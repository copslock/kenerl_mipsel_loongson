Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 02:41:15 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44967 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835029Ab3FTAkhN-NbK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 02:40:37 +0200
Received: by mail-pd0-f182.google.com with SMTP id r10so5598105pdi.41
        for <linux-mips@linux-mips.org>; Wed, 19 Jun 2013 17:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hZb+EeUbCnvsNZ1NG9mxvuKiYeJzbVLTcYM84n0SLh0=;
        b=BGbMwbMAybnOuKxeGQ09Is5KqHpvo4+htthsVn6o3IfXE8uTCfOCaKuvDIynu4P3ma
         +yNTNkPRcEVX5Kj2TVDpKVyodizUaoy8cRU2ct3fKXV6FcYzKZQmwsZTD13qH+2Y03nk
         OY49hmmNp0hN28D9IWLqRonkeA+YDeI1QxO5pagucjPt83LEBN4F6HjPOWIBeUmaRV/Q
         bmmOeK//fO/r89IQc4TKMoRAQOKBAAdpptLwC2qt8hWWHqj+pX3gTenHVKCEm34YlcnM
         UMhAWJNYi8X6yN5yQMHs4rgsOg7GUrLD9BM2SM7Ko2ovuLPd6oB9scUhc/MewdjN8VMy
         w+yA==
X-Received: by 10.68.213.231 with SMTP id nv7mr5236300pbc.70.1371688830921;
        Wed, 19 Jun 2013 17:40:30 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vu5sm26973580pab.10.2013.06.19.17.40.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 17:40:29 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5K0eRt0004624;
        Wed, 19 Jun 2013 17:40:28 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5K0eRtZ004623;
        Wed, 19 Jun 2013 17:40:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] netdev: octeon_mgmt: Correct tx IFG workaround.
Date:   Wed, 19 Jun 2013 17:40:19 -0700
Message-Id: <1371688820-4585-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37035
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

From: David Daney <david.daney@cavium.com>

The previous fix was still too agressive to meet ieee specs.  Increase
to (14, 10).

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index e6e0292..1ef4148 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -1141,10 +1141,13 @@ static int octeon_mgmt_open(struct net_device *netdev)
 		/* For compensation state to lock. */
 		ndelay(1040 * NS_PER_PHY_CLK);
 
-		/* Some Ethernet switches cannot handle standard
-		 * Interframe Gap, increase to 16 bytes.
+		/* Default Interframe Gaps are too small.  Recommended
+		 * workaround is.
+		 *
+		 * AGL_GMX_TX_IFG[IFG1]=14
+		 * AGL_GMX_TX_IFG[IFG2]=10
 		 */
-		cvmx_write_csr(CVMX_AGL_GMX_TX_IFG, 0x88);
+		cvmx_write_csr(CVMX_AGL_GMX_TX_IFG, 0xae);
 	}
 
 	octeon_mgmt_rx_fill_ring(netdev);
-- 
1.7.11.7
