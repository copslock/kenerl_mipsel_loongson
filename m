Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:48:38 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56769 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903669Ab2HUSp1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:45:27 +0200
Received: by pbbrq8 with SMTP id rq8so322108pbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SXAGBC0vpBTCqFb5BHsD3ZeTlwcmY7QRVWoXIRL2Zvc=;
        b=UsGMcG1gnzmscNjLsOzYgybHTk4nUTn+Dbk2fBQ3nw6uA6Lbv5d/zD2brvxDsgFbOa
         LAIBbdyTzPoUd6J/qZJCqvfGcvhMKywZWOJ069zh2r3In44MfYpUkDBy9AFX2Z3lQfbg
         zBzH5rteVKF3Rq4G4qNP+hyZ3rgCilv/Ai2/jHrCCTYl5AIW1RqRRzjX6Ms6+DhfgRjN
         YhZSNtLYTZ2aK5mzvcroD0ebuUPzAFIJOp9HVa2KDdxzeVY1a7iRLiZuWsqehwTVRJnr
         X7FoV7fvMJzxjziHJ+qyF9b1ph/1L/6EjKkqAYarGWfjzs0sQzNGtrG3VWfVX1VKT007
         ogrQ==
Received: by 10.68.227.163 with SMTP id sb3mr46647776pbc.74.1345574720546;
        Tue, 21 Aug 2012 11:45:20 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id gt2sm1932683pbc.62.2012.08.21.11.45.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7LIjHB5021519;
        Tue, 21 Aug 2012 11:45:17 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7LIjHem021518;
        Tue, 21 Aug 2012 11:45:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 8/8] netdev: octeon_mgmt: Make multi-line comment style consistent.
Date:   Tue, 21 Aug 2012 11:45:12 -0700
Message-Id: <1345574712-21444-9-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34325
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

No code changes.  Recent patches have used the netdev style multi-line
comment formatting, making the style inconsistent within octeon_mgmt.c

Update the remaining comment blocks to achieve style harmony.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index ccb1f81..5be431c 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -34,8 +34,7 @@
 
 #define OCTEON_MGMT_NAPI_WEIGHT 16
 
-/*
- * Ring sizes that are powers of two allow for more efficient modulo
+/* Ring sizes that are powers of two allow for more efficient modulo
  * opertions.
  */
 #define OCTEON_MGMT_RX_RING_SIZE 512
@@ -431,8 +430,7 @@ good:
 		netif_receive_skb(skb);
 		rc = 0;
 	} else if (re.s.code == RING_ENTRY_CODE_MORE) {
-		/*
-		 * Packet split across skbs.  This can happen if we
+		/* Packet split across skbs.  This can happen if we
 		 * increase the MTU.  Buffers that are already in the
 		 * rx ring can then end up being too small.  As the rx
 		 * ring is refilled, buffers sized for the new MTU
@@ -462,8 +460,7 @@ good:
 	} else {
 		/* Some other error, discard it. */
 		dev_kfree_skb_any(skb);
-		/*
-		 * Error statistics are accumulated in
+		/* Error statistics are accumulated in
 		 * octeon_mgmt_update_rx_stats.
 		 */
 	}
@@ -590,8 +587,7 @@ static void octeon_mgmt_set_rx_filtering(struct net_device *netdev)
 		cam_mode = 0;
 		available_cam_entries = 8;
 	} else {
-		/*
-		 * One CAM entry for the primary address, leaves seven
+		/* One CAM entry for the primary address, leaves seven
 		 * for the secondary addresses.
 		 */
 		available_cam_entries = 7 - netdev->uc.count;
@@ -663,8 +659,7 @@ static int octeon_mgmt_change_mtu(struct net_device *netdev, int new_mtu)
 	struct octeon_mgmt *p = netdev_priv(netdev);
 	int size_without_fcs = new_mtu + OCTEON_MGMT_RX_HEADROOM;
 
-	/*
-	 * Limit the MTU to make sure the ethernet packets are between
+	/* Limit the MTU to make sure the ethernet packets are between
 	 * 64 bytes and 16383 bytes.
 	 */
 	if (size_without_fcs < 64 || size_without_fcs > 16383) {
@@ -1044,8 +1039,7 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	}
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
 		|| OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
-		/*
-		 * Force compensation values, as they are not
+		/* Force compensation values, as they are not
 		 * determined properly by HW
 		 */
 		union cvmx_agl_gmx_drv_ctl drv_ctl;
@@ -1078,8 +1072,7 @@ static int octeon_mgmt_open(struct net_device *netdev)
 
 	octeon_mgmt_change_mtu(netdev, netdev->mtu);
 
-	/*
-	 * Enable the port HW. Packets are not allowed until
+	/* Enable the port HW. Packets are not allowed until
 	 * cvmx_mgmt_port_enable() is called.
 	 */
 	mix_ctl.u64 = 0;
@@ -1196,8 +1189,7 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	rxx_frm_ctl.u64 = 0;
 	rxx_frm_ctl.s.ptp_mode = p->has_rx_tstamp ? 1 : 0;
 	rxx_frm_ctl.s.pre_align = 1;
-	/*
-	 * When set, disables the length check for non-min sized pkts
+	/* When set, disables the length check for non-min sized pkts
 	 * with padding in the client data.
 	 */
 	rxx_frm_ctl.s.pad_len = 1;
@@ -1215,8 +1207,7 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	rxx_frm_ctl.s.ctl_drp = 1;
 	/* Strip off the preamble */
 	rxx_frm_ctl.s.pre_strp = 1;
-	/*
-	 * This port is configured to send PREAMBLE+SFD to begin every
+	/* This port is configured to send PREAMBLE+SFD to begin every
 	 * frame.  GMX checks that the PREAMBLE is sent correctly.
 	 */
 	rxx_frm_ctl.s.pre_chk = 1;
-- 
1.7.11.4
