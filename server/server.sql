CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    c_level INTEGER DEFAULT 2 CHECK (c_level IN (1, 2)),
    phone TEXT NOT NULL,
    photo TEXT -- can be NULL by default
);
