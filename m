Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 14:36:25 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:52566 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822066AbaFRMfoVjTrH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 14:35:44 +0200
X-IronPort-AV: E=Sophos;i="5.01,499,1400050800"; 
   d="scan'208";a="34780334"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 18 Jun 2014 05:40:41 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 18 Jun 2014 05:35:36 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 18 Jun 2014 05:35:36 -0700
Received: from netl-oss-2.ban.broadcom.com (unknown [10.132.128.135])   by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1B1569F9F9;  Wed, 18 Jun
 2014 05:35:32 -0700 (PDT)
From:   <ganesanr@broadcom.com>
To:     <kristina.martsenko@gmail.com>, <gregkh@linuxfoundation.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>,
        <jchandra@broadcom.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <netdev@vger.kernel.org>
Subject: [PATCH 1/3] Staging: Fix compilation error
Date:   Wed, 18 Jun 2014 18:43:56 +0530
Message-ID: <21dec378b0ed417152176d2cc1600ce7c61ad486.1403096668.git.ganesanr@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1403096668.git.ganesanr@broadcom.com>
References: <cover.1403096668.git.ganesanr@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <ganesanr@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ganesanr@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Cop2 save and restore function names are changed, added that change

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
---
 drivers/staging/netlogic/xlr_net.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index 75d7c63..69ae8b6 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -125,9 +125,9 @@ static int send_to_rfr_fifo(struct xlr_net_priv *priv, void *addr)
 	msg.msg3 = 0;
 	stnid = priv->nd->rfr_station;
 	do {
-		mflags = nlm_cop2_enable();
+		mflags = nlm_cop2_enable_irqsave();
 		ret = nlm_fmn_send(1, 0, stnid, &msg);
-		nlm_cop2_restore(mflags);
+		nlm_cop2_disable_irqrestore(mflags);
 		if (ret == 0)
 			return 0;
 	} while (++num_try < 10000);
@@ -299,9 +299,9 @@ static netdev_tx_t xlr_net_start_xmit(struct sk_buff *skb,
 	u32 flags;
 
 	xlr_make_tx_desc(&msg, virt_to_phys(skb->data), skb);
-	flags = nlm_cop2_enable();
+	flags = nlm_cop2_enable_irqsave();
 	ret = nlm_fmn_send(2, 0, priv->nd->tx_stnid, &msg);
-	nlm_cop2_restore(flags);
+	nlm_cop2_disable_irqrestore(flags);
 	if (ret)
 		dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
-- 
1.7.9.5
