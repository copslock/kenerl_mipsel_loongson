Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:52:15 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60585 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826606Ab2KKMuoY9Gqv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:44 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053447bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c040Gcj089aIEz6nX6pXwImA9KsEZ7hRxntyj9akQIQ=;
        b=0z2bY2WZKg+FZ7qOzurHzhQ29sUXb6u4XkKvfESQOeuuRnM12KrzHayw2wmHuSM5Pk
         r7kD3U1hwuH1lznBj9jsBevJdDXzNtb4u0eXT2it6kG9WKVUTeeUpMPpmAS3jfyKE6yM
         rH099hWVB+jWswVNIkmElOnjAbY0KcSWzJ5Wrw226q5bGehK49fKkX2MPcXl/RKXTfLG
         hMveZrp4BRJ6uXIhSSVz72AhJWUAyncf1PRbhr8a3INEoc4mxD+5CJxL0vENLsyEi+rg
         ajGYEbIWWdGzEKzXNoS8oroGTXk6JbHIBt6oQ7MzyszuQDi0a+wrews/z54eca9H/KP4
         3JFA==
Received: by 10.204.148.89 with SMTP id o25mr5904452bkv.11.1352638244183;
        Sun, 11 Nov 2012 04:50:44 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.42
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:43 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] bcm63xx-rng: use clk_{prepare_enable,disable_unprepare}
Date:   Sun, 11 Nov 2012 13:50:40 +0100
Message-Id: <1352638249-29298-7-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Use proper clk_prepare/unprepare calls in preparation for switching to
the generic clock framework.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/char/hw_random/bcm63xx-rng.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
index aec6a42..3693f56 100644
--- a/drivers/char/hw_random/bcm63xx-rng.c
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -122,7 +122,7 @@ static int __devinit bcm63xx_rng_probe(struct platform_device *pdev)
 		goto out_free_rng;
 	}
 
-	clk_enable(clk);
+	clk_prepare_enable(clk);
 
 	ret = hwrng_register(rng);
 	if (ret) {
@@ -135,7 +135,7 @@ static int __devinit bcm63xx_rng_probe(struct platform_device *pdev)
 	return 0;
 
 out_clk_disable:
-	clk_disable(clk);
+	clk_disable_unprepare(clk);
 out_free_rng:
 	platform_set_drvdata(pdev, NULL);
 	kfree(rng);
@@ -151,7 +151,7 @@ static int __devexit bcm63xx_rng_remove(struct platform_device *pdev)
 	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
 
 	hwrng_unregister(rng);
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 	kfree(priv);
 	kfree(rng);
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.2.5
