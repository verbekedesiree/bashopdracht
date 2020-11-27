tar -czvf /home/user/backups/backupfile.tar /home/user/testfiles/

if [ ! -s "/etc/cron.weekly/make_backup" ];
		then 
			sudo cp make_backup.sh /etc/cron.weekly/make_backup	
			echo "the backup schedule has been set to run weekly"
			echo "the exact run time is in the /etc/crontab file"
			exit 1
fi
