Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2004 07:41:14 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:6358 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225213AbUBSHlN>;
	Thu, 19 Feb 2004 07:41:13 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id QAA00298;
	Thu, 19 Feb 2004 16:41:05 +0900 (JST)
Received: 4UMDO01 id i1J7f5805970; Thu, 19 Feb 2004 16:41:05 +0900 (JST)
Received: 4UMRO01 id i1J7f4w20964; Thu, 19 Feb 2004 16:41:05 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Thu, 19 Feb 2004 16:41:04 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Fixed build error about NEC Eagle
Message-Id: <20040219164104.7951605e.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I made a patch for NEC Eagle.
This patch fixed build error about NEC Eagle.

Please apply this patch to v2.6.

Yoichi


diff -urN -X dontdiff linux-orig/arch/mips/pci/fixup-eagle.c linux/arch/mips/pci/fixup-eagle.c
--- linux-orig/arch/mips/pci/fixup-eagle.c	2003-11-25 15:28:14.000000000 +0900
+++ linux/arch/mips/pci/fixup-eagle.c	2004-02-19 16:28:42.000000000 +0900
@@ -1,34 +1,14 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/nec-eagle/pci_fixup.c
+ * arch/mips/vr41xx/nec-eagle/pci_fixup.c
  *
- * BRIEF MODULE DESCRIPTION
- *	The NEC Eagle/Hawk Board specific PCI fixups.
+ * The NEC Eagle/Hawk Board specific PCI fixups.
  *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ * Author: Yoichi Yuasa <you@mvista.com, or source@mvista.com>
  *
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
+ * 2001-2002,2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -74,3 +54,7 @@
 
 	return irq_tab_eagle[slot][pin];
 }
+
+struct pci_fixup pcibios_fixups[] __initdata = {
+	{	.pass = 0,	},
+};
diff -urN -X dontdiff linux-orig/arch/mips/pci/pci-vr41xx.c linux/arch/mips/pci/pci-vr41xx.c
--- linux-orig/arch/mips/pci/pci-vr41xx.c	2003-06-13 23:19:56.000000000 +0900
+++ linux/arch/mips/pci/pci-vr41xx.c	2004-02-19 16:15:31.000000000 +0900
@@ -8,7 +8,7 @@
  * Author: Yoichi Yuasa
  *         yyuasa@mvista.com or source@mvista.com
  *
- * Copyright 2001,2002 MontaVista Software Inc.
+ * Copyright 2001-2003 MontaVista Software Inc.
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -49,9 +49,7 @@
 #include <asm/pci_channel.h>
 #include <asm/vr41xx/vr41xx.h>
 
-#include "pciu.h"
-
-extern unsigned long vr41xx_vtclock;
+#include "pci-vr41xx.h"
 
 static inline int vr41xx_pci_config_access(unsigned char bus,
 					   unsigned int devfn, int where)
@@ -150,6 +148,7 @@
 void __init vr41xx_pciu_init(struct vr41xx_pci_address_map *map)
 {
 	struct vr41xx_pci_address_space *s;
+	unsigned long vtclock;
 	u32 config;
 	int n;
 
@@ -169,11 +168,12 @@
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
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/pmu.c linux/arch/mips/vr41xx/common/pmu.c
--- linux-orig/arch/mips/vr41xx/common/pmu.c	2004-02-01 01:47:09.000000000 +0900
+++ linux/arch/mips/vr41xx/common/pmu.c	2004-02-19 16:09:31.000000000 +0900
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	2004-02-02 11:24:21.000000000 +0900
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	2004-02-19 16:13:48.000000000 +0900
@@ -1,34 +1,14 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/nec-eagle/setup.c
+ * arch/mips/vr41xx/nec-eagle/setup.c
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the NEC Eagle/Hawk board.
+ * Setup for the NEC Eagle/Hawk board.
  *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
  *
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
+ * 2001-2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -99,7 +79,7 @@
 };
 #endif
 
-static void __init nec_eagle_setup(void)
+static int nec_eagle_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
@@ -134,6 +114,8 @@
 
 	vrc4173_preinit();
 #endif
+
+	return 0;
 }
 
 early_initcall(nec_eagle_setup);
