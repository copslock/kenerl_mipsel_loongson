Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 03:10:41 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39331 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013097AbbBQCJjWO3Fq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2015 03:09:39 +0100
Received: by pablf10 with SMTP id lf10so2564888pab.6
        for <linux-mips@linux-mips.org>; Mon, 16 Feb 2015 18:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+7hrWsND8E7IicL7elpStEPLUib8GY2zMyssUl3eFeU=;
        b=U997Z1jcIJczi3z1Po1ovRPZeRyfO9+M92RoLuH/3mCZ+yWWdv9Sihb3yu/yo3X+oB
         gw8DrMDcyCedVNQr+O3U3/DlfYQRi7yqYZPCAKJYSitnMyzjwEqdk4QMSHRwJ/Bdh41g
         ezpAaIjVXfpEgqnwSvrdv4Gr3H0KtBr8sjY0wk0WB8i2LXsfomQ4uVWI/1E8Cow00Dec
         ZGrvHGXwgzc+JeS6tp+ooDjGYbbD0t+WX9FfP2f74fcpZP+En+Jj1gy2s3uGCqu8bWkK
         eSJj28J6hxKATp7nmTHEBeFyIzQcAKILbS3w2p1SSRqEFCWsJHShpv1ws6JkT5CwrdJP
         2nMA==
X-Received: by 10.66.242.141 with SMTP id wq13mr44351539pac.41.1424138973855;
        Mon, 16 Feb 2015 18:09:33 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id cq5sm13624562pbc.79.2015.02.16.18.09.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Feb 2015 18:09:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, wsa@the-dreams.de,
        cernekee@gmail.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4/4] hw_random: bcm63xx-rng: use devm_* helpers
Date:   Mon, 16 Feb 2015 18:09:16 -0800
Message-Id: <1424138956-11563-5-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
References: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Simplify the driver's probe function and error handling by using the
device managed allocators, while at it, drop the redundant "out of
memory" messages since these are already printed by the allocator.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/bcm63xx-rng.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
index c7f3af852599..27da00f68c8f 100644
--- a/drivers/char/hw_random/bcm63xx-rng.c
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -83,18 +83,16 @@ static int bcm63xx_rng_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
-		dev_err(&pdev->dev, "no memory for private structure\n");
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	rng = kzalloc(sizeof(*rng), GFP_KERNEL);
+	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
 	if (!rng) {
-		dev_err(&pdev->dev, "no memory for rng structure\n");
 		ret = -ENOMEM;
-		goto out_free_priv;
+		goto out;
 	}
 
 	platform_set_drvdata(pdev, rng);
@@ -109,7 +107,7 @@ static int bcm63xx_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "no clock for device\n");
 		ret = PTR_ERR(clk);
-		goto out_free_rng;
+		goto out;
 	}
 
 	priv->clk = clk;
@@ -118,7 +116,7 @@ static int bcm63xx_rng_probe(struct platform_device *pdev)
 					resource_size(r), pdev->name)) {
 		dev_err(&pdev->dev, "request mem failed");
 		ret = -ENOMEM;
-		goto out_free_rng;
+		goto out;
 	}
 
 	priv->regs = devm_ioremap_nocache(&pdev->dev, r->start,
@@ -126,7 +124,7 @@ static int bcm63xx_rng_probe(struct platform_device *pdev)
 	if (!priv->regs) {
 		dev_err(&pdev->dev, "ioremap failed");
 		ret = -ENOMEM;
-		goto out_free_rng;
+		goto out;
 	}
 
 	clk_enable(clk);
@@ -143,10 +141,6 @@ static int bcm63xx_rng_probe(struct platform_device *pdev)
 
 out_clk_disable:
 	clk_disable(clk);
-out_free_rng:
-	kfree(rng);
-out_free_priv:
-	kfree(priv);
 out:
 	return ret;
 }
@@ -158,8 +152,6 @@ static int bcm63xx_rng_remove(struct platform_device *pdev)
 
 	hwrng_unregister(rng);
 	clk_disable(priv->clk);
-	kfree(priv);
-	kfree(rng);
 
 	return 0;
 }
-- 
2.1.0
