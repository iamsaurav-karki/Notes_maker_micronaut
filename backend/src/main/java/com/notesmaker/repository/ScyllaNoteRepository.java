package com.notesmaker.repository;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.*;
import com.notesmaker.model.Note;
import io.micronaut.context.annotation.Value;
import jakarta.inject.Singleton;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Singleton
public class ScyllaNoteRepository implements NoteRepository {
    private static final Logger logger = LoggerFactory.getLogger(ScyllaNoteRepository.class);
    
    private final CqlSession session;
    private final String keyspace;
    
    private static final String CREATE_TABLE_QUERY = """
        CREATE TABLE IF NOT EXISTS notes (
            id uuid PRIMARY KEY,
            title text,
            content text,
            created_at timestamp,
            updated_at timestamp
        )
    """;
    
    private static final String INSERT_QUERY = 
        "INSERT INTO notes (id, title, content, created_at, updated_at) VALUES (?, ?, ?, ?, ?)";
    
    private static final String SELECT_ALL_QUERY = "SELECT * FROM notes";
    
    private static final String SELECT_BY_ID_QUERY = "SELECT * FROM notes WHERE id = ?";
    
    private static final String UPDATE_QUERY = 
        "UPDATE notes SET title = ?, content = ?, updated_at = ? WHERE id = ?";
    
    private static final String DELETE_QUERY = "DELETE FROM notes WHERE id = ?";

    public ScyllaNoteRepository(CqlSession session, @Value("${cassandra.default.keyspace}") String keyspace) {
        this.session = session;
        this.keyspace = keyspace;
        initializeTable();
    }

    private void initializeTable() {
        try {
            session.execute(CREATE_TABLE_QUERY);
            logger.info("Notes table initialized successfully");
        } catch (Exception e) {
            logger.error("Error initializing notes table", e);
            throw new RuntimeException("Failed to initialize database table", e);
        }
    }

    @Override
    public List<Note> findAll() {
        try {
            ResultSet resultSet = session.execute(SELECT_ALL_QUERY);
            return resultSet.all().stream()
                    .map(this::mapRowToNote)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error fetching all notes", e);
            throw new RuntimeException("Failed to fetch notes", e);
        }
    }

    @Override
    public Optional<Note> findById(UUID id) {
        try {
            PreparedStatement preparedStatement = session.prepare(SELECT_BY_ID_QUERY);
            BoundStatement boundStatement = preparedStatement.bind(id);
            ResultSet resultSet = session.execute(boundStatement);
            
            Row row = resultSet.one();
            return row != null ? Optional.of(mapRowToNote(row)) : Optional.empty();
        } catch (Exception e) {
            logger.error("Error fetching note by id: {}", id, e);
            throw new RuntimeException("Failed to fetch note", e);
        }
    }

    @Override
    public Note save(Note note) {
        try {
            PreparedStatement preparedStatement = session.prepare(INSERT_QUERY);
            BoundStatement boundStatement = preparedStatement.bind(
                    note.getId(),
                    note.getTitle(),
                    note.getContent(),
                    note.getCreatedAt(),
                    note.getUpdatedAt()
            );
            session.execute(boundStatement);
            return note;
        } catch (Exception e) {
            logger.error("Error saving note", e);
            throw new RuntimeException("Failed to save note", e);
        }
    }

    @Override
    public void deleteById(UUID id) {
        try {
            PreparedStatement preparedStatement = session.prepare(DELETE_QUERY);
            BoundStatement boundStatement = preparedStatement.bind(id);
            session.execute(boundStatement);
        } catch (Exception e) {
            logger.error("Error deleting note with id: {}", id, e);
            throw new RuntimeException("Failed to delete note", e);
        }
    }

    @Override
    public Note update(Note note) {
        try {
            note.setUpdatedAt(LocalDateTime.now());
            PreparedStatement preparedStatement = session.prepare(UPDATE_QUERY);
            BoundStatement boundStatement = preparedStatement.bind(
                    note.getTitle(),
                    note.getContent(),
                    note.getUpdatedAt(),
                    note.getId()
            );
            session.execute(boundStatement);
            return note;
        } catch (Exception e) {
            logger.error("Error updating note", e);
            throw new RuntimeException("Failed to update note", e);
        }
    }

    private Note mapRowToNote(Row row) {
        return new Note(
                row.getUuid("id"),
                row.getString("title"),
                row.getString("content"),
                row.getInstant("created_at").atZone(ZoneId.systemDefault()).toLocalDateTime(),
                row.getInstant("updated_at").atZone(ZoneId.systemDefault()).toLocalDateTime()
        );
    }
} 