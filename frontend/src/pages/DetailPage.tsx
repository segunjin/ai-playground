import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { applicationApi, commentApi } from '../api/api';
import { Application, Comment, CommentRequest } from '../types';
import './DetailPage.css';

const DetailPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [application, setApplication] = useState<Application | null>(null);
  const [comments, setComments] = useState<Comment[]>([]);
  const [loading, setLoading] = useState(true);
  const [commentForm, setCommentForm] = useState<CommentRequest>({
    author: '',
    content: '',
  });

  useEffect(() => {
    const controller = new AbortController();

    const loadData = async (appId: number) => {
      try {
        const [appResponse, commentsResponse] = await Promise.all([
          applicationApi.getById(appId, controller.signal),
          commentApi.getByApplicationId(appId),
        ]);
        setApplication(appResponse.data);
        setComments(commentsResponse.data);
      } catch (error) {
        if (error instanceof Error && error.name !== 'CanceledError') {
          console.error('Failed to load data:', error);
        }
      } finally {
        setLoading(false);
      }
    };

    if (id) {
      loadData(parseInt(id));
    }

    return () => {
      controller.abort();
    };
  }, [id]);

  const loadData = async (appId: number) => {
    try {
      const [appResponse, commentsResponse] = await Promise.all([
        applicationApi.getById(appId),
        commentApi.getByApplicationId(appId),
      ]);
      setApplication(appResponse.data);
      setComments(commentsResponse.data);
    } catch (error) {
      console.error('Failed to load data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleLike = async () => {
    if (!application) return;
    try {
      const response = await applicationApi.like(application.id);
      setApplication(response.data);
    } catch (error) {
      console.error('Failed to like:', error);
    }
  };

  const handleCommentSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!application || !commentForm.author || !commentForm.content) return;

    try {
      await commentApi.create(application.id, commentForm);
      setCommentForm({ author: '', content: '' });
      loadData(application.id);
    } catch (error) {
      console.error('Failed to submit comment:', error);
    }
  };

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  if (!application) {
    return <div className="error">Application not found</div>;
  }

  return (
    <div className="detail-page">
      <button onClick={() => navigate('/')} className="btn-back">← Back</button>

      <div className="app-detail">
        <div className="app-detail-header">
          {application.coverImage && (
            <img src={application.coverImage} alt={application.name} />
          )}
          <h1>{application.name}</h1>
          <p className="creator">By {application.creator}</p>
        </div>

        <div className="app-detail-content">
          <p>{application.description}</p>
          <a href={application.url} target="_blank" rel="noopener noreferrer" className="app-link">
            Visit Application →
          </a>
        </div>

        <div className="app-actions">
          <button onClick={handleLike} className="btn-like">
            👍 Like ({application.likeCount})
          </button>
        </div>

        <div className="comments-section">
          <h2>Comments ({comments.length})</h2>

          <form onSubmit={handleCommentSubmit} className="comment-form">
            <input
              type="text"
              placeholder="Your name"
              value={commentForm.author}
              onChange={(e) => setCommentForm({ ...commentForm, author: e.target.value })}
              required
            />
            <textarea
              placeholder="Write a comment..."
              value={commentForm.content}
              onChange={(e) => setCommentForm({ ...commentForm, content: e.target.value })}
              required
            />
            <button type="submit" className="btn-submit">Submit Comment</button>
          </form>

          <div className="comments-list">
            {comments.map((comment) => (
              <div key={comment.id} className="comment">
                <div className="comment-header">
                  <strong>{comment.author}</strong>
                  <span className="comment-date">
                    {new Date(comment.createdAt).toLocaleDateString()}
                  </span>
                </div>
                <p>{comment.content}</p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default DetailPage;
