Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 16:13:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:3583 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037082AbYGMPNW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 16:13:22 +0100
Received: from localhost (p1204-ipad207funabasi.chiba.ocn.ne.jp [222.145.83.204])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2AC11A8B3; Mon, 14 Jul 2008 00:13:17 +0900 (JST)
Date:	Mon, 14 Jul 2008 00:15:04 +0900 (JST)
Message-Id: <20080714.001504.18284902.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] txx9: cleanup and fix some sparse warnings
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Do not return void value
* Make some functions static
* Do not include unnecessary bootinfo.h

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied on top of Yoichi Yuasa's txx9 mips_machtype
cleanup patchset.

 arch/mips/txx9/generic/setup.c  |    2 +-
 arch/mips/txx9/jmr3927/setup.c  |    3 ---
 arch/mips/txx9/rbtx4927/setup.c |   16 +++-------------
 arch/mips/txx9/rbtx4938/setup.c |   13 +++----------
 include/asm-mips/txx9/generic.h |    1 +
 5 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 452cb9e..5afc5d5 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -140,7 +140,7 @@ void __init prom_init(void)
 
 	strcpy(txx9_system_type, txx9_board_vec->system);
 
-	return txx9_board_vec->prom_init();
+	txx9_board_vec->prom_init();
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 61edc4a..5e35ef7 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -38,8 +38,6 @@
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/serial_core.h>
 #endif
-
-#include <asm/bootinfo.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
 #include <asm/reboot.h>
@@ -95,7 +93,6 @@ static void __init jmr3927_time_init(void)
 #define DO_WRITE_THROUGH
 #define DO_ENABLE_CACHE
 
-extern char * __init prom_getcmdline(void);
 static void jmr3927_board_init(void);
 
 static void __init jmr3927_mem_setup(void)
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index aba11f3..1657fd9 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -50,8 +50,6 @@
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-
-#include <asm/bootinfo.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/reboot.h>
@@ -65,14 +63,6 @@
 #include <linux/serial_core.h>
 #endif
 
-/* These functions are used for rebooting or halting the machine*/
-extern void toshiba_rbtx4927_restart(char *command);
-extern void toshiba_rbtx4927_halt(void);
-extern void toshiba_rbtx4927_power_off(void);
-extern void toshiba_rbtx4927_irq_setup(void);
-
-char *prom_getcmdline(void);
-
 static int tx4927_ccfg_toeon = 1;
 
 #ifdef CONFIG_PCI
@@ -189,7 +179,7 @@ static void __noreturn wait_forever(void)
 			(*cpu_wait)();
 }
 
-void toshiba_rbtx4927_restart(char *command)
+static void toshiba_rbtx4927_restart(char *command)
 {
 	printk(KERN_NOTICE "System Rebooting...\n");
 
@@ -209,7 +199,7 @@ void toshiba_rbtx4927_restart(char *command)
 	/* no return */
 }
 
-void toshiba_rbtx4927_halt(void)
+static void toshiba_rbtx4927_halt(void)
 {
 	printk(KERN_NOTICE "System Halted\n");
 	local_irq_disable();
@@ -217,7 +207,7 @@ void toshiba_rbtx4927_halt(void)
 	/* no return */
 }
 
-void toshiba_rbtx4927_power_off(void)
+static void toshiba_rbtx4927_power_off(void)
 {
 	toshiba_rbtx4927_halt();
 	/* no return */
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 2ef71ad..aaa987a 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -23,7 +23,6 @@
 #include <asm/time.h>
 #include <asm/txx9tmr.h>
 #include <asm/io.h>
-#include <asm/bootinfo.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4938.h>
@@ -34,15 +33,9 @@
 #include <asm/txx9/spi.h>
 #include <asm/txx9pio.h>
 
-extern char * __init prom_getcmdline(void);
-/* These functions are used for rebooting or halting the machine*/
-extern void rbtx4938_machine_restart(char *command);
-extern void rbtx4938_machine_halt(void);
-extern void rbtx4938_machine_power_off(void);
-
 static int tx4938_ccfg_toeon = 1;
 
-void rbtx4938_machine_halt(void)
+static void rbtx4938_machine_halt(void)
 {
         printk(KERN_NOTICE "System Halted\n");
 	local_irq_disable();
@@ -53,13 +46,13 @@ void rbtx4938_machine_halt(void)
 			".set\tmips0");
 }
 
-void rbtx4938_machine_power_off(void)
+static void rbtx4938_machine_power_off(void)
 {
         rbtx4938_machine_halt();
         /* no return */
 }
 
-void rbtx4938_machine_restart(char *command)
+static void rbtx4938_machine_restart(char *command)
 {
 	local_irq_disable();
 
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index 715d7c8..d875666 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -36,5 +36,6 @@ struct txx9_board_vec {
 extern struct txx9_board_vec *txx9_board_vec;
 extern int (*txx9_irq_dispatch)(int pending);
 void prom_init_cmdline(void);
+char *prom_getcmdline(void);
 
 #endif /* __ASM_TXX9_GENERIC_H */
