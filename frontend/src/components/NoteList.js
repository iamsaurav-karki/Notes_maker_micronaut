import React from 'react';
import './NoteList.css';

function NoteList({ notes, onDeleteNote }) {
  const handleDelete = async (id) => {
    if (window.confirm('Are you sure you want to delete this note?')) {
      await onDeleteNote(id);
    }
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString();
  };

  if (notes.length === 0) {
    return (
      <div className="note-list-container">
        <h2>Your Notes</h2>
        <div className="empty-state">
          <p>No notes yet. Create your first note above!</p>
        </div>
      </div>
    );
  }

  return (
    <div className="note-list-container">
      <h2>Your Notes ({notes.length})</h2>
      <div className="notes-grid">
        {notes.map((note) => (
          <div key={note.id} className="note-card">
            <div className="note-header">
              <h3 className="note-title">{note.title}</h3>
              <button
                onClick={() => handleDelete(note.id)}
                className="delete-btn"
                title="Delete note"
              >
                🗑️
              </button>
            </div>
            <p className="note-content">{note.content}</p>
            <div className="note-footer">
              <small>Created: {formatDate(note.createdAt)}</small>
              {note.updatedAt !== note.createdAt && (
                <small>Updated: {formatDate(note.updatedAt)}</small>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default NoteList; 