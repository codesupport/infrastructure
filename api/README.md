# API
## Certbot

[Certbot](https://certbot.eff.org/) is used to handle automatically generating SSL certificates as well as renewing them when the time comes.

### Running certbot

```bash
$ certbot --nginx -d api.codesupport.dev
```

This will attempt a HTTP challenge (ensure port 80 is open) to verify the domain and then generate a new LetsEncrypt SSL certificate.

**Note:** LE certs expire every 3 months.

### Automatic renewal

By default most installations of certbot should handle auto-renewal for you out of the box, however, it is worth verifying: [Certbot Auto-Renewal Documentation](https://certbot.eff.org/docs/using.html?highlight=renew#automated-renewals).

For Ubuntu 20.04 we should see the certbot job enabled in `systemctl list-timers`

```
NEXT                        LEFT          LAST                        PASSED       UNIT         >
...
Sat 2021-03-06 07:07:00 UTC 9h left       Fri 2021-03-05 13:38:11 UTC 7h ago       snap.certbot.>
...
```

If for whatever reason it is not enabled by either cron or systemd, you can add a new cron job to run automatic renewal.

```
# This will open the crontab file in the chosen editor
$ crontab -e

# Add the following line (Ensure you leave a newline at the bottom of the crontab file)
0 12 * * * /usr/bin/certbot renew --quiet
```