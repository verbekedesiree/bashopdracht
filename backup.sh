tar -czvf /home/user/backups/backupfile.tar /home/user/testfiles/

if [ ! -s "/etc/cron.weekly/make_backup" ];
		then 
			sudo cp make_backup.sh /etc/cron.d/make_backup	
			echo "de file is in de cron.d gestopt."
			echo "de exacte tijd kan bekeken worden in de  /etc/crontab file"
			exit 1
fi

echo '321' | su root 

echo 'tijd wordt aangepast naar zondag om 17uur'
sudo echo '
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

17 * * * * root cd / && run-parts --report /etc/cron.hourly
25 6 * * * root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
0 17 * * 7 root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6 1 * * root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly$
' > /etc/crontab

su user