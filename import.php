<?php

/***************************/
/* configuration constants */
/***************************/

date_default_timezone_set('Europe/Berlin');

// redefine include path to add FreeBSD share path
set_include_path('.:/usr/local/share/pear:/usr/local/share');

/****************/
/* define DDDBL */
/****************/

require_once 'dddbl/dddbl.php';

\DDDBL\storeDBFileContent(__DIR__ . '/config/database.ddef');
\DDDBL\loadQueryDefinitionsInDir(__DIR__ . '/database/sql/', '*.sql');

if(!\DDDBL\isConnected())
  \DDDBL\connect();

if(!\DDDBL\isConnected())
  throw new \Exception ("could not connect to database");
