Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2004 16:40:54 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:29683 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225300AbUBTQky>;
	Fri, 20 Feb 2004 16:40:54 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA21725;
	Sat, 21 Feb 2004 01:40:50 +0900 (JST)
Received: 4UMDO01 id i1KGen800573; Sat, 21 Feb 2004 01:40:49 +0900 (JST)
Received: 4UMRO01 id i1KGem706592; Sat, 21 Feb 2004 01:40:49 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sat, 21 Feb 2004 01:40:34 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Changed clock function for vr41xx
Message-Id: <20040221014034.2144a075.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Rlaf,

I made a patch for vr41xx.
This patch changes a clock function for a power management.
This patch makes the same change as patch of 2.4 sent before.

Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/pci-vr41xx.c linux/arch/mips/pci/pci-vr41xx.c
--- linux-orig/arch/mips/pci/pci-vr41xx.c	Fri Feb 20 00:49:46 2004
+++ linux/arch/mips/pci/pci-vr41xx.c	Sat Feb 21 01:11:22 2004
@@ -159,7 +159,7 @@
 	writew(0, MPCIINTREG);
 
 	/* Supply VTClock to PCIU */
-	vr41xx_clock_supply(PCIU_CLOCK);
+	vr41xx_supply_clock(PCIU_CLOCK);
 
 	/*
 	 * Sleep for 1us after setting MSKPPCIU bit in CMUCLKMSK
@@ -179,7 +179,7 @@
 		printk(KERN_INFO "Warning: PCI Clock is over 33MHz.\n");
 
 	/* Supply PCI clock by PCI bus */
-	vr41xx_clock_supply(PCI_CLOCK);
+	vr41xx_supply_clock(PCI_CLOCK);
 
 	/*
 	 * Set PCI memory & I/O space address conversion registers
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/cmu.c linux/arch/mips/vr41xx/common/cmu.c
--- linux-orig/arch/mips/vr41xx/common/cmu.c	Tue Jan 13 08:21:05 2004
+++ linux/arch/mips/vr41xx/common/cmu.c	Sat Feb 21 01:07:00 2004
@@ -1,34 +1,23 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/cmu.c
+ *  cmu.c, Clock Mask Unit routines for the NEC VR4100 series.
  *
- * BRIEF MODULE DESCRIPTION
- *	Clock Mask Unit routines for the NEC VR4100 series.
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
+ *  Copyright (C) 2001-2002  MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
+ *  Copuright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
  */
 /*
  * Changes:
@@ -41,6 +30,7 @@
  */
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
@@ -67,16 +57,19 @@
  #define MSKMAC0	0x0002
  #define MSKMAC1	0x0004
 
-static u32 vr41xx_cmu_base;
-static u16 cmuclkmsk, cmuclkmsk2;
+static uint32_t cmu_base;
+static uint16_t cmuclkmsk, cmuclkmsk2;
+static spinlock_t cmu_lock;
 
-#define read_cmuclkmsk()	readw(vr41xx_cmu_base)
+#define read_cmuclkmsk()	readw(cmu_base)
 #define read_cmuclkmsk2()	readw(CMUCLKMSK2)
-#define write_cmuclkmsk()	writew(cmuclkmsk, vr41xx_cmu_base)
+#define write_cmuclkmsk()	writew(cmuclkmsk, cmu_base)
 #define write_cmuclkmsk2()	writew(cmuclkmsk2, CMUCLKMSK2)
 
-void vr41xx_clock_supply(unsigned int clock)
+void vr41xx_supply_clock(vr41xx_clock_t clock)
 {
+	spin_lock_irq(&cmu_lock);
+
 	switch (clock) {
 	case PIU_CLOCK:
 		cmuclkmsk |= MSKPIU;
@@ -130,10 +123,14 @@
 		write_cmuclkmsk2();
 	else
 		write_cmuclkmsk();
+
+	spin_unlock_irq(&cmu_lock);
 }
 
-void vr41xx_clock_mask(unsigned int clock)
+void vr41xx_mask_clock(vr41xx_clock_t clock)
 {
+	spin_lock_irq(&cmu_lock);
+
 	switch (clock) {
 	case PIU_CLOCK:
 		cmuclkmsk &= ~MSKPIU;
@@ -199,6 +196,8 @@
 		write_cmuclkmsk2();
 	else
 		write_cmuclkmsk();
+
+	spin_unlock_irq(&cmu_lock);
 }
 
 void __init vr41xx_cmu_init(void)
@@ -206,14 +205,14 @@
 	switch (current_cpu_data.cputype) {
         case CPU_VR4111:
         case CPU_VR4121:
-                vr41xx_cmu_base = CMUCLKMSK_TYPE1;
+                cmu_base = CMUCLKMSK_TYPE1;
                 break;
         case CPU_VR4122:
         case CPU_VR4131:
-                vr41xx_cmu_base = CMUCLKMSK_TYPE2;
+                cmu_base = CMUCLKMSK_TYPE2;
                 break;
         case CPU_VR4133:
-                vr41xx_cmu_base = CMUCLKMSK_TYPE2;
+                cmu_base = CMUCLKMSK_TYPE2;
 		cmuclkmsk2 = read_cmuclkmsk2();
                 break;
 	default:
@@ -222,4 +221,6 @@
         }
 
 	cmuclkmsk = read_cmuclkmsk();
+
+	spin_lock_init(&cmu_lock);
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux-orig/arch/mips/vr41xx/common/serial.c	Tue Jan 13 08:21:05 2004
+++ linux/arch/mips/vr41xx/common/serial.c	Sat Feb 21 01:09:41 2004
@@ -146,7 +146,7 @@
 	if (early_serial_setup(&s) != 0)
 		printk(KERN_ERR "SIU setup failed!\n");
 
-	vr41xx_clock_supply(SIU_CLOCK);
+	vr41xx_supply_clock(SIU_CLOCK);
 
 	vr41xx_serial_ports++;
 }
@@ -172,7 +172,7 @@
 	if (early_serial_setup(&s) != 0)
 		printk(KERN_ERR "DSIU setup failed!\n");
 
-	vr41xx_clock_supply(DSIU_CLOCK);
+	vr41xx_supply_clock(DSIU_CLOCK);
 
 	writew(INTDSIU, MDSIUINTREG);
 
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Sun Feb  1 21:41:46 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Sat Feb 21 01:08:54 2004
@@ -7,7 +7,7 @@
  * Copyright (C) 2001, 2002 Paul Mundt
  * Copyright (C) 2002 MontaVista Software, Inc.
  * Copyright (C) 2002 TimeSys Corp.
- * Copyright (C) 2003 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ * Copyright (C) 2003-2004 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -53,10 +53,8 @@
  * Clock Mask Unit
  */
 extern void vr41xx_cmu_init(void);
-extern void vr41xx_clock_supply(unsigned int clock);
-extern void vr41xx_clock_mask(unsigned int clock);
 
-enum {
+typedef enum {
 	PIU_CLOCK,
 	SIU_CLOCK,
 	AIU_CLOCK,
@@ -70,7 +68,10 @@
 	CEU_CLOCK,
 	ETHER0_CLOCK,
 	ETHER1_CLOCK
-};
+} vr41xx_clock_t;
+
+extern void vr41xx_supply_clock(vr41xx_clock_t clock);
+extern void vr41xx_mask_clock(vr41xx_clock_t clock);
 
 /*
  * Interrupt Control Unit
