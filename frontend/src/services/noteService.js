import axios from 'axios';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const getNotes = async () => {
  try {
    const response = await api.get('/notes');
    return response.data;
  } catch (error) {
    console.error('Error fetching notes:', error);
    throw error;
  }
};

export const getNoteById = async (id) => {
  try {
    const response = await api.get(`/notes/${id}`);
    return response.data;
  } catch (error) {
    console.error('Error fetching note:', error);
    throw error;
  }
};

export const createNote = async (noteData) => {
  try {
    const response = await api.post('/notes', noteData);
    return response.data;
  } catch (error) {
    console.error('Error creating note:', error);
    throw error;
  }
};

export const updateNote = async (id, noteData) => {
  try {
    const response = await api.put(`/notes/${id}`, noteData);
    return response.data;
  } catch (error) {
    console.error('Error updating note:', error);
    throw error;
  }
};

export const deleteNote = async (id) => {
  try {
    await api.delete(`/notes/${id}`);
  } catch (error) {
    console.error('Error deleting note:', error);
    throw error;
  }
}; 
