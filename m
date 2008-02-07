Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 13:47:33 +0000 (GMT)
Received: from mo30.po.2iij.NET ([210.128.50.53]:64563 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037430AbYBGNpb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2008 13:45:31 +0000
Received: by mo.po.2iij.net (mo30) id m17DjRPc018661; Thu, 7 Feb 2008 22:45:27 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox302) id m17DjJfx000906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Feb 2008 22:45:19 +0900
Date:	Thu, 7 Feb 2008 22:44:54 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][5/5][MIPS] cleanup lasat reset functions
Message-Id: <20080207224454.1f4254f0.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080207224140.30878819.yoichi_yuasa@tripeaks.co.jp>
References: <20080207222601.def26d7d.yoichi_yuasa@tripeaks.co.jp>
	<20080207222717.7d58f50a.yoichi_yuasa@tripeaks.co.jp>
	<20080207223945.32f20b2d.yoichi_yuasa@tripeaks.co.jp>
	<20080207224140.30878819.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Clean up lasat reset functions

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/lasat/reset.c mips/arch/mips/lasat/reset.c
--- mips-orig/arch/mips/lasat/reset.c	2007-12-13 10:20:15.537626250 +0900
+++ mips/arch/mips/lasat/reset.c	2007-12-13 10:17:32.751452750 +0900
@@ -17,18 +17,21 @@
  *
  * Reset the LASAT board.
  */
-#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irqflags.h>
 #include <linux/pm.h>
 
+#include <asm/bootinfo.h>
 #include <asm/reboot.h>
-#include <asm/system.h>
 #include <asm/lasat/lasat.h>
 
-#include "picvue.h"
 #include "prom.h"
 
-static void lasat_machine_restart(char *command);
-static void lasat_machine_halt(void);
+#define LASAT_SERVICEMODE_MAGIC_1	0xdeadbeef
+#define LASAT_SERVICEMODE_MAGIC_2	0xfedeabba
+
+static void __iomem *reset_reg;
 
 /* Used to set machine to boot in service mode via /proc interface */
 int lasat_boot_to_service;
@@ -38,10 +41,13 @@ static void lasat_machine_restart(char *
 	local_irq_disable();
 
 	if (lasat_boot_to_service) {
-		*(volatile unsigned int *)0xa0000024 = 0xdeadbeef;
-		*(volatile unsigned int *)0xa00000fc = 0xfedeabba;
+		writel(LASAT_SERVICEMODE_MAGIC_1,
+		       (void __iomem *)KSEG1ADDR(0x24));
+		writel(LASAT_SERVICEMODE_MAGIC_2,
+		       (void __iomem *)KSEG1ADDR(0xfc));
 	}
-	*lasat_misc->reset_reg = 0xbedead;
+
+	writel(0xbedead, reset_reg);
 	for (;;) ;
 }
 
@@ -53,9 +59,25 @@ static void lasat_machine_halt(void)
 	for (;;) ;
 }
 
-void lasat_reboot_setup(void)
+static int lasat_reboot_setup(void)
 {
+	switch (mips_machtype) {
+	case MACH_LASAT_100:
+		reset_reg = (void __iomem *)KSEG1ADDR(0x1c840000);
+		break;
+	case MACH_LASAT_200:
+		reset_reg = (void __iomem *)KSEG1ADDR(0x11080000);
+		break;
+	default:
+		printk(KERN_ERR "Unknown LASAT board\n");
+		return -EINVAL;
+	}
+
 	_machine_restart = lasat_machine_restart;
 	_machine_halt = lasat_machine_halt;
 	pm_power_off = lasat_machine_halt;
+
+	return 0;
 }
+
+arch_initcall(lasat_reboot_setup);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/lasat/setup.c mips/arch/mips/lasat/setup.c
--- mips-orig/arch/mips/lasat/setup.c	2007-12-13 10:20:15.553627250 +0900
+++ mips/arch/mips/lasat/setup.c	2007-12-13 10:17:32.755453000 +0900
@@ -46,20 +46,6 @@
 
 #include "prom.h"
 
-extern void lasat_reboot_setup(void);
-
-struct lasat_misc lasat_misc_info[N_MACHTYPES] = {
-	{
-		.reset_reg	= (void *)KSEG1ADDR(0x1c840000),
-		.flash_wp_reg	= (void *)KSEG1ADDR(0x1c800000), 2
-	}, {
-		.reset_reg	= (void *)KSEG1ADDR(0x11080000),
-		.flash_wp_reg	= (void *)KSEG1ADDR(0x11000000), 6
-	}
-};
-
-struct lasat_misc *lasat_misc;
-
 #ifdef CONFIG_DS1603
 static struct ds_defs ds_defs[N_MACHTYPES] = {
 	{ (void *)DS1603_REG_100, (void *)DS1603_REG_100,
@@ -121,7 +107,7 @@ void __init plat_time_init(void)
 void __init plat_mem_setup(void)
 {
 	int i;
-	lasat_misc  = &lasat_misc_info[mips_machtype];
+
 #ifdef CONFIG_PICVUE
 	picvue = &pvc_defs[mips_machtype];
 #endif
@@ -131,8 +117,6 @@ void __init plat_mem_setup(void)
 		atomic_notifier_chain_register(&panic_notifier_list,
 				&lasat_panic_block[i]);
 
-	lasat_reboot_setup();
-
 #ifdef CONFIG_DS1603
 	ds1603 = &ds_defs[mips_machtype];
 #endif
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/lasat/lasat.h mips/include/asm-mips/lasat/lasat.h
--- mips-orig/include/asm-mips/lasat/lasat.h	2007-12-13 10:20:15.569628250 +0900
+++ mips/include/asm-mips/lasat/lasat.h	2007-12-13 10:17:32.755453000 +0900
@@ -24,12 +24,6 @@
 
 #ifndef _LANGUAGE_ASSEMBLY
 
-extern struct lasat_misc {
-	volatile u32 *reset_reg;
-	volatile u32 *flash_wp_reg;
-	u32 flash_wp_bit;
-} *lasat_misc;
-
 enum lasat_mtdparts {
 	LASAT_MTD_BOOTLOADER,
 	LASAT_MTD_SERVICE,
@@ -242,9 +236,6 @@ static inline void lasat_ndelay(unsigned
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
-#define LASAT_SERVICEMODE_MAGIC_1     0xdeadbeef
-#define LASAT_SERVICEMODE_MAGIC_2     0xfedeabba
-
 /* Lasat 200 boards */
 #define Vrc5074_PHYS_BASE       0x1fa00000
 #define Vrc5074_BASE            (KSEG1ADDR(Vrc5074_PHYS_BASE))
