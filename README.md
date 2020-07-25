local-to-internet
==================

Scripts that sync a local drive to cloud storage.

Usage
------------

Use `make sync` to copy this to the server you want to run it on. (Or just clone it there.) If you are using `make sync`, create a `config.mk` in the project directory that lists the server and user for that server like so:

    USER = syncuser
    SERVER = hostname

Run config in [s3cmd](https://s3tools.org/s3cmd) so that credentials for your s3-compatible bucket are set up. (Note: This has only been tested with Digital Ocean Spaces so far.)

If `s3cmd` is in a location other than `/usr/local/bin/s3cmd`, edit it in sync.sh.

Make sure `/var/log/local-to-internet` exists on that server and that the cron user can write to it.

Then, schedule it in cron. e.g.

    57 * * * * cd /opt/local-to-internet/sync.sh /usr/share/my-web-sites/ mybucket web

Sometimes, the directory is so large that s3cmd seems to do nothing for over an hour (because I imagine it's calculating diffs). In those cases, it might be better to use `sync-subdir-at-a-time` which will go through the subdirectories of the directory you specify and issue an s3cmd for each of those, so that you can see things happen in the log and at least get partial results if the machine goes down or something.
