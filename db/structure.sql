CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "todos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "decription" text);
INSERT INTO "schema_migrations" (version) VALUES
('20170315144305');


