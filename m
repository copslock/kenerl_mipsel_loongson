Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:50:37 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:39105 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226031AbUEZPuc>;
	Wed, 26 May 2004 16:50:32 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA14192;
	Thu, 27 May 2004 00:50:28 +0900 (JST)
Received: 4UMDO01 id i4QFoRu08866; Thu, 27 May 2004 00:50:27 +0900 (JST)
Received: 4UMRO00 id i4QFoOV28687; Thu, 27 May 2004 00:50:25 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:50:22 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/14] vr41xx: change to early_initcall
Message-Id: <20040527005022.53033dd4.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The some functions change to early_initcall from the call from prom_init().

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/bcu.c linux/arch/mips/vr41xx/common/bcu.c
--- linux-orig/arch/mips/vr41xx/common/bcu.c	Tue Jan 13 08:21:05 2004
+++ linux/arch/mips/vr41xx/common/bcu.c	Tue May 18 02:30:13 2004
@@ -1,34 +1,23 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/bcu.c
+ *  bcu.c, Bus Control Unit routines for the NEC VR4100 series.
  *
- * BRIEF MODULE DESCRIPTION
- *	Bus Control Unit routines for the NEC VR4100 series.
- *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
- *
- * Copyright 2002 MontaVista Software Inc.
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
+ *  Copyright (C) 2002  MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
+ *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
@@ -40,12 +29,16 @@
  *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
 #include <asm/io.h>
 
+#define IO_MEM_RESOURCE_START	0UL
+#define IO_MEM_RESOURCE_END	0x1fffffffUL
+
 #define CLKSPEEDREG_TYPE1	KSEG1ADDR(0x0b000014)
 #define CLKSPEEDREG_TYPE2	KSEG1ADDR(0x0f000014)
  #define CLKSP(x)		((x) & 0x001f)
@@ -213,7 +206,7 @@
 	return tclock;
 }
 
-void __init vr41xx_bcu_init(void)
+static int __init vr41xx_bcu_init(void)
 {
 	unsigned long pclock;
 	uint16_t clkspeed;
@@ -223,4 +216,11 @@
 	pclock = calculate_pclock(clkspeed);
 	vr41xx_vtclock = calculate_vtclock(clkspeed, pclock);
 	vr41xx_tclock = calculate_tclock(clkspeed, pclock, vr41xx_vtclock);
+
+	iomem_resource.start = IO_MEM_RESOURCE_START;
+	iomem_resource.end = IO_MEM_RESOURCE_END;
+
+	return 0;
 }
+
+early_initcall(vr41xx_bcu_init);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/cmu.c linux/arch/mips/vr41xx/common/cmu.c
--- linux-orig/arch/mips/vr41xx/common/cmu.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/common/cmu.c	Tue May 18 02:30:13 2004
@@ -200,7 +200,7 @@
 	spin_unlock_irq(&cmu_lock);
 }
 
-void __init vr41xx_cmu_init(void)
+static int __init vr41xx_cmu_init(void)
 {
 	switch (current_cpu_data.cputype) {
         case CPU_VR4111:
@@ -223,4 +223,8 @@
 	cmuclkmsk = read_cmuclkmsk();
 
 	spin_lock_init(&cmu_lock);
+
+	return 0;
 }
+
+early_initcall(vr41xx_cmu_init);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/init.c linux/arch/mips/vr41xx/common/init.c
--- linux-orig/arch/mips/vr41xx/common/init.c	Wed Feb 25 11:15:36 2004
+++ linux/arch/mips/vr41xx/common/init.c	Tue May 18 02:30:13 2004
@@ -18,16 +18,9 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
-#include <linux/ioport.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
-#include <asm/vr41xx/vr41xx.h>
-
-extern void vr41xx_bcu_init(void);
-extern void vr41xx_cmu_init(void);
-extern void vr41xx_pmu_init(void);
-extern void vr41xx_rtc_init(void);
 
 void __init prom_init(void)
 {
@@ -42,14 +35,6 @@
 		if (i < (argc - 1))
 			strcat(arcs_cmdline, " ");
 	}
-
-	iomem_resource.start = IO_MEM_RESOURCE_START;
-	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-	vr41xx_bcu_init();
-	vr41xx_cmu_init();
-	vr41xx_pmu_init();
-	vr41xx_rtc_init();
 }
 
 unsigned long __init prom_free_prom_memory (void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/pmu.c linux/arch/mips/vr41xx/common/pmu.c
--- linux-orig/arch/mips/vr41xx/common/pmu.c	Fri Feb 20 00:49:46 2004
+++ linux/arch/mips/vr41xx/common/pmu.c	Tue May 18 02:30:13 2004
@@ -1,7 +1,7 @@
 /*
  *  pmu.c, Power Management Unit routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -68,9 +68,13 @@
 	while (1) ;
 }
 
-void __init vr41xx_pmu_init(void)
+static int __init vr41xx_pmu_init(void)
 {
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
 	_machine_power_off = vr41xx_power_off;
+
+	return 0;
 }
+
+early_initcall(vr41xx_pmu_init);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/rtc.c linux/arch/mips/vr41xx/common/rtc.c
--- linux-orig/arch/mips/vr41xx/common/rtc.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/common/rtc.c	Tue May 18 02:30:13 2004
@@ -1,7 +1,7 @@
 /*
  *  rtc.c, RTC(has only timer function) routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -310,8 +310,12 @@
 	setup_irq(ELAPSEDTIME_IRQ, irq);
 }
 
-void __init vr41xx_rtc_init(void)
+static int __init vr41xx_rtc_init(void)
 {
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
+
+	return 0;
 }
+
+early_initcall(vr41xx_rtc_init);
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Tue May 18 02:28:47 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Tue May 18 02:30:13 2004
@@ -43,12 +43,6 @@
 #define PRID_VR4133		0x00000c84
 
 /*
- * Memory resource
- */
-#define IO_MEM_RESOURCE_START	0UL
-#define IO_MEM_RESOURCE_END	0x1fffffffUL
-
-/*
  * Bus Control Uint
  */
 extern unsigned long vr41xx_get_vtclock_frequency(void);
