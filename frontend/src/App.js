import React, { useState, useEffect } from 'react';
import NoteList from './components/NoteList';
import NoteForm from './components/NoteForm';
import { getNotes, createNote, deleteNote, getNoteById, updateNote } from './services/noteService';
import './App.css';

function App() {
  const [notes, setNotes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedNote, setSelectedNote] = useState(null);
  const [viewMode, setViewMode] = useState(false);
  const [editMode, setEditMode] = useState(false);

  useEffect(() => {
    fetchNotes();
  }, []);

  const fetchNotes = async () => {
    try {
      setLoading(true);
      const data = await getNotes();
      setNotes(data);
      setError(null);
    } catch (err) {
      setError('Failed to fetch notes');
      console.error('Error fetching notes:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleCreateNote = async (noteData) => {
    try {
      const newNote = await createNote(noteData);
      setNotes([...notes, newNote]);
      setError(null);
    } catch (err) {
      setError('Failed to create note');
      console.error('Error creating note:', err);
    }
  };

  const handleDeleteNote = async (id) => {
    try {
      await deleteNote(id);
      setNotes(notes.filter(note => note.id !== id));
      setError(null);
    } catch (err) {
      setError('Failed to delete note');
      console.error('Error deleting note:', err);
    }
  };

  const handleViewNote = async (id) => {
    try {
      setLoading(true);
      const note = await getNoteById(id);
      setSelectedNote(note);
      setViewMode(true);
      setEditMode(false);
      setError(null);
    } catch (err) {
      setError('Failed to fetch note details');
      console.error('Error fetching note:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleEditNote = async (id) => {
    try {
      setLoading(true);
      const note = await getNoteById(id);
      setSelectedNote(note);
      setEditMode(true);
      setViewMode(false);
      setError(null);
    } catch (err) {
      setError('Failed to fetch note for editing');
      console.error('Error fetching note:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleUpdateNote = async (noteData) => {
    try {
      const updated = await updateNote(noteData.id, { title: noteData.title, content: noteData.content });
      setNotes(notes.map(n => n.id === updated.id ? updated : n));
      setEditMode(false);
      setSelectedNote(null);
      setError(null);
    } catch (err) {
      setError('Failed to update note');
      console.error('Error updating note:', err);
    }
  };

  const handleCancel = () => {
    setViewMode(false);
    setEditMode(false);
    setSelectedNote(null);
  };

  if (loading) {
    return <div className="app">Loading...</div>;
  }

  return (
    <div className="app">
      <header className="app-header">
        <h1>📝 Simple Notes Maker</h1>
      </header>
      
      <main className="app-main">
        {error && <div className="error-message">{error}</div>}
        
        {editMode ? (
          <NoteForm
            initialNote={selectedNote}
            onSubmit={handleUpdateNote}
            onCancel={handleCancel}
            mode="edit"
          />
        ) : (
          <NoteForm onSubmit={handleCreateNote} mode="create" />
        )}
        
        {viewMode && selectedNote && (
          <div className="note-view-modal" style={{ background: 'white', borderRadius: 12, boxShadow: '0 8px 32px rgba(0,0,0,0.1)', padding: 24, margin: '24px 0' }}>
            <h2>Note Details</h2>
            <h3>{selectedNote.title}</h3>
            <p>{selectedNote.content}</p>
            <div style={{ color: '#666', fontSize: '0.95em', marginTop: 12 }}>
              <div>Created: {new Date(selectedNote.createdAt).toLocaleString()}</div>
              {selectedNote.updatedAt !== selectedNote.createdAt && (
                <div>Updated: {new Date(selectedNote.updatedAt).toLocaleString()}</div>
              )}
            </div>
            <button onClick={handleCancel} className="submit-btn" style={{ marginTop: 16 }}>Close</button>
          </div>
        )}
        
        <NoteList 
          notes={notes} 
          onDeleteNote={handleDeleteNote}
          onViewNote={handleViewNote}
          onEditNote={handleEditNote}
        />
      </main>
    </div>
  );
}

export default App; 