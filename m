Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 01:05:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1673 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492516Ab0EEXDx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 01:03:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4be1f9650004>; Wed, 05 May 2010 16:04:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o45N3Jtm011095;
        Wed, 5 May 2010 16:03:19 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o45N3JLe011094;
        Wed, 5 May 2010 16:03:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/6] netdev: octeon_mgmt: Fix race manipulating irq bits.
Date:   Wed,  5 May 2010 16:03:10 -0700
Message-Id: <1273100593-11043-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
References: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 05 May 2010 23:03:24.0145 (UTC) FILETIME=[29FA6610:01CAECA7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Don't re-read the interrupt status register, clear the exact bits we
will be testing.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/net/octeon/octeon_mgmt.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/net/octeon/octeon_mgmt.c b/drivers/net/octeon/octeon_mgmt.c
index b975a2f..633fa89 100644
--- a/drivers/net/octeon/octeon_mgmt.c
+++ b/drivers/net/octeon/octeon_mgmt.c
@@ -598,8 +598,7 @@ static irqreturn_t octeon_mgmt_interrupt(int cpl, void *dev_id)
 	mixx_isr.u64 = cvmx_read_csr(CVMX_MIXX_ISR(port));
 
 	/* Clear any pending interrupts */
-	cvmx_write_csr(CVMX_MIXX_ISR(port),
-		       cvmx_read_csr(CVMX_MIXX_ISR(port)));
+	cvmx_write_csr(CVMX_MIXX_ISR(port), mixx_isr.u64);
 	cvmx_read_csr(CVMX_MIXX_ISR(port));
 
 	if (mixx_isr.s.irthresh) {
-- 
1.6.6.1
