import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { applicationApi } from '../api/api';
import { Application } from '../types';
import ApplicationCard from '../components/ApplicationCard';
import './HomePage.css';

const categories = ['전체', '패션/미용', '인문/과학', '외국어', '운동/취미', '만화/애니', '팬카페', '동향/트렌드', '경제/도서'];

const HomePage: React.FC = () => {
  const [applications, setApplications] = useState<Application[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedCategory, setSelectedCategory] = useState('전체');
  const navigate = useNavigate();

  useEffect(() => {
    const controller = new AbortController();

    const loadApplications = async () => {
      try {
        const response = await applicationApi.getAll(controller.signal);
        setApplications(response.data);
      } catch (error) {
        if (error instanceof Error && error.name !== 'CanceledError') {
          console.error('Failed to load applications:', error);
        }
      } finally {
        setLoading(false);
      }
    };

    loadApplications();

    return () => {
      controller.abort();
    };
  }, []);

  const loadApplications = async () => {
    try {
      const response = await applicationApi.getAll();
      setApplications(response.data);
    } catch (error) {
      console.error('Failed to load applications:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleCardClick = (id: number) => {
    navigate(`/app/${id}`);
  };

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  return (
    <div className="home-page">
      <header className="home-header">
        <div className="header-content">
          <h1>AI 어플리케이션 큐레이션</h1>
          <p className="header-subtitle">AI로 만든 유용한 어플리케이션을 찾아보세요</p>
        </div>
        <button onClick={() => navigate('/register')} className="btn-register">
          + 앱 등록
        </button>
      </header>

      <div className="category-tabs">
        {categories.map((category) => (
          <button
            key={category}
            className={`category-tab ${selectedCategory === category ? 'active' : ''}`}
            onClick={() => setSelectedCategory(category)}
          >
            {category}
          </button>
        ))}
      </div>

      <div className="app-list">
        {applications.map((app) => (
          <ApplicationCard
            key={app.id}
            application={app}
            onClick={() => handleCardClick(app.id)}
          />
        ))}
      </div>

      {applications.length === 0 && (
        <div className="empty-state">
          <p>아직 등록된 어플리케이션이 없습니다.</p>
          <p>첫 번째 앱을 등록해보세요!</p>
        </div>
      )}
    </div>
  );
};

export default HomePage;
