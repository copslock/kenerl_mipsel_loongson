Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 13:22:34 +0100 (WEST)
Received: from arrakis.dune.hu ([195.56.146.235]:57258 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022024AbZFBMWJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 13:22:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id 28FC023C0108
	for <linux-mips@linux-mips.org>; Tue,  2 Jun 2009 14:22:09 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6cHRFhyUNBk for <linux-mips@linux-mips.org>;
	Tue,  2 Jun 2009 14:22:06 +0200 (CEST)
Received: by arrakis.dune.hu (Postfix, from userid 1000)
	id 55B7A23C013F; Tue,  2 Jun 2009 14:22:06 +0200 (CEST)
From:	Imre Kaloz <kaloz@openwrt.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Remove standalone SiByte kernel support
Date:	Tue,  2 Jun 2009 14:22:06 +0200
Message-Id: <1243945326-5029-1-git-send-email-kaloz@openwrt.org>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <kaloz@arrakis.dune.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
X-list: linux-mips

CFE is the only supported and used bootloader on the SiByte boards,
the standalone kernel support has been never used outside Broadcom.
Remove it and make the kernel use CFE by default.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/Makefile                    |    1 -
 arch/mips/sibyte/Kconfig              |   24 +--
 arch/mips/sibyte/cfe/Makefile         |    2 -
 arch/mips/sibyte/cfe/console.c        |   79 --------
 arch/mips/sibyte/cfe/setup.c          |  350 ---------------------------------
 arch/mips/sibyte/common/Makefile      |    4 +-
 arch/mips/sibyte/common/cfe.c         |  350 +++++++++++++++++++++++++++++++++
 arch/mips/sibyte/common/cfe_console.c |   79 ++++++++
 arch/mips/sibyte/sb1250/Makefile      |    1 -
 arch/mips/sibyte/sb1250/prom.c        |   96 ---------
 arch/mips/sibyte/swarm/setup.c        |   10 -
 11 files changed, 434 insertions(+), 562 deletions(-)
 delete mode 100644 arch/mips/sibyte/cfe/Makefile
 delete mode 100644 arch/mips/sibyte/cfe/console.c
 delete mode 100644 arch/mips/sibyte/cfe/setup.c
 create mode 100644 arch/mips/sibyte/common/cfe.c
 create mode 100644 arch/mips/sibyte/common/cfe_console.c
 delete mode 100644 arch/mips/sibyte/sb1250/prom.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c4cae9e..52a3509 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -167,7 +167,6 @@ libs-$(CONFIG_ARC)		+= arch/mips/fw/arc/
 libs-$(CONFIG_CFE)		+= arch/mips/fw/cfe/
 libs-$(CONFIG_SNIPROM)		+= arch/mips/fw/sni/
 libs-y				+= arch/mips/fw/lib/
-libs-$(CONFIG_SIBYTE_CFE)	+= arch/mips/sibyte/cfe/
 
 #
 # Board-dependent options and extra files
diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index 989d1a9..3e639bd 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -75,6 +75,8 @@ config SIBYTE_SB1xxx_SOC
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
+	select CFE
+	select SYS_HAS_EARLY_PRINTK
 
 choice
 	prompt "SiByte SOC Stepping"
@@ -136,34 +138,14 @@ config SB1_CERR_STALL
 	bool "Stall (rather than panic) on fatal cache error"
 	depends on SIBYTE_SB1xxx_SOC
 
-config SIBYTE_CFE
-	bool "Booting from CFE"
-	depends on SIBYTE_SB1xxx_SOC
-	select CFE
-	select SYS_HAS_EARLY_PRINTK
-	help
-	  Make use of the CFE API for enumerating available memory,
-	  controlling secondary CPUs, and possibly console output.
-
 config SIBYTE_CFE_CONSOLE
 	bool "Use firmware console"
-	depends on SIBYTE_CFE
+	depends on SIBYTE_SB1xxx_SOC
 	help
 	  Use the CFE API's console write routines during boot.  Other console
 	  options (VT console, sb1250 duart console, etc.) should not be
 	  configured.
 
-config SIBYTE_STANDALONE
-	bool
-	depends on SIBYTE_SB1xxx_SOC && !SIBYTE_CFE
-	select SYS_HAS_EARLY_PRINTK
-	default y
-
-config SIBYTE_STANDALONE_RAM_SIZE
-	int "Memory size (in megabytes)"
-	depends on SIBYTE_STANDALONE
-	default "32"
-
 config SIBYTE_BUS_WATCHER
 	bool "Support for Bus Watcher statistics"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/arch/mips/sibyte/cfe/Makefile b/arch/mips/sibyte/cfe/Makefile
deleted file mode 100644
index 02b32e1..0000000
--- a/arch/mips/sibyte/cfe/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-lib-y					= setup.o
-lib-$(CONFIG_SIBYTE_CFE_CONSOLE)	+= console.o
diff --git a/arch/mips/sibyte/cfe/console.c b/arch/mips/sibyte/cfe/console.c
deleted file mode 100644
index 81e3d54..0000000
--- a/arch/mips/sibyte/cfe/console.c
+++ /dev/null
@@ -1,79 +0,0 @@
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/console.h>
-
-#include <asm/sibyte/board.h>
-
-#include <asm/fw/cfe/cfe_api.h>
-#include <asm/fw/cfe/cfe_error.h>
-
-extern int cfe_cons_handle;
-
-static void cfe_console_write(struct console *cons, const char *str,
-		       unsigned int count)
-{
-	int i, last, written;
-
-	for (i=0, last=0; i<count; i++) {
-		if (!str[i])
-			/* XXXKW can/should this ever happen? */
-			return;
-		if (str[i] == '\n') {
-			do {
-				written = cfe_write(cfe_cons_handle, &str[last], i-last);
-				if (written < 0)
-					;
-				last += written;
-			} while (last < i);
-			while (cfe_write(cfe_cons_handle, "\r", 1) <= 0)
-				;
-		}
-	}
-	if (last != count) {
-		do {
-			written = cfe_write(cfe_cons_handle, &str[last], count-last);
-			if (written < 0)
-				;
-			last += written;
-		} while (last < count);
-	}
-
-}
-
-static int cfe_console_setup(struct console *cons, char *str)
-{
-	char consdev[32];
-	/* XXXKW think about interaction with 'console=' cmdline arg */
-	/* If none of the console options are configured, the build will break. */
-	if (cfe_getenv("BOOT_CONSOLE", consdev, 32) >= 0) {
-#ifdef CONFIG_SERIAL_SB1250_DUART
-		if (!strcmp(consdev, "uart0")) {
-			setleds("u0cn");
-		} else if (!strcmp(consdev, "uart1")) {
-			setleds("u1cn");
-#endif
-#ifdef CONFIG_VGA_CONSOLE
-		} else if (!strcmp(consdev, "pcconsole0")) {
-			setleds("pccn");
-#endif
-		} else
-			return -ENODEV;
-	}
-	return 0;
-}
-
-static struct console sb1250_cfe_cons = {
-	.name		= "cfe",
-	.write		= cfe_console_write,
-	.setup		= cfe_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-};
-
-static int __init sb1250_cfe_console_init(void)
-{
-	register_console(&sb1250_cfe_cons);
-	return 0;
-}
-
-console_initcall(sb1250_cfe_console_init);
diff --git a/arch/mips/sibyte/cfe/setup.c b/arch/mips/sibyte/cfe/setup.c
deleted file mode 100644
index 3de30f7..0000000
--- a/arch/mips/sibyte/cfe/setup.c
+++ /dev/null
@@ -1,350 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002, 2003 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/linkage.h>
-#include <linux/mm.h>
-#include <linux/blkdev.h>
-#include <linux/bootmem.h>
-#include <linux/pm.h>
-#include <linux/smp.h>
-
-#include <asm/bootinfo.h>
-#include <asm/reboot.h>
-#include <asm/sibyte/board.h>
-#include <asm/smp-ops.h>
-
-#include <asm/fw/cfe/cfe_api.h>
-#include <asm/fw/cfe/cfe_error.h>
-
-/* Max ram addressable in 32-bit segments */
-#ifdef CONFIG_64BIT
-#define MAX_RAM_SIZE (~0ULL)
-#else
-#ifdef CONFIG_HIGHMEM
-#ifdef CONFIG_64BIT_PHYS_ADDR
-#define MAX_RAM_SIZE (~0ULL)
-#else
-#define MAX_RAM_SIZE (0xffffffffULL)
-#endif
-#else
-#define MAX_RAM_SIZE (0x1fffffffULL)
-#endif
-#endif
-
-#define SIBYTE_MAX_MEM_REGIONS 8
-phys_t board_mem_region_addrs[SIBYTE_MAX_MEM_REGIONS];
-phys_t board_mem_region_sizes[SIBYTE_MAX_MEM_REGIONS];
-unsigned int board_mem_region_count;
-
-int cfe_cons_handle;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-#endif
-
-static void __noreturn cfe_linux_exit(void *arg)
-{
-	int warm = *(int *)arg;
-
-	if (smp_processor_id()) {
-		static int reboot_smp;
-
-		/* Don't repeat the process from another CPU */
-		if (!reboot_smp) {
-			/* Get CPU 0 to do the cfe_exit */
-			reboot_smp = 1;
-			smp_call_function(cfe_linux_exit, arg, 0);
-		}
-	} else {
-		printk("Passing control back to CFE...\n");
-		cfe_exit(warm, 0);
-		printk("cfe_exit returned??\n");
-	}
-	while (1);
-}
-
-static void __noreturn cfe_linux_restart(char *command)
-{
-	static const int zero;
-
-	cfe_linux_exit((void *)&zero);
-}
-
-static void __noreturn cfe_linux_halt(void)
-{
-	static const int one = 1;
-
-	cfe_linux_exit((void *)&one);
-}
-
-static __init void prom_meminit(void)
-{
-	u64 addr, size, type; /* regardless of 64BIT_PHYS_ADDR */
-	int mem_flags = 0;
-	unsigned int idx;
-	int rd_flag;
-#ifdef CONFIG_BLK_DEV_INITRD
-	unsigned long initrd_pstart;
-	unsigned long initrd_pend;
-
-	initrd_pstart = CPHYSADDR(initrd_start);
-	initrd_pend = CPHYSADDR(initrd_end);
-	if (initrd_start &&
-	    ((initrd_pstart > MAX_RAM_SIZE)
-	     || (initrd_pend > MAX_RAM_SIZE))) {
-		panic("initrd out of addressable memory");
-	}
-
-#endif /* INITRD */
-
-	for (idx = 0; cfe_enummem(idx, mem_flags, &addr, &size, &type) != CFE_ERR_NOMORE;
-	     idx++) {
-		rd_flag = 0;
-		if (type == CFE_MI_AVAILABLE) {
-			/*
-			 * See if this block contains (any portion of) the
-			 * ramdisk
-			 */
-#ifdef CONFIG_BLK_DEV_INITRD
-			if (initrd_start) {
-				if ((initrd_pstart > addr) &&
-				    (initrd_pstart < (addr + size))) {
-					add_memory_region(addr,
-					                  initrd_pstart - addr,
-					                  BOOT_MEM_RAM);
-					rd_flag = 1;
-				}
-				if ((initrd_pend > addr) &&
-				    (initrd_pend < (addr + size))) {
-					add_memory_region(initrd_pend,
-						(addr + size) - initrd_pend,
-						 BOOT_MEM_RAM);
-					rd_flag = 1;
-				}
-			}
-#endif
-			if (!rd_flag) {
-				if (addr > MAX_RAM_SIZE)
-					continue;
-				if (addr+size > MAX_RAM_SIZE)
-					size = MAX_RAM_SIZE - (addr+size) + 1;
-				/*
-				 * memcpy/__copy_user prefetch, which
-				 * will cause a bus error for
-				 * KSEG/KUSEG addrs not backed by RAM.
-				 * Hence, reserve some padding for the
-				 * prefetch distance.
-				 */
-				if (size > 512)
-					size -= 512;
-				add_memory_region(addr, size, BOOT_MEM_RAM);
-			}
-			board_mem_region_addrs[board_mem_region_count] = addr;
-			board_mem_region_sizes[board_mem_region_count] = size;
-			board_mem_region_count++;
-			if (board_mem_region_count ==
-			    SIBYTE_MAX_MEM_REGIONS) {
-				/*
-				 * Too many regions.  Need to configure more
-				 */
-				while(1);
-			}
-		}
-	}
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		add_memory_region(initrd_pstart, initrd_pend - initrd_pstart,
-				  BOOT_MEM_RESERVED);
-	}
-#endif
-}
-
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init initrd_setup(char *str)
-{
-	char rdarg[64];
-	int idx;
-	char *tmp, *endptr;
-	unsigned long initrd_size;
-
-	/* Make a copy of the initrd argument so we can smash it up here */
-	for (idx = 0; idx < sizeof(rdarg)-1; idx++) {
-		if (!str[idx] || (str[idx] == ' ')) break;
-		rdarg[idx] = str[idx];
-	}
-
-	rdarg[idx] = 0;
-	str = rdarg;
-
-	/*
-	 *Initrd location comes in the form "<hex size of ramdisk in bytes>@<location in memory>"
-	 *  e.g. initrd=3abfd@80010000.  This is set up by the loader.
-	 */
-	for (tmp = str; *tmp != '@'; tmp++) {
-		if (!*tmp) {
-			goto fail;
-		}
-	}
-	*tmp = 0;
-	tmp++;
-	if (!*tmp) {
-		goto fail;
-	}
-	initrd_size = simple_strtoul(str, &endptr, 16);
-	if (*endptr) {
-		*(tmp-1) = '@';
-		goto fail;
-	}
-	*(tmp-1) = '@';
-	initrd_start = simple_strtoul(tmp, &endptr, 16);
-	if (*endptr) {
-		goto fail;
-	}
-	initrd_end = initrd_start + initrd_size;
-	printk("Found initrd of %lx@%lx\n", initrd_size, initrd_start);
-	return 1;
- fail:
-	printk("Bad initrd argument.  Disabling initrd\n");
-	initrd_start = 0;
-	initrd_end = 0;
-	return 1;
-}
-
-#endif
-
-extern struct plat_smp_ops sb_smp_ops;
-extern struct plat_smp_ops bcm1480_smp_ops;
-
-/*
- * prom_init is called just after the cpu type is determined, from setup_arch()
- */
-void __init prom_init(void)
-{
-	uint64_t cfe_ept, cfe_handle;
-	unsigned int cfe_eptseal;
-	int argc = fw_arg0;
-	char **envp = (char **) fw_arg2;
-	int *prom_vec = (int *) fw_arg3;
-
-	_machine_restart   = cfe_linux_restart;
-	_machine_halt      = cfe_linux_halt;
-	pm_power_off = cfe_linux_halt;
-
-	/*
-	 * Check if a loader was used; if NOT, the 4 arguments are
-	 * what CFE gives us (handle, 0, EPT and EPTSEAL)
-	 */
-	if (argc < 0) {
-		cfe_handle = (uint64_t)(long)argc;
-		cfe_ept = (long)envp;
-		cfe_eptseal = (uint32_t)(unsigned long)prom_vec;
-	} else {
-		if ((int32_t)(long)prom_vec < 0) {
-			/*
-			 * Old loader; all it gives us is the handle,
-			 * so use the "known" entrypoint and assume
-			 * the seal.
-			 */
-			cfe_handle = (uint64_t)(long)prom_vec;
-			cfe_ept = (uint64_t)((int32_t)0x9fc00500);
-			cfe_eptseal = CFE_EPTSEAL;
-		} else {
-			/*
-			 * Newer loaders bundle the handle/ept/eptseal
-			 * Note: prom_vec is in the loader's useg
-			 * which is still alive in the TLB.
-			 */
-			cfe_handle = (uint64_t)((int32_t *)prom_vec)[0];
-			cfe_ept = (uint64_t)((int32_t *)prom_vec)[2];
-			cfe_eptseal = (unsigned int)((uint32_t *)prom_vec)[3];
-		}
-	}
-	if (cfe_eptseal != CFE_EPTSEAL) {
-		/* too early for panic to do any good */
-		printk("CFE's entrypoint seal doesn't match. Spinning.");
-		while (1) ;
-	}
-	cfe_init(cfe_handle, cfe_ept);
-	/*
-	 * Get the handle for (at least) prom_putchar, possibly for
-	 * boot console
-	 */
-	cfe_cons_handle = cfe_getstdhandle(CFE_STDHANDLE_CONSOLE);
-	if (cfe_getenv("LINUX_CMDLINE", arcs_cmdline, CL_SIZE) < 0) {
-		if (argc < 0) {
-			/*
-			 * It's OK for direct boot to not provide a
-			 *  command line
-			 */
-			strcpy(arcs_cmdline, "root=/dev/ram0 ");
-		} else {
-			/* The loader should have set the command line */
-			/* too early for panic to do any good */
-			printk("LINUX_CMDLINE not defined in cfe.");
-			while (1) ;
-		}
-	}
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	{
-		char *ptr;
-		/* Need to find out early whether we've got an initrd.  So scan
-		   the list looking now */
-		for (ptr = arcs_cmdline; *ptr; ptr++) {
-			while (*ptr == ' ') {
-				ptr++;
-			}
-			if (!strncmp(ptr, "initrd=", 7)) {
-				initrd_setup(ptr+7);
-				break;
-			} else {
-				while (*ptr && (*ptr != ' ')) {
-					ptr++;
-				}
-			}
-		}
-	}
-#endif /* CONFIG_BLK_DEV_INITRD */
-
-	/* Not sure this is needed, but it's the safe way. */
-	arcs_cmdline[CL_SIZE-1] = 0;
-
-	prom_meminit();
-
-#if defined(CONFIG_SIBYTE_BCM112X) || defined(CONFIG_SIBYTE_SB1250)
-	register_smp_ops(&sb_smp_ops);
-#endif
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
-	register_smp_ops(&bcm1480_smp_ops);
-#endif
-}
-
-void __init prom_free_prom_memory(void)
-{
-	/* Not sure what I'm supposed to do here.  Nothing, I think */
-}
-
-void prom_putchar(char c)
-{
-	int ret;
-
-	while ((ret = cfe_write(cfe_cons_handle, &c, 1)) == 0)
-		;
-}
diff --git a/arch/mips/sibyte/common/Makefile b/arch/mips/sibyte/common/Makefile
index 48a91b9..4f65983 100644
--- a/arch/mips/sibyte/common/Makefile
+++ b/arch/mips/sibyte/common/Makefile
@@ -1,5 +1,5 @@
-obj-y :=
-
+obj-y := cfe.o
+obj-$(CONFIG_SIBYTE_CFE_CONSOLE)	+= cfe_console.o
 obj-$(CONFIG_SIBYTE_TBPROF)		+= sb_tbprof.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
new file mode 100644
index 0000000..3de30f7
--- /dev/null
+++ b/arch/mips/sibyte/common/cfe.c
@@ -0,0 +1,350 @@
+/*
+ * Copyright (C) 2000, 2001, 2002, 2003 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/blkdev.h>
+#include <linux/bootmem.h>
+#include <linux/pm.h>
+#include <linux/smp.h>
+
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/sibyte/board.h>
+#include <asm/smp-ops.h>
+
+#include <asm/fw/cfe/cfe_api.h>
+#include <asm/fw/cfe/cfe_error.h>
+
+/* Max ram addressable in 32-bit segments */
+#ifdef CONFIG_64BIT
+#define MAX_RAM_SIZE (~0ULL)
+#else
+#ifdef CONFIG_HIGHMEM
+#ifdef CONFIG_64BIT_PHYS_ADDR
+#define MAX_RAM_SIZE (~0ULL)
+#else
+#define MAX_RAM_SIZE (0xffffffffULL)
+#endif
+#else
+#define MAX_RAM_SIZE (0x1fffffffULL)
+#endif
+#endif
+
+#define SIBYTE_MAX_MEM_REGIONS 8
+phys_t board_mem_region_addrs[SIBYTE_MAX_MEM_REGIONS];
+phys_t board_mem_region_sizes[SIBYTE_MAX_MEM_REGIONS];
+unsigned int board_mem_region_count;
+
+int cfe_cons_handle;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+extern unsigned long initrd_start, initrd_end;
+#endif
+
+static void __noreturn cfe_linux_exit(void *arg)
+{
+	int warm = *(int *)arg;
+
+	if (smp_processor_id()) {
+		static int reboot_smp;
+
+		/* Don't repeat the process from another CPU */
+		if (!reboot_smp) {
+			/* Get CPU 0 to do the cfe_exit */
+			reboot_smp = 1;
+			smp_call_function(cfe_linux_exit, arg, 0);
+		}
+	} else {
+		printk("Passing control back to CFE...\n");
+		cfe_exit(warm, 0);
+		printk("cfe_exit returned??\n");
+	}
+	while (1);
+}
+
+static void __noreturn cfe_linux_restart(char *command)
+{
+	static const int zero;
+
+	cfe_linux_exit((void *)&zero);
+}
+
+static void __noreturn cfe_linux_halt(void)
+{
+	static const int one = 1;
+
+	cfe_linux_exit((void *)&one);
+}
+
+static __init void prom_meminit(void)
+{
+	u64 addr, size, type; /* regardless of 64BIT_PHYS_ADDR */
+	int mem_flags = 0;
+	unsigned int idx;
+	int rd_flag;
+#ifdef CONFIG_BLK_DEV_INITRD
+	unsigned long initrd_pstart;
+	unsigned long initrd_pend;
+
+	initrd_pstart = CPHYSADDR(initrd_start);
+	initrd_pend = CPHYSADDR(initrd_end);
+	if (initrd_start &&
+	    ((initrd_pstart > MAX_RAM_SIZE)
+	     || (initrd_pend > MAX_RAM_SIZE))) {
+		panic("initrd out of addressable memory");
+	}
+
+#endif /* INITRD */
+
+	for (idx = 0; cfe_enummem(idx, mem_flags, &addr, &size, &type) != CFE_ERR_NOMORE;
+	     idx++) {
+		rd_flag = 0;
+		if (type == CFE_MI_AVAILABLE) {
+			/*
+			 * See if this block contains (any portion of) the
+			 * ramdisk
+			 */
+#ifdef CONFIG_BLK_DEV_INITRD
+			if (initrd_start) {
+				if ((initrd_pstart > addr) &&
+				    (initrd_pstart < (addr + size))) {
+					add_memory_region(addr,
+					                  initrd_pstart - addr,
+					                  BOOT_MEM_RAM);
+					rd_flag = 1;
+				}
+				if ((initrd_pend > addr) &&
+				    (initrd_pend < (addr + size))) {
+					add_memory_region(initrd_pend,
+						(addr + size) - initrd_pend,
+						 BOOT_MEM_RAM);
+					rd_flag = 1;
+				}
+			}
+#endif
+			if (!rd_flag) {
+				if (addr > MAX_RAM_SIZE)
+					continue;
+				if (addr+size > MAX_RAM_SIZE)
+					size = MAX_RAM_SIZE - (addr+size) + 1;
+				/*
+				 * memcpy/__copy_user prefetch, which
+				 * will cause a bus error for
+				 * KSEG/KUSEG addrs not backed by RAM.
+				 * Hence, reserve some padding for the
+				 * prefetch distance.
+				 */
+				if (size > 512)
+					size -= 512;
+				add_memory_region(addr, size, BOOT_MEM_RAM);
+			}
+			board_mem_region_addrs[board_mem_region_count] = addr;
+			board_mem_region_sizes[board_mem_region_count] = size;
+			board_mem_region_count++;
+			if (board_mem_region_count ==
+			    SIBYTE_MAX_MEM_REGIONS) {
+				/*
+				 * Too many regions.  Need to configure more
+				 */
+				while(1);
+			}
+		}
+	}
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start) {
+		add_memory_region(initrd_pstart, initrd_pend - initrd_pstart,
+				  BOOT_MEM_RESERVED);
+	}
+#endif
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+static int __init initrd_setup(char *str)
+{
+	char rdarg[64];
+	int idx;
+	char *tmp, *endptr;
+	unsigned long initrd_size;
+
+	/* Make a copy of the initrd argument so we can smash it up here */
+	for (idx = 0; idx < sizeof(rdarg)-1; idx++) {
+		if (!str[idx] || (str[idx] == ' ')) break;
+		rdarg[idx] = str[idx];
+	}
+
+	rdarg[idx] = 0;
+	str = rdarg;
+
+	/*
+	 *Initrd location comes in the form "<hex size of ramdisk in bytes>@<location in memory>"
+	 *  e.g. initrd=3abfd@80010000.  This is set up by the loader.
+	 */
+	for (tmp = str; *tmp != '@'; tmp++) {
+		if (!*tmp) {
+			goto fail;
+		}
+	}
+	*tmp = 0;
+	tmp++;
+	if (!*tmp) {
+		goto fail;
+	}
+	initrd_size = simple_strtoul(str, &endptr, 16);
+	if (*endptr) {
+		*(tmp-1) = '@';
+		goto fail;
+	}
+	*(tmp-1) = '@';
+	initrd_start = simple_strtoul(tmp, &endptr, 16);
+	if (*endptr) {
+		goto fail;
+	}
+	initrd_end = initrd_start + initrd_size;
+	printk("Found initrd of %lx@%lx\n", initrd_size, initrd_start);
+	return 1;
+ fail:
+	printk("Bad initrd argument.  Disabling initrd\n");
+	initrd_start = 0;
+	initrd_end = 0;
+	return 1;
+}
+
+#endif
+
+extern struct plat_smp_ops sb_smp_ops;
+extern struct plat_smp_ops bcm1480_smp_ops;
+
+/*
+ * prom_init is called just after the cpu type is determined, from setup_arch()
+ */
+void __init prom_init(void)
+{
+	uint64_t cfe_ept, cfe_handle;
+	unsigned int cfe_eptseal;
+	int argc = fw_arg0;
+	char **envp = (char **) fw_arg2;
+	int *prom_vec = (int *) fw_arg3;
+
+	_machine_restart   = cfe_linux_restart;
+	_machine_halt      = cfe_linux_halt;
+	pm_power_off = cfe_linux_halt;
+
+	/*
+	 * Check if a loader was used; if NOT, the 4 arguments are
+	 * what CFE gives us (handle, 0, EPT and EPTSEAL)
+	 */
+	if (argc < 0) {
+		cfe_handle = (uint64_t)(long)argc;
+		cfe_ept = (long)envp;
+		cfe_eptseal = (uint32_t)(unsigned long)prom_vec;
+	} else {
+		if ((int32_t)(long)prom_vec < 0) {
+			/*
+			 * Old loader; all it gives us is the handle,
+			 * so use the "known" entrypoint and assume
+			 * the seal.
+			 */
+			cfe_handle = (uint64_t)(long)prom_vec;
+			cfe_ept = (uint64_t)((int32_t)0x9fc00500);
+			cfe_eptseal = CFE_EPTSEAL;
+		} else {
+			/*
+			 * Newer loaders bundle the handle/ept/eptseal
+			 * Note: prom_vec is in the loader's useg
+			 * which is still alive in the TLB.
+			 */
+			cfe_handle = (uint64_t)((int32_t *)prom_vec)[0];
+			cfe_ept = (uint64_t)((int32_t *)prom_vec)[2];
+			cfe_eptseal = (unsigned int)((uint32_t *)prom_vec)[3];
+		}
+	}
+	if (cfe_eptseal != CFE_EPTSEAL) {
+		/* too early for panic to do any good */
+		printk("CFE's entrypoint seal doesn't match. Spinning.");
+		while (1) ;
+	}
+	cfe_init(cfe_handle, cfe_ept);
+	/*
+	 * Get the handle for (at least) prom_putchar, possibly for
+	 * boot console
+	 */
+	cfe_cons_handle = cfe_getstdhandle(CFE_STDHANDLE_CONSOLE);
+	if (cfe_getenv("LINUX_CMDLINE", arcs_cmdline, CL_SIZE) < 0) {
+		if (argc < 0) {
+			/*
+			 * It's OK for direct boot to not provide a
+			 *  command line
+			 */
+			strcpy(arcs_cmdline, "root=/dev/ram0 ");
+		} else {
+			/* The loader should have set the command line */
+			/* too early for panic to do any good */
+			printk("LINUX_CMDLINE not defined in cfe.");
+			while (1) ;
+		}
+	}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	{
+		char *ptr;
+		/* Need to find out early whether we've got an initrd.  So scan
+		   the list looking now */
+		for (ptr = arcs_cmdline; *ptr; ptr++) {
+			while (*ptr == ' ') {
+				ptr++;
+			}
+			if (!strncmp(ptr, "initrd=", 7)) {
+				initrd_setup(ptr+7);
+				break;
+			} else {
+				while (*ptr && (*ptr != ' ')) {
+					ptr++;
+				}
+			}
+		}
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	/* Not sure this is needed, but it's the safe way. */
+	arcs_cmdline[CL_SIZE-1] = 0;
+
+	prom_meminit();
+
+#if defined(CONFIG_SIBYTE_BCM112X) || defined(CONFIG_SIBYTE_SB1250)
+	register_smp_ops(&sb_smp_ops);
+#endif
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+	register_smp_ops(&bcm1480_smp_ops);
+#endif
+}
+
+void __init prom_free_prom_memory(void)
+{
+	/* Not sure what I'm supposed to do here.  Nothing, I think */
+}
+
+void prom_putchar(char c)
+{
+	int ret;
+
+	while ((ret = cfe_write(cfe_cons_handle, &c, 1)) == 0)
+		;
+}
diff --git a/arch/mips/sibyte/common/cfe_console.c b/arch/mips/sibyte/common/cfe_console.c
new file mode 100644
index 0000000..81e3d54
--- /dev/null
+++ b/arch/mips/sibyte/common/cfe_console.c
@@ -0,0 +1,79 @@
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/console.h>
+
+#include <asm/sibyte/board.h>
+
+#include <asm/fw/cfe/cfe_api.h>
+#include <asm/fw/cfe/cfe_error.h>
+
+extern int cfe_cons_handle;
+
+static void cfe_console_write(struct console *cons, const char *str,
+		       unsigned int count)
+{
+	int i, last, written;
+
+	for (i=0, last=0; i<count; i++) {
+		if (!str[i])
+			/* XXXKW can/should this ever happen? */
+			return;
+		if (str[i] == '\n') {
+			do {
+				written = cfe_write(cfe_cons_handle, &str[last], i-last);
+				if (written < 0)
+					;
+				last += written;
+			} while (last < i);
+			while (cfe_write(cfe_cons_handle, "\r", 1) <= 0)
+				;
+		}
+	}
+	if (last != count) {
+		do {
+			written = cfe_write(cfe_cons_handle, &str[last], count-last);
+			if (written < 0)
+				;
+			last += written;
+		} while (last < count);
+	}
+
+}
+
+static int cfe_console_setup(struct console *cons, char *str)
+{
+	char consdev[32];
+	/* XXXKW think about interaction with 'console=' cmdline arg */
+	/* If none of the console options are configured, the build will break. */
+	if (cfe_getenv("BOOT_CONSOLE", consdev, 32) >= 0) {
+#ifdef CONFIG_SERIAL_SB1250_DUART
+		if (!strcmp(consdev, "uart0")) {
+			setleds("u0cn");
+		} else if (!strcmp(consdev, "uart1")) {
+			setleds("u1cn");
+#endif
+#ifdef CONFIG_VGA_CONSOLE
+		} else if (!strcmp(consdev, "pcconsole0")) {
+			setleds("pccn");
+#endif
+		} else
+			return -ENODEV;
+	}
+	return 0;
+}
+
+static struct console sb1250_cfe_cons = {
+	.name		= "cfe",
+	.write		= cfe_console_write,
+	.setup		= cfe_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+};
+
+static int __init sb1250_cfe_console_init(void)
+{
+	register_console(&sb1250_cfe_cons);
+	return 0;
+}
+
+console_initcall(sb1250_cfe_console_init);
diff --git a/arch/mips/sibyte/sb1250/Makefile b/arch/mips/sibyte/sb1250/Makefile
index 6977937..1896f4e 100644
--- a/arch/mips/sibyte/sb1250/Makefile
+++ b/arch/mips/sibyte/sb1250/Makefile
@@ -1,7 +1,6 @@
 obj-y := setup.o irq.o time.o
 
 obj-$(CONFIG_SMP)			+= smp.o
-obj-$(CONFIG_SIBYTE_STANDALONE)		+= prom.o
 obj-$(CONFIG_SIBYTE_BUS_WATCHER)	+= bus_watcher.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/sibyte/sb1250/prom.c b/arch/mips/sibyte/sb1250/prom.c
deleted file mode 100644
index 65b1af6..0000000
--- a/arch/mips/sibyte/sb1250/prom.c
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright (C) 2000, 2001 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/blkdev.h>
-#include <linux/bootmem.h>
-#include <linux/smp.h>
-#include <linux/initrd.h>
-#include <linux/pm.h>
-
-#include <asm/bootinfo.h>
-#include <asm/reboot.h>
-
-#define MAX_RAM_SIZE ((CONFIG_SIBYTE_STANDALONE_RAM_SIZE * 1024 * 1024) - 1)
-
-static __init void prom_meminit(void)
-{
-#ifdef CONFIG_BLK_DEV_INITRD
-	unsigned long initrd_pstart;
-	unsigned long initrd_pend;
-
-	initrd_pstart = __pa(initrd_start);
-	initrd_pend = __pa(initrd_end);
-	if (initrd_start &&
-	    ((initrd_pstart > MAX_RAM_SIZE)
-	     || (initrd_pend > MAX_RAM_SIZE))) {
-		panic("initrd out of addressable memory");
-	}
-
-	add_memory_region(0, initrd_pstart,
-			  BOOT_MEM_RAM);
-	add_memory_region(initrd_pstart, initrd_pend - initrd_pstart,
-			  BOOT_MEM_RESERVED);
-	add_memory_region(initrd_pend,
-			  (CONFIG_SIBYTE_STANDALONE_RAM_SIZE * 1024 * 1024) - initrd_pend,
-			  BOOT_MEM_RAM);
-#else
-	add_memory_region(0, CONFIG_SIBYTE_STANDALONE_RAM_SIZE * 1024 * 1024,
-			  BOOT_MEM_RAM);
-#endif
-}
-
-void prom_cpu0_exit(void *unused)
-{
-        while (1) ;
-}
-
-static void prom_linux_exit(void)
-{
-#ifdef CONFIG_SMP
-	if (smp_processor_id()) {
-		smp_call_function(prom_cpu0_exit, NULL, 1);
-	}
-#endif
-	while(1);
-}
-
-/*
- * prom_init is called just after the cpu type is determined, from setup_arch()
- */
-void __init prom_init(void)
-{
-	_machine_restart   = (void (*)(char *))prom_linux_exit;
-	_machine_halt      = prom_linux_exit;
-	pm_power_off = prom_linux_exit;
-
-	strcpy(arcs_cmdline, "root=/dev/ram0 ");
-
-	prom_meminit();
-}
-
-void __init prom_free_prom_memory(void)
-{
-	/* Not sure what I'm supposed to do here.  Nothing, I think */
-}
-
-void prom_putchar(char c)
-{
-}
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index cffa30a..672e45d 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -136,16 +136,6 @@ void __init plat_mem_setup(void)
 	if (m41t81_probe())
 		swarm_rtc_type = RTC_M4LT81;
 
-	printk("This kernel optimized for "
-	       "board"
-	       " runs "
-#ifdef CONFIG_SIBYTE_CFE
-	       "with"
-#else
-	       "without"
-#endif
-	       " CFE\n");
-
 #ifdef CONFIG_VT
 	screen_info = (struct screen_info) {
 		0, 0,           /* orig-x, orig-y */
-- 
1.6.0.4
