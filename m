Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2003 15:17:43 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:18683 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225386AbTJ3PRL>;
	Thu, 30 Oct 2003 15:17:11 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA08380;
	Fri, 31 Oct 2003 00:17:03 +0900 (JST)
Received: 4UMDO01 id h9UFH1m14930; Fri, 31 Oct 2003 00:17:02 +0900 (JST)
Received: 4UMRO01 id h9UFGxd04967; Fri, 31 Oct 2003 00:17:00 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Fri, 31 Oct 2003 00:16:58 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [patch] VR4133
Message-Id: <20031031001658.23bf544c.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20031030004807.05974e01.yuasa@hh.iij4u.or.jp>
References: <20031008003402.23a326cb.yuasa@hh.iij4u.or.jp>
	<20031012151517.GA20647@linux-mips.org>
	<20031013020207.5887e42e.yuasa@hh.iij4u.or.jp>
	<20031016010533.5a772fef.yuasa@hh.iij4u.or.jp>
	<20031030004807.05974e01.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__31_Oct_2003_00_16_58_+0900_MB_RW/VX.w/mVD7N"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart=_Fri__31_Oct_2003_00_16_58_+0900_MB_RW/VX.w/mVD7N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I updated about VR4133 also for mips64 file of v2.4.

Yoichi

On Thu, 30 Oct 2003 00:48:07 +0900
Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:

> Hello Ralf,
> 
> I updated these patches for latest CVS tree.
> These patches add support of NEC VR4133 CPU.
> 
> Please apply these patches.
> 
> Yoichi
> 
> On Thu, 16 Oct 2003 01:05:33 +0900
> Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
> 
> > Hello Ralf,
> > 
> > I updated the patch about part of GIU for VR4133.
> > Please apply them to CVS tree.
> > 
> > Yoichi
> > 
> > On Mon, 13 Oct 2003 02:02:07 +0900
> > Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
> > 
> > > Hello Ralf,
> > > 
> > > On Sun, 12 Oct 2003 17:15:17 +0200
> > > Ralf Baechle <ralf@linux-mips.org> wrote:
> > > 
> > > > On Wed, Oct 08, 2003 at 12:34:02AM +0900, Yoichi Yuasa wrote:
> > > > 
> > > > > I made patches for NEC VR4133.
> > > > > These patches add support of new CPU of NEC.
> > > > > 
> > > > > Please apply this patch to CVS tree.
> > > > 
> > > > Please keep the 32-bit and 64-bit files in sync - even if you're not
> > > > using both.  Having them diverse is a huge pain.
> > > 
> > > OK, I updated these patches.
> > > 
> > > Please apply them to CVS.
> > > 
> > > Yoichi
> > > 
> > > 
> > 
> 

--Multipart=_Fri__31_Oct_2003_00_16_58_+0900_MB_RW/VX.w/mVD7N
Content-Type: text/plain;
 name="vr4133-v24-031031.diff"
Content-Disposition: attachment;
 filename="vr4133-v24-031031.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/cpu-probe.c linux/arch/mips/kernel/cpu-probe.c
--- linux.orig/arch/mips/kernel/cpu-probe.c	Tue Oct 14 11:58:38 2003
+++ linux/arch/mips/kernel/cpu-probe.c	Thu Oct 30 23:51:39 2003
@@ -220,8 +220,11 @@
 			else
 				c->cputype = CPU_VR4181A;
 			break;
-		case PRID_REV_VR4131:
-			c->cputype = CPU_VR4131;
+		case PRID_REV_VR4130:
+			if ((c->processor_id & 0xf) < 0x4)
+				c->cputype = CPU_VR4131;
+			else
+				c->cputype = CPU_VR4133;
 			break;
 		default:
 			printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/proc.c linux/arch/mips/kernel/proc.c
--- linux.orig/arch/mips/kernel/proc.c	Tue Oct 14 11:58:38 2003
+++ linux/arch/mips/kernel/proc.c	Thu Oct 30 23:51:39 2003
@@ -68,6 +68,7 @@
 	[CPU_VR4121]	"NEC VR4121",
 	[CPU_VR4122]	"NEC VR4122",
 	[CPU_VR4131]	"NEC VR4131",
+	[CPU_VR4133]	"NEC VR4133",
 	[CPU_VR4181]	"NEC VR4181",
 	[CPU_VR4181A]	"NEC VR4181A",
 	[CPU_SR71000]	"Sandcraft SR71000"
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux.orig/arch/mips/mm/c-r4k.c	Tue Oct 14 11:58:39 2003
+++ linux/arch/mips/mm/c-r4k.c	Thu Oct 30 23:51:40 2003
@@ -833,6 +833,8 @@
 		c->dcache.waybit = 0;
 		break;
 
+	case CPU_VR4133:
+		write_c0_config(config & ~CONF_EB);
 	case CPU_VR4131:
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux.orig/arch/mips/vr41xx/casio-e55/setup.c	Wed Jul 30 09:35:37 2003
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Thu Oct 30 23:51:40 2003
@@ -59,7 +59,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/bcu.c linux/arch/mips/vr41xx/common/bcu.c
--- linux.orig/arch/mips/vr41xx/common/bcu.c	Sat Aug 30 01:32:54 2003
+++ linux/arch/mips/vr41xx/common/bcu.c	Thu Oct 30 23:51:40 2003
@@ -33,13 +33,14 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
  *  Paul Mundt <lethal@chaoticdreams.org>
  *  - Calculate mips_hpt_frequency properly on VR4131.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
 #include <linux/types.h>
@@ -52,8 +53,8 @@
 
 #define VR4111_CLKSPEEDREG	KSEG1ADDR(0x0b000014)
 #define VR4122_CLKSPEEDREG	KSEG1ADDR(0x0f000014)
-#define VR4131_CLKSPEEDREG	VR4122_CLKSPEEDREG
  #define CLKSP(x)		((x) & 0x001f)
+ #define CLKSP_VR4133(x)	((x) & 0x0007)
 
  #define DIV2B			0x8000
  #define DIV3B			0x4000
@@ -72,8 +73,9 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121: return readw(VR4111_CLKSPEEDREG);
-	case CPU_VR4122: return readw(VR4122_CLKSPEEDREG);
-	case CPU_VR4131: return readw(VR4131_CLKSPEEDREG);
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133: return readw(VR4122_CLKSPEEDREG);
 	default:
 		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 		break;
@@ -90,19 +92,43 @@
 	case CPU_VR4111:
 	case CPU_VR4121:
 		pclock = 18432000 * 64;
+		pclock /= CLKSP(clkspeed);
 		break;
 	case CPU_VR4122:
 		pclock = 18432000 * 98;
+		pclock /= CLKSP(clkspeed);
 		break;
 	case CPU_VR4131:
 		pclock = 18432000 * 108;
+		pclock /= CLKSP(clkspeed);
+		break;
+	case CPU_VR4133:
+		switch (CLKSP_VR4133(clkspeed)) {
+		case 0:
+			pclock = 133000000;
+			break;
+		case 1:
+			pclock = 149000000;
+			break;
+		case 2:
+			pclock = 165900000;
+			break;
+		case 3:
+			pclock = 199100000;
+			break;
+		case 4:
+			pclock = 265900000;
+			break;
+		default:
+			printk(KERN_INFO "Unknown PClock speed for NEC VR4133\n");
+			break;
+		}
 		break;
 	default:
 		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 		break;
 	}
 
-	pclock /= CLKSP(clkspeed);
 	printk(KERN_INFO "PClock: %ldHz\n", pclock);
 
 	return pclock;
@@ -135,6 +161,7 @@
 		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
 		break;
 	case CPU_VR4131:
+	case CPU_VR4133:
 		vr41xx_vtclock = pclock / VTDIVMODE(clkspeed);
 		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
 		break;
@@ -165,6 +192,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		tclock = vtclock / TDIVMODE(clkspeed);
 		break;
 	default:
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/cmu.c linux/arch/mips/vr41xx/common/cmu.c
--- linux.orig/arch/mips/vr41xx/common/cmu.c	Mon Apr  7 09:17:06 2003
+++ linux/arch/mips/vr41xx/common/cmu.c	Thu Oct 30 23:51:40 2003
@@ -33,38 +33,174 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
 #include <asm/io.h>
+#include <asm/vr41xx/vr41xx.h>
 
 #define VR4111_CMUCLKMSK	KSEG1ADDR(0x0b000060)
 #define VR4122_CMUCLKMSK	KSEG1ADDR(0x0f000060)
+ #define MSKPIU			0x0001
+ #define MSKSIU			0x0002
+ #define MSKAIU			0x0004
+ #define MSKKIU			0x0008
+ #define MSKFIR			0x0010
+ #define MSKDSIU		0x0820
+ #define MSKCSI			0x0040
+ #define MSKPCIU		0x0080
+ #define MSKSSIU		0x0100
+ #define MSKSHSP		0x0200
+ #define MSKFFIR		0x0400
+ #define MSKSCSI		0x1000
+ #define MSKPPCIU		0x2000
+#define VR4133_CMUCLKMSK2	KSEG1ADDR(0x0f000064)
+ #define MSKCEU			0x0001
+ #define MSKMAC0		0x0002
+ #define MSKMAC1		0x0004
 
 static u32 vr41xx_cmu_base;
-static u16 cmuclkmsk;
+static u16 cmuclkmsk, cmuclkmsk2;
 
-#define write_cmu(mask)	writew((mask), vr41xx_cmu_base)
+#define read_cmuclkmsk()	readw(vr41xx_cmu_base)
+#define read_cmuclkmsk2()	readw(VR4133_CMUCLKMSK2)
+#define write_cmuclkmsk()	writew(cmuclkmsk, vr41xx_cmu_base)
+#define write_cmuclkmsk2()	writew(cmuclkmsk2, VR4133_CMUCLKMSK2)
 
-void vr41xx_clock_supply(u16 mask)
+void vr41xx_clock_supply(unsigned int clock)
 {
-	cmuclkmsk |= mask;
-	write_cmu(cmuclkmsk);
+	switch (clock) {
+	case PIU_CLOCK:
+		cmuclkmsk |= MSKPIU;
+		break;
+	case SIU_CLOCK:
+		cmuclkmsk |= MSKSIU | MSKSSIU;
+		break;
+	case AIU_CLOCK:
+		cmuclkmsk |= MSKAIU;
+		break;
+	case KIU_CLOCK:
+		cmuclkmsk |= MSKKIU;
+		break;
+	case FIR_CLOCK:
+		cmuclkmsk |= MSKFIR | MSKFFIR;
+		break;
+	case DSIU_CLOCK:
+		if (current_cpu_data.cputype == CPU_VR4111 ||
+		    current_cpu_data.cputype == CPU_VR4121)
+			cmuclkmsk |= MSKDSIU;
+		else
+			cmuclkmsk |= MSKSIU | MSKDSIU;
+		break;
+	case CSI_CLOCK:
+		cmuclkmsk |= MSKCSI | MSKSCSI;
+		break;
+	case PCIU_CLOCK:
+		cmuclkmsk |= MSKPCIU;
+		break;
+	case HSP_CLOCK:
+		cmuclkmsk |= MSKSHSP;
+		break;
+	case PCI_CLOCK:
+		cmuclkmsk |= MSKPPCIU;
+		break;
+	case CEU_CLOCK:
+		cmuclkmsk2 |= MSKCEU;
+		break;
+	case ETHER0_CLOCK:
+		cmuclkmsk2 |= MSKMAC0;
+		break;
+	case ETHER1_CLOCK:
+		cmuclkmsk2 |= MSKMAC1;
+		break;
+	default:
+		break;
+	}
+
+	if (clock == CEU_CLOCK || clock == ETHER0_CLOCK ||
+	    clock == ETHER1_CLOCK)
+		write_cmuclkmsk2();
+	else
+		write_cmuclkmsk();
 }
 
-void vr41xx_clock_mask(u16 mask)
+void vr41xx_clock_mask(unsigned int clock)
 {
-	cmuclkmsk &= ~mask;
-	write_cmu(cmuclkmsk);
+	switch (clock) {
+	case PIU_CLOCK:
+		cmuclkmsk &= ~MSKPIU;
+		break;
+	case SIU_CLOCK:
+		if (current_cpu_data.cputype == CPU_VR4111 ||
+		    current_cpu_data.cputype == CPU_VR4121) {
+			cmuclkmsk &= ~(MSKSIU | MSKSSIU);
+		} else {
+			if (cmuclkmsk & MSKDSIU)
+				cmuclkmsk &= ~MSKSSIU;
+			else
+				cmuclkmsk &= ~(MSKSIU | MSKSSIU);
+		}
+		break;
+	case AIU_CLOCK:
+		cmuclkmsk &= ~MSKAIU;
+		break;
+	case KIU_CLOCK:
+		cmuclkmsk &= ~MSKKIU;
+		break;
+	case FIR_CLOCK:
+		cmuclkmsk &= ~(MSKFIR | MSKFFIR);
+		break;
+	case DSIU_CLOCK:
+		if (current_cpu_data.cputype == CPU_VR4111 ||
+		    current_cpu_data.cputype == CPU_VR4121) {
+			cmuclkmsk &= ~MSKDSIU;
+		} else {
+			if (cmuclkmsk & MSKSIU)
+				cmuclkmsk &= ~MSKDSIU;
+			else
+				cmuclkmsk &= ~(MSKSIU | MSKDSIU);
+		}
+		break;
+	case CSI_CLOCK:
+		cmuclkmsk &= ~(MSKCSI | MSKSCSI);
+		break;
+	case PCIU_CLOCK:
+		cmuclkmsk &= ~MSKPCIU;
+		break;
+	case HSP_CLOCK:
+		cmuclkmsk &= ~MSKSHSP;
+		break;
+	case PCI_CLOCK:
+		cmuclkmsk &= ~MSKPPCIU;
+		break;
+	case CEU_CLOCK:
+		cmuclkmsk2 &= ~MSKCEU;
+		break;
+	case ETHER0_CLOCK:
+		cmuclkmsk2 &= ~MSKMAC0;
+		break;
+	case ETHER1_CLOCK:
+		cmuclkmsk2 &= ~MSKMAC1;
+		break;
+	default:
+		break;
+	}
+
+	if (clock == CEU_CLOCK || clock == ETHER0_CLOCK ||
+	    clock == ETHER1_CLOCK)
+		write_cmuclkmsk2();
+	else
+		write_cmuclkmsk();
 }
 
-void __init vr41xx_cmu_init(u16 mask)
+void __init vr41xx_cmu_init(void)
 {
 	switch (current_cpu_data.cputype) {
         case CPU_VR4111:
@@ -75,10 +211,14 @@
         case CPU_VR4131:
                 vr41xx_cmu_base = VR4122_CMUCLKMSK;
                 break;
+        case CPU_VR4133:
+                vr41xx_cmu_base = VR4122_CMUCLKMSK;
+		cmuclkmsk2 = read_cmuclkmsk2();
+                break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
 		break;
         }
 
-	cmuclkmsk = mask;
+	cmuclkmsk = read_cmuclkmsk();
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux.orig/arch/mips/vr41xx/common/giu.c	Wed Apr 16 21:59:34 2003
+++ linux/arch/mips/vr41xx/common/giu.c	Thu Oct 30 23:51:40 2003
@@ -34,6 +34,9 @@
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
  *  - New creation, NEC VR4111, VR4121, VR4122 and VR4131 are supported.
+ *
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -246,6 +249,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		vr41xx_giu_base = VR4122_GIUIOSELL;
 		break;
 	default:
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux.orig/arch/mips/vr41xx/common/icu.c	Wed Apr 16 21:59:34 2003
+++ linux/arch/mips/vr41xx/common/icu.c	Thu Oct 30 23:51:40 2003
@@ -33,13 +33,14 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
  *  Paul Mundt <lethal@chaoticdreams.org>
  *  - kgdb support.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -290,6 +291,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		vr41xx_icu1_base = VR4122_SYSINT1REG;
 		vr41xx_icu2_base = VR4122_SYSINT2REG;
 		break;
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/pciu.c linux/arch/mips/vr41xx/common/pciu.c
--- linux.orig/arch/mips/vr41xx/common/pciu.c	Mon Apr  7 09:17:06 2003
+++ linux/arch/mips/vr41xx/common/pciu.c	Thu Oct 30 23:51:40 2003
@@ -74,7 +74,7 @@
 		/*
 		 * Type 1 configuration
 		 */
-		if (bus > 255 || PCI_SLOT(dev_fn) > 31 || where > 255)
+		if (PCI_SLOT(dev_fn) > 31 || where > 255)
 			return -1;
 
 		writel((bus << 16)	|
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/pciu.h linux/arch/mips/vr41xx/common/pciu.h
--- linux.orig/arch/mips/vr41xx/common/pciu.h	Mon Jul 15 09:02:56 2002
+++ linux/arch/mips/vr41xx/common/pciu.h	Thu Oct 30 23:51:40 2003
@@ -107,9 +107,6 @@
 
 #define MAX_PCI_CLOCK			33333333
 
-#define PCIU_CLOCK			0x0080
-#define PCI_CLOCK			0x2000
-
 static inline int pciu_read_config_byte(int where, u8 *val)
 {
 	u32 data;
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux.orig/arch/mips/vr41xx/common/serial.c	Mon Apr  7 09:17:06 2003
+++ linux/arch/mips/vr41xx/common/serial.c	Thu Oct 30 23:51:40 2003
@@ -33,10 +33,11 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
 #include <linux/types.h>
@@ -66,7 +67,6 @@
  #define TMICMODE		0x20
 
 #define SIU_BASE_BAUD		1152000
-#define SIU_CLOCK		0x0102
 
 /* VR4122 and VR4131 DSIU Registers */
 #define DSIURB			KSEG1ADDR(0x0f000820)
@@ -75,7 +75,6 @@
  #define INTDSIU		0x0800
 
 #define DSIU_BASE_BAUD		1152000
-#define DSIU_CLOCK		0x0802
 
 int vr41xx_serial_ports = 0;
 
@@ -106,6 +105,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		writew(val, VR4122_SIUIRSEL);
 		break;
 	default:
@@ -133,6 +133,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		s.iomem_base = (unsigned char *)VR4122_SIURB;
 		break;
 	default:
@@ -154,7 +155,8 @@
 	struct serial_struct s;
 
 	if (current_cpu_data.cputype != CPU_VR4122 &&
-	    current_cpu_data.cputype != CPU_VR4131)
+	    current_cpu_data.cputype != CPU_VR4131 &&
+	    current_cpu_data.cputype != CPU_VR4133)
 		return;
 
 	memset(&s, 0, sizeof(s));
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/time.c linux/arch/mips/vr41xx/common/time.c
--- linux.orig/arch/mips/vr41xx/common/time.c	Sat Aug 30 01:32:54 2003
+++ linux/arch/mips/vr41xx/common/time.c	Thu Oct 30 23:51:40 2003
@@ -33,10 +33,11 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4100 series are supported.
  *  - Added support for NEC VR4100 series RTC Unit.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4100 series are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/config.h>
 #include <linux/interrupt.h>
@@ -69,6 +70,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
                 vr41xx_rtc_base = VR4122_ETIMELREG;
                 break;
         default:
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux.orig/arch/mips/vr41xx/ibm-workpad/setup.c	Wed Jul 30 09:35:38 2003
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Thu Oct 30 23:51:40 2003
@@ -59,7 +59,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/setup.c	Wed Jul 30 09:35:38 2003
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Thu Oct 30 23:51:40 2003
@@ -140,7 +140,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 #ifdef CONFIG_SERIAL
 	vr41xx_dsiu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Wed Jul 30 09:35:38 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Oct 30 23:51:41 2003
@@ -102,7 +102,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu May 22 06:36:53 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Oct 30 23:51:41 2003
@@ -114,7 +114,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Wed Jul 30 09:35:38 2003
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu Oct 30 23:51:41 2003
@@ -107,7 +107,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux.orig/arch/mips/vr41xx/zao-capcella/setup.c	Wed Jul 30 09:35:38 2003
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Thu Oct 30 23:51:41 2003
@@ -107,7 +107,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0x0102);
+	vr41xx_cmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips64/kernel/cpu-probe.c linux/arch/mips64/kernel/cpu-probe.c
--- linux.orig/arch/mips64/kernel/cpu-probe.c	Sun Sep 21 01:21:25 2003
+++ linux/arch/mips64/kernel/cpu-probe.c	Thu Oct 30 23:53:40 2003
@@ -544,8 +544,11 @@
 				else
 					c->cputype = CPU_VR4181A;
 				break;
-			case PRID_REV_VR4131:
-				c->cputype = CPU_VR4131;
+			case PRID_REV_VR4130:
+				if ((c->processor_id & 0xf) < 0x4)
+					c->cputype = CPU_VR4131;
+				else
+					c->cputype = CPU_VR4133;
 				break;
 			default:
 				printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips64/kernel/proc.c linux/arch/mips64/kernel/proc.c
--- linux.orig/arch/mips64/kernel/proc.c	Tue Oct 14 11:58:46 2003
+++ linux/arch/mips64/kernel/proc.c	Thu Oct 30 23:54:10 2003
@@ -68,6 +68,7 @@
 	[CPU_VR4121]	"NEC VR4121",
 	[CPU_VR4122]	"NEC VR4122",
 	[CPU_VR4131]	"NEC VR4131",
+	[CPU_VR4133]	"NEC VR4133",
 	[CPU_VR4181]	"NEC VR4181",
 	[CPU_VR4181A]	"NEC VR4181A",
 	[CPU_SR71000]	"Sandcraft SR71000"
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips64/mm/c-r4k.c linux/arch/mips64/mm/c-r4k.c
--- linux.orig/arch/mips64/mm/c-r4k.c	Tue Oct 14 11:58:47 2003
+++ linux/arch/mips64/mm/c-r4k.c	Thu Oct 30 23:54:51 2003
@@ -833,6 +833,8 @@
 		c->dcache.waybit = 0;
 		break;
 
+	case CPU_VR4133:
+		write_c0_config(config & ~CONF_EB);
 	case CPU_VR4131:
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/cpu.h linux/include/asm-mips/cpu.h
--- linux.orig/include/asm-mips/cpu.h	Tue Oct 14 11:58:58 2003
+++ linux/include/asm-mips/cpu.h	Thu Oct 30 23:51:41 2003
@@ -100,7 +100,7 @@
 #define PRID_REV_VR4121		0x0060
 #define PRID_REV_VR4122		0x0070
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
-#define PRID_REV_VR4131		0x0080
+#define PRID_REV_VR4130		0x0080
 
 /*
  * FPU implementation/revision register (CP1 control register 0).
@@ -168,7 +168,8 @@
 #define CPU_AU1100		52
 #define CPU_SR71000		53
 #define CPU_RM9000		54
-#define CPU_LAST		54
+#define CPU_VR4133		55
+#define CPU_LAST		55
 
 /*
  * ISA Level encodings
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux.orig/include/asm-mips/vr41xx/vr41xx.h	Wed Jul 30 09:35:38 2003
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Thu Oct 30 23:51:41 2003
@@ -32,12 +32,15 @@
 #define PRID_VR4181A_REV1_0	0x00000c73
 #define PRID_VR4181A_REV1_1	0x00000c74
 
-/* VR4131 0x00000c80-0x00000c8f */
+/* VR4131 0x00000c80-0x00000c83 */
 #define PRID_VR4131_REV1_2	0x00000c80
 #define PRID_VR4131_REV2_0	0x00000c81
 #define PRID_VR4131_REV2_1	0x00000c82
 #define PRID_VR4131_REV2_2	0x00000c83
 
+/* VR4133 0x00000c84- */
+#define PRID_VR4133		0x00000c84
+
 /*
  * Bus Control Uint
  */
@@ -46,9 +49,25 @@
 /*
  * Clock Mask Unit
  */
-extern void vr41xx_cmu_init(u16 mask);
-extern void vr41xx_clock_supply(u16 mask);
-extern void vr41xx_clock_mask(u16 mask);
+extern void vr41xx_cmu_init(void);
+extern void vr41xx_clock_supply(unsigned int clock);
+extern void vr41xx_clock_mask(unsigned int clock);
+
+enum {
+	PIU_CLOCK,
+	SIU_CLOCK,
+	AIU_CLOCK,
+	KIU_CLOCK,
+	FIR_CLOCK,
+	DSIU_CLOCK,
+	CSI_CLOCK,
+	PCIU_CLOCK,
+	HSP_CLOCK,
+	PCI_CLOCK,
+	CEU_CLOCK,
+	ETHER0_CLOCK,
+	ETHER1_CLOCK
+};
 
 /*
  * Interrupt Control Unit
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips64/cpu.h linux/include/asm-mips64/cpu.h
--- linux.orig/include/asm-mips64/cpu.h	Tue Oct 14 11:58:59 2003
+++ linux/include/asm-mips64/cpu.h	Thu Oct 30 23:56:07 2003
@@ -100,7 +100,7 @@
 #define PRID_REV_VR4121		0x0060
 #define PRID_REV_VR4122		0x0070
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
-#define PRID_REV_VR4131		0x0080
+#define PRID_REV_VR4130		0x0080
 
 /*
  * FPU implementation/revision register (CP1 control register 0).
@@ -168,7 +168,8 @@
 #define CPU_AU1100		52
 #define CPU_SR71000		53
 #define CPU_RM9000		54
-#define CPU_LAST		54
+#define CPU_VR4133		55
+#define CPU_LAST		55
 
 /*
  * ISA Level encodings

--Multipart=_Fri__31_Oct_2003_00_16_58_+0900_MB_RW/VX.w/mVD7N
Content-Type: text/plain;
 name="vr4133-v26-031031.diff"
Content-Disposition: attachment;
 filename="vr4133-v26-031031.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/cpu-probe.c linux/arch/mips/kernel/cpu-probe.c
--- linux.orig/arch/mips/kernel/cpu-probe.c	Tue Oct 14 12:00:55 2003
+++ linux/arch/mips/kernel/cpu-probe.c	Thu Oct 30 23:50:17 2003
@@ -222,9 +222,11 @@
 			else
 				c->cputype = CPU_VR4181A;
 			break;
-		case PRID_REV_VR4131:
-			c->cputype = CPU_VR4131;
-			break;
+		case PRID_REV_VR4130:
+			if ((c->processor_id & 0xf) < 0x4)
+				c->cputype = CPU_VR4131;
+			else
+				c->cputype = CPU_VR4133;
 		default:
 			printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 				c->cputype = CPU_VR41XX;
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/proc.c linux/arch/mips/kernel/proc.c
--- linux.orig/arch/mips/kernel/proc.c	Tue Oct 14 12:00:55 2003
+++ linux/arch/mips/kernel/proc.c	Thu Oct 30 23:50:17 2003
@@ -69,6 +69,7 @@
 	[CPU_VR4121]	"NEC VR4121",
 	[CPU_VR4122]	"NEC VR4122",
 	[CPU_VR4131]	"NEC VR4131",
+	[CPU_VR4133]	"NEC VR4133",
 	[CPU_VR4181]	"NEC VR4181",
 	[CPU_VR4181A]	"NEC VR4181A",
 	[CPU_SR71000]	"Sandcraft SR71000"
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux.orig/arch/mips/mm/c-r4k.c	Tue Oct 14 12:00:56 2003
+++ linux/arch/mips/mm/c-r4k.c	Thu Oct 30 23:50:17 2003
@@ -831,6 +831,8 @@
 		c->dcache.waybit = 0;
 		break;
 
+	case CPU_VR4133:
+		write_c0_config(config & ~CONF_EB);
 	case CPU_VR4131:
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/pci/pci-vr41xx.h linux/arch/mips/pci/pci-vr41xx.h
--- linux.orig/arch/mips/pci/pci-vr41xx.h	Fri Jun 13 23:19:56 2003
+++ linux/arch/mips/pci/pci-vr41xx.h	Thu Oct 30 23:50:17 2003
@@ -107,9 +107,6 @@
 
 #define MAX_PCI_CLOCK			33333333
 
-#define PCIU_CLOCK			0x0080
-#define PCI_CLOCK			0x2000
-
 static inline int pciu_read_config_byte(int where, u8 * val)
 {
 	u32 data;
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux.orig/arch/mips/vr41xx/casio-e55/setup.c	Wed Jul 30 22:36:55 2003
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Thu Oct 30 23:50:17 2003
@@ -62,7 +62,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/bcu.c linux/arch/mips/vr41xx/common/bcu.c
--- linux.orig/arch/mips/vr41xx/common/bcu.c	Sat Aug 30 01:35:41 2003
+++ linux/arch/mips/vr41xx/common/bcu.c	Thu Oct 30 23:50:17 2003
@@ -33,13 +33,14 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
  *  Paul Mundt <lethal@chaoticdreams.org>
  *  - Calculate mips_hpt_frequency properly on VR4131.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
 #include <linux/types.h>
@@ -52,8 +53,8 @@
 
 #define VR4111_CLKSPEEDREG	KSEG1ADDR(0x0b000014)
 #define VR4122_CLKSPEEDREG	KSEG1ADDR(0x0f000014)
-#define VR4131_CLKSPEEDREG	VR4122_CLKSPEEDREG
  #define CLKSP(x)		((x) & 0x001f)
+ #define CLKSP_VR4133(x)	((x) & 0x0007)
 
  #define DIV2B			0x8000
  #define DIV3B			0x4000
@@ -72,8 +73,9 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121: return readw(VR4111_CLKSPEEDREG);
-	case CPU_VR4122: return readw(VR4122_CLKSPEEDREG);
-	case CPU_VR4131: return readw(VR4131_CLKSPEEDREG);
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133: return readw(VR4122_CLKSPEEDREG);
 	default:
 		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 		break;
@@ -90,19 +92,43 @@
 	case CPU_VR4111:
 	case CPU_VR4121:
 		pclock = 18432000 * 64;
+		pclock /= CLKSP(clkspeed);
 		break;
 	case CPU_VR4122:
 		pclock = 18432000 * 98;
+		pclock /= CLKSP(clkspeed);
 		break;
 	case CPU_VR4131:
 		pclock = 18432000 * 108;
+		pclock /= CLKSP(clkspeed);
+		break;
+	case CPU_VR4133:
+		switch (CLKSP_VR4133(clkspeed)) {
+		case 0:
+			pclock = 133000000;
+			break;
+		case 1:
+			pclock = 149000000;
+			break;
+		case 2:
+			pclock = 165900000;
+			break;
+		case 3:
+			pclock = 199100000;
+			break;
+		case 4:
+			pclock = 265900000;
+			break;
+		default:
+			printk(KERN_INFO "Unknown PClock speed for NEC VR4133\n");
+			break;
+		}
 		break;
 	default:
 		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 		break;
 	}
 
-	pclock /= CLKSP(clkspeed);
 	printk(KERN_INFO "PClock: %ldHz\n", pclock);
 
 	return pclock;
@@ -135,6 +161,7 @@
 		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
 		break;
 	case CPU_VR4131:
+	case CPU_VR4133:
 		vr41xx_vtclock = pclock / VTDIVMODE(clkspeed);
 		printk(KERN_INFO "VTClock: %ldHz\n", vr41xx_vtclock);
 		break;
@@ -165,6 +192,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		tclock = vtclock / TDIVMODE(clkspeed);
 		break;
 	default:
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/cmu.c linux/arch/mips/vr41xx/common/cmu.c
--- linux.orig/arch/mips/vr41xx/common/cmu.c	Fri Apr 11 00:17:57 2003
+++ linux/arch/mips/vr41xx/common/cmu.c	Thu Oct 30 23:50:17 2003
@@ -33,38 +33,174 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
 #include <asm/io.h>
+#include <asm/vr41xx/vr41xx.h>
 
 #define VR4111_CMUCLKMSK	KSEG1ADDR(0x0b000060)
 #define VR4122_CMUCLKMSK	KSEG1ADDR(0x0f000060)
+ #define MSKPIU			0x0001
+ #define MSKSIU			0x0002
+ #define MSKAIU			0x0004
+ #define MSKKIU			0x0008
+ #define MSKFIR			0x0010
+ #define MSKDSIU		0x0820
+ #define MSKCSI			0x0040
+ #define MSKPCIU		0x0080
+ #define MSKSSIU		0x0100
+ #define MSKSHSP		0x0200
+ #define MSKFFIR		0x0400
+ #define MSKSCSI		0x1000
+ #define MSKPPCIU		0x2000
+#define VR4133_CMUCLKMSK2	KSEG1ADDR(0x0f000064)
+ #define MSKCEU			0x0001
+ #define MSKMAC0		0x0002
+ #define MSKMAC1		0x0004
+
+static u32 vr41xx_cmu_base;
+static u16 cmuclkmsk, cmuclkmsk2;
+
+#define read_cmuclkmsk()	readw(vr41xx_cmu_base)
+#define read_cmuclkmsk2()	readw(VR4133_CMUCLKMSK2)
+#define write_cmuclkmsk()	writew(cmuclkmsk, vr41xx_cmu_base)
+#define write_cmuclkmsk2()	writew(cmuclkmsk2, VR4133_CMUCLKMSK2)
 
-static u32 vr41xx_cmu_base = 0;
-static u16 cmuclkmsk = 0;
-
-#define write_cmu(mask)	writew((mask), vr41xx_cmu_base)
-
-void vr41xx_clock_supply(u16 mask)
+void vr41xx_clock_supply(unsigned int clock)
 {
-	cmuclkmsk |= mask;
-	write_cmu(cmuclkmsk);
+	switch (clock) {
+	case PIU_CLOCK:
+		cmuclkmsk |= MSKPIU;
+		break;
+	case SIU_CLOCK:
+		cmuclkmsk |= MSKSIU | MSKSSIU;
+		break;
+	case AIU_CLOCK:
+		cmuclkmsk |= MSKAIU;
+		break;
+	case KIU_CLOCK:
+		cmuclkmsk |= MSKKIU;
+		break;
+	case FIR_CLOCK:
+		cmuclkmsk |= MSKFIR | MSKFFIR;
+		break;
+	case DSIU_CLOCK:
+		if (current_cpu_data.cputype == CPU_VR4111 ||
+		    current_cpu_data.cputype == CPU_VR4121)
+			cmuclkmsk |= MSKDSIU;
+		else
+			cmuclkmsk |= MSKSIU | MSKDSIU;
+		break;
+	case CSI_CLOCK:
+		cmuclkmsk |= MSKCSI | MSKSCSI;
+		break;
+	case PCIU_CLOCK:
+		cmuclkmsk |= MSKPCIU;
+		break;
+	case HSP_CLOCK:
+		cmuclkmsk |= MSKSHSP;
+		break;
+	case PCI_CLOCK:
+		cmuclkmsk |= MSKPPCIU;
+		break;
+	case CEU_CLOCK:
+		cmuclkmsk2 |= MSKCEU;
+		break;
+	case ETHER0_CLOCK:
+		cmuclkmsk2 |= MSKMAC0;
+		break;
+	case ETHER1_CLOCK:
+		cmuclkmsk2 |= MSKMAC1;
+		break;
+	default:
+		break;
+	}
+
+	if (clock == CEU_CLOCK || clock == ETHER0_CLOCK ||
+	    clock == ETHER1_CLOCK)
+		write_cmuclkmsk2();
+	else
+		write_cmuclkmsk();
 }
 
-void vr41xx_clock_mask(u16 mask)
+void vr41xx_clock_mask(unsigned int clock)
 {
-	cmuclkmsk &= ~mask;
-	write_cmu(cmuclkmsk);
+	switch (clock) {
+	case PIU_CLOCK:
+		cmuclkmsk &= ~MSKPIU;
+		break;
+	case SIU_CLOCK:
+		if (current_cpu_data.cputype == CPU_VR4111 ||
+		    current_cpu_data.cputype == CPU_VR4121) {
+			cmuclkmsk &= ~(MSKSIU | MSKSSIU);
+		} else {
+			if (cmuclkmsk & MSKDSIU)
+				cmuclkmsk &= ~MSKSSIU;
+			else
+				cmuclkmsk &= ~(MSKSIU | MSKSSIU);
+		}
+		break;
+	case AIU_CLOCK:
+		cmuclkmsk &= ~MSKAIU;
+		break;
+	case KIU_CLOCK:
+		cmuclkmsk &= ~MSKKIU;
+		break;
+	case FIR_CLOCK:
+		cmuclkmsk &= ~(MSKFIR | MSKFFIR);
+		break;
+	case DSIU_CLOCK:
+		if (current_cpu_data.cputype == CPU_VR4111 ||
+		    current_cpu_data.cputype == CPU_VR4121) {
+			cmuclkmsk &= ~MSKDSIU;
+		} else {
+			if (cmuclkmsk & MSKSIU)
+				cmuclkmsk &= ~MSKDSIU;
+			else
+				cmuclkmsk &= ~(MSKSIU | MSKDSIU);
+		}
+		break;
+	case CSI_CLOCK:
+		cmuclkmsk &= ~(MSKCSI | MSKSCSI);
+		break;
+	case PCIU_CLOCK:
+		cmuclkmsk &= ~MSKPCIU;
+		break;
+	case HSP_CLOCK:
+		cmuclkmsk &= ~MSKSHSP;
+		break;
+	case PCI_CLOCK:
+		cmuclkmsk &= ~MSKPPCIU;
+		break;
+	case CEU_CLOCK:
+		cmuclkmsk2 &= ~MSKCEU;
+		break;
+	case ETHER0_CLOCK:
+		cmuclkmsk2 &= ~MSKMAC0;
+		break;
+	case ETHER1_CLOCK:
+		cmuclkmsk2 &= ~MSKMAC1;
+		break;
+	default:
+		break;
+	}
+
+	if (clock == CEU_CLOCK || clock == ETHER0_CLOCK ||
+	    clock == ETHER1_CLOCK)
+		write_cmuclkmsk2();
+	else
+		write_cmuclkmsk();
 }
 
-void __init vr41xx_cmu_init(u16 mask)
+void __init vr41xx_cmu_init(void)
 {
 	switch (current_cpu_data.cputype) {
         case CPU_VR4111:
@@ -75,10 +211,14 @@
         case CPU_VR4131:
                 vr41xx_cmu_base = VR4122_CMUCLKMSK;
                 break;
+        case CPU_VR4133:
+                vr41xx_cmu_base = VR4122_CMUCLKMSK;
+		cmuclkmsk2 = read_cmuclkmsk2();
+                break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
 		break;
         }
 
-	cmuclkmsk = mask;
+	cmuclkmsk = read_cmuclkmsk();
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux.orig/arch/mips/vr41xx/common/giu.c	Sat Apr 19 16:38:35 2003
+++ linux/arch/mips/vr41xx/common/giu.c	Thu Oct 30 23:50:17 2003
@@ -34,6 +34,9 @@
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
  *  - New creation, NEC VR4111, VR4121, VR4122 and VR4131 are supported.
+ *
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -246,6 +249,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		vr41xx_giu_base = VR4122_GIUIOSELL;
 		break;
 	default:
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux.orig/arch/mips/vr41xx/common/icu.c	Sat Apr 19 16:38:35 2003
+++ linux/arch/mips/vr41xx/common/icu.c	Thu Oct 30 23:50:17 2003
@@ -33,13 +33,14 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
  *  Paul Mundt <lethal@chaoticdreams.org>
  *  - kgdb support.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -290,6 +291,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		vr41xx_icu1_base = VR4122_SYSINT1REG;
 		vr41xx_icu2_base = VR4122_SYSINT2REG;
 		break;
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux.orig/arch/mips/vr41xx/common/serial.c	Fri Apr 11 00:18:03 2003
+++ linux/arch/mips/vr41xx/common/serial.c	Thu Oct 30 23:50:17 2003
@@ -33,10 +33,11 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
 #include <linux/types.h>
@@ -66,7 +67,6 @@
  #define TMICMODE		0x20
 
 #define SIU_BASE_BAUD		1152000
-#define SIU_CLOCK		0x0102
 
 /* VR4122 and VR4131 DSIU Registers */
 #define DSIURB			KSEG1ADDR(0x0f000820)
@@ -75,7 +75,6 @@
  #define INTDSIU		0x0800
 
 #define DSIU_BASE_BAUD		1152000
-#define DSIU_CLOCK		0x0802
 
 int vr41xx_serial_ports = 0;
 
@@ -106,6 +105,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		writew(val, VR4122_SIUIRSEL);
 		break;
 	default:
@@ -133,6 +133,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
 		s.iomem_base = (unsigned char *)VR4122_SIURB;
 		break;
 	default:
@@ -154,7 +155,8 @@
 	struct serial_struct s;
 
 	if (current_cpu_data.cputype != CPU_VR4122 &&
-	    current_cpu_data.cputype != CPU_VR4131)
+	    current_cpu_data.cputype != CPU_VR4131 &&
+	    current_cpu_data.cputype != CPU_VR4133)
 		return;
 
 	memset(&s, 0, sizeof(s));
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/time.c linux/arch/mips/vr41xx/common/time.c
--- linux.orig/arch/mips/vr41xx/common/time.c	Sat Aug 30 01:35:41 2003
+++ linux/arch/mips/vr41xx/common/time.c	Thu Oct 30 23:50:17 2003
@@ -33,10 +33,11 @@
 /*
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4100 series are supported.
  *  - Added support for NEC VR4100 series RTC Unit.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4100 series are supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Added support for NEC VR4133.
  */
 #include <linux/config.h>
 #include <linux/interrupt.h>
@@ -69,6 +70,7 @@
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
+	case CPU_VR4133:
                 vr41xx_rtc_base = VR4122_ETIMELREG;
                 break;
         default:
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux.orig/arch/mips/vr41xx/ibm-workpad/setup.c	Wed Jul 30 22:36:55 2003
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Thu Oct 30 23:50:17 2003
@@ -62,7 +62,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/setup.c	Sun Oct 26 11:26:40 2003
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Thu Oct 30 23:50:17 2003
@@ -135,7 +135,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_dsiu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Sun Oct 26 11:26:40 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Oct 30 23:50:17 2003
@@ -103,7 +103,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Sun Oct 26 11:26:40 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Oct 30 23:50:18 2003
@@ -108,7 +108,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Sun Oct 26 11:26:40 2003
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu Oct 30 23:50:18 2003
@@ -111,7 +111,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0);
+	vr41xx_cmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux.orig/arch/mips/vr41xx/zao-capcella/setup.c	Sun Oct 26 11:26:40 2003
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Thu Oct 30 23:50:18 2003
@@ -111,7 +111,7 @@
 
 	vr41xx_bcu_init();
 
-	vr41xx_cmu_init(0x0102);
+	vr41xx_cmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/cpu.h linux/include/asm-mips/cpu.h
--- linux.orig/include/asm-mips/cpu.h	Tue Oct 14 12:01:08 2003
+++ linux/include/asm-mips/cpu.h	Thu Oct 30 23:50:18 2003
@@ -101,7 +101,7 @@
 #define PRID_REV_VR4121		0x0060
 #define PRID_REV_VR4122		0x0070
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
-#define PRID_REV_VR4131		0x0080
+#define PRID_REV_VR4130		0x0080
 
 /*
  * FPU implementation/revision register (CP1 control register 0).
@@ -170,7 +170,8 @@
 #define CPU_SR71000		53
 #define CPU_RM9000		54
 #define CPU_25KF		55
-#define CPU_LAST		55
+#define CPU_VR4133		56
+#define CPU_LAST		56
 
 /*
  * ISA Level encodings
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux.orig/include/asm-mips/vr41xx/vr41xx.h	Wed Jul 30 22:36:56 2003
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Thu Oct 30 23:50:18 2003
@@ -32,12 +32,15 @@
 #define PRID_VR4181A_REV1_0	0x00000c73
 #define PRID_VR4181A_REV1_1	0x00000c74
 
-/* VR4131 0x00000c80-0x00000c8f */
+/* VR4131 0x00000c80-0x00000c83 */
 #define PRID_VR4131_REV1_2	0x00000c80
 #define PRID_VR4131_REV2_0	0x00000c81
 #define PRID_VR4131_REV2_1	0x00000c82
 #define PRID_VR4131_REV2_2	0x00000c83
 
+/* VR4131 0x00000c84- */
+#define PRID_VR4133		0x00000c84
+
 /*
  * Bus Control Uint
  */
@@ -46,9 +49,25 @@
 /*
  * Clock Mask Unit
  */
-extern void vr41xx_cmu_init(u16 mask);
-extern void vr41xx_clock_supply(u16 mask);
-extern void vr41xx_clock_mask(u16 mask);
+extern void vr41xx_cmu_init(void);
+extern void vr41xx_clock_supply(unsigned int clock);
+extern void vr41xx_clock_mask(unsigned int clock);
+
+enum {
+	PIU_CLOCK,
+	SIU_CLOCK,
+	AIU_CLOCK,
+	KIU_CLOCK,
+	FIR_CLOCK,
+	DSIU_CLOCK,
+	CSI_CLOCK,
+	PCIU_CLOCK,
+	HSP_CLOCK,
+	PCI_CLOCK,
+	CEU_CLOCK,
+	ETHER0_CLOCK,
+	ETHER1_CLOCK
+};
 
 /*
  * Interrupt Control Unit

--Multipart=_Fri__31_Oct_2003_00_16_58_+0900_MB_RW/VX.w/mVD7N--
