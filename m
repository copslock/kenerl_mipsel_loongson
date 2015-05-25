Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 19:54:10 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:59920 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007134AbbEYRyJeRBnG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 May 2015 19:54:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id AAF5F2815AD;
        Mon, 25 May 2015 19:52:43 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from newshaker64.lan (dslb-088-073-027-024.088.073.pools.vodafone-ip.de [88.73.27.24])
        by arrakis.dune.hu (Postfix) with ESMTPSA id BDFA72803EE;
        Mon, 25 May 2015 19:52:41 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: ralink: fix clearing the illegal access interrupt
Date:   Mon, 25 May 2015 19:53:54 +0200
Message-Id: <1432576434-25962-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Due to a typo the illegal access interrupt is never cleared in by
the interupt handler, causing an effective deadlock on the first
illegal access.

This was broken since the code was introduced in 5433acd81e87 ("MIPS:
ralink: add illegal access driver"), but only exposed when the Kconfig
symbol was added, thus enabling the code.

Cc: <stable@vger.kernel.org>  [3.18+]
Fixes: a7b7aad383c ("MIPS: ralink: add missing symbol for RALINK_ILL_ACC")
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/ralink/ill_acc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index e20b02e..e10d10b 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -41,7 +41,7 @@ static irqreturn_t ill_acc_irq_handler(int irq, void *_priv)
 		addr, (type >> ILL_ACC_OFF_S) & ILL_ACC_OFF_M,
 		type & ILL_ACC_LEN_M);
 
-	rt_memc_w32(REG_ILL_ACC_TYPE, REG_ILL_ACC_TYPE);
+	rt_memc_w32(ILL_INT_STATUS, REG_ILL_ACC_TYPE);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.10.4
