Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2007 01:23:36 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.240]:3710 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20025755AbXIHAX0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Sep 2007 01:23:26 +0100
Received: by ag-out-0708.google.com with SMTP id 33so302209agc
        for <linux-mips@linux-mips.org>; Fri, 07 Sep 2007 17:23:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:x-spam-checker-version:x-spam-status:delivered-to:received:received:received:received-spf:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        bh=XGDniepId2pzmzCbAnmgeWQESTaAA2R4kVm3g5hUV+k=;
        b=XJ2A+jMzeCoi8Zdt4KyC6DdDK7AzIUssEaBHg5GlbC4CovL2WqPVWw5exQNAsFmxYaO3RP442TchYMeMSG+sMIDrVIrFhswNjxlsSrnwjP6+0Db6R5Rk7DmY2M2+8F2xfiHxUpeg8+KRsxN6EEhV017NJPqE+9E03qApA9t4gHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:x-spam-checker-version:x-spam-status:delivered-to:received-spf:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        b=kgXxwrMjMzn4CDMDWm9SEgo5W7b3tYS0TGRIcxL9XTMFHpVXL8kaAlFn+L3BIlXBIq5rmoVBSO4PP17qB7Ou5JEM7bVmcyOPdfDY2dTgthXVyWBHI4f8qRF7wLH53iNM2VkquE+t6hECyEv2IieHpn7nkccYdpZhLRs+bKb7V8E=
Received: by 10.90.102.20 with SMTP id z20mr4902898agb.1189210987387;
        Fri, 07 Sep 2007 17:23:07 -0700 (PDT)
Received: from raver.cocorico ( [87.12.226.15])
        by mx.google.com with ESMTPS id h35sm2361117wxd.2007.09.07.17.23.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2007 17:23:06 -0700 (PDT)
Received: by 10.82.154.20 with SMTP id b20cs876037bue;
        Wed, 22 Aug 2007 01:11:04 -0700 (PDT)
Received: by 10.82.112.3 with SMTP id k3mr943124buc.1187770261340;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received: from smtp1.int-evry.fr (smtp1.int-evry.fr [157.159.10.44])
        by mx.google.com with ESMTP id j9si1357887mue.2007.08.22.01.10.56;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received-SPF: neutral (google.com: 157.159.10.44 is neither permitted nor denied by best guess record for domain of florian.fainelli@telecomint.eu) client-ip=157.159.10.44;
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 122398E84F0;
	Wed, 22 Aug 2007 10:10:48 +0200 (CEST)
Received: from ibook.lan (mla78-1-82-240-16-241.fbx.proxad.net [82.240.16.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 73CFED0E336;
	Wed, 22 Aug 2007 10:10:47 +0200 (CEST)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][7/7] AR7: ethernet
Date:	Sat, 8 Sep 2007 02:23:00 +0200
User-Agent: KMail/1.9.7
References: <200709080143.12345.technoboy85@gmail.com>
In-Reply-To: <200709080143.12345.technoboy85@gmail.com>
MIME-Version: 1.0
Message-Id: <200709080223.00613.technoboy85@gmail.com>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-1.467, requis 4.01,
	autolearn=not spam, AWL 1.00, BAYES_00 -2.60, FORGED_RCVD_HELO 0.14)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Content-Disposition: inline
Cc:	Eugene Konev <ejka@imfi.kspu.ru>, netdev@vger.kernel.org,
	davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
	jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Driver for the cpmac 100M ethernet driver.
It works fine disabling napi support, enabling it gives a kernel panic
when the first IPv6 packet has to be forwarded.
Other than that works fine.

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d9b7d9c..6f38a84 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1822,6 +1822,15 @@ config SC92031
 	  To compile this driver as a module, choose M here: the module
 	  will be called sc92031.  This is recommended.
 
+config CPMAC
+	tristate "TI AR7 CPMAC Ethernet support (EXPERIMENTAL)"
+	depends on NET_ETHERNET && EXPERIMENTAL && AR7
+	select PHYLIB
+	select FIXED_PHY
+	select FIXED_MII_100_FDX
+	help
+	  TI AR7 CPMAC Ethernet support
+
 config NET_POCKET
 	bool "Pocket and portable adapters"
 	depends on PARPORT
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 535d2a0..bb22df9 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
 obj-$(CONFIG_ZNET) += znet.o
 obj-$(CONFIG_LAN_SAA9730) += saa9730.o
+obj-$(CONFIG_CPMAC) += cpmac.o
 obj-$(CONFIG_DEPCA) += depca.o
 obj-$(CONFIG_EWRK3) += ewrk3.o
 obj-$(CONFIG_ATP) += atp.o
diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
new file mode 100644
index 0000000..c10ab08
--- /dev/null
+++ b/drivers/net/cpmac.c
@@ -0,0 +1,1194 @@
+/*
+ * Copyright (C) 2006, 2007 Eugene Konev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/version.h>
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/skbuff.h>
+#include <linux/mii.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <asm/ar7/ar7.h>
+#include <gpio.h>
+
+MODULE_AUTHOR("Eugene Konev");
+MODULE_DESCRIPTION("TI AR7 ethernet driver (CPMAC)");
+MODULE_LICENSE("GPL");
+
+static int rx_ring_size = 64;
+static int disable_napi;
+module_param(rx_ring_size, int, 64);
+module_param(disable_napi, int, 0);
+MODULE_PARM_DESC(rx_ring_size, "Size of rx ring (in skbs)");
+MODULE_PARM_DESC(disable_napi, "Disable NAPI polling");
+
+/* Register definitions */
+struct cpmac_control_regs {
+	u32 revision;
+	u32 control;
+	u32 teardown;
+	u32 unused;
+} __attribute__ ((packed));
+
+struct cpmac_int_regs {
+	u32 stat_raw;
+	u32 stat_masked;
+	u32 enable;
+	u32 clear;
+} __attribute__ ((packed));
+
+struct cpmac_stats {
+	u32 good;
+	u32 bcast;
+	u32 mcast;
+	u32 pause;
+	u32 crc_error;
+	u32 align_error;
+	u32 oversized;
+	u32 jabber;
+	u32 undersized;
+	u32 fragment;
+	u32 filtered;
+	u32 qos_filtered;
+	u32 octets;
+} __attribute__ ((packed));
+
+struct cpmac_regs {
+	struct cpmac_control_regs tx_ctrl;
+	struct cpmac_control_regs rx_ctrl;
+	u32 unused1[56];
+	u32 mbp;
+/* MBP bits */
+#define MBP_RXPASSCRC         0x40000000
+#define MBP_RXQOS             0x20000000
+#define MBP_RXNOCHAIN         0x10000000
+#define MBP_RXCMF             0x01000000
+#define MBP_RXSHORT           0x00800000
+#define MBP_RXCEF             0x00400000
+#define MBP_RXPROMISC         0x00200000
+#define MBP_PROMISCCHAN(chan) (((chan) & 0x7) << 16)
+#define MBP_RXBCAST           0x00002000
+#define MBP_BCASTCHAN(chan)   (((chan) & 0x7) << 8)
+#define MBP_RXMCAST           0x00000020
+#define MBP_MCASTCHAN(chan)   ((chan) & 0x7)
+	u32 unicast_enable;
+	u32 unicast_clear;
+	u32 max_len;
+	u32 buffer_offset;
+	u32 filter_flow_threshold;
+	u32 unused2[2];
+	u32 flow_thre[8];
+	u32 free_buffer[8];
+	u32 mac_control;
+#define MAC_TXPTYPE  0x00000200
+#define MAC_TXPACE   0x00000040
+#define MAC_MII      0x00000020
+#define MAC_TXFLOW   0x00000010
+#define MAC_RXFLOW   0x00000008
+#define MAC_MTEST    0x00000004
+#define MAC_LOOPBACK 0x00000002
+#define MAC_FDX      0x00000001
+	u32 mac_status;
+#define MACST_QOS    0x4
+#define MACST_RXFLOW 0x2
+#define MACST_TXFLOW 0x1
+	u32 emc_control;
+	u32 unused3;
+	struct cpmac_int_regs tx_int;
+	u32 mac_int_vector;
+/* Int Status bits */
+#define INTST_STATUS 0x80000
+#define INTST_HOST   0x40000
+#define INTST_RX     0x20000
+#define INTST_TX     0x10000
+	u32 mac_eoi_vector;
+	u32 unused4[2];
+	struct cpmac_int_regs rx_int;
+	u32 mac_int_stat_raw;
+	u32 mac_int_stat_masked;
+	u32 mac_int_enable;
+	u32 mac_int_clear;
+	u32 mac_addr_low[8];
+	u32 mac_addr_mid;
+	u32 mac_addr_high;
+	u32 mac_hash_low;
+	u32 mac_hash_high;
+	u32 boff_test;
+	u32 pac_test;
+	u32 rx_pause;
+	u32 tx_pause;
+	u32 unused5[2];
+	struct cpmac_stats rx_stats;
+	struct cpmac_stats tx_stats;
+	u32 unused6[232];
+	u32 tx_ptr[8];
+	u32 rx_ptr[8];
+	u32 tx_ack[8];
+	u32 rx_ack[8];
+
+} __attribute__ ((packed));
+
+struct cpmac_mdio_regs {
+	u32 version;
+	u32 control;
+#define MDIOC_IDLE        0x80000000
+#define MDIOC_ENABLE      0x40000000
+#define MDIOC_PREAMBLE    0x00100000
+#define MDIOC_FAULT       0x00080000
+#define MDIOC_FAULTDETECT 0x00040000
+#define MDIOC_INTTEST     0x00020000
+#define MDIOC_CLKDIV(div) ((div) & 0xff)
+	u32 alive;
+	u32 link;
+	struct cpmac_int_regs link_int;
+	struct cpmac_int_regs user_int;
+	u32 unused[20];
+	volatile u32 access;
+#define MDIO_BUSY       0x80000000
+#define MDIO_WRITE      0x40000000
+#define MDIO_REG(reg)   (((reg) & 0x1f) << 21)
+#define MDIO_PHY(phy)   (((phy) & 0x1f) << 16)
+#define MDIO_DATA(data) ((data) & 0xffff)
+	u32 physel;
+} __attribute__ ((packed));
+
+/* Descriptor */
+struct cpmac_desc {
+	u32 hw_next;
+	u32 hw_data;
+	u16 buflen;
+	u16 bufflags;
+	u16 datalen;
+	u16 dataflags;
+/* Flags bits */
+#define CPMAC_SOP 0x8000
+#define CPMAC_EOP 0x4000
+#define CPMAC_OWN 0x2000
+#define CPMAC_EOQ 0x1000
+	struct sk_buff *skb;
+	struct cpmac_desc *next;
+} __attribute__ ((packed));
+
+struct cpmac_priv {
+	struct net_device_stats stats;
+	spinlock_t lock; /* irq{save,restore} */
+	struct sk_buff *skb_pool;
+	int free_skbs;
+	struct cpmac_desc *rx_head;
+	int tx_head, tx_tail;
+	struct cpmac_desc *desc_ring;
+	struct cpmac_regs *regs;
+	struct mii_bus *mii_bus;
+	struct phy_device *phy;
+	char phy_name[BUS_ID_SIZE];
+	struct plat_cpmac_data *config;
+	int oldlink, oldspeed, oldduplex;
+	u32 msg_enable;
+	struct net_device *dev;
+	struct work_struct alloc_work;
+};
+
+static irqreturn_t cpmac_irq(int, void *);
+static void cpmac_reset(struct net_device *dev);
+static void cpmac_hw_init(struct net_device *dev);
+static int cpmac_stop(struct net_device *dev);
+static int cpmac_open(struct net_device *dev);
+
+#undef CPMAC_DEBUG
+#define CPMAC_LOW_THRESH 32
+#define CPMAC_ALLOC_SIZE 64
+#define CPMAC_SKB_SIZE 1518
+#define CPMAC_TX_RING_SIZE 8
+
+#ifdef CPMAC_DEBUG
+static void cpmac_dump_regs(u32 *base, int count)
+{
+	int i;
+	for (i = 0; i < (count + 3) / 4; i++) {
+		if (i % 4 == 0) printk(KERN_DEBUG "\nCPMAC[0x%04x]:", i * 4);
+		printk(KERN_DEBUG " 0x%08x", *(base + i));
+	}
+	printk(KERN_DEBUG "\n");
+}
+
+static const char *cpmac_dump_buf(const uint8_t *buf, unsigned size)
+{
+	static char buffer[3 * 25 + 1];
+	char *p = &buffer[0];
+	if (size > 20)
+		size = 20;
+	while (size-- > 0)
+		p += sprintf(p, " %02x", *buf++);
+	return buffer;
+}
+#endif
+
+static int cpmac_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
+{
+	struct cpmac_mdio_regs *regs = bus->priv;
+	u32 val;
+
+	while ((val = regs->access) & MDIO_BUSY);
+	regs->access = MDIO_BUSY | MDIO_REG(regnum & 0x1f) |
+		MDIO_PHY(phy_id & 0x1f);
+	while ((val = regs->access) & MDIO_BUSY);
+
+	return val & 0xffff;
+}
+
+static int cpmac_mdio_write(struct mii_bus *bus, int phy_id,
+				int regnum, u16 val)
+{
+	struct cpmac_mdio_regs *regs = bus->priv;
+
+	while (regs->access & MDIO_BUSY);
+	regs->access = MDIO_BUSY | MDIO_WRITE |
+		MDIO_REG(regnum & 0x1f) | MDIO_PHY(phy_id & 0x1f) | val;
+
+	return 0;
+}
+
+static int cpmac_mdio_reset(struct mii_bus *bus)
+{
+	ar7_device_reset(AR7_RESET_BIT_MDIO);
+	((struct cpmac_mdio_regs *)bus->priv)->control = MDIOC_ENABLE |
+		MDIOC_CLKDIV(ar7_cpmac_freq() / 2200000 - 1);
+
+	return 0;
+}
+
+static int mii_irqs[PHY_MAX_ADDR] = { PHY_POLL, };
+
+static struct mii_bus cpmac_mii = {
+	.name = "cpmac-mii",
+	.read = cpmac_mdio_read,
+	.write = cpmac_mdio_write,
+	.reset = cpmac_mdio_reset,
+	.irq = mii_irqs,
+};
+
+static int cpmac_config(struct net_device *dev, struct ifmap *map)
+{
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* Don't allow changing the I/O address */
+	if (map->base_addr != dev->base_addr)
+		return -EOPNOTSUPP;
+
+	/* ignore other fields */
+	return 0;
+}
+
+static int cpmac_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct sockaddr *sa = addr;
+
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	memcpy(dev->dev_addr, sa->sa_data, dev->addr_len);
+
+	return 0;
+}
+
+static void cpmac_set_multicast_list(struct net_device *dev)
+{
+	struct dev_mc_list *iter;
+	int i;
+	int hash, tmp;
+	int hashlo = 0, hashhi = 0;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (dev->flags & IFF_PROMISC) {
+		priv->regs->mbp &= ~MBP_PROMISCCHAN(0); /* promisc channel 0 */
+		priv->regs->mbp |= MBP_RXPROMISC;
+	} else {
+		priv->regs->mbp &= ~MBP_RXPROMISC;
+		if (dev->flags & IFF_ALLMULTI) {
+			/* enable all multicast mode */
+			priv->regs->mac_hash_low = 0xffffffff;
+			priv->regs->mac_hash_high = 0xffffffff;
+		} else {
+			for (i = 0, iter = dev->mc_list; i < dev->mc_count;
+			    i++, iter = iter->next) {
+				hash = 0;
+				tmp = iter->dmi_addr[0];
+				hash  ^= (tmp >> 2) ^ (tmp << 4);
+				tmp = iter->dmi_addr[1];
+				hash  ^= (tmp >> 4) ^ (tmp << 2);
+				tmp = iter->dmi_addr[2];
+				hash  ^= (tmp >> 6) ^ tmp;
+				tmp = iter->dmi_addr[4];
+				hash  ^= (tmp >> 2) ^ (tmp << 4);
+				tmp = iter->dmi_addr[5];
+				hash  ^= (tmp >> 4) ^ (tmp << 2);
+				tmp = iter->dmi_addr[6];
+				hash  ^= (tmp >> 6) ^ tmp;
+				hash &= 0x3f;
+				if (hash < 32) {
+					hashlo |= 1<<hash;
+				} else {
+					hashhi |= 1<<(hash - 32);
+				}
+			}
+
+			priv->regs->mac_hash_low = hashlo;
+			priv->regs->mac_hash_high = hashhi;
+		}
+	}
+}
+
+static struct sk_buff *cpmac_get_skb(struct net_device *dev)
+{
+	struct sk_buff *skb;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	skb = priv->skb_pool;
+	if (likely(skb))
+		priv->skb_pool = skb->next;
+	else {
+		skb = dev_alloc_skb(CPMAC_SKB_SIZE + 2);
+		if (skb) {
+			skb->next = NULL;
+			skb_reserve(skb, 2);
+			skb->dev = priv->dev;
+		}
+	}
+
+	if (likely(priv->free_skbs))
+		priv->free_skbs--;
+
+	if (priv->free_skbs < CPMAC_LOW_THRESH)
+		schedule_work(&priv->alloc_work);
+
+	return skb;
+}
+
+static struct sk_buff *cpmac_rx_one(struct net_device *dev,
+					   struct cpmac_priv *priv,
+					   struct cpmac_desc *desc)
+{
+	unsigned long flags;
+	char *data;
+	struct sk_buff *skb, *result = NULL;
+
+	priv->regs->rx_ack[0] = virt_to_phys(desc);
+	if (unlikely(!desc->datalen)) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "%s: rx: spurious interrupt\n",
+			       dev->name);
+		priv->stats.rx_errors++;
+		return NULL;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+	skb = cpmac_get_skb(dev);
+	if (likely(skb)) {
+		data = (char *)phys_to_virt(desc->hw_data);
+		dma_cache_inv((u32)data, desc->datalen);
+		skb_put(desc->skb, desc->datalen);
+		desc->skb->protocol = eth_type_trans(desc->skb, dev);
+		desc->skb->ip_summed = CHECKSUM_NONE;
+		priv->stats.rx_packets++;
+		priv->stats.rx_bytes += desc->datalen;
+		result = desc->skb;
+		desc->skb = skb;
+	} else {
+#ifdef CPMAC_DEBUG
+		if (printk_ratelimit())
+			printk(KERN_NOTICE "%s: low on skbs, dropping packet\n",
+			       dev->name);
+#endif
+		priv->stats.rx_dropped++;
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	desc->hw_data = virt_to_phys(desc->skb->data);
+	desc->buflen = CPMAC_SKB_SIZE;
+	desc->dataflags = CPMAC_OWN;
+	dma_cache_wback((u32)desc, 16);
+
+	return result;
+}
+
+static void cpmac_rx(struct net_device *dev)
+{
+	struct sk_buff *skb;
+	struct cpmac_desc *desc;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	spin_lock(&priv->lock);
+	if (unlikely(!priv->rx_head)) {
+		spin_unlock(&priv->lock);
+		return;
+	}
+
+	desc = priv->rx_head;
+	dma_cache_inv((u32)desc, 16);
+#ifdef CPMAC_DEBUG
+	printk(KERN_DEBUG "%s: len=%d, %s\n", __func__, pkt->datalen,
+		cpmac_dump_buf(data, pkt->datalen));
+#endif
+
+	while ((desc->dataflags & CPMAC_OWN) == 0) {
+		skb = cpmac_rx_one(dev, priv, desc);
+		if (likely(skb))
+			netif_rx(skb);
+		desc = desc->next;
+		dma_cache_inv((u32)desc, 16);
+	}
+
+	priv->rx_head = desc;
+	priv->regs->rx_ptr[0] = virt_to_phys(desc);
+	spin_unlock(&priv->lock);
+}
+
+static int cpmac_poll(struct net_device *dev, int *budget)
+{
+	struct sk_buff *skb;
+	struct cpmac_desc *desc;
+	int received = 0, quota = min(dev->quota, *budget);
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (unlikely(!priv->rx_head)) {
+		if (printk_ratelimit())
+			printk(KERN_NOTICE "%s: rx: polling, but no queue\n",
+			       dev->name);
+		netif_rx_complete(dev);
+		return 0;
+	}
+
+	desc = priv->rx_head;
+	dma_cache_inv((u32)desc, 16);
+
+	while ((received < quota) && ((desc->dataflags & CPMAC_OWN) == 0)) {
+		skb = cpmac_rx_one(dev, priv, desc);
+		if (likely(skb)) {
+			netif_receive_skb(skb);
+			received++;
+		}
+		desc = desc->next;
+		priv->rx_head = desc;
+		dma_cache_inv((u32)desc, 16);
+	}
+
+	*budget -= received;
+	dev->quota -= received;
+#ifdef CPMAC_DEBUG
+	printk(KERN_DEBUG "%s: processed %d packets\n", dev->name, received);
+#endif
+	if (desc->dataflags & CPMAC_OWN) {
+		priv->regs->rx_ptr[0] = virt_to_phys(desc);
+		netif_rx_complete(dev);
+		priv->regs->rx_int.enable = 0x1;
+		priv->regs->rx_int.clear = 0xfe;
+		return 0;
+	}
+
+	return 1;
+}
+
+static void
+cpmac_alloc_skbs(struct work_struct *work)
+{
+	struct cpmac_priv *priv = container_of(work, struct cpmac_priv,
+			alloc_work);
+	unsigned long flags;
+	int i, num_skbs = 0;
+	struct sk_buff *skb, *skbs = NULL;
+
+	for (i = 0; i < CPMAC_ALLOC_SIZE; i++) {
+		skb = alloc_skb(CPMAC_SKB_SIZE + 2, GFP_KERNEL);
+		if (!skb)
+			break;
+		skb->next = skbs;
+		skb_reserve(skb, 2);
+		skb->dev = priv->dev;
+		num_skbs++;
+		skbs = skb;
+	}
+
+	if (skbs) {
+		spin_lock_irqsave(&priv->lock, flags);
+		for (skb = priv->skb_pool; skb && skb->next; skb = skb->next);
+		if (!skb)
+			priv->skb_pool = skbs;
+		else
+			skb->next = skbs;
+		priv->free_skbs += num_skbs;
+		spin_unlock_irqrestore(&priv->lock, flags);
+#ifdef CPMAC_DEBUG
+		printk(KERN_DEBUG "%s: allocated %d skbs\n",
+			priv->dev->name, num_skbs);
+#endif
+	}
+}
+
+static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned long flags;
+	int len, chan;
+	struct cpmac_desc *desc;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	len = skb->len;
+#ifdef CPMAC_DEBUG
+	printk(KERN_DEBUG "%s: len=%d\n", __func__, len);
+	/* cpmac_dump_buf(const uint8_t * buf, unsigned size) */
+#endif
+	if (unlikely(len < ETH_ZLEN)) {
+		if (unlikely(skb_padto(skb, ETH_ZLEN))) {
+			if (printk_ratelimit())
+				printk(KERN_NOTICE
+					"%s: padding failed, dropping\n",
+								dev->name);
+			spin_lock_irqsave(&priv->lock, flags);
+			priv->stats.tx_dropped++;
+			spin_unlock_irqrestore(&priv->lock, flags);
+			return -ENOMEM;
+		}
+		len = ETH_ZLEN;
+	}
+	spin_lock_irqsave(&priv->lock, flags);
+	chan = priv->tx_tail++;
+	priv->tx_tail %= 8;
+	if (priv->tx_tail == priv->tx_head)
+		netif_stop_queue(dev);
+
+	desc = &priv->desc_ring[chan];
+	dma_cache_inv((u32)desc, 16);
+	if (desc->dataflags & CPMAC_OWN) {
+		printk(KERN_NOTICE "%s: tx dma ring full, dropping\n",
+								dev->name);
+		priv->stats.tx_dropped++;
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return -ENOMEM;
+	}
+
+	dev->trans_start = jiffies;
+	desc->dataflags = CPMAC_SOP | CPMAC_EOP | CPMAC_OWN;
+	desc->skb = skb;
+	desc->hw_data = virt_to_phys(skb->data);
+	dma_cache_wback((u32)skb->data, len);
+	desc->buflen = len;
+	desc->datalen = len;
+	desc->hw_next = 0;
+	dma_cache_wback((u32)desc, 16);
+	priv->regs->tx_ptr[chan] = virt_to_phys(desc);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void cpmac_end_xmit(struct net_device *dev, int channel)
+{
+	struct cpmac_desc *desc;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	spin_lock(&priv->lock);
+	desc = &priv->desc_ring[channel];
+	priv->regs->tx_ack[channel] = virt_to_phys(desc);
+	if (likely(desc->skb)) {
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += desc->skb->len;
+		dev_kfree_skb_irq(desc->skb);
+		if (netif_queue_stopped(dev))
+			netif_wake_queue(dev);
+	} else
+		if (printk_ratelimit())
+			printk(KERN_NOTICE "%s: end_xmit: spurious interrupt\n",
+			       dev->name);
+	spin_unlock(&priv->lock);
+}
+
+static void cpmac_reset(struct net_device *dev)
+{
+	int i;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	ar7_device_reset(priv->config->reset_bit);
+	priv->regs->rx_ctrl.control &= ~1;
+	priv->regs->tx_ctrl.control &= ~1;
+	for (i = 0; i < 8; i++) {
+		priv->regs->tx_ptr[i] = 0;
+		priv->regs->rx_ptr[i] = 0;
+	}
+	priv->regs->mac_control &= ~MAC_MII; /* disable mii */
+}
+
+static inline void cpmac_free_rx_ring(struct net_device *dev)
+{
+	struct cpmac_desc *desc;
+	int i;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (unlikely(!priv->rx_head))
+		return;
+
+	desc = priv->rx_head;
+	dma_cache_inv((u32)desc, 16);
+
+	for (i = 0; i < rx_ring_size; i++) {
+		desc->buflen = CPMAC_SKB_SIZE;
+		if ((desc->dataflags & CPMAC_OWN) == 0) {
+			desc->dataflags = CPMAC_OWN;
+			priv->stats.rx_dropped++;
+		}
+		dma_cache_wback((u32)desc, 16);
+		desc = desc->next;
+		dma_cache_inv((u32)desc, 16);
+	}
+}
+
+static irqreturn_t cpmac_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct cpmac_priv *priv = netdev_priv(dev);
+	u32 status;
+
+	if (!dev)
+		return IRQ_NONE;
+
+	status = priv->regs->mac_int_vector;
+
+	if (status & INTST_TX)
+		cpmac_end_xmit(dev, (status & 7));
+
+	if (status & INTST_RX) {
+		if (disable_napi)
+			cpmac_rx(dev);
+		else {
+			priv->regs->rx_int.enable = 0;
+			priv->regs->rx_int.clear = 0xff;
+			netif_rx_schedule(dev);
+		}
+	}
+
+	priv->regs->mac_eoi_vector = 0;
+
+	if (unlikely(status & (INTST_HOST | INTST_STATUS))) {
+		if (printk_ratelimit())
+			printk(KERN_ERR "%s: hw error, resetting...\n",
+								dev->name);
+		spin_lock(&priv->lock);
+		phy_stop(priv->phy);
+		cpmac_reset(dev);
+		cpmac_free_rx_ring(dev);
+		cpmac_hw_init(dev);
+		spin_unlock(&priv->lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void cpmac_tx_timeout(struct net_device *dev)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+	struct cpmac_desc *desc;
+
+	priv->stats.tx_errors++;
+	desc = &priv->desc_ring[priv->tx_head++];
+	priv->tx_head %= 8;
+	printk(KERN_NOTICE "%s: transmit timeout\n", dev->name);
+	if (desc->skb)
+		dev_kfree_skb(desc->skb);
+	netif_wake_queue(dev);
+}
+
+static int cpmac_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+	if (!(netif_running(dev)))
+		return -EINVAL;
+	if (!priv->phy)
+		return -EINVAL;
+	if ((cmd == SIOCGMIIPHY) || (cmd == SIOCGMIIREG) ||
+	    (cmd == SIOCSMIIREG))
+		return phy_mii_ioctl(priv->phy, if_mii(ifr), cmd);
+
+	return -EINVAL;
+}
+
+static int cpmac_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (priv->phy)
+		return phy_ethtool_gset(priv->phy, cmd);
+
+	return -EINVAL;
+}
+
+static int cpmac_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (priv->phy)
+		return phy_ethtool_sset(priv->phy, cmd);
+
+	return -EINVAL;
+}
+
+static void cpmac_get_drvinfo(struct net_device *dev,
+			      struct ethtool_drvinfo *info)
+{
+	strcpy(info->driver, "cpmac");
+	strcpy(info->version, "0.0.3");
+	info->fw_version[0] = '\0';
+	sprintf(info->bus_info, "%s", "cpmac");
+	info->regdump_len = 0;
+}
+
+static const struct ethtool_ops cpmac_ethtool_ops = {
+	.get_settings = cpmac_get_settings,
+	.set_settings = cpmac_set_settings,
+	.get_drvinfo = cpmac_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+};
+
+static struct net_device_stats *cpmac_stats(struct net_device *dev)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (netif_device_present(dev))
+		return &priv->stats;
+
+	return NULL;
+}
+
+static int cpmac_change_mtu(struct net_device *dev, int mtu)
+{
+	unsigned long flags;
+	struct cpmac_priv *priv = netdev_priv(dev);
+	spinlock_t *lock = &priv->lock;
+
+	if ((mtu < 68) || (mtu > 1500))
+		return -EINVAL;
+
+	spin_lock_irqsave(lock, flags);
+	dev->mtu = mtu;
+	spin_unlock_irqrestore(lock, flags);
+
+	return 0;
+}
+
+static void cpmac_adjust_link(struct net_device *dev)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+	int new_state = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->phy->link) {
+		if (priv->phy->duplex != priv->oldduplex) {
+			new_state = 1;
+			priv->oldduplex = priv->phy->duplex;
+		}
+
+		if (priv->phy->speed != priv->oldspeed) {
+			new_state = 1;
+			priv->oldspeed = priv->phy->speed;
+		}
+
+		if (!priv->oldlink) {
+			new_state = 1;
+			priv->oldlink = 1;
+			netif_schedule(dev);
+		}
+	} else if (priv->oldlink) {
+		new_state = 1;
+		priv->oldlink = 0;
+		priv->oldspeed = 0;
+		priv->oldduplex = -1;
+	}
+
+	if (new_state)
+		phy_print_status(priv->phy);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void cpmac_hw_init(struct net_device *dev)
+{
+	int i;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	for (i = 0; i < 8; i++)
+		priv->regs->tx_ptr[i] = 0;
+	priv->regs->rx_ptr[0] = virt_to_phys(priv->rx_head);
+
+	priv->regs->mbp = MBP_RXSHORT | MBP_RXBCAST | MBP_RXMCAST;
+	priv->regs->unicast_enable = 0x1;
+	priv->regs->unicast_clear = 0xfe;
+	priv->regs->buffer_offset = 0;
+	for (i = 0; i < 8; i++)
+		priv->regs->mac_addr_low[i] = dev->dev_addr[5];
+	priv->regs->mac_addr_mid = dev->dev_addr[4];
+	priv->regs->mac_addr_high = dev->dev_addr[0] | (dev->dev_addr[1] << 8)
+		| (dev->dev_addr[2] << 16) | (dev->dev_addr[3] << 24);
+	priv->regs->max_len = CPMAC_SKB_SIZE;
+	priv->regs->rx_int.enable = 0x1;
+	priv->regs->rx_int.clear = 0xfe;
+	priv->regs->tx_int.enable = 0xff;
+	priv->regs->tx_int.clear = 0;
+	priv->regs->mac_int_enable = 3;
+	priv->regs->mac_int_clear = 0xfc;
+
+	priv->regs->rx_ctrl.control |= 1;
+	priv->regs->tx_ctrl.control |= 1;
+	priv->regs->mac_control |= MAC_MII | MAC_FDX;
+
+	priv->phy->state = PHY_CHANGELINK;
+	phy_start(priv->phy);
+}
+
+static int cpmac_open(struct net_device *dev)
+{
+	int i, size, res;
+	struct cpmac_priv *priv = netdev_priv(dev);
+	struct cpmac_desc *desc;
+	struct sk_buff *skb;
+
+	priv->phy = phy_connect(dev, priv->phy_name, &cpmac_adjust_link,
+				0, PHY_INTERFACE_MODE_MII);
+	if (IS_ERR(priv->phy)) {
+		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
+		return PTR_ERR(priv->phy);
+	}
+
+	if (!request_mem_region(dev->mem_start, dev->mem_end -
+				dev->mem_start, dev->name)) {
+		printk(KERN_ERR "%s: failed to request registers\n",
+		       dev->name);
+		res = -ENXIO;
+		goto fail_reserve;
+	}
+
+	priv->regs = ioremap_nocache(dev->mem_start, dev->mem_end -
+				     dev->mem_start);
+	if (!priv->regs) {
+		printk(KERN_ERR "%s: failed to remap registers\n", dev->name);
+		res = -ENXIO;
+		goto fail_remap;
+	}
+
+	priv->rx_head = NULL;
+	size = sizeof(struct cpmac_desc) * (rx_ring_size +
+					    CPMAC_TX_RING_SIZE);
+	priv->desc_ring = (struct cpmac_desc *)kmalloc(size, GFP_KERNEL);
+	if (!priv->desc_ring) {
+		res = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	memset((char *)priv->desc_ring, 0, size);
+
+	priv->skb_pool = NULL;
+	priv->free_skbs = 0;
+	priv->rx_head = &priv->desc_ring[CPMAC_TX_RING_SIZE];
+
+	INIT_WORK(&priv->alloc_work, cpmac_alloc_skbs);
+	schedule_work(&priv->alloc_work);
+	flush_scheduled_work();
+
+	for (i = 0; i < rx_ring_size; i++) {
+		desc = &priv->rx_head[i];
+		skb = cpmac_get_skb(dev);
+		if (!skb) {
+			res = -ENOMEM;
+			goto fail_desc;
+		}
+		desc->skb = skb;
+		desc->hw_data = virt_to_phys(skb->data);
+		desc->buflen = CPMAC_SKB_SIZE;
+		desc->dataflags = CPMAC_OWN;
+		desc->next = &priv->rx_head[(i + 1) % rx_ring_size];
+		desc->hw_next = virt_to_phys(desc->next);
+		dma_cache_wback((u32)desc, 16);
+	}
+
+	if ((res = request_irq(dev->irq, cpmac_irq, SA_INTERRUPT,
+			      dev->name, dev))) {
+		printk(KERN_ERR "%s: failed to obtain irq\n", dev->name);
+		goto fail_irq;
+	}
+
+	cpmac_reset(dev);
+	cpmac_hw_init(dev);
+
+	netif_start_queue(dev);
+	return 0;
+
+fail_irq:
+fail_desc:
+	for (i = 0; i < rx_ring_size; i++)
+		if (priv->rx_head[i].skb)
+			kfree_skb(priv->rx_head[i].skb);
+fail_alloc:
+	kfree(priv->desc_ring);
+
+	for (skb = priv->skb_pool; skb; skb = priv->skb_pool) {
+		priv->skb_pool = skb->next;
+		kfree_skb(skb);
+	}
+
+	iounmap(priv->regs);
+
+fail_remap:
+	release_mem_region(dev->mem_start, dev->mem_end -
+			   dev->mem_start);
+
+fail_reserve:
+	phy_disconnect(priv->phy);
+
+	return res;
+}
+
+static int cpmac_stop(struct net_device *dev)
+{
+	int i;
+	struct sk_buff *skb;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	netif_stop_queue(dev);
+
+	phy_stop(priv->phy);
+	phy_disconnect(priv->phy);
+	priv->phy = NULL;
+
+	cpmac_reset(dev);
+
+	for (i = 0; i < 8; i++) {
+		priv->regs->rx_ptr[i] = 0;
+		priv->regs->tx_ptr[i] = 0;
+		priv->regs->mbp = 0;
+	}
+
+	free_irq(dev->irq, dev);
+	release_mem_region(dev->mem_start, dev->mem_end -
+			   dev->mem_start);
+
+	cancel_delayed_work(&priv->alloc_work);
+	flush_scheduled_work();
+
+	priv->rx_head = &priv->desc_ring[CPMAC_TX_RING_SIZE];
+	for (i = 0; i < rx_ring_size; i++)
+		if (priv->rx_head[i].skb)
+			kfree_skb(priv->rx_head[i].skb);
+
+	kfree(priv->desc_ring);
+
+	for (skb = priv->skb_pool; skb; skb = priv->skb_pool) {
+		priv->skb_pool = skb->next;
+		kfree_skb(skb);
+	}
+
+	return 0;
+}
+
+static int external_switch;
+
+static int __devinit cpmac_probe(struct platform_device *pdev)
+{
+	int i, rc, phy_id;
+	struct resource *res;
+	struct cpmac_priv *priv;
+	struct net_device *dev;
+	struct plat_cpmac_data *pdata;
+
+	pdata = pdev->dev.platform_data;
+
+	for (phy_id = 0; phy_id < PHY_MAX_ADDR; phy_id++) {
+		if (!(pdata->phy_mask & (1 << phy_id)))
+			continue;
+		if (!cpmac_mii.phy_map[phy_id])
+			continue;
+		break;
+	}
+
+	if (phy_id == PHY_MAX_ADDR) {
+		if (external_switch)
+			phy_id = 0;
+		else {
+			printk(KERN_ERR "cpmac: no PHY present\n");
+			return -ENODEV;
+		}
+	}
+
+	dev = alloc_etherdev(sizeof(struct cpmac_priv));
+
+	if (!dev) {
+		printk(KERN_ERR
+			"cpmac: Unable to allocate net_device structure!\n");
+		return -ENOMEM;
+	}
+
+	SET_MODULE_OWNER(dev);
+	platform_set_drvdata(pdev, dev);
+	priv = netdev_priv(dev);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (!res) {
+		rc = -ENODEV;
+		goto fail;
+	}
+
+	dev->mem_start = res->start;
+	dev->mem_end = res->end;
+	dev->irq = platform_get_irq_byname(pdev, "irq");
+
+	dev->mtu                = 1500;
+	dev->open               = cpmac_open;
+	dev->stop               = cpmac_stop;
+	dev->set_config         = cpmac_config;
+	dev->hard_start_xmit    = cpmac_start_xmit;
+	dev->do_ioctl           = cpmac_ioctl;
+	dev->get_stats          = cpmac_stats;
+	dev->change_mtu         = cpmac_change_mtu;
+	dev->set_mac_address    = cpmac_set_mac_address;
+	dev->set_multicast_list = cpmac_set_multicast_list;
+	dev->tx_timeout         = cpmac_tx_timeout;
+	dev->ethtool_ops        = &cpmac_ethtool_ops;
+	if (!disable_napi) {
+		dev->poll = cpmac_poll;
+		dev->weight = min(rx_ring_size, 64);
+	}
+
+	memset(priv, 0, sizeof(struct cpmac_priv));
+	spin_lock_init(&priv->lock);
+	priv->msg_enable = netif_msg_init(NETIF_MSG_WOL, 0x3fff);
+	priv->config = pdata;
+	priv->dev = dev;
+	memcpy(dev->dev_addr, priv->config->dev_addr, sizeof(dev->dev_addr));
+	if (phy_id == 31)
+		snprintf(priv->phy_name, BUS_ID_SIZE, PHY_ID_FMT,
+			 cpmac_mii.id, phy_id);
+	else
+		snprintf(priv->phy_name, BUS_ID_SIZE, "fixed@%d:%d", 100, 1);
+
+	if ((rc = register_netdev(dev))) {
+		printk(KERN_ERR "cpmac: error %i registering device %s\n",
+		       rc, dev->name);
+		goto fail;
+	}
+
+	printk(KERN_INFO "cpmac: device %s (regs: %p, irq: %d, phy: %s, mac: ",
+	       dev->name, (u32 *)dev->mem_start, dev->irq,
+	       priv->phy_name);
+	for (i = 0; i < 6; i++)
+		printk("%02x%s", dev->dev_addr[i], i < 5 ? ":" : ")\n");
+
+	return 0;
+
+fail:
+	free_netdev(dev);
+	return rc;
+}
+
+static int __devexit cpmac_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	unregister_netdev(dev);
+	free_netdev(dev);
+	return 0;
+}
+
+static struct platform_driver cpmac_driver = {
+	.driver.name = "cpmac",
+	.probe = cpmac_probe,
+	.remove = cpmac_remove,
+};
+
+int __devinit cpmac_init(void)
+{
+	u32 mask;
+	int i, res;
+	cpmac_mii.priv =
+		ioremap_nocache(AR7_REGS_MDIO, sizeof(struct cpmac_mdio_regs));
+
+	if (!cpmac_mii.priv) {
+		printk(KERN_ERR "Can't ioremap mdio registers\n");
+		return -ENXIO;
+	}
+
+#warning FIXME: unhardcode gpio&reset bits
+	ar7_gpio_disable(26);
+	ar7_gpio_disable(27);
+	ar7_device_reset(AR7_RESET_BIT_CPMAC_LO);
+	ar7_device_reset(AR7_RESET_BIT_CPMAC_HI);
+	ar7_device_reset(AR7_RESET_BIT_EPHY);
+
+	cpmac_mii.reset(&cpmac_mii);
+
+	for (i = 0; i < 300000; i++) {
+		mask = ((struct cpmac_mdio_regs *)cpmac_mii.priv)->alive;
+		if (mask)
+			break;
+	}
+
+/*	mask &= 0x7fffffff;
+	if (mask & (mask - 1)) {*/
+		external_switch = 1;
+		mask = 0;
+/*	}*/
+
+	cpmac_mii.phy_mask = ~(mask | 0x80000000);
+
+	res = mdiobus_register(&cpmac_mii);
+	if (res)
+		goto fail_mii;
+
+	res = platform_driver_register(&cpmac_driver);
+	if (res)
+		goto fail_cpmac;
+
+	return 0;
+
+fail_cpmac:
+	mdiobus_unregister(&cpmac_mii);
+
+fail_mii:
+	iounmap(cpmac_mii.priv);
+
+	return res;
+}
+
+void __devexit cpmac_exit(void)
+{
+	platform_driver_unregister(&cpmac_driver);
+	mdiobus_unregister(&cpmac_mii);
+}
+
+module_init(cpmac_init);
+module_exit(cpmac_exit);
