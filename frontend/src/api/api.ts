import axios from 'axios';
import { Application, Comment, ApplicationRequest, CommentRequest } from '../types';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const applicationApi = {
  getAll: (signal?: AbortSignal) => api.get<Application[]>('/applications', { signal }),
  getById: (id: number, signal?: AbortSignal) => api.get<Application>(`/applications/${id}`, { signal }),
  create: (data: ApplicationRequest) => api.post<Application>('/applications', data),
  update: (id: number, data: ApplicationRequest) => api.put<Application>(`/applications/${id}`, data),
  delete: (id: number) => api.delete(`/applications/${id}`),
  like: (id: number) => api.post<Application>(`/applications/${id}/like`),
  unlike: (id: number) => api.post<Application>(`/applications/${id}/unlike`),
};

export const commentApi = {
  getByApplicationId: (applicationId: number) =>
    api.get<Comment[]>(`/applications/${applicationId}/comments`),
  create: (applicationId: number, data: CommentRequest) =>
    api.post<Comment>(`/applications/${applicationId}/comments`, data),
  update: (commentId: number, data: CommentRequest) =>
    api.put<Comment>(`/applications/${commentId}/comments`, data),
  delete: (commentId: number) =>
    api.delete(`/applications/${commentId}/comments`),
};
