Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 01:30:34 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:65364 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903745Ab2FFX2r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 01:28:47 +0200
Received: by dadm1 with SMTP id m1so8217dad.36
        for <multiple recipients>; Wed, 06 Jun 2012 16:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hYzmn/lg6zEaTJ+EEmzo2r4qgpGCRPzAVPa9Wisq/KA=;
        b=b8a7gbfI2itWHOzzgbD8pmYlkQ/MjeX9rwxWePhytIXIKdC7fTNvYuxQ8fgpFPhG8P
         k7paYdjN11Rjp7zO9zcUgEQf228kIne7YE61ms+DmruHI4x+zYdGjtJAwdKhkIeK79k6
         1hrTo0R6DIDhU/sVjxJcpv62mQ1iBuoXFWXUQ1HBg4dlV9L5/LD1c1XTBFjP6ToMvcbC
         QiDe/K9cTYo14JkJLI3YvYKEbK5D904PXcdXkXMaK00UYRuWM6+nePr10UoCCAyrAs3e
         3dnOssgt8IAVm94+XTpKH4VsFsRL315F0HYVnVWvbiuMHhxX5azjKNBNw5cUENCNpMMy
         t87w==
Received: by 10.68.116.203 with SMTP id jy11mr1336116pbb.129.1339025320787;
        Wed, 06 Jun 2012 16:28:40 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id vp4sm1887104pbc.61.2012.06.06.16.28.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 16:28:38 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56NSbR3024266;
        Wed, 6 Jun 2012 16:28:37 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56NSbI0024265;
        Wed, 6 Jun 2012 16:28:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 3/5] netdev: octeon_mgmt: Convert to use device tree.
Date:   Wed,  6 Jun 2012 16:28:32 -0700
Message-Id: <1339025314-24216-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1339025314-24216-1-git-send-email-ddaney.cavm@gmail.com>
References: <1339025314-24216-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The device tree will supply the register bank base addresses, make
register addressing relative to those.  PHY connection is now
described by the device tree.

The OCTEON_IRQ_MII{0,1} symbols are also removed as they are now
unused and interfere with the irq_domain used for device tree irq
mapping.

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c      |    2 -
 arch/mips/cavium-octeon/octeon-platform.c |   62 ------
 drivers/net/ethernet/octeon/octeon_mgmt.c |  312 +++++++++++++++++++----------
 3 files changed, 207 insertions(+), 169 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 2a661ad..5fb76aa 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1197,7 +1197,6 @@ static void __init octeon_irq_init_ciu(void)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip, handle_edge_irq);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB0, 0, 56, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII0, 0, 62, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_BOOTDMA, 0, 63, chip, handle_level_irq);
 
 	/* CIU_1 */
@@ -1206,7 +1205,6 @@ static void __init octeon_irq_init_ciu(void)
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART2, 1, 16, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB1, 1, 17, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII1, 1, 18, chip, handle_level_irq);
 
 	gpio_node = of_find_compatible_node(NULL, NULL, "cavium,octeon-3860-gpio");
 	if (gpio_node) {
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 66cabc2..0938df1 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -168,68 +168,6 @@ out:
 }
 device_initcall(octeon_rng_device_init);
 
-/* Octeon mgmt port Ethernet interface.  */
-static int __init octeon_mgmt_device_init(void)
-{
-	struct platform_device *pd;
-	int ret = 0;
-	int port, num_ports;
-
-	struct resource mgmt_port_resource = {
-		.flags	= IORESOURCE_IRQ,
-		.start	= -1,
-		.end	= -1
-	};
-
-	if (!OCTEON_IS_MODEL(OCTEON_CN56XX) && !OCTEON_IS_MODEL(OCTEON_CN52XX))
-		return 0;
-
-	if (OCTEON_IS_MODEL(OCTEON_CN56XX))
-		num_ports = 1;
-	else
-		num_ports = 2;
-
-	for (port = 0; port < num_ports; port++) {
-		pd = platform_device_alloc("octeon_mgmt", port);
-		if (!pd) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		/* No DMA restrictions */
-		pd->dev.coherent_dma_mask = DMA_BIT_MASK(64);
-		pd->dev.dma_mask = &pd->dev.coherent_dma_mask;
-
-		switch (port) {
-		case 0:
-			mgmt_port_resource.start = OCTEON_IRQ_MII0;
-			break;
-		case 1:
-			mgmt_port_resource.start = OCTEON_IRQ_MII1;
-			break;
-		default:
-			BUG();
-		}
-		mgmt_port_resource.end = mgmt_port_resource.start;
-
-		ret = platform_device_add_resources(pd, &mgmt_port_resource, 1);
-
-		if (ret)
-			goto fail;
-
-		ret = platform_device_add(pd);
-		if (ret)
-			goto fail;
-	}
-	return ret;
-fail:
-	platform_device_put(pd);
-
-out:
-	return ret;
-
-}
-device_initcall(octeon_mgmt_device_init);
-
 #ifdef CONFIG_USB
 
 static int __init octeon_ehci_device_init(void)
diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index cd827ff..c42bbb1 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -6,19 +6,21 @@
  * Copyright (C) 2009 Cavium Networks
  */
 
-#include <linux/capability.h>
+#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/module.h>
+#include <linux/etherdevice.h>
+#include <linux/capability.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>
 #include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/if.h>
+#include <linux/spinlock.h>
 #include <linux/if_vlan.h>
+#include <linux/of_mdio.h>
+#include <linux/module.h>
+#include <linux/of_net.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/phy.h>
-#include <linux/spinlock.h>
+#include <linux/io.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-mixx-defs.h>
@@ -58,8 +60,56 @@ union mgmt_port_ring_entry {
 	} s;
 };
 
+#define MIX_ORING1	0x0
+#define MIX_ORING2	0x8
+#define MIX_IRING1	0x10
+#define MIX_IRING2	0x18
+#define MIX_CTL		0x20
+#define MIX_IRHWM	0x28
+#define MIX_IRCNT	0x30
+#define MIX_ORHWM	0x38
+#define MIX_ORCNT	0x40
+#define MIX_ISR		0x48
+#define MIX_INTENA	0x50
+#define MIX_REMCNT	0x58
+#define MIX_BIST	0x78
+
+#define AGL_GMX_PRT_CFG			0x10
+#define AGL_GMX_RX_FRM_CTL		0x18
+#define AGL_GMX_RX_FRM_MAX		0x30
+#define AGL_GMX_RX_JABBER		0x38
+#define AGL_GMX_RX_STATS_CTL		0x50
+
+#define AGL_GMX_RX_STATS_PKTS_DRP	0xb0
+#define AGL_GMX_RX_STATS_OCTS_DRP	0xb8
+#define AGL_GMX_RX_STATS_PKTS_BAD	0xc0
+
+#define AGL_GMX_RX_ADR_CTL		0x100
+#define AGL_GMX_RX_ADR_CAM_EN		0x108
+#define AGL_GMX_RX_ADR_CAM0		0x180
+#define AGL_GMX_RX_ADR_CAM1		0x188
+#define AGL_GMX_RX_ADR_CAM2		0x190
+#define AGL_GMX_RX_ADR_CAM3		0x198
+#define AGL_GMX_RX_ADR_CAM4		0x1a0
+#define AGL_GMX_RX_ADR_CAM5		0x1a8
+
+#define AGL_GMX_TX_STATS_CTL		0x268
+#define AGL_GMX_TX_CTL			0x270
+#define AGL_GMX_TX_STAT0		0x280
+#define AGL_GMX_TX_STAT1		0x288
+#define AGL_GMX_TX_STAT2		0x290
+#define AGL_GMX_TX_STAT3		0x298
+#define AGL_GMX_TX_STAT4		0x2a0
+#define AGL_GMX_TX_STAT5		0x2a8
+#define AGL_GMX_TX_STAT6		0x2b0
+#define AGL_GMX_TX_STAT7		0x2b8
+#define AGL_GMX_TX_STAT8		0x2c0
+#define AGL_GMX_TX_STAT9		0x2c8
+
 struct octeon_mgmt {
 	struct net_device *netdev;
+	u64 mix;
+	u64 agl;
 	int port;
 	int irq;
 	u64 *tx_ring;
@@ -85,31 +135,34 @@ struct octeon_mgmt {
 	struct napi_struct napi;
 	struct tasklet_struct tx_clean_tasklet;
 	struct phy_device *phydev;
+	struct device_node *phy_np;
+	resource_size_t mix_phys;
+	resource_size_t mix_size;
+	resource_size_t agl_phys;
+	resource_size_t agl_size;
 };
 
 static void octeon_mgmt_set_rx_irq(struct octeon_mgmt *p, int enable)
 {
-	int port = p->port;
 	union cvmx_mixx_intena mix_intena;
 	unsigned long flags;
 
 	spin_lock_irqsave(&p->lock, flags);
-	mix_intena.u64 = cvmx_read_csr(CVMX_MIXX_INTENA(port));
+	mix_intena.u64 = cvmx_read_csr(p->mix + MIX_INTENA);
 	mix_intena.s.ithena = enable ? 1 : 0;
-	cvmx_write_csr(CVMX_MIXX_INTENA(port), mix_intena.u64);
+	cvmx_write_csr(p->mix + MIX_INTENA, mix_intena.u64);
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static void octeon_mgmt_set_tx_irq(struct octeon_mgmt *p, int enable)
 {
-	int port = p->port;
 	union cvmx_mixx_intena mix_intena;
 	unsigned long flags;
 
 	spin_lock_irqsave(&p->lock, flags);
-	mix_intena.u64 = cvmx_read_csr(CVMX_MIXX_INTENA(port));
+	mix_intena.u64 = cvmx_read_csr(p->mix + MIX_INTENA);
 	mix_intena.s.othena = enable ? 1 : 0;
-	cvmx_write_csr(CVMX_MIXX_INTENA(port), mix_intena.u64);
+	cvmx_write_csr(p->mix + MIX_INTENA, mix_intena.u64);
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
@@ -146,7 +199,6 @@ static unsigned int ring_size_to_bytes(unsigned int ring_size)
 static void octeon_mgmt_rx_fill_ring(struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 
 	while (p->rx_current_fill < ring_max_fill(OCTEON_MGMT_RX_RING_SIZE)) {
 		unsigned int size;
@@ -177,24 +229,23 @@ static void octeon_mgmt_rx_fill_ring(struct net_device *netdev)
 			(p->rx_next_fill + 1) % OCTEON_MGMT_RX_RING_SIZE;
 		p->rx_current_fill++;
 		/* Ring the bell.  */
-		cvmx_write_csr(CVMX_MIXX_IRING2(port), 1);
+		cvmx_write_csr(p->mix + MIX_IRING2, 1);
 	}
 }
 
 static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 {
-	int port = p->port;
 	union cvmx_mixx_orcnt mix_orcnt;
 	union mgmt_port_ring_entry re;
 	struct sk_buff *skb;
 	int cleaned = 0;
 	unsigned long flags;
 
-	mix_orcnt.u64 = cvmx_read_csr(CVMX_MIXX_ORCNT(port));
+	mix_orcnt.u64 = cvmx_read_csr(p->mix + MIX_ORCNT);
 	while (mix_orcnt.s.orcnt) {
 		spin_lock_irqsave(&p->tx_list.lock, flags);
 
-		mix_orcnt.u64 = cvmx_read_csr(CVMX_MIXX_ORCNT(port));
+		mix_orcnt.u64 = cvmx_read_csr(p->mix + MIX_ORCNT);
 
 		if (mix_orcnt.s.orcnt == 0) {
 			spin_unlock_irqrestore(&p->tx_list.lock, flags);
@@ -214,7 +265,7 @@ static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 		mix_orcnt.s.orcnt = 1;
 
 		/* Acknowledge to hardware that we have the buffer.  */
-		cvmx_write_csr(CVMX_MIXX_ORCNT(port), mix_orcnt.u64);
+		cvmx_write_csr(p->mix + MIX_ORCNT, mix_orcnt.u64);
 		p->tx_current_fill--;
 
 		spin_unlock_irqrestore(&p->tx_list.lock, flags);
@@ -224,7 +275,7 @@ static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 		dev_kfree_skb_any(skb);
 		cleaned++;
 
-		mix_orcnt.u64 = cvmx_read_csr(CVMX_MIXX_ORCNT(port));
+		mix_orcnt.u64 = cvmx_read_csr(p->mix + MIX_ORCNT);
 	}
 
 	if (cleaned && netif_queue_stopped(p->netdev))
@@ -241,13 +292,12 @@ static void octeon_mgmt_clean_tx_tasklet(unsigned long arg)
 static void octeon_mgmt_update_rx_stats(struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 	unsigned long flags;
 	u64 drop, bad;
 
 	/* These reads also clear the count registers.  */
-	drop = cvmx_read_csr(CVMX_AGL_GMX_RXX_STATS_PKTS_DRP(port));
-	bad = cvmx_read_csr(CVMX_AGL_GMX_RXX_STATS_PKTS_BAD(port));
+	drop = cvmx_read_csr(p->agl + AGL_GMX_RX_STATS_PKTS_DRP);
+	bad = cvmx_read_csr(p->agl + AGL_GMX_RX_STATS_PKTS_BAD);
 
 	if (drop || bad) {
 		/* Do an atomic update. */
@@ -261,15 +311,14 @@ static void octeon_mgmt_update_rx_stats(struct net_device *netdev)
 static void octeon_mgmt_update_tx_stats(struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 	unsigned long flags;
 
 	union cvmx_agl_gmx_txx_stat0 s0;
 	union cvmx_agl_gmx_txx_stat1 s1;
 
 	/* These reads also clear the count registers.  */
-	s0.u64 = cvmx_read_csr(CVMX_AGL_GMX_TXX_STAT0(port));
-	s1.u64 = cvmx_read_csr(CVMX_AGL_GMX_TXX_STAT1(port));
+	s0.u64 = cvmx_read_csr(p->agl + AGL_GMX_TX_STAT0);
+	s1.u64 = cvmx_read_csr(p->agl + AGL_GMX_TX_STAT1);
 
 	if (s0.s.xsdef || s0.s.xscol || s1.s.scol || s1.s.mcol) {
 		/* Do an atomic update. */
@@ -308,7 +357,6 @@ static u64 octeon_mgmt_dequeue_rx_buffer(struct octeon_mgmt *p,
 
 static int octeon_mgmt_receive_one(struct octeon_mgmt *p)
 {
-	int port = p->port;
 	struct net_device *netdev = p->netdev;
 	union cvmx_mixx_ircnt mix_ircnt;
 	union mgmt_port_ring_entry re;
@@ -381,18 +429,17 @@ done:
 	/* Tell the hardware we processed a packet.  */
 	mix_ircnt.u64 = 0;
 	mix_ircnt.s.ircnt = 1;
-	cvmx_write_csr(CVMX_MIXX_IRCNT(port), mix_ircnt.u64);
+	cvmx_write_csr(p->mix + MIX_IRCNT, mix_ircnt.u64);
 	return rc;
 }
 
 static int octeon_mgmt_receive_packets(struct octeon_mgmt *p, int budget)
 {
-	int port = p->port;
 	unsigned int work_done = 0;
 	union cvmx_mixx_ircnt mix_ircnt;
 	int rc;
 
-	mix_ircnt.u64 = cvmx_read_csr(CVMX_MIXX_IRCNT(port));
+	mix_ircnt.u64 = cvmx_read_csr(p->mix + MIX_IRCNT);
 	while (work_done < budget && mix_ircnt.s.ircnt) {
 
 		rc = octeon_mgmt_receive_one(p);
@@ -400,7 +447,7 @@ static int octeon_mgmt_receive_packets(struct octeon_mgmt *p, int budget)
 			work_done++;
 
 		/* Check for more packets. */
-		mix_ircnt.u64 = cvmx_read_csr(CVMX_MIXX_IRCNT(port));
+		mix_ircnt.u64 = cvmx_read_csr(p->mix + MIX_IRCNT);
 	}
 
 	octeon_mgmt_rx_fill_ring(p->netdev);
@@ -434,16 +481,16 @@ static void octeon_mgmt_reset_hw(struct octeon_mgmt *p)
 	union cvmx_agl_gmx_bist agl_gmx_bist;
 
 	mix_ctl.u64 = 0;
-	cvmx_write_csr(CVMX_MIXX_CTL(p->port), mix_ctl.u64);
+	cvmx_write_csr(p->mix + MIX_CTL, mix_ctl.u64);
 	do {
-		mix_ctl.u64 = cvmx_read_csr(CVMX_MIXX_CTL(p->port));
+		mix_ctl.u64 = cvmx_read_csr(p->mix + MIX_CTL);
 	} while (mix_ctl.s.busy);
 	mix_ctl.s.reset = 1;
-	cvmx_write_csr(CVMX_MIXX_CTL(p->port), mix_ctl.u64);
-	cvmx_read_csr(CVMX_MIXX_CTL(p->port));
+	cvmx_write_csr(p->mix + MIX_CTL, mix_ctl.u64);
+	cvmx_read_csr(p->mix + MIX_CTL);
 	cvmx_wait(64);
 
-	mix_bist.u64 = cvmx_read_csr(CVMX_MIXX_BIST(p->port));
+	mix_bist.u64 = cvmx_read_csr(p->mix + MIX_BIST);
 	if (mix_bist.u64)
 		dev_warn(p->dev, "MIX failed BIST (0x%016llx)\n",
 			(unsigned long long)mix_bist.u64);
@@ -474,7 +521,6 @@ static void octeon_mgmt_cam_state_add(struct octeon_mgmt_cam_state *cs,
 static void octeon_mgmt_set_rx_filtering(struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 	union cvmx_agl_gmx_rxx_adr_ctl adr_ctl;
 	union cvmx_agl_gmx_prtx_cfg agl_gmx_prtx;
 	unsigned long flags;
@@ -520,29 +566,29 @@ static void octeon_mgmt_set_rx_filtering(struct net_device *netdev)
 	spin_lock_irqsave(&p->lock, flags);
 
 	/* Disable packet I/O. */
-	agl_gmx_prtx.u64 = cvmx_read_csr(CVMX_AGL_GMX_PRTX_CFG(port));
+	agl_gmx_prtx.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
 	prev_packet_enable = agl_gmx_prtx.s.en;
 	agl_gmx_prtx.s.en = 0;
-	cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port), agl_gmx_prtx.u64);
+	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, agl_gmx_prtx.u64);
 
 	adr_ctl.u64 = 0;
 	adr_ctl.s.cam_mode = cam_mode;
 	adr_ctl.s.mcst = multicast_mode;
 	adr_ctl.s.bcst = 1;     /* Allow broadcast */
 
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CTL(port), adr_ctl.u64);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_ADR_CTL, adr_ctl.u64);
 
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM0(port), cam_state.cam[0]);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM1(port), cam_state.cam[1]);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM2(port), cam_state.cam[2]);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM3(port), cam_state.cam[3]);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM4(port), cam_state.cam[4]);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM5(port), cam_state.cam[5]);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM_EN(port), cam_state.cam_mask);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_ADR_CAM0, cam_state.cam[0]);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_ADR_CAM1, cam_state.cam[1]);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_ADR_CAM2, cam_state.cam[2]);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_ADR_CAM3, cam_state.cam[3]);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_ADR_CAM4, cam_state.cam[4]);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_ADR_CAM5, cam_state.cam[5]);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_ADR_CAM_EN, cam_state.cam_mask);
 
 	/* Restore packet I/O. */
 	agl_gmx_prtx.s.en = prev_packet_enable;
-	cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port), agl_gmx_prtx.u64);
+	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, agl_gmx_prtx.u64);
 
 	spin_unlock_irqrestore(&p->lock, flags);
 }
@@ -564,7 +610,6 @@ static int octeon_mgmt_set_mac_address(struct net_device *netdev, void *addr)
 static int octeon_mgmt_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 	int size_without_fcs = new_mtu + OCTEON_MGMT_RX_HEADROOM;
 
 	/*
@@ -580,8 +625,8 @@ static int octeon_mgmt_change_mtu(struct net_device *netdev, int new_mtu)
 
 	netdev->mtu = new_mtu;
 
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_FRM_MAX(port), size_without_fcs);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_JABBER(port),
+	cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_MAX, size_without_fcs);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_JABBER,
 		       (size_without_fcs + 7) & 0xfff8);
 
 	return 0;
@@ -591,14 +636,13 @@ static irqreturn_t octeon_mgmt_interrupt(int cpl, void *dev_id)
 {
 	struct net_device *netdev = dev_id;
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 	union cvmx_mixx_isr mixx_isr;
 
-	mixx_isr.u64 = cvmx_read_csr(CVMX_MIXX_ISR(port));
+	mixx_isr.u64 = cvmx_read_csr(p->mix + MIX_ISR);
 
 	/* Clear any pending interrupts */
-	cvmx_write_csr(CVMX_MIXX_ISR(port), mixx_isr.u64);
-	cvmx_read_csr(CVMX_MIXX_ISR(port));
+	cvmx_write_csr(p->mix + MIX_ISR, mixx_isr.u64);
+	cvmx_read_csr(p->mix + MIX_ISR);
 
 	if (mixx_isr.s.irthresh) {
 		octeon_mgmt_disable_rx_irq(p);
@@ -629,7 +673,6 @@ static int octeon_mgmt_ioctl(struct net_device *netdev,
 static void octeon_mgmt_adjust_link(struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 	union cvmx_agl_gmx_prtx_cfg prtx_cfg;
 	unsigned long flags;
 	int link_changed = 0;
@@ -640,11 +683,9 @@ static void octeon_mgmt_adjust_link(struct net_device *netdev)
 			link_changed = 1;
 		if (p->last_duplex != p->phydev->duplex) {
 			p->last_duplex = p->phydev->duplex;
-			prtx_cfg.u64 =
-				cvmx_read_csr(CVMX_AGL_GMX_PRTX_CFG(port));
+			prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
 			prtx_cfg.s.duplex = p->phydev->duplex;
-			cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port),
-				       prtx_cfg.u64);
+			cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
 		}
 	} else {
 		if (p->last_link)
@@ -670,18 +711,16 @@ static void octeon_mgmt_adjust_link(struct net_device *netdev)
 static int octeon_mgmt_init_phy(struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	char phy_id[MII_BUS_ID_SIZE + 3];
 
-	if (octeon_is_simulation()) {
+	if (octeon_is_simulation() || p->phy_np == NULL) {
 		/* No PHYs in the simulator. */
 		netif_carrier_on(netdev);
 		return 0;
 	}
 
-	snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "mdio-octeon-0", p->port);
-
-	p->phydev = phy_connect(netdev, phy_id, octeon_mgmt_adjust_link, 0,
-				PHY_INTERFACE_MODE_MII);
+	p->phydev = of_phy_connect(netdev, p->phy_np,
+				   octeon_mgmt_adjust_link, 0,
+				   PHY_INTERFACE_MODE_MII);
 
 	if (IS_ERR(p->phydev)) {
 		p->phydev = NULL;
@@ -737,14 +776,14 @@ static int octeon_mgmt_open(struct net_device *netdev)
 
 	octeon_mgmt_reset_hw(p);
 
-	mix_ctl.u64 = cvmx_read_csr(CVMX_MIXX_CTL(port));
+	mix_ctl.u64 = cvmx_read_csr(p->mix + MIX_CTL);
 
 	/* Bring it out of reset if needed. */
 	if (mix_ctl.s.reset) {
 		mix_ctl.s.reset = 0;
-		cvmx_write_csr(CVMX_MIXX_CTL(port), mix_ctl.u64);
+		cvmx_write_csr(p->mix + MIX_CTL, mix_ctl.u64);
 		do {
-			mix_ctl.u64 = cvmx_read_csr(CVMX_MIXX_CTL(port));
+			mix_ctl.u64 = cvmx_read_csr(p->mix + MIX_CTL);
 		} while (mix_ctl.s.reset);
 	}
 
@@ -755,17 +794,17 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	oring1.u64 = 0;
 	oring1.s.obase = p->tx_ring_handle >> 3;
 	oring1.s.osize = OCTEON_MGMT_TX_RING_SIZE;
-	cvmx_write_csr(CVMX_MIXX_ORING1(port), oring1.u64);
+	cvmx_write_csr(p->mix + MIX_ORING1, oring1.u64);
 
 	iring1.u64 = 0;
 	iring1.s.ibase = p->rx_ring_handle >> 3;
 	iring1.s.isize = OCTEON_MGMT_RX_RING_SIZE;
-	cvmx_write_csr(CVMX_MIXX_IRING1(port), iring1.u64);
+	cvmx_write_csr(p->mix + MIX_IRING1, iring1.u64);
 
 	/* Disable packet I/O. */
-	prtx_cfg.u64 = cvmx_read_csr(CVMX_AGL_GMX_PRTX_CFG(port));
+	prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
 	prtx_cfg.s.en = 0;
-	cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port), prtx_cfg.u64);
+	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
 
 	memcpy(sa.sa_data, netdev->dev_addr, ETH_ALEN);
 	octeon_mgmt_set_mac_address(netdev, &sa);
@@ -782,7 +821,7 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	mix_ctl.s.nbtarb = 0;       /* Arbitration mode */
 	/* MII CB-request FIFO programmable high watermark */
 	mix_ctl.s.mrq_hwm = 1;
-	cvmx_write_csr(CVMX_MIXX_CTL(port), mix_ctl.u64);
+	cvmx_write_csr(p->mix + MIX_CTL, mix_ctl.u64);
 
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
 	    || OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
@@ -809,16 +848,16 @@ static int octeon_mgmt_open(struct net_device *netdev)
 
 	/* Clear statistics. */
 	/* Clear on read. */
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_STATS_CTL(port), 1);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_STATS_PKTS_DRP(port), 0);
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_STATS_PKTS_BAD(port), 0);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_STATS_CTL, 1);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_STATS_PKTS_DRP, 0);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_STATS_PKTS_BAD, 0);
 
-	cvmx_write_csr(CVMX_AGL_GMX_TXX_STATS_CTL(port), 1);
-	cvmx_write_csr(CVMX_AGL_GMX_TXX_STAT0(port), 0);
-	cvmx_write_csr(CVMX_AGL_GMX_TXX_STAT1(port), 0);
+	cvmx_write_csr(p->agl + AGL_GMX_TX_STATS_CTL, 1);
+	cvmx_write_csr(p->agl + AGL_GMX_TX_STAT0, 0);
+	cvmx_write_csr(p->agl + AGL_GMX_TX_STAT1, 0);
 
 	/* Clear any pending interrupts */
-	cvmx_write_csr(CVMX_MIXX_ISR(port), cvmx_read_csr(CVMX_MIXX_ISR(port)));
+	cvmx_write_csr(p->mix + MIX_ISR, cvmx_read_csr(p->mix + MIX_ISR));
 
 	if (request_irq(p->irq, octeon_mgmt_interrupt, 0, netdev->name,
 			netdev)) {
@@ -829,18 +868,18 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	/* Interrupt every single RX packet */
 	mix_irhwm.u64 = 0;
 	mix_irhwm.s.irhwm = 0;
-	cvmx_write_csr(CVMX_MIXX_IRHWM(port), mix_irhwm.u64);
+	cvmx_write_csr(p->mix + MIX_IRHWM, mix_irhwm.u64);
 
 	/* Interrupt when we have 1 or more packets to clean.  */
 	mix_orhwm.u64 = 0;
 	mix_orhwm.s.orhwm = 1;
-	cvmx_write_csr(CVMX_MIXX_ORHWM(port), mix_orhwm.u64);
+	cvmx_write_csr(p->mix + MIX_ORHWM, mix_orhwm.u64);
 
 	/* Enable receive and transmit interrupts */
 	mix_intena.u64 = 0;
 	mix_intena.s.ithena = 1;
 	mix_intena.s.othena = 1;
-	cvmx_write_csr(CVMX_MIXX_INTENA(port), mix_intena.u64);
+	cvmx_write_csr(p->mix + MIX_INTENA, mix_intena.u64);
 
 
 	/* Enable packet I/O. */
@@ -871,7 +910,7 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	 * frame.  GMX checks that the PREAMBLE is sent correctly.
 	 */
 	rxx_frm_ctl.s.pre_chk = 1;
-	cvmx_write_csr(CVMX_AGL_GMX_RXX_FRM_CTL(port), rxx_frm_ctl.u64);
+	cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_CTL, rxx_frm_ctl.u64);
 
 	/* Enable the AGL block */
 	agl_gmx_inf_mode.u64 = 0;
@@ -879,13 +918,13 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	cvmx_write_csr(CVMX_AGL_GMX_INF_MODE, agl_gmx_inf_mode.u64);
 
 	/* Configure the port duplex and enables */
-	prtx_cfg.u64 = cvmx_read_csr(CVMX_AGL_GMX_PRTX_CFG(port));
+	prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
 	prtx_cfg.s.tx_en = 1;
 	prtx_cfg.s.rx_en = 1;
 	prtx_cfg.s.en = 1;
 	p->last_duplex = 1;
 	prtx_cfg.s.duplex = p->last_duplex;
-	cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port), prtx_cfg.u64);
+	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
 
 	p->last_link = 0;
 	netif_carrier_off(netdev);
@@ -949,7 +988,6 @@ static int octeon_mgmt_stop(struct net_device *netdev)
 static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 	union mgmt_port_ring_entry re;
 	unsigned long flags;
 	int rv = NETDEV_TX_BUSY;
@@ -993,7 +1031,7 @@ static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	netdev->stats.tx_bytes += skb->len;
 
 	/* Ring the bell.  */
-	cvmx_write_csr(CVMX_MIXX_ORING2(port), 1);
+	cvmx_write_csr(p->mix + MIX_ORING2, 1);
 
 	rv = NETDEV_TX_OK;
 out:
@@ -1071,10 +1109,14 @@ static const struct net_device_ops octeon_mgmt_ops = {
 
 static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 {
-	struct resource *res_irq;
 	struct net_device *netdev;
 	struct octeon_mgmt *p;
-	int i;
+	const __be32 *data;
+	const u8 *mac;
+	struct resource *res_mix;
+	struct resource *res_agl;
+	int len;
+	int result;
 
 	netdev = alloc_etherdev(sizeof(struct octeon_mgmt));
 	if (netdev == NULL)
@@ -1088,14 +1130,63 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 	p->netdev = netdev;
 	p->dev = &pdev->dev;
 
-	p->port = pdev->id;
+	data = of_get_property(pdev->dev.of_node, "cell-index", &len);
+	if (data && len == sizeof(*data)) {
+		p->port = be32_to_cpup(data);
+	} else {
+		dev_err(&pdev->dev, "no 'cell-index' property\n");
+		result = -ENXIO;
+		goto err;
+	}
+
 	snprintf(netdev->name, IFNAMSIZ, "mgmt%d", p->port);
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq)
+	result = platform_get_irq(pdev, 0);
+	if (result < 0)
+		goto err;
+
+	p->irq = result;
+
+	res_mix = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res_mix == NULL) {
+		dev_err(&pdev->dev, "no 'reg' resource\n");
+		result = -ENXIO;
+		goto err;
+	}
+
+	res_agl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res_agl == NULL) {
+		dev_err(&pdev->dev, "no 'reg' resource\n");
+		result = -ENXIO;
+		goto err;
+	}
+
+	p->mix_phys = res_mix->start;
+	p->mix_size = resource_size(res_mix);
+	p->agl_phys = res_agl->start;
+	p->agl_size = resource_size(res_agl);
+
+
+	if (!devm_request_mem_region(&pdev->dev, p->mix_phys, p->mix_size,
+				     res_mix->name)) {
+		dev_err(&pdev->dev, "request_mem_region (%s) failed\n",
+			res_mix->name);
+		result = -ENXIO;
+		goto err;
+	}
+
+	if (!devm_request_mem_region(&pdev->dev, p->agl_phys, p->agl_size,
+				     res_agl->name)) {
+		result = -ENXIO;
+		dev_err(&pdev->dev, "request_mem_region (%s) failed\n",
+			res_agl->name);
 		goto err;
+	}
+
+
+	p->mix = (u64)devm_ioremap(&pdev->dev, p->mix_phys, p->mix_size);
+	p->agl = (u64)devm_ioremap(&pdev->dev, p->agl_phys, p->agl_size);
 
-	p->irq = res_irq->start;
 	spin_lock_init(&p->lock);
 
 	skb_queue_head_init(&p->tx_list);
@@ -1108,24 +1199,26 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 	netdev->netdev_ops = &octeon_mgmt_ops;
 	netdev->ethtool_ops = &octeon_mgmt_ethtool_ops;
 
-	/* The mgmt ports get the first N MACs.  */
-	for (i = 0; i < 6; i++)
-		netdev->dev_addr[i] = octeon_bootinfo->mac_addr_base[i];
-	netdev->dev_addr[5] += p->port;
+	mac = of_get_mac_address(pdev->dev.of_node);
+
+	if (mac)
+		memcpy(netdev->dev_addr, mac, 6);
 
-	if (p->port >= octeon_bootinfo->mac_addr_count)
-		dev_err(&pdev->dev,
-			"Error %s: Using MAC outside of the assigned range: %pM\n",
-			netdev->name, netdev->dev_addr);
+	p->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
 
-	if (register_netdev(netdev))
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
+	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+
+	result = register_netdev(netdev);
+	if (result)
 		goto err;
 
 	dev_info(&pdev->dev, "Version " DRV_VERSION "\n");
 	return 0;
+
 err:
 	free_netdev(netdev);
-	return -ENOENT;
+	return result;
 }
 
 static int __devexit octeon_mgmt_remove(struct platform_device *pdev)
@@ -1137,10 +1230,19 @@ static int __devexit octeon_mgmt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id octeon_mgmt_match[] = {
+	{
+		.compatible = "cavium,octeon-5750-mix",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_mgmt_match);
+
 static struct platform_driver octeon_mgmt_driver = {
 	.driver = {
 		.name		= "octeon_mgmt",
 		.owner		= THIS_MODULE,
+		.of_match_table = octeon_mgmt_match,
 	},
 	.probe		= octeon_mgmt_probe,
 	.remove		= __devexit_p(octeon_mgmt_remove),
-- 
1.7.2.3
