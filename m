Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 00:20:34 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16373 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225571AbUAVAUd>;
	Thu, 22 Jan 2004 00:20:33 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0M0KWQ01655;
	Wed, 21 Jan 2004 16:20:32 -0800
Date: Wed, 21 Jan 2004 16:20:32 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH 2.6] set up conswitchp when CONFIG_VT is set
Message-ID: <20040121162032.F29705@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


conswitchp needs to be set whenever CONFIG_VT is selected.
Currently this job is done individually by each board in its setup
routine, often in a wrong way.

The right thing to do is to set the pointer in the common code
and remove almost two dozens of duplicated and often wrong settings.

The attached patch is for illustration only.  The removal of board settings
is not complete.

Comments?  Objections and cheers are equally welcome. :)

Jun

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dummy_console.patch"

diff -Nru linux/arch/mips/ddb5xxx/ddb5074/setup.c.orig linux/arch/mips/ddb5xxx/ddb5074/setup.c
--- linux/arch/mips/ddb5xxx/ddb5074/setup.c.orig	Mon Jan  5 10:33:34 2004
+++ linux/arch/mips/ddb5xxx/ddb5074/setup.c	Wed Jan 21 16:03:33 2004
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
 #include <linux/types.h>
-#include <linux/console.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
 #include <linux/ide.h>
@@ -113,10 +112,6 @@
 	ddb_set_pmr(DDB_PCIINIT0, DDB_PCICMD_IO, 0, 0x10);
 	ddb_set_pmr(DDB_PCIINIT1, DDB_PCICMD_MEM, DDB_PCI_MEM_BASE , 0x10);
 
-#ifdef CONFIG_FB
-	conswitchp = &dummy_con;
-#endif
-
 	/* Reboot on panic */
 	panic_timeout = 180;
 }
diff -Nru linux/arch/mips/ddb5xxx/ddb5476/setup.c.orig linux/arch/mips/ddb5xxx/ddb5476/setup.c
--- linux/arch/mips/ddb5xxx/ddb5476/setup.c.orig	Mon Jan  5 10:33:34 2004
+++ linux/arch/mips/ddb5xxx/ddb5476/setup.c	Wed Jan 21 16:03:50 2004
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
 #include <linux/types.h>
-#include <linux/console.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
 
@@ -166,10 +165,6 @@
 	/* [jsun] we need to set BAR0 so that SDRAM 0 appears at 0x0 in PCI */
 	/* *(long*)0xbfa00218 = 0x8; */
 
-#ifdef CONFIG_FB
-	conswitchp = &dummy_con;
-#endif
-
 	/* board initialization stuff */
 	ddb5476_board_init();
 }
diff -Nru linux/arch/mips/kernel/setup.c.orig linux/arch/mips/kernel/setup.c
--- linux/arch/mips/kernel/setup.c.orig	Tue Nov 18 10:01:24 2003
+++ linux/arch/mips/kernel/setup.c	Wed Jan 21 16:00:47 2004
@@ -32,6 +32,7 @@
 #include <linux/kdev_t.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
+#include <linux/console.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -471,6 +472,15 @@
 	set_c0_status(ST0_CU0|ST0_KX|ST0_SX|ST0_FR);
 #endif
 
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+        conswitchp = &vga_con;
+#elif defined(CONFIG_DUMMY_CONSOLE)
+        conswitchp = &dummy_con;
+#endif
+#endif
+
+	/* call board setup routine */
 	do_earlyinitcalls();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));

--V0207lvV8h4k8FAm--
