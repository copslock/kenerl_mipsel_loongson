Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:04:16 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994627AbeC1VC1oykBC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:27 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id D97A62608C5
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH v4 08/15] mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
Date:   Wed, 28 Mar 2018 18:00:50 -0300
Message-Id: <20180328210057.31148-9-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@collabora.com
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

From: Alex Smith <alex.smith@imgtec.com>

The maximum clock rate can be overridden by DT. The clock rate should
be set to the DT-specified value rather than the constant JZ_MMC_CLK_RATE
when this is done. If the maximum clock rate is not set by DT then
mmc->f_max will be set to JZ_MMC_CLK_RATE.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 03757cc55f52..aa635b458d2c 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -825,7 +825,7 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
 	int real_rate;
 
 	jz4740_mmc_clock_disable(host);
-	clk_set_rate(host->clk, JZ_MMC_CLK_RATE);
+	clk_set_rate(host->clk, host->mmc->f_max);
 
 	real_rate = clk_get_rate(host->clk);
 
-- 
2.16.2
