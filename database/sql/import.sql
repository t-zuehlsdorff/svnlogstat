[GET-REPO-FOR-UPDATE]
QUERY = "SELECT repo_id,
                repo_path,
                last_rev,
                max_logs_fetched
         FROM   repositories
         LIMIT  1
         FOR UPDATE SKIP LOCKED"
HANDLER = SINGLE
