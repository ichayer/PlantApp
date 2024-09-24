CREATE TABLE plants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description VARCHAR(500),
    water_frequency_days SMALLINT NOT NULL,
    image TEXT
);
