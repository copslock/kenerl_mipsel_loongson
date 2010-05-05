Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 01:04:19 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1665 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492510Ab0EEXDv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 01:03:51 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4be1f9650003>; Wed, 05 May 2010 16:04:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:23 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o45N3JMc011091;
        Wed, 5 May 2010 16:03:19 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o45N3Jdd011090;
        Wed, 5 May 2010 16:03:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/6] netdev: octeon_mgmt: Fix race condition freeing TX buffers.
Date:   Wed,  5 May 2010 16:03:09 -0700
Message-Id: <1273100593-11043-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
References: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 05 May 2010 23:03:24.0020 (UTC) FILETIME=[29E75340:01CAECA7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Under heavy load the TX cleanup tasklet and xmit threads would race
and try to free too many buffers.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/net/octeon/octeon_mgmt.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/octeon/octeon_mgmt.c b/drivers/net/octeon/octeon_mgmt.c
index bbbd737..b975a2f 100644
--- a/drivers/net/octeon/octeon_mgmt.c
+++ b/drivers/net/octeon/octeon_mgmt.c
@@ -189,12 +189,19 @@ static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 
 	mix_orcnt.u64 = cvmx_read_csr(CVMX_MIXX_ORCNT(port));
 	while (mix_orcnt.s.orcnt) {
+		spin_lock_irqsave(&p->tx_list.lock, flags);
+
+		mix_orcnt.u64 = cvmx_read_csr(CVMX_MIXX_ORCNT(port));
+
+		if (mix_orcnt.s.orcnt == 0) {
+			spin_unlock_irqrestore(&p->tx_list.lock, flags);
+			break;
+		}
+
 		dma_sync_single_for_cpu(p->dev, p->tx_ring_handle,
 					ring_size_to_bytes(OCTEON_MGMT_TX_RING_SIZE),
 					DMA_BIDIRECTIONAL);
 
-		spin_lock_irqsave(&p->tx_list.lock, flags);
-
 		re.d64 = p->tx_ring[p->tx_next_clean];
 		p->tx_next_clean =
 			(p->tx_next_clean + 1) % OCTEON_MGMT_TX_RING_SIZE;
-- 
1.6.6.1
