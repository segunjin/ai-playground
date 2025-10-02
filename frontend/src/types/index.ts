export interface Application {
  id: number;
  name: string;
  description: string;
  url: string;
  coverImage: string;
  creator: string;
  likeCount: number;
  commentCount: number;
  createdAt: string;
  updatedAt: string;
}

export interface Comment {
  id: number;
  applicationId: number;
  author: string;
  content: string;
  createdAt: string;
  updatedAt: string;
}

export interface ApplicationRequest {
  name: string;
  description: string;
  url: string;
  coverImage: string;
  creator: string;
}

export interface CommentRequest {
  author: string;
  content: string;
}
