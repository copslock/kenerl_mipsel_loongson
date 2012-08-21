Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:47:04 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:43768 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2HUSp0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:45:26 +0200
Received: by pbbrq8 with SMTP id rq8so322060pbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yjVUELd8JY5ddOducZ8l/Tcj3AopTsBnJkX41OJLFWU=;
        b=VqAm7uieC7x6nFSi9oRgjTLVKiZLqZ/OUD6tedrU43siFW/Z/kjWJHLpcZOkCVlOVk
         duCjJbh57EBQvIXNQir4ztSesmS9d35U2ZDCFKC9SBDPeKs9CUG/PqYVmXD3XyZoNkjh
         zkxfejcMoWX4bpVw5ja79FqFFau1mm2TcnCg9AqqsaJO+QP4+1b3bEyenChc+TMbW+Yh
         SNuIbqvdiNNaw+iI/K2bC88XU17B1Kf7ob4jaJ74uz32oNNud0P/fSjJcBPcVPVLrRSi
         MNPwf5cPx12TjJ9wCeOUS6PghRkosNiELnUR1hQDFuEhvDmLerUUBVQ/EMwgx63+TmBC
         DZwg==
Received: by 10.68.231.10 with SMTP id tc10mr46009546pbc.107.1345574719250;
        Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id tq4sm1964389pbc.11.2012.08.21.11.45.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:45:18 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7LIjG3w021499;
        Tue, 21 Aug 2012 11:45:16 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7LIjG8R021498;
        Tue, 21 Aug 2012 11:45:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Chad Reese <kreese@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 3/8] netdev: octeon_mgmt: Add hardware timestamp support.
Date:   Tue, 21 Aug 2012 11:45:07 -0700
Message-Id: <1345574712-21444-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34321
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

From: Chad Reese <kreese@caviumnetworks.com>

Octeon cn6XXX models have timestamp support on the mgmt ports, so hook
it up.

Signed-off-by: Chad Reese <kreese@caviumnetworks.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 157 +++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index c4df1ab..687a6a0 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/capability.h>
+#include <linux/net_tstamp.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
@@ -114,6 +115,7 @@ struct octeon_mgmt {
 	u64 agl_prt_ctl;
 	int port;
 	int irq;
+	bool has_rx_tstamp;
 	u64 *tx_ring;
 	dma_addr_t tx_ring_handle;
 	unsigned int tx_next;
@@ -238,6 +240,28 @@ static void octeon_mgmt_rx_fill_ring(struct net_device *netdev)
 	}
 }
 
+static ktime_t ptp_to_ktime(u64 ptptime)
+{
+	ktime_t ktimebase;
+	u64 ptpbase;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/* Fill the icache with the code */
+	ktime_get_real();
+	/* Flush all pending operations */
+	mb();
+	/* Read the time and PTP clock as close together as
+	 * possible. It is important that this sequence take the same
+	 * amount of time to reduce jitter
+	 */
+	ktimebase = ktime_get_real();
+	ptpbase = cvmx_read_csr(CVMX_MIO_PTP_CLOCK_HI);
+	local_irq_restore(flags);
+
+	return ktime_sub_ns(ktimebase, ptpbase - ptptime);
+}
+
 static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 {
 	union cvmx_mixx_orcnt mix_orcnt;
@@ -277,6 +301,20 @@ static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 
 		dma_unmap_single(p->dev, re.s.addr, re.s.len,
 				 DMA_TO_DEVICE);
+
+		/* Read the hardware TX timestamp if one was recorded */
+		if (unlikely(re.s.tstamp)) {
+			struct skb_shared_hwtstamps ts;
+			/* Read the timestamp */
+			u64 ns = cvmx_read_csr(CVMX_MIXX_TSTAMP(p->port));
+			/* Remove the timestamp from the FIFO */
+			cvmx_write_csr(CVMX_MIXX_TSCTL(p->port), 0);
+			/* Tell the kernel about the timestamp */
+			ts.syststamp = ptp_to_ktime(ns);
+			ts.hwtstamp = ns_to_ktime(ns);
+			skb_tstamp_tx(skb, &ts);
+		}
+
 		dev_kfree_skb_any(skb);
 		cleaned++;
 
@@ -377,6 +415,16 @@ static int octeon_mgmt_receive_one(struct octeon_mgmt *p)
 		/* A good packet, send it up. */
 		skb_put(skb, re.s.len);
 good:
+		/* Process the RX timestamp if it was recorded */
+		if (p->has_rx_tstamp) {
+			/* The first 8 bytes are the timestamp */
+			u64 ns = *(u64 *)skb->data;
+			struct skb_shared_hwtstamps *ts;
+			ts = skb_hwtstamps(skb);
+			ts->hwtstamp = ns_to_ktime(ns);
+			ts->syststamp = ptp_to_ktime(ns);
+			__skb_pull(skb, 8);
+		}
 		skb->protocol = eth_type_trans(skb, netdev);
 		netdev->stats.rx_packets++;
 		netdev->stats.rx_bytes += skb->len;
@@ -661,18 +709,114 @@ static irqreturn_t octeon_mgmt_interrupt(int cpl, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int octeon_mgmt_ioctl(struct net_device *netdev,
-			     struct ifreq *rq, int cmd)
+static int octeon_mgmt_ioctl_hwtstamp(struct net_device *netdev,
+				      struct ifreq *rq, int cmd)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
+	struct hwtstamp_config config;
+	union cvmx_mio_ptp_clock_cfg ptp;
+	union cvmx_agl_gmx_rxx_frm_ctl rxx_frm_ctl;
+	bool have_hw_timestamps = false;
+
+	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
+		return -EFAULT;
 
-	if (!netif_running(netdev))
+	if (config.flags) /* reserved for future extensions */
 		return -EINVAL;
 
-	if (!p->phydev)
+	/* Check the status of hardware for tiemstamps */
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		/* Get the current state of the PTP clock */
+		ptp.u64 = cvmx_read_csr(CVMX_MIO_PTP_CLOCK_CFG);
+		if (!ptp.s.ext_clk_en) {
+			/* The clock has not been configured to use an
+			 * external source.  Program it to use the main clock
+			 * reference.
+			 */
+			u64 clock_comp = (NSEC_PER_SEC << 32) /	octeon_get_io_clock_rate();
+			if (!ptp.s.ptp_en)
+				cvmx_write_csr(CVMX_MIO_PTP_CLOCK_COMP, clock_comp);
+			pr_info("PTP Clock: Using sclk reference at %lld Hz\n",
+				(NSEC_PER_SEC << 32) / clock_comp);
+		} else {
+			/* The clock is already programmed to use a GPIO */
+			u64 clock_comp = cvmx_read_csr(CVMX_MIO_PTP_CLOCK_COMP);
+			pr_info("PTP Clock: Using GPIO %d at %lld Hz\n",
+				ptp.s.ext_clk_in,
+				(NSEC_PER_SEC << 32) / clock_comp);
+		}
+
+		/* Enable the clock if it wasn't done already */
+		if (!ptp.s.ptp_en) {
+			ptp.s.ptp_en = 1;
+			cvmx_write_csr(CVMX_MIO_PTP_CLOCK_CFG, ptp.u64);
+		}
+		have_hw_timestamps = true;
+	}
+
+	if (!have_hw_timestamps)
 		return -EINVAL;
 
-	return phy_mii_ioctl(p->phydev, rq, cmd);
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+	case HWTSTAMP_TX_ON:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		p->has_rx_tstamp = false;
+		rxx_frm_ctl.u64 = cvmx_read_csr(p->agl + AGL_GMX_RX_FRM_CTL);
+		rxx_frm_ctl.s.ptp_mode = 0;
+		cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_CTL, rxx_frm_ctl.u64);
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_SOME:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		p->has_rx_tstamp = have_hw_timestamps;
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		if (p->has_rx_tstamp) {
+			rxx_frm_ctl.u64 = cvmx_read_csr(p->agl + AGL_GMX_RX_FRM_CTL);
+			rxx_frm_ctl.s.ptp_mode = 1;
+			cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_CTL, rxx_frm_ctl.u64);
+		}
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	if (copy_to_user(rq->ifr_data, &config, sizeof(config)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int octeon_mgmt_ioctl(struct net_device *netdev,
+			     struct ifreq *rq, int cmd)
+{
+	struct octeon_mgmt *p = netdev_priv(netdev);
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		return octeon_mgmt_ioctl_hwtstamp(netdev, rq, cmd);
+	default:
+		if (p->phydev)
+			return phy_mii_ioctl(p->phydev, rq, cmd);
+		return -EINVAL;
+	}
 }
 
 static void octeon_mgmt_disable_link(struct octeon_mgmt *p)
@@ -1052,6 +1196,7 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	/* Enable packet I/O. */
 
 	rxx_frm_ctl.u64 = 0;
+	rxx_frm_ctl.s.ptp_mode = p->has_rx_tstamp ? 1 : 0;
 	rxx_frm_ctl.s.pre_align = 1;
 	/*
 	 * When set, disables the length check for non-min sized pkts
@@ -1155,6 +1300,7 @@ static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	int rv = NETDEV_TX_BUSY;
 
 	re.d64 = 0;
+	re.s.tstamp = ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) != 0);
 	re.s.len = skb->len;
 	re.s.addr = dma_map_single(p->dev, skb->data,
 				   skb->len,
@@ -1293,6 +1439,7 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 
 	p->netdev = netdev;
 	p->dev = &pdev->dev;
+	p->has_rx_tstamp = false;
 
 	data = of_get_property(pdev->dev.of_node, "cell-index", &len);
 	if (data && len == sizeof(*data)) {
-- 
1.7.11.4
