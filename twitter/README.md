# CodeSupport Twitter

This repo integrates the twitter API along with Discord webhooks. It works by polling the [twitter timeline api](https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets) and sending any new tweets to Discord as a webhook message.

## Getting started

### Dictu

This script is written in [Dictu](https://github.com/dictu-lang/Dictu) so to use it, ensure Dictu is installed first.

### Env Variables

To get setup this project requires a `.env` file in the project root, an example is provided at `.env.example`.

| Variable                 | Explanation                                                  |
| ------------------------ | ------------------------------------------------------------ |
| ENV                      | This is used to designate which discord webhook URL to use, useful for testing.<br />Accepted values (DEV or PROD) |
| TWITTER_API_TOKEN        | This is the bearer token given to you when creating an application within the twitter API |
| TWITTER_USER_ID          | Twitter user ID who's timeline is being watched              |
| PROD_DISCORD_WEBHOOK_URL | Discord webhook URL                                          |
| DEV_DISCORD_WEBHOOK_URL  | Secondary webhook URL, useful for testing                    |

### Running

After copying `.env.example` to `.env` and filling out the required variables run the entry point `run.du` file.

```bash
$ dictu run.du
```

### Cron

This script is best used with some sort of scheduler to execute it periodically, cron being a prime example. A small bash script can help with this.

```bash
cd /path/to/repo
dictu run.du
```

To setup a cronjob add the following via `crontab -e`.

```
*/5 * * * * /path/to/repo/run.sh >> /path/to/repo/logs.txt 2>&1
```

This will run every 5 minutes, for a different resolution see [Crontab.guru - The cron schedule expression editor](https://crontab.guru/).

This will also pipe all logs and/or errors generated into logs.txt.

### Last tweet

Once the twitter API has been queried the latest tweet ID is saved into `last_tweet_id.txt` and used in subsequent requests to the Twitter API to ensure it only returns tweets past the last ID. If you're setting this up for the first time it will pull all tweets, however, you can just create this file manually and enter the given tweet ID to start from a given point.