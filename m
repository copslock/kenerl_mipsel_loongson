Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 15:52:51 +0100 (CET)
Received: from mail-gx0-f224.google.com ([209.85.217.224]:38168 "EHLO
        mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492276Ab0BYGdQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 07:33:16 +0100
Received: by gxk24 with SMTP id 24so3740116gxk.7
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2010 22:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Ru7pictMCi7unZR6UqzMQAsZUBEfDNzDfdDrAWex8vo=;
        b=LKn2iF0un8U2RFpZhQ2g9Yx/QN2Zya3elnXfKWcwbywrAZcnHZWfstsnvtt/sfo2qh
         ZnJLATj4oAx0DdArMNEV0Dn7zEe3hxIn4Z4qdzLHlYcdHfYscJxHf0zNchTLtvl5UXee
         bs7th9FdR5BZyy6+x1tOjvLSqicq8BSjmVSFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=aoiPc/zAFocjYbqgFeyyogjXD47koIxH5Un8eNoyCWAPfts8F9Yd/3v/WP9OzBXUXZ
         VwiDf9c5KUhUZM7HFJAW9Lb7dHqJhrNT7bAAZOH5qVwJsoXOjQBz2o+hTROHeMz9w6pB
         WMAm4BajMkY1Wh2sr4uIzMxAl4eCYo3ctlP/Y=
Received: by 10.151.58.8 with SMTP id l8mr988045ybk.59.1267079589080;
        Wed, 24 Feb 2010 22:33:09 -0800 (PST)
Received: from ?10.0.0.13? (eth7090.sa.adsl.internode.on.net [150.101.58.177])
        by mx.google.com with ESMTPS id 5sm1098321yxd.53.2010.02.24.22.33.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 22:33:07 -0800 (PST)
Message-ID: <4B86193D.2010307@gmail.com>
Date:   Thu, 25 Feb 2010 17:01:25 +1030
From:   Graham Gower <graham.gower@gmail.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090820)
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH 3/3] net: add driver for JZ4730 ethernet controller.
References: <4B861890.6090002@gmail.com>
In-Reply-To: <4B861890.6090002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <graham.gower@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26050
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graham.gower@gmail.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Graham Gower <graham.gower@gmail.com>
---
 drivers/net/Kconfig  |   10 +
 drivers/net/Makefile |    1 +
 drivers/net/jz_eth.c | 1232 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/jz_eth.h |  403 +++++++++++++++++
 4 files changed, 1646 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/jz_eth.c
 create mode 100644 drivers/net/jz_eth.h

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 7f8ad5d..7e8060a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1951,6 +1951,16 @@ config BCM63XX_ENET
 	  This driver supports the ethernet MACs in the Broadcom 63xx
 	  MIPS chipset family (BCM63XX).
 
+config JZ_ETH
+	tristate "JZ4730/JZ5730 On-Chip Ethernet support"
+	depends on XBURST_JZ4730
+	select MII
+	help
+	  This driver supports the JZ4730/JZ5730 On-Chip Ethernet interface.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called jz_eth.
+
 source "drivers/net/fs_enet/Kconfig"
 
 source "drivers/net/octeon/Kconfig"
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 657ccc3..da8ff86 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_FORCEDETH) += forcedeth.o
 obj-$(CONFIG_NE_H8300) += ne-h8300.o 8390.o
 obj-$(CONFIG_AX88796) += ax88796.o
 obj-$(CONFIG_BCM63XX_ENET) += bcm63xx_enet.o
+obj-$(CONFIG_JZ_ETH) += jz_eth.o
 
 obj-$(CONFIG_TSI108_ETH) += tsi108_eth.o
 obj-$(CONFIG_MV643XX_ETH) += mv643xx_eth.o
diff --git a/drivers/net/jz_eth.c b/drivers/net/jz_eth.c
new file mode 100644
index 0000000..624c081
--- /dev/null
+++ b/drivers/net/jz_eth.c
@@ -0,0 +1,1232 @@
+/*
+ *  Jz4730/Jz5730 On-Chip ethernet driver.
+ *
+ *  Copyright (C) 2009, 2010 Ubiq Technologies <graham.gower@gmail.com>
+ *  Copyright (C) 2005 - 2007  Ingenic Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <xburst.h>
+
+#include "jz_eth.h"
+
+#define DRV_NAME	"jz_eth"
+#define DRV_VERSION	"1.2"
+
+MODULE_AUTHOR("Peter Wei <jlwei@ingenic.cn>");
+MODULE_DESCRIPTION("JzSOC On-chip Ethernet driver");
+MODULE_LICENSE("GPL");
+
+static void __iomem *jz_eth_base;
+static char *hwaddr = NULL;
+static int debug = -1;
+static struct mii_if_info mii_info;
+
+MODULE_PARM_DESC(debug, "i");
+MODULE_PARM_DESC(hwaddr,"s");
+
+static irqreturn_t jz_eth_interrupt(int irq, void *dev_id);
+
+static int link_check_thread (void *data);
+
+static inline void
+ring_inv(jz_desc_t ring[], int ring_index)
+{
+	unsigned long addr = (unsigned long)&ring[ring_index];
+	dma_cache_inv(addr, sizeof(jz_desc_t));
+}
+
+static inline void
+ring_wback(jz_desc_t ring[], int ring_index)
+{
+	unsigned long addr = (unsigned long)&ring[ring_index];
+	dma_cache_wback(addr, sizeof(jz_desc_t));
+}
+
+static inline unsigned char str2hexnum(unsigned char c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	return 0; /* foo */
+}
+
+static inline void str2eaddr(unsigned char *ea, unsigned char *str)
+{
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		unsigned char num;
+
+		if((*str == '.') || (*str == ':'))
+			str++;
+		num = str2hexnum(*str++) << 4;
+		num |= (str2hexnum(*str++));
+		ea[i] = num;
+	}
+}
+
+static int ethaddr_cmd = 0;
+static unsigned char ethaddr_hex[6];
+
+static int __init ethernet_addr_setup(char *str)
+{
+	if (!str) {
+	        printk("ethaddr not set in command line\n");
+		return -1;
+	}
+	ethaddr_cmd = 1;
+	str2eaddr(ethaddr_hex, str);
+
+	return 0;
+}
+
+__setup("ethaddr=", ethernet_addr_setup);
+
+static int get_mac_address(struct net_device *dev)
+{
+	int i;
+	unsigned char flag0=0;
+	unsigned char flag1=0xff;
+	
+	dev->dev_addr[0] = 0xff;
+	if (hwaddr != NULL) {
+		/* insmod jz-ethc.o hwaddr=00:ef:a3:c1:00:10 */
+		str2eaddr(dev->dev_addr, hwaddr);
+	} else if (ethaddr_cmd) {
+		/* linux command line: ethaddr=00:ef:a3:c1:00:10 */
+		for (i=0; i<6; i++)
+			dev->dev_addr[i] = ethaddr_hex[i];
+	}
+
+	/* check whether valid MAC address */
+	for (i=0; i<6; i++) {
+		flag0 |= dev->dev_addr[i];
+		flag1 &= dev->dev_addr[i];
+	}
+	if ((dev->dev_addr[0] & 0xC0) || (flag0 == 0) || (flag1 == 0xff)) {
+		printk("WARNING: There is not MAC address, use default ..\n");
+		dev->dev_addr[0] = 0x00;
+		dev->dev_addr[1] = 0xef;
+		dev->dev_addr[2] = 0xa3;
+		dev->dev_addr[3] = 0xc1;
+		dev->dev_addr[4] = 0x00;
+		dev->dev_addr[5] = 0x10;
+		dev->dev_addr[5] = 0x03;
+	}
+	memcpy(dev->perm_addr, dev->dev_addr, ETH_ALEN);
+	if (!is_valid_ether_addr(dev->perm_addr))
+		printk(KERN_ERR "%s: ethaddr is b0rken!\n", dev->name);
+	return 0;
+}
+
+/*---------------------------------------------------------------------*/
+
+static u32 jz_eth_curr_mode(struct net_device *dev);
+
+/*
+ * Ethernet START/STOP routines
+ */
+#define START_ETH() \
+	do { \
+		s32 val; \
+		val = readl(jz_eth_base + DMA_OMR); \
+		val |= OMR_ST | OMR_SR; \
+		writel(val, jz_eth_base + DMA_OMR); \
+	} while(0)
+
+#define STOP_ETH() \
+	do { \
+		s32 val; \
+		val = readl(jz_eth_base + DMA_OMR); \
+		val &= ~(OMR_ST|OMR_SR); \
+		writel(val, jz_eth_base + DMA_OMR); \
+	} while(0)
+
+/*
+ * Link check routines
+ */
+static void start_check(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+
+	np->thread_die = 0;
+	init_waitqueue_head(&np->thr_wait);
+	init_completion (&np->thr_exited);
+
+	np->thread = kthread_run(link_check_thread,(void *)dev,
+			"%s-linkcheck", dev->name);
+	if (IS_ERR(np->thread))
+		printk(KERN_ERR "%s: unable to start kernel thread\n", dev->name);
+}
+
+static int close_check(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	int ret = 0;
+
+	if (np->thread != NULL) {
+		np->thread_die = 1;
+		wmb();
+		ret = send_sig(SIGTERM, np->thread, 1);
+		if (ret) {
+			printk(KERN_ERR "%s: unable to signal thread\n", dev->name);
+			return 1;
+		}
+		wait_for_completion (&np->thr_exited);
+	}
+	return 0;
+}
+
+static int link_check_thread(void *data)
+{
+	struct net_device *dev=(struct net_device *)data;
+	struct jz_eth_private *np = netdev_priv(dev);
+	unsigned char current_link;
+	unsigned long timeout;
+
+	while (1) {
+		timeout = 3*HZ;
+		do {
+			timeout = interruptible_sleep_on_timeout (&np->thr_wait, timeout);
+			/* make swsusp happy with our thread */
+//			if (current->flags & PF_FREEZE)
+//				refrigerator(PF_FREEZE);
+		} while (!signal_pending (current) && (timeout > 0));
+
+		if (signal_pending (current)) {
+			spin_lock_irq(&current->sighand->siglock);
+			flush_signals(current);
+			spin_unlock_irq(&current->sighand->siglock);
+		}
+
+		if (np->thread_die)
+			break;
+		
+		current_link=mii_link_ok(&mii_info);
+		if (np->link_state!=current_link) {
+			if (current_link) {
+				printk(KERN_INFO "%s: Ethernet Link OK!\n",dev->name);
+				jz_eth_curr_mode(dev);
+				netif_carrier_on(dev);
+			}
+			else {
+				printk(KERN_WARNING "%s: Ethernet Link offline!\n",dev->name);
+				netif_carrier_off(dev);
+			}
+		}
+		np->link_state=current_link;
+
+	}
+	complete_and_exit (&np->thr_exited, 0);	
+}
+
+
+/*
+ * Reset ethernet device
+ */
+static inline void jz_eth_reset(void)
+{				
+	u32 i;					
+	i = readl(jz_eth_base + DMA_BMR);
+	writel(i | BMR_SWR, jz_eth_base + DMA_BMR);			
+	for(i = 0; i < 1000; i++) {			
+		if(!(readl(jz_eth_base + DMA_BMR) & BMR_SWR)) break;	
+		mdelay(1);			
+	}						
+}
+
+/*
+ * MII operation routines 
+ */
+static inline void mii_wait(void)
+{
+	int i;
+	for(i = 0; i < 10000; i++) {
+		if(!(readl(jz_eth_base + MAC_MIIA) & 0x1)) 
+			break;
+		mdelay(1);
+	}
+	if (i >= 10000)
+		printk("MII wait timeout : %d.\n", i);
+}
+
+static int mdio_read(struct net_device *dev,int phy_id, int location)
+{
+	u32 mii_cmd = (phy_id << 11) | (location << 6) | 1;
+	int retval = 0;
+	
+	writel(mii_cmd, jz_eth_base + MAC_MIIA);
+	mii_wait();
+	retval = readl(jz_eth_base + MAC_MIID) & 0x0000ffff;
+
+	return retval;
+	
+}
+
+static void mdio_write(struct net_device *dev,int phy_id, int location, int data)
+{
+	u32 mii_cmd = (phy_id << 11) | (location << 6) | 0x2 /*| 1*/;
+
+	writel(mii_cmd, jz_eth_base + MAC_MIIA);
+	writel(data & 0x0000ffff, jz_eth_base + MAC_MIID);
+	mii_cmd = (phy_id << 11) | (location << 6) | 0x2 | 1;
+	writel(mii_cmd, jz_eth_base + MAC_MIIA);
+	mii_wait();
+}
+
+
+/*
+ * Search MII phy
+ */
+static int jz_search_mii_phy(struct net_device *dev)
+{
+	
+	struct jz_eth_private *np = netdev_priv(dev);
+	int phy, phy_idx = 0;
+
+	np->valid_phy = 0xff;
+	for (phy = 0; phy < 32; phy++) {
+		int mii_status = mdio_read(dev,phy, 1);
+		if (mii_status != 0xffff  &&  mii_status != 0x0000) {
+			np->phys[phy_idx] = phy;
+			np->ecmds[phy_idx].speed=SPEED_100;
+			np->ecmds[phy_idx].duplex=DUPLEX_FULL;
+			np->ecmds[phy_idx].port=PORT_MII;
+			np->ecmds[phy_idx].transceiver=XCVR_INTERNAL;
+			np->ecmds[phy_idx].phy_address=np->phys[phy_idx];
+			np->ecmds[phy_idx].autoneg=AUTONEG_ENABLE;
+			np->ecmds[phy_idx].advertising=(ADVERTISED_10baseT_Half |
+							ADVERTISED_10baseT_Full |
+							ADVERTISED_100baseT_Half |
+							ADVERTISED_100baseT_Full);
+			phy_idx++;
+			break;
+		}
+	}
+	if (phy_idx == 1) {
+		np->valid_phy = np->phys[0];
+		np->phy_type = 0;
+	}
+	if (phy_idx != 0) {
+		phy = np->valid_phy;
+		np->advertising = mdio_read(dev,phy, 4);
+	}
+	return phy_idx;
+}
+
+/*
+ * CRC calc for Destination Address for gets hashtable index
+ */
+
+#define POLYNOMIAL 0x04c11db7UL
+static u16 jz_hashtable_index(u8 *addr)
+{
+	u32 crc = 0xffffffff, msb;
+	int  i, j;
+	u32  byte;
+	for (i = 0; i < 6; i++) {
+		byte = *addr++;
+		for (j = 0; j < 8; j++) {
+			msb = crc >> 31;
+			crc <<= 1;
+			if (msb ^ (byte & 1)) crc ^= POLYNOMIAL;
+			byte >>= 1;
+		}
+	}
+	return ((int)(crc >> 26));
+}
+
+/*
+ * Multicast filter and config multicast hash table
+ */
+#define MULTICAST_FILTER_LIMIT 64
+
+static void jz_set_multicast_list(struct net_device *dev)
+{
+	int i, hash_index;
+	u32 mcr, hash_h, hash_l, hash_bit;
+	
+	mcr = readl(jz_eth_base + MAC_MCR);
+	mcr &= ~(MCR_PR | MCR_PM | MCR_HP);
+	
+	if (dev->flags & IFF_PROMISC) {
+		/* Accept any kinds of packets */
+		mcr |= MCR_PR;
+		hash_h = 0xffffffff;
+		hash_l = 0xffffffff;
+	}
+	else  if ((dev->flags & IFF_ALLMULTI) || (dev->mc_count > MULTICAST_FILTER_LIMIT)){
+		/* Accept all multicast packets */
+		mcr |= MCR_PM;
+		hash_h = 0xffffffff;
+		hash_l = 0xffffffff;
+	}
+	else if (dev->flags & IFF_MULTICAST)
+	{
+		/* Update multicast hash table */
+		struct dev_mc_list *mclist;
+		hash_h = readl(jz_eth_base + MAC_HTH);
+		hash_l = readl(jz_eth_base + MAC_HTL);
+		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
+		     i++, mclist = mclist->next)
+		{
+			hash_index = jz_hashtable_index(mclist->dmi_addr);
+			hash_bit=0x00000001;
+			hash_bit <<= (hash_index & 0x1f);
+			if (hash_index > 0x1f) 
+				hash_h |= hash_bit;
+			else
+				hash_l |= hash_bit;
+		}
+		writel(hash_h, jz_eth_base + MAC_HTH);
+		writel(hash_l, jz_eth_base + MAC_HTL);
+		mcr |= MCR_HP;
+	}
+	writel(mcr, jz_eth_base + MAC_MCR);
+}
+
+static inline int jz_phy_reset(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	unsigned int mii_reg0;
+	int i;
+
+	mii_reg0 = mdio_read(dev,np->valid_phy,MII_BMCR);
+	mii_reg0 |= MII_CR_RST;
+	mdio_write(dev, np->valid_phy, MII_BMCR, mii_reg0);
+
+	for (i=0; i<1000; i++) {
+		mdelay(1);
+		mii_reg0 = mdio_read(dev, np->valid_phy, MII_BMCR);
+		if (!(mii_reg0 & MII_CR_RST))
+			break;
+	}
+
+	if (i >= 1000)
+		/* phy error */
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Start Auto-Negotiation function for PHY 
+ */
+static int jz_autonet_complete(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	int i;
+	u32 mii_reg1, timeout = 3000;
+
+	for (i=0; i<timeout; i++) {
+		mdelay(1);
+		mii_reg1 = mdio_read(dev, np->valid_phy, MII_BMSR);
+		if (mii_reg1 & MII_SR_ASSC)
+			break;
+	}
+
+	if (i >= timeout)
+		/* auto negotiation error */
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Get current mode of eth phy
+ */
+static u32 jz_eth_curr_mode(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	unsigned int mii_reg17;
+	u32 flag = 0;
+
+	mii_reg17 = mdio_read(dev,np->valid_phy,MII_DSCSR); 
+	np->media = mii_reg17>>12;
+	if (np->media==8) {
+		printk(KERN_INFO "%s: Current Mode is [100M Full Duplex]",dev->name);
+		flag = 0;
+		np->full_duplex=1;
+	}
+	if (np->media==4) {
+		printk(KERN_INFO "%s: Current Mode is [100M Half Duplex]",dev->name);
+		flag = 0;
+		np->full_duplex=0;
+	}
+	if (np->media==2) {
+		printk(KERN_INFO "%s: Current Mode is [10M Full Duplex]",dev->name);
+		flag = OMR_TTM;
+		np->full_duplex=1;
+	}
+	if (np->media==1) {
+		printk(KERN_INFO "%s: Current Mode is [10M Half Duplex]",dev->name);
+		flag = OMR_TTM;
+		np->full_duplex=0;
+	}
+	printk("\n");
+	return flag;
+}
+
+/*
+ * Ethernet device hardware init
+ * This routine initializes the ethernet device hardware and PHY
+ */
+static int jz_init_hw(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	struct ethtool_cmd ecmd;
+	u32 mcr, omr;
+	u32 sts, flag = 0;
+	int i;
+
+	jz_eth_reset();
+	STOP_ETH();
+
+	/* Set MAC address */
+	writel(le32_to_cpu(*(unsigned long *)&dev->dev_addr[0]),
+			jz_eth_base + MAC_MAL);
+	writel(le32_to_cpu(*(unsigned long *)&dev->dev_addr[4]),
+			jz_eth_base + MAC_MAH);
+	printk("%s: JZ On-Chip ethernet (MAC ", dev->name);
+	for (i = 0; i < 5; i++) {
+		printk("%2.2x:", dev->dev_addr[i]);
+	}
+	printk("%2.2x, IRQ %d)\n", dev->dev_addr[i], dev->irq);
+
+	if ((np->mii_phy_cnt = jz_search_mii_phy(dev)) == 0) {
+		printk("%s: PHY not found, bailing.\n", dev->name);
+		return -ENXIO;
+	}
+
+	printk("%s: Found %d PHY on JZ MAC\n", dev->name, np->mii_phy_cnt);
+
+	mii_info.phy_id = np->valid_phy;
+	mii_info.dev = dev;
+	mii_info.mdio_read = &mdio_read;
+	mii_info.mdio_write = &mdio_write;
+
+	ecmd.speed = SPEED_100;
+	ecmd.duplex = DUPLEX_FULL;
+	ecmd.port = PORT_MII;
+	ecmd.transceiver = XCVR_INTERNAL;
+	ecmd.phy_address = np->valid_phy;
+	ecmd.autoneg = AUTONEG_ENABLE;
+	ecmd.advertising = ADVERTISED_10baseT_Half
+				| ADVERTISED_10baseT_Full
+				| ADVERTISED_100baseT_Half
+				| ADVERTISED_100baseT_Full;
+
+	mii_ethtool_sset(&mii_info,&ecmd);
+
+	if (jz_autonet_complete(dev)) 
+		printk(KERN_WARNING "%s: Ethernet Module AutoNegotiation failed\n",dev->name);
+	mii_ethtool_gset(&mii_info,&ecmd);
+
+	printk(KERN_INFO "%s: Provide Modes: ",dev->name);
+	for (i = 0; i < 5;i++) 
+		if (ecmd.advertising & (1<<i))
+			printk("(%d)%s", i+1, media_types[i]);
+	printk("\n");  
+
+	flag = jz_eth_curr_mode(dev);
+
+	/* Config OMR register */
+	omr = readl(jz_eth_base + DMA_OMR) & ~OMR_TTM;
+	omr |= flag;
+	//omr |= OMR_OSF;
+	omr |= OMR_SF;
+	writel(omr, jz_eth_base + DMA_OMR);
+
+	readl(jz_eth_base + DMA_MFC); //through read operation to clear the register for 0x0000000
+
+	/* Set the programmable burst length (value 1 or 4 is validate)*/
+#if 0 /* __BIG_ENDIAN__ */
+	writel(PBL_4 | DSL_0 | 0x100080, jz_eth_base + DMA_BMR);  /* DSL_0: see DESC_SKIP_LEN and DESC_ALIGN */
+#else /* __LITTLE_ENDIAN__ */
+	writel(PBL_4 | DSL_0, jz_eth_base + DMA_BMR);  /* DSL_0: see DESC_SKIP_LEN and DESC_ALIGN */
+#endif
+
+	/* Config MCR register*/
+	mcr = (readl(jz_eth_base + MAC_MCR) & ~(MCR_PS | MCR_HBD | MCR_FDX));   
+	if(np->full_duplex)
+		mcr |= MCR_FDX;
+	mcr |= MCR_BFD | MCR_TE | MCR_RE | MCR_OWD|MCR_HBD;
+	writel(mcr, jz_eth_base + MAC_MCR);
+
+	/* Set base address of TX and RX descriptors */
+	writel(np->dma_rx_ring, jz_eth_base + DMA_RRBA);
+	writel(np->dma_tx_ring, jz_eth_base + DMA_TRBA);
+
+	START_ETH();
+
+	/* set interrupt mask */
+	writel(IMR_DEFAULT | IMR_ENABLE, jz_eth_base + DMA_IMR);
+
+	/* Reset any pending (stale) interrupts */
+	sts = readl(jz_eth_base + DMA_STS);
+	writel(sts, jz_eth_base + DMA_STS);
+
+	return 0;
+}
+
+static void jz_eth_ring_init(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < NUM_RX_DESCS; i++) {
+		np->rx_ring[i].status = cpu_to_le32(R_OWN);
+		np->rx_ring[i].desc1 = cpu_to_le32(RX_BUF_SIZE | RD_RCH);
+		np->rx_ring[i].buf1_addr = cpu_to_le32(np->dma_rx_buf + i*RX_BUF_SIZE);
+		np->rx_ring[i].next_addr = cpu_to_le32(np->dma_rx_ring + (i+1) * sizeof (jz_desc_t));
+	}
+	np->rx_ring[NUM_RX_DESCS - 1].next_addr = cpu_to_le32(np->dma_rx_ring);
+
+	for (i = 0; i < NUM_TX_DESCS; i++) {
+		np->tx_ring[i].status = cpu_to_le32(0);
+		np->tx_ring[i].desc1  = cpu_to_le32(TD_TCH);
+		np->tx_ring[i].buf1_addr = 0;
+		np->tx_ring[i].next_addr = cpu_to_le32(np->dma_tx_ring + (i+1) * sizeof (jz_desc_t));
+	}
+	np->tx_ring[NUM_TX_DESCS - 1].next_addr = cpu_to_le32(np->dma_tx_ring);
+
+	np->rx_head = 0;
+	np->tx_head = np->tx_tail = 0;
+
+	dma_cache_wback((unsigned long)np->rx_ring, sizeof(jz_desc_t)*NUM_RX_DESCS);
+	dma_cache_wback((unsigned long)np->tx_ring, sizeof(jz_desc_t)*NUM_TX_DESCS);
+}
+
+static int jz_eth_open(struct net_device *dev)
+{
+	int retval;
+
+	jz_eth_ring_init(dev);
+
+	if ((retval = jz_init_hw(dev)) != 0)
+		return retval;
+
+	retval = request_irq(dev->irq, jz_eth_interrupt, 0, dev->name, dev);
+	if (retval) {
+		printk(KERN_WARNING "%s: unable to get IRQ %d .\n", dev->name, dev->irq);
+		return -EAGAIN;
+	}
+
+	dev->trans_start = jiffies;
+	netif_start_queue(dev);
+	start_check(dev);
+
+	return 0;
+}
+
+static int jz_eth_close(struct net_device *dev)
+{
+	netif_stop_queue(dev);
+	close_check(dev);
+	STOP_ETH();
+	free_irq(dev->irq, dev);
+	return 0;
+}
+
+/*
+ * Get the current statistics.
+ * This may be called with the device open or closed.
+ */
+static struct net_device_stats * jz_eth_get_stats(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	int tmp;
+
+	tmp = readl(jz_eth_base + DMA_MFC); // After read clear to zero
+	np->stats.rx_missed_errors += (tmp & MFC_CNT2) + ((tmp & MFC_CNT1) >> 16);
+
+	return &np->stats;
+}
+
+/*
+ * ethtool routines
+ */
+static int jz_ethtool_ioctl(struct net_device *dev, void *useraddr)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	u32 ethcmd;
+
+	/* dev_ioctl() in ../../net/core/dev.c has already checked
+	   capable(CAP_NET_ADMIN), so don't bother with that here.  */
+
+	if (get_user(ethcmd, (u32 *)useraddr))
+		return -EFAULT;
+
+	switch (ethcmd) {
+
+	case ETHTOOL_GDRVINFO: {
+		struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
+		strcpy (info.driver, DRV_NAME);
+		strcpy (info.version, DRV_VERSION);
+		strcpy (info.bus_info, "OCS");
+		if (copy_to_user (useraddr, &info, sizeof (info)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* get settings */
+	case ETHTOOL_GSET: {
+		struct ethtool_cmd ecmd = { ETHTOOL_GSET };
+		spin_lock_irq(&np->lock);
+		mii_ethtool_gset(&mii_info, &ecmd);
+		spin_unlock_irq(&np->lock);
+		if (copy_to_user(useraddr, &ecmd, sizeof(ecmd)))
+			return -EFAULT;
+		return 0;
+	}
+	/* set settings */
+	case ETHTOOL_SSET: {
+		int r;
+		struct ethtool_cmd ecmd;
+		if (copy_from_user(&ecmd, useraddr, sizeof(ecmd)))
+			return -EFAULT;
+		spin_lock_irq(&np->lock);
+		r = mii_ethtool_sset(&mii_info, &ecmd);
+		spin_unlock_irq(&np->lock);
+		return r;
+	}
+	/* restart autonegotiation */
+	case ETHTOOL_NWAY_RST: {
+		return mii_nway_restart(&mii_info);
+	}
+	/* get link status */
+	case ETHTOOL_GLINK: {
+		struct ethtool_value edata = {ETHTOOL_GLINK};
+		edata.data = mii_link_ok(&mii_info);
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* get message-level */
+	case ETHTOOL_GMSGLVL: {
+		struct ethtool_value edata = {ETHTOOL_GMSGLVL};
+		edata.data = debug;
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+	/* set message-level */
+	case ETHTOOL_SMSGLVL: {
+		struct ethtool_value edata;
+		if (copy_from_user(&edata, useraddr, sizeof(edata)))
+			return -EFAULT;
+		debug = edata.data;
+		return 0;
+	}
+
+
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+
+}
+
+/*
+ * Config device
+ */
+static int jz_eth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	struct mii_ioctl_data *data, rdata;
+
+	switch (cmd) {
+	case SIOCETHTOOL:
+		return jz_ethtool_ioctl(dev, (void *) rq->ifr_data);
+	case SIOCGMIIPHY:
+	case SIOCDEVPRIVATE:
+		data = (struct mii_ioctl_data *)&rq->ifr_data;
+		data->phy_id = np->valid_phy;
+	case SIOCGMIIREG:
+	case SIOCDEVPRIVATE+1:
+		data = (struct mii_ioctl_data *)&rq->ifr_data;
+		data->val_out = mdio_read(dev,np->valid_phy, data->reg_num & 0x1f);
+		return 0;
+	case SIOCSMIIREG:
+	case SIOCDEVPRIVATE+2:
+		data = (struct mii_ioctl_data *)&rq->ifr_data;
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		mdio_write(dev,np->valid_phy, data->reg_num & 0x1f, data->val_in);
+		return 0;
+	case READ_COMMAND:	
+		data = (struct mii_ioctl_data *)rq->ifr_data;
+		if (copy_from_user(&rdata,data,sizeof(rdata)))
+			return -EFAULT;
+		rdata.val_out = mdio_read(dev,rdata.phy_id, rdata.reg_num & 0x1f);
+		if (copy_to_user(data,&rdata,sizeof(rdata)))
+			return -EFAULT;
+		return 0;
+	case WRITE_COMMAND:
+		if (np->phy_type==1) {
+			data = (struct mii_ioctl_data *)rq->ifr_data;
+			if (!capable(CAP_NET_ADMIN))
+				return -EPERM;
+			if (copy_from_user(&rdata,data,sizeof(rdata)))
+				return -EFAULT;
+			mdio_write(dev,rdata.phy_id, rdata.reg_num & 0x1f, rdata.val_in);
+		}
+		return 0;
+	case GETDRIVERINFO:
+		if (np->phy_type==1) {
+			data = (struct mii_ioctl_data *)rq->ifr_data;
+			if (copy_from_user(&rdata,data,sizeof(rdata)))
+				return -EFAULT;
+			rdata.val_in = 0x1;
+			rdata.val_out = 0x00d0;
+			if (copy_to_user(data,&rdata,sizeof(rdata)))
+				return -EFAULT;
+		}
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+/*
+ * Received one packet
+ */
+static void eth_rxready(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	struct sk_buff *skb;
+	unsigned char *pkt_ptr;
+	u32 pkt_len;
+	u32 status;
+
+	ring_inv(np->rx_ring, np->rx_head);
+	status = le32_to_cpu(np->rx_ring[np->rx_head].status);
+	while (!(status & R_OWN)) {               /* owner bit = 0 */
+		if (status & RD_ES) {              /* error summary */
+			np->stats.rx_errors++;    /* Update the error stats. */
+			if (status & (RD_RF | RD_TL))
+				np->stats.rx_frame_errors++;
+			if (status & RD_CE)
+				np->stats.rx_crc_errors++;
+			if (status & RD_TL)
+				np->stats.rx_length_errors++;
+		} else {
+			pkt_ptr = bus_to_virt(le32_to_cpu(np->rx_ring[np->rx_head].buf1_addr));
+			pkt_len = ((status & RD_FL) >> 16) - 4;
+
+			skb = dev_alloc_skb(pkt_len + 2);
+			if (skb == NULL) {
+				printk("%s: Memory squeeze, dropping.\n",
+				       dev->name);
+				np->stats.rx_dropped++;
+				break;
+			}
+			skb->dev = dev;
+			skb_reserve(skb, 2); /* 16 byte align */
+
+			memcpy(skb->data, pkt_ptr, pkt_len);
+			skb_put(skb, pkt_len);
+
+			skb->protocol = eth_type_trans(skb,dev);
+			netif_rx(skb);	/* pass the packet to upper layers */
+			dev->last_rx = jiffies;
+			np->stats.rx_packets++;
+			np->stats.rx_bytes += pkt_len;
+		}
+		np->rx_ring[np->rx_head].status = cpu_to_le32(R_OWN);
+
+		np->rx_head ++;
+		if (np->rx_head >= NUM_RX_DESCS)
+			np->rx_head = 0;
+		ring_inv(np->rx_ring, np->rx_head);
+		status = le32_to_cpu(np->rx_ring[np->rx_head].status);
+	}
+}
+
+/*
+ * Tx timeout routine 
+ */
+static void jz_eth_tx_timeout(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+
+	jz_init_hw(dev);
+	np->stats.tx_errors ++;
+	netif_wake_queue(dev);
+}
+
+/*
+ * One packet was transmitted
+ */
+static void eth_txdone(struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	int tx_tail = np->tx_tail;
+	int entry;
+	u32 status;
+
+	while (tx_tail != np->tx_head) {
+		entry = tx_tail % NUM_TX_DESCS;
+		ring_inv(np->tx_ring, entry);
+		status = le32_to_cpu(np->tx_ring[entry].status);
+		if (status & T_OWN)
+			break;
+		if (status & TD_ES ) {       /* Error summary */
+			np->stats.tx_errors++;
+			if (status & TD_NC) np->stats.tx_carrier_errors++;
+			if (status & TD_LC) np->stats.tx_window_errors++;
+			if (status & TD_UF) np->stats.tx_fifo_errors++;
+			if (status & TD_DE) np->stats.tx_aborted_errors++;
+			if (np->tx_head != np->tx_tail)
+				writel(1, jz_eth_base + DMA_TPD);  /* Restart a stalled TX */
+		} else
+			np->stats.tx_packets++;
+		/* Update the collision counter */
+		np->stats.collisions += ((status & TD_EC) ? 16 : ((status & TD_CC) >> 3));
+		/* Free the original skb */
+		if (np->tx_skb[entry]) {
+			dev_kfree_skb_irq(np->tx_skb[entry]);
+			np->tx_skb[entry] = 0;
+		}
+		tx_tail++;
+	}
+	if (np->tx_full && (tx_tail + NUM_TX_DESCS > np->tx_head + 1)) {
+		/* The ring is no longer full */
+		np->tx_full = 0;
+		netif_wake_queue(dev);
+	}
+	np->tx_tail = tx_tail;
+}
+
+/*
+ * Update the tx descriptor
+ */
+static void load_tx_packet(struct net_device *dev, char *buf, u32 flags, struct sk_buff *skb)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	int entry = np->tx_head % NUM_TX_DESCS;
+
+	np->tx_ring[entry].buf1_addr = cpu_to_le32(virt_to_bus(buf));
+	np->tx_ring[entry].desc1 &= cpu_to_le32((TD_TER | TD_TCH));
+	np->tx_ring[entry].desc1 |= cpu_to_le32(flags);
+	np->tx_ring[entry].status = cpu_to_le32(T_OWN);
+	np->tx_skb[entry] = skb;
+
+	ring_wback(np->tx_ring, entry);
+}
+
+/*
+ * Transmit one packet
+ */
+static int jz_eth_send_packet(struct sk_buff *skb, struct net_device *dev)
+{
+	struct jz_eth_private *np = netdev_priv(dev);
+	u32 length;
+
+	if (np->tx_full) {
+		return 0;
+	}
+
+	length = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len;
+	dma_cache_wback((unsigned long)skb->data, length);
+	load_tx_packet(dev, (char *)skb->data,
+			TD_IC | TD_LS | TD_FS | (length & TD_TBS1), skb);
+
+	spin_lock_irq(&np->lock);
+	np->tx_head ++;
+	np->stats.tx_bytes += length;
+	writel(1, jz_eth_base + DMA_TPD);		/* Start the TX */
+
+	dev->trans_start = jiffies;	/* for timeout */
+	if (np->tx_tail + NUM_TX_DESCS > np->tx_head + 1) {
+		np->tx_full = 0;
+	}
+	else {
+		np->tx_full = 1;
+		netif_stop_queue(dev);
+	}
+	spin_unlock_irq(&np->lock);
+
+	return 0;
+}
+
+/*
+ * Interrupt service routine
+ */
+static irqreturn_t jz_eth_interrupt(int irq, void *dev_id)
+{
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct jz_eth_private *np = netdev_priv(dev);
+	u32 sts;
+	int i;
+
+	spin_lock(&np->lock);
+
+	writel((readl(jz_eth_base + DMA_IMR) & ~IMR_ENABLE),
+			jz_eth_base + DMA_IMR);
+
+	for (i = 0; i < 100; i++) {
+		/* clear status */
+		sts = readl(jz_eth_base + DMA_STS);
+		writel(sts, jz_eth_base + DMA_STS);
+
+		if (!(sts & IMR_DEFAULT))
+			break;
+
+		if (sts & (DMA_INT_RI | DMA_INT_RU))
+			/* Rx IRQ */
+			eth_rxready(dev);
+		if (sts & (DMA_INT_TI | DMA_INT_TU)) {
+			/* Tx IRQ */
+			eth_txdone(dev);
+		}
+
+		/* check error conditions */
+		if (sts & DMA_INT_FB){
+			STOP_ETH();
+			printk(KERN_ERR "%s: Fatal bus error occurred, sts=%#8x, "
+					"device stopped.\n",dev->name, sts);
+			break;
+		}
+
+		/* Transmit underrun */
+		if (sts & DMA_INT_UN) {
+			u32 omr;
+			omr = readl(jz_eth_base + DMA_OMR);
+			if (!(omr & OMR_SF)) {
+				omr &= ~(OMR_ST | OMR_SR);
+				writel(omr, jz_eth_base + DMA_OMR);
+
+				/* wait for stop */
+				while (readl(jz_eth_base + DMA_STS) & STS_TS)
+					;
+
+				/* increase transmit threshold if possible */
+				if ((omr & OMR_TR) < OMR_TR) {
+					omr += TR_24;
+				} else {
+					omr |= OMR_SF;
+				}
+				writel(omr | OMR_ST | OMR_SR,
+						jz_eth_base + DMA_OMR);
+			}
+		}
+	}
+
+	writel(readl(jz_eth_base + DMA_IMR)|IMR_ENABLE, jz_eth_base + DMA_IMR);
+
+	spin_unlock(&np->lock);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PM
+/*
+ * Suspend the ETH interface.
+ */
+static int jz_eth_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct jz_eth_private *jep = netdev_priv(dev);
+	unsigned long flags, tmp;
+
+	if (!netif_running(dev))
+		return 0;
+
+	netif_device_detach(dev);
+
+	spin_lock_irqsave(&jep->lock, flags);
+
+	/* Disable interrupts, stop Tx and Rx. */
+	writel(0, jz_eth_base + DMA_IMR);
+	STOP_ETH();
+
+	/* Update the error counts. */
+	tmp = readl(jz_eth_base + DMA_MFC);
+	jep->stats.rx_missed_errors += (tmp & 0x1ffff);
+	jep->stats.rx_fifo_errors += ((tmp >> 17) & 0x7ff);
+
+	spin_unlock_irqrestore(&jep->lock, flags);
+
+	return 0;
+}
+
+/*
+ * Resume the ETH interface.
+ */
+static int jz_eth_resume(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+
+	if (!netif_running(dev))
+		return 0;
+
+	jz_eth_ring_init(dev);
+	jz_init_hw(dev);
+
+	netif_device_attach(dev);
+	netif_wake_queue(dev);
+
+	return 0;
+}
+#else
+#define jz_eth_suspend NULL
+#define jz_eth_resume NULL
+#endif /* CONFIG_PM */
+
+static const struct net_device_ops jz_netdev_ops = {
+	.ndo_open = jz_eth_open,
+	.ndo_stop = jz_eth_close,
+	.ndo_start_xmit = jz_eth_send_packet,
+	.ndo_set_multicast_list = jz_set_multicast_list,
+	.ndo_tx_timeout = jz_eth_tx_timeout,
+	.ndo_get_stats = jz_eth_get_stats,
+	.ndo_do_ioctl = jz_eth_ioctl,
+};
+
+static int jz_eth_probe(struct platform_device *pdev)
+{
+	struct net_device *dev;
+	struct jz_eth_private *np;
+	int ret;
+
+	dev = alloc_etherdev(sizeof(struct jz_eth_private));
+	if (!dev) {
+		printk(KERN_ERR "%s: alloc_etherdev failed\n", DRV_NAME);
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	np = netdev_priv(dev);
+	memset(np, 0, sizeof(struct jz_eth_private));
+
+	np->vaddr_rx_buf = (u32)dma_alloc_noncoherent(NULL,
+					NUM_RX_DESCS*RX_BUF_SIZE,
+					&np->dma_rx_buf, 0);
+
+	if (!np->vaddr_rx_buf) {
+		printk(KERN_ERR "%s: Cannot alloc dma buffers\n", DRV_NAME);
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	np->dma_rx_ring = virt_to_bus(np->rx_ring);
+	np->dma_tx_ring = virt_to_bus(np->tx_ring);
+	np->full_duplex = 1;
+	np->link_state = 1;
+
+	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq < 0) {
+		ret = -ENXIO;
+		goto err2;
+	}
+
+	np->iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!np->iores) {
+		ret = -ENXIO;
+		goto err2;
+	}
+
+	np->iores = request_mem_region(np->iores->start,
+			resource_size(np->iores), pdev->name);
+	if (!np->iores) {
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	jz_eth_base = ioremap_nocache(np->iores->start,
+			resource_size(np->iores));
+	if (!jz_eth_base) {
+		ret = -EBUSY;
+		goto err3;
+	}
+
+	spin_lock_init(&np->lock);
+
+	dev->netdev_ops = &jz_netdev_ops;
+	dev->watchdog_timeo = ETH_TX_TIMEOUT;
+
+	/* configure MAC address */
+	get_mac_address(dev);
+
+	platform_set_drvdata(pdev, dev);
+
+	if ((ret = register_netdev(dev)) != 0) {
+		printk(KERN_ERR "%s: Cannot register net device, error %d\n",
+				DRV_NAME, ret);
+		goto err4;
+	}
+
+	return 0;
+
+err4:
+	iounmap(jz_eth_base);
+err3:
+	release_mem_region(np->iores->start, 0x10000);
+err2:
+	dma_free_noncoherent(NULL, NUM_RX_DESCS * RX_BUF_SIZE,
+			     (void *)np->vaddr_rx_buf, np->dma_rx_buf);
+err1:
+	free_netdev(dev);
+err0:
+	return ret;
+}
+
+static int jz_eth_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct jz_eth_private *np = netdev_priv(dev);
+
+	unregister_netdev(dev);
+	iounmap(jz_eth_base);
+	release_mem_region(np->iores->start, 0x10000);
+	dma_free_noncoherent(NULL, NUM_RX_DESCS * RX_BUF_SIZE,
+			     (void *)np->vaddr_rx_buf, np->dma_rx_buf);
+	free_netdev(dev);
+	return 0;
+}
+
+static struct platform_driver jz_eth_driver = {
+	.driver = {
+		.name = "jz-eth"
+	},
+	.probe = jz_eth_probe,
+	.remove = jz_eth_remove,
+	.suspend = jz_eth_suspend,
+	.resume = jz_eth_resume,
+};
+
+static int __init jz_eth_init(void)
+{
+	return platform_driver_register(&jz_eth_driver);
+}
+
+static void __exit jz_eth_exit(void)
+{
+	platform_driver_unregister(&jz_eth_driver);
+}
+
+module_init(jz_eth_init);
+module_exit(jz_eth_exit);
diff --git a/drivers/net/jz_eth.h b/drivers/net/jz_eth.h
new file mode 100644
index 0000000..62d147c
--- /dev/null
+++ b/drivers/net/jz_eth.h
@@ -0,0 +1,403 @@
+/*
+ *  Jz4730/Jz5730 On-Chip ethernet driver.
+ *
+ *  Copyright (C) 2005 - 2007  Ingenic Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __JZ_ETH_H__
+#define __JZ_ETH_H__
+
+/* DMA control and status registers */
+#define DMA_BMR                0x1000 // Bus mode
+#define DMA_TPD                0x1004 // Transmit poll demand register
+#define DMA_RPD                0x1008 // Receieve poll demand register
+#define DMA_RRBA               0x100C // Receieve descriptor base address
+#define DMA_TRBA               0x1010 // Transmit descriptor base address
+#define DMA_STS                0x1014 // Status register
+#define DMA_OMR                0x1018 // Command register
+#define DMA_IMR                0x101C
+#define DMA_MFC                0x1020
+
+/* DMA CSR8-CSR19 reserved */
+#define DMA_CTA                0x1050
+#define DMA_CRA                0x1054
+
+/* Mac control and status registers */
+#define MAC_MCR                0x0000
+#define MAC_MAH                0x0004
+#define MAC_MAL                0x0008
+#define MAC_HTH                0x000C
+#define MAC_HTL                0x0010
+#define MAC_MIIA               0x0014
+#define MAC_MIID               0x0018
+#define MAC_FCR                0x001C
+#define MAC_VTR1               0x0020
+#define MAC_VTR2               0x0024
+
+/*
+ * Bus Mode Register (DMA_BMR)
+ */
+#define BMR_PBL    0x00003f00       /* Programmable Burst Length */
+#define BMR_DSL    0x0000007c       /* Descriptor Skip Length */
+#define BMR_BAR    0x00000002       /* Bus ARbitration */
+#define BMR_SWR    0x00000001       /* Software Reset */
+
+#define PBL_0      0x00000000       /*  DMA burst length = amount in RX FIFO */
+#define PBL_1      0x00000100       /*  1 longword  DMA burst length */
+#define PBL_2      0x00000200       /*  2 longwords DMA burst length */
+#define PBL_4      0x00000400       /*  4 longwords DMA burst length */
+#define PBL_8      0x00000800       /*  8 longwords DMA burst length */
+#define PBL_16     0x00001000       /* 16 longwords DMA burst length */
+#define PBL_32     0x00002000       /* 32 longwords DMA burst length */
+
+#define DSL_0      0x00000000       /*  0 longword  / descriptor */
+#define DSL_1      0x00000004       /*  1 longword  / descriptor */
+#define DSL_2      0x00000008       /*  2 longwords / descriptor */
+#define DSL_4      0x00000010       /*  4 longwords / descriptor */
+#define DSL_8      0x00000020       /*  8 longwords / descriptor */
+#define DSL_16     0x00000040       /* 16 longwords / descriptor */
+#define DSL_32     0x00000080       /* 32 longwords / descriptor */
+
+/*
+ * Status Register (DMA_STS)
+ */
+#define STS_BE     0x03800000       /* Bus Error Bits */
+#define STS_TS     0x00700000       /* Transmit Process State */
+#define STS_RS     0x000e0000       /* Receive Process State */
+
+#define TS_STOP    0x00000000       /* Stopped */
+#define TS_FTD     0x00100000       /* Running Fetch Transmit Descriptor */
+#define TS_WEOT    0x00200000       /* Running Wait for End Of Transmission */
+#define TS_QDAT    0x00300000       /* Running Queue skb data into TX FIFO */
+#define TS_RES     0x00400000       /* Reserved */
+#define TS_SPKT    0x00500000       /* Reserved */
+#define TS_SUSP    0x00600000       /* Suspended */
+#define TS_CLTD    0x00700000       /* Running Close Transmit Descriptor */
+
+#define RS_STOP    0x00000000       /* Stopped */
+#define RS_FRD     0x00020000       /* Running Fetch Receive Descriptor */
+#define RS_CEOR    0x00040000       /* Running Check for End of Receive Packet */
+#define RS_WFRP    0x00060000       /* Running Wait for Receive Packet */
+#define RS_SUSP    0x00080000       /* Suspended */
+#define RS_CLRD    0x000a0000       /* Running Close Receive Descriptor */
+#define RS_FLUSH   0x000c0000       /* Running Flush RX FIFO */
+#define RS_QRFS    0x000e0000       /* Running Queue RX FIFO into RX Skb */
+
+/*
+ * Operation Mode Register (DMA_OMR)
+ */
+#define OMR_TTM    0x00400000       /* Transmit Threshold Mode */
+#define OMR_SF     0x00200000       /* Store and Forward */
+#define OMR_TR     0x0000c000       /* Threshold Control Bits */
+#define OMR_ST     0x00002000       /* Start/Stop Transmission Command */
+#define OMR_OSF    0x00000004       /* Operate on Second Frame */
+#define OMR_SR     0x00000002       /* Start/Stop Receive */
+
+#define TR_18      0x00000000       /* Threshold set to 18 (32) bytes */
+#define TR_24      0x00004000       /* Threshold set to 24 (64) bytes */
+#define TR_32      0x00008000       /* Threshold set to 32 (128) bytes */
+#define TR_40      0x0000c000       /* Threshold set to 40 (256) bytes */
+
+/*
+ * Missed Frames Counters (DMA_MFC)
+ */
+//#define MFC_CNT1   0xffff0000       /* Missed Frames Counter Bits by application */
+#define MFC_CNT1   0x0ffe0000       /* Missed Frames Counter Bits by application */
+#define MFC_CNT2   0x0000ffff       /* Missed Frames Counter Bits by controller */
+
+/*
+ * Mac control  Register (MAC_MCR)
+ */
+#define MCR_RA     0x80000000       /* Receive All */
+#define MCR_HBD    0x10000000       /* HeartBeat Disable */
+#define MCR_PS     0x08000000       /* Port Select */
+#define MCR_OWD    0x00800000       /* Receive own Disable */
+#define MCR_OM     0x00600000       /* Operating(loopback) Mode */
+#define MCR_FDX    0x00100000       /* Full Duplex Mode */
+#define MCR_PM     0x00080000       /* Pass All Multicast */
+#define MCR_PR     0x00040000       /* Promiscuous Mode */
+#define MCR_IF     0x00020000       /* Inverse Filtering */
+#define MCR_PB     0x00010000       /* Pass Bad Frames */
+#define MCR_HO     0x00008000       /* Hash Only Filtering Mode */
+#define MCR_HP     0x00002000       /* Hash/Perfect Receive Filtering Mode */
+#define MCR_FC     0x00001000       /* Late Collision control */
+#define MCR_BFD    0x00000800       /* Boardcast frame Disable */
+#define MCR_RED    0x00000400       /* Retry Disable */
+#define MCR_APS    0x00000100       /* Automatic pad stripping */
+#define MCR_BL     0x000000c0       /* Back off Limit */
+#define MCR_DC     0x00000020       /* Deferral check */
+#define MCR_TE     0x00000008       /* Transmitter enable */
+#define MCR_RE     0x00000004       /* Receiver enable */
+
+#define MCR_MII_10  ( OMR_TTM | MCR_PS)
+#define MCR_MII_100 ( MCR_HBD | MCR_PS)
+
+/* Flow control Register (MAC_FCR) */
+#define FCR_PT     0xffff0000       /* Pause time */
+#define FCR_PCF    0x00000004       /* Pass control frames */
+#define FCR_FCE    0x00000002       /* Flow control enable */
+#define FCR_FCB    0x00000001       /* Flow control busy */
+
+
+/* Constants for the interrupt mask and
+ * interrupt status registers. (DMA_SIS and DMA_IMR)
+ */
+#define DMA_INT_NI             0x00010000       // Normal interrupt summary
+#define DMA_INT_AI             0x00008000       // Abnormal interrupt summary
+#define DMA_INT_ER             0x00004000       // Early receive interrupt
+#define DMA_INT_FB             0x00002000       // Fatal bus error
+#define DMA_INT_ET             0x00000400       // Early transmit interrupt
+#define DMA_INT_RW             0x00000200       // Receive watchdog timeout
+#define DMA_INT_RS             0x00000100       // Receive stop
+#define DMA_INT_RU             0x00000080       // Receive buffer unavailble
+#define DMA_INT_RI             0x00000040       // Receive interrupt
+#define DMA_INT_UN             0x00000020       // Underflow 
+#define DMA_INT_TJ             0x00000008       // Transmit jabber timeout
+#define DMA_INT_TU             0x00000004       // Transmit buffer unavailble 
+#define DMA_INT_TS             0x00000002       // Transmit stop
+#define DMA_INT_TI             0x00000001       // Transmit interrupt
+
+/*
+ * Receive Descriptor Bit Summary
+ */
+#define R_OWN      0x80000000       /* Own Bit */
+#define RD_FF      0x40000000       /* Filtering Fail */
+#define RD_FL      0x3fff0000       /* Frame Length */
+#define RD_ES      0x00008000       /* Error Summary */
+#define RD_DE      0x00004000       /* Descriptor Error */
+#define RD_LE      0x00001000       /* Length Error */
+#define RD_RF      0x00000800       /* Runt Frame */
+#define RD_MF      0x00000400       /* Multicast Frame */
+#define RD_FS      0x00000200       /* First Descriptor */
+#define RD_LS      0x00000100       /* Last Descriptor */
+#define RD_TL      0x00000080       /* Frame Too Long */
+#define RD_CS      0x00000040       /* Collision Seen */
+#define RD_FT      0x00000020       /* Frame Type */
+#define RD_RJ      0x00000010       /* Receive Watchdog timeout*/
+#define RD_RE      0x00000008       /* Report on MII Error */
+#define RD_DB      0x00000004       /* Dribbling Bit */
+#define RD_CE      0x00000002       /* CRC Error */
+
+#define RD_RER     0x02000000       /* Receive End Of Ring */
+#define RD_RCH     0x01000000       /* Second Address Chained */
+#define RD_RBS2    0x003ff800       /* Buffer 2 Size */
+#define RD_RBS1    0x000007ff       /* Buffer 1 Size */
+
+/*
+ * Transmit Descriptor Bit Summary
+ */
+#define T_OWN      0x80000000       /* Own Bit */
+#define TD_ES      0x00008000       /* Frame Aborted (error summary)*/
+#define TD_LO      0x00000800       /* Loss Of Carrier */
+#define TD_NC      0x00000400       /* No Carrier */
+#define TD_LC      0x00000200       /* Late Collision */
+#define TD_EC      0x00000100       /* Excessive Collisions */
+#define TD_HF      0x00000080       /* Heartbeat Fail */
+#define TD_CC      0x0000003c       /* Collision Counter */
+#define TD_UF      0x00000002       /* Underflow Error */
+#define TD_DE      0x00000001       /* Deferred */
+
+#define TD_IC      0x80000000       /* Interrupt On Completion */
+#define TD_LS      0x40000000       /* Last Segment */
+#define TD_FS      0x20000000       /* First Segment */
+#define TD_FT1     0x10000000       /* Filtering Type */
+#define TD_SET     0x08000000       /* Setup Packet */
+#define TD_AC      0x04000000       /* Add CRC Disable */
+#define TD_TER     0x02000000       /* Transmit End Of Ring */
+#define TD_TCH     0x01000000       /* Second Address Chained */
+#define TD_DPD     0x00800000       /* Disabled Padding */
+#define TD_FT0     0x00400000       /* Filtering Type */
+#define TD_TBS2    0x003ff800       /* Buffer 2 Size */
+#define TD_TBS1    0x000007ff       /* Buffer 1 Size */
+
+#define PERFECT_F  0x00000000
+#define HASH_F     TD_FT0
+#define INVERSE_F  TD_FT1
+#define HASH_O_F   (TD_FT1 | TD_F0)
+
+/*
+ * Constant setting
+ */
+
+#define IMR_DEFAULT    ( DMA_INT_TI | DMA_INT_RI |	\
+                         DMA_INT_TS | DMA_INT_RS |	\
+                         DMA_INT_TU | DMA_INT_RU |	\
+                         DMA_INT_FB )
+
+#define IMR_ENABLE     (DMA_INT_NI | DMA_INT_AI)
+
+#define CRC_POLYNOMIAL_BE 0x04c11db7UL  /* Ethernet CRC, big endian */
+#define CRC_POLYNOMIAL_LE 0xedb88320UL  /* Ethernet CRC, little endian */
+
+#define HASH_TABLE_LEN   512       /* Bits */
+#define HASH_BITS        0x01ff    /* 9 LS bits */
+
+#define SETUP_FRAME_LEN  192       /* Bytes */
+#define IMPERF_PA_OFFSET 156       /* Bytes */
+
+/*
+ * Address Filtering Modes
+ */
+#define PERFECT              0     /* 16 perfect physical addresses */
+#define HASH_PERF            1     /* 1 perfect, 512 multicast addresses */
+#define PERFECT_REJ          2     /* Reject 16 perfect physical addresses */
+#define ALL_HASH             3     /* Hashes all physical & multicast addrs */
+
+#define ALL                  0     /* Clear out all the setup frame */
+#define PHYS_ADDR_ONLY       1     /* Update the physical address only */
+
+/* MII register */
+#define MII_BMCR       0x00          /* MII Basic Mode Control Register */
+#define MII_BMSR       0x01          /* MII Basic Mode Status Register */
+#define MII_ID1        0x02          /* PHY Identifier Register 1 */
+#define MII_ID2        0x03          /* PHY Identifier Register 2 */
+#define MII_ANAR       0x04          /* Auto Negotiation Advertisement Register */
+#define MII_ANLPAR     0x05          /* Auto Negotiation Link Partner Ability */
+#define MII_ANER       0x06          /* Auto Negotiation Expansion */
+#define MII_DSCR       0x10          /* Davicom Specified Configration Register */
+#define MII_DSCSR      0x11          /* Davicom Specified Configration/Status Register */
+#define MII_10BTCSR    0x12          /* 10base-T Specified Configration/Status Register */
+
+
+#define MII_PREAMBLE 0xffffffff    /* MII Management Preamble */
+#define MII_TEST     0xaaaaaaaa    /* MII Test Signal */
+#define MII_STRD     0x06          /* Start of Frame+Op Code: use low nibble */
+#define MII_STWR     0x0a          /* Start of Frame+Op Code: use low nibble */
+
+/*
+ * MII Management Control Register
+ */
+#define MII_CR_RST  0x8000         /* RESET the PHY chip */
+#define MII_CR_LPBK 0x4000         /* Loopback enable */
+#define MII_CR_SPD  0x2000         /* 0: 10Mb/s; 1: 100Mb/s */
+#define MII_CR_ASSE 0x1000         /* Auto Speed Select Enable */
+#define MII_CR_PD   0x0800         /* Power Down */
+#define MII_CR_ISOL 0x0400         /* Isolate Mode */
+#define MII_CR_RAN  0x0200         /* Restart Auto Negotiation */
+#define MII_CR_FDM  0x0100         /* Full Duplex Mode */
+#define MII_CR_CTE  0x0080         /* Collision Test Enable */
+
+/*
+ * MII Management Status Register
+ */
+#define MII_SR_T4C  0x8000         /* 100BASE-T4 capable */
+#define MII_SR_TXFD 0x4000         /* 100BASE-TX Full Duplex capable */
+#define MII_SR_TXHD 0x2000         /* 100BASE-TX Half Duplex capable */
+#define MII_SR_TFD  0x1000         /* 10BASE-T Full Duplex capable */
+#define MII_SR_THD  0x0800         /* 10BASE-T Half Duplex capable */
+#define MII_SR_ASSC 0x0020         /* Auto Speed Selection Complete*/
+#define MII_SR_RFD  0x0010         /* Remote Fault Detected */
+#define MII_SR_ANC  0x0008         /* Auto Negotiation capable */
+#define MII_SR_LKS  0x0004         /* Link Status */
+#define MII_SR_JABD 0x0002         /* Jabber Detect */
+#define MII_SR_XC   0x0001         /* Extended Capabilities */
+
+/*
+ * MII Management Auto Negotiation Advertisement Register
+ */
+#define MII_ANA_TAF  0x03e0        /* Technology Ability Field */
+#define MII_ANA_T4AM 0x0200        /* T4 Technology Ability Mask */
+#define MII_ANA_TXAM 0x0180        /* TX Technology Ability Mask */
+#define MII_ANA_FDAM 0x0140        /* Full Duplex Technology Ability Mask */
+#define MII_ANA_HDAM 0x02a0        /* Half Duplex Technology Ability Mask */
+#define MII_ANA_100M 0x0380        /* 100Mb Technology Ability Mask */
+#define MII_ANA_10M  0x0060        /* 10Mb Technology Ability Mask */
+#define MII_ANA_CSMA 0x0001        /* CSMA-CD Capable */
+
+/*
+ * MII Management Auto Negotiation Remote End Register
+ */
+#define MII_ANLPA_NP   0x8000      /* Next Page (Enable) */
+#define MII_ANLPA_ACK  0x4000      /* Remote Acknowledge */
+#define MII_ANLPA_RF   0x2000      /* Remote Fault */
+#define MII_ANLPA_TAF  0x03e0      /* Technology Ability Field */
+#define MII_ANLPA_T4AM 0x0200      /* T4 Technology Ability Mask */
+#define MII_ANLPA_TXAM 0x0180      /* TX Technology Ability Mask */
+#define MII_ANLPA_FDAM 0x0140      /* Full Duplex Technology Ability Mask */
+#define MII_ANLPA_HDAM 0x02a0      /* Half Duplex Technology Ability Mask */
+#define MII_ANLPA_100M 0x0380      /* 100Mb Technology Ability Mask */
+#define MII_ANLPA_10M  0x0060      /* 10Mb Technology Ability Mask */
+#define MII_ANLPA_CSMA 0x0001      /* CSMA-CD Capable */
+
+/*
+ * MII Management DAVICOM Specified Configuration And Status Register
+ */
+#define MII_DSCSR_100FDX       0x8000  /* 100M Full Duplex Operation Mode */    
+#define MII_DSCSR_100HDX       0x4000  /* 100M Half Duplex Operation Mode */
+#define MII_DSCSR_10FDX        0x2000  /* 10M  Full Duplex Operation Mode */
+#define MII_DSCSR_10HDX        0x1000  /* 10M  Half Duplex Operation Mode */
+#define MII_DSCSR_ANMB         0x000f  /* Auto-Negotiation Monitor Bits   */
+
+
+/*
+ * Used by IOCTL
+ */
+#define READ_COMMAND		(SIOCDEVPRIVATE+4)
+#define WRITE_COMMAND		(SIOCDEVPRIVATE+5)
+#define GETDRIVERINFO		(SIOCDEVPRIVATE+6)
+
+/*
+ * Device data and structure
+ */
+
+#define ETH_TX_TIMEOUT		(6*HZ)
+
+#define RX_BUF_SIZE		1536
+
+#define NUM_RX_DESCS		32
+#define NUM_TX_DESCS		16
+
+static const char *media_types[] = {
+	"10BaseT-HD ", "10BaseT-FD ","100baseTx-HD ", 
+	"100baseTx-FD", "100baseT4", 0
+};
+
+typedef struct {
+	unsigned int status;
+	unsigned int desc1;
+	unsigned int buf1_addr;
+	unsigned int next_addr;
+} jz_desc_t;	
+
+struct jz_eth_private {
+	jz_desc_t tx_ring[NUM_TX_DESCS];	/* transmit descriptors */
+	jz_desc_t rx_ring[NUM_RX_DESCS];	/* receive descriptors */
+	dma_addr_t dma_tx_ring;                 /* bus address of tx ring */
+	dma_addr_t dma_rx_ring;                 /* bus address of rx ring */
+	dma_addr_t dma_rx_buf;			/* DMA address of rx buffer  */	
+	unsigned int vaddr_rx_buf;		/* virtual address of rx buffer  */
+
+	unsigned int rx_head;			/* first rx descriptor */
+	unsigned int tx_head;			/* first tx descriptor */
+	unsigned int tx_tail;  			/* last unacked transmit packet */
+	unsigned int tx_full;			/* transmit buffers are full */
+	struct sk_buff *tx_skb[NUM_TX_DESCS];	/* skbuffs for packets to transmit */
+
+	struct net_device_stats stats;
+	spinlock_t lock;
+
+	int media;				/* Media (eg TP), mode (eg 100B)*/
+	int full_duplex;			/* Current duplex setting. */
+	int link_state;
+	char phys[32];				/* List of attached PHY devices */
+	char valid_phy;				/* Current linked phy-id with MAC */
+	int mii_phy_cnt;
+	int phy_type;				/* 1-RTL8309,0-DVCOM */
+	struct ethtool_cmd ecmds[32];
+	u16 advertising;			/* NWay media advertisement */
+
+	struct task_struct *thread;		/* Link check thread */
+	int thread_die;
+	struct completion thr_exited;
+	wait_queue_head_t thr_wait;
+
+	struct pm_dev *pmdev;
+
+	struct resource *iores;
+};
+
+#endif /* __JZ_ETH_H__ */
-- 
1.6.4
