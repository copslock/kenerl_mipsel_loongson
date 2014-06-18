Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 14:36:05 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:56845 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859953AbaFRMflz4nIm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 14:35:41 +0200
X-IronPort-AV: E=Sophos;i="5.01,499,1400050800"; 
   d="scan'208";a="35032630"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw2-out.broadcom.com with ESMTP; 18 Jun 2014 05:40:06 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 18 Jun 2014 05:35:39 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Wed, 18 Jun 2014 05:35:39 -0700
Received: from netl-oss-2.ban.broadcom.com (unknown [10.132.128.135])   by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 85F259F9F9;  Wed, 18 Jun
 2014 05:35:37 -0700 (PDT)
From:   <ganesanr@broadcom.com>
To:     <kristina.martsenko@gmail.com>, <gregkh@linuxfoundation.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>,
        <jchandra@broadcom.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <netdev@vger.kernel.org>
Subject: [PATCH 2/3] Staging: PHY address calculation fix
Date:   Wed, 18 Jun 2014 18:43:57 +0530
Message-ID: <20fcbf14feaa9b27cd043a1d6af21debacacf63a.1403096668.git.ganesanr@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1403096668.git.ganesanr@broadcom.com>
References: <cover.1403096668.git.ganesanr@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <ganesanr@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40626
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

SGMII PHY address calculation should be based on phy_addr of priv data

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
---
 drivers/staging/netlogic/xlr_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index 69ae8b6..6d7a6a7 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -776,7 +776,7 @@ static void xlr_sgmii_init(struct xlr_net_priv *priv)
 	xlr_nae_wreg(priv->gpio_addr, 0x21, 0x7104);
 
 	/* enable autoneg - more magic */
-	phy = priv->port_id % 4 + 27;
+	phy = priv->phy_addr % 4 + 27;
 	xlr_phy_write(priv->pcs_addr, phy, 0, 0x1000);
 	xlr_phy_write(priv->pcs_addr, phy, 0, 0x0200);
 }
-- 
1.7.9.5
