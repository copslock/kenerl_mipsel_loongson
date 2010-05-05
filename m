Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 01:05:59 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1674 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492519Ab0EEXDx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 01:03:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4be1f9650005>; Wed, 05 May 2010 16:04:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o45N3JaD011099;
        Wed, 5 May 2010 16:03:19 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o45N3JcO011098;
        Wed, 5 May 2010 16:03:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/6] netdev: octeon_mgmt: Free TX skbufs in a timely manner.
Date:   Wed,  5 May 2010 16:03:11 -0700
Message-Id: <1273100593-11043-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
References: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 05 May 2010 23:03:24.0270 (UTC) FILETIME=[2A0D78E0:01CAECA7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

We also reduce the high water mark to 1 so skbufs are not stranded for
long periods of time.  Since we are cleaning after each packet, no
need to do it in the transmit path.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/net/octeon/octeon_mgmt.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/octeon/octeon_mgmt.c b/drivers/net/octeon/octeon_mgmt.c
index 633fa89..3cf6f62 100644
--- a/drivers/net/octeon/octeon_mgmt.c
+++ b/drivers/net/octeon/octeon_mgmt.c
@@ -832,9 +832,9 @@ static int octeon_mgmt_open(struct net_device *netdev)
 	mix_irhwm.s.irhwm = 0;
 	cvmx_write_csr(CVMX_MIXX_IRHWM(port), mix_irhwm.u64);
 
-	/* Interrupt when we have 5 or more packets to clean.  */
+	/* Interrupt when we have 1 or more packets to clean.  */
 	mix_orhwm.u64 = 0;
-	mix_orhwm.s.orhwm = 5;
+	mix_orhwm.s.orhwm = 1;
 	cvmx_write_csr(CVMX_MIXX_ORHWM(port), mix_orhwm.u64);
 
 	/* Enable receive and transmit interrupts */
@@ -995,7 +995,6 @@ static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	cvmx_write_csr(CVMX_MIXX_ORING2(port), 1);
 
 	netdev->trans_start = jiffies;
-	octeon_mgmt_clean_tx_buffers(p);
 	octeon_mgmt_update_tx_stats(netdev);
 	return NETDEV_TX_OK;
 }
-- 
1.6.6.1
