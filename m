Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 19:22:04 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1533 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225470AbUAOTWD>;
	Thu, 15 Jan 2004 19:22:03 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0FJM1C21272;
	Thu, 15 Jan 2004 11:22:01 -0800
Date: Thu, 15 Jan 2004 11:22:01 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH 2.6] DEBUG_INFO, KGDB and etc...
Message-ID: <20040115112201.E18368@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch adds the missing "-g" gcc option when kgdb is configure.
Clean up some debugging related options (DEBUG_INFO really should
go under KGDB and depends its not being selected)

If no objection, will check it in later.

And yes, the good news is that kgdb works in 2.6.

Jun

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk1

diff -Nru link/arch/mips/Makefile.orig link/arch/mips/Makefile
--- link/arch/mips/Makefile.orig	Thu Jan 15 10:55:57 2004
+++ link/arch/mips/Makefile	Thu Jan 15 10:59:19 2004
@@ -60,6 +60,7 @@
 LDFLAGS_vmlinux			+= -G 0 -static # -N
 MODFLAGS			+= -mlong-calls
 
+cflags-$(CONFIG_DEBUG_INFO)     += -g
 cflags-$(CONFIG_SB1XXX_CORELIS)	+= -mno-sched-prolog -fno-omit-frame-pointer
 
 check_warning = $(shell if $(CC) $(1) -c -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
diff -Nru link/arch/mips/Kconfig.orig link/arch/mips/Kconfig
--- link/arch/mips/Kconfig.orig	Thu Jan 15 10:55:57 2004
+++ link/arch/mips/Kconfig	Thu Jan 15 11:12:23 2004
@@ -1233,23 +1233,6 @@
 	  This allows applications to run more reliably even when the system is
 	  under load.
 
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	default y if KGDB
-	help
-	  If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-
-config SB1XXX_CORELIS
-	bool "Corelis Debugger"
-	depends on SIBYTE_SB1xxx_SOC && DEBUG_INFO
-	help
-	  Select compile flags that produce code that can be processed by the
-	  Corelis mksym utility and UDB Emulator.
-
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
 	depends on DEBUG_KERNEL
@@ -1471,6 +1454,7 @@
 config KGDB
 	bool "Remote GDB kernel debugging"
 	depends on DEBUG_KERNEL
+	select DEBUG_INFO
 	help
 	  If you say Y here, it will be possible to remotely debug the MIPS
 	  kernel using gdb. This enlarges your kernel image disk size by
@@ -1486,6 +1470,23 @@
 	  would like kernel messages to be formatted into GDB $O packets so
 	  that GDB prints them as program output, say 'Y'.
 
+config DEBUG_INFO
+	bool "Compile the kernel with debug info"
+	depends on DEBUG_KERNEL && !KGDB
+	default y if KGDB
+	help
+	  If you say Y here the resulting kernel image will include
+	  debugging info resulting in a larger kernel image.
+	  Say Y here only if you plan to use gdb to debug the kernel.
+	  If you don't debug the kernel, you can say N.
+
+config SB1XXX_CORELIS
+	bool "Corelis Debugger"
+	depends on SIBYTE_SB1xxx_SOC && DEBUG_INFO
+	help
+	  Select compile flags that produce code that can be processed by the
+	  Corelis mksym utility and UDB Emulator.
+
 config RUNTIME_DEBUG
 	bool "Enable run-time debugging"
 	depends on DEBUG_KERNEL

--cmJC7u66zC7hs+87--
