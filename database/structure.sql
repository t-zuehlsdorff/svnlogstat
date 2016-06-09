START TRANSACTION;

-- store various repo-urls (repo_path), the last fetched revision (last_rev)
-- and how many log entries should be fetched on an update (max_logs_fetched)
CREATE TABLE repositories (
  repo_id           SERIAL NOT NULL PRIMARY KEY,
  repo_path         TEXT   NOT NULL UNIQUE,
  last_rev          BIGINT CHECK (last_rev IS NULL OR last_rev >= 1),
  max_logs_fetched  INT    NOT NULL DEFAULT 10000
);

-- since we want a statistic about FreeBSD
-- we add its repositories
-- feel free to add anything else later ;)
INSERT INTO repositories (repo_path)
VALUES ('svn://svn.freebsd.org/src'),
       ('svn://svn.freebsd.org/doc'),
       ('svn://svn.freebsd.org/ports');

-- store for basic revision informations
-- rev_date is the timestamp of the commit
-- its a little bit bad named by subversion
CREATE TABLE revisions (
  repo_id  INT         NOT NULL REFERENCES repositories (repo_id) ON UPDATE CASCADE ON DELETE CASCADE,
  revision BIGINT      NOT NULL,
  author   TEXT        NOT NULL,
  rev_date TIMESTAMPTZ NOT NULL,
  log      TEXT        NOT NULL,
  PRIMARY KEY (repo_id, revision)
);

-- store modified pathes, its actions on it and if
-- the commit contains text and/or property modifications
CREATE TABLE revisions_paths (
  repo_id   INT         NOT NULL,
  revision  BIGINT      NOT NULL,
  action    TEXT        NOT NULL,
  kind      TEXT        NOT NULL,
  prop_mods BOOLEAN     NOT NULL,
  text_mods BOOLEAN     NOT NULL,
  FOREIGN KEY (repo_id, revision) REFERENCES revisions (repo_id, revision) ON UPDATE CASCADE ON DELETE CASCADE
);

COMMIT;
