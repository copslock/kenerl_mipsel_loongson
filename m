Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2007 13:35:05 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:45443 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021434AbXHOMfD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Aug 2007 13:35:03 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1ILI5R-0005ob-HY; Wed, 15 Aug 2007 14:34:57 +0200
Date:	Wed, 15 Aug 2007 14:34:57 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH -mm][MIPS] Add CFE support to BCM947xx code
Message-ID: <20070815123457.GB22291@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below adds CFE support to the BCM947xx code. That includes
querying CFE environment variables as well as using CFE to print 
messages before the serial port is initialized (early printk).

Signed-off-by: Aurelien Jarno <aurel32@farad.aurel32.net>

--- a/arch/mips/bcm947xx/prom.c
+++ b/arch/mips/bcm947xx/prom.c
@@ -1,5 +1,6 @@
 /*
  *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
+ *  Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -23,18 +24,117 @@
  */
 
 #include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
 #include <asm/bootinfo.h>
+#include <asm/cfe/cfe_api.h>
+#include <asm/cfe/cfe_error.h>
+
+static int cfe_cons_handle;
 
 const char *get_system_type(void)
 {
 	return "Broadcom BCM947xx";
 }
 
-void __init prom_init(void)
+void prom_putchar(char c)
+{
+	while (cfe_write(cfe_cons_handle, &c, 1) == 0)
+		;
+}
+
+static __init void prom_init_cfe(void)
+{
+	uint32_t cfe_ept;
+	uint32_t cfe_handle;
+	uint32_t cfe_eptseal;
+	int argc = fw_arg0;
+	char **envp = (char **) fw_arg2;
+	int *prom_vec = (int *) fw_arg3;
+
+	/*
+	 * Check if a loader was used; if NOT, the 4 arguments are
+	 * what CFE gives us (handle, 0, EPT and EPTSEAL)
+	 */
+	if (argc < 0) {
+		cfe_handle = (uint32_t)argc;
+		cfe_ept = (uint32_t)envp;
+		cfe_eptseal = (uint32_t)prom_vec;
+	} else {
+		if ((int)prom_vec < 0) {
+			/*
+			 * Old loader; all it gives us is the handle,
+			 * so use the "known" entrypoint and assume
+			 * the seal.
+			 */
+			cfe_handle = (uint32_t)prom_vec;
+			cfe_ept = 0xBFC00500;
+			cfe_eptseal = CFE_EPTSEAL;
+		} else {
+			/*
+			 * Newer loaders bundle the handle/ept/eptseal
+			 * Note: prom_vec is in the loader's useg
+			 * which is still alive in the TLB.
+			 */
+			cfe_handle = prom_vec[0];
+			cfe_ept = prom_vec[2];
+			cfe_eptseal = prom_vec[3];
+		}
+	}
+
+	if (cfe_eptseal != CFE_EPTSEAL) {
+		/* too early for panic to do any good */
+		printk(KERN_ERR "CFE's entrypoint seal doesn't match.");
+		while (1) ;
+	}
+
+	cfe_init(cfe_handle, cfe_ept);
+}
+
+static __init void prom_init_console(void)
+{
+	/* Initialize CFE console */
+	cfe_cons_handle = cfe_getstdhandle(CFE_STDHANDLE_CONSOLE);
+}
+
+static __init void prom_init_cmdline(void)
+{
+	char buf[CL_SIZE];
+
+	/* Get the kernel command line from CFE */
+	if (cfe_getenv("LINUX_CMDLINE", buf, CL_SIZE) >= 0) {
+		buf[CL_SIZE-1] = 0;
+		strcpy(arcs_cmdline, buf);
+	}
+
+	/* Force a console handover by adding a console= argument if needed,
+	 * as CFE is not available anymore later in the boot process. */
+	if ((strstr(arcs_cmdline, "console=")) == NULL) {
+		/* Try to read the default serial port used by CFE */
+		if ((cfe_getenv("BOOT_CONSOLE", buf, CL_SIZE) < 0)
+		    || (strncmp("uart", buf, 4)))
+			/* Default to uart0 */
+			strcpy(buf, "uart0");
+
+		/* Compute the new command line */
+		snprintf(arcs_cmdline, CL_SIZE, "%s console=ttyS%c,115200",
+			 arcs_cmdline, buf[4]);
+	}
+}
+
+static __init void prom_init_mem(void)
 {
 	unsigned long mem;
 
-	/* Figure out memory size by finding aliases */
+	/* Figure out memory size by finding aliases.
+	 *
+	 * We should theoretically use the mapping from CFE using cfe_enummem().
+	 * However as the BCM947xx is mostly used on low-memory systems, we
+	 * want to reuse the memory used by CFE (around 4MB). That means cfe_*
+	 * functions stop to work at some point during the boot, we should only
+	 * call them at the beginning of the boot.
+	 */
 	for (mem = (1 << 20); mem < (128 << 20); mem += (1 << 20)) {
 		if (*(unsigned long *)((unsigned long)(prom_init) + mem) ==
 		    *(unsigned long *)(prom_init))
@@ -44,6 +145,15 @@
 	add_memory_region(0, mem, BOOT_MEM_RAM);
 }
 
+void __init prom_init(void)
+{
+	prom_init_cfe();
+	prom_init_console();
+	prom_init_cmdline();
+	prom_init_mem();
+}
+
 void __init prom_free_prom_memory(void)
 {
 }
+
--- a/arch/mips/bcm947xx/setup.c
+++ b/arch/mips/bcm947xx/setup.c
@@ -27,9 +27,11 @@
 
 #include <linux/types.h>
 #include <linux/ssb/ssb.h>
+#include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <bcm947xx.h>
+#include <asm/cfe/cfe_api.h>
 
 struct ssb_bus ssb_bcm947xx;
 EXPORT_SYMBOL(ssb_bcm947xx);
@@ -53,12 +55,55 @@
 		cpu_relax();
 }
 
-static int bcm947xx_get_invariants(struct ssb_bus *bus,
-				   struct ssb_init_invariants *iv)
+static void str2eaddr(char *str, char *dest)
 {
-	/* TODO: fill ssb_init_invariants using boardtype/boardrev
-	 * CFE environment variables.
-	 */
+	int i = 0;
+
+	if (str == NULL) {
+		memset(dest, 0, 6);
+		return;
+	}
+
+	for (;;) {
+		dest[i++] = (char) simple_strtoul(str, NULL, 16);
+		str += 2;
+		if (!*str++ || i == 6)
+			break;
+	}
+}
+
+static int bcm947xx_get_invariants(struct ssb_bus *bus,
+				   struct ssb_init_invariants *iv)
+{
+	char buf[100];
+
+	/* Fill boardinfo structure */
+	memset(&(iv->boardinfo), 0 , sizeof(struct ssb_boardinfo));
+
+	if (cfe_getenv("boardvendor", buf, sizeof(buf)) >= 0)
+		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
+	if (cfe_getenv("boardtype", buf, sizeof(buf)) >= 0)
+		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
+	if (cfe_getenv("boardrev", buf, sizeof(buf)) >= 0)
+		iv->boardinfo.rev = (u16)simple_strtoul(buf, NULL, 0);
+
+	/* Fill sprom structure */
+	memset(&(iv->sprom), 0, sizeof(struct ssb_sprom));
+	iv->sprom.revision = 3;
+
+	if (cfe_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
+		str2eaddr(buf, iv->sprom.r1.et0mac);
+	if (cfe_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
+		str2eaddr(buf, iv->sprom.r1.et1mac);
+	if (cfe_getenv("et0phyaddr", buf, sizeof(buf)) >= 0)
+		iv->sprom.r1.et0phyaddr = simple_strtoul(buf, NULL, 10);
+	if (cfe_getenv("et1phyaddr", buf, sizeof(buf)) >= 0)
+		iv->sprom.r1.et1phyaddr = simple_strtoul(buf, NULL, 10);
+	if (cfe_getenv("et0mdcport", buf, sizeof(buf)) >= 0)
+		iv->sprom.r1.et0mdcport = simple_strtoul(buf, NULL, 10);
+	if (cfe_getenv("et1mdcport", buf, sizeof(buf)) >= 0)
+		iv->sprom.r1.et1mdcport = simple_strtoul(buf, NULL, 10);
+
 	return 0;
 }
 
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -78,6 +78,8 @@
 	select SSB
 	select SSB_DRIVER_MIPS
 	select GENERIC_GPIO
+	select SYS_HAS_EARLY_PRINTK
+	select CFE
 	help
 	 Support for BCM947xx based boards
 

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
