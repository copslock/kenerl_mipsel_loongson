Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2003 15:41:47 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:16686
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8224802AbTGEOlo>; Sat, 5 Jul 2003 15:41:44 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19YoE3-0002jQ-00; Sat, 05 Jul 2003 16:41:19 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.4] lasat ndelay bug
Cc: linux-mips@linux-mips.org
Message-Id: <E19YoE3-0002jQ-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Sat, 05 Jul 2003 16:41:19 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	this fixes a bug in my internal ndelay function. It is 
needed to because the clock speed is not available until the 
eeprom (at93c) is read and the clock tick is calibrated.

/Brian

Index: arch/mips/lasat/at93c.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/at93c.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 at93c.c
--- arch/mips/lasat/at93c.c	13 Dec 2002 19:45:36 -0000	1.1.2.1
+++ arch/mips/lasat/at93c.c	5 Jul 2003 13:17:26 -0000
@@ -41,9 +41,9 @@
 static void at93c_cycle_clk(u32 data)
 {
 	at93c_reg_write(data | at93c->clk);
-	ndelay(250);
+	lasat_ndelay(250);
 	at93c_reg_write(data & ~at93c->clk);
-	ndelay(250);
+	lasat_ndelay(250);
 }
 
 static void at93c_write_databit(u8 bit)
@@ -55,7 +55,7 @@
 		data &= ~(1 << at93c->wdata_shift);
 
 	at93c_reg_write(data);
-	ndelay(100);
+	lasat_ndelay(100);
 	at93c_cycle_clk(data);
 }
 
@@ -95,13 +95,13 @@
 static void at93c_init_op(void)
 {
 	at93c_reg_write((at93c_reg_read() | at93c->cs) & ~at93c->clk & ~(1 << at93c->rdata_shift));
-	ndelay(50);
+	lasat_ndelay(50);
 }
 
 static void at93c_end_op(void)
 {
 	at93c_reg_write(at93c_reg_read() & ~at93c->cs);
-	ndelay(250);
+	lasat_ndelay(250);
 }
 
 static void at93c_wait(void) 
Index: arch/mips/lasat/prom.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/prom.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 prom.c
--- arch/mips/lasat/prom.c	7 Apr 2003 00:17:06 -0000	1.1.2.4
+++ arch/mips/lasat/prom.c	5 Jul 2003 14:23:12 -0000
@@ -47,6 +47,8 @@
 		null_prom_display;
 void (* prom_monitor)(void) = null_prom_monitor;
 
+unsigned int lasat_ndelay_divider;
+
 #define PROM_PRINTFBUF_SIZE 256
 static char prom_printfbuf[PROM_PRINTFBUF_SIZE];
 
@@ -98,10 +100,13 @@
 {
 	setup_prom_vectors();
 
-	if (current_cpu_data.cputype == CPU_R5000)
+	if (current_cpu_data.cputype == CPU_R5000) {
 		mips_machtype = MACH_LASAT_200;
-	else
+		lasat_ndelay_divider = 8;
+	} else {
 		mips_machtype = MACH_LASAT_100;
+		lasat_ndelay_divider = 20;
+	}
 
 	at93c = &at93c_defs[mips_machtype];
 
Index: include/asm-mips/lasat/lasat.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/lasat/lasat.h,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 lasat.h
--- include/asm-mips/lasat/lasat.h	5 Jul 2003 13:17:04 -0000	1.1.2.4
+++ include/asm-mips/lasat/lasat.h	5 Jul 2003 14:21:59 -0000
@@ -226,10 +226,16 @@
 /* for calibration of delays */
 
 #include <asm/delay.h>
-#define NANOTH 1000000000L
-extern inline void ndelay(unsigned int ns) {
-	if (ns != 0)
-		__delay(lasat_board_info.li_cpu_hz / 2 / (NANOTH / ns) + 1);
+#include <asm/bootinfo.h>
+/* calculating with the slowest board with 100 MHz clock */
+#define LASAT_100_DIVIDER 20
+/* All 200's run at 250 MHz clock */
+#define LASAT_200_DIVIDER 8
+
+extern unsigned int lasat_ndelay_divider;
+
+extern inline void lasat_ndelay(unsigned int ns) {
+	__delay(ns / lasat_ndelay_divider);
 }
 
 extern void (* prom_printf)(const char *fmt, ...);
