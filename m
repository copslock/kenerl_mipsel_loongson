Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA04732; Sun, 15 Jun 1997 09:49:41 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA25521 for linux-list; Sun, 15 Jun 1997 09:49:15 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA25515 for <linux@engr.sgi.com>; Sun, 15 Jun 1997 09:49:13 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA15448
	for <linux@engr.sgi.com>; Sun, 15 Jun 1997 09:48:46 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id SAA13812 for <linux@engr.sgi.com>; Sun, 15 Jun 1997 18:44:50 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706151644.SAA13812@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id SAA16711; Sun, 15 Jun 1997 18:44:48 +0200
Subject: Indy keyboard fix
To: linux@cthulhu.engr.sgi.com
Date: Sun, 15 Jun 1997 18:44:47 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

the patch blow fixes the keyboard and the kernel load address such that
the new handling of the current pointer works again on the Indy and give
your Indy a fresh kernel.  Use this in addition to the pre-2 patch.

  Ralf

Index: linux/Makefile
diff -u linux/Makefile:1.2 linux/Makefile:1.3
--- linux/Makefile:1.2	Tue Jun  3 00:28:06 1997
+++ linux/Makefile	Fri Jun 13 23:33:10 1997
@@ -1,6 +1,6 @@
 VERSION = 2
 PATCHLEVEL = 1
-SUBLEVEL = 41
+SUBLEVEL = 42
 
 ARCH = mips
 
Index: linux/arch/mips/Makefile
diff -u linux/arch/mips/Makefile:1.2 linux/arch/mips/Makefile:1.3
--- linux/arch/mips/Makefile:1.2	Fri Jun 13 22:38:26 1997
+++ linux/arch/mips/Makefile	Sat Jun 14 15:50:48 1997
@@ -1,4 +1,6 @@
 #
+# $Id:$
+#
 # arch/mips/Makefile
 #
 # This file is included by the global makefile so that you can add your own
@@ -135,7 +137,12 @@
 ifdef CONFIG_SGI
 LIBS          += arch/mips/sgi/kernel/sgikern.a arch/mips/sgi/prom/promlib.a
 SUBDIRS       += arch/mips/sgi/kernel arch/mips/sgi/prom
-LOADADDR      += 0x88069000
+#
+# Set LOADADDR to >= 0x88069000 if you want to leave space for symmon,
+# 0x88002000 for production kernels.  Note that the value must be
+# 8kb aligned or the handling of the current variable will break.
+#
+LOADADDR      += 0x88002000
 HOSTCC        = cc
 endif
 
Index: linux/arch/mips/kernel/setup.c
diff -u linux/arch/mips/kernel/setup.c:1.1.1.1 linux/arch/mips/kernel/setup.c:1.2
--- linux/arch/mips/kernel/setup.c:1.1.1.1	Sat May 31 20:16:43 1997
+++ linux/arch/mips/kernel/setup.c	Sat Jun 14 15:52:02 1997
@@ -60,8 +60,9 @@
 
 /*
  * There are several bus types available for MIPS machines.  "RISC PC"
- * type machines have ISA, EISA or PCI available, some DECstations have
- * Turbochannel, SGI has GIO, there are lots of VME boxes ...
+ * type machines have ISA, EISA, VLB or PCI available, DECstations
+ * have Turbochannel or Q-Bus, SGI has GIO, there are lots of VME
+ * boxes ...
  * This flag is set if a EISA slots are available.
  */
 int EISA_bus = 0;
Index: linux/include/asm-mips/keyboard.h
diff -u linux/include/asm-mips/keyboard.h:1.1.1.1 linux/include/asm-mips/keyboard.h:1.2
--- linux/include/asm-mips/keyboard.h:1.1.1.1	Sat May 31 20:17:13 1997
+++ linux/include/asm-mips/keyboard.h	Sat Jun 14 15:56:54 1997
@@ -6,6 +6,8 @@
  * for more details.
  *
  * This file is a mess.  Put on your peril sensitive glasses.
+ *
+ * $Id:$
  */
 #ifndef __ASM_MIPS_KEYBOARD_H
 #define __ASM_MIPS_KEYBOARD_H
@@ -81,23 +83,10 @@
 void (*kbd_outb_p)(unsigned char data, unsigned short port);
 void (*kbd_outb)(unsigned char data, unsigned short port);
 
-#if defined(CONFIG_MIPS_JAZZ) || defined(CONFIG_SGI)
-/*
- * We want the full initialization for the keyboard controller.
- */
-
-/* XXX Define both and ...  */
 #ifdef CONFIG_MIPS_JAZZ
 #define INIT_KBD	/* full initialization for the keyboard controller. */
-#define __khtype keyboard_hardware
-#endif
 
-#ifdef CONFIG_SGI
-#define INIT_KBD	/* full initialization for the keyboard controller. */
-#define __khtype struct hpc_keyb
-#endif
-
-static volatile __khtype *kh;
+static volatile keyboard_hardware *jazz_kh;
 
 static int
 jazz_kbd_inb_p(unsigned short port)
@@ -105,12 +94,10 @@
 	int result;
 
 	if(port == KBD_DATA_REG)
-		result = kh->data;
+		result = jazz_kh->data;
 	else /* Must be KBD_STATUS_REG */
-		result = kh->command;
-#ifndef CONFIG_SGI
+		result = jazz_kh->command;
 	inb(0x80);
-#endif
 
 	return result;
 }
@@ -121,9 +108,9 @@
 	int result;
 
 	if(port == KBD_DATA_REG)
-		result = kh->data;
+		result = jazz_kh->data;
 	else /* Must be KBD_STATUS_REG */
-		result = kh->command;
+		result = jazz_kh->command;
 
 	return result;
 }
@@ -132,24 +119,50 @@
 jazz_kbd_outb_p(unsigned char data, unsigned short port)
 {
 	if(port == KBD_DATA_REG)
-		kh->data = data;
+		jazz_kh->data = data;
 	else if(port == KBD_CNTL_REG)
-		kh->command = data;
-#ifndef CONFIG_SGI
+		jazz_kh->command = data;
 	inb(0x80);
-#endif
 }
 
 static void
 jazz_kbd_outb(unsigned char data, unsigned short port)
 {
 	if(port == KBD_DATA_REG)
-		kh->data = data;
+		jazz_kh->data = data;
 	else if(port == KBD_CNTL_REG)
-		kh->command = data;
+		jazz_kh->command = data;
 }
 #endif /* CONFIG_MIPS_JAZZ */
 
+#ifdef CONFIG_SGI
+#define INIT_KBD	/* full initialization for the keyboard controller. */
+
+static volatile struct hpc_keyb *sgi_kh;
+
+static int
+sgi_kbd_inb(unsigned short port)
+{
+	int result;
+
+	if(port == KBD_DATA_REG)
+		result = sgi_kh->data;
+	else /* Must be KBD_STATUS_REG */
+		result = sgi_kh->command;
+
+	return result;
+}
+
+static void
+sgi_kbd_outb(unsigned char data, unsigned short port)
+{
+	if(port == KBD_DATA_REG)
+		sgi_kh->data = data;
+	else if(port == KBD_CNTL_REG)
+		sgi_kh->command = data;
+}
+#endif /* CONFIG_SGI */
+
 /*
  * Most other MIPS machines access the keyboard controller via
  * ordinary I/O ports.
@@ -178,14 +191,11 @@
 	return outb(data, port);
 }
 
-static inline void kb_wait(void);
-static int send_data(unsigned char data);
-
 extern __inline__ void keyboard_setup(void)
 {
 #ifdef CONFIG_MIPS_JAZZ
         if (mips_machgroup == MACH_GROUP_JAZZ) {
-		kh = (void *) JAZZ_KEYBOARD_ADDRESS;
+		jazz_kh = (void *) JAZZ_KEYBOARD_ADDRESS;
 		kbd_inb_p = jazz_kbd_inb_p;
 		kbd_inb = jazz_kbd_inb;
 		kbd_outb_p = jazz_kbd_outb_p;
@@ -211,18 +221,14 @@
 		kbd_outb_p = port_kbd_outb_p;
 		kbd_outb = port_kbd_outb;
 		request_region(0x60,16,"keyboard");
-
-		kb_wait();
-		kbd_outb(0x60, 0x64); /* 60 == PS/2 MODE ??  */
-		kb_wait();
-		kbd_outb(0x41, 0x60); /* 4d:same as freebsd, 41:KCC+EKI */
-		kb_wait();
-		if (!send_data(0xf0) || !send_data(0x02))
-			printk("Scanmode 2 change failed\n");
 	}
 #ifdef CONFIG_SGI
-	if (mips_machgroup == MACH_SGI_INDY) {
-		kh = (struct hpc_keyb *) (KSEG1 + 0x1fbd9800 + 64);
+	if (mips_machgroup == MACH_GROUP_SGI) {
+		sgi_kh = (struct hpc_keyb *) (KSEG1 + 0x1fbd9800 + 64);
+		kbd_inb_p = sgi_kbd_inb;
+		kbd_inb = sgi_kbd_inb;
+		kbd_outb_p = sgi_kbd_outb;
+		kbd_outb = sgi_kbd_outb;
 	}
 #endif
 }
