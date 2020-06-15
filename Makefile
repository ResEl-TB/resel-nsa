SHELL=/bin/bash
PACKAGE=$(shell basename $$(ls -d */))
ARCHIVE=$(shell echo $(PACKAGE) | sed 's/\(.*\)-/\1_/')

deb:
	find . -name .keep -delete
	tar --exclude debian -C $(PACKAGE)/ -cvzf $(ARCHIVE).orig.tar.gz .
	cd $(PACKAGE); debuild -us -uc

clean:
	rm -f $(ARCHIVE)*
	cd $(PACKAGE); dh_clean
	find . -type d ! -path "./.git*" -empty -exec touch '{}'/.keep \;
