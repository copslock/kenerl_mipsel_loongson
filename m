Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:56:15 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:56812 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226031AbUEZPwb>;
	Wed, 26 May 2004 16:52:31 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA02606;
	Thu, 27 May 2004 00:52:27 +0900 (JST)
Received: 4UMDO00 id i4QFqRQ00102; Thu, 27 May 2004 00:52:27 +0900 (JST)
Received: 4UMRO00 id i4QFqQV28848; Thu, 27 May 2004 00:52:26 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:52:24 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][13/14] vr41xx: update setup.c for NEC Eagle
Message-Id: <20040527005224.542a5087.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

setup.c for NEC Eagle was updated.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Thu May 13 23:33:00 2004
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Fri May 14 00:23:19 2004
@@ -1,72 +1,26 @@
 /*
- * arch/mips/vr41xx/nec-eagle/setup.c
+ *  setup.c, Setup for the NEC Eagle/Hawk board.
  *
- * Setup for the NEC Eagle/Hawk board.
+ *  Copyright (C) 2001-2004  MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
  *
- * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- * 2001-2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
-#include <linux/ioport.h>
-
-#include <asm/io.h>
-#include <asm/pci_channel.h>
-#include <asm/vr41xx/eagle.h>
-
-#ifdef CONFIG_PCI
-
-extern void vrc4173_preinit(void);
-
-static struct resource vr41xx_pci_io_resource = {
-	"PCI I/O space",
-	VR41XX_PCI_IO_START,
-	VR41XX_PCI_IO_END,
-	IORESOURCE_IO
-};
-
-static struct resource vr41xx_pci_mem_resource = {
-	"PCI memory space",
-	VR41XX_PCI_MEM_START,
-	VR41XX_PCI_MEM_END,
-	IORESOURCE_MEM
-};
-
-extern struct pci_ops vr41xx_pci_ops;
 
-struct pci_controller vr41xx_controller = {
-	.pci_ops	= &vr41xx_pci_ops,
-	.io_resource	= &vr41xx_pci_io_resource,
-	.mem_resource	= &vr41xx_pci_mem_resource,
-};
-
-struct vr41xx_pci_address_space vr41xx_pci_mem1 = {
-	VR41XX_PCI_MEM1_BASE,
-	VR41XX_PCI_MEM1_MASK,
-	IO_MEM1_RESOURCE_START
-};
-
-struct vr41xx_pci_address_space vr41xx_pci_mem2 = {
-	VR41XX_PCI_MEM2_BASE,
-	VR41XX_PCI_MEM2_MASK,
-	IO_MEM2_RESOURCE_START
-};
-
-struct vr41xx_pci_address_space vr41xx_pci_io = {
-	VR41XX_PCI_IO_BASE,
-	VR41XX_PCI_IO_MASK,
-	IO_PORT_RESOURCE_START
-};
-
-static struct vr41xx_pci_address_map pci_address_map = {
-	&vr41xx_pci_mem1,
-	&vr41xx_pci_mem2,
-	&vr41xx_pci_io
-};
-#endif
+#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
@@ -75,18 +29,10 @@
 
 static int nec_eagle_setup(void)
 {
-	set_io_port_base(IO_PORT_BASE);
-	ioport_resource.start = IO_PORT_RESOURCE_START;
-	ioport_resource.end = IO_PORT_RESOURCE_END;
-
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
 	vr41xx_siu_init();
 	vr41xx_dsiu_init();
-#endif
-
-#ifdef CONFIG_PCI
-	vr41xx_pciu_init(&pci_address_map);
 #endif
 
 	return 0;
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/eagle.h linux/include/asm-mips/vr41xx/eagle.h
--- linux-orig/include/asm-mips/vr41xx/eagle.h	Mon Mar 24 00:01:42 2003
+++ linux/include/asm-mips/vr41xx/eagle.h	Fri May 14 00:23:19 2004
@@ -1,71 +1,29 @@
 /*
- * FILE NAME
- *	include/asm-mips/vr41xx/eagle.h
+ *  eagle.h, Include file for NEC Eagle board.
  *
- * BRIEF MODULE DESCRIPTION
- *	Include file for NEC Eagle board.
+ *  Copyright (C) 2001-2003  MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
  *
- * Author: MontaVista Software, Inc.
- *         yyuasa@mvista.com or source@mvista.com
- *
- * Copyright 2001-2003 MontaVista Software Inc.
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
 #ifndef __NEC_EAGLE_H
 #define __NEC_EAGLE_H
 
-#include <asm/addrspace.h>
 #include <asm/vr41xx/vr41xx.h>
 
 /*
- * Board specific address mapping
- */
-#define VR41XX_PCI_MEM1_BASE		0x10000000
-#define VR41XX_PCI_MEM1_SIZE		0x04000000
-#define VR41XX_PCI_MEM1_MASK		0x7c000000
-
-#define VR41XX_PCI_MEM2_BASE		0x14000000
-#define VR41XX_PCI_MEM2_SIZE		0x02000000
-#define VR41XX_PCI_MEM2_MASK		0x7e000000
-
-#define VR41XX_PCI_IO_BASE		0x16000000
-#define VR41XX_PCI_IO_SIZE		0x02000000
-#define VR41XX_PCI_IO_MASK		0x7e000000
-
-#define VR41XX_PCI_IO_START		0x01000000
-#define VR41XX_PCI_IO_END		0x01ffffff
-
-#define VR41XX_PCI_MEM_START		0x12000000
-#define VR41XX_PCI_MEM_END		0x15ffffff
-
-#define IO_PORT_BASE			KSEG1ADDR(VR41XX_PCI_IO_BASE)
-#define IO_PORT_RESOURCE_START		0
-#define IO_PORT_RESOURCE_END		VR41XX_PCI_IO_SIZE
-#define IO_MEM1_RESOURCE_START		VR41XX_PCI_MEM1_BASE
-#define IO_MEM1_RESOURCE_END		(VR41XX_PCI_MEM1_BASE + VR41XX_PCI_MEM1_SIZE)
-#define IO_MEM2_RESOURCE_START		VR41XX_PCI_MEM2_BASE
-#define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
-
-/*
  * General-Purpose I/O Pin Number
  */
 #define VRC4173_PIN			1
@@ -99,167 +57,5 @@
 #define CP_INTD_IRQ			PCIINT_IRQ(3)
 #define LANINTA_IRQ			PCIINT_IRQ(4)
 #define PCIINT_IRQ_LAST			LANINTA_IRQ
-
-/*
- * On board Devices I/O Mapping
- */
-#define NEC_EAGLE_SIO1RB		KSEG1ADDR(0x0DFFFEC0)
-#define NEC_EAGLE_SIO1TH		KSEG1ADDR(0x0DFFFEC0)
-#define NEC_EAGLE_SIO1IE		KSEG1ADDR(0x0DFFFEC2)
-#define NEC_EAGLE_SIO1IID		KSEG1ADDR(0x0DFFFEC4)
-#define NEC_EAGLE_SIO1FC		KSEG1ADDR(0x0DFFFEC4)
-#define NEC_EAGLE_SIO1LC		KSEG1ADDR(0x0DFFFEC6)
-#define NEC_EAGLE_SIO1MC		KSEG1ADDR(0x0DFFFEC8)
-#define NEC_EAGLE_SIO1LS		KSEG1ADDR(0x0DFFFECA)
-#define NEC_EAGLE_SIO1MS		KSEG1ADDR(0x0DFFFECC)
-#define NEC_EAGLE_SIO1SC		KSEG1ADDR(0x0DFFFECE)
-
-#define NEC_EAGLE_SIO2TH		KSEG1ADDR(0x0DFFFED0)
-#define NEC_EAGLE_SIO2IE		KSEG1ADDR(0x0DFFFED2)
-#define NEC_EAGLE_SIO2IID		KSEG1ADDR(0x0DFFFED4)
-#define NEC_EAGLE_SIO2FC		KSEG1ADDR(0x0DFFFED4)
-#define NEC_EAGLE_SIO2LC		KSEG1ADDR(0x0DFFFED6)
-#define NEC_EAGLE_SIO2MC		KSEG1ADDR(0x0DFFFED8)
-#define NEC_EAGLE_SIO2LS		KSEG1ADDR(0x0DFFFEDA)
-#define NEC_EAGLE_SIO2MS		KSEG1ADDR(0x0DFFFEDC)
-#define NEC_EAGLE_SIO2SC		KSEG1ADDR(0x0DFFFEDE)
-
-#define NEC_EAGLE_PIOPP_DATA		KSEG1ADDR(0x0DFFFEE0)
-#define NEC_EAGLE_PIOPP_STATUS		KSEG1ADDR(0x0DFFFEE2)
-#define NEC_EAGLE_PIOPP_CNT		KSEG1ADDR(0x0DFFFEE4)
-#define NEC_EAGLE_PIOPP_EPPADDR		KSEG1ADDR(0x0DFFFEE6)
-#define NEC_EAGLE_PIOPP_EPPDATA0	KSEG1ADDR(0x0DFFFEE8)
-#define NEC_EAGLE_PIOPP_EPPDATA1	KSEG1ADDR(0x0DFFFEEA)
-#define NEC_EAGLE_PIOPP_EPPDATA2	KSEG1ADDR(0x0DFFFEEC)
-
-#define NEC_EAGLE_PIOECP_DATA		KSEG1ADDR(0x0DFFFEF0)
-#define NEC_EAGLE_PIOECP_CONFIG		KSEG1ADDR(0x0DFFFEF2)
-#define NEC_EAGLE_PIOECP_EXTCNT		KSEG1ADDR(0x0DFFFEF4)
-
-/*
- *  FLSHCNT Register
- */
-#define NEC_EAGLE_FLSHCNT		KSEG1ADDR(0x0DFFFFA0)
-#define NEC_EAGLE_FLSHCNT_FRDY		0x80
-#define NEC_EAGLE_FLSHCNT_VPPE		0x40
-#define NEC_EAGLE_FLSHCNT_WP2		0x01
-
-/*
- * FLSHBANK Register
- */
-#define NEC_EAGLE_FLSHBANK		KSEG1ADDR(0x0DFFFFA4)
-#define NEC_EAGLE_FLSHBANK_S_BANK2	0x40
-#define NEC_EAGLE_FLSHBANK_S_BANK1	0x20
-#define NEC_EAGLE_FLSHBANK_BNKQ4	0x10
-#define NEC_EAGLE_FLSHBANK_BNKQ3	0x08
-#define NEC_EAGLE_FLSHBANK_BNKQ2	0x04
-#define NEC_EAGLE_FLSHBANK_BNKQ1	0x02
-#define NEC_EAGLE_FLSHBANK_BNKQ0	0x01
-
-/*
- * SWITCH Setting Register
- */
-#define NEC_EAGLE_SWTCHSET		KSEG1ADDR(0x0DFFFFA8)
-#define NEC_EAGLE_SWTCHSET_DP2SW4	0x80
-#define NEC_EAGLE_SWTCHSET_DP2SW3	0x40
-#define NEC_EAGLE_SWTCHSET_DP2SW2	0x20
-#define NEC_EAGLE_SWTCHSET_DP2SW1	0x10
-#define NEC_EAGLE_SWTCHSET_DP1SW4	0x08
-#define NEC_EAGLE_SWTCHSET_DP1SW3	0x04
-#define NEC_EAGLE_SWTCHSET_DP1SW2	0x02
-#define NEC_EAGLE_SWTCHSET_DP1SW1	0x01
-
-/*
- * PPT Parallel Port Device Controller
- */
-#define NEC_EAGLE_PPT_WRITE_DATA	KSEG1ADDR(0x0DFFFFB0)
-#define NEC_EAGLE_PPT_READ_DATA		KSEG1ADDR(0x0DFFFFB2)
-#define NEC_EAGLE_PPT_CNT		KSEG1ADDR(0x0DFFFFB4)
-#define NEC_EAGLE_PPT_CNT2		KSEG1ADDR(0x0DFFFFB4)
-
-/* Control Register */
-#define NEC_EAGLE_PPT_INTMSK		0x20
-#define NEC_EAGLE_PPT_PARIINT		0x10
-#define NEC_EAGLE_PPT_SELECTIN		0x08
-#define NEC_EAGLE_PPT_INIT		0x04
-#define NEC_EAGLE_PPT_AUTOFD		0x02
-#define NEC_EAGLE_PPT_STROBE		0x01
-
-/* Control Rgister 2 */
-#define NEC_EAGLE_PPT_PAREN		0x80
-#define NEC_EAGLE_PPT_AUTOEN		0x20
-#define NEC_EAGLE_PPT_BUSY		0x10
-#define NEC_EAGLE_PPT_ACK		0x08
-#define NEC_EAGLE_PPT_PE		0x04
-#define NEC_EAGLE_PPT_SELECT		0x02
-#define NEC_EAGLE_PPT_FAULT		0x01
-
-/*
- * LEDWR Register
- */
-#define NEC_EAGLE_LEDWR1		KSEG1ADDR(0x0DFFFFC0)
-#define NEC_EAGLE_LEDWR2		KSEG1ADDR(0x0DFFFFC4)
-
-/*
- * SDBINT Register
- */
-#define NEC_EAGLE_SDBINT		KSEG1ADDR(0x0DFFFFD0)
-#define NEC_EAGLE_SDBINT_PARINT		0x20
-#define NEC_EAGLE_SDBINT_SIO2INT	0x10
-#define NEC_EAGLE_SDBINT_SIO1INT	0x08
-#define NEC_EAGLE_SDBINT_ENUM		0x04
-#define NEC_EAGLE_SDBINT_DEG		0x02
-
-/*
- * SDB INTMSK Register
- */
-#define NEC_EAGLE_SDBINTMSK		KSEG1ADDR(0x0DFFFFD4)
-#define NEC_EAGLE_SDBINTMSK_MSKPAR	0x20
-#define NEC_EAGLE_SDBINTMSK_MSKSIO2	0x10
-#define NEC_EAGLE_SDBINTMSK_MSKSIO1	0x08
-#define NEC_EAGLE_SDBINTMSK_MSKENUM	0x04
-#define NEC_EAGLE_SDBINTMSK_MSKDEG	0x02
-
-/*
- * RSTREG Register
- */
-#define NEC_EAGLE_RSTREG		KSEG1ADDR(0x0DFFFFD8)
-#define NEC_EAGLE_RST_RSTSW		0x02
-#define NEC_EAGLE_RST_LEDOFF		0x01
-
-/*
- * PCI INT Rgister
- */
-#define NEC_EAGLE_PCIINTREG		KSEG1ADDR(0x0DFFFFDC)
-#define NEC_EAGLE_PCIINT_LANINT		0x10
-#define NEC_EAGLE_PCIINT_CP_INTD	0x08
-#define NEC_EAGLE_PCIINT_CP_INTC	0x04
-#define NEC_EAGLE_PCIINT_CP_INTB	0x02
-#define NEC_EAGLE_PCIINT_CP_INTA	0x01
-
-/*
- * PCI INT Mask Register
- */
-#define NEC_EAGLE_PCIINTMSKREG		KSEG1ADDR(0x0DFFFFE0)
-#define NEC_EAGLE_PCIINTMSK_MSKLANINT	0x10
-#define NEC_EAGLE_PCIINTMSK_MSKCP_INTD	0x08
-#define NEC_EAGLE_PCIINTMSK_MSKCP_INTC	0x04
-#define NEC_EAGLE_PCIINTMSK_MSKCP_INTB	0x02
-#define NEC_EAGLE_PCIINTMSK_MSKCP_INTA	0x01
-
-/*
- * CLK Division Register
- */
-#define NEC_EAGLE_CLKDIV		KSEG1ADDR(0x0DFFFFE4)
-#define NEC_EAGLE_CLKDIV_PCIDIV1	0x10
-#define NEC_EAGLE_CLKDIV_PCIDIV0	0x08
-#define NEC_EAGLE_CLKDIV_VTDIV2		0x04
-#define NEC_EAGLE_CLKDIV_VTDIV1		0x02
-#define NEC_EAGLE_CLKDIV_VTDIV0		0x01
-
-/*
- * Source Revision Register
- */
-#define NEC_EAGLE_REVISION		KSEG1ADDR(0x0DFFFFE8)
 
 #endif /* __NEC_EAGLE_H */
