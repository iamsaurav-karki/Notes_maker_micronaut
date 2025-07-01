import React, { useState, useEffect } from 'react';
import './NoteForm.css';

function NoteForm({ initialNote = null, onSubmit, onCancel, mode = 'create' }) {
  const [title, setTitle] = useState(initialNote ? initialNote.title : '');
  const [content, setContent] = useState(initialNote ? initialNote.content : '');
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    if (initialNote) {
      setTitle(initialNote.title || '');
      setContent(initialNote.content || '');
    }
  }, [initialNote]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!title.trim() || !content.trim()) {
      return;
    }
    setIsSubmitting(true);
    try {
      await onSubmit({
        id: initialNote ? initialNote.id : undefined,
        title: title.trim(),
        content: content.trim(),
      });
      if (!initialNote) {
        setTitle('');
        setContent('');
      }
    } catch (error) {
      console.error(`${mode === 'edit' ? 'Error updating' : 'Error creating'} note:`, error);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="note-form-container">
      <h2>{mode === 'edit' ? 'Edit Note' : 'Create New Note'}</h2>
      <form onSubmit={handleSubmit} className="note-form">
        <div className="form-group">
          <label htmlFor="title">Title:</label>
          <input
            type="text"
            id="title"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="Enter note title..."
            required
            disabled={isSubmitting}
          />
        </div>
        <div className="form-group">
          <label htmlFor="content">Content:</label>
          <textarea
            id="content"
            value={content}
            onChange={(e) => setContent(e.target.value)}
            placeholder="Enter note content..."
            rows="4"
            required
            disabled={isSubmitting}
          />
        </div>
        <div style={{ display: 'flex', gap: '10px' }}>
          <button
            type="submit"
            disabled={isSubmitting || !title.trim() || !content.trim()}
            className="submit-btn"
          >
            {isSubmitting ? (mode === 'edit' ? 'Saving...' : 'Creating...') : (mode === 'edit' ? 'Save Changes' : 'Create Note')}
          </button>
          {mode === 'edit' && (
            <button type="button" onClick={onCancel} className="submit-btn" style={{ background: '#eee', color: '#333' }} disabled={isSubmitting}>
              Cancel
            </button>
          )}
        </div>
      </form>
    </div>
  );
}

export default NoteForm; 