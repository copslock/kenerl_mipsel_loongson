Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 20:21:07 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:53362 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993030AbeGRSUpqDRUK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 20:20:45 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 02/17] dmaengine: dma-jz4780: Return error if not probed from DT
Date:   Wed, 18 Jul 2018 20:20:08 +0200
Message-Id: <20180718182023.8182-3-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938045; bh=Mj06wx96BqJqsNzQyX6qLzsRhLEMkGTkmupGf5oWocw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BXwORPYG4oLtE/W+VzWA7TeULYbybh2hgouYG8F6QyzPukJ6WRjDIHeXktWQ/GL2+/a9g0CAXjQA8rPEcHHXnzNHHU9TZNdyMj/NxkrPlRBtzcZh5e79YgVNev2VxUKJUt0KfbjnZ/KLMvmqc8fHtJNm9QbDTWpH2o8k0PgZtY8=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

The driver calls clk_get() with the clock name set to NULL, which means
that the driver could only work when probed from devicetree. From now
on, we explicitly require the driver to be probed from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 5 +++++
 1 file changed, 5 insertions(+)

 v2: New patch

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 85820a2d69d4..987899610b46 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -761,6 +761,11 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, ret;
 
+	if (!dev->of_node) {
+		dev_err(dev, "This driver must be probed from devicetree\n");
+		return -EINVAL;
+	}
+
 	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
 	if (!jzdma)
 		return -ENOMEM;
-- 
2.11.0
