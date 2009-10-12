Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 21:04:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14538 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493333AbZJLTEu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Oct 2009 21:04:50 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad37dc20000>; Mon, 12 Oct 2009 12:04:34 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Oct 2009 12:04:37 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Oct 2009 12:04:36 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n9CJ4YQS000316;
	Mon, 12 Oct 2009 12:04:34 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n9CJ4W42000314;
	Mon, 12 Oct 2009 12:04:32 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] Staging: octeon-ethernet: Assign proper MAC addresses.
Date:	Mon, 12 Oct 2009 12:04:32 -0700
Message-Id: <1255374272-32757-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 12 Oct 2009 19:04:36.0948 (UTC) FILETIME=[D79EE140:01CA4B6E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Allocate MAC addresses using the same method as the bootloader.  This
avoids changing the MAC between bootloader and kernel operation as
well as avoiding duplicates and use of addresses outside of the
assigned range.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

This could merge via Ralf's tree as Octeon is MIPS based and all the
rest of the Octeon patches seem to be going in this way.

 drivers/staging/octeon/ethernet.c |   53 ++++++++++++++++++++++++++++--------
 1 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index b847951..492c502 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -111,6 +111,16 @@ MODULE_PARM_DESC(disable_core_queueing, "\n"
 	"\tallows packets to be sent without lock contention in the packet\n"
 	"\tscheduler resulting in some cases in improved throughput.\n");
 
+
+/*
+ * The offset from mac_addr_base that should be used for the next port
+ * that is configured.  By convention, if any mgmt ports exist on the
+ * chip, they get the first mac addresses, The ports controlled by
+ * this driver are numbered sequencially following any mgmt addresses
+ * that may exist.
+ */
+static unsigned int cvm_oct_mac_addr_offset;
+
 /**
  * Periodic timer to check auto negotiation
  */
@@ -474,16 +484,30 @@ static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
  */
 int cvm_oct_common_init(struct net_device *dev)
 {
-	static int count;
-	char mac[8] = { 0x00, 0x00,
-		octeon_bootinfo->mac_addr_base[0],
-		octeon_bootinfo->mac_addr_base[1],
-		octeon_bootinfo->mac_addr_base[2],
-		octeon_bootinfo->mac_addr_base[3],
-		octeon_bootinfo->mac_addr_base[4],
-		octeon_bootinfo->mac_addr_base[5] + count
-	};
 	struct octeon_ethernet *priv = netdev_priv(dev);
+	struct sockaddr sa;
+	u64 mac = ((u64)(octeon_bootinfo->mac_addr_base[0] & 0xff) << 40) |
+		((u64)(octeon_bootinfo->mac_addr_base[1] & 0xff) << 32) |
+		((u64)(octeon_bootinfo->mac_addr_base[2] & 0xff) << 24) |
+		((u64)(octeon_bootinfo->mac_addr_base[3] & 0xff) << 16) |
+		((u64)(octeon_bootinfo->mac_addr_base[4] & 0xff) << 8) |
+		(u64)(octeon_bootinfo->mac_addr_base[5] & 0xff);
+
+	mac += cvm_oct_mac_addr_offset;
+	sa.sa_data[0] = (mac >> 40) & 0xff;
+	sa.sa_data[1] = (mac >> 32) & 0xff;
+	sa.sa_data[2] = (mac >> 24) & 0xff;
+	sa.sa_data[3] = (mac >> 16) & 0xff;
+	sa.sa_data[4] = (mac >> 8) & 0xff;
+	sa.sa_data[5] = mac & 0xff;
+
+	if (cvm_oct_mac_addr_offset >= octeon_bootinfo->mac_addr_count)
+		printk(KERN_DEBUG "%s: Using MAC outside of the assigned range:"
+			" %02x:%02x:%02x:%02x:%02x:%02x\n", dev->name,
+			sa.sa_data[0] & 0xff, sa.sa_data[1] & 0xff,
+			sa.sa_data[2] & 0xff, sa.sa_data[3] & 0xff,
+			sa.sa_data[4] & 0xff, sa.sa_data[5] & 0xff);
+	cvm_oct_mac_addr_offset++;
 
 	/*
 	 * Force the interface to use the POW send if always_use_pow
@@ -496,14 +520,12 @@ int cvm_oct_common_init(struct net_device *dev)
 	if (priv->queue != -1 && USE_HW_TCPUDP_CHECKSUM)
 		dev->features |= NETIF_F_IP_CSUM;
 
-	count++;
-
 	/* We do our own locking, Linux doesn't need to */
 	dev->features |= NETIF_F_LLTX;
 	SET_ETHTOOL_OPS(dev, &cvm_oct_ethtool_ops);
 
 	cvm_oct_mdio_setup_device(dev);
-	dev->netdev_ops->ndo_set_mac_address(dev, mac);
+	dev->netdev_ops->ndo_set_mac_address(dev, &sa);
 	dev->netdev_ops->ndo_change_mtu(dev, dev->mtu);
 
 	/*
@@ -620,6 +642,13 @@ static int __init cvm_oct_init_module(void)
 
 	pr_notice("cavium-ethernet %s\n", OCTEON_ETHERNET_VERSION);
 
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX))
+		cvm_oct_mac_addr_offset = 2; /* First two are the mgmt ports. */
+	else if (OCTEON_IS_MODEL(OCTEON_CN56XX))
+		cvm_oct_mac_addr_offset = 1; /* First one is the mgmt port. */
+	else
+		cvm_oct_mac_addr_offset = 0;
+
 	cvm_oct_proc_initialize();
 	cvm_oct_rx_initialize();
 	cvm_oct_configure_common_hw();
-- 
1.6.0.6
