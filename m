Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 03:09:51 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43532 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013020AbbBQCJevBSSI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2015 03:09:34 +0100
Received: by pdev10 with SMTP id v10so40193501pde.10
        for <linux-mips@linux-mips.org>; Mon, 16 Feb 2015 18:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rciiJHq8mzvgtVrs8t1A6i7OfFpsBZwZCeqkLQdLACA=;
        b=iTlyK08L2386IhDVIR9e5MH7NsytigBbkkXoizqa7VtntsdkORqxI/cjFl6LSP5ic7
         Qk24wLw5VaxJZFtDBUyK1H0xZXHsjWJmJYaAMWqaJbkSiijOSCjQgvlhJHSsGDegNtSC
         LSLLp8U1dFWISeNLNSbj+x4zN6rEHmUYgqHgbjIOrds6kFkOQ0zsuLaBvRPfNINA+cMV
         UC622DxoubWWkeFAwMEGgR3bBIDRVvoypcBXctl14cuCsfKE0b6sL6D/TIanF4iqjeoQ
         jt8H4yptNwLghHhull+dEpWRjjX1gstqKrwNfe948AfnDrAisrDvY62nagJ3+BXyM9f7
         hTGQ==
X-Received: by 10.68.201.225 with SMTP id kd1mr45145960pbc.11.1424138969232;
        Mon, 16 Feb 2015 18:09:29 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id cq5sm13624562pbc.79.2015.02.16.18.09.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Feb 2015 18:09:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, wsa@the-dreams.de,
        cernekee@gmail.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/4] hw_random: bcm63xx-rng: drop bcm_{readl,writel} macros
Date:   Mon, 16 Feb 2015 18:09:13 -0800
Message-Id: <1424138956-11563-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
References: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45835
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

bcm_{readl,writel} macros expand to __raw_{readl,writel}, use these
directly such that we do not rely on the platform to provide these for
us. As a result, we no longer use bcm63xx_io.h, so remove that inclusion
too.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/bcm63xx-rng.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
index ba6a65ac023b..ed9b28b35a39 100644
--- a/drivers/char/hw_random/bcm63xx-rng.c
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
 
-#include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 
 struct bcm63xx_rng_priv {
@@ -28,9 +27,9 @@ static int bcm63xx_rng_init(struct hwrng *rng)
 	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
 	u32 val;
 
-	val = bcm_readl(priv->regs + RNG_CTRL);
+	val = __raw_readl(priv->regs + RNG_CTRL);
 	val |= RNG_EN;
-	bcm_writel(val, priv->regs + RNG_CTRL);
+	__raw_writel(val, priv->regs + RNG_CTRL);
 
 	return 0;
 }
@@ -40,23 +39,23 @@ static void bcm63xx_rng_cleanup(struct hwrng *rng)
 	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
 	u32 val;
 
-	val = bcm_readl(priv->regs + RNG_CTRL);
+	val = __raw_readl(priv->regs + RNG_CTRL);
 	val &= ~RNG_EN;
-	bcm_writel(val, priv->regs + RNG_CTRL);
+	__raw_writel(val, priv->regs + RNG_CTRL);
 }
 
 static int bcm63xx_rng_data_present(struct hwrng *rng, int wait)
 {
 	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
 
-	return bcm_readl(priv->regs + RNG_STAT) & RNG_AVAIL_MASK;
+	return __raw_readl(priv->regs + RNG_STAT) & RNG_AVAIL_MASK;
 }
 
 static int bcm63xx_rng_data_read(struct hwrng *rng, u32 *data)
 {
 	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
 
-	*data = bcm_readl(priv->regs + RNG_DATA);
+	*data = __raw_readl(priv->regs + RNG_DATA);
 
 	return 4;
 }
-- 
2.1.0
