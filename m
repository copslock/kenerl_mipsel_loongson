Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:03:25 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3]:43952
        "EHLO bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeC1VCSCt2rC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:18 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E95DB260844
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v4 05/15] mmc: jz4740: Reset the device requesting the interrupt
Date:   Wed, 28 Mar 2018 18:00:47 -0300
Message-Id: <20180328210057.31148-6-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63308
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

From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

In case a bootloader leaves the device in a bad state,
requesting the interrupt before resetting results in a bad
interrupt loop.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
[Ezequiel: cleanup commit description]
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index b11f65077ce7..9f316d953b30 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1027,6 +1027,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	spin_lock_init(&host->lock);
 	host->irq_mask = 0xffff;
 
+	jz4740_mmc_reset(host);
+
 	ret = request_threaded_irq(host->irq, jz_mmc_irq, jz_mmc_irq_worker, 0,
 			dev_name(&pdev->dev), host);
 	if (ret) {
@@ -1034,7 +1036,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_gpios;
 	}
 
-	jz4740_mmc_reset(host);
 	jz4740_mmc_clock_disable(host);
 	timer_setup(&host->timeout_timer, jz4740_mmc_timeout, 0);
 
-- 
2.16.2
