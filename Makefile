# This suite monitors your external network connection
# and lets you generate a report on its up/down status.

# Do "sudo make install" to install these scripts

# If you change the following definitions, be sure
#    to also change them in the .service and .bsh
#    files, too.

PROJ=NetCheck
BIN=/usr/local/bin
LOG=/var/log

install:
ifneq ($(shell id -u), 0)
	@echo "You must be root to install this program; 'sudo make install'."
else
	@echo "Installing $(PROJ) ..."
	cp $(PROJ).bsh $(BIN)/
	chmod 755 $(BIN)/$(PROJ).bsh
	cp $(PROJ)Rpt.bsh $(BIN)/
	chmod 755 $(BIN)/$(PROJ)Rpt.bsh
	cp $(PROJ).service /etc/systemd/system/
	mkdir -p $(LOG)
	systemctl enable $(PROJ).service
	systemctl start  $(PROJ).service
	@echo "... done"
endif

clean:
	rm *~

uninstall:
ifneq ($(shell id -u), 0)
	@echo "You must be root to uninstall this program; 'sudo make uninstall'."
else
	@echo "Uninstalling $(PROJ) ..."
	systemctl stop    $(PROJ).service
	systemctl disable $(PROJ).service
	rm /etc/systemd/system/$(PROJ).service
	rm $(LOG)/$(PROJ).log
	rm $(BIN)/$(PROJ).bsh
	rm $(BIN)/$(PROJ)Rpt.bsh
	@echo "... done"
endif
