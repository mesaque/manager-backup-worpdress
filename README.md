# manager-backup-worpdress

## How it work?

Example Environment:
wordpress domain: example.com
wordpress root path: /var/www/example.com
wordpress wp-config.php:  /var/www/wp-config.php
your backup public folder:  /var/www/example.com/my-magic-backup

- [--backup-database]Database Backup
{command} --backup-database {path-wp-config-file} {root-backup-dir}
EX:
```sh
/var/www/manager-backup-worpdress/manager.sh --backup-database /var/www/wp-config.php /var/www/example.com/my-magic-backup
```

- [--backup-files]Files Backup(Withou Uploads)
{command} --backup-files {root-wordpress-path} {root-backup-dir}
```sh
/var/www/manager-backup-worpdress/manager.sh --backup-files /var/www/example.com /var/www/example.com/my-magic-backup
```

- [--backup-all]Full Files Backup
{command} --backup-all {root-wordpress-path} {root-backup-dir} {path-wp-config-file}
```sh
/var/www/manager-backup-worpdress/manager.sh --backup-all /var/www/example.com /var/www/example.com/my-magic-backup /var/www/wp-config.php
```

- [--auto-clean] Auto Clean for old backups
{command} --auto-clean {root-backup-dir} {number-days-old-to-delete}
```sh
/var/www/manager-backup-worpdress/manager.sh /var/www/example.com/my-magic-backup 2
```

### Authenc Default:
```sh
user: administrator
password: kS6BQWNbg9ZhULM5
```
