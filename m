Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2004 20:58:05 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:21135 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224954AbUAFU6C>;
	Tue, 6 Jan 2004 20:58:02 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i06KvwQF006888;
	Tue, 6 Jan 2004 21:57:58 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id VAA19546;
	Tue, 6 Jan 2004 21:57:59 +0100 (MET)
Date: Tue, 6 Jan 2004 21:57:59 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH][2.6] Fix Makefiles for CONFIG_EMBEDDED_RAMDISK
Message-ID: <20040106205758.GA19525@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

Hi,

  here are patches that fix the arch/mips/Makefile and
  arch/mips/ramdisk/Makefile when an embedded ramdisk image needs to
  be included through the CONFIG_EMBEDDED_RAMDISK option.


--- linux-mips-2.6.orig/arch/mips/Makefile	2004-01-06 21:17:57.000000000 +0100
+++ linux.work/arch/mips/Makefile	2004-01-06 21:43:33.000000000 +0100
@@ -187,13 +187,11 @@
 
 #
 # ramdisk/initrd support
-# You need a compressed ramdisk image, named ramdisk.gz in
-# arch/mips/ramdisk
+# You need a compressed ramdisk image, named
+# CONFIG_EMBEDDED_RAMDISK_IMAGE. Relative pathnames 
+# are relative to arch/mips/ramdisk/.
 #
-ifdef CONFIG_EMBEDDED_RAMDISK
-CORE_FILES	+= arch/mips/ramdisk/ramdisk.o
-SUBDIRS		+= arch/mips/ramdisk
-endif
+core-$(CONFIG_EMBEDDED_RAMDISK)	+= arch/mips/ramdisk/
 
 #
 # Firmware support



--- linux-mips-2.6.orig/arch/mips/ramdisk/Makefile	2003-07-29 16:26:23.000000000 +0200
+++ linux.work/arch/mips/ramdisk/Makefile	2004-01-06 21:40:50.000000000 +0100
@@ -2,8 +2,19 @@
 # Makefile for a ramdisk image
 #
 
+obj-y += ramdisk.o
+
+
 O_FORMAT = $(shell $(OBJDUMP) -i | head -n 2 | grep elf32)
-img = $(CONFIG_EMBEDDED_RAMDISK_IMAGE)
-ramdisk.o: $(subst ",,$(img)) ld.script
-	echo "O_FORMAT:  " $(O_FORMAT)
-	$(LD) -T ld.script -b binary --oformat $(O_FORMAT) -o $@ $(img)
+img := $(subst ",,$(CONFIG_EMBEDDED_RAMDISK_IMAGE))
+# add $(src) when $(img) is relative
+img := $(subst $(src)//,/,$(src)/$(img))
+
+quiet_cmd_ramdisk = LD      $@
+define cmd_ramdisk
+	$(LD) -T $(src)/ld.script -b binary --oformat $(O_FORMAT) -o $@ $(img)
+endef
+
+$(obj)/ramdisk.o: $(img) $(src)/ld.script
+	$(call cmd,ramdisk)
+


-- 
Dimitri Torfs             |  NSCE 
dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
tel: +32 2 2908451        |  1130 Brussel
fax: +32 2 7262686        |  Belgium
