Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2004 14:19:41 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:17897 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225234AbUAKOTk>;
	Sun, 11 Jan 2004 14:19:40 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA01878;
	Sun, 11 Jan 2004 23:19:38 +0900 (JST)
Received: 4UMDO00 id i0BEJbL23914; Sun, 11 Jan 2004 23:19:37 +0900 (JST)
Received: 4UMRO00 id i0BEJaC19565; Sun, 11 Jan 2004 23:19:37 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sun, 11 Jan 2004 23:19:32 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] change registers name for vr41xx
Message-Id: <20040111231932.2b2b26d9.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for vr41xx of 2.6.

Although the old register name is using CPU as the base,
it is not dependent on CPU in practice.
This patch corrects the name depending on the CPU name.

Please apply this patch.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/bcu.c linux/arch/mips/vr41xx/common/bcu.c
--- linux-orig/arch/mips/vr41xx/common/bcu.c	Sat Jan 10 19:43:13 2004
+++ linux/arch/mips/vr41xx/common/bcu.c	Sun Jan 11 22:09:01 2004
@@ -46,8 +46,8 @@
 #include <asm/cpu.h>
 #include <asm/io.h>
 
-#define VR4111_CLKSPEEDREG	KSEG1ADDR(0x0b000014)
-#define VR4122_CLKSPEEDREG	KSEG1ADDR(0x0f000014)
+#define CLKSPEEDREG_TYPE1	KSEG1ADDR(0x0b000014)
+#define CLKSPEEDREG_TYPE2	KSEG1ADDR(0x0f000014)
  #define CLKSP(x)		((x) & 0x001f)
  #define CLKSP_VR4133(x)	((x) & 0x0007)
 
@@ -78,10 +78,10 @@
 {
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
-	case CPU_VR4121: return readw(VR4111_CLKSPEEDREG);
+	case CPU_VR4121: return readw(CLKSPEEDREG_TYPE1);
 	case CPU_VR4122:
 	case CPU_VR4131:
-	case CPU_VR4133: return readw(VR4122_CLKSPEEDREG);
+	case CPU_VR4133: return readw(CLKSPEEDREG_TYPE2);
 	default:
 		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 		break;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/cmu.c linux/arch/mips/vr41xx/common/cmu.c
--- linux-orig/arch/mips/vr41xx/common/cmu.c	Sat Jan 10 19:43:13 2004
+++ linux/arch/mips/vr41xx/common/cmu.c	Sun Jan 11 22:09:01 2004
@@ -47,33 +47,33 @@
 #include <asm/io.h>
 #include <asm/vr41xx/vr41xx.h>
 
-#define VR4111_CMUCLKMSK	KSEG1ADDR(0x0b000060)
-#define VR4122_CMUCLKMSK	KSEG1ADDR(0x0f000060)
- #define MSKPIU			0x0001
- #define MSKSIU			0x0002
- #define MSKAIU			0x0004
- #define MSKKIU			0x0008
- #define MSKFIR			0x0010
- #define MSKDSIU		0x0820
- #define MSKCSI			0x0040
- #define MSKPCIU		0x0080
- #define MSKSSIU		0x0100
- #define MSKSHSP		0x0200
- #define MSKFFIR		0x0400
- #define MSKSCSI		0x1000
- #define MSKPPCIU		0x2000
-#define VR4133_CMUCLKMSK2	KSEG1ADDR(0x0f000064)
- #define MSKCEU			0x0001
- #define MSKMAC0		0x0002
- #define MSKMAC1		0x0004
+#define CMUCLKMSK_TYPE1	KSEG1ADDR(0x0b000060)
+#define CMUCLKMSK_TYPE2	KSEG1ADDR(0x0f000060)
+ #define MSKPIU		0x0001
+ #define MSKSIU		0x0002
+ #define MSKAIU		0x0004
+ #define MSKKIU		0x0008
+ #define MSKFIR		0x0010
+ #define MSKDSIU	0x0820
+ #define MSKCSI		0x0040
+ #define MSKPCIU	0x0080
+ #define MSKSSIU	0x0100
+ #define MSKSHSP	0x0200
+ #define MSKFFIR	0x0400
+ #define MSKSCSI	0x1000
+ #define MSKPPCIU	0x2000
+#define CMUCLKMSK2	KSEG1ADDR(0x0f000064)
+ #define MSKCEU		0x0001
+ #define MSKMAC0	0x0002
+ #define MSKMAC1	0x0004
 
 static u32 vr41xx_cmu_base;
 static u16 cmuclkmsk, cmuclkmsk2;
 
 #define read_cmuclkmsk()	readw(vr41xx_cmu_base)
-#define read_cmuclkmsk2()	readw(VR4133_CMUCLKMSK2)
+#define read_cmuclkmsk2()	readw(CMUCLKMSK2)
 #define write_cmuclkmsk()	writew(cmuclkmsk, vr41xx_cmu_base)
-#define write_cmuclkmsk2()	writew(cmuclkmsk2, VR4133_CMUCLKMSK2)
+#define write_cmuclkmsk2()	writew(cmuclkmsk2, CMUCLKMSK2)
 
 void vr41xx_clock_supply(unsigned int clock)
 {
@@ -206,14 +206,14 @@
 	switch (current_cpu_data.cputype) {
         case CPU_VR4111:
         case CPU_VR4121:
-                vr41xx_cmu_base = VR4111_CMUCLKMSK;
+                vr41xx_cmu_base = CMUCLKMSK_TYPE1;
                 break;
         case CPU_VR4122:
         case CPU_VR4131:
-                vr41xx_cmu_base = VR4122_CMUCLKMSK;
+                vr41xx_cmu_base = CMUCLKMSK_TYPE2;
                 break;
         case CPU_VR4133:
-                vr41xx_cmu_base = VR4122_CMUCLKMSK;
+                vr41xx_cmu_base = CMUCLKMSK_TYPE2;
 		cmuclkmsk2 = read_cmuclkmsk2();
                 break;
 	default:
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux-orig/arch/mips/vr41xx/common/giu.c	Sat Jan 10 19:43:13 2004
+++ linux/arch/mips/vr41xx/common/giu.c	Sun Jan 11 22:09:01 2004
@@ -49,8 +49,8 @@
 #include <asm/io.h>
 #include <asm/vr41xx/vr41xx.h>
 
-#define VR4111_GIUIOSELL	KSEG1ADDR(0x0b000100)
-#define VR4122_GIUIOSELL	KSEG1ADDR(0x0f000140)
+#define GIUIOSELL_TYPE1	KSEG1ADDR(0x0b000100)
+#define GIUIOSELL_TYPE2	KSEG1ADDR(0x0f000140)
 
 #define GIUIOSELL	0x00
 #define GIUIOSELH	0x02
@@ -281,12 +281,12 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		giu_base = VR4111_GIUIOSELL;
+		giu_base = GIUIOSELL_TYPE1;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		giu_base = VR4122_GIUIOSELL;
+		giu_base = GIUIOSELL_TYPE2;
 		break;
 	default:
 		panic("GIU: Unexpected CPU of NEC VR4100 series");
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux-orig/arch/mips/vr41xx/common/icu.c	Sat Jan 10 19:43:13 2004
+++ linux/arch/mips/vr41xx/common/icu.c	Sun Jan 11 22:09:01 2004
@@ -68,11 +68,11 @@
 static unsigned char sysint2_assign[16] = {
 	2, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
-#define VR4111_SYSINT1REG	KSEG1ADDR(0x0b000080)
-#define VR4111_SYSINT2REG	KSEG1ADDR(0x0b000200)
+#define SYSINT1REG_TYPE1	KSEG1ADDR(0x0b000080)
+#define SYSINT2REG_TYPE1	KSEG1ADDR(0x0b000200)
 
-#define VR4122_SYSINT1REG	KSEG1ADDR(0x0f000080)
-#define VR4122_SYSINT2REG	KSEG1ADDR(0x0f0000a0)
+#define SYSINT1REG_TYPE2	KSEG1ADDR(0x0f000080)
+#define SYSINT2REG_TYPE2	KSEG1ADDR(0x0f0000a0)
 
 #define SYSINT1REG	0x00
 #define INTASSIGN0	0x04
@@ -293,14 +293,14 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		icu1_base = VR4111_SYSINT1REG;
-		icu2_base = VR4111_SYSINT2REG;
+		icu1_base = SYSINT1REG_TYPE1;
+		icu2_base = SYSINT2REG_TYPE1;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		icu1_base = VR4122_SYSINT1REG;
-		icu2_base = VR4122_SYSINT2REG;
+		icu1_base = SYSINT1REG_TYPE2;
+		icu2_base = SYSINT2REG_TYPE2;
 		break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/rtc.c linux/arch/mips/vr41xx/common/rtc.c
--- linux-orig/arch/mips/vr41xx/common/rtc.c	Sat Jan 10 19:43:13 2004
+++ linux/arch/mips/vr41xx/common/rtc.c	Sun Jan 11 22:09:01 2004
@@ -39,11 +39,11 @@
 #define REMAINDER_PER_SEC	(CLOCK_TICK_RATE - (CYCLES_PER_JIFFY * HZ))
 #define CYCLES_PER_100USEC	((CLOCK_TICK_RATE + (10000 / 2)) / 10000)
 
-#define VR4111_ETIMELREG	KSEG1ADDR(0x0b0000c0)
-#define VR4111_TCLKLREG		KSEG1ADDR(0x0b0001c0)
+#define ETIMELREG_TYPE1		KSEG1ADDR(0x0b0000c0)
+#define TCLKLREG_TYPE1		KSEG1ADDR(0x0b0001c0)
 
-#define VR4122_ETIMELREG	KSEG1ADDR(0x0f000100)
-#define VR4122_TCLKLREG		KSEG1ADDR(0x0f000120)
+#define ETIMELREG_TYPE2		KSEG1ADDR(0x0f000100)
+#define TCLKLREG_TYPE2		KSEG1ADDR(0x0f000120)
 
 /* RTC 1 registers */
 #define ETIMELREG		0x00
@@ -264,14 +264,14 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		rtc1_base = VR4111_ETIMELREG;
-		rtc2_base = VR4111_TCLKLREG;
+		rtc1_base = ETIMELREG_TYPE1;
+		rtc2_base = TCLKLREG_TYPE1;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		rtc1_base = VR4122_ETIMELREG;
-		rtc2_base = VR4122_TCLKLREG;
+		rtc1_base = ETIMELREG_TYPE2;
+		rtc2_base = TCLKLREG_TYPE2;
 		break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux-orig/arch/mips/vr41xx/common/serial.c	Sat Jan 10 19:43:13 2004
+++ linux/arch/mips/vr41xx/common/serial.c	Sun Jan 11 22:09:01 2004
@@ -50,12 +50,12 @@
 #include <asm/vr41xx/vr41xx.h>
 
 /* VR4111 and VR4121 SIU Registers */
-#define VR4111_SIURB		KSEG1ADDR(0x0c000000)
-#define VR4111_SIUIRSEL		KSEG1ADDR(0x0c000008)
+#define SIURB_TYPE1		KSEG1ADDR(0x0c000000)
+#define SIUIRSEL_TYPE1		KSEG1ADDR(0x0c000008)
 
-/* VR4122 and VR4131 SIU Registers */
-#define VR4122_SIURB		KSEG1ADDR(0x0f000800)
-#define VR4122_SIUIRSEL		KSEG1ADDR(0x0f000808)
+/* VR4122, VR4131 and VR4133 SIU Registers */
+#define SIURB_TYPE2		KSEG1ADDR(0x0f000800)
+#define SIUIRSEL_TYPE2		KSEG1ADDR(0x0f000808)
 
  #define USE_RS232C		0x00
  #define USE_IRDA		0x01
@@ -102,12 +102,12 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		writew(val, VR4111_SIUIRSEL);
+		writew(val, SIUIRSEL_TYPE1);
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		writew(val, VR4122_SIUIRSEL);
+		writew(val, SIUIRSEL_TYPE2);
 		break;
 	default:
 		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
@@ -130,12 +130,12 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		s.iomem_base = (unsigned char *)VR4111_SIURB;
+		s.iomem_base = (unsigned char *)SIURB_TYPE1;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		s.iomem_base = (unsigned char *)VR4122_SIURB;
+		s.iomem_base = (unsigned char *)SIURB_TYPE2;
 		break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
