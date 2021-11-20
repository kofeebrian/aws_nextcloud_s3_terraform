#!/bin/bash

# MariaDB config
cat << EOF > nextcloud/config/autoconfig.php
<?php
\$AUTOCONFIG = array(
  "dbtype"        => "mysql",
  "dbname"        => "${database_name}",
  "dbuser"        => "${database_user}",
  "dbpass"        => "${database_pass}",
  "dbhost"        => "10.0.2.51",
  "dbtableprefix" => "",
  "adminlogin"    => "${admin_user}",
  "adminpass"     => "${admin_pass}",
  "directory"     => "${data_dir}",
);
EOF

touch 3.txt