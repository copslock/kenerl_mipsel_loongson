Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2003 20:31:12 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:36848 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224939AbTBMUbL>;
	Thu, 13 Feb 2003 20:31:11 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1DKV9B19770;
	Thu, 13 Feb 2003 12:31:09 -0800
Date: Thu, 13 Feb 2003 12:31:08 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] REMOTE_DEBUG, DEBUG config cleanup
Message-ID: <20030213123108.V7466@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Remove false dependency.  Add help info for CONFIG_DEBUG.

Patches for both 2.4 & 2.5.

Jun

--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030213.a-2.4-debug-config-cleanup.patch"

diff -Nru linux/Documentation/Configure.help.orig linux/Documentation/Configure.help
--- linux/Documentation/Configure.help.orig	Wed Jan 29 15:32:58 2003
+++ linux/Documentation/Configure.help	Thu Feb 13 12:22:21 2003
@@ -20482,6 +20482,13 @@
   Currently used only by the time services code in the MIPS port.
   Don't turn this on unless you know what you are doing.
 
+Enable run-time debugging
+CONFIG_DEBUG
+  If you say Y here, some debugging macros will do run-time checking.
+  If you say N here, those macros will mostly turn to no-ops.  For
+  MIPS boards only.  See include/asm-mips/debug.h for debuging macros.
+  If unsure, say N.
+
 Remote GDB kernel debugging
 CONFIG_REMOTE_DEBUG
   If you say Y here, it will be possible to remotely debug the MIPS
diff -Nru linux/arch/mips/config-shared.in.orig linux/arch/mips/config-shared.in
--- linux/arch/mips/config-shared.in.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/config-shared.in	Thu Feb 13 12:26:54 2003
@@ -976,10 +976,8 @@
 
 bool 'Are you using a crosscompiler' CONFIG_CROSSCOMPILE
 bool 'Enable run-time debugging' CONFIG_DEBUG
-if [ "$CONFIG_AU1X00_UART" = "y" -o "$CONFIG_ZS" = "y" -o "$CONFIG_SIBYTE_SB1xxx_SOC" = "y" ]; then
-   dep_bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG $CONFIG_DEBUG
-   dep_bool '  Console output to GDB' CONFIG_GDB_CONSOLE $CONFIG_REMOTE_DEBUG
-fi
+bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
+dep_bool '  Console output to GDB' CONFIG_GDB_CONSOLE $CONFIG_REMOTE_DEBUG
 if [ "$CONFIG_SIBYTE_SB1xxx_SOC" = "y" ]; then
    dep_bool 'Compile for Corelis Debugger' CONFIG_SB1XXX_CORELIS $CONFIG_DEBUG
 fi

--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030213.a-2.5-debug-config-cleanup.patch"

diff -Nru linux/arch/mips/Kconfig-shared.orig linux/arch/mips/Kconfig-shared
--- linux/arch/mips/Kconfig-shared.orig	Thu Feb 13 11:37:29 2003
+++ linux/arch/mips/Kconfig-shared	Thu Feb 13 12:26:08 2003
@@ -1547,7 +1547,7 @@
 
 config REMOTE_DEBUG
 	bool "Remote GDB kernel debugging"
-	depends on DEBUG_KERNEL && (AU1000_UART || ZS=y)
+	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, it will be possible to remotely debug the MIPS
 	  kernel using gdb. This enlarges your kernel image disk size by
@@ -1566,6 +1566,12 @@
 config DEBUG
 	bool "Enable run-time debugging"
 	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, some debugging macros will do run-time checking.
+	  If you say N here, those macros will mostly turn to no-ops.  For
+	  MIPS boards only.  See include/asm-mips/debug.h for debuging macros.
+	  If unsure, say N.
+
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"

--KFztAG8eRSV9hGtP--
