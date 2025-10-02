import React from 'react';
import { Application } from '../types';
import './ApplicationCard.css';

interface ApplicationCardProps {
  application: Application;
  onClick: () => void;
}

const formatNumber = (num: number): string => {
  if (num >= 1000000) {
    return (num / 1000000).toFixed(1) + 'M';
  }
  if (num >= 1000) {
    return (num / 1000).toFixed(1) + 'K';
  }
  return num.toString();
};

const ApplicationCard: React.FC<ApplicationCardProps> = ({ application, onClick }) => {
  return (
    <div className="app-card" onClick={onClick}>
      <div className="app-card-layout">
        <div className="app-card-image">
          {application.coverImage ? (
            <img src={application.coverImage} alt={application.name} />
          ) : (
            <div className="app-card-placeholder">
              <span>📱</span>
            </div>
          )}
        </div>
        <div className="app-card-content">
          <h3 className="app-card-title">{application.name}</h3>
          <p className="app-card-creator">{application.creator}</p>
          <p className="app-card-description">{application.description}</p>
          <div className="app-card-stats">
            <span className="stat-item">
              <span className="stat-icon">👥</span>
              <span className="stat-value">{formatNumber(application.likeCount * 50)}</span>
            </span>
            <span className="stat-divider">·</span>
            <span className="stat-item">
              <span className="stat-icon">👍</span>
              <span className="stat-value">{formatNumber(application.likeCount)}</span>
            </span>
            <span className="stat-divider">·</span>
            <span className="stat-item">
              <span className="stat-icon">💬</span>
              <span className="stat-value">{formatNumber(application.commentCount)}</span>
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ApplicationCard;
