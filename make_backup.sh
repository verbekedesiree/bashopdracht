#!/bin/bash


##variables 
LOG_LOC = "/var/log/mybackup.log"


function check_dir_loc {
		#check for dir list file
		if [ ! -s "/backup_dir.conf" ]
		then 
			echo "please create a list of directories to backup by creating a backup_dir. conf file in the root directorty"
			exit 1 
		fi
		
}

function check_backup_loc {
		if [ ! -s "/backup_loc.conf"]
		then
			echo "please specify the full path of where to send the backup to, by creating the backup_loc.conf file in the root directory"
			exit 1
		fi
}

function check_schedule {
		#check to see if script exists in weekly cron directory
		if [ ! -s "/etc/cron.weekly/make_backup"]
		then 
			sudo cp make_backup.sh /etc/cron.weekly/make_backup	
			echo "the backup schedule has been set to run weekly"
			echo "the exact run time is in the /etc/crontab file"
			exit 1
		fi
}

function perform_backup {
		# get backup location
		backup_path=$(cat /backup_loc.conf)
		
		echo "starting backup..." >$LOG_LOC
		while read dir_path
		do
			# get backup dir name
			dir_name=$(basename $dir_path)
			
			# create filename for compressed backup
			filename=$backup_path$dir_name.tar.gz
			
			#archive dirs and compress archive
			tar -zcf $filename $dir_path 2>> $LOG_LOC
			
			#change ownership of backup files
			chown user:user $filename
			
			echo "backing up of $dir_name completed." >> $LOG_LOC
			
		done < /backup_dirs.conf
		echo "backup complete at: " >> $LOG_LOC
		date >> $LOG_LOC
}

##end function
check_dir_loc
check_backup_loc
check_schedule
perform_backup