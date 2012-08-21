Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:46:19 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:40734 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903645Ab2HUSpZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:45:25 +0200
Received: by pbbrq8 with SMTP id rq8so322048pbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iSo+o+VA1daCApDEvfDBWltrCjP/ZTb65TSTHqrjE6M=;
        b=IuVG9XSYrw2FLTkYYq1C6vHGYiCrxgVvUyvfHSQnJUCcl4LWY+O7nNpNbLgX5GP8eY
         FDHDOtNzN6j8QNoZYltC7jt20M1XzRJuO+aiT9lJ+lHiCD1N9a2ftHuZ0H12FtrMVg0S
         66frOVSHodP+Eh2g113SkgjkVNrCImb0ZE58IpjrJcftilsq3Stx2+9UWRcIHlMPaIWl
         fjtJWQj0vSH0iyph7stMlpdXva8ZgqxP4F/NeaoXkT5a7pPH+zzs0mm6B3FApqJU5Ahq
         I4YLbxi+8u1xr+RJapzqZhz3zCOhSXgEfebEgThOW05vaECepqQjaVlenh7vpFXw2kPC
         vu1A==
Received: by 10.68.132.194 with SMTP id ow2mr46379181pbb.36.1345574718631;
        Tue, 21 Aug 2012 11:45:18 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id oj8sm1937945pbb.54.2012.08.21.11.45.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:45:17 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7LIjGlP021495;
        Tue, 21 Aug 2012 11:45:16 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7LIjFM3021494;
        Tue, 21 Aug 2012 11:45:15 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/8] netdev: octeon_mgmt: Add support for 1Gig ports.
Date:   Tue, 21 Aug 2012 11:45:06 -0700
Message-Id: <1345574712-21444-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34319
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

The original hardware only supported 10M and 100M.  Later versions
added 1G support.  Here we update the driver to make use of this.

Also minor logic clean-ups for testing PHY registration error codes
and TX complete high water marks.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 328 +++++++++++++++++++++++-------
 1 file changed, 255 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index c42bbb1..c4df1ab 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2009 Cavium Networks
+ * Copyright (C) 2009-2012 Cavium, Inc
  */
 
 #include <linux/platform_device.h>
@@ -93,6 +93,7 @@ union mgmt_port_ring_entry {
 #define AGL_GMX_RX_ADR_CAM4		0x1a0
 #define AGL_GMX_RX_ADR_CAM5		0x1a8
 
+#define AGL_GMX_TX_CLK			0x208
 #define AGL_GMX_TX_STATS_CTL		0x268
 #define AGL_GMX_TX_CTL			0x270
 #define AGL_GMX_TX_STAT0		0x280
@@ -110,6 +111,7 @@ struct octeon_mgmt {
 	struct net_device *netdev;
 	u64 mix;
 	u64 agl;
+	u64 agl_prt_ctl;
 	int port;
 	int irq;
 	u64 *tx_ring;
@@ -131,6 +133,7 @@ struct octeon_mgmt {
 	spinlock_t lock;
 	unsigned int last_duplex;
 	unsigned int last_link;
+	unsigned int last_speed;
 	struct device *dev;
 	struct napi_struct napi;
 	struct tasklet_struct tx_clean_tasklet;
@@ -140,6 +143,8 @@ struct octeon_mgmt {
 	resource_size_t mix_size;
 	resource_size_t agl_phys;
 	resource_size_t agl_size;
+	resource_size_t agl_prt_ctl_phys;
+	resource_size_t agl_prt_ctl_size;
 };
 
 static void octeon_mgmt_set_rx_irq(struct octeon_mgmt *p, int enable)
@@ -488,7 +493,7 @@ static void octeon_mgmt_reset_hw(struct octeon_mgmt *p)
 	mix_ctl.s.reset = 1;
 	cvmx_write_csr(p->mix + MIX_CTL, mix_ctl.u64);
 	cvmx_read_csr(p->mix + MIX_CTL);
-	cvmx_wait(64);
+	octeon_io_clk_delay(64);
 
 	mix_bist.u64 = cvmx_read_csr(p->mix + MIX_BIST);
 	if (mix_bist.u64)
@@ -670,39 +675,148 @@ static int octeon_mgmt_ioctl(struct net_device *netdev,
 	return phy_mii_ioctl(p->phydev, rq, cmd);
 }
 
+static void octeon_mgmt_disable_link(struct octeon_mgmt *p)
+{
+	union cvmx_agl_gmx_prtx_cfg prtx_cfg;
+
+	/* Disable GMX before we make any changes. */
+	prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
+	prtx_cfg.s.en = 0;
+	prtx_cfg.s.tx_en = 0;
+	prtx_cfg.s.rx_en = 0;
+	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
+
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		int i;
+		for (i = 0; i < 10; i++) {
+			prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
+			if (prtx_cfg.s.tx_idle == 1 || prtx_cfg.s.rx_idle == 1)
+				break;
+			mdelay(1);
+			i++;
+		}
+	}
+}
+
+static void octeon_mgmt_enable_link(struct octeon_mgmt *p)
+{
+	union cvmx_agl_gmx_prtx_cfg prtx_cfg;
+
+	/* Restore the GMX enable state only if link is set */
+	prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
+	prtx_cfg.s.tx_en = 1;
+	prtx_cfg.s.rx_en = 1;
+	prtx_cfg.s.en = 1;
+	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
+}
+
+static void octeon_mgmt_update_link(struct octeon_mgmt *p)
+{
+	union cvmx_agl_gmx_prtx_cfg prtx_cfg;
+
+	prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
+
+	if (!p->phydev->link)
+		prtx_cfg.s.duplex = 1;
+	else
+		prtx_cfg.s.duplex = p->phydev->duplex;
+
+	switch (p->phydev->speed) {
+	case 10:
+		prtx_cfg.s.speed = 0;
+		prtx_cfg.s.slottime = 0;
+
+		if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+			prtx_cfg.s.burst = 1;
+			prtx_cfg.s.speed_msb = 1;
+		}
+		break;
+	case 100:
+		prtx_cfg.s.speed = 0;
+		prtx_cfg.s.slottime = 0;
+
+		if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+			prtx_cfg.s.burst = 1;
+			prtx_cfg.s.speed_msb = 0;
+		}
+		break;
+	case 1000:
+		/* 1000 MBits is only supported on 6XXX chips */
+		if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+			prtx_cfg.s.speed = 1;
+			prtx_cfg.s.speed_msb = 0;
+			/* Only matters for half-duplex */
+			prtx_cfg.s.slottime = 1;
+			prtx_cfg.s.burst = p->phydev->duplex;
+		}
+		break;
+	case 0:  /* No link */
+	default:
+		break;
+	}
+
+	/* Write the new GMX setting with the port still disabled. */
+	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
+
+	/* Read GMX CFG again to make sure the config is completed. */
+	prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
+
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		union cvmx_agl_gmx_txx_clk agl_clk;
+		union cvmx_agl_prtx_ctl prtx_ctl;
+
+		prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
+		agl_clk.u64 = cvmx_read_csr(p->agl + AGL_GMX_TX_CLK);
+		/* MII (both speeds) and RGMII 1000 speed. */
+		agl_clk.s.clk_cnt = 1;
+		if (prtx_ctl.s.mode == 0) { /* RGMII mode */
+			if (p->phydev->speed == 10)
+				agl_clk.s.clk_cnt = 50;
+			else if (p->phydev->speed == 100)
+				agl_clk.s.clk_cnt = 5;
+		}
+		cvmx_write_csr(p->agl + AGL_GMX_TX_CLK, agl_clk.u64);
+	}
+}
+
 static void octeon_mgmt_adjust_link(struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	union cvmx_agl_gmx_prtx_cfg prtx_cfg;
 	unsigned long flags;
 	int link_changed = 0;
 
+	if (!p->phydev)
+		return;
+
 	spin_lock_irqsave(&p->lock, flags);
-	if (p->phydev->link) {
-		if (!p->last_link)
-			link_changed = 1;
-		if (p->last_duplex != p->phydev->duplex) {
-			p->last_duplex = p->phydev->duplex;
-			prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
-			prtx_cfg.s.duplex = p->phydev->duplex;
-			cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
-		}
-	} else {
-		if (p->last_link)
-			link_changed = -1;
+
+
+	if (!p->phydev->link && p->last_link)
+		link_changed = -1;
+
+	if (p->phydev->link
+	    && (p->last_duplex != p->phydev->duplex
+		|| p->last_link != p->phydev->link
+		|| p->last_speed != p->phydev->speed)) {
+		octeon_mgmt_disable_link(p);
+		link_changed = 1;
+		octeon_mgmt_update_link(p);
+		octeon_mgmt_enable_link(p);
 	}
+
 	p->last_link = p->phydev->link;
+	p->last_speed = p->phydev->speed;
+	p->last_duplex = p->phydev->duplex;
+
 	spin_unlock_irqrestore(&p->lock, flags);
 
 	if (link_changed != 0) {
 		if (link_changed > 0) {
-			netif_carrier_on(netdev);
 			pr_info("%s: Link is up - %d/%s\n", netdev->name,
 				p->phydev->speed,
 				DUPLEX_FULL == p->phydev->duplex ?
 				"Full" : "Half");
 		} else {
-			netif_carrier_off(netdev);
 			pr_info("%s: Link is down\n", netdev->name);
 		}
 	}
@@ -722,12 +836,8 @@ static int octeon_mgmt_init_phy(struct net_device *netdev)
 				   octeon_mgmt_adjust_link, 0,
 				   PHY_INTERFACE_MODE_MII);
 
-	if (IS_ERR(p->phydev)) {
-		p->phydev = NULL;
-		return -1;
-	}
-
-	phy_start_aneg(p->phydev);
+	if (p->phydev == NULL)
+		return -ENODEV;
 
 	return 0;
 }
@@ -735,12 +845,10 @@ static int octeon_mgmt_init_phy(struct net_device *netdev)
 static int octeon_mgmt_open(struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int port = p->port;
 	union cvmx_mixx_ctl mix_ctl;
 	union cvmx_agl_gmx_inf_mode agl_gmx_inf_mode;
 	union cvmx_mixx_oring1 oring1;
 	union cvmx_mixx_iring1 iring1;
-	union cvmx_agl_gmx_prtx_cfg prtx_cfg;
 	union cvmx_agl_gmx_rxx_frm_ctl rxx_frm_ctl;
 	union cvmx_mixx_irhwm mix_irhwm;
 	union cvmx_mixx_orhwm mix_orhwm;
@@ -787,9 +895,31 @@ static int octeon_mgmt_open(struct net_device *netdev)
 		} while (mix_ctl.s.reset);
 	}
 
-	agl_gmx_inf_mode.u64 = 0;
-	agl_gmx_inf_mode.s.en = 1;
-	cvmx_write_csr(CVMX_AGL_GMX_INF_MODE, agl_gmx_inf_mode.u64);
+	if (OCTEON_IS_MODEL(OCTEON_CN5XXX)) {
+		agl_gmx_inf_mode.u64 = 0;
+		agl_gmx_inf_mode.s.en = 1;
+		cvmx_write_csr(CVMX_AGL_GMX_INF_MODE, agl_gmx_inf_mode.u64);
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
+		|| OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
+		/*
+		 * Force compensation values, as they are not
+		 * determined properly by HW
+		 */
+		union cvmx_agl_gmx_drv_ctl drv_ctl;
+
+		drv_ctl.u64 = cvmx_read_csr(CVMX_AGL_GMX_DRV_CTL);
+		if (p->port) {
+			drv_ctl.s.byp_en1 = 1;
+			drv_ctl.s.nctl1 = 6;
+			drv_ctl.s.pctl1 = 6;
+		} else {
+			drv_ctl.s.byp_en = 1;
+			drv_ctl.s.nctl = 6;
+			drv_ctl.s.pctl = 6;
+		}
+		cvmx_write_csr(CVMX_AGL_GMX_DRV_CTL, drv_ctl.u64);
+	}
 
 	oring1.u64 = 0;
 	oring1.s.obase = p->tx_ring_handle >> 3;
@@ -801,11 +931,6 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	iring1.s.isize = OCTEON_MGMT_RX_RING_SIZE;
 	cvmx_write_csr(p->mix + MIX_IRING1, iring1.u64);
 
-	/* Disable packet I/O. */
-	prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
-	prtx_cfg.s.en = 0;
-	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
-
 	memcpy(sa.sa_data, netdev->dev_addr, ETH_ALEN);
 	octeon_mgmt_set_mac_address(netdev, &sa);
 
@@ -821,27 +946,70 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	mix_ctl.s.nbtarb = 0;       /* Arbitration mode */
 	/* MII CB-request FIFO programmable high watermark */
 	mix_ctl.s.mrq_hwm = 1;
+#ifdef __LITTLE_ENDIAN
+	mix_ctl.s.lendian = 1;
+#endif
 	cvmx_write_csr(p->mix + MIX_CTL, mix_ctl.u64);
 
-	if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
-	    || OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
-		/*
-		 * Force compensation values, as they are not
-		 * determined properly by HW
-		 */
-		union cvmx_agl_gmx_drv_ctl drv_ctl;
+	/* Read the PHY to find the mode of the interface. */
+	if (octeon_mgmt_init_phy(netdev)) {
+		dev_err(p->dev, "Cannot initialize PHY on MIX%d.\n", p->port);
+		goto err_noirq;
+	}
 
-		drv_ctl.u64 = cvmx_read_csr(CVMX_AGL_GMX_DRV_CTL);
-		if (port) {
-			drv_ctl.s.byp_en1 = 1;
-			drv_ctl.s.nctl1 = 6;
-			drv_ctl.s.pctl1 = 6;
-		} else {
-			drv_ctl.s.byp_en = 1;
-			drv_ctl.s.nctl = 6;
-			drv_ctl.s.pctl = 6;
+	/* Set the mode of the interface, RGMII/MII. */
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX) && p->phydev) {
+		union cvmx_agl_prtx_ctl agl_prtx_ctl;
+		int rgmii_mode = (p->phydev->supported &
+				  (SUPPORTED_1000baseT_Half | SUPPORTED_1000baseT_Full)) != 0;
+
+		agl_prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
+		agl_prtx_ctl.s.mode = rgmii_mode ? 0 : 1;
+		cvmx_write_csr(p->agl_prt_ctl,	agl_prtx_ctl.u64);
+
+		/* MII clocks counts are based on the 125Mhz
+		 * reference, which has an 8nS period. So our delays
+		 * need to be multiplied by this factor.
+		 */
+#define NS_PER_PHY_CLK 8
+
+		/* Take the DLL and clock tree out of reset */
+		agl_prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
+		agl_prtx_ctl.s.clkrst = 0;
+		if (rgmii_mode) {
+			agl_prtx_ctl.s.dllrst = 0;
+			agl_prtx_ctl.s.clktx_byp = 0;
 		}
-		cvmx_write_csr(CVMX_AGL_GMX_DRV_CTL, drv_ctl.u64);
+		cvmx_write_csr(p->agl_prt_ctl,	agl_prtx_ctl.u64);
+		cvmx_read_csr(p->agl_prt_ctl); /* Force write out before wait */
+
+		/* Wait for the DLL to lock. External 125 MHz
+		 * reference clock must be stable at this point.
+		 */
+		ndelay(256 * NS_PER_PHY_CLK);
+
+		/* Enable the interface */
+		agl_prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
+		agl_prtx_ctl.s.enable = 1;
+		cvmx_write_csr(p->agl_prt_ctl, agl_prtx_ctl.u64);
+
+		/* Read the value back to force the previous write */
+		agl_prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
+
+		/* Enable the compensation controller */
+		agl_prtx_ctl.s.comp = 1;
+		agl_prtx_ctl.s.drv_byp = 0;
+		cvmx_write_csr(p->agl_prt_ctl,	agl_prtx_ctl.u64);
+		/* Force write out before wait. */
+		cvmx_read_csr(p->agl_prt_ctl);
+
+		/* For compensation state to lock. */
+		ndelay(1040 * NS_PER_PHY_CLK);
+
+		/* Some Ethernet switches cannot handle standard
+		 * Interframe Gap, increase to 16 bytes.
+		 */
+		cvmx_write_csr(CVMX_AGL_GMX_TX_IFG, 0x88);
 	}
 
 	octeon_mgmt_rx_fill_ring(netdev);
@@ -872,7 +1040,7 @@ static int octeon_mgmt_open(struct net_device *netdev)
 
 	/* Interrupt when we have 1 or more packets to clean.  */
 	mix_orhwm.u64 = 0;
-	mix_orhwm.s.orhwm = 1;
+	mix_orhwm.s.orhwm = 0;
 	cvmx_write_csr(p->mix + MIX_ORHWM, mix_orhwm.u64);
 
 	/* Enable receive and transmit interrupts */
@@ -881,7 +1049,6 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	mix_intena.s.othena = 1;
 	cvmx_write_csr(p->mix + MIX_INTENA, mix_intena.u64);
 
-
 	/* Enable packet I/O. */
 
 	rxx_frm_ctl.u64 = 0;
@@ -912,26 +1079,20 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	rxx_frm_ctl.s.pre_chk = 1;
 	cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_CTL, rxx_frm_ctl.u64);
 
-	/* Enable the AGL block */
-	agl_gmx_inf_mode.u64 = 0;
-	agl_gmx_inf_mode.s.en = 1;
-	cvmx_write_csr(CVMX_AGL_GMX_INF_MODE, agl_gmx_inf_mode.u64);
-
-	/* Configure the port duplex and enables */
-	prtx_cfg.u64 = cvmx_read_csr(p->agl + AGL_GMX_PRT_CFG);
-	prtx_cfg.s.tx_en = 1;
-	prtx_cfg.s.rx_en = 1;
-	prtx_cfg.s.en = 1;
-	p->last_duplex = 1;
-	prtx_cfg.s.duplex = p->last_duplex;
-	cvmx_write_csr(p->agl + AGL_GMX_PRT_CFG, prtx_cfg.u64);
+	/* Configure the port duplex, speed and enables */
+	octeon_mgmt_disable_link(p);
+	if (p->phydev)
+		octeon_mgmt_update_link(p);
+	octeon_mgmt_enable_link(p);
 
 	p->last_link = 0;
-	netif_carrier_off(netdev);
-
-	if (octeon_mgmt_init_phy(netdev)) {
-		dev_err(p->dev, "Cannot initialize PHY.\n");
-		goto err_noirq;
+	p->last_speed = 0;
+	/* PHY is not present in simulator. The carrier is enabled
+	 * while initializing the phy for simulator, leave it enabled.
+	 */
+	if (p->phydev) {
+		netif_carrier_off(netdev);
+		phy_start_aneg(p->phydev);
 	}
 
 	netif_wake_queue(netdev);
@@ -961,6 +1122,7 @@ static int octeon_mgmt_stop(struct net_device *netdev)
 
 	if (p->phydev)
 		phy_disconnect(p->phydev);
+	p->phydev = NULL;
 
 	netif_carrier_off(netdev);
 
@@ -1033,6 +1195,7 @@ static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* Ring the bell.  */
 	cvmx_write_csr(p->mix + MIX_ORING2, 1);
 
+	netdev->trans_start = jiffies;
 	rv = NETDEV_TX_OK;
 out:
 	octeon_mgmt_update_tx_stats(netdev);
@@ -1098,9 +1261,9 @@ static const struct net_device_ops octeon_mgmt_ops = {
 	.ndo_open =			octeon_mgmt_open,
 	.ndo_stop =			octeon_mgmt_stop,
 	.ndo_start_xmit =		octeon_mgmt_xmit,
-	.ndo_set_rx_mode = 		octeon_mgmt_set_rx_filtering,
+	.ndo_set_rx_mode =		octeon_mgmt_set_rx_filtering,
 	.ndo_set_mac_address =		octeon_mgmt_set_mac_address,
-	.ndo_do_ioctl = 		octeon_mgmt_ioctl,
+	.ndo_do_ioctl =			octeon_mgmt_ioctl,
 	.ndo_change_mtu =		octeon_mgmt_change_mtu,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller =		octeon_mgmt_poll_controller,
@@ -1115,6 +1278,7 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 	const u8 *mac;
 	struct resource *res_mix;
 	struct resource *res_agl;
+	struct resource *res_agl_prt_ctl;
 	int len;
 	int result;
 
@@ -1161,10 +1325,19 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	res_agl_prt_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+	if (res_agl_prt_ctl == NULL) {
+		dev_err(&pdev->dev, "no 'reg' resource\n");
+		result = -ENXIO;
+		goto err;
+	}
+
 	p->mix_phys = res_mix->start;
 	p->mix_size = resource_size(res_mix);
 	p->agl_phys = res_agl->start;
 	p->agl_size = resource_size(res_agl);
+	p->agl_prt_ctl_phys = res_agl_prt_ctl->start;
+	p->agl_prt_ctl_size = resource_size(res_agl_prt_ctl);
 
 
 	if (!devm_request_mem_region(&pdev->dev, p->mix_phys, p->mix_size,
@@ -1183,10 +1356,18 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	if (!devm_request_mem_region(&pdev->dev, p->agl_prt_ctl_phys,
+				     p->agl_prt_ctl_size, res_agl_prt_ctl->name)) {
+		result = -ENXIO;
+		dev_err(&pdev->dev, "request_mem_region (%s) failed\n",
+			res_agl_prt_ctl->name);
+		goto err;
+	}
 
 	p->mix = (u64)devm_ioremap(&pdev->dev, p->mix_phys, p->mix_size);
 	p->agl = (u64)devm_ioremap(&pdev->dev, p->agl_phys, p->agl_size);
-
+	p->agl_prt_ctl = (u64)devm_ioremap(&pdev->dev, p->agl_prt_ctl_phys,
+					   p->agl_prt_ctl_size);
 	spin_lock_init(&p->lock);
 
 	skb_queue_head_init(&p->tx_list);
@@ -1209,6 +1390,7 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
 	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 
+	netif_carrier_off(netdev);
 	result = register_netdev(netdev);
 	if (result)
 		goto err;
-- 
1.7.11.4
