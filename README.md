# NetCheck
Monitor and report on external network connectivity changes

## Description
`NetCheck` is a suite of modules that monitor your computer's connection to the external Internet and reports on the connection's up/down events.  It does not monitor bandwidth, just connectivity disruptions.

`NetCheck`'s creation was motivated by my service provider's intermittent router failures that randomly broke and then restored our external network connections.  The `NetCheck` logs confirmed that the disconnections were caused by the provider's routers, which were subsequently corrected.

This distribution package includes:
-  A `bash` script that checks connectivity status every 60 seconds and records events in a log file;
-  A `bash` script that reads that log file and reports on those up/down events;
-  A `.service` script that is installed for use by `systemctl` to run the status-recording script and restart it upon reboots;
-  A `Makefile` to install those files and start the service.

## Installation
First, clone this repository: `git clone http://github.com/hdtodd/NetCheck` and `cd NetCheck`.

1. To begin installation, you must first identify the first external (service provider) router that your network sees.  Execute, for example, `traceroute 8.8.8.8` and find the first external router that receives your packets.  It will have an IP address such as `67.78.89.90`.
2. The distributed code expects to use `/usr/local/bin` for the two scripts and to keep the connectivity log in `/var/log`.  Decide if those are acceptable; if not identify the directories you would prefer to use.
3. Edit `NetCheck.bsh` to set the "server" IP address to the one you identified in step 1 and to change the path to the log file (if you want a different location/name).
4. If you're changing directories from those as distributed, change those in `Makefile` and in `NetCheckRpt.bsh`.
5. `sudo make install`

## Checking Connectivity Events
Run `NetCheckRpt.bsh` to obtain a report on connectivity status and disruptions.

## Uninstalling
`cd` into the repository clone `NetCheck` directory and type `sudo make uninstall`.  This stops and disables the `systemctl NetCheck` service, removes the `.log` file, and removes the `NetCheck.bsh` and `NetCheckRpt.bsh` files.

## Release History

| Version | Date       | Changes |
|---------|------------|---------|
| V2.0    | 2026.09.17 | Document and automate installation |
| V1.0    | 2026.05.17 | Implement recording and reporting scripts and put into production |

## Author
Written by HDTodd@gmail.com, 2026.05.17.
