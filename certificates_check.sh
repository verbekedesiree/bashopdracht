if openssl x509 -checkend $((24*3600*14)) -noout -in  /etc/ssl/certs/*.pem
then
  echo "Certificate is good for another day!"
else
  echo "Certificate has expired or will do so within 24 hours!"
  echo "(or is invalid/not found)"
fi


openssl x509 -checkend $((24*3600*14)) -noout -in  /etc/ssl/certs/*.pem
if [ $? -eq 0 ]; then
	echo 'alles in orde'
else 
	echo 'bad'
fi


for pem in /etc/ssl/certs/*.pem; do 
   printf '%s: %s\n' \
      "$(date --date="$(openssl x509 -enddate -noout -in "$pem"|cut -d= -f 2)" --iso-8601)" \
      "$pem"
done | sort