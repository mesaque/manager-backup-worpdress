# Auto Manager Backups for WordPress

## What is this:

## How it work:

Requirements:

* mysqldump
* tar


Example Environment:

1. wordpress domain: example.com
2. wordpress root path: /var/www/example.com
3. wordpress wp-config.php:  /var/www/wp-config.php
4. your backup public folder:  /var/www/example.com/my-magic-backup

## How to use:
--
- **[--backup-database]Database Backup**

{command} --backup-database {path-wp-config-file} {root-backup-dir}
```sh
/var/www/manager-backup-worpdress/manager.sh \
--backup-database \
/var/www/wp-config.php \
/var/www/example.com/my-magic-backup
```

- **[--backup-files]Files Backup(Without Uploads)**

{command} --backup-files {root-wordpress-path} {root-backup-dir}
```sh
/var/www/manager-backup-worpdress/manager.sh \
--backup-files \
/var/www/example.com \
/var/www/example.com/my-magic-backup
```

- **[--backup-all]Full Files Backup**

{command} --backup-all {root-wordpress-path} {root-backup-dir} {path-wp-config-file}
```sh
/var/www/manager-backup-worpdress/manager.sh \
--backup-all \
/var/www/example.com \
/var/www/example.com/my-magic-backup \
/var/www/wp-config.php
```

- **[--auto-clean] Auto Clean for old backups**

{command} --auto-clean {root-backup-dir} {number-days-old-to-delete}
```sh
/var/www/manager-backup-worpdress/manager.sh \
--auto-clean \
/var/www/example.com/my-magic-backup \
2
```

### Authentication Default:
```sh
user: administrator
password: kS6BQWNbg9ZhULM5
```

## Cron job
```sh
#auto clean
0 0 * * * /var/www/manager-backup-worpdress/manager.sh --auto-clean /var/www/example.com/my-magic-backup 2
# database backup
10 0 * * * /var/www/manager-backup-worpdress/manager.sh --backup-database /var/www/wp-config.php /var/www/example.com/my-magic-backup
#files backups(without uploads)
0 1 * * * /var/www/manager-backup-worpdress/manager.sh --backup-files /var/www/example.com /var/www/example.com/my-magic-backup
#Full backup
0 2 * * * /var/www/manager-backup-worpdress/manager.sh --backup-all /var/www/example.com /var/www/example.com/my-magic-backup /var/www/wp-config.php
```
