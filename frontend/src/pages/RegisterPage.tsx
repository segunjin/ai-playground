import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { applicationApi } from '../api/api';
import { ApplicationRequest } from '../types';
import './RegisterPage.css';

const RegisterPage: React.FC = () => {
  const navigate = useNavigate();
  const [form, setForm] = useState<ApplicationRequest>({
    name: '',
    description: '',
    url: '',
    coverImage: '',
    creator: '',
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await applicationApi.create(form);
      navigate('/');
    } catch (error) {
      console.error('Failed to create application:', error);
      alert('Failed to register application. Please try again.');
    }
  };

  return (
    <div className="register-page">
      <button onClick={() => navigate('/')} className="btn-back">← Back</button>

      <div className="register-container">
        <h1>Register New Application</h1>

        <form onSubmit={handleSubmit} className="register-form">
          <div className="form-group">
            <label>Application Name *</label>
            <input
              type="text"
              value={form.name}
              onChange={(e) => setForm({ ...form, name: e.target.value })}
              required
            />
          </div>

          <div className="form-group">
            <label>Description</label>
            <textarea
              value={form.description}
              onChange={(e) => setForm({ ...form, description: e.target.value })}
              rows={4}
            />
          </div>

          <div className="form-group">
            <label>URL *</label>
            <input
              type="url"
              value={form.url}
              onChange={(e) => setForm({ ...form, url: e.target.value })}
              placeholder="https://example.com"
              required
            />
          </div>

          <div className="form-group">
            <label>Cover Image URL</label>
            <input
              type="url"
              value={form.coverImage}
              onChange={(e) => setForm({ ...form, coverImage: e.target.value })}
              placeholder="https://example.com/image.jpg"
            />
          </div>

          <div className="form-group">
            <label>Creator Name *</label>
            <input
              type="text"
              value={form.creator}
              onChange={(e) => setForm({ ...form, creator: e.target.value })}
              required
            />
          </div>

          <button type="submit" className="btn-submit">Register Application</button>
        </form>
      </div>
    </div>
  );
};

export default RegisterPage;
