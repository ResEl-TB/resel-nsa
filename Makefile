SHELL=/bin/bash
PACKAGE=$(shell basename $$(ls -d */))
ARCHIVE=$(shell echo $(PACKAGE) | sed 's/\(.*\)-/\1_/')
SHORT=$(shell echo $(PACKAGE) | sed 's/\(.*\)-\(.*\)/\1/')

deb:
	tar --exclude debian -C $(PACKAGE)/ -cvzf $(ARCHIVE).orig.tar.gz .
	cd $(PACKAGE); debuild -us -uc

clean:
	rm -f $(ARCHIVE)*
	rm -rf $(PACKAGE)/debian/{.debhelper,$(SHORT)}
	rm -f $(PACKAGE)/debian/{debhelper-build-stamp,files,$(SHORT).{debhelper.log,substvars}}
