
#!/bin/bash

basename=$(basename $0);
basedir=$( which $0 |  sed "s/\/$basename//g");

current_file_name=$(date +%F_%Hh%M)

#create our worker dir
[ ! -d $basedir/logs ] && mkdir -p $basedir/logs
[ ! -d $basedir/tmp ] && mkdir -p $basedir/tmp

backupAll() {
        echo 'backall';
}
backupDATABASE() {
  db=$(cat $2 | grep -i 'db_name' | grep "^[^/#;]" | sed "s/.* '//g" | sed "s/'.*//g")
  user=$(cat $2 | grep -i 'db_user' | grep "^[^/#;]" |sed "s/.* '//g" | sed "s/'.*//g")
  password=$(cat $2 | grep -i 'db_password' | grep "^[^/#;]" | sed "s/.* '//g" | sed "s/'.*//g")
  host=$(cat $2 | grep -i 'db_host' | grep "^[^/#;]" | sed "s/.* '//g" | sed "s/'.*//g")
  
  ERROR=$(mysql -u${user} -p${password} -h${host} ${db} -e 'exit' 2>&1 > /dev/null )
  echo $ERROR | grep -i "ERROR" | tee -a $basedir/logs/status.log
  echo $ERROR | grep -i "error" &> /dev/null
  [ $? == 0 ] && {
  	printf "[$(date) - Backup Database] Failled\n" | tee -a $basedir/logs/status.log && exit 1
  	exit 1;
  }
  mysqldump -u${user} -p${password} -h${host} ${db} > $3/${current_file_name}.sql;
  printf "[$(date) - Backup Database] Successfully done\n" | tee -a $basedir/logs/status.log && exit 0
  exit;
}
backupFILES() {
	echo 'files'
}
backupAUTOCLEAN() {
	echo 'autoclean';
}
validateARGS() {
  case "$1" in
    --backup-all)
	[ ! "$2" ] &&  printf "[$(date)] missing argument for root website folder\n" | tee -a $basedir/logs/status.log && exit 1
        [ ! -d $2 ] && printf "[$(date)] not a valid website path\n" | tee -a $basedir/logs/status.log && exit 1
        [ ! "$3" ] &&  printf "[$(date)] missing argument for root backup path\n" | tee -a $basedir/logs/status.log  && exit 1
	[ ! "$4" ] &&  printf "[$(date)] missing argument for wp-config.php\n" | tee -a $basedir/logs/status.log  && exit 1
    ;;
   --backup-files)
	[ ! "$2" ] &&  printf "[$(date)] missing argument for root website folder\n" | tee -a $basedir/logs/status.log && exit 1
        [ ! -d $2 ] && printf "[$(date)] not a valid website path\n" | tee -a $basedir/logs/status.log && exit 1
        [ ! "$3" ] &&  printf "[$(date)] missing argument for root backup folder\n" | tee -a $basedir/logs/status.log  && exit 1
    ;;
    --backup-database)
	[ ! "$2" ] &&  printf "[$(date)] missing argument for wp-config.php\n" | tee -a $basedir/logs/status.log  && exit 1
        [ ! "$3" ] &&  printf "[$(date)] missing argument for root backup folder\n" | tee -a $basedir/logs/status.log  && exit 1
    ;;
   esac;
   [ ! -d "$3" ] && mkdir -p "$3"
}

#This is the main action of backup shell
[ "$1" ] && {
  case "$1" in
    --backup-all)
      echo "[$(date) - Backup ALL]API started successfully\n" >> "$basedir/logs/status.log"
      validateARGS $@
      backupAll $@
      exit 0
    ;;
    --backup-files)
      echo "[$(date) - Backup Files]API started successfully\n" >> "$basedir/logs/status.log"
      validateARGS $@
      backupFILES $@
      exit 0
    ;;
    --backup-database)
      echo "[$(date) - Backup Database]API started successfully\n" >> "$basedir/logs/status.log"
      validateARGS $@
      backupDATABASE $@
      exit 0
    ;;
    --auto-clean)
      echo "[$(date) - Auto Clean]API started successfully\n" >> "$basedir/logs/status.log"
      validateARGS $@
      backupAUTOCLEAN $@
      exit 0
    ;;
   -h |--help)
       echo "$MSG_HELP"
       exit 0
    ;;
    *)
	echo "missing action option";
	exit 0
    ;;
  esac
}
