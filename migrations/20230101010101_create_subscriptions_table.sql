-- migrations/20230101010101_create_subscriptions_table.sql
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY,
    email TEXT NOT NULL,
    name TEXT NOT NULL,
    subscribed_at TIMESTAMP WITH TIME ZONE NOT NULL
);

