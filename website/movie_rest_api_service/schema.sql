-- CineMantra REST API SQLite3 Schema
CREATE TABLE IF NOT EXISTS users (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    username   TEXT NOT NULL UNIQUE,
    email      TEXT NOT NULL UNIQUE,
    password   TEXT NOT NULL,
    created_at TEXT DEFAULT (datetime('now'))
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
    created_at TEXT DEFAULT (datetime('now'))
);

INSERT OR IGNORE INTO users (id, username, email, password) VALUES
    (1, 'admin',  'admin@cinemantra.dev',  'admin_secret_123'),
    (2, 'raghav', 'raghav@cinemantra.dev', 'raghav_secret_456');

INSERT OR IGNORE INTO movies (id, title, genre, release_year, director, synopsis) VALUES
    (1, 'Inception',                'Sci-Fi / Thriller', 2010, 'Christopher Nolan', 'A thief who steals corporate secrets through dream-sharing technology.'),
    (2, 'The Dark Knight',          'Action / Crime',    2008, 'Christopher Nolan', 'Batman raises the stakes in his war on crime against the Joker.'),
    (3, 'Interstellar',             'Sci-Fi / Adventure', 2014, 'Christopher Nolan', 'Explorers travel through a wormhole in search of a new home for humanity.'),
    (4, 'Parasite',                 'Thriller / Drama',  2019, 'Bong Joon-ho',      'Greed and class discrimination threaten the relationship between two families.'),
    (5, 'The Shawshank Redemption', 'Drama',             1994, 'Frank Darabont',    'Two convicts form an enduring bond, seeking solace and eventual redemption.');

INSERT OR IGNORE INTO reviews (id, movie_id, user_id, rating, body) VALUES
    (1, 1, 2, 9.4, 'Mind-bending cinematic masterpiece.'),
    (2, 2, 2, 9.9, 'Heath Ledger delivers an iconic performance.'),
    (3, 3, 1, 9.1, 'Breathtaking journey across spacetime.'),
    (4, 4, 1, 9.6, 'Remarkable social commentary and dark humor.'),
    (5, 5, 2, 9.8, 'An enduring testament to hope and friendship.');
