Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 10:30:31 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:38316 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133415AbWAJKaK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jan 2006 10:30:10 +0000
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1EwGoR-0007ta-00
	for <linux-mips@linux-mips.org>; Tue, 10 Jan 2006 11:33:11 +0100
Date:	Tue, 10 Jan 2006 11:33:11 +0100
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: [PATCH] IrDA support for au1000/au1100
Message-ID: <20060110103311.GE1373@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

Here a patch for IrDA support on au1000 and au1100 CPUs in order to
work with linux 2.6.x.

I tested the software with an au1100 based board.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1000_irda.patch"

diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index d54156f..190138e 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -342,8 +342,8 @@ config TOSHIBA_FIR
 	  donauboe.
 
 config AU1000_FIR
-	tristate "Alchemy Au1000 SIR/FIR"
-	depends on MIPS_AU1000 && IRDA
+	tristate "Alchemy Au1000/Au1100 SIR/FIR"
+	depends on ( SOC_AU1000 || SOC_AU1100 ) && IRDA
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"
diff --git a/drivers/net/irda/au1k_ir.c b/drivers/net/irda/au1k_ir.c
index e6b1985..34071f3 100644
--- a/drivers/net/irda/au1k_ir.c
+++ b/drivers/net/irda/au1k_ir.c
@@ -5,6 +5,8 @@
  * Author: MontaVista Software, Inc.
  *         	ppopov@mvista.com or source@mvista.com
  *
+ * Driver ported to Linux 2.6.x by Rodolfo Giometti <giometti@linux.it>
+ *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
  *  published by the Free Software Foundation.
@@ -32,19 +34,13 @@
 
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/au1000.h>
-#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1100)
-#include <asm/pb1000.h>
-#elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
-#include <asm/db1x00.h>
-#else 
-#error au1k_ir: unsupported board
-#endif
 
 #include <net/irda/irda.h>
 #include <net/irda/irmod.h>
 #include <net/irda/wrapper.h>
 #include <net/irda/irda_device.h>
+
+#include <au1xxx.h>
 #include "au1000_ircc.h"
 
 static int au1k_irda_net_init(struct net_device *);
@@ -52,7 +48,7 @@ static int au1k_irda_start(struct net_de
 static int au1k_irda_stop(struct net_device *dev);
 static int au1k_irda_hard_xmit(struct sk_buff *, struct net_device *);
 static int au1k_irda_rx(struct net_device *);
-static void au1k_irda_interrupt(int, void *, struct pt_regs *);
+static irqreturn_t au1k_irda_interrupt(int, void *, struct pt_regs *);
 static void au1k_tx_timeout(struct net_device *);
 static struct net_device_stats *au1k_irda_stats(struct net_device *);
 static int au1k_irda_ioctl(struct net_device *, struct ifreq *, int);
@@ -78,12 +74,16 @@ static DEFINE_SPINLOCK(ir_lock);
  * IrDA peripheral bug. You have to read the register
  * twice to get the right value.
  */
-u32 read_ir_reg(u32 addr) 
+static inline u32 read_ir_reg(unsigned long addr) 
 { 
-	readl(addr);
-	return readl(addr);
+	au_readl(addr);
+	return au_readl(addr);
 }
 
+static inline void write_ir_reg(u32 data, unsigned long addr) 
+{ 
+	au_writel(data, addr);
+}
 
 /*
  * Buffer allocation/deallocation routines. The buffer descriptor returned
@@ -259,7 +259,7 @@ static int au1k_irda_net_init(struct net
 	/* attach a data buffer to each descriptor */
 	for (i=0; i<NUM_IR_DESC; i++) {
 		pDB = GetFreeDB(aup);
-		if (!pDB) goto out;
+		if (!pDB) goto out3;
 		aup->rx_ring[i]->addr_0 = (u8)(pDB->dma_addr & 0xff);
 		aup->rx_ring[i]->addr_1 = (u8)((pDB->dma_addr>>8) & 0xff);
 		aup->rx_ring[i]->addr_2 = (u8)((pDB->dma_addr>>16) & 0xff);
@@ -268,7 +268,7 @@ static int au1k_irda_net_init(struct net
 	}
 	for (i=0; i<NUM_IR_DESC; i++) {
 		pDB = GetFreeDB(aup);
-		if (!pDB) goto out;
+		if (!pDB) goto out4;
 		aup->tx_ring[i]->addr_0 = (u8)(pDB->dma_addr & 0xff);
 		aup->tx_ring[i]->addr_1 = (u8)((pDB->dma_addr>>8) & 0xff);
 		aup->tx_ring[i]->addr_2 = (u8)((pDB->dma_addr>>16) & 0xff);
@@ -288,6 +288,9 @@ static int au1k_irda_net_init(struct net
 
 	return 0;
 
+out4:
+	ReleaseDB(aup, pDB);
+
 out3:
 	dma_free((void *)aup->rx_ring[0],
 		2 * MAX_NUM_IR_DESC*(sizeof(ring_dest_t)));
@@ -320,22 +323,22 @@ static int au1k_init(struct net_device *
 		aup->rx_ring[i]->flags = AU_OWN;
 	}
 
-	writel(control, IR_INTERFACE_CONFIG);
+	write_ir_reg(control, IR_INTERFACE_CONFIG);
 	au_sync_delay(10);
 
-	writel(read_ir_reg(IR_ENABLE) & ~0x8000, IR_ENABLE); /* disable PHY */
+	write_ir_reg(read_ir_reg(IR_ENABLE) & ~0x8000, IR_ENABLE); /* disable PHY */
 	au_sync_delay(1);
 
-	writel(MAX_BUF_SIZE, IR_MAX_PKT_LEN);
+	write_ir_reg(MAX_BUF_SIZE, IR_MAX_PKT_LEN);
 
 	ring_address = (u32)virt_to_phys((void *)aup->rx_ring[0]);
-	writel(ring_address >> 26, IR_RING_BASE_ADDR_H);
-	writel((ring_address >> 10) & 0xffff, IR_RING_BASE_ADDR_L);
+	write_ir_reg(ring_address >> 26, IR_RING_BASE_ADDR_H);
+	write_ir_reg((ring_address >> 10) & 0xffff, IR_RING_BASE_ADDR_L);
 
-	writel(RING_SIZE_64<<8 | RING_SIZE_64<<12, IR_RING_SIZE);
+	write_ir_reg(RING_SIZE_64<<8 | RING_SIZE_64<<12, IR_RING_SIZE);
 
-	writel(1<<2 | IR_ONE_PIN, IR_CONFIG_2); /* 48MHz */
-	writel(0, IR_RING_ADDR_CMPR);
+	write_ir_reg(1<<2 | IR_ONE_PIN, IR_CONFIG_2); /* 48MHz */
+	write_ir_reg(0, IR_RING_ADDR_CMPR);
 
 	au1k_irda_set_speed(dev, 9600);
 	return 0;
@@ -352,13 +355,13 @@ static int au1k_irda_start(struct net_de
 		return retval;
 	}
 
-	if ((retval = request_irq(AU1000_IRDA_TX_INT, &au1k_irda_interrupt, 
+	if ((retval = request_irq(AU1000_IRDA_TX_INT, au1k_irda_interrupt, 
 					0, dev->name, dev))) {
 		printk(KERN_ERR "%s: unable to get IRQ %d\n", 
 				dev->name, dev->irq);
 		return retval;
 	}
-	if ((retval = request_irq(AU1000_IRDA_RX_INT, &au1k_irda_interrupt, 
+	if ((retval = request_irq(AU1000_IRDA_RX_INT, au1k_irda_interrupt, 
 					0, dev->name, dev))) {
 		free_irq(AU1000_IRDA_TX_INT, dev);
 		printk(KERN_ERR "%s: unable to get IRQ %d\n", 
@@ -371,7 +374,7 @@ static int au1k_irda_start(struct net_de
 	aup->irlap = irlap_open(dev, &aup->qos, hwname);
 	netif_start_queue(dev);
 
-	writel(read_ir_reg(IR_CONFIG_2) | 1<<8, IR_CONFIG_2); /* int enable */
+	write_ir_reg(read_ir_reg(IR_CONFIG_2) | 1<<8, IR_CONFIG_2); /* int enable */
 
 	aup->timer.expires = RUN_AT((3*HZ)); 
 	aup->timer.data = (unsigned long)dev;
@@ -383,9 +386,9 @@ static int au1k_irda_stop(struct net_dev
 	struct au1k_private *aup = netdev_priv(dev);
 
 	/* disable interrupts */
-	writel(read_ir_reg(IR_CONFIG_2) & ~(1<<8), IR_CONFIG_2);
-	writel(0, IR_CONFIG_1); 
-	writel(0, IR_INTERFACE_CONFIG); /* disable clock */
+	write_ir_reg(read_ir_reg(IR_CONFIG_2) & ~(1<<8), IR_CONFIG_2);
+	write_ir_reg(0, IR_CONFIG_1); 
+	write_ir_reg(0, IR_INTERFACE_CONFIG); /* disable clock */
 	au_sync();
 
 	if (aup->irlap) {
@@ -462,12 +465,12 @@ static void au1k_tx_ack(struct net_devic
 			aup->newspeed = 0;
 		}
 		else {
-			writel(read_ir_reg(IR_CONFIG_1) & ~IR_TX_ENABLE, 
+			write_ir_reg(read_ir_reg(IR_CONFIG_1) & ~IR_TX_ENABLE, 
 					IR_CONFIG_1); 
 			au_sync();
-			writel(read_ir_reg(IR_CONFIG_1) | IR_RX_ENABLE, 
+			write_ir_reg(read_ir_reg(IR_CONFIG_1) | IR_RX_ENABLE, 
 					IR_CONFIG_1); 
-			writel(0, IR_RING_PROMPT);
+			write_ir_reg(0, IR_RING_PROMPT);
 			au_sync();
 		}
 	}
@@ -543,8 +546,8 @@ static int au1k_irda_hard_xmit(struct sk
 	ptxd->flags |= AU_OWN;
 	au_sync();
 
-	writel(read_ir_reg(IR_CONFIG_1) | IR_TX_ENABLE, IR_CONFIG_1); 
-	writel(0, IR_RING_PROMPT);
+	write_ir_reg(read_ir_reg(IR_CONFIG_1) | IR_TX_ENABLE, IR_CONFIG_1); 
+	write_ir_reg(0, IR_RING_PROMPT);
 	au_sync();
 
 	dev_kfree_skb(skb);
@@ -615,7 +618,7 @@ static int au1k_irda_rx(struct net_devic
 		}
 		prxd->flags |= AU_OWN;
 		aup->rx_head = (aup->rx_head + 1) & (NUM_IR_DESC - 1);
-		writel(0, IR_RING_PROMPT);
+		write_ir_reg(0, IR_RING_PROMPT);
 		au_sync();
 
 		/* next descriptor */
@@ -628,19 +631,21 @@ static int au1k_irda_rx(struct net_devic
 }
 
 
-void au1k_irda_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t au1k_irda_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 
 	if (dev == NULL) {
 		printk(KERN_ERR "%s: isr: null dev ptr\n", dev->name);
-		return;
+		return IRQ_NONE;
 	}
 
-	writel(0, IR_INT_CLEAR); /* ack irda interrupts */
+	write_ir_reg(0, IR_INT_CLEAR); /* ack irda interrupts */
 
 	au1k_irda_rx(dev);
 	au1k_tx_ack(dev);
+
+	return IRQ_HANDLED;
 }
 
 
@@ -683,10 +688,10 @@ au1k_irda_set_speed(struct net_device *d
 	spin_lock_irqsave(&ir_lock, flags);
 
 	/* disable PHY first */
-	writel(read_ir_reg(IR_ENABLE) & ~0x8000, IR_ENABLE);
+	write_ir_reg(read_ir_reg(IR_ENABLE) & ~0x8000, IR_ENABLE);
 
 	/* disable RX/TX */
-	writel(read_ir_reg(IR_CONFIG_1) & ~(IR_RX_ENABLE|IR_TX_ENABLE), 
+	write_ir_reg(read_ir_reg(IR_CONFIG_1) & ~(IR_RX_ENABLE|IR_TX_ENABLE), 
 			IR_CONFIG_1);
 	au_sync_delay(1);
 	while (read_ir_reg(IR_ENABLE) & (IR_RX_STATUS | IR_TX_STATUS)) {
@@ -699,7 +704,7 @@ au1k_irda_set_speed(struct net_device *d
 	}
 
 	/* disable DMA */
-	writel(read_ir_reg(IR_CONFIG_1) & ~IR_DMA_ENABLE, IR_CONFIG_1);
+	write_ir_reg(read_ir_reg(IR_CONFIG_1) & ~IR_DMA_ENABLE, IR_CONFIG_1);
 	au_sync_delay(1);
 
 	/* 
@@ -724,42 +729,42 @@ au1k_irda_set_speed(struct net_device *d
 	if (speed == 4000000) {
 #if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
 		bcsr->resets |= BCSR_RESETS_FIR_SEL;
-#else /* Pb1000 and Pb1100 */
-		writel(1<<13, CPLD_AUX1);
+#elif defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1100)
+		write_ir_reg(1<<13, CPLD_AUX1);
 #endif
 	}
 	else {
 #if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
 		bcsr->resets &= ~BCSR_RESETS_FIR_SEL;
-#else /* Pb1000 and Pb1100 */
-		writel(readl(CPLD_AUX1) & ~(1<<13), CPLD_AUX1);
+#elif defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1100)
+		write_ir_reg(readl(CPLD_AUX1) & ~(1<<13), CPLD_AUX1);
 #endif
 	}
 
 	switch (speed) {
 	case 9600:	
-		writel(11<<10 | 12<<5, IR_WRITE_PHY_CONFIG); 
-		writel(IR_SIR_MODE, IR_CONFIG_1); 
+		write_ir_reg(11<<10 | 12<<5, IR_WRITE_PHY_CONFIG); 
+		write_ir_reg(IR_SIR_MODE, IR_CONFIG_1); 
 		break;
 	case 19200:	
-		writel(5<<10 | 12<<5, IR_WRITE_PHY_CONFIG); 
-		writel(IR_SIR_MODE, IR_CONFIG_1); 
+		write_ir_reg(5<<10 | 12<<5, IR_WRITE_PHY_CONFIG); 
+		write_ir_reg(IR_SIR_MODE, IR_CONFIG_1); 
 		break;
 	case 38400:
-		writel(2<<10 | 12<<5, IR_WRITE_PHY_CONFIG); 
-		writel(IR_SIR_MODE, IR_CONFIG_1); 
+		write_ir_reg(2<<10 | 12<<5, IR_WRITE_PHY_CONFIG); 
+		write_ir_reg(IR_SIR_MODE, IR_CONFIG_1); 
 		break;
 	case 57600:	
-		writel(1<<10 | 12<<5, IR_WRITE_PHY_CONFIG); 
-		writel(IR_SIR_MODE, IR_CONFIG_1); 
+		write_ir_reg(1<<10 | 12<<5, IR_WRITE_PHY_CONFIG); 
+		write_ir_reg(IR_SIR_MODE, IR_CONFIG_1); 
 		break;
 	case 115200: 
-		writel(12<<5, IR_WRITE_PHY_CONFIG); 
-		writel(IR_SIR_MODE, IR_CONFIG_1); 
+		write_ir_reg(12<<5, IR_WRITE_PHY_CONFIG); 
+		write_ir_reg(IR_SIR_MODE, IR_CONFIG_1); 
 		break;
 	case 4000000:
-		writel(0xF, IR_WRITE_PHY_CONFIG);
-		writel(IR_FIR|IR_DMA_ENABLE|IR_RX_ENABLE, IR_CONFIG_1); 
+		write_ir_reg(0xF, IR_WRITE_PHY_CONFIG);
+		write_ir_reg(IR_FIR|IR_DMA_ENABLE|IR_RX_ENABLE, IR_CONFIG_1); 
 		break;
 	default:
 		printk(KERN_ERR "%s unsupported speed %x\n", dev->name, speed);
@@ -768,11 +773,11 @@ au1k_irda_set_speed(struct net_device *d
 	}
 
 	aup->speed = speed;
-	writel(read_ir_reg(IR_ENABLE) | 0x8000, IR_ENABLE);
+	write_ir_reg(read_ir_reg(IR_ENABLE) | 0x8000, IR_ENABLE);
 	au_sync();
 
 	control = read_ir_reg(IR_ENABLE);
-	writel(0, IR_RING_PROMPT);
+	write_ir_reg(0, IR_RING_PROMPT);
 	au_sync();
 
 	if (control & (1<<14)) {

--5Mfx4RzfBqgnTE/w--
