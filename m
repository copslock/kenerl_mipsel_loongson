Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6K2A4c06165
	for linux-mips-outgoing; Thu, 19 Jul 2001 19:10:04 -0700
Received: from snfc21.pbi.net (mta5.snfc21.pbi.net [206.13.28.241])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6K2A2V06159
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 19:10:02 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta5.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GGR00KD820OL1@mta5.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Thu, 19 Jul 2001 19:10:00 -0700 (PDT)
Date: Thu, 19 Jul 2001 19:10:07 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: generic ramdisk support
To: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3B5792FF.1030808@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------050502010009030901000804
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------050502010009030901000804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Any reason why we don't have a single directory for a ramdisk linker 
script and Makefile? I've attached that does that. You just put a 
ramdisk.gz image in arch/mips/ramdisk and turn on initrd support. At 
somepoint I'll upload some useful ramdisks to the sourceforge linux-mips 
anonymous ftp site.


Pete

--------------050502010009030901000804
Content-Type: text/plain;
 name="ramdisk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ramdisk.patch"

diff -Naur --exclude=CVS linux-mips-dev-orig/arch/mips/Makefile linux-mips-dev/arch/mips/Makefile
--- linux-mips-dev-orig/arch/mips/Makefile	Thu Jul 12 11:41:14 2001
+++ linux-mips-dev/arch/mips/Makefile	Thu Jul 19 18:54:29 2001
@@ -90,6 +90,16 @@
 CORE_FILES	+=arch/mips/math-emu/fpu_emulator.o
 SUBDIRS		+=arch/mips/math-emu
 
+# 
+# ramdisk/initrd support
+# You need a compressed ramdisk image, named ramdisk.gz in
+# arch/mips/ramdisk
+#
+ifdef CONFIG_BLK_DEV_INITRD 
+CORE_FILES      += arch/mips/ramdisk/ramdisk.o
+SUBDIRS		+= arch/mips/ramdisk
+endif
+
 #
 # Board-dependent options and extra files
 #
diff -Naur --exclude=CVS linux-mips-dev-orig/arch/mips/ramdisk/Makefile linux-mips-dev/arch/mips/ramdisk/Makefile
--- linux-mips-dev-orig/arch/mips/ramdisk/Makefile	Wed Dec 31 16:00:00 1969
+++ linux-mips-dev/arch/mips/ramdisk/Makefile	Thu Jul 19 18:07:46 2001
@@ -0,0 +1,22 @@
+#
+# Makefile for a ramdisk image
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+
+ifdef CONFIG_CPU_LITTLE_ENDIAN
+output-format   = elf32-tradlittlemips
+else
+output-format   = elf32-tradbigmips
+endif
+
+ramdisk.o: ramdisk.gz ld.script
+	$(LD) -T ld.script -b binary -o $@ ramdisk.gz
+
+ld.script: $(TOPDIR)/arch/$(ARCH)/ramdisk/ld.script.in
+	sed 's/@@OUTPUT_FORMAT@@/$(output-format)/' <$< >$@
+
+include $(TOPDIR)/Rules.make
+
diff -Naur --exclude=CVS linux-mips-dev-orig/arch/mips/ramdisk/ld.script.in linux-mips-dev/arch/mips/ramdisk/ld.script.in
--- linux-mips-dev-orig/arch/mips/ramdisk/ld.script.in	Wed Dec 31 16:00:00 1969
+++ linux-mips-dev/arch/mips/ramdisk/ld.script.in	Thu Jul 19 17:36:10 2001
@@ -0,0 +1,10 @@
+OUTPUT_FORMAT("@@OUTPUT_FORMAT@@")
+OUTPUT_ARCH(mips)
+SECTIONS
+{
+  .initrd :
+  {
+  	*(.data)
+  }
+}
+

--------------050502010009030901000804--
