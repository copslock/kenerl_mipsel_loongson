Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2004 23:38:32 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:41166 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225344AbUBXXi3>;
	Tue, 24 Feb 2004 23:38:29 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id IAA17606;
	Wed, 25 Feb 2004 08:38:24 +0900 (JST)
Received: 4UMDO00 id i1ONcOF12044; Wed, 25 Feb 2004 08:38:24 +0900 (JST)
Received: 4UMRO00 id i1ONcN326773; Wed, 25 Feb 2004 08:38:23 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date:	Wed, 25 Feb 2004 08:38:13 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Fixed argument of early_serial_setup  for vr41xx
Message-Id: <20040225083813.34c98707.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for serial setup about vr41xx.
This patch corrects the argument of early_serial_setup correctly.

In order to apply this patch, it is necessary to apply the patche sent before.

I already sent the following patch to you.

1. [PATCH][2.6] Changed clock functions for vr41xx

This patch changes a clock function for a power management.
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/01-cmu-v26.diff

Please apply these patches to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux-orig/arch/mips/vr41xx/common/serial.c	Sat Feb 21 17:13:46 2004
+++ linux/arch/mips/vr41xx/common/serial.c	Sun Feb 22 00:59:38 2004
@@ -1,34 +1,23 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/serial.c
+ *  serial.c, Serial Interface Unit routines for NEC VR4100 series.
  *
- * BRIEF MODULE DESCRIPTION
- *	Serial Interface Unit routines for NEC VR4100 series.
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
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
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
@@ -41,7 +30,9 @@
  */
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/tty.h>
 #include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <linux/smp.h>
 
 #include <asm/addrspace.h>
@@ -117,33 +108,33 @@
 
 void __init vr41xx_siu_init(int interface, int module)
 {
-	struct serial_struct s;
+	struct uart_port port;
 
 	vr41xx_siu_ifselect(interface, module);
 
-	memset(&s, 0, sizeof(s));
+	memset(&port, 0, sizeof(port));
 
-	s.line = vr41xx_serial_ports;
-	s.baud_base = SIU_BASE_BAUD;
-	s.irq = SIU_IRQ;
-	s.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = vr41xx_serial_ports;
+	port.uartclk = SIU_BASE_BAUD;
+	port.irq = SIU_IRQ;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		s.iomem_base = (unsigned char *)SIURB_TYPE1;
+		port.membase = (char *)SIURB_TYPE1;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		s.iomem_base = (unsigned char *)SIURB_TYPE2;
+		port.membase = (char *)SIURB_TYPE2;
 		break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
 		break;
 	}
-	s.iomem_reg_shift = 0;
-	s.io_type = SERIAL_IO_MEM;
-	if (early_serial_setup(&s) != 0)
+	port.regshift = 0;
+	port.iotype = UPIO_MEM;
+	if (early_serial_setup(&port) != 0)
 		printk(KERN_ERR "SIU setup failed!\n");
 
 	vr41xx_supply_clock(SIU_CLOCK);
@@ -153,23 +144,23 @@
 
 void __init vr41xx_dsiu_init(void)
 {
-	struct serial_struct s;
+	struct uart_port port;
 
 	if (current_cpu_data.cputype != CPU_VR4122 &&
 	    current_cpu_data.cputype != CPU_VR4131 &&
 	    current_cpu_data.cputype != CPU_VR4133)
 		return;
 
-	memset(&s, 0, sizeof(s));
+	memset(&port, 0, sizeof(port));
 
-	s.line = vr41xx_serial_ports;
-	s.baud_base = DSIU_BASE_BAUD;
-	s.irq = DSIU_IRQ;
-	s.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
-	s.iomem_base = (unsigned char *)DSIURB;
-	s.iomem_reg_shift = 0;
-	s.io_type = SERIAL_IO_MEM;
-	if (early_serial_setup(&s) != 0)
+	port.line = vr41xx_serial_ports;
+	port.uartclk = DSIU_BASE_BAUD;
+	port.irq = DSIU_IRQ;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	port.membase = (char *)DSIURB;
+	port.regshift = 0;
+	port.iotype = UPIO_MEM;
+	if (early_serial_setup(&port) != 0)
 		printk(KERN_ERR "DSIU setup failed!\n");
 
 	vr41xx_supply_clock(DSIU_CLOCK);
