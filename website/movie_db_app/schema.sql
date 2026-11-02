-- CineMantra SQLite3 Database Schema
-- Shared between movie_db_app, movie_rest_api_service, and movie_gql_service

CREATE TABLE IF NOT EXISTS users (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    username   TEXT    NOT NULL UNIQUE,
    email      TEXT    NOT NULL UNIQUE,
    password   TEXT    NOT NULL,
    created_at TEXT    DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS movies (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    title        TEXT    NOT NULL,
    genre        TEXT    NOT NULL,
    release_year INTEGER NOT NULL,
    director     TEXT    NOT NULL,
    synopsis     TEXT,
    poster_url   TEXT
);

CREATE TABLE IF NOT EXISTS reviews (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id   INTEGER NOT NULL REFERENCES movies(id),
    user_id    INTEGER NOT NULL REFERENCES users(id),
    rating     REAL    NOT NULL CHECK(rating >= 1.0 AND rating <= 10.0),
    body       TEXT,
    created_at TEXT    DEFAULT (datetime('now'))
);

-- Seed Data
INSERT OR IGNORE INTO users (id, username, email, password) VALUES
    (1, 'admin',  'admin@cinemantra.dev',  'admin_secret_123'),
    (2, 'raghav', 'raghav@cinemantra.dev', 'raghav_secret_456');

INSERT OR IGNORE INTO movies (id, title, genre, release_year, director, synopsis) VALUES
    (1, 'Inception',                'Sci-Fi / Thriller', 2010, 'Christopher Nolan', 'A thief who steals corporate secrets through the use of dream-sharing technology.'),
    (2, 'The Dark Knight',          'Action / Crime',    2008, 'Christopher Nolan', 'When the menace known as the Joker wreaks havoc, Batman must accept one of the greatest psychological tests.'),
    (3, 'Interstellar',             'Sci-Fi / Adventure', 2014, 'Christopher Nolan', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity survival.'),
    (4, 'Parasite',                 'Thriller / Drama',  2019, 'Bong Joon-ho',      'Greed and class discrimination threaten the newly formed symbiotic relationship between two families.'),
    (5, 'The Shawshank Redemption', 'Drama',             1994, 'Frank Darabont',    'Over the course of several years, two convicts form a friendship, seeking solace and eventual redemption through basic compassion.');

INSERT OR IGNORE INTO reviews (id, movie_id, user_id, rating, body) VALUES
    (1, 1, 2, 9.4, 'Mind-bending cinematic masterpiece with unparalleled sound and visual effects.'),
    (2, 2, 2, 9.9, 'Heath Ledger delivers one of the greatest antagonist performances in film history.'),
    (3, 3, 1, 9.1, 'A breathtaking journey across spacetime with an emotional father-daughter core.'),
    (4, 4, 1, 9.6, 'Remarkable social commentary paired with pitch-perfect dark comedy and tension.'),
    (5, 5, 2, 9.8, 'An enduring testament to hope and human resilience. Outstanding storytelling.');
