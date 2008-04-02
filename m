Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 12:16:46 +0200 (CEST)
Received: from mx1.minet.net ([157.159.40.25]:57556 "EHLO mx1.minet.net")
	by lappi.linux-mips.net with ESMTP id S524468AbYDBKQg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 12:16:36 +0200
Received: from localhost (spam.minet.net [192.168.1.97])
	by mx1.minet.net (Postfix) with ESMTP id F2D1E5CD71;
	Wed,  2 Apr 2008 12:17:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using ClamAV at minet.net
Received: from smtp.minet.net (imap.minet.net [192.168.1.27])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.minet.net (Postfix) with ESMTP id D5A1D5CD70;
	Wed,  2 Apr 2008 12:16:57 +0200 (CEST)
Received: from ibook (mla78-1-82-240-17-188.fbx.proxad.net [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: florian)
	by smtp.minet.net (Postfix) with ESMTP id A77F814A7A;
	Wed,  2 Apr 2008 12:16:26 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Wed, 2 Apr 2008 12:21:18 +0200
Subject: [PATCH] Fix Alchemy xss1500 and pb1x00 PCMCIA drivers
MIME-Version: 1.0
X-UID:	949
X-Length: 15920
To:	linux-pcmcia@lists.infradead.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Adrian Bunk <bunk@kernel.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804021221.19377.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This patch fixes compilation of the Alchemy XSS1500
and PB1x00 PCMCIA drivers. Clean up code while we are
at it.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
diff --git a/drivers/pcmcia/au1000_pb1x00.c b/drivers/pcmcia/au1000_pb1x00.c
index 86c0808..9bc9739 100644
--- a/drivers/pcmcia/au1000_pb1x00.c
+++ b/drivers/pcmcia/au1000_pb1x00.c
@@ -22,48 +22,41 @@
  *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
  */
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/tqueue.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/proc_fs.h>
-#include <linux/types.h>
-
-#include <pcmcia/cs_types.h>
-#include <pcmcia/cs.h>
-#include <pcmcia/ss.h>
-#include <pcmcia/bulkmem.h>
-#include <pcmcia/cistpl.h>
-#include <pcmcia/bus_ops.h>
-#include "cs_internal.h"
-
-#include <asm/io.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/init.h>
+
 #include <asm/irq.h>
-#include <asm/system.h>
+#include <asm/signal.h>
+#include <asm/mach-au1x00/au1000.h>
 
-#include <asm/au1000.h>
-#include <asm/au1000_pcmcia.h>
-
-#define debug(fmt, arg...) do { } while (0)
+#include "au1000_generic.h"
 
 #ifdef CONFIG_MIPS_PB1000
-#include <asm/pb1000.h>
+#include <asm/mach-pb1x00/pb1000.h>
 #define PCMCIA_IRQ AU1000_GPIO_15
 #elif defined (CONFIG_MIPS_PB1500)
-#include <asm/pb1500.h>
+#include <asm/mach-pb1x00/pb1500.h>
 #define PCMCIA_IRQ AU1500_GPIO_203
 #elif defined (CONFIG_MIPS_PB1100)
-#include <asm/pb1100.h>
+#include <asm/mach-pb1x00/pb1100.h>
 #define PCMCIA_IRQ AU1000_GPIO_11
 #endif
 
-static int pb1x00_pcmcia_init(struct pcmcia_init *init)
+#define debug(fmt, arg...) do { } while (0)
+
+struct au1000_pcmcia_socket au1000_pcmcia_socket[PCMCIA_NUM_SOCKS];
+extern int au1x00_pcmcia_socket_probe(struct device *, struct pcmcia_low_level *, int, int);
+
+static int pb1x00_pcmcia_init(struct au1000_pcmcia_socket *skt)
 {
-#ifdef CONFIG_MIPS_PB1000
 	u16 pcr;
+
+        skt->irq = PCMCIA_IRQ;
+
+#ifdef CONFIG_MIPS_PB1000
 	pcr = PCR_SLOT_0_RST | PCR_SLOT_1_RST;
 
 	au_writel(0x8000, PB1000_MDR); /* clear pcmcia interrupt */
@@ -79,17 +72,16 @@ static int pb1x00_pcmcia_init(struct pcmcia_init *init)
 	return PCMCIA_NUM_SOCKS;
 
 #else /* fixme -- take care of the Pb1500 at some point */
-
-	u16 pcr;
 	pcr = au_readw(PCMCIA_BOARD_REG) & ~0xf; /* turn off power */
 	pcr &= ~(PC_DEASSERT_RST | PC_DRV_EN);
 	au_writew(pcr, PCMCIA_BOARD_REG);
 	au_sync_delay(500);
+	
 	return PCMCIA_NUM_SOCKS;
 #endif
 }
 
-static int pb1x00_pcmcia_shutdown(void)
+static int pb1x00_pcmcia_shutdown(struct au1000_pcmcia_socket *skt)
 {
 #ifdef CONFIG_MIPS_PB1000
 	u16 pcr;
@@ -109,11 +101,12 @@ static int pb1x00_pcmcia_shutdown(void)
 #endif
 }
 
-static int 
-pb1x00_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
+static int pb1x00_pcmcia_socket_state(struct au1000_pcmcia_socket *skt, struct pcmcia_state *state)
 {
 	u32 inserted0, inserted1;
 	u16 vs0, vs1;
+	
+	vs1 = 0;
 
 #ifdef CONFIG_MIPS_PB1000
 	vs0 = vs1 = (u16)au_readl(PB1000_ACR1);
@@ -136,7 +129,7 @@ pb1x00_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
 	state->vs_3v = 0;
 	state->detect = 0;
 
-	if (sock == 0) {
+	if (skt->nr == 0) {
 		if (inserted0) {
 			switch (vs0) {
 				case 0:
@@ -179,37 +172,23 @@ pb1x00_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
 
 	state->bvd1=1;
 	state->bvd2=1;
-	state->wrprot=0; 
-	return 1;
-}
-
-
-static int pb1x00_pcmcia_get_irq_info(struct pcmcia_irq_info *info)
-{
-
-	if(info->sock > PCMCIA_MAX_SOCK) return -1;
+	state->wrprot=0;
 
-	/*
-	 * Even in the case of the Pb1000, both sockets are connected
-	 * to the same irq line.
-	 */
-	info->irq = PCMCIA_IRQ;
-
-	return 0;
+	return 1;
 }
 
 
-static int 
-pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
+static int pb1x00_pcmcia_configure_socket(struct au1000_pcmcia_socket *skt, struct socket_state_t *state)
 {
 	u16 pcr;
 
-	if(configure->sock > PCMCIA_MAX_SOCK) return -1;
+	if (skt->nr > PCMCIA_MAX_SOCK)
+		return -1;
 
 #ifdef CONFIG_MIPS_PB1000
 	pcr = au_readl(PB1000_PCR);
 
-	if (configure->sock == 0) {
+	if (skt->nr == 0) {
 		pcr &= ~(PCR_SLOT_0_VCC0 | PCR_SLOT_0_VCC1 | 
 				PCR_SLOT_0_VPP0 | PCR_SLOT_0_VPP1);
 	}
@@ -220,107 +199,107 @@ pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 
 	pcr &= ~PCR_SLOT_0_RST;
 	debug("Vcc %dV Vpp %dV, pcr %x\n", 
-			configure->vcc, configure->vpp, pcr);
-	switch(configure->vcc){
+			state->Vcc, state->Vpp, pcr);
+	switch(state->Vcc){
 		case 0:  /* Vcc 0 */
-			switch(configure->vpp) {
+			switch(state->Vpp) {
 				case 0:
 					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_GND,
-							configure->sock);
+							skt->nr);
 					break;
 				case 12:
 					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_12V,
-							configure->sock);
+							skt->nr);
 					break;
 				case 50:
 					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_5V,
-							configure->sock);
+							skt->nr);
 					break;
 				case 33:
 					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_3V,
-							configure->sock);
+							skt->nr);
 					break;
 				default:
 					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,
-							configure->sock);
+							skt->nr);
 					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
 							__FUNCTION__, 
-							configure->vcc, 
-							configure->vpp);
+							state->Vcc, 
+							state->Vpp);
 					break;
 			}
 			break;
 		case 50: /* Vcc 5V */
-			switch(configure->vpp) {
+			switch(state->Vpp) {
 				case 0:
 					pcr |= SET_VCC_VPP(VCC_5V,VPP_GND,
-							configure->sock);
+							stk->nr);
 					break;
 				case 50:
 					pcr |= SET_VCC_VPP(VCC_5V,VPP_5V,
-							configure->sock);
+							skt->nr);
 					break;
 				case 12:
 					pcr |= SET_VCC_VPP(VCC_5V,VPP_12V,
-							configure->sock);
+							skt->nr);
 					break;
 				case 33:
 					pcr |= SET_VCC_VPP(VCC_5V,VPP_3V,
-							configure->sock);
+							skt->nr);
 					break;
 				default:
 					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,
-							configure->sock);
+							skt->nr);
 					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
 							__FUNCTION__, 
-							configure->vcc, 
-							configure->vpp);
+							state->Vcc, 
+							state->Vpp);
 					break;
 			}
 			break;
 		case 33: /* Vcc 3.3V */
-			switch(configure->vpp) {
+			switch(state->Vpp) {
 				case 0:
 					pcr |= SET_VCC_VPP(VCC_3V,VPP_GND,
-							configure->sock);
+							skt->nr);
 					break;
 				case 50:
 					pcr |= SET_VCC_VPP(VCC_3V,VPP_5V,
-							configure->sock);
+							skt->nr);
 					break;
 				case 12:
 					pcr |= SET_VCC_VPP(VCC_3V,VPP_12V,
-							configure->sock);
+							skt->nr);
 					break;
 				case 33:
 					pcr |= SET_VCC_VPP(VCC_3V,VPP_3V,
-							configure->sock);
+							skt->nr);
 					break;
 				default:
 					pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,
-							configure->sock);
+							skt->nr);
 					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
 							__FUNCTION__, 
-							configure->vcc, 
-							configure->vpp);
+							state->Vcc, 
+							state->Vpp);
 					break;
 			}
 			break;
 		default: /* what's this ? */
-			pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,configure->sock);
+			pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,skt->nr);
 			printk(KERN_ERR "%s: bad Vcc %d\n", 
-					__FUNCTION__, configure->vcc);
+					__FUNCTION__, state->Vcc);
 			break;
 	}
 
-	if (configure->sock == 0) {
+	if (skt->nr == 0) {
 	pcr &= ~(PCR_SLOT_0_RST);
-		if (configure->reset)
-		pcr |= PCR_SLOT_0_RST;
+		if (state->flags & SS_REET)
+			pcr |= PCR_SLOT_0_RST;
 	}
 	else {
 		pcr &= ~(PCR_SLOT_1_RST);
-		if (configure->reset)
+		if (state->flags & SS_RESET)
 			pcr |= PCR_SLOT_1_RST;
 	}
 	au_writel(pcr, PB1000_PCR);
@@ -331,15 +310,15 @@ pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 	pcr = au_readw(PCMCIA_BOARD_REG) & ~0xf;
 
 	debug("Vcc %dV Vpp %dV, pcr %x, reset %d\n", 
-			configure->vcc, configure->vpp, pcr, configure->reset);
+			state->Vcc, state->Vpp, pcr, state->flags & SS_RESET);
 
 
-	switch(configure->vcc){
+	switch(state->Vcc){
 		case 0:  /* Vcc 0 */
 			pcr |= SET_VCC_VPP(0,0);
 			break;
 		case 50: /* Vcc 5V */
-			switch(configure->vpp) {
+			switch(state->Vpp) {
 				case 0:
 					pcr |= SET_VCC_VPP(2,0);
 					break;
@@ -354,13 +333,13 @@ pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 					pcr |= SET_VCC_VPP(0,0);
 					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
 							__FUNCTION__, 
-							configure->vcc, 
-							configure->vpp);
+							state->Vcc, 
+							state->Vpp);
 					break;
 			}
 			break;
 		case 33: /* Vcc 3.3V */
-			switch(configure->vpp) {
+			switch(state->Vpp) {
 				case 0:
 					pcr |= SET_VCC_VPP(1,0);
 					break;
@@ -375,22 +354,22 @@ pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 					pcr |= SET_VCC_VPP(0,0);
 					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
 							__FUNCTION__, 
-							configure->vcc, 
-							configure->vpp);
+							state->Vcc, 
+							state->Vpp);
 					break;
 			}
 			break;
 		default: /* what's this ? */
 			pcr |= SET_VCC_VPP(0,0);
 			printk(KERN_ERR "%s: bad Vcc %d\n", 
-					__FUNCTION__, configure->vcc);
+					__FUNCTION__, state->Vcc);
 			break;
 	}
 
 	au_writew(pcr, PCMCIA_BOARD_REG);
 	au_sync_delay(300);
 
-	if (!configure->reset) {
+	if (!(state->flags & SS_RESET)) {
 		pcr |= PC_DRV_EN;
 		au_writew(pcr, PCMCIA_BOARD_REG);
 		au_sync_delay(100);
@@ -408,10 +387,16 @@ pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 }
 
 
-struct pcmcia_low_level pb1x00_pcmcia_ops = { 
-	pb1x00_pcmcia_init,
-	pb1x00_pcmcia_shutdown,
-	pb1x00_pcmcia_socket_state,
-	pb1x00_pcmcia_get_irq_info,
-	pb1x00_pcmcia_configure_socket
+static struct pcmcia_low_level pb1x00_pcmcia_ops = {
+	.owner			= THIS_MODULE,
+	
+	.hw_init		= pb1x00_pcmcia_init,
+	.hw_shutdown		= pb1x00_pcmcia_shutdown,
+	.socket_state		= pb1x00_pcmcia_socket_state,
+	.configure_socket 	= pb1x00_pcmcia_configure_socket
 };
+
+int au1x_board_init(struct device *dev)
+{
+        return au1x00_pcmcia_socket_probe(dev, &pb1x00_pcmcia_ops, 0, PCMCIA_MAX_SOCK);
+}
diff --git a/drivers/pcmcia/au1000_xxs1500.c b/drivers/pcmcia/au1000_xxs1500.c
index ce9d5c4..1ca0e3b 100644
--- a/drivers/pcmcia/au1000_xxs1500.c
+++ b/drivers/pcmcia/au1000_xxs1500.c
@@ -26,47 +26,37 @@
  *
  */
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/tqueue.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/proc_fs.h>
-#include <linux/types.h>
-
-#include <pcmcia/cs_types.h>
-#include <pcmcia/cs.h>
-#include <pcmcia/ss.h>
-#include <pcmcia/bulkmem.h>
-#include <pcmcia/cistpl.h>
-#include <pcmcia/bus_ops.h>
-#include "cs_internal.h"
-
-#include <asm/io.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/init.h>
+
 #include <asm/irq.h>
-#include <asm/system.h>
+#include <asm/signal.h>
+#include <asm/mach-au1x00/au1000.h>
 
-#include <asm/au1000.h>
-#include <asm/au1000_pcmcia.h>
+#include "au1000_generic.h"
 
 #define PCMCIA_MAX_SOCK		0
 #define PCMCIA_NUM_SOCKS	(PCMCIA_MAX_SOCK + 1)
-#define PCMCIA_IRQ		AU1000_GPIO_4
 
-#if 0
-#define DEBUG(x,args...)	printk(__FUNCTION__ ": " x,##args)
-#else
 #define DEBUG(x,args...)
-#endif
 
-static int xxs1500_pcmcia_init(struct pcmcia_init *init)
+struct au1000_pcmcia_socket au1000_pcmcia_socket[PCMCIA_NUM_SOCKS];
+extern int au1x00_pcmcia_socket_probe(struct device *, struct pcmcia_low_level *, int, int);
+
+static int xxs1500_pcmcia_init(struct au1000_pcmcia_socket *skt)
 {
+	if (skt->nr > PCMCIA_MAX_SOCK)
+		return -1;
+
+	skt->irq = AU1000_GPIO_4;
+
 	return PCMCIA_NUM_SOCKS;
 }
 
-static int xxs1500_pcmcia_shutdown(void)
+static int xxs1500_pcmcia_shutdown(struct au1000_pcmcia_socket *skt)
 {
 	/* turn off power */
 	au_writel(au_readl(GPIO2_PINSTATE) | (1<<14)|(1<<30),
@@ -82,12 +72,13 @@ static int xxs1500_pcmcia_shutdown(void)
 
 
 static int
-xxs1500_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
+xxs1500_pcmcia_socket_state(struct au1000_pcmcia_socket *skt, struct pcmcia_state *state)
 {
 	u32 inserted; u32 vs;
 	unsigned long gpio, gpio2;
 
-	if(sock > PCMCIA_MAX_SOCK) return -1;
+	if(skt->nr > PCMCIA_MAX_SOCK)
+		return -1;
 
 	gpio = au_readl(SYS_PINSTATERD);
 	gpio2 = au_readl(GPIO2_PINSTATE);
@@ -110,9 +101,9 @@ xxs1500_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
 			case 3: /* 5V */
 			default:
 				/* return without setting 'detect' */
-				printk(KERN_ERR "au1x00_cs: unsupported VS\n",
+				printk(KERN_ERR "au1x00_cs: unsupported VS 0x%08x\n",
 						vs);
-				return;
+				return -1;
 		}
 		state->detect = 1;
 	}
@@ -128,25 +119,16 @@ xxs1500_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
 }
 
 
-static int xxs1500_pcmcia_get_irq_info(struct pcmcia_irq_info *info)
-{
-
-	if(info->sock > PCMCIA_MAX_SOCK) return -1;
-	info->irq = PCMCIA_IRQ;
-	return 0;
-}
-
-
 static int
-xxs1500_pcmcia_configure_socket(const struct pcmcia_configure *configure)
+xxs1500_pcmcia_configure_socket(struct au1000_pcmcia_socket *skt, struct socket_state_t *state)
 {
-
-	if(configure->sock > PCMCIA_MAX_SOCK) return -1;
+	if(skt->nr > PCMCIA_MAX_SOCK)
+		return -1;
 
 	DEBUG("Vcc %dV Vpp %dV, reset %d\n",
-			configure->vcc, configure->vpp, configure->reset);
+			state->Vcc, state->vpp, state->flags & SS_RESET);
 
-	switch(configure->vcc){
+	switch(state->Vcc){
 		case 33: /* Vcc 3.3V */
 			/* turn on power */
 			DEBUG("turn on power\n");
@@ -165,7 +147,7 @@ xxs1500_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 			break;
 	}
 
-	if (!configure->reset) {
+	if (!(state->flags & SS_RESET)) {
 		DEBUG("deassert reset\n");
 		au_writel((au_readl(GPIO2_PINSTATE) & ~(1<<4))|(1<<20),
 				GPIO2_OUTPUT);
@@ -183,9 +165,16 @@ xxs1500_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 }
 
 struct pcmcia_low_level xxs1500_pcmcia_ops = {
-	xxs1500_pcmcia_init,
-	xxs1500_pcmcia_shutdown,
-	xxs1500_pcmcia_socket_state,
-	xxs1500_pcmcia_get_irq_info,
-	xxs1500_pcmcia_configure_socket
+	.owner 			= THIS_MODULE,
+
+	.hw_init 		= xxs1500_pcmcia_init,
+	.hw_shutdown		= xxs1500_pcmcia_shutdown,
+
+	.socket_state		= xxs1500_pcmcia_socket_state,
+	.configure_socket 	= xxs1500_pcmcia_configure_socket
 };
+
+int au1x_board_init(struct device *dev)
+{
+	return au1x00_pcmcia_socket_probe(dev, &xxs1500_pcmcia_ops, 0, PCMCIA_MAX_SOCK);
+}
