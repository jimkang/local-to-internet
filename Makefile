include config.mk

HOMEDIR = $(shell pwd)
PROJECTNAME = local-to-internet
APPDIR = /opt/$(PROJECTNAME)
SSHCMD = ssh $(USER)@$(SERVER)

set-up-server-dir:
	$(SSHCMD) "mkdir -p $(APPDIR)"

sync:
	rsync -a $(HOMEDIR) $(USER)@$(SERVER):/opt/ --exclude node_modules/

pushall: sync
	git push origin master
