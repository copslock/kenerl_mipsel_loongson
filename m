Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2003 16:49:49 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:12234 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225546AbTLAQtp>;
	Mon, 1 Dec 2003 16:49:45 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA03657;
	Tue, 2 Dec 2003 01:49:39 +0900 (JST)
Received: 4UMDO00 id hB1Gnc710991; Tue, 2 Dec 2003 01:49:38 +0900 (JST)
Received: 4UMRO01 id hB1GnbU19203; Tue, 2 Dec 2003 01:49:37 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Tue, 2 Dec 2003 01:49:35 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch] NEC VR41xx new timer
Message-Id: <20031202014935.1b2c796b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__2_Dec_2003_01_49_35_+0900_O8rOD56eF1FAQzKz"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart=_Tue__2_Dec_2003_01_49_35_+0900_O8rOD56eF1FAQzKz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I updated new timer patches for latest CVS tree.
These patches are required for power management.

Please apply these patches.

Thanks,

Yoichi

--Multipart=_Tue__2_Dec_2003_01_49_35_+0900_O8rOD56eF1FAQzKz
Content-Type: text/plain;
 name="00-vr41xx_time-v24.diff"
Content-Disposition: attachment;
 filename="00-vr41xx_time-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/config-shared.in linux/arch/mips/config-shared.in
--- linux.orig/arch/mips/config-shared.in	Sun Nov 30 22:11:28 2003
+++ linux/arch/mips/config-shared.in	Tue Dec  2 01:19:39 2003
@@ -252,7 +252,6 @@
 if [ "$CONFIG_CASIO_E55" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_VR41XX_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_ISA y
    define_bool CONFIG_DUMMY_KEYB y
@@ -433,7 +432,6 @@
 if [ "$CONFIG_IBM_WORKPAD" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_VR41XX_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_ISA y
    define_bool CONFIG_DUMMY_KEYB y
@@ -579,7 +577,6 @@
 if [ "$CONFIG_NEC_EAGLE" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_VR41XX_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
@@ -635,7 +632,6 @@
 if [ "$CONFIG_TANBAC_TB0226" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_VR41XX_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
@@ -646,7 +642,6 @@
 if [ "$CONFIG_TANBAC_TB0229" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_VR41XX_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
@@ -678,7 +673,6 @@
 if [ "$CONFIG_VICTOR_MPC30X" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_VR41XX_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
@@ -689,7 +683,6 @@
 if [ "$CONFIG_ZAO_CAPCELLA" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_VR41XX_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/Makefile linux/arch/mips/vr41xx/common/Makefile
--- linux.orig/arch/mips/vr41xx/common/Makefile	Wed Jul 30 09:35:37 2003
+++ linux/arch/mips/vr41xx/common/Makefile	Tue Dec  2 01:19:39 2003
@@ -12,13 +12,12 @@
 
 O_TARGET := vr41xx.o
 
-obj-y := bcu.o cmu.o giu.o icu.o int-handler.o reset.o
+obj-y := bcu.o cmu.o giu.o icu.o int-handler.o ksyms.o reset.o rtc.o
 
-export-objs := vrc4173.o
+export-objs := ksyms.o vrc4173.o
 
 obj-$(CONFIG_PCI)		+= pciu.o
 obj-$(CONFIG_SERIAL)		+= serial.o
-obj-$(CONFIG_VR41XX_TIME_C)	+= time.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 obj-$(subst m,y,$(CONFIG_IDE))	+= ide.o
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/bcu.c linux/arch/mips/vr41xx/common/bcu.c
--- linux.orig/arch/mips/vr41xx/common/bcu.c	Fri Oct 31 11:28:40 2003
+++ linux/arch/mips/vr41xx/common/bcu.c	Tue Dec  2 01:19:39 2003
@@ -36,20 +36,14 @@
  *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
- *  Paul Mundt <lethal@chaoticdreams.org>
- *  - Calculate mips_hpt_frequency properly on VR4131.
- *
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
 #include <linux/types.h>
 
-#include <asm/addrspace.h>
 #include <asm/cpu.h>
 #include <asm/io.h>
-#include <asm/time.h>
-#include <asm/vr41xx/vr41xx.h>
 
 #define VR4111_CLKSPEEDREG	KSEG1ADDR(0x0b000014)
 #define VR4122_CLKSPEEDREG	KSEG1ADDR(0x0f000014)
@@ -66,9 +60,20 @@
  #define TDIVMODE(x)		(2 << (((x) & 0x1000) >> 12))
  #define VTDIVMODE(x)		(((x) & 0x0700) >> 8)
 
-unsigned long vr41xx_vtclock = 0;
+static unsigned long vr41xx_vtclock;
+static unsigned long vr41xx_tclock;
 
-static inline u16 read_clkspeed(void)
+unsigned long vr41xx_get_vtclock_frequency(void)
+{
+	return vr41xx_vtclock;
+}
+
+unsigned long vr41xx_get_tclock_frequency(void)
+{
+	return vr41xx_tclock;
+}
+
+static inline uint16_t read_clkspeed(void)
 {
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
@@ -84,7 +89,7 @@
 	return 0;
 }
 
-static inline unsigned long calculate_pclock(u16 clkspeed)
+static inline unsigned long calculate_pclock(uint16_t clkspeed)
 {
 	unsigned long pclock = 0;
 
@@ -134,46 +139,48 @@
 	return pclock;
 }
 
-static inline unsigned long calculate_vtclock(u16 clkspeed, unsigned long pclock)
+static inline unsigned long calculate_vtclock(uint16_t clkspeed, unsigned long pclock)
 {
+	unsigned long vtclock = 0;
+
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 		/* The NEC VR4111 doesn't have the VTClock. */
 		break;
 	case CPU_VR4121:
-		vr41xx_vtclock = pclock;
+		vtclock = pclock;
 		/* DIVVT == 9 Divide by 1.5 . VTClock = (PClock * 6) / 9 */
 		if (DIVVT(clkspeed) == 9)
-			vr41xx_vtclock = pclock * 6;
+			vtclock = pclock * 6;
 		/* DIVVT == 10 Divide by 2.5 . VTClock = (PClock * 4) / 10 */
 		else if (DIVVT(clkspeed) == 10)
-			vr41xx_vtclock = pclock * 4;
-		vr41xx_vtclock /= DIVVT(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
+			vtclock = pclock * 4;
+		vtclock /= DIVVT(clkspeed);
+		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
 		break;
 	case CPU_VR4122:
 		if(VTDIVMODE(clkspeed) == 7)
-			vr41xx_vtclock = pclock / 1;
+			vtclock = pclock / 1;
 		else if(VTDIVMODE(clkspeed) == 1)
-			vr41xx_vtclock = pclock / 2;
+			vtclock = pclock / 2;
 		else
-			vr41xx_vtclock = pclock / VTDIVMODE(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
+			vtclock = pclock / VTDIVMODE(clkspeed);
+		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
 		break;
 	case CPU_VR4131:
 	case CPU_VR4133:
-		vr41xx_vtclock = pclock / VTDIVMODE(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
+		vtclock = pclock / VTDIVMODE(clkspeed);
+		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
 		break;
 	default:
 		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 		break;
 	}
 
-	return vr41xx_vtclock;
+	return vtclock;
 }
 
-static inline unsigned long calculate_tclock(u16 clkspeed, unsigned long pclock,
+static inline unsigned long calculate_tclock(uint16_t clkspeed, unsigned long pclock,
                                              unsigned long vtclock)
 {
 	unsigned long tclock = 0;
@@ -205,30 +212,14 @@
 	return tclock;
 }
 
-static inline unsigned long calculate_mips_hpt_frequency(unsigned long tclock)
-{
-	/*
-	 * VR4131 Revision 2.0 and 2.1 use a value of (tclock / 2).
-	 */
-	if ((current_cpu_data.processor_id == PRID_VR4131_REV2_0) ||
-	    (current_cpu_data.processor_id == PRID_VR4131_REV2_1))
-		tclock /= 2;
-	else
-		tclock /= 4;
-
-	return tclock;
-}
-
 void __init vr41xx_bcu_init(void)
 {
-	unsigned long pclock, vtclock, tclock;
-	u16 clkspeed;
+	unsigned long pclock;
+	uint16_t clkspeed;
 
 	clkspeed = read_clkspeed();
 
 	pclock = calculate_pclock(clkspeed);
-	vtclock = calculate_vtclock(clkspeed, pclock);
-	tclock = calculate_tclock(clkspeed, pclock, vtclock);
-
-	mips_hpt_frequency = calculate_mips_hpt_frequency(tclock);
+	vr41xx_vtclock = calculate_vtclock(clkspeed, pclock);
+	vr41xx_tclock = calculate_tclock(clkspeed, pclock, vr41xx_vtclock);
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/ksyms.c linux/arch/mips/vr41xx/common/ksyms.c
--- linux.orig/arch/mips/vr41xx/common/ksyms.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/common/ksyms.c	Tue Dec  2 01:19:39 2003
@@ -0,0 +1,33 @@
+/*
+ *   ksyms.c, Export NEC VR4100 series specific functions needed for loadable modules.
+ *
+ *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <asm/vr41xx/vr41xx.h>
+
+EXPORT_SYMBOL(vr41xx_get_vtclock_frequency);
+EXPORT_SYMBOL(vr41xx_get_tclock_frequency);
+
+EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
+EXPORT_SYMBOL(vr41xx_read_rtclong1_counter);
+EXPORT_SYMBOL(vr41xx_set_rtclong2_cycle);
+EXPORT_SYMBOL(vr41xx_read_rtclong2_counter);
+EXPORT_SYMBOL(vr41xx_set_tclock_cycle);
+EXPORT_SYMBOL(vr41xx_read_tclock_counter);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/pciu.c linux/arch/mips/vr41xx/common/pciu.c
--- linux.orig/arch/mips/vr41xx/common/pciu.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/common/pciu.c	Tue Dec  2 01:19:39 2003
@@ -51,8 +51,6 @@
 
 #include "pciu.h"
 
-extern unsigned long vr41xx_vtclock;
-
 static inline int vr41xx_pci_config_access(struct pci_dev *dev, int where)
 {
 	unsigned char bus = dev->bus->number;
@@ -196,6 +194,7 @@
 void __init vr41xx_pciu_init(struct vr41xx_pci_address_map *map)
 {
 	struct vr41xx_pci_address_space *s;
+	unsigned long vtclock;
 	u32 config;
 	int n;
 
@@ -215,11 +214,12 @@
 	udelay(1);
 
 	/* Select PCI clock */
-	if (vr41xx_vtclock < MAX_PCI_CLOCK)
+	vtclock = vr41xx_get_vtclock_frequency();
+	if (vtclock < MAX_PCI_CLOCK)
 		writel(EQUAL_VTCLOCK, PCICLKSELREG);
-	else if ((vr41xx_vtclock / 2) < MAX_PCI_CLOCK)
+	else if ((vtclock / 2) < MAX_PCI_CLOCK)
 		writel(HALF_VTCLOCK, PCICLKSELREG);
-	else if ((vr41xx_vtclock / 4) < MAX_PCI_CLOCK)
+	else if ((vtclock / 4) < MAX_PCI_CLOCK)
 		writel(QUARTER_VTCLOCK, PCICLKSELREG);
 	else
 		printk(KERN_INFO "Warning: PCI Clock is over 33MHz.\n");
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/rtc.c linux/arch/mips/vr41xx/common/rtc.c
--- linux.orig/arch/mips/vr41xx/common/rtc.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/common/rtc.c	Tue Dec  2 01:19:39 2003
@@ -0,0 +1,312 @@
+/*
+ *  rtc.c, RTC(has only timer function) routines for NEC VR4100 series.
+ *
+ *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/vr41xx/vr41xx.h>
+
+static uint32_t rtc1_base;
+static uint32_t rtc2_base;
+
+static uint64_t previous_elapsedtime;
+static unsigned int remainder_per_sec;
+static unsigned int cycles_per_sec;
+static unsigned int cycles_per_jiffy;
+static unsigned long epoch_time;
+
+#define CLOCK_TICK_RATE		32768	/* 32.768kHz */
+
+#define CYCLES_PER_JIFFY	(CLOCK_TICK_RATE / HZ)
+#define REMAINDER_PER_SEC	(CLOCK_TICK_RATE - (CYCLES_PER_JIFFY * HZ))
+#define CYCLES_PER_100USEC	((CLOCK_TICK_RATE + (10000 / 2)) / 10000)
+
+#define VR4111_ETIMELREG	KSEG1ADDR(0x0b0000c0)
+#define VR4111_TCLKLREG		KSEG1ADDR(0x0b0001c0)
+
+#define VR4122_ETIMELREG	KSEG1ADDR(0x0f000100)
+#define VR4122_TCLKLREG		KSEG1ADDR(0x0f000120)
+
+/* RTC 1 registers */
+#define ETIMELREG		0x00
+#define ETIMEMREG		0x02
+#define ETIMEHREG		0x04
+/* RFU */
+#define ECMPLREG		0x08
+#define ECMPMREG		0x0a
+#define ECMPHREG		0x0c
+/* RFU */
+#define RTCL1LREG		0x10
+#define RTCL1HREG		0x12
+#define RTCL1CNTLREG		0x14
+#define RTCL1CNTHREG		0x16
+#define RTCL2LREG		0x18
+#define RTCL2HREG		0x1a
+#define RTCL2CNTLREG		0x1c
+#define RTCL2CNTHREG		0x1e
+
+/* RTC 2 registers */
+#define TCLKLREG		0x00
+#define TCLKHREG		0x02
+#define TCLKCNTLREG		0x04
+#define TCLKCNTHREG		0x06
+/* RFU */
+#define RTCINTREG		0x1e
+ #define TCLOCK_INT		0x08
+ #define RTCLONG2_INT		0x04
+ #define RTCLONG1_INT		0x02
+ #define ELAPSEDTIME_INT	0x01
+
+#define read_rtc1(offset)	readw(rtc1_base + (offset))
+#define write_rtc1(val, offset)	writew((val), rtc1_base + (offset))
+
+#define read_rtc2(offset)	readw(rtc2_base + (offset))
+#define write_rtc2(val, offset)	writew((val), rtc2_base + (offset))
+
+static inline uint64_t read_elapsedtime_counter(void)
+{
+	uint64_t first, second;
+	uint32_t first_mid, first_low;
+	uint32_t second_mid, second_low;
+
+	do {
+		first_low = (uint32_t)read_rtc1(ETIMELREG);
+		first_mid = (uint32_t)read_rtc1(ETIMEMREG);
+		first = (uint64_t)read_rtc1(ETIMEHREG);
+		second_low = (uint32_t)read_rtc1(ETIMELREG);
+		second_mid = (uint32_t)read_rtc1(ETIMEMREG);
+		second = (uint64_t)read_rtc1(ETIMEHREG);
+	} while (first_low != second_low || first_mid != second_mid ||
+	         first != second);
+
+	return (first << 32) | (uint64_t)((first_mid << 16) | first_low);
+}
+
+static inline void write_elapsedtime_counter(uint64_t time)
+{
+	write_rtc1((uint16_t)time, ETIMELREG);
+	write_rtc1((uint16_t)(time >> 16), ETIMEMREG);
+	write_rtc1((uint16_t)(time >> 32), ETIMEHREG);
+}
+
+static inline void write_elapsedtime_compare(uint64_t time)
+{
+	write_rtc1((uint16_t)time, ECMPLREG);
+	write_rtc1((uint16_t)(time >> 16), ECMPMREG);
+	write_rtc1((uint16_t)(time >> 32), ECMPHREG);
+}
+
+void vr41xx_set_rtclong1_cycle(uint32_t cycles)
+{
+	write_rtc1((uint16_t)cycles, RTCL1LREG);
+	write_rtc1((uint16_t)(cycles >> 16), RTCL1HREG);
+}
+
+uint32_t vr41xx_read_rtclong1_counter(void)
+{
+	uint32_t first_high, first_low;
+	uint32_t second_high, second_low;
+
+	do {
+		first_low = (uint32_t)read_rtc1(RTCL1CNTLREG);
+		first_high = (uint32_t)read_rtc1(RTCL1CNTHREG);
+		second_low = (uint32_t)read_rtc1(RTCL1CNTLREG);
+		second_high = (uint32_t)read_rtc1(RTCL1CNTHREG);
+	} while (first_low != second_low || first_high != second_high);
+
+	return (first_high << 16) | first_low;
+}
+
+void vr41xx_set_rtclong2_cycle(uint32_t cycles)
+{
+	write_rtc1((uint16_t)cycles, RTCL2LREG);
+	write_rtc1((uint16_t)(cycles >> 16), RTCL2HREG);
+}
+
+uint32_t vr41xx_read_rtclong2_counter(void)
+{
+	uint32_t first_high, first_low;
+	uint32_t second_high, second_low;
+
+	do {
+		first_low = (uint32_t)read_rtc1(RTCL2CNTLREG);
+		first_high = (uint32_t)read_rtc1(RTCL2CNTHREG);
+		second_low = (uint32_t)read_rtc1(RTCL2CNTLREG);
+		second_high = (uint32_t)read_rtc1(RTCL2CNTHREG);
+	} while (first_low != second_low || first_high != second_high);
+
+	return (first_high << 16) | first_low;
+}
+
+void vr41xx_set_tclock_cycle(uint32_t cycles)
+{
+	write_rtc2((uint16_t)cycles, TCLKLREG);
+	write_rtc2((uint16_t)(cycles >> 16), TCLKHREG);
+}
+
+uint32_t vr41xx_read_tclock_counter(void)
+{
+	uint32_t first_high, first_low;
+	uint32_t second_high, second_low;
+
+	do {
+		first_low = (uint32_t)read_rtc2(TCLKCNTLREG);
+		first_high = (uint32_t)read_rtc2(TCLKCNTHREG);
+		second_low = (uint32_t)read_rtc2(TCLKCNTLREG);
+		second_high = (uint32_t)read_rtc2(TCLKCNTHREG);
+	} while (first_low != second_low || first_high != second_high);
+
+	return (first_high << 16) | first_low;
+}
+
+static void vr41xx_timer_ack(void)
+{
+	uint64_t cur;
+
+	write_rtc2(ELAPSEDTIME_INT, RTCINTREG);
+
+	previous_elapsedtime += (uint64_t)cycles_per_jiffy;
+	cycles_per_sec += cycles_per_jiffy;
+
+	if (cycles_per_sec >= CLOCK_TICK_RATE) {
+		cycles_per_sec = 0;
+		remainder_per_sec = REMAINDER_PER_SEC;
+	}
+
+	cycles_per_jiffy = 0;
+
+	do {
+		cycles_per_jiffy += CYCLES_PER_JIFFY;
+		if (remainder_per_sec > 0) {
+			cycles_per_jiffy++;
+			remainder_per_sec--;
+		}
+
+		cur = read_elapsedtime_counter();
+	} while (cur >= previous_elapsedtime + (uint64_t)cycles_per_jiffy);
+
+	write_elapsedtime_compare(previous_elapsedtime + (uint64_t)cycles_per_jiffy);
+}
+
+static void vr41xx_hpt_init(unsigned int count)
+{
+}
+
+static unsigned int vr41xx_hpt_read(void)
+{
+	uint64_t cur;
+
+	cur = read_elapsedtime_counter();
+
+	return (unsigned int)cur;
+}
+
+static unsigned long vr41xx_gettimeoffset(void)
+{
+	uint64_t cur;
+	unsigned long gap;
+
+	cur = read_elapsedtime_counter();
+	gap = (unsigned long)(cur - previous_elapsedtime);
+	gap = gap / CYCLES_PER_100USEC * 100;	/* usec */
+
+	return gap;
+}
+
+static unsigned long vr41xx_get_time(void)
+{
+	uint64_t counts;
+
+	counts = read_elapsedtime_counter();
+	counts >>= 15;
+
+	return epoch_time + (unsigned long)counts;
+
+}
+
+static int vr41xx_set_time(unsigned long sec)
+{
+	if (sec < epoch_time)
+		return -EINVAL;
+
+	sec -= epoch_time;
+
+	write_elapsedtime_counter((uint64_t)sec << 15);
+
+	return 0;
+}
+
+void vr41xx_set_epoch_time(unsigned long time)
+{
+	epoch_time = time;
+}
+
+void __init vr41xx_time_init(void)
+{
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		rtc1_base = VR4111_ETIMELREG;
+		rtc2_base = VR4111_TCLKLREG;
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		rtc1_base = VR4122_ETIMELREG;
+		rtc2_base = VR4122_TCLKLREG;
+		break;
+	default:
+		panic("Unexpected CPU of NEC VR4100 series");
+		break;
+	}
+
+	mips_timer_ack = vr41xx_timer_ack;
+
+	mips_hpt_init = vr41xx_hpt_init;
+	mips_hpt_read = vr41xx_hpt_read;
+	mips_hpt_frequency = CLOCK_TICK_RATE;
+
+	if (epoch_time == 0)
+		epoch_time = mktime(1970, 1, 1, 0, 0, 0);
+
+	rtc_get_time = vr41xx_get_time;
+	rtc_set_time = vr41xx_set_time;
+}
+
+void __init vr41xx_timer_setup(struct irqaction *irq)
+{
+	do_gettimeoffset = vr41xx_gettimeoffset;
+
+	remainder_per_sec = REMAINDER_PER_SEC;
+	cycles_per_jiffy = CYCLES_PER_JIFFY;
+
+	if (remainder_per_sec > 0) {
+		cycles_per_jiffy++;
+		remainder_per_sec--;
+	}
+
+	previous_elapsedtime = read_elapsedtime_counter();
+	write_elapsedtime_compare(previous_elapsedtime + (uint64_t)cycles_per_jiffy);
+	write_rtc2(ELAPSEDTIME_INT, RTCINTREG);
+
+	setup_irq(ELAPSEDTIME_IRQ, irq);
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/time.c linux/arch/mips/vr41xx/common/time.c
--- linux.orig/arch/mips/vr41xx/common/time.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/common/time.c	Thu Jan  1 09:00:00 1970
@@ -1,95 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/common/time.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Timer routines for the NEC VR4100 series.
- *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
- *
- * Copyright 2001,2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4100 series are supported.
- *  - Added support for NEC VR4100 series RTC Unit.
- *
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - Added support for NEC VR4133.
- */
-#include <linux/config.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/types.h>
-
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/param.h>
-#include <asm/time.h>
-#include <asm/vr41xx/vr41xx.h>
-
-#define VR4111_ETIMELREG	KSEG1ADDR(0x0b0000c0)
-#define VR4122_ETIMELREG	KSEG1ADDR(0x0f000100)
-
-u32 vr41xx_rtc_base = 0;
-
-#ifdef CONFIG_VR41XX_RTC
-extern unsigned long vr41xx_rtc_get_time(void);
-extern int vr41xx_rtc_set_time(unsigned long sec);
-#endif
-
-void vr41xx_time_init(void)
-{
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		vr41xx_rtc_base = VR4111_ETIMELREG;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-                vr41xx_rtc_base = VR4122_ETIMELREG;
-                break;
-        default:
-                panic("Unexpected CPU of NEC VR4100 series");
-                break;
-        }
-
-#ifdef CONFIG_VR41XX_RTC
-        rtc_get_time = vr41xx_rtc_get_time;
-        rtc_set_time = vr41xx_rtc_set_time;
-#endif
-}
-
-void vr41xx_timer_setup(struct irqaction *irq)
-{
-	u32 count;
-
-	setup_irq(MIPS_COUNTER_IRQ, irq);
-
-	count = read_c0_count();
-	write_c0_compare(count + (mips_hpt_frequency / HZ));
-}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux.orig/include/asm-mips/vr41xx/vr41xx.h	Fri Oct 31 11:28:51 2003
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Tue Dec  2 01:19:39 2003
@@ -7,6 +7,7 @@
  * Copyright (C) 2001, 2002 Paul Mundt
  * Copyright (C) 2002 MontaVista Software, Inc.
  * Copyright (C) 2002 TimeSys Corp.
+ * Copyright (C) 2003 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -45,6 +46,8 @@
  * Bus Control Uint
  */
 extern void vr41xx_bcu_init(void);
+extern unsigned long vr41xx_get_vtclock_frequency(void);
+extern unsigned long vr41xx_get_tclock_frequency(void);
 
 /*
  * Clock Mask Unit
@@ -90,6 +93,8 @@
 /* RFU */
 #define POWER_IRQ		SYSINT1_IRQ(1)
 /* RFU */
+#define ELAPSEDTIME_IRQ		SYSINT1_IRQ(3)
+/* RFU */
 #define GIUINT_CASCADE_IRQ	SYSINT1_IRQ(8)
 #define SIU_IRQ			SYSINT1_IRQ(9)
 /* RFU */
@@ -121,7 +126,19 @@
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
 
 /*
- * Gegeral-Purpose I/O Unit
+ * RTC
+ */
+extern void vr41xx_set_rtclong1_cycle(uint32_t cycles);
+extern uint32_t vr41xx_read_rtclong1_counter(void);
+
+extern void vr41xx_set_rtclong2_cycle(uint32_t cycles);
+extern uint32_t vr41xx_read_rtclong2_counter(void);
+
+extern void vr41xx_set_tclock_cycle(uint32_t cycles);
+extern uint32_t vr41xx_read_tclock_counter(void);
+
+/*
+ * General-Purpose I/O Unit
  */
 extern void vr41xx_enable_giuint(int pin);
 extern void vr41xx_disable_giuint(int pin);

--Multipart=_Tue__2_Dec_2003_01_49_35_+0900_O8rOD56eF1FAQzKz
Content-Type: text/plain;
 name="00-vr41xx_time-v26.diff"
Content-Disposition: attachment;
 filename="00-vr41xx_time-v26.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux.orig/arch/mips/Kconfig	Tue Nov 18 12:33:51 2003
+++ linux/arch/mips/Kconfig	Tue Dec  2 01:33:06 2003
@@ -724,11 +724,6 @@
 	depends on MOMENCO_JAGUAR_ATX || MOMENCO_OCELOT || MOMENCO_OCELOT_G
 	default y
 
-config VR41XX_TIME_C
-	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || NEC_EAGLE || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226 || TANBAC_TB0229
-	default y
-
 config DUMMY_KEYB
 	bool
 	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SIBYTE_SB1xxx_SOC || NEC_EAGLE || NEC_OSPREY || DDB5477 || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226 || TANBAC_TB0229
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/Makefile linux/arch/mips/vr41xx/common/Makefile
--- linux.orig/arch/mips/vr41xx/common/Makefile	Tue Nov 18 12:34:22 2003
+++ linux/arch/mips/vr41xx/common/Makefile	Tue Dec  2 01:33:06 2003
@@ -2,9 +2,8 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o giu.o icu.o int-handler.o reset.o
+obj-y				+= bcu.o cmu.o giu.o icu.o int-handler.o ksyms.o reset.o rtc.o
 obj-$(CONFIG_SERIAL_8250)	+= serial.o
-obj-$(CONFIG_VR41XX_TIME_C)	+= time.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/bcu.c linux/arch/mips/vr41xx/common/bcu.c
--- linux.orig/arch/mips/vr41xx/common/bcu.c	Fri Oct 31 11:30:38 2003
+++ linux/arch/mips/vr41xx/common/bcu.c	Tue Dec  2 01:33:07 2003
@@ -36,20 +36,15 @@
  *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
- *  Paul Mundt <lethal@chaoticdreams.org>
- *  - Calculate mips_hpt_frequency properly on VR4131.
- *
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/types.h>
 
-#include <asm/addrspace.h>
 #include <asm/cpu.h>
 #include <asm/io.h>
-#include <asm/time.h>
-#include <asm/vr41xx/vr41xx.h>
 
 #define VR4111_CLKSPEEDREG	KSEG1ADDR(0x0b000014)
 #define VR4122_CLKSPEEDREG	KSEG1ADDR(0x0f000014)
@@ -66,9 +61,20 @@
  #define TDIVMODE(x)		(2 << (((x) & 0x1000) >> 12))
  #define VTDIVMODE(x)		(((x) & 0x0700) >> 8)
 
-unsigned long vr41xx_vtclock = 0;
+static unsigned long vr41xx_vtclock;
+static unsigned long vr41xx_tclock;
 
-static inline u16 read_clkspeed(void)
+unsigned long vr41xx_get_vtclock_frequency(void)
+{
+	return vr41xx_vtclock;
+}
+
+unsigned long vr41xx_get_tclock_frequency(void)
+{
+	return vr41xx_tclock;
+}
+
+static inline uint16_t read_clkspeed(void)
 {
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
@@ -84,7 +90,7 @@
 	return 0;
 }
 
-static inline unsigned long calculate_pclock(u16 clkspeed)
+static inline unsigned long calculate_pclock(uint16_t clkspeed)
 {
 	unsigned long pclock = 0;
 
@@ -134,46 +140,48 @@
 	return pclock;
 }
 
-static inline unsigned long calculate_vtclock(u16 clkspeed, unsigned long pclock)
+static inline unsigned long calculate_vtclock(uint16_t clkspeed, unsigned long pclock)
 {
+	unsigned long vtclock = 0;
+
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 		/* The NEC VR4111 doesn't have the VTClock. */
 		break;
 	case CPU_VR4121:
-		vr41xx_vtclock = pclock;
+		vtclock = pclock;
 		/* DIVVT == 9 Divide by 1.5 . VTClock = (PClock * 6) / 9 */
 		if (DIVVT(clkspeed) == 9)
-			vr41xx_vtclock = pclock * 6;
+			vtclock = pclock * 6;
 		/* DIVVT == 10 Divide by 2.5 . VTClock = (PClock * 4) / 10 */
 		else if (DIVVT(clkspeed) == 10)
-			vr41xx_vtclock = pclock * 4;
-		vr41xx_vtclock /= DIVVT(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
+			vtclock = pclock * 4;
+		vtclock /= DIVVT(clkspeed);
+		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
 		break;
 	case CPU_VR4122:
 		if(VTDIVMODE(clkspeed) == 7)
-			vr41xx_vtclock = pclock / 1;
+			vtclock = pclock / 1;
 		else if(VTDIVMODE(clkspeed) == 1)
-			vr41xx_vtclock = pclock / 2;
+			vtclock = pclock / 2;
 		else
-			vr41xx_vtclock = pclock / VTDIVMODE(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
+			vtclock = pclock / VTDIVMODE(clkspeed);
+		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
 		break;
 	case CPU_VR4131:
 	case CPU_VR4133:
-		vr41xx_vtclock = pclock / VTDIVMODE(clkspeed);
-		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
+		vtclock = pclock / VTDIVMODE(clkspeed);
+		printk(KERN_INFO "VTClock: %ldHz\n", vtclock);
 		break;
 	default:
 		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 		break;
 	}
 
-	return vr41xx_vtclock;
+	return vtclock;
 }
 
-static inline unsigned long calculate_tclock(u16 clkspeed, unsigned long pclock,
+static inline unsigned long calculate_tclock(uint16_t clkspeed, unsigned long pclock,
                                              unsigned long vtclock)
 {
 	unsigned long tclock = 0;
@@ -205,30 +213,14 @@
 	return tclock;
 }
 
-static inline unsigned long calculate_mips_hpt_frequency(unsigned long tclock)
-{
-	/*
-	 * VR4131 Revision 2.0 and 2.1 use a value of (tclock / 2).
-	 */
-	if ((current_cpu_data.processor_id == PRID_VR4131_REV2_0) ||
-	    (current_cpu_data.processor_id == PRID_VR4131_REV2_1))
-		tclock /= 2;
-	else
-		tclock /= 4;
-
-	return tclock;
-}
-
 void __init vr41xx_bcu_init(void)
 {
-	unsigned long pclock, vtclock, tclock;
-	u16 clkspeed;
+	unsigned long pclock;
+	uint16_t clkspeed;
 
 	clkspeed = read_clkspeed();
 
 	pclock = calculate_pclock(clkspeed);
-	vtclock = calculate_vtclock(clkspeed, pclock);
-	tclock = calculate_tclock(clkspeed, pclock, vtclock);
-
-	mips_hpt_frequency = calculate_mips_hpt_frequency(tclock);
+	vr41xx_vtclock = calculate_vtclock(clkspeed, pclock);
+	vr41xx_tclock = calculate_tclock(clkspeed, pclock, vr41xx_vtclock);
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/ksyms.c linux/arch/mips/vr41xx/common/ksyms.c
--- linux.orig/arch/mips/vr41xx/common/ksyms.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/common/ksyms.c	Tue Dec  2 01:33:07 2003
@@ -0,0 +1,33 @@
+/*
+ *   ksyms.c, Export NEC VR4100 series specific functions needed for loadable modules.
+ *
+ *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <asm/vr41xx/vr41xx.h>
+
+EXPORT_SYMBOL(vr41xx_get_vtclock_frequency);
+EXPORT_SYMBOL(vr41xx_get_tclock_frequency);
+
+EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
+EXPORT_SYMBOL(vr41xx_read_rtclong1_counter);
+EXPORT_SYMBOL(vr41xx_set_rtclong2_cycle);
+EXPORT_SYMBOL(vr41xx_read_rtclong2_counter);
+EXPORT_SYMBOL(vr41xx_set_tclock_cycle);
+EXPORT_SYMBOL(vr41xx_read_tclock_counter);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/rtc.c linux/arch/mips/vr41xx/common/rtc.c
--- linux.orig/arch/mips/vr41xx/common/rtc.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/common/rtc.c	Tue Dec  2 01:33:07 2003
@@ -0,0 +1,310 @@
+/*
+ *  rtc.c, RTC(has only timer function) routines for NEC VR4100 series.
+ *
+ *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/vr41xx/vr41xx.h>
+
+static uint32_t rtc1_base;
+static uint32_t rtc2_base;
+
+static uint64_t previous_elapsedtime;
+static unsigned int remainder_per_sec;
+static unsigned int cycles_per_sec;
+static unsigned int cycles_per_jiffy;
+static unsigned long epoch_time;
+
+#define CYCLES_PER_JIFFY	(CLOCK_TICK_RATE / HZ)
+#define REMAINDER_PER_SEC	(CLOCK_TICK_RATE - (CYCLES_PER_JIFFY * HZ))
+#define CYCLES_PER_100USEC	((CLOCK_TICK_RATE + (10000 / 2)) / 10000)
+
+#define VR4111_ETIMELREG	KSEG1ADDR(0x0b0000c0)
+#define VR4111_TCLKLREG		KSEG1ADDR(0x0b0001c0)
+
+#define VR4122_ETIMELREG	KSEG1ADDR(0x0f000100)
+#define VR4122_TCLKLREG		KSEG1ADDR(0x0f000120)
+
+/* RTC 1 registers */
+#define ETIMELREG		0x00
+#define ETIMEMREG		0x02
+#define ETIMEHREG		0x04
+/* RFU */
+#define ECMPLREG		0x08
+#define ECMPMREG		0x0a
+#define ECMPHREG		0x0c
+/* RFU */
+#define RTCL1LREG		0x10
+#define RTCL1HREG		0x12
+#define RTCL1CNTLREG		0x14
+#define RTCL1CNTHREG		0x16
+#define RTCL2LREG		0x18
+#define RTCL2HREG		0x1a
+#define RTCL2CNTLREG		0x1c
+#define RTCL2CNTHREG		0x1e
+
+/* RTC 2 registers */
+#define TCLKLREG		0x00
+#define TCLKHREG		0x02
+#define TCLKCNTLREG		0x04
+#define TCLKCNTHREG		0x06
+/* RFU */
+#define RTCINTREG		0x1e
+ #define TCLOCK_INT		0x08
+ #define RTCLONG2_INT		0x04
+ #define RTCLONG1_INT		0x02
+ #define ELAPSEDTIME_INT	0x01
+
+#define read_rtc1(offset)	readw(rtc1_base + (offset))
+#define write_rtc1(val, offset)	writew((val), rtc1_base + (offset))
+
+#define read_rtc2(offset)	readw(rtc2_base + (offset))
+#define write_rtc2(val, offset)	writew((val), rtc2_base + (offset))
+
+static inline uint64_t read_elapsedtime_counter(void)
+{
+	uint64_t first, second;
+	uint32_t first_mid, first_low;
+	uint32_t second_mid, second_low;
+
+	do {
+		first_low = (uint32_t)read_rtc1(ETIMELREG);
+		first_mid = (uint32_t)read_rtc1(ETIMEMREG);
+		first = (uint64_t)read_rtc1(ETIMEHREG);
+		second_low = (uint32_t)read_rtc1(ETIMELREG);
+		second_mid = (uint32_t)read_rtc1(ETIMEMREG);
+		second = (uint64_t)read_rtc1(ETIMEHREG);
+	} while (first_low != second_low || first_mid != second_mid ||
+	         first != second);
+
+	return (first << 32) | (uint64_t)((first_mid << 16) | first_low);
+}
+
+static inline void write_elapsedtime_counter(uint64_t time)
+{
+	write_rtc1((uint16_t)time, ETIMELREG);
+	write_rtc1((uint16_t)(time >> 16), ETIMEMREG);
+	write_rtc1((uint16_t)(time >> 32), ETIMEHREG);
+}
+
+static inline void write_elapsedtime_compare(uint64_t time)
+{
+	write_rtc1((uint16_t)time, ECMPLREG);
+	write_rtc1((uint16_t)(time >> 16), ECMPMREG);
+	write_rtc1((uint16_t)(time >> 32), ECMPHREG);
+}
+
+void vr41xx_set_rtclong1_cycle(uint32_t cycles)
+{
+	write_rtc1((uint16_t)cycles, RTCL1LREG);
+	write_rtc1((uint16_t)(cycles >> 16), RTCL1HREG);
+}
+
+uint32_t vr41xx_read_rtclong1_counter(void)
+{
+	uint32_t first_high, first_low;
+	uint32_t second_high, second_low;
+
+	do {
+		first_low = (uint32_t)read_rtc1(RTCL1CNTLREG);
+		first_high = (uint32_t)read_rtc1(RTCL1CNTHREG);
+		second_low = (uint32_t)read_rtc1(RTCL1CNTLREG);
+		second_high = (uint32_t)read_rtc1(RTCL1CNTHREG);
+	} while (first_low != second_low || first_high != second_high);
+
+	return (first_high << 16) | first_low;
+}
+
+void vr41xx_set_rtclong2_cycle(uint32_t cycles)
+{
+	write_rtc1((uint16_t)cycles, RTCL2LREG);
+	write_rtc1((uint16_t)(cycles >> 16), RTCL2HREG);
+}
+
+uint32_t vr41xx_read_rtclong2_counter(void)
+{
+	uint32_t first_high, first_low;
+	uint32_t second_high, second_low;
+
+	do {
+		first_low = (uint32_t)read_rtc1(RTCL2CNTLREG);
+		first_high = (uint32_t)read_rtc1(RTCL2CNTHREG);
+		second_low = (uint32_t)read_rtc1(RTCL2CNTLREG);
+		second_high = (uint32_t)read_rtc1(RTCL2CNTHREG);
+	} while (first_low != second_low || first_high != second_high);
+
+	return (first_high << 16) | first_low;
+}
+
+void vr41xx_set_tclock_cycle(uint32_t cycles)
+{
+	write_rtc2((uint16_t)cycles, TCLKLREG);
+	write_rtc2((uint16_t)(cycles >> 16), TCLKHREG);
+}
+
+uint32_t vr41xx_read_tclock_counter(void)
+{
+	uint32_t first_high, first_low;
+	uint32_t second_high, second_low;
+
+	do {
+		first_low = (uint32_t)read_rtc2(TCLKCNTLREG);
+		first_high = (uint32_t)read_rtc2(TCLKCNTHREG);
+		second_low = (uint32_t)read_rtc2(TCLKCNTLREG);
+		second_high = (uint32_t)read_rtc2(TCLKCNTHREG);
+	} while (first_low != second_low || first_high != second_high);
+
+	return (first_high << 16) | first_low;
+}
+
+static void vr41xx_timer_ack(void)
+{
+	uint64_t cur;
+
+	write_rtc2(ELAPSEDTIME_INT, RTCINTREG);
+
+	previous_elapsedtime += (uint64_t)cycles_per_jiffy;
+	cycles_per_sec += cycles_per_jiffy;
+
+	if (cycles_per_sec >= CLOCK_TICK_RATE) {
+		cycles_per_sec = 0;
+		remainder_per_sec = REMAINDER_PER_SEC;
+	}
+
+	cycles_per_jiffy = 0;
+
+	do {
+		cycles_per_jiffy += CYCLES_PER_JIFFY;
+		if (remainder_per_sec > 0) {
+			cycles_per_jiffy++;
+			remainder_per_sec--;
+		}
+
+		cur = read_elapsedtime_counter();
+	} while (cur >= previous_elapsedtime + (uint64_t)cycles_per_jiffy);
+
+	write_elapsedtime_compare(previous_elapsedtime + (uint64_t)cycles_per_jiffy);
+}
+
+static void vr41xx_hpt_init(unsigned int count)
+{
+}
+
+static unsigned int vr41xx_hpt_read(void)
+{
+	uint64_t cur;
+
+	cur = read_elapsedtime_counter();
+
+	return (unsigned int)cur;
+}
+
+static unsigned long vr41xx_gettimeoffset(void)
+{
+	uint64_t cur;
+	unsigned long gap;
+
+	cur = read_elapsedtime_counter();
+	gap = (unsigned long)(cur - previous_elapsedtime);
+	gap = gap / CYCLES_PER_100USEC * 100;	/* usec */
+
+	return gap;
+}
+
+static unsigned long vr41xx_get_time(void)
+{
+	uint64_t counts;
+
+	counts = read_elapsedtime_counter();
+	counts >>= 15;
+
+	return epoch_time + (unsigned long)counts;
+
+}
+
+static int vr41xx_set_time(unsigned long sec)
+{
+	if (sec < epoch_time)
+		return -EINVAL;
+
+	sec -= epoch_time;
+
+	write_elapsedtime_counter((uint64_t)sec << 15);
+
+	return 0;
+}
+
+void vr41xx_set_epoch_time(unsigned long time)
+{
+	epoch_time = time;
+}
+
+void __init vr41xx_time_init(void)
+{
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		rtc1_base = VR4111_ETIMELREG;
+		rtc2_base = VR4111_TCLKLREG;
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		rtc1_base = VR4122_ETIMELREG;
+		rtc2_base = VR4122_TCLKLREG;
+		break;
+	default:
+		panic("Unexpected CPU of NEC VR4100 series");
+		break;
+	}
+
+	mips_timer_ack = vr41xx_timer_ack;
+
+	mips_hpt_init = vr41xx_hpt_init;
+	mips_hpt_read = vr41xx_hpt_read;
+	mips_hpt_frequency = CLOCK_TICK_RATE;
+
+	if (epoch_time == 0)
+		epoch_time = mktime(1970, 1, 1, 0, 0, 0);
+
+	rtc_get_time = vr41xx_get_time;
+	rtc_set_time = vr41xx_set_time;
+}
+
+void __init vr41xx_timer_setup(struct irqaction *irq)
+{
+	do_gettimeoffset = vr41xx_gettimeoffset;
+
+	remainder_per_sec = REMAINDER_PER_SEC;
+	cycles_per_jiffy = CYCLES_PER_JIFFY;
+
+	if (remainder_per_sec > 0) {
+		cycles_per_jiffy++;
+		remainder_per_sec--;
+	}
+
+	previous_elapsedtime = read_elapsedtime_counter();
+	write_elapsedtime_compare(previous_elapsedtime + (uint64_t)cycles_per_jiffy);
+	write_rtc2(ELAPSEDTIME_INT, RTCINTREG);
+
+	setup_irq(ELAPSEDTIME_IRQ, irq);
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/time.c linux/arch/mips/vr41xx/common/time.c
--- linux.orig/arch/mips/vr41xx/common/time.c	Fri Oct 31 11:30:39 2003
+++ linux/arch/mips/vr41xx/common/time.c	Thu Jan  1 09:00:00 1970
@@ -1,95 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/common/time.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Timer routines for the NEC VR4100 series.
- *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
- *
- * Copyright 2001,2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4100 series are supported.
- *  - Added support for NEC VR4100 series RTC Unit.
- *
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - Added support for NEC VR4133.
- */
-#include <linux/config.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/types.h>
-
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/param.h>
-#include <asm/time.h>
-#include <asm/vr41xx/vr41xx.h>
-
-#define VR4111_ETIMELREG	KSEG1ADDR(0x0b0000c0)
-#define VR4122_ETIMELREG	KSEG1ADDR(0x0f000100)
-
-u32 vr41xx_rtc_base = 0;
-
-#ifdef CONFIG_VR41XX_RTC
-extern unsigned long vr41xx_rtc_get_time(void);
-extern int vr41xx_rtc_set_time(unsigned long sec);
-#endif
-
-void vr41xx_time_init(void)
-{
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		vr41xx_rtc_base = VR4111_ETIMELREG;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-                vr41xx_rtc_base = VR4122_ETIMELREG;
-                break;
-        default:
-                panic("Unexpected CPU of NEC VR4100 series");
-                break;
-        }
-
-#ifdef CONFIG_VR41XX_RTC
-        rtc_get_time = vr41xx_rtc_get_time;
-        rtc_set_time = vr41xx_rtc_set_time;
-#endif
-}
-
-void vr41xx_timer_setup(struct irqaction *irq)
-{
-	u32 count;
-
-	setup_irq(MIPS_COUNTER_IRQ, irq);
-
-	count = read_c0_count();
-	write_c0_compare(count + (mips_hpt_frequency / HZ));
-}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/mach-vr41xx/timex.h linux/include/asm-mips/mach-vr41xx/timex.h
--- linux.orig/include/asm-mips/mach-vr41xx/timex.h	Tue Nov 18 10:17:48 2003
+++ linux/include/asm-mips/mach-vr41xx/timex.h	Tue Dec  2 01:33:07 2003
@@ -5,9 +5,14 @@
  *
  * Copyright (C) 2003 by Ralf Baechle
  */
+/*
+ * Changes:
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - CLOCK_TICK_RATE is changed into 32768 from 6144000.
+ */
 #ifndef __ASM_MACH_VR41XX_TIMEX_H
 #define __ASM_MACH_VR41XX_TIMEX_H
 
-#define CLOCK_TICK_RATE		6144000
+#define CLOCK_TICK_RATE		32768
 
 #endif /* __ASM_MACH_VR41XX_TIMEX_H */
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux.orig/include/asm-mips/vr41xx/vr41xx.h	Tue Nov 18 12:34:50 2003
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Tue Dec  2 01:33:08 2003
@@ -7,6 +7,7 @@
  * Copyright (C) 2001, 2002 Paul Mundt
  * Copyright (C) 2002 MontaVista Software, Inc.
  * Copyright (C) 2002 TimeSys Corp.
+ * Copyright (C) 2003 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -45,6 +46,8 @@
  * Bus Control Uint
  */
 extern void vr41xx_bcu_init(void);
+extern unsigned long vr41xx_get_vtclock_frequency(void);
+extern unsigned long vr41xx_get_tclock_frequency(void);
 
 /*
  * Clock Mask Unit
@@ -90,6 +93,8 @@
 /* RFU */
 #define POWER_IRQ		SYSINT1_IRQ(1)
 /* RFU */
+#define ELAPSEDTIME_IRQ		SYSINT1_IRQ(3)
+/* RFU */
 #define GIUINT_CASCADE_IRQ	SYSINT1_IRQ(8)
 #define SIU_IRQ			SYSINT1_IRQ(9)
 /* RFU */
@@ -119,6 +124,18 @@
 
 extern void (*board_irq_init)(void);
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
+
+/*
+ * RTC
+ */
+extern void vr41xx_set_rtclong1_cycle(uint32_t cycles);
+extern uint32_t vr41xx_read_rtclong1_counter(void);
+
+extern void vr41xx_set_rtclong2_cycle(uint32_t cycles);
+extern uint32_t vr41xx_read_rtclong2_counter(void);
+
+extern void vr41xx_set_tclock_cycle(uint32_t cycles);
+extern uint32_t vr41xx_read_tclock_counter(void);
 
 /*
  * Gegeral-Purpose I/O Unit

--Multipart=_Tue__2_Dec_2003_01_49_35_+0900_O8rOD56eF1FAQzKz--
