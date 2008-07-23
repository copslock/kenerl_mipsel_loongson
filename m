Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:25:14 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:19690 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577895AbYGWPXh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:37 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 00E8CA8F2; Thu, 24 Jul 2008 00:23:29 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 06/10] txx9: Cleanup restart/halt/power_off
Date:	Thu, 24 Jul 2008 00:25:17 +0900
Message-Id: <1216826721-28259-6-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Unify machine_restart/machine_halt/pm_power_off and add fallback
machine_halt routine.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c  |   26 ++++++++++++++++++++++++++
 arch/mips/txx9/jmr3927/setup.c  |   29 ++++-------------------------
 arch/mips/txx9/rbtx4927/setup.c |   33 ++-------------------------------
 arch/mips/txx9/rbtx4938/setup.c |   26 ++------------------------
 4 files changed, 34 insertions(+), 80 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 4fbd7ba..82272e8 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
+#include <asm/reboot.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #ifdef CONFIG_CPU_TX49XX
@@ -188,6 +189,25 @@ char * __init prom_getcmdline(void)
 	return &(arcs_cmdline[0]);
 }
 
+static void __noreturn txx9_machine_halt(void)
+{
+	local_irq_disable();
+	clear_c0_status(ST0_IM);
+	while (1) {
+		if (cpu_wait) {
+			(*cpu_wait)();
+			if (cpu_has_counter) {
+				/*
+				 * Clear counter interrupt while it
+				 * breaks WAIT instruction even if
+				 * masked.
+				 */
+				write_c0_compare(0);
+			}
+		}
+	}
+}
+
 /* wrappers */
 void __init plat_mem_setup(void)
 {
@@ -195,6 +215,12 @@ void __init plat_mem_setup(void)
 	ioport_resource.end = ~0UL;	/* no limit */
 	iomem_resource.start = 0;
 	iomem_resource.end = ~0UL;	/* no limit */
+
+	/* fallback restart/halt routines */
+	_machine_restart = (void (*)(char *))txx9_machine_halt;
+	_machine_halt = txx9_machine_halt;
+	pm_power_off = txx9_machine_halt;
+
 #ifdef CONFIG_PCI
 	pcibios_plat_setup = txx9_pcibios_setup;
 #endif
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 7c16c40..fa0503e 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -32,7 +32,6 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #ifdef CONFIG_SERIAL_TXX9
@@ -46,13 +45,12 @@
 #include <asm/txx9/jmr3927.h>
 #include <asm/mipsregs.h>
 
-extern void puts(const char *cp);
-
 /* don't enable - see errata */
 static int jmr3927_ccfg_toeon;
 
-static inline void do_reset(void)
+static void jmr3927_machine_restart(char *command)
 {
+	local_irq_disable();
 #if 1	/* Resetting PCI bus */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
 	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI, JMR3927_IOC_RESET_ADDR);
@@ -61,25 +59,8 @@ static inline void do_reset(void)
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
 #endif
 	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_CPU, JMR3927_IOC_RESET_ADDR);
-}
-
-static void jmr3927_machine_restart(char *command)
-{
-	local_irq_disable();
-	puts("Rebooting...");
-	do_reset();
-}
-
-static void jmr3927_machine_halt(void)
-{
-	puts("JMR-TX3927 halted.\n");
-	while (1);
-}
-
-static void jmr3927_machine_power_off(void)
-{
-	puts("JMR-TX3927 halted. Please turn off the power.\n");
-	while (1);
+	/* fallback */
+	(*_machine_halt)();
 }
 
 static void __init jmr3927_time_init(void)
@@ -102,8 +83,6 @@ static void __init jmr3927_mem_setup(void)
 	set_io_port_base(JMR3927_PORT_BASE + JMR3927_PCIIO);
 
 	_machine_restart = jmr3927_machine_restart;
-	_machine_halt = jmr3927_machine_halt;
-	pm_power_off = jmr3927_machine_power_off;
 
 	/* Reboot on panic */
 	panic_timeout = 180;
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 65b7224..54c33c3 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -47,11 +47,9 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <asm/io.h>
-#include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
@@ -167,17 +165,8 @@ static void __init rbtx4937_arch_init(void)
 #define rbtx4937_arch_init NULL
 #endif /* CONFIG_PCI */
 
-static void __noreturn wait_forever(void)
-{
-	while (1)
-		if (cpu_wait)
-			(*cpu_wait)();
-}
-
 static void toshiba_rbtx4927_restart(char *command)
 {
-	printk(KERN_NOTICE "System Rebooting...\n");
-
 	/* enable the s/w reset register */
 	writeb(1, rbtx4927_softresetlock_addr);
 
@@ -188,24 +177,8 @@ static void toshiba_rbtx4927_restart(char *command)
 	/* do a s/w reset */
 	writeb(1, rbtx4927_softreset_addr);
 
-	/* do something passive while waiting for reset */
-	local_irq_disable();
-	wait_forever();
-	/* no return */
-}
-
-static void toshiba_rbtx4927_halt(void)
-{
-	printk(KERN_NOTICE "System Halted\n");
-	local_irq_disable();
-	wait_forever();
-	/* no return */
-}
-
-static void toshiba_rbtx4927_power_off(void)
-{
-	toshiba_rbtx4927_halt();
-	/* no return */
+	/* fallback */
+	(*_machine_halt)();
 }
 
 static void __init rbtx4927_clock_init(void);
@@ -233,8 +206,6 @@ static void __init rbtx4927_mem_setup(void)
 	}
 
 	_machine_restart = toshiba_rbtx4927_restart;
-	_machine_halt = toshiba_rbtx4927_halt;
-	pm_power_off = toshiba_rbtx4927_power_off;
 
 #ifdef CONFIG_PCI
 	txx9_alloc_pci_controller(&txx9_primary_pcic,
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 4454b79..e1177b3 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/console.h>
-#include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 
@@ -28,33 +27,14 @@
 #include <asm/txx9/spi.h>
 #include <asm/txx9pio.h>
 
-static void rbtx4938_machine_halt(void)
-{
-        printk(KERN_NOTICE "System Halted\n");
-	local_irq_disable();
-
-	while (1)
-		__asm__(".set\tmips3\n\t"
-			"wait\n\t"
-			".set\tmips0");
-}
-
-static void rbtx4938_machine_power_off(void)
-{
-        rbtx4938_machine_halt();
-        /* no return */
-}
-
 static void rbtx4938_machine_restart(char *command)
 {
 	local_irq_disable();
-
-	printk("Rebooting...");
 	writeb(1, rbtx4938_softresetlock_addr);
 	writeb(1, rbtx4938_sfvol_addr);
 	writeb(1, rbtx4938_softreset_addr);
-	while(1)
-		;
+	/* fallback */
+	(*_machine_halt)();
 }
 
 static void __init rbtx4938_pci_setup(void)
@@ -263,8 +243,6 @@ static void __init rbtx4938_mem_setup(void)
 		printk("request resource for fpga failed\n");
 
 	_machine_restart = rbtx4938_machine_restart;
-	_machine_halt = rbtx4938_machine_halt;
-	pm_power_off = rbtx4938_machine_power_off;
 
 	writeb(0xff, rbtx4938_led_addr);
 	printk(KERN_INFO "RBTX4938 --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
-- 
1.5.5.5
