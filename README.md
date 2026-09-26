# NetCheck V2.1
Monitor and report on external Internet connectivity disruptions.

## Description
`NetCheck` is a suite of modules that monitor your computer's connection to the external Internet and report on the connection's up/down events.  It does not monitor bandwidth, just connectivity disruptions.

`NetCheck`'s creation was motivated by my service provider's intermittent router failures that randomly broke and then restored our external network connections.  The `NetCheck` logs confirmed that the disconnections were caused by the provider's routers, which were subsequently corrected.

Example report:
```
$ NetCheckRpt.bsh 

Up/Down Status Summary of Network Pings of 1st External Router

↑ UP	 2026-09-17@08:32:39 	
↓ DOWN	 2026-09-18@02:00:10 	
↑ UP	 2026-09-18@07:11:55 	
↓ DOWN	 2026-09-24@08:46:02 	
↑ UP	 2026-09-24@08:47:02 	
↓ DOWN	 2026-09-26@08:33:30 	Router update
↑ UP	 2026-09-26@08:34:30 	
Last status, <↑> @  2026-09-26@08:34:30 
```

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
5. Now install with the command `sudo make install`

## Use
After installation, check to confirm that `NetCheck` is running by issuing the command 

        $ ps ax | grep NetCheck

Once it is in operation, no further action is needed.

`NetCheck` only records _changes_ in network connectivity status, so the log file will (normally) grow in size only very slowly.  Still, you might occasionally check `/var/log/NetCheck.log` and remove it if it becomes very large.

Notations that are edited into `/var/log/NetCheck.log` at the end of an entry line are reported in the `NetCheckRpt` summary, as seen above.  This may be handy to note cases in which the Internet connection has been intentionally disrupted, such as when a router update is performed.

## Checking Connectivity Events
Run `NetCheckRpt.bsh` to obtain a report on connectivity status and disruptions.

## Uninstalling
`cd` into the repository clone `NetCheck` directory and type `sudo make uninstall`.  This stops and disables the `systemctl NetCheck` service, removes the `.log` file, and removes the `NetCheck.bsh` and `NetCheckRpt.bsh` files.

## Release History

| Version | Date       | Changes |
|---------|------------|---------|
| V2.1    | 2026.09.26 | Add ability to report manual notations in log file |
| V2.0    | 2026.09.17 | Document and automate installation |
| V1.0    | 2026.05.17 | Implement recording and reporting scripts and put into production |

## Author
Written by HDTodd@gmail.com, 2026.05.17.
