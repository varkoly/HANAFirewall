# 21.11.2014, rr
VERSION	= $(shell cat VERSION)
PACKAGE	=HANA-Firewall
DIR	=$(PACKAGE)-$(VERSION)
SUBS	=hana_firewall init.d sysconfig Makefile

install: install_bin install_config

install_bin:
	install -d -m 755 $(DESTDIR)/sbin
	install -d -m 755 $(DESTDIR)/etc/init.d
	install -m 755 hana_firewall $(DESTDIR)/sbin
	install -m 755 init.d/hana_firewall $(DESTDIR)/etc/init.d
	ln -s /etc/init.d/hana_firewall $(DESTDIR)/sbin/rchana_firewall

install_config:
	install -d -m 755 $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall $(DESTDIR)/etc/sysconfig
	install -m 750 sysconfig/hana_firewall.d/create_new_service $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_DATABASE_CLIENT $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_DATA_PROVISIONING $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_DISTRIBUTED_SYSTEMS $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_HTTP_CLIENT_ACCESS $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_SAP_SUPPORT $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_STUDIO $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_STUDIO_LIFECYCLE_MANAGER $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_SYSTEM_REPLICATION $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/NFS_SERVER $(DESTDIR)/etc/sysconfig/hana_firewall.d
	install -m 640 sysconfig/hana_firewall.d/HANA_HIGH_AVAILABILITY $(DESTDIR)/etc/sysconfig/hana_firewall.d

dist:
	if [ -e $(DIR) ] ;  then rm -rf $(DIR) ; fi  
	mkdir $(DIR)
	for i in $(SUBS); do /bin/ln -s ../$$i $(DIR)/$$i; done
	tar hjcvpf $(DIR).tar.bz2 $(DIR)
	sed    s/@VERSION@/$(VERSION)/  $(PACKAGE).spec.in > $(PACKAGE).spec
