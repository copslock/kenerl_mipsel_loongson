Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jun 2009 20:38:32 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9716 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492408AbZFWSi0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Jun 2009 20:38:26 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a4120470001>; Tue, 23 Jun 2009 14:34:47 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Jun 2009 11:34:14 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Jun 2009 11:34:14 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n5NIY9rv024085;
	Tue, 23 Jun 2009 11:34:10 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n5NIY87t024083;
	Tue, 23 Jun 2009 11:34:09 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] Staging: octeon-ethernet: Convert to use net_device_ops.
Date:	Tue, 23 Jun 2009 11:34:08 -0700
Message-Id: <1245782048-24058-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 23 Jun 2009 18:34:14.0420 (UTC) FILETIME=[3574ED40:01C9F431]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Convert the driver to use net_device_ops as it is now mandatory.

Also compensate for the removal of struct sk_buff's dst field.

The changes are mostly mechanical, the content of ethernet-common.c
was moved to ethernet.c and ethernet-common.{c,h} are removed.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Although it is a staging driver, we may want to merge it via Ralf's
tree as Octeon is a MIPS SOC.

 drivers/staging/octeon/Makefile          |    1 -
 drivers/staging/octeon/ethernet-common.c |  328 -------------------------
 drivers/staging/octeon/ethernet-common.h |   29 ---
 drivers/staging/octeon/ethernet-rgmii.c  |    9 +-
 drivers/staging/octeon/ethernet-sgmii.c  |    9 +-
 drivers/staging/octeon/ethernet-spi.c    |    1 -
 drivers/staging/octeon/ethernet-tx.c     |    6 +-
 drivers/staging/octeon/ethernet-xaui.c   |    9 +-
 drivers/staging/octeon/ethernet.c        |  383 ++++++++++++++++++++++++++++--
 drivers/staging/octeon/octeon-ethernet.h |   11 +
 10 files changed, 390 insertions(+), 396 deletions(-)
 delete mode 100644 drivers/staging/octeon/ethernet-common.c
 delete mode 100644 drivers/staging/octeon/ethernet-common.h

diff --git a/drivers/staging/octeon/Makefile b/drivers/staging/octeon/Makefile
index 3c839e3..c0a583c 100644
--- a/drivers/staging/octeon/Makefile
+++ b/drivers/staging/octeon/Makefile
@@ -12,7 +12,6 @@
 obj-${CONFIG_OCTEON_ETHERNET} :=  octeon-ethernet.o
 
 octeon-ethernet-objs := ethernet.o
-octeon-ethernet-objs += ethernet-common.o
 octeon-ethernet-objs += ethernet-mdio.o
 octeon-ethernet-objs += ethernet-mem.o
 octeon-ethernet-objs += ethernet-proc.o
diff --git a/drivers/staging/octeon/ethernet-common.c b/drivers/staging/octeon/ethernet-common.c
deleted file mode 100644
index 3e6f5b8..0000000
--- a/drivers/staging/octeon/ethernet-common.c
+++ /dev/null
@@ -1,328 +0,0 @@
-/**********************************************************************
- * Author: Cavium Networks
- *
- * Contact: support@caviumnetworks.com
- * This file is part of the OCTEON SDK
- *
- * Copyright (c) 2003-2007 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- *
- * This file is distributed in the hope that it will be useful, but
- * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
- * NONINFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- * or visit http://www.gnu.org/licenses/.
- *
- * This file may also be available under a different license from Cavium.
- * Contact Cavium Networks for more information
-**********************************************************************/
-#include <linux/kernel.h>
-#include <linux/mii.h>
-#include <net/dst.h>
-
-#include <asm/atomic.h>
-#include <asm/octeon/octeon.h>
-
-#include "ethernet-defines.h"
-#include "ethernet-tx.h"
-#include "ethernet-mdio.h"
-#include "ethernet-util.h"
-#include "octeon-ethernet.h"
-#include "ethernet-common.h"
-
-#include "cvmx-pip.h"
-#include "cvmx-pko.h"
-#include "cvmx-fau.h"
-#include "cvmx-helper.h"
-
-#include "cvmx-gmxx-defs.h"
-
-/**
- * Get the low level ethernet statistics
- *
- * @dev:    Device to get the statistics from
- * Returns Pointer to the statistics
- */
-static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
-{
-	cvmx_pip_port_status_t rx_status;
-	cvmx_pko_port_status_t tx_status;
-	struct octeon_ethernet *priv = netdev_priv(dev);
-
-	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
-		if (octeon_is_simulation()) {
-			/* The simulator doesn't support statistics */
-			memset(&rx_status, 0, sizeof(rx_status));
-			memset(&tx_status, 0, sizeof(tx_status));
-		} else {
-			cvmx_pip_get_port_status(priv->port, 1, &rx_status);
-			cvmx_pko_get_port_status(priv->port, 1, &tx_status);
-		}
-
-		priv->stats.rx_packets += rx_status.inb_packets;
-		priv->stats.tx_packets += tx_status.packets;
-		priv->stats.rx_bytes += rx_status.inb_octets;
-		priv->stats.tx_bytes += tx_status.octets;
-		priv->stats.multicast += rx_status.multicast_packets;
-		priv->stats.rx_crc_errors += rx_status.inb_errors;
-		priv->stats.rx_frame_errors += rx_status.fcs_align_err_packets;
-
-		/*
-		 * The drop counter must be incremented atomically
-		 * since the RX tasklet also increments it.
-		 */
-#ifdef CONFIG_64BIT
-		atomic64_add(rx_status.dropped_packets,
-			     (atomic64_t *)&priv->stats.rx_dropped);
-#else
-		atomic_add(rx_status.dropped_packets,
-			     (atomic_t *)&priv->stats.rx_dropped);
-#endif
-	}
-
-	return &priv->stats;
-}
-
-/**
- * Set the multicast list. Currently unimplemented.
- *
- * @dev:    Device to work on
- */
-static void cvm_oct_common_set_multicast_list(struct net_device *dev)
-{
-	union cvmx_gmxx_prtx_cfg gmx_cfg;
-	struct octeon_ethernet *priv = netdev_priv(dev);
-	int interface = INTERFACE(priv->port);
-	int index = INDEX(priv->port);
-
-	if ((interface < 2)
-	    && (cvmx_helper_interface_get_mode(interface) !=
-		CVMX_HELPER_INTERFACE_MODE_SPI)) {
-		union cvmx_gmxx_rxx_adr_ctl control;
-		control.u64 = 0;
-		control.s.bcst = 1;	/* Allow broadcast MAC addresses */
-
-		if (dev->mc_list || (dev->flags & IFF_ALLMULTI) ||
-		    (dev->flags & IFF_PROMISC))
-			/* Force accept multicast packets */
-			control.s.mcst = 2;
-		else
-			/* Force reject multicat packets */
-			control.s.mcst = 1;
-
-		if (dev->flags & IFF_PROMISC)
-			/*
-			 * Reject matches if promisc. Since CAM is
-			 * shut off, should accept everything.
-			 */
-			control.s.cam_mode = 0;
-		else
-			/* Filter packets based on the CAM */
-			control.s.cam_mode = 1;
-
-		gmx_cfg.u64 =
-		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
-		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
-			       gmx_cfg.u64 & ~1ull);
-
-		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CTL(index, interface),
-			       control.u64);
-		if (dev->flags & IFF_PROMISC)
-			cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN
-				       (index, interface), 0);
-		else
-			cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN
-				       (index, interface), 1);
-
-		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
-			       gmx_cfg.u64);
-	}
-}
-
-/**
- * Set the hardware MAC address for a device
- *
- * @dev:    Device to change the MAC address for
- * @addr:   Address structure to change it too. MAC address is addr + 2.
- * Returns Zero on success
- */
-static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
-{
-	struct octeon_ethernet *priv = netdev_priv(dev);
-	union cvmx_gmxx_prtx_cfg gmx_cfg;
-	int interface = INTERFACE(priv->port);
-	int index = INDEX(priv->port);
-
-	memcpy(dev->dev_addr, addr + 2, 6);
-
-	if ((interface < 2)
-	    && (cvmx_helper_interface_get_mode(interface) !=
-		CVMX_HELPER_INTERFACE_MODE_SPI)) {
-		int i;
-		uint8_t *ptr = addr;
-		uint64_t mac = 0;
-		for (i = 0; i < 6; i++)
-			mac = (mac << 8) | (uint64_t) (ptr[i + 2]);
-
-		gmx_cfg.u64 =
-		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
-		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
-			       gmx_cfg.u64 & ~1ull);
-
-		cvmx_write_csr(CVMX_GMXX_SMACX(index, interface), mac);
-		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM0(index, interface),
-			       ptr[2]);
-		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM1(index, interface),
-			       ptr[3]);
-		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM2(index, interface),
-			       ptr[4]);
-		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM3(index, interface),
-			       ptr[5]);
-		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM4(index, interface),
-			       ptr[6]);
-		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM5(index, interface),
-			       ptr[7]);
-		cvm_oct_common_set_multicast_list(dev);
-		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
-			       gmx_cfg.u64);
-	}
-	return 0;
-}
-
-/**
- * Change the link MTU. Unimplemented
- *
- * @dev:     Device to change
- * @new_mtu: The new MTU
- *
- * Returns Zero on success
- */
-static int cvm_oct_common_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct octeon_ethernet *priv = netdev_priv(dev);
-	int interface = INTERFACE(priv->port);
-	int index = INDEX(priv->port);
-#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
-	int vlan_bytes = 4;
-#else
-	int vlan_bytes = 0;
-#endif
-
-	/*
-	 * Limit the MTU to make sure the ethernet packets are between
-	 * 64 bytes and 65535 bytes.
-	 */
-	if ((new_mtu + 14 + 4 + vlan_bytes < 64)
-	    || (new_mtu + 14 + 4 + vlan_bytes > 65392)) {
-		pr_err("MTU must be between %d and %d.\n",
-		       64 - 14 - 4 - vlan_bytes, 65392 - 14 - 4 - vlan_bytes);
-		return -EINVAL;
-	}
-	dev->mtu = new_mtu;
-
-	if ((interface < 2)
-	    && (cvmx_helper_interface_get_mode(interface) !=
-		CVMX_HELPER_INTERFACE_MODE_SPI)) {
-		/* Add ethernet header and FCS, and VLAN if configured. */
-		int max_packet = new_mtu + 14 + 4 + vlan_bytes;
-
-		if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
-		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
-			/* Signal errors on packets larger than the MTU */
-			cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX(index, interface),
-				       max_packet);
-		} else {
-			/*
-			 * Set the hardware to truncate packets larger
-			 * than the MTU and smaller the 64 bytes.
-			 */
-			union cvmx_pip_frm_len_chkx frm_len_chk;
-			frm_len_chk.u64 = 0;
-			frm_len_chk.s.minlen = 64;
-			frm_len_chk.s.maxlen = max_packet;
-			cvmx_write_csr(CVMX_PIP_FRM_LEN_CHKX(interface),
-				       frm_len_chk.u64);
-		}
-		/*
-		 * Set the hardware to truncate packets larger than
-		 * the MTU. The jabber register must be set to a
-		 * multiple of 8 bytes, so round up.
-		 */
-		cvmx_write_csr(CVMX_GMXX_RXX_JABBER(index, interface),
-			       (max_packet + 7) & ~7u);
-	}
-	return 0;
-}
-
-/**
- * Per network device initialization
- *
- * @dev:    Device to initialize
- * Returns Zero on success
- */
-int cvm_oct_common_init(struct net_device *dev)
-{
-	static int count;
-	char mac[8] = { 0x00, 0x00,
-		octeon_bootinfo->mac_addr_base[0],
-		octeon_bootinfo->mac_addr_base[1],
-		octeon_bootinfo->mac_addr_base[2],
-		octeon_bootinfo->mac_addr_base[3],
-		octeon_bootinfo->mac_addr_base[4],
-		octeon_bootinfo->mac_addr_base[5] + count
-	};
-	struct octeon_ethernet *priv = netdev_priv(dev);
-
-	/*
-	 * Force the interface to use the POW send if always_use_pow
-	 * was specified or it is in the pow send list.
-	 */
-	if ((pow_send_group != -1)
-	    && (always_use_pow || strstr(pow_send_list, dev->name)))
-		priv->queue = -1;
-
-	if (priv->queue != -1) {
-		dev->hard_start_xmit = cvm_oct_xmit;
-		if (USE_HW_TCPUDP_CHECKSUM)
-			dev->features |= NETIF_F_IP_CSUM;
-	} else
-		dev->hard_start_xmit = cvm_oct_xmit_pow;
-	count++;
-
-	dev->get_stats = cvm_oct_common_get_stats;
-	dev->set_mac_address = cvm_oct_common_set_mac_address;
-	dev->set_multicast_list = cvm_oct_common_set_multicast_list;
-	dev->change_mtu = cvm_oct_common_change_mtu;
-	dev->do_ioctl = cvm_oct_ioctl;
-	/* We do our own locking, Linux doesn't need to */
-	dev->features |= NETIF_F_LLTX;
-	SET_ETHTOOL_OPS(dev, &cvm_oct_ethtool_ops);
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	dev->poll_controller = cvm_oct_poll_controller;
-#endif
-
-	cvm_oct_mdio_setup_device(dev);
-	dev->set_mac_address(dev, mac);
-	dev->change_mtu(dev, dev->mtu);
-
-	/*
-	 * Zero out stats for port so we won't mistakenly show
-	 * counters from the bootloader.
-	 */
-	memset(dev->get_stats(dev), 0, sizeof(struct net_device_stats));
-
-	return 0;
-}
-
-void cvm_oct_common_uninit(struct net_device *dev)
-{
-	/* Currently nothing to do */
-}
diff --git a/drivers/staging/octeon/ethernet-common.h b/drivers/staging/octeon/ethernet-common.h
deleted file mode 100644
index 2bd9cd7..0000000
--- a/drivers/staging/octeon/ethernet-common.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*********************************************************************
- * Author: Cavium Networks
- *
- * Contact: support@caviumnetworks.com
- * This file is part of the OCTEON SDK
- *
- * Copyright (c) 2003-2007 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- *
- * This file is distributed in the hope that it will be useful, but
- * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
- * NONINFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- * or visit http://www.gnu.org/licenses/.
- *
- * This file may also be available under a different license from Cavium.
- * Contact Cavium Networks for more information
-*********************************************************************/
-
-int cvm_oct_common_init(struct net_device *dev);
-void cvm_oct_common_uninit(struct net_device *dev);
diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
index 8579f16..8704133 100644
--- a/drivers/staging/octeon/ethernet-rgmii.c
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -33,7 +33,6 @@
 
 #include "ethernet-defines.h"
 #include "octeon-ethernet.h"
-#include "ethernet-common.h"
 #include "ethernet-util.h"
 
 #include "cvmx-helper.h"
@@ -265,7 +264,7 @@ static irqreturn_t cvm_oct_rgmii_rml_interrupt(int cpl, void *dev_id)
 	return return_status;
 }
 
-static int cvm_oct_rgmii_open(struct net_device *dev)
+int cvm_oct_rgmii_open(struct net_device *dev)
 {
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -286,7 +285,7 @@ static int cvm_oct_rgmii_open(struct net_device *dev)
 	return 0;
 }
 
-static int cvm_oct_rgmii_stop(struct net_device *dev)
+int cvm_oct_rgmii_stop(struct net_device *dev)
 {
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -305,9 +304,7 @@ int cvm_oct_rgmii_init(struct net_device *dev)
 	int r;
 
 	cvm_oct_common_init(dev);
-	dev->open = cvm_oct_rgmii_open;
-	dev->stop = cvm_oct_rgmii_stop;
-	dev->stop(dev);
+	dev->netdev_ops->ndo_stop(dev);
 
 	/*
 	 * Due to GMX errata in CN3XXX series chips, it is necessary
diff --git a/drivers/staging/octeon/ethernet-sgmii.c b/drivers/staging/octeon/ethernet-sgmii.c
index 58fa39c..2b54996 100644
--- a/drivers/staging/octeon/ethernet-sgmii.c
+++ b/drivers/staging/octeon/ethernet-sgmii.c
@@ -34,13 +34,12 @@
 #include "ethernet-defines.h"
 #include "octeon-ethernet.h"
 #include "ethernet-util.h"
-#include "ethernet-common.h"
 
 #include "cvmx-helper.h"
 
 #include "cvmx-gmxx-defs.h"
 
-static int cvm_oct_sgmii_open(struct net_device *dev)
+int cvm_oct_sgmii_open(struct net_device *dev)
 {
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -61,7 +60,7 @@ static int cvm_oct_sgmii_open(struct net_device *dev)
 	return 0;
 }
 
-static int cvm_oct_sgmii_stop(struct net_device *dev)
+int cvm_oct_sgmii_stop(struct net_device *dev)
 {
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -113,9 +112,7 @@ int cvm_oct_sgmii_init(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	cvm_oct_common_init(dev);
-	dev->open = cvm_oct_sgmii_open;
-	dev->stop = cvm_oct_sgmii_stop;
-	dev->stop(dev);
+	dev->netdev_ops->ndo_stop(dev);
 	if (!octeon_is_simulation())
 		priv->poll = cvm_oct_sgmii_poll;
 
diff --git a/drivers/staging/octeon/ethernet-spi.c b/drivers/staging/octeon/ethernet-spi.c
index e0971bb..66190b0 100644
--- a/drivers/staging/octeon/ethernet-spi.c
+++ b/drivers/staging/octeon/ethernet-spi.c
@@ -33,7 +33,6 @@
 
 #include "ethernet-defines.h"
 #include "octeon-ethernet.h"
-#include "ethernet-common.h"
 #include "ethernet-util.h"
 
 #include "cvmx-spi.h"
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 77b7122..bfd3dd2 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -253,10 +253,10 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/*
 	 * The skbuff will be reused without ever being freed. We must
-	 * cleanup a bunch of Linux stuff.
+	 * cleanup a bunch of core things.
 	 */
-	dst_release(skb->dst);
-	skb->dst = NULL;
+	dst_release(skb_dst(skb));
+	skb_dst_set(skb, NULL);
 #ifdef CONFIG_XFRM
 	secpath_put(skb->sp);
 	skb->sp = NULL;
diff --git a/drivers/staging/octeon/ethernet-xaui.c b/drivers/staging/octeon/ethernet-xaui.c
index f08eb32..0c2e7cc 100644
--- a/drivers/staging/octeon/ethernet-xaui.c
+++ b/drivers/staging/octeon/ethernet-xaui.c
@@ -33,14 +33,13 @@
 
 #include "ethernet-defines.h"
 #include "octeon-ethernet.h"
-#include "ethernet-common.h"
 #include "ethernet-util.h"
 
 #include "cvmx-helper.h"
 
 #include "cvmx-gmxx-defs.h"
 
-static int cvm_oct_xaui_open(struct net_device *dev)
+int cvm_oct_xaui_open(struct net_device *dev)
 {
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -60,7 +59,7 @@ static int cvm_oct_xaui_open(struct net_device *dev)
 	return 0;
 }
 
-static int cvm_oct_xaui_stop(struct net_device *dev)
+int cvm_oct_xaui_stop(struct net_device *dev)
 {
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -112,9 +111,7 @@ int cvm_oct_xaui_init(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	cvm_oct_common_init(dev);
-	dev->open = cvm_oct_xaui_open;
-	dev->stop = cvm_oct_xaui_stop;
-	dev->stop(dev);
+	dev->netdev_ops->ndo_stop(dev);
 	if (!octeon_is_simulation())
 		priv->poll = cvm_oct_xaui_poll;
 
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index e8ef9e0..2d9356d 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -40,9 +40,9 @@
 #include "ethernet-mem.h"
 #include "ethernet-rx.h"
 #include "ethernet-tx.h"
+#include "ethernet-mdio.h"
 #include "ethernet-util.h"
 #include "ethernet-proc.h"
-#include "ethernet-common.h"
 #include "octeon-ethernet.h"
 
 #include "cvmx-pip.h"
@@ -51,6 +51,7 @@
 #include "cvmx-ipd.h"
 #include "cvmx-helper.h"
 
+#include "cvmx-gmxx-defs.h"
 #include "cvmx-smix-defs.h"
 
 #if defined(CONFIG_CAVIUM_OCTEON_NUM_PACKET_BUFFERS) \
@@ -164,7 +165,7 @@ static void cvm_do_timer(unsigned long arg)
 						    lock);
 				}
 			}
-			cvm_oct_device[port]->get_stats(cvm_oct_device[port]);
+			cvm_oct_device[port]->netdev_ops->ndo_get_stats(cvm_oct_device[port]);
 		}
 		port++;
 		/* Poll the next port in a 50th of a second.
@@ -246,6 +247,362 @@ int cvm_oct_free_work(void *work_queue_entry)
 EXPORT_SYMBOL(cvm_oct_free_work);
 
 /**
+ * Get the low level ethernet statistics
+ *
+ * @dev:    Device to get the statistics from
+ * Returns Pointer to the statistics
+ */
+static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
+{
+	cvmx_pip_port_status_t rx_status;
+	cvmx_pko_port_status_t tx_status;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+
+	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
+		if (octeon_is_simulation()) {
+			/* The simulator doesn't support statistics */
+			memset(&rx_status, 0, sizeof(rx_status));
+			memset(&tx_status, 0, sizeof(tx_status));
+		} else {
+			cvmx_pip_get_port_status(priv->port, 1, &rx_status);
+			cvmx_pko_get_port_status(priv->port, 1, &tx_status);
+		}
+
+		priv->stats.rx_packets += rx_status.inb_packets;
+		priv->stats.tx_packets += tx_status.packets;
+		priv->stats.rx_bytes += rx_status.inb_octets;
+		priv->stats.tx_bytes += tx_status.octets;
+		priv->stats.multicast += rx_status.multicast_packets;
+		priv->stats.rx_crc_errors += rx_status.inb_errors;
+		priv->stats.rx_frame_errors += rx_status.fcs_align_err_packets;
+
+		/*
+		 * The drop counter must be incremented atomically
+		 * since the RX tasklet also increments it.
+		 */
+#ifdef CONFIG_64BIT
+		atomic64_add(rx_status.dropped_packets,
+			     (atomic64_t *)&priv->stats.rx_dropped);
+#else
+		atomic_add(rx_status.dropped_packets,
+			     (atomic_t *)&priv->stats.rx_dropped);
+#endif
+	}
+
+	return &priv->stats;
+}
+
+/**
+ * Change the link MTU. Unimplemented
+ *
+ * @dev:     Device to change
+ * @new_mtu: The new MTU
+ *
+ * Returns Zero on success
+ */
+static int cvm_oct_common_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	int vlan_bytes = 4;
+#else
+	int vlan_bytes = 0;
+#endif
+
+	/*
+	 * Limit the MTU to make sure the ethernet packets are between
+	 * 64 bytes and 65535 bytes.
+	 */
+	if ((new_mtu + 14 + 4 + vlan_bytes < 64)
+	    || (new_mtu + 14 + 4 + vlan_bytes > 65392)) {
+		pr_err("MTU must be between %d and %d.\n",
+		       64 - 14 - 4 - vlan_bytes, 65392 - 14 - 4 - vlan_bytes);
+		return -EINVAL;
+	}
+	dev->mtu = new_mtu;
+
+	if ((interface < 2)
+	    && (cvmx_helper_interface_get_mode(interface) !=
+		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+		/* Add ethernet header and FCS, and VLAN if configured. */
+		int max_packet = new_mtu + 14 + 4 + vlan_bytes;
+
+		if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
+		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+			/* Signal errors on packets larger than the MTU */
+			cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX(index, interface),
+				       max_packet);
+		} else {
+			/*
+			 * Set the hardware to truncate packets larger
+			 * than the MTU and smaller the 64 bytes.
+			 */
+			union cvmx_pip_frm_len_chkx frm_len_chk;
+			frm_len_chk.u64 = 0;
+			frm_len_chk.s.minlen = 64;
+			frm_len_chk.s.maxlen = max_packet;
+			cvmx_write_csr(CVMX_PIP_FRM_LEN_CHKX(interface),
+				       frm_len_chk.u64);
+		}
+		/*
+		 * Set the hardware to truncate packets larger than
+		 * the MTU. The jabber register must be set to a
+		 * multiple of 8 bytes, so round up.
+		 */
+		cvmx_write_csr(CVMX_GMXX_RXX_JABBER(index, interface),
+			       (max_packet + 7) & ~7u);
+	}
+	return 0;
+}
+
+/**
+ * Set the multicast list. Currently unimplemented.
+ *
+ * @dev:    Device to work on
+ */
+static void cvm_oct_common_set_multicast_list(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	if ((interface < 2)
+	    && (cvmx_helper_interface_get_mode(interface) !=
+		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+		union cvmx_gmxx_rxx_adr_ctl control;
+		control.u64 = 0;
+		control.s.bcst = 1;	/* Allow broadcast MAC addresses */
+
+		if (dev->mc_list || (dev->flags & IFF_ALLMULTI) ||
+		    (dev->flags & IFF_PROMISC))
+			/* Force accept multicast packets */
+			control.s.mcst = 2;
+		else
+			/* Force reject multicat packets */
+			control.s.mcst = 1;
+
+		if (dev->flags & IFF_PROMISC)
+			/*
+			 * Reject matches if promisc. Since CAM is
+			 * shut off, should accept everything.
+			 */
+			control.s.cam_mode = 0;
+		else
+			/* Filter packets based on the CAM */
+			control.s.cam_mode = 1;
+
+		gmx_cfg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmx_cfg.u64 & ~1ull);
+
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CTL(index, interface),
+			       control.u64);
+		if (dev->flags & IFF_PROMISC)
+			cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN
+				       (index, interface), 0);
+		else
+			cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN
+				       (index, interface), 1);
+
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmx_cfg.u64);
+	}
+}
+
+/**
+ * Set the hardware MAC address for a device
+ *
+ * @dev:    Device to change the MAC address for
+ * @addr:   Address structure to change it too. MAC address is addr + 2.
+ * Returns Zero on success
+ */
+static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	memcpy(dev->dev_addr, addr + 2, 6);
+
+	if ((interface < 2)
+	    && (cvmx_helper_interface_get_mode(interface) !=
+		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+		int i;
+		uint8_t *ptr = addr;
+		uint64_t mac = 0;
+		for (i = 0; i < 6; i++)
+			mac = (mac << 8) | (uint64_t) (ptr[i + 2]);
+
+		gmx_cfg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmx_cfg.u64 & ~1ull);
+
+		cvmx_write_csr(CVMX_GMXX_SMACX(index, interface), mac);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM0(index, interface),
+			       ptr[2]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM1(index, interface),
+			       ptr[3]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM2(index, interface),
+			       ptr[4]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM3(index, interface),
+			       ptr[5]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM4(index, interface),
+			       ptr[6]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM5(index, interface),
+			       ptr[7]);
+		cvm_oct_common_set_multicast_list(dev);
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmx_cfg.u64);
+	}
+	return 0;
+}
+
+/**
+ * Per network device initialization
+ *
+ * @dev:    Device to initialize
+ * Returns Zero on success
+ */
+int cvm_oct_common_init(struct net_device *dev)
+{
+	static int count;
+	char mac[8] = { 0x00, 0x00,
+		octeon_bootinfo->mac_addr_base[0],
+		octeon_bootinfo->mac_addr_base[1],
+		octeon_bootinfo->mac_addr_base[2],
+		octeon_bootinfo->mac_addr_base[3],
+		octeon_bootinfo->mac_addr_base[4],
+		octeon_bootinfo->mac_addr_base[5] + count
+	};
+	struct octeon_ethernet *priv = netdev_priv(dev);
+
+	/*
+	 * Force the interface to use the POW send if always_use_pow
+	 * was specified or it is in the pow send list.
+	 */
+	if ((pow_send_group != -1)
+	    && (always_use_pow || strstr(pow_send_list, dev->name)))
+		priv->queue = -1;
+
+	if (priv->queue != -1 && USE_HW_TCPUDP_CHECKSUM)
+		dev->features |= NETIF_F_IP_CSUM;
+
+	count++;
+
+	/* We do our own locking, Linux doesn't need to */
+	dev->features |= NETIF_F_LLTX;
+	SET_ETHTOOL_OPS(dev, &cvm_oct_ethtool_ops);
+
+	cvm_oct_mdio_setup_device(dev);
+	dev->netdev_ops->ndo_set_mac_address(dev, mac);
+	dev->netdev_ops->ndo_change_mtu(dev, dev->mtu);
+
+	/*
+	 * Zero out stats for port so we won't mistakenly show
+	 * counters from the bootloader.
+	 */
+	memset(dev->netdev_ops->ndo_get_stats(dev), 0,
+	       sizeof(struct net_device_stats));
+
+	return 0;
+}
+
+void cvm_oct_common_uninit(struct net_device *dev)
+{
+	/* Currently nothing to do */
+}
+
+static const struct net_device_ops cvm_oct_npi_netdev_ops = {
+	.ndo_init		= cvm_oct_common_init,
+	.ndo_uninit		= cvm_oct_common_uninit,
+	.ndo_start_xmit		= cvm_oct_xmit,
+	.ndo_set_multicast_list	= cvm_oct_common_set_multicast_list,
+	.ndo_set_mac_address	= cvm_oct_common_set_mac_address,
+	.ndo_do_ioctl		= cvm_oct_ioctl,
+	.ndo_change_mtu		= cvm_oct_common_change_mtu,
+	.ndo_get_stats		= cvm_oct_common_get_stats,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= cvm_oct_poll_controller,
+#endif
+};
+static const struct net_device_ops cvm_oct_xaui_netdev_ops = {
+	.ndo_init		= cvm_oct_xaui_init,
+	.ndo_uninit		= cvm_oct_xaui_uninit,
+	.ndo_open		= cvm_oct_xaui_open,
+	.ndo_stop		= cvm_oct_xaui_stop,
+	.ndo_start_xmit		= cvm_oct_xmit,
+	.ndo_set_multicast_list	= cvm_oct_common_set_multicast_list,
+	.ndo_set_mac_address	= cvm_oct_common_set_mac_address,
+	.ndo_do_ioctl		= cvm_oct_ioctl,
+	.ndo_change_mtu		= cvm_oct_common_change_mtu,
+	.ndo_get_stats		= cvm_oct_common_get_stats,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= cvm_oct_poll_controller,
+#endif
+};
+static const struct net_device_ops cvm_oct_sgmii_netdev_ops = {
+	.ndo_init		= cvm_oct_sgmii_init,
+	.ndo_uninit		= cvm_oct_sgmii_uninit,
+	.ndo_open		= cvm_oct_sgmii_open,
+	.ndo_stop		= cvm_oct_sgmii_stop,
+	.ndo_start_xmit		= cvm_oct_xmit,
+	.ndo_set_multicast_list	= cvm_oct_common_set_multicast_list,
+	.ndo_set_mac_address	= cvm_oct_common_set_mac_address,
+	.ndo_do_ioctl		= cvm_oct_ioctl,
+	.ndo_change_mtu		= cvm_oct_common_change_mtu,
+	.ndo_get_stats		= cvm_oct_common_get_stats,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= cvm_oct_poll_controller,
+#endif
+};
+static const struct net_device_ops cvm_oct_spi_netdev_ops = {
+	.ndo_init		= cvm_oct_spi_init,
+	.ndo_uninit		= cvm_oct_spi_uninit,
+	.ndo_start_xmit		= cvm_oct_xmit,
+	.ndo_set_multicast_list	= cvm_oct_common_set_multicast_list,
+	.ndo_set_mac_address	= cvm_oct_common_set_mac_address,
+	.ndo_do_ioctl		= cvm_oct_ioctl,
+	.ndo_change_mtu		= cvm_oct_common_change_mtu,
+	.ndo_get_stats		= cvm_oct_common_get_stats,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= cvm_oct_poll_controller,
+#endif
+};
+static const struct net_device_ops cvm_oct_rgmii_netdev_ops = {
+	.ndo_init		= cvm_oct_rgmii_init,
+	.ndo_uninit		= cvm_oct_rgmii_uninit,
+	.ndo_open		= cvm_oct_rgmii_open,
+	.ndo_stop		= cvm_oct_rgmii_stop,
+	.ndo_start_xmit		= cvm_oct_xmit,
+	.ndo_set_multicast_list	= cvm_oct_common_set_multicast_list,
+	.ndo_set_mac_address	= cvm_oct_common_set_mac_address,
+	.ndo_do_ioctl		= cvm_oct_ioctl,
+	.ndo_change_mtu		= cvm_oct_common_change_mtu,
+	.ndo_get_stats		= cvm_oct_common_get_stats,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= cvm_oct_poll_controller,
+#endif
+};
+static const struct net_device_ops cvm_oct_pow_netdev_ops = {
+	.ndo_init		= cvm_oct_common_init,
+	.ndo_start_xmit		= cvm_oct_xmit_pow,
+	.ndo_set_multicast_list	= cvm_oct_common_set_multicast_list,
+	.ndo_set_mac_address	= cvm_oct_common_set_mac_address,
+	.ndo_do_ioctl		= cvm_oct_ioctl,
+	.ndo_change_mtu		= cvm_oct_common_change_mtu,
+	.ndo_get_stats		= cvm_oct_common_get_stats,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= cvm_oct_poll_controller,
+#endif
+};
+
+/**
  * Module/ driver initialization. Creates the linux network
  * devices.
  *
@@ -303,7 +660,7 @@ static int __init cvm_oct_init_module(void)
 			struct octeon_ethernet *priv = netdev_priv(dev);
 			memset(priv, 0, sizeof(struct octeon_ethernet));
 
-			dev->init = cvm_oct_common_init;
+			dev->netdev_ops = &cvm_oct_pow_netdev_ops;
 			priv->imode = CVMX_HELPER_INTERFACE_MODE_DISABLED;
 			priv->port = CVMX_PIP_NUM_INPUT_PORTS;
 			priv->queue = -1;
@@ -372,44 +729,38 @@ static int __init cvm_oct_init_module(void)
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_NPI:
-				dev->init = cvm_oct_common_init;
-				dev->uninit = cvm_oct_common_uninit;
+				dev->netdev_ops = &cvm_oct_npi_netdev_ops;
 				strcpy(dev->name, "npi%d");
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_XAUI:
-				dev->init = cvm_oct_xaui_init;
-				dev->uninit = cvm_oct_xaui_uninit;
+				dev->netdev_ops = &cvm_oct_xaui_netdev_ops;
 				strcpy(dev->name, "xaui%d");
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_LOOP:
-				dev->init = cvm_oct_common_init;
-				dev->uninit = cvm_oct_common_uninit;
+				dev->netdev_ops = &cvm_oct_npi_netdev_ops;
 				strcpy(dev->name, "loop%d");
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_SGMII:
-				dev->init = cvm_oct_sgmii_init;
-				dev->uninit = cvm_oct_sgmii_uninit;
+				dev->netdev_ops = &cvm_oct_sgmii_netdev_ops;
 				strcpy(dev->name, "eth%d");
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_SPI:
-				dev->init = cvm_oct_spi_init;
-				dev->uninit = cvm_oct_spi_uninit;
+				dev->netdev_ops = &cvm_oct_spi_netdev_ops;
 				strcpy(dev->name, "spi%d");
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_RGMII:
 			case CVMX_HELPER_INTERFACE_MODE_GMII:
-				dev->init = cvm_oct_rgmii_init;
-				dev->uninit = cvm_oct_rgmii_uninit;
+				dev->netdev_ops = &cvm_oct_rgmii_netdev_ops;
 				strcpy(dev->name, "eth%d");
 				break;
 			}
 
-			if (!dev->init) {
+			if (!dev->netdev_ops) {
 				kfree(dev);
 			} else if (register_netdev(dev) < 0) {
 				pr_err("Failed to register ethernet device "
diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index b319907..3aef987 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -111,12 +111,23 @@ static inline int cvm_oct_transmit(struct net_device *dev,
 
 extern int cvm_oct_rgmii_init(struct net_device *dev);
 extern void cvm_oct_rgmii_uninit(struct net_device *dev);
+extern int cvm_oct_rgmii_open(struct net_device *dev);
+extern int cvm_oct_rgmii_stop(struct net_device *dev);
+
 extern int cvm_oct_sgmii_init(struct net_device *dev);
 extern void cvm_oct_sgmii_uninit(struct net_device *dev);
+extern int cvm_oct_sgmii_open(struct net_device *dev);
+extern int cvm_oct_sgmii_stop(struct net_device *dev);
+
 extern int cvm_oct_spi_init(struct net_device *dev);
 extern void cvm_oct_spi_uninit(struct net_device *dev);
 extern int cvm_oct_xaui_init(struct net_device *dev);
 extern void cvm_oct_xaui_uninit(struct net_device *dev);
+extern int cvm_oct_xaui_open(struct net_device *dev);
+extern int cvm_oct_xaui_stop(struct net_device *dev);
+
+extern int cvm_oct_common_init(struct net_device *dev);
+extern void cvm_oct_common_uninit(struct net_device *dev);
 
 extern int always_use_pow;
 extern int pow_send_group;
-- 
1.6.0.6
