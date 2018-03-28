Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:03:11 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3]:43934
        "EHLO bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994591AbeC1VCOmOtxC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:14 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id DC17626088B
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v4 04/15] mmc: jz4740: Use dev_get_platdata
Date:   Wed, 28 Mar 2018 18:00:46 -0300
Message-Id: <20180328210057.31148-5-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63307
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Instead of accessing the platform data pointer directly,
use the dev_get_platdata() helper.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index eb57f514a459..b11f65077ce7 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -926,7 +926,7 @@ static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
 static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 	struct platform_device *pdev)
 {
-	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int ret = 0;
 
 	if (!pdata)
@@ -955,7 +955,7 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 
 static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 {
-	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (!pdata)
 		return;
@@ -971,7 +971,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	struct jz4740_mmc_host *host;
 	struct jz4740_mmc_platform_data *pdata;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 
 	mmc = mmc_alloc_host(sizeof(struct jz4740_mmc_host), &pdev->dev);
 	if (!mmc) {
-- 
2.16.2
