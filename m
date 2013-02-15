Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 20:52:07 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:55081 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827653Ab3BOTwGhmL1H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 20:52:06 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ah7X7Zp8aUbG; Fri, 15 Feb 2013 20:51:55 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 52F682801AE;
        Fri, 15 Feb 2013 20:51:54 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ath79: fix WMAC IRQ resource assignment
Date:   Fri, 15 Feb 2013 20:51:57 +0100
Message-Id: <1360957917-19196-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

The '.start' field of the IRQ resource assigned twice
in ar934x_wmac_setup(). The second assignment must
set the '.end' field. Fix it.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Note:

This is a fix for the existing code. The modified version of
the QCA955X specific patch will come later.

-Gabor
---
 arch/mips/ath79/dev-wmac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/dev-wmac.c b/arch/mips/ath79/dev-wmac.c
index 4f6c4e3..d71d745 100644
--- a/arch/mips/ath79/dev-wmac.c
+++ b/arch/mips/ath79/dev-wmac.c
@@ -107,7 +107,7 @@ static void ar934x_wmac_setup(void)
 	ath79_wmac_resources[0].start = AR934X_WMAC_BASE;
 	ath79_wmac_resources[0].end = AR934X_WMAC_BASE + AR934X_WMAC_SIZE - 1;
 	ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
-	ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
+	ath79_wmac_resources[1].end = ATH79_IP2_IRQ(1);
 
 	t = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
 	if (t & AR934X_BOOTSTRAP_REF_CLK_40)
-- 
1.7.10
