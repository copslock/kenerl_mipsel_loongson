Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 15:58:53 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:12242 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28577737AbYGNO6v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 15:58:51 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KIPVq-0005di-00; Mon, 14 Jul 2008 16:58:50 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 8383EDE7B3; Mon, 14 Jul 2008 16:58:47 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Remove mips_machtype for LASAT machines
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080714145847.8383EDE7B3@solo.franken.de>
Date:	Mon, 14 Jul 2008 16:58:47 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

This is the LASAT part of the mips_machtype removal.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

This patch is against the queue tree.

 arch/mips/lasat/interrupt.c    |   21 ++++++++-------------
 arch/mips/lasat/lasat_board.c  |    3 +--
 arch/mips/lasat/prom.c         |    8 +++-----
 arch/mips/lasat/serial.c       |    3 +--
 arch/mips/lasat/setup.c        |    8 +++++---
 arch/mips/pci/pci-lasat.c      |   14 ++++----------
 include/asm-mips/bootinfo.h    |    6 ------
 include/asm-mips/lasat/lasat.h |    2 ++
 8 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/arch/mips/lasat/interrupt.c b/arch/mips/lasat/interrupt.c
index a56c150..d1ac7a2 100644
--- a/arch/mips/lasat/interrupt.c
+++ b/arch/mips/lasat/interrupt.c
@@ -22,8 +22,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
-#include <asm/bootinfo.h>
 #include <asm/irq_cpu.h>
+#include <asm/lasat/lasat.h>
 #include <asm/lasat/lasatint.h>
 
 #include <irq.h>
@@ -112,23 +112,18 @@ void __init arch_init_irq(void)
 {
 	int i;
 
-	switch (mips_machtype) {
-	case MACH_LASAT_100:
-		lasat_int_status = (void *)LASAT_INT_STATUS_REG_100;
-		lasat_int_mask = (void *)LASAT_INT_MASK_REG_100;
-		lasat_int_mask_shift = LASATINT_MASK_SHIFT_100;
-		get_int_status = get_int_status_100;
-		*lasat_int_mask = 0;
-		break;
-	case MACH_LASAT_200:
+	if (IS_LASAT_200()) {
 		lasat_int_status = (void *)LASAT_INT_STATUS_REG_200;
 		lasat_int_mask = (void *)LASAT_INT_MASK_REG_200;
 		lasat_int_mask_shift = LASATINT_MASK_SHIFT_200;
 		get_int_status = get_int_status_200;
 		*lasat_int_mask &= 0xffff;
-		break;
-	default:
-		panic("arch_init_irq: mips_machtype incorrect");
+	} else {
+		lasat_int_status = (void *)LASAT_INT_STATUS_REG_100;
+		lasat_int_mask = (void *)LASAT_INT_MASK_REG_100;
+		lasat_int_mask_shift = LASATINT_MASK_SHIFT_100;
+		get_int_status = get_int_status_100;
+		*lasat_int_mask = 0;
 	}
 
 	mips_cpu_irq_init();
diff --git a/arch/mips/lasat/lasat_board.c b/arch/mips/lasat/lasat_board.c
index 31e328b..577bb46 100644
--- a/arch/mips/lasat/lasat_board.c
+++ b/arch/mips/lasat/lasat_board.c
@@ -24,7 +24,6 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/mutex.h>
-#include <asm/bootinfo.h>
 #include <asm/addrspace.h>
 #include "at93c.h"
 /* New model description table */
@@ -66,7 +65,7 @@ static void init_flash_sizes(void)
 	ls[LASAT_MTD_SERVICE] = 0xC0000;
 	ls[LASAT_MTD_NORMAL] = 0x100000;
 
-	if (mips_machtype == MACH_LASAT_100) {
+	if (!IS_LASAT_200()) {
 		lasat_board_info.li_flash_base = 0x1e000000;
 
 		lb[LASAT_MTD_BOOTLOADER] = 0x1e400000;
diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
index 209edcc..6acc6cb 100644
--- a/arch/mips/lasat/prom.c
+++ b/arch/mips/lasat/prom.c
@@ -86,18 +86,16 @@ void __init prom_init(void)
 
 	setup_prom_vectors();
 
-	if (current_cpu_data.cputype == CPU_R5000) {
+	if (IS_LASAT_200()) {
 		printk(KERN_INFO "LASAT 200 board\n");
-		mips_machtype = MACH_LASAT_200;
 		lasat_ndelay_divider = LASAT_200_DIVIDER;
+		at93c = &at93c_defs[1];
 	} else {
 		printk(KERN_INFO "LASAT 100 board\n");
-		mips_machtype = MACH_LASAT_100;
 		lasat_ndelay_divider = LASAT_100_DIVIDER;
+		at93c = &at93c_defs[0];
 	}
 
-	at93c = &at93c_defs[mips_machtype];
-
 	lasat_init_board_info();		/* Read info from EEPROM */
 
 	/* Get the command line */
diff --git a/arch/mips/lasat/serial.c b/arch/mips/lasat/serial.c
index 205bd39..5bcb6e8 100644
--- a/arch/mips/lasat/serial.c
+++ b/arch/mips/lasat/serial.c
@@ -23,7 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 
-#include <asm/bootinfo.h>
 #include <asm/lasat/lasat.h>
 #include <asm/lasat/serial.h>
 
@@ -47,7 +46,7 @@ static __init int lasat_uart_add(void)
 	if (!pdev)
 		return -ENOMEM;
 
-	if (mips_machtype == MACH_LASAT_100) {
+	if (!IS_LASAT_200()) {
 		lasat_serial_res[0].start = KSEG1ADDR(LASAT_UART_REGS_BASE_100);
 		lasat_serial_res[0].end = lasat_serial_res[0].start + LASAT_UART_REGS_SHIFT_100 * 8 - 1;
 		lasat_serial_res[0].flags = IORESOURCE_MEM;
diff --git a/arch/mips/lasat/setup.c b/arch/mips/lasat/setup.c
index e072da4..dbd3163 100644
--- a/arch/mips/lasat/setup.c
+++ b/arch/mips/lasat/setup.c
@@ -127,9 +127,11 @@ void __init plat_time_init(void)
 void __init plat_mem_setup(void)
 {
 	int i;
-	lasat_misc  = &lasat_misc_info[mips_machtype];
+	int lasat_type = IS_LASAT_200() ? 1 : 0;
+
+	lasat_misc  = &lasat_misc_info[lasat_type];
 #ifdef CONFIG_PICVUE
-	picvue = &pvc_defs[mips_machtype];
+	picvue = &pvc_defs[lasat_type];
 #endif
 
 	/* Set up panic notifier */
@@ -140,7 +142,7 @@ void __init plat_mem_setup(void)
 	lasat_reboot_setup();
 
 #ifdef CONFIG_DS1603
-	ds1603 = &ds_defs[mips_machtype];
+	ds1603 = &ds_defs[lasat_type];
 #endif
 
 #ifdef DYNAMIC_SERIAL_INIT
diff --git a/arch/mips/pci/pci-lasat.c b/arch/mips/pci/pci-lasat.c
index e70ae32..a98e543 100644
--- a/arch/mips/pci/pci-lasat.c
+++ b/arch/mips/pci/pci-lasat.c
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/types.h>
 
-#include <asm/bootinfo.h>
+#include <asm/lasat/lasat.h>
 
 #include <irq.h>
 
@@ -39,16 +39,10 @@ static int __init lasat_pci_setup(void)
 {
 	printk(KERN_DEBUG "PCI: starting\n");
 
-	switch (mips_machtype) {
-	case MACH_LASAT_100:
-		lasat_pci_controller.pci_ops = &gt64xxx_pci0_ops;
-		break;
-	case MACH_LASAT_200:
+	if (IS_LASAT_200())
 		lasat_pci_controller.pci_ops = &nile4_pci_ops;
-		break;
-	default:
-		panic("pcibios_init: mips_machtype incorrect");
-	}
+	else
+		lasat_pci_controller.pci_ops = &gt64xxx_pci0_ops;
 
 	register_pci_controller(&lasat_pci_controller);
 
diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index 51dbec9..d39e143 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -41,12 +41,6 @@
 #define  MACH_DS5900		10	/* DECsystem 5900		*/
 
 /*
- * Valid machtype for group LASAT
- */
-#define  MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
-#define  MACH_LASAT_200		1	/* Masquerade PRO/SP200 */
-
-/*
  * Valid machtype for group PMC-MSP
  */
 #define MACH_MSP4200_EVAL       0	/* PMC-Sierra MSP4200 Evaluation */
diff --git a/include/asm-mips/lasat/lasat.h b/include/asm-mips/lasat/lasat.h
index ea04d92..caeba1e 100644
--- a/include/asm-mips/lasat/lasat.h
+++ b/include/asm-mips/lasat/lasat.h
@@ -240,6 +240,8 @@ static inline void lasat_ndelay(unsigned int ns)
 	__delay(ns / lasat_ndelay_divider);
 }
 
+#define IS_LASAT_200()     (current_cpu_data.cputype == CPU_R5000)
+
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 #define LASAT_SERVICEMODE_MAGIC_1     0xdeadbeef
