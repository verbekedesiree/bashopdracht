tar -czvf /home/user/backups/backupfile.tar /home/user/testfiles/

if [ ! -s "/etc/cron.weekly/make_backup" ];
		then 
			sudo cp make_backup.sh /etc/cron.weekly/make_backup	
			echo "de file is in de weekly cron gestopt. Dit zorgt ervoor dat het iedere zondag runt."
			echo "de exacte tijd kan bekeken worden in de  /etc/crontab file"
			exit 1
fi
