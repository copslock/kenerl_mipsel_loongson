Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 01:06:24 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1676 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492521Ab0EEXDz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 01:03:55 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4be1f9650007>; Wed, 05 May 2010 16:04:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o45N3JTX011107;
        Wed, 5 May 2010 16:03:19 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o45N3JPa011106;
        Wed, 5 May 2010 16:03:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 6/6] netdev: octeon_mgmt: Remove some gratuitous blank lines.
Date:   Wed,  5 May 2010 16:03:13 -0700
Message-Id: <1273100593-11043-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
References: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 05 May 2010 23:03:24.0520 (UTC) FILETIME=[2A339E80:01CAECA7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/net/octeon/octeon_mgmt.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/net/octeon/octeon_mgmt.c b/drivers/net/octeon/octeon_mgmt.c
index 1fdc7b3..3924703 100644
--- a/drivers/net/octeon/octeon_mgmt.c
+++ b/drivers/net/octeon/octeon_mgmt.c
@@ -380,7 +380,6 @@ done:
 	mix_ircnt.s.ircnt = 1;
 	cvmx_write_csr(CVMX_MIXX_IRCNT(port), mix_ircnt.u64);
 	return rc;
-
 }
 
 static int octeon_mgmt_receive_packets(struct octeon_mgmt *p, int budget)
@@ -390,7 +389,6 @@ static int octeon_mgmt_receive_packets(struct octeon_mgmt *p, int budget)
 	union cvmx_mixx_ircnt mix_ircnt;
 	int rc;
 
-
 	mix_ircnt.u64 = cvmx_read_csr(CVMX_MIXX_IRCNT(port));
 	while (work_done < budget && mix_ircnt.s.ircnt) {
 
@@ -516,7 +514,6 @@ static void octeon_mgmt_set_rx_filtering(struct net_device *netdev)
 			octeon_mgmt_cam_state_add(&cam_state, ha->addr);
 	}
 
-
 	spin_lock_irqsave(&p->lock, flags);
 
 	/* Disable packet I/O. */
@@ -525,7 +522,6 @@ static void octeon_mgmt_set_rx_filtering(struct net_device *netdev)
 	agl_gmx_prtx.s.en = 0;
 	cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port), agl_gmx_prtx.u64);
 
-
 	adr_ctl.u64 = 0;
 	adr_ctl.s.cam_mode = cam_mode;
 	adr_ctl.s.mcst = multicast_mode;
@@ -928,7 +924,6 @@ static int octeon_mgmt_stop(struct net_device *netdev)
 
 	octeon_mgmt_reset_hw(p);
 
-
 	free_irq(p->irq, netdev);
 
 	/* dma_unmap is a nop on Octeon, so just free everything.  */
@@ -945,7 +940,6 @@ static int octeon_mgmt_stop(struct net_device *netdev)
 			 DMA_BIDIRECTIONAL);
 	kfree(p->tx_ring);
 
-
 	return 0;
 }
 
@@ -1112,7 +1106,6 @@ static int __init octeon_mgmt_probe(struct platform_device *pdev)
 	netdev->netdev_ops = &octeon_mgmt_ops;
 	netdev->ethtool_ops = &octeon_mgmt_ethtool_ops;
 
-
 	/* The mgmt ports get the first N MACs.  */
 	for (i = 0; i < 6; i++)
 		netdev->dev_addr[i] = octeon_bootinfo->mac_addr_base[i];
-- 
1.6.6.1
