Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2008 17:11:08 +0100 (BST)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:30130 "EHLO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20033275AbYHaQLF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 Aug 2008 17:11:05 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id A2EA15BC04E;
	Sun, 31 Aug 2008 19:11:04 +0300 (EEST)
Date:	Sun, 31 Aug 2008 19:09:52 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Dominik Brodowski <linux@dominikbrodowski.net>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-pcmcia@lists.infradead.org,
	source@mvista.com
Subject: [2.6 patch] remove drivers/pcmcia/au1000_pb1x00.c
Message-ID: <20080831160951.GB3695@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

drivers/pcmcia/au1000_pb1x00.c was added in 2003 but #include's 
linux/tqueue.h that was removed in 2002.

This file clearly never compiled after it was added to the tree.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/pcmcia/Kconfig         |    3 
 drivers/pcmcia/Makefile        |   12 
 drivers/pcmcia/au1000_pb1x00.c |  416 ---------------------------------
 3 files changed, 4 insertions(+), 427 deletions(-)


diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index e0f8840..074280d 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -194,7 +194,8 @@ config HD64465_PCMCIA
 
 config PCMCIA_AU1X00
 	tristate "Au1x00 pcmcia support"
-	depends on SOC_AU1X00 && PCMCIA
+	depends on PCMCIA
+	depends on MIPS_PB1200 || MIPS_DB1000 || MIPS_DB1100 || MIPS_DB1200 || MIPS_DB1500 || MIPS_DB1550
 
 config PCMCIA_SA1100
 	tristate "SA1100 support"
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 7c851a8..5fe4809 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -43,16 +43,8 @@ obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
 sa11xx_core-y					+= soc_common.o sa11xx_base.o
 pxa2xx_core-y					+= soc_common.o pxa2xx_base.o
 
-au1x00_ss-y					+= au1000_generic.o
-au1x00_ss-$(CONFIG_MIPS_PB1000)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1100)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1200)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1500)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1000)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1100)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1200)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1500)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1550)			+= au1000_db1x00.o
+au1x00_ss-y					+= au1000_generic.o \
+						   au1000_db1x00.o
 
 sa1111_cs-y					+= sa1111_generic.o
 sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1100_neponset.o
diff --git a/drivers/pcmcia/au1000_pb1x00.c b/drivers/pcmcia/au1000_pb1x00.c
deleted file mode 100644
index aa1cd4d..0000000
--- a/drivers/pcmcia/au1000_pb1x00.c
+++ /dev/null
@@ -1,416 +0,0 @@
-/*
- *
- * Alchemy Semi Pb1x00 boards specific pcmcia routines.
- *
- * Copyright 2002 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- */
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/tqueue.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/proc_fs.h>
-#include <linux/types.h>
-
-#include <pcmcia/cs_types.h>
-#include <pcmcia/cs.h>
-#include <pcmcia/ss.h>
-#include <pcmcia/cistpl.h>
-#include <pcmcia/bus_ops.h>
-#include "cs_internal.h"
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/system.h>
-
-#include <asm/au1000.h>
-#include <asm/au1000_pcmcia.h>
-
-#define debug(fmt, arg...) do { } while (0)
-
-#ifdef CONFIG_MIPS_PB1000
-#include <asm/pb1000.h>
-#define PCMCIA_IRQ AU1000_GPIO_15
-#elif defined (CONFIG_MIPS_PB1500)
-#include <asm/pb1500.h>
-#define PCMCIA_IRQ AU1500_GPIO_203
-#elif defined (CONFIG_MIPS_PB1100)
-#include <asm/pb1100.h>
-#define PCMCIA_IRQ AU1000_GPIO_11
-#endif
-
-static int pb1x00_pcmcia_init(struct pcmcia_init *init)
-{
-#ifdef CONFIG_MIPS_PB1000
-	u16 pcr;
-	pcr = PCR_SLOT_0_RST | PCR_SLOT_1_RST;
-
-	au_writel(0x8000, PB1000_MDR); /* clear pcmcia interrupt */
-	au_sync_delay(100);
-	au_writel(0x4000, PB1000_MDR); /* enable pcmcia interrupt */
-	au_sync();
-
-	pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,0);
-	pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,1);
-	au_writel(pcr, PB1000_PCR);
-	au_sync_delay(20);
-	  
-	return PCMCIA_NUM_SOCKS;
-
-#else /* fixme -- take care of the Pb1500 at some point */
-
-	u16 pcr;
-	pcr = au_readw(PCMCIA_BOARD_REG) & ~0xf; /* turn off power */
-	pcr &= ~(PC_DEASSERT_RST | PC_DRV_EN);
-	au_writew(pcr, PCMCIA_BOARD_REG);
-	au_sync_delay(500);
-	return PCMCIA_NUM_SOCKS;
-#endif
-}
-
-static int pb1x00_pcmcia_shutdown(void)
-{
-#ifdef CONFIG_MIPS_PB1000
-	u16 pcr;
-	pcr = PCR_SLOT_0_RST | PCR_SLOT_1_RST;
-	pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,0);
-	pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,1);
-	au_writel(pcr, PB1000_PCR);
-	au_sync_delay(20);
-	return 0;
-#else
-	u16 pcr;
-	pcr = au_readw(PCMCIA_BOARD_REG) & ~0xf; /* turn off power */
-	pcr &= ~(PC_DEASSERT_RST | PC_DRV_EN);
-	au_writew(pcr, PCMCIA_BOARD_REG);
-	au_sync_delay(2);
-	return 0;
-#endif
-}
-
-static int 
-pb1x00_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
-{
-	u32 inserted0, inserted1;
-	u16 vs0, vs1;
-
-#ifdef CONFIG_MIPS_PB1000
-	vs0 = vs1 = (u16)au_readl(PB1000_ACR1);
-	inserted0 = !(vs0 & (ACR1_SLOT_0_CD1 | ACR1_SLOT_0_CD2));
-	inserted1 = !(vs1 & (ACR1_SLOT_1_CD1 | ACR1_SLOT_1_CD2));
-	vs0 = (vs0 >> 4) & 0x3;
-	vs1 = (vs1 >> 12) & 0x3;
-#else
-	vs0 = (au_readw(BOARD_STATUS_REG) >> 4) & 0x3;
-#ifdef CONFIG_MIPS_PB1500
-	inserted0 = !((au_readl(GPIO2_PINSTATE) >> 1) & 0x1); /* gpio 201 */
-#else /* Pb1100 */
-	inserted0 = !((au_readl(SYS_PINSTATERD) >> 9) & 0x1); /* gpio 9 */
-#endif
-	inserted1 = 0;
-#endif
-
-	state->ready = 0;
-	state->vs_Xv = 0;
-	state->vs_3v = 0;
-	state->detect = 0;
-
-	if (sock == 0) {
-		if (inserted0) {
-			switch (vs0) {
-				case 0:
-				case 2:
-					state->vs_3v=1;
-					break;
-				case 3: /* 5V */
-					break;
-				default:
-					/* return without setting 'detect' */
-					printk(KERN_ERR "pb1x00 bad VS (%d)\n",
-							vs0);
-					return 0;
-			}
-			state->detect = 1;
-		}
-	}
-	else  {
-		if (inserted1) {
-			switch (vs1) {
-				case 0:
-				case 2:
-					state->vs_3v=1;
-					break;
-				case 3: /* 5V */
-					break;
-				default:
-					/* return without setting 'detect' */
-					printk(KERN_ERR "pb1x00 bad VS (%d)\n",
-							vs1);
-					return 0;
-			}
-			state->detect = 1;
-		}
-	}
-
-	if (state->detect) {
-		state->ready = 1;
-	}
-
-	state->bvd1=1;
-	state->bvd2=1;
-	state->wrprot=0; 
-	return 1;
-}
-
-
-static int pb1x00_pcmcia_get_irq_info(struct pcmcia_irq_info *info)
-{
-
-	if(info->sock > PCMCIA_MAX_SOCK) return -1;
-
-	/*
-	 * Even in the case of the Pb1000, both sockets are connected
-	 * to the same irq line.
-	 */
-	info->irq = PCMCIA_IRQ;
-
-	return 0;
-}
-
-
-static int 
-pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
-{
-	u16 pcr;
-
-	if(configure->sock > PCMCIA_MAX_SOCK) return -1;
-
-#ifdef CONFIG_MIPS_PB1000
-	pcr = au_readl(PB1000_PCR);
-
-	if (configure->sock == 0) {
-		pcr &= ~(PCR_SLOT_0_VCC0 | PCR_SLOT_0_VCC1 | 
-				PCR_SLOT_0_VPP0 | PCR_SLOT_0_VPP1);
-	}
-	else  {
-		pcr &= ~(PCR_SLOT_1_VCC0 | PCR_SLOT_1_VCC1 | 
-				PCR_SLOT_1_VPP0 | PCR_SLOT_1_VPP1);
-	}
-
-	pcr &= ~PCR_SLOT_0_RST;
-	debug("Vcc %dV Vpp %dV, pcr %x\n", 
-			configure->vcc, configure->vpp, pcr);
-	switch(configure->vcc){
-		case 0:  /* Vcc 0 */
-			switch(configure->vpp) {
-				case 0:
-					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_GND,
-							configure->sock);
-					break;
-				case 12:
-					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_12V,
-							configure->sock);
-					break;
-				case 50:
-					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_5V,
-							configure->sock);
-					break;
-				case 33:
-					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_3V,
-							configure->sock);
-					break;
-				default:
-					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,
-							configure->sock);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
-							__func__,
-							configure->vcc, 
-							configure->vpp);
-					break;
-			}
-			break;
-		case 50: /* Vcc 5V */
-			switch(configure->vpp) {
-				case 0:
-					pcr |= SET_VCC_VPP(VCC_5V,VPP_GND,
-							configure->sock);
-					break;
-				case 50:
-					pcr |= SET_VCC_VPP(VCC_5V,VPP_5V,
-							configure->sock);
-					break;
-				case 12:
-					pcr |= SET_VCC_VPP(VCC_5V,VPP_12V,
-							configure->sock);
-					break;
-				case 33:
-					pcr |= SET_VCC_VPP(VCC_5V,VPP_3V,
-							configure->sock);
-					break;
-				default:
-					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,
-							configure->sock);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
-							__func__,
-							configure->vcc, 
-							configure->vpp);
-					break;
-			}
-			break;
-		case 33: /* Vcc 3.3V */
-			switch(configure->vpp) {
-				case 0:
-					pcr |= SET_VCC_VPP(VCC_3V,VPP_GND,
-							configure->sock);
-					break;
-				case 50:
-					pcr |= SET_VCC_VPP(VCC_3V,VPP_5V,
-							configure->sock);
-					break;
-				case 12:
-					pcr |= SET_VCC_VPP(VCC_3V,VPP_12V,
-							configure->sock);
-					break;
-				case 33:
-					pcr |= SET_VCC_VPP(VCC_3V,VPP_3V,
-							configure->sock);
-					break;
-				default:
-					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,
-							configure->sock);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
-							__func__,
-							configure->vcc, 
-							configure->vpp);
-					break;
-			}
-			break;
-		default: /* what's this ? */
-			pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,configure->sock);
-			printk(KERN_ERR "%s: bad Vcc %d\n", 
-					__func__, configure->vcc);
-			break;
-	}
-
-	if (configure->sock == 0) {
-	pcr &= ~(PCR_SLOT_0_RST);
-		if (configure->reset)
-		pcr |= PCR_SLOT_0_RST;
-	}
-	else {
-		pcr &= ~(PCR_SLOT_1_RST);
-		if (configure->reset)
-			pcr |= PCR_SLOT_1_RST;
-	}
-	au_writel(pcr, PB1000_PCR);
-	au_sync_delay(300);
-
-#else
-
-	pcr = au_readw(PCMCIA_BOARD_REG) & ~0xf;
-
-	debug("Vcc %dV Vpp %dV, pcr %x, reset %d\n", 
-			configure->vcc, configure->vpp, pcr, configure->reset);
-
-
-	switch(configure->vcc){
-		case 0:  /* Vcc 0 */
-			pcr |= SET_VCC_VPP(0,0);
-			break;
-		case 50: /* Vcc 5V */
-			switch(configure->vpp) {
-				case 0:
-					pcr |= SET_VCC_VPP(2,0);
-					break;
-				case 50:
-					pcr |= SET_VCC_VPP(2,1);
-					break;
-				case 12:
-					pcr |= SET_VCC_VPP(2,2);
-					break;
-				case 33:
-				default:
-					pcr |= SET_VCC_VPP(0,0);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
-							__func__,
-							configure->vcc, 
-							configure->vpp);
-					break;
-			}
-			break;
-		case 33: /* Vcc 3.3V */
-			switch(configure->vpp) {
-				case 0:
-					pcr |= SET_VCC_VPP(1,0);
-					break;
-				case 12:
-					pcr |= SET_VCC_VPP(1,2);
-					break;
-				case 33:
-					pcr |= SET_VCC_VPP(1,1);
-					break;
-				case 50:
-				default:
-					pcr |= SET_VCC_VPP(0,0);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
-							__func__,
-							configure->vcc, 
-							configure->vpp);
-					break;
-			}
-			break;
-		default: /* what's this ? */
-			pcr |= SET_VCC_VPP(0,0);
-			printk(KERN_ERR "%s: bad Vcc %d\n", 
-					__func__, configure->vcc);
-			break;
-	}
-
-	au_writew(pcr, PCMCIA_BOARD_REG);
-	au_sync_delay(300);
-
-	if (!configure->reset) {
-		pcr |= PC_DRV_EN;
-		au_writew(pcr, PCMCIA_BOARD_REG);
-		au_sync_delay(100);
-		pcr |= PC_DEASSERT_RST;
-		au_writew(pcr, PCMCIA_BOARD_REG);
-		au_sync_delay(100);
-	}
-	else {
-		pcr &= ~(PC_DEASSERT_RST | PC_DRV_EN);
-		au_writew(pcr, PCMCIA_BOARD_REG);
-		au_sync_delay(100);
-	}
-#endif
-	return 0;
-}
-
-
-struct pcmcia_low_level pb1x00_pcmcia_ops = { 
-	pb1x00_pcmcia_init,
-	pb1x00_pcmcia_shutdown,
-	pb1x00_pcmcia_socket_state,
-	pb1x00_pcmcia_get_irq_info,
-	pb1x00_pcmcia_configure_socket
-};
