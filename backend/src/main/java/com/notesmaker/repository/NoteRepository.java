package com.notesmaker.repository;

import com.notesmaker.model.Note;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface NoteRepository {
    List<Note> findAll();
    Optional<Note> findById(UUID id);
    Note save(Note note);
    void deleteById(UUID id);
    Note update(Note note);
} 