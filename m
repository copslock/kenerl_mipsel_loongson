Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 16:22:21 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:35056 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225217AbUBYQWU>;
	Wed, 25 Feb 2004 16:22:20 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA24561;
	Thu, 26 Feb 2004 01:22:16 +0900 (JST)
Received: 4UMDO01 id i1PGMFt00640; Thu, 26 Feb 2004 01:22:15 +0900 (JST)
Received: 4UMRO00 id i1PGME712977; Thu, 26 Feb 2004 01:22:15 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 26 Feb 2004 01:22:13 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Removed board_irq_init for vr41xx
Message-Id: <20040226012213.458ad64f.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I made a patch for vr41xx platforms.
This patch removes the board_irq_init function for vr41xx.
The board_irq_init isn't needed for us.

I rewrote the IRQ function of NEC Eagle without using board_irq_init.

Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux-orig/arch/mips/vr41xx/common/giu.c	Tue Jan 13 08:21:05 2004
+++ linux/arch/mips/vr41xx/common/giu.c	Thu Feb 26 00:52:52 2004
@@ -1,34 +1,23 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/giu.c
+ *  giu.c, General-purpose I/O Unit Interrupt routines for NEC VR4100 series.
  *
- * BRIEF MODULE DESCRIPTION
- *	General-purpose I/O Unit Interrupt routines for NEC VR4100 series.
+ *  Copyright (C) 2002 MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
+ *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- * Copyright 2002 MontaVista Software Inc.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
  *
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 /*
  * Changes:
@@ -37,6 +26,7 @@
  *
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *  - Added support for NEC VR4133.
+ *  - Removed board_irq_init.
  */
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -272,8 +262,6 @@
 	return retval;
 }
 
-void (*board_irq_init)(void) = NULL;
-
 void __init vr41xx_giuint_init(void)
 {
 	int i;
@@ -301,7 +289,4 @@
 
 	if (setup_irq(GIUINT_CASCADE_IRQ, &giu_cascade))
 		printk("GIUINT: Can not cascade IRQ %d.\n", GIUINT_CASCADE_IRQ);
-
-	if (board_irq_init)
-		board_irq_init();
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/irq.c linux/arch/mips/vr41xx/nec-eagle/irq.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/irq.c	Sun Dec 29 23:50:56 2002
+++ linux/arch/mips/vr41xx/nec-eagle/irq.c	Thu Feb 26 00:49:14 2004
@@ -1,64 +1,61 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/nec-eagle/irq.c
+ *  irq.c,  Interrupt routines for the NEC Eagle/Hawk board.
  *
- * BRIEF MODULE DESCRIPTION
- *	Interrupt routines for the NEC Eagle/Hawk board.
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
+ *  Copyright (C) 2002  MontaVista Software, Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC Eagle is supported.
  *  - Added support for NEC Hawk.
  *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC Eagle is supported.
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Changed from board_irq_init to driver module.
  */
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/types.h>
 
 #include <asm/io.h>
 #include <asm/vr41xx/eagle.h>
 
+MODULE_DESCRIPTION("IRQ module driver for NEC Eagle/Hawk");
+MODULE_AUTHOR("Yoichi Yuasa <yyuasa@mvista.com>");
+MODULE_LICENSE("GPL");
+
 static void enable_pciint_irq(unsigned int irq)
 {
-	u8 val;
+	uint8_t val;
 
 	val = readb(NEC_EAGLE_PCIINTMSKREG);
-	val |= (u8)1 << (irq - PCIINT_IRQ_BASE);
+	val |= (uint8_t)1 << (irq - PCIINT_IRQ_BASE);
 	writeb(val, NEC_EAGLE_PCIINTMSKREG);
 }
 
 static void disable_pciint_irq(unsigned int irq)
 {
-	u8 val;
+	uint8_t val;
 
 	val = readb(NEC_EAGLE_PCIINTMSKREG);
-	val &= ~((u8)1 << (irq - PCIINT_IRQ_BASE));
+	val &= ~((uint8_t)1 << (irq - PCIINT_IRQ_BASE));
 	writeb(val, NEC_EAGLE_PCIINTMSKREG);
 }
 
@@ -78,31 +75,30 @@
 }
 
 static struct hw_interrupt_type pciint_irq_type = {
-	"PCIINT",
-	startup_pciint_irq,
-	shutdown_pciint_irq,
-       	enable_pciint_irq,
-	disable_pciint_irq,
-	ack_pciint_irq,
-	end_pciint_irq,
-	NULL
+	.typename	= "PCIINT",
+	.startup	= startup_pciint_irq,
+	.shutdown 	= shutdown_pciint_irq,
+	.enable       	= enable_pciint_irq,
+	.disable	= disable_pciint_irq,
+	.ack		= ack_pciint_irq,
+	.end		= end_pciint_irq,
 };
 
 static void enable_sdbint_irq(unsigned int irq)
 {
-	u8 val;
+	uint8_t val;
 
 	val = readb(NEC_EAGLE_SDBINTMSK);
-	val |= (u8)1 << (irq - SDBINT_IRQ_BASE);
+	val |= (uint8_t)1 << (irq - SDBINT_IRQ_BASE);
 	writeb(val, NEC_EAGLE_SDBINTMSK);
 }
 
 static void disable_sdbint_irq(unsigned int irq)
 {
-	u8 val;
+	uint8_t val;
 
 	val = readb(NEC_EAGLE_SDBINTMSK);
-	val &= ~((u8)1 << (irq - SDBINT_IRQ_BASE));
+	val &= ~((uint8_t)1 << (irq - SDBINT_IRQ_BASE));
 	writeb(val, NEC_EAGLE_SDBINTMSK);
 }
 
@@ -122,19 +118,18 @@
 }
 
 static struct hw_interrupt_type sdbint_irq_type = {
-	"SDBINT",
-	startup_sdbint_irq,
-	shutdown_sdbint_irq,
-       	enable_sdbint_irq,
-	disable_sdbint_irq,
-	ack_sdbint_irq,
-	end_sdbint_irq,
-	NULL
+	.typename	= "SDBINT",
+	.startup	= startup_sdbint_irq,
+	.shutdown	= shutdown_sdbint_irq,
+	.enable		= enable_sdbint_irq,
+	.disable	= disable_sdbint_irq,
+	.ack		= ack_sdbint_irq,
+	.end		= end_sdbint_irq,
 };
 
 static int eagle_get_irq_number(int irq)
 {
-	u8 sdbint, pciint;
+	uint8_t sdbint, pciint;
 	int i;
 
 	sdbint = readb(NEC_EAGLE_SDBINT);
@@ -157,9 +152,9 @@
 	return -EINVAL;
 }
 
-void __init eagle_irq_init(void)
+static int __devinit eagle_irq_init(void)
 {
-	int i;
+	int i, retval;
 
 	writeb(0, NEC_EAGLE_SDBINTMSK);
 	writeb(0, NEC_EAGLE_PCIINTMSKREG);
@@ -179,5 +174,17 @@
 	for (i = PCIINT_IRQ_BASE; i <= PCIINT_IRQ_LAST; i++)
 		irq_desc[i].handler = &pciint_irq_type;
 
-	vr41xx_cascade_irq(FPGA_CASCADE_IRQ, eagle_get_irq_number);
+	retval = vr41xx_cascade_irq(FPGA_CASCADE_IRQ, eagle_get_irq_number);
+	if (retval != 0)
+		printk(KERN_ERR "eagle: Cannot cascade IRQ %d\n", FPGA_CASCADE_IRQ);
+
+	return retval;
 }
+
+static void __devexit eagle_irq_exit(void)
+{
+	free_irq(FPGA_CASCADE_IRQ, NULL);
+}
+
+module_init(eagle_irq_init);
+module_exit(eagle_irq_exit);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Thu Feb 26 00:49:14 2004
@@ -17,8 +17,6 @@
 #include <asm/pci_channel.h>
 #include <asm/vr41xx/eagle.h>
 
-extern void eagle_irq_init(void);
-
 #ifdef CONFIG_PCI
 
 extern void vrc4173_preinit(void);
@@ -80,8 +78,6 @@
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-
-	board_irq_init = eagle_irq_init;
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_dsiu_init();
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Thu Feb 26 00:24:02 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Thu Feb 26 00:49:14 2004
@@ -133,7 +133,6 @@
 #define GIU_IRQ_LAST		GIU_IRQ(31)
 #define GIU_IRQ_TO_PIN(x)	((x) - GIU_IRQ_BASE)	/* Pin 0-31 */
 
-extern void (*board_irq_init)(void);
 extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
 
