Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 12:58:37 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:24279 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225365AbUBAM6g>;
	Sun, 1 Feb 2004 12:58:36 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id VAA18548;
	Sun, 1 Feb 2004 21:58:30 +0900 (JST)
Received: 4UMDO00 id i11CwU119511; Sun, 1 Feb 2004 21:58:30 +0900 (JST)
Received: 4UMRO00 id i11CwSX01588; Sun, 1 Feb 2004 21:58:29 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sun, 1 Feb 2004 21:58:08 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Moved timer setup to common part for vr41xx
Message-Id: <20040201215808.69e35cc9.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for timer of vr41xx.
This patch get together setup of dispersed timer to one place.

Please apply to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux-orig/arch/mips/vr41xx/casio-e55/setup.c	Sat Jan 31 23:11:48 2004
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Sat Jan 31 22:53:18 2004
@@ -24,7 +24,6 @@
 #include <linux/kdev_t.h>
 #include <linux/root_dev.h>
 
-#include <asm/time.h>
 #include <asm/vr41xx/e55.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -46,14 +45,13 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	board_time_init = vr41xx_time_init;
-	board_timer_setup = vr41xx_timer_setup;
-
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
 
 	vr41xx_pmu_init();
+
+	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/rtc.c linux/arch/mips/vr41xx/common/rtc.c
--- linux-orig/arch/mips/vr41xx/common/rtc.c	Tue Jan 13 08:21:05 2004
+++ linux/arch/mips/vr41xx/common/rtc.c	Sat Jan 31 22:51:47 2004
@@ -259,7 +259,7 @@
 	epoch_time = time;
 }
 
-void __init vr41xx_time_init(void)
+static void __init vr41xx_time_init(void)
 {
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
@@ -291,7 +291,7 @@
 	rtc_set_time = vr41xx_set_time;
 }
 
-void __init vr41xx_timer_setup(struct irqaction *irq)
+static void __init vr41xx_timer_setup(struct irqaction *irq)
 {
 	do_gettimeoffset = vr41xx_gettimeoffset;
 
@@ -308,4 +308,10 @@
 	write_rtc2(ELAPSEDTIME_INT, RTCINTREG);
 
 	setup_irq(ELAPSEDTIME_IRQ, irq);
+}
+
+void __init vr41xx_rtc_init(void)
+{
+	board_time_init = vr41xx_time_init;
+	board_timer_setup = vr41xx_timer_setup;
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Sat Jan 31 23:11:48 2004
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Sat Jan 31 22:54:11 2004
@@ -24,7 +24,6 @@
 #include <linux/kdev_t.h>
 #include <linux/root_dev.h>
 
-#include <asm/time.h>
 #include <asm/vr41xx/workpad.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -46,14 +45,13 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	board_time_init = vr41xx_time_init;
-	board_timer_setup = vr41xx_timer_setup;
-
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
 
 	vr41xx_pmu_init();
+
+	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Sat Jan 31 23:11:48 2004
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Sat Jan 31 22:51:47 2004
@@ -38,7 +38,6 @@
 #include <linux/root_dev.h>
 
 #include <asm/pci_channel.h>
-#include <asm/time.h>
 #include <asm/vr41xx/eagle.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -113,9 +112,6 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	board_time_init = vr41xx_time_init;
-	board_timer_setup = vr41xx_timer_setup;
-
 	board_irq_init = eagle_irq_init;
 
 	vr41xx_bcu_init();
@@ -123,6 +119,8 @@
 	vr41xx_cmu_init();
 
 	vr41xx_pmu_init();
+
+	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_dsiu_init();
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Sat Jan 31 23:11:48 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Sat Jan 31 22:55:24 2004
@@ -22,7 +22,6 @@
 #include <linux/ioport.h>
 
 #include <asm/pci_channel.h>
-#include <asm/time.h>
 #include <asm/vr41xx/tb0226.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -92,14 +91,13 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	board_time_init = vr41xx_time_init;
-	board_timer_setup = vr41xx_timer_setup;
-
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
 
 	vr41xx_pmu_init();
+
+	vr41xx_rtc_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Sat Jan 31 23:11:48 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Sat Jan 31 22:56:19 2004
@@ -28,7 +28,6 @@
 
 #include <asm/pci_channel.h>
 #include <asm/reboot.h>
-#include <asm/time.h>
 #include <asm/vr41xx/tb0229.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -97,14 +96,13 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	board_time_init = vr41xx_time_init;
-	board_timer_setup = vr41xx_timer_setup;
-
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
 
 	vr41xx_pmu_init();
+
+	vr41xx_rtc_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Sat Jan 31 23:11:48 2004
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Sat Jan 31 22:57:09 2004
@@ -25,7 +25,6 @@
 #include <linux/root_dev.h>
 
 #include <asm/pci_channel.h>
-#include <asm/time.h>
 #include <asm/vr41xx/mpc30x.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -95,14 +94,13 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	board_time_init = vr41xx_time_init;
-	board_timer_setup = vr41xx_timer_setup;
-
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
 
 	vr41xx_pmu_init();
+
+	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	Sat Jan 31 23:11:49 2004
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Sat Jan 31 22:58:36 2004
@@ -25,7 +25,6 @@
 #include <linux/root_dev.h>
 
 #include <asm/pci_channel.h>
-#include <asm/time.h>
 #include <asm/vr41xx/capcella.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -95,14 +94,13 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	board_time_init = vr41xx_time_init;
-	board_timer_setup = vr41xx_timer_setup;
-
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
 
 	vr41xx_pmu_init();
+
+	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Sat Jan 31 23:11:49 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Sat Jan 31 22:51:47 2004
@@ -150,6 +150,8 @@
 extern void vr41xx_set_tclock_cycle(uint32_t cycles);
 extern uint32_t vr41xx_read_tclock_counter(void);
 
+extern void vr41xx_rtc_init(void);
+
 /*
  * General-Purpose I/O Unit
  */
@@ -225,11 +227,5 @@
 };
 
 extern void vr41xx_pciu_init(struct vr41xx_pci_address_map *map);
-
-/*
- * MISC
- */
-extern void vr41xx_time_init(void);
-extern void vr41xx_timer_setup(struct irqaction *irq);
 
 #endif /* __NEC_VR41XX_H */
