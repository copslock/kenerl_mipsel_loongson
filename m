Received:  by oss.sgi.com id <S305180AbQDBIRd>;
	Sun, 2 Apr 2000 00:17:33 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:13101 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305164AbQDBIRW>; Sun, 2 Apr 2000 00:17:22 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id AAA00890; Sun, 2 Apr 2000 00:21:05 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA93398
	for linux-list;
	Sat, 1 Apr 2000 23:53:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA80796
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Apr 2000 23:53:11 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id XAA15108
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Apr 2000 23:48:30 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7FC347F4; Sun,  2 Apr 2000 09:39:47 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id DA78D8FC3; Sun,  2 Apr 2000 09:24:55 +0200 (CEST)
Date:   Sun, 2 Apr 2000 09:24:55 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: mips config.in patch 1 of N - Check for completeness
Message-ID: <20000402092455.C1368@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



Hi,
here is a small patch against current cvs config.in - Please people
check it as i think i made some errors - It looks much cleaner (afterwards)
but its only a small step down the road ...

BTW: Does ANYONE use the "I am using a crosscompiler" config flag ?
I dont as i have a different name for my compiler (It assumes
mips-linux- or mipsel-linux- but i have the full name
mipsel-unknown-linux-gnu-) - The old style method by inserting it
into the Makefile works also.

Index: config.in
===================================================================
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.48
diff -u -r1.48 config.in
--- config.in	2000/03/29 00:18:16	1.48
+++ config.in	2000/04/02 07:30:44
@@ -114,83 +114,83 @@
 mainmenu_option next_comment
 comment 'General setup'
 
-if [ "$CONFIG_DECSTATION" = "y" -o "$CONFIG_DDB5074" = "y" ]; then
-   define_bool CONFIG_CPU_LITTLE_ENDIAN y
-else
-   bool 'Generate little endian code' CONFIG_CPU_LITTLE_ENDIAN
-fi
-
-if [ "$CONFIG_PROC_FS" = "y" ]; then
-   define_bool CONFIG_KCORE_ELF y
-fi
-define_bool CONFIG_ELF_KERNEL y
-
-if [ "$CONFIG_CPU_LITTLE_ENDIAN" = "n" ]; then
-   define_bool CONFIG_BINFMT_IRIX y
-   define_bool CONFIG_FORWARD_KEYBOARD y
-fi
-define_bool CONFIG_BINFMT_AOUT n
-define_bool CONFIG_BINFMT_ELF y
-tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-
-bool 'Networking support' CONFIG_NET
-
-source drivers/pci/Config.in
-source drivers/pcmcia/Config.in
-
-bool 'System V IPC' CONFIG_SYSVIPC
-bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
-bool 'Sysctl support' CONFIG_SYSCTL
-
-if [ "$CONFIG_SGI_IP22" != "y" -a "$CONFIG_DECSTATION" != "y" -a "$CONFIG_BAGET_MIPS" != "y" ]; then
-   source drivers/parport/Config.in
-fi
-endmenu
-
-mainmenu_option next_comment
-comment 'Loadable module support'
-bool 'Enable loadable module support' CONFIG_MODULES
-if [ "$CONFIG_MODULES" = "y" ]; then
-   bool '  Set version information on all symbols for modules' CONFIG_MODVERSIONS
-   bool '  Kernel module loader' CONFIG_KMOD
-fi
-
-source drivers/pci/Config.in
-
+	if [ "$CONFIG_DECSTATION" = "y" -o "$CONFIG_DDB5074" = "y" ]; then
+	   define_bool CONFIG_CPU_LITTLE_ENDIAN y
+	else
+	   bool 'Generate little endian code' CONFIG_CPU_LITTLE_ENDIAN
+	fi
+
+	if [ "$CONFIG_PROC_FS" = "y" ]; then
+	   define_bool CONFIG_KCORE_ELF y
+	fi
+	define_bool CONFIG_ELF_KERNEL y
+
+	if [ "$CONFIG_CPU_LITTLE_ENDIAN" = "n" ]; then
+	   define_bool CONFIG_BINFMT_IRIX y
+	   define_bool CONFIG_FORWARD_KEYBOARD y
+	fi
+	define_bool CONFIG_BINFMT_AOUT n
+	define_bool CONFIG_BINFMT_ELF y
+	tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+
+	bool 'Networking support' CONFIG_NET
+
+	if [ "$CONFIG_PCI" = "y" ]; then
+	    source drivers/pci/Config.in
+	fi
+
+	#Architectures possibly having pcmcia should include this
+        #source drivers/pcmcia/Config.in
+
+	bool 'System V IPC' CONFIG_SYSVIPC
+	bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
+	bool 'Sysctl support' CONFIG_SYSCTL
+
+	#Architectures having PC Style Parports - please include
+        #source drivers/parport/Config.in
+
+	bool 'Enable loadable module support' CONFIG_MODULES
+	if [ "$CONFIG_MODULES" = "y" ]; then
+	   bool '  Set version information on all symbols for modules' CONFIG_MODVERSIONS
+	   bool '  Kernel module loader' CONFIG_KMOD
+	fi
+
+	if [ "$CONFIG_DECSTATION" = "y" ]; then
+            bool 'TURBOchannel support' CONFIG_TC
+	fi
 endmenu
 
-if [ "$CONFIG_DECSTATION" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'TURBOchannel support'
-   bool 'TURBOchannel support' CONFIG_TC
-#   if [ "$CONFIG_TC" = "y" ]; then
-#      tristate '  MAGMA Parallel port support' CONFIG_PARPORT
-#   fi
-   endmenu
+if [ "$CONFIG_ISA" = "y" ]; then
+   source drivers/pnp/Config.in
 fi
 
-source drivers/pnp/Config.in
-
 source drivers/block/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
    source net/Config.in
 fi
-
-source drivers/telephony/Config.in
-
-mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
-
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
-  define_bool CONFIG_BLK_DEV_HD n
+if [ "$CONFIG_DECSTATION" != "n" -a \
+     "$CONFIG_SGI_IP22" != "n" ]; then
+    source drivers/telephony/Config.in
+fi
+
+if [ "$CONFIG_SGI_IP22" != "n" -a \
+     "$CONFIG_DECSTATION" != "n" ]; then
+
+    mainmenu_option next_comment
+    comment 'ATA/IDE/MFM/RLL support'
+    
+    tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+    
+    if [ "$CONFIG_IDE" != "n" ]; then
+      source drivers/ide/Config.in
+    else
+      define_bool CONFIG_BLK_DEV_IDE_MODES n
+      define_bool CONFIG_BLK_DEV_HD n
+    fi
+    endmenu
 fi
-endmenu
 
 mainmenu_option next_comment
 comment 'SCSI support'
@@ -202,7 +202,10 @@
 fi
 endmenu
 
-source drivers/i2o/Config.in
+if [ "$CONFIG_DECSTATION" != "n" -a \
+     "$CONFIG_SGI_IP22" != "n" ]; then
+    source drivers/i2o/Config.in
+fi
 
 if [ "$CONFIG_NET" = "y" ]; then
    mainmenu_option next_comment
@@ -210,8 +213,13 @@
 
    bool 'Network device support' CONFIG_NETDEVICES
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
-      if [ "$CONFIG_SGI_IP22" != "y" -a "$CONFIG_DECSTATION" != "y" -a "$CONFIG_BAGET_MIPS" != "y" ]; then
+
+      if [ "$CONFIG_SGI_IP22" != "y" -a \
+      	   "$CONFIG_DECSTATION" != "y" -a \
+	   "$CONFIG_BAGET_MIPS" != "y" ]; then
+
 	 source drivers/net/Config.in
+
 	 if [ "$CONFIG_ATM" = "y" ]; then
 	    source drivers/atm/Config.in
 	 fi
@@ -239,8 +247,11 @@
    fi
    endmenu
 fi
+
+if [ "$CONFIG_SGI_IP22" != "y" -a \
+	"$CONFIG_DECSTATION" != "y" -a \
+	"$CONFIG_BAGET_MIPS" != "y" ]; then
 
-if [ "$CONFIG_SGI_IP22" != "y" -a "$CONFIG_DECSTATION" != "y" -a "$CONFIG_BAGET_MIPS" != "y" ]; then
    source drivers/net/hamradio/Config.in
 
    mainmenu_option next_comment
@@ -264,20 +275,20 @@
    endmenu
 fi
 
-if [ "$CONFIG_DECSTATION" != "y" ]; then
+if [ "$CONFIG_DECSTATION" != "n" -a \
+     "$CONFIG_SGI_IP22" != "n" ]; then
    source drivers/char/Config.in
-else
+fi
+
+if [ "$CONFIG_DECSTATION" = "y" ]; then
    mainmenu_option next_comment
-   comment 'DECstation Character devices'
+   comment 'DECStation Character devices'
 
    bool 'Virtual terminal' CONFIG_VT
    if [ "$CONFIG_VT" = "y" ]; then
       bool 'Support for console on virtual terminal' CONFIG_VT_CONSOLE
    fi
    tristate 'Standard/generic (dumb) serial support' CONFIG_SERIAL
-   if [ "$CONFIG_SGI_IP22" = "y" ]; then
-      bool 'SGI PROM Console Support' CONFIG_SGI_PROM_CONSOLE
-   fi
    if [ "$CONFIG_SERIAL" = "y" ]; then
       bool 'DZ11 Serial Support' CONFIG_DZ
       if [ "$CONFIG_TC" = "y" ]; then
@@ -294,30 +305,43 @@
    bool 'Enhanced Real Time Clock Support' CONFIG_RTC
    endmenu
 fi
-
-source drivers/usb/Config.in
-
-#source drivers/misc/Config.in
-
-source fs/Config.in
 
-if [ "$CONFIG_VT" = "y" ]; then
+if [ "$CONFIG_SGI_IP22" = "y" ]; then
    mainmenu_option next_comment
-   comment 'Console drivers'
-   if [ "$CONFIG_SGI_IP22" = "y" ]; then
+   comment 'SGI Character devices'
+   bool 'Virtual terminal' CONFIG_VT
+   if [ "$CONFIG_VT" = "y" ]; then
+      bool 'Support for console on virtual terminal' CONFIG_VT_CONSOLE
       tristate 'SGI Newport Console support' CONFIG_SGI_NEWPORT_CONSOLE
       if [ "$CONFIG_SGI_NEWPORT_CONSOLE" != "y" ]; then
 	 define_bool CONFIG_DUMMY_CONSOLE y
       else
          define_bool CONFIG_FONT_8x16 y
       fi
-   else
+      bool 'SGI PROM Console Support' CONFIG_SGI_PROM_CONSOLE
+   fi
+   bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
+   if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
+      int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256
+   fi
+   endmenu
+fi
+
+#The ones having USB should include it
+#source drivers/usb/Config.in
+
+
+source fs/Config.in
+
+if [ "$CONFIG_VT" = "y" ]; then
+   mainmenu_option next_comment
+
+   comment 'Console drivers'
       if [ "$CONFIG_DECSTATION" != "y" ]; then
 	 bool 'VGA text console' CONFIG_VGA_CONSOLE
       fi
-	 bool 'Support for frame buffer devices' CONFIG_FB
-	 source drivers/video/Config.in
-   fi
+      bool 'Support for frame buffer devices' CONFIG_FB
+      source drivers/video/Config.in
    endmenu
 fi
 
@@ -339,7 +363,6 @@
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
-#bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Are you using a crosscompiler' CONFIG_CROSSCOMPILE
 if [ "$CONFIG_MODULES" = "y" ]; then
    bool ' Build fp execption handler module' CONFIG_MIPS_FPE_MODULE

-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
