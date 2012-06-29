Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2012 11:12:23 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:39691 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903437Ab2F2JMR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jun 2012 11:12:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id CEF3F9980C3;
        Fri, 29 Jun 2012 11:12:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HmXO2jLxtiPu; Fri, 29 Jun 2012 11:12:16 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 71BBC9979B9;
        Fri, 29 Jun 2012 11:12:16 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH mips-for-linux-next] hw_random: bcm63xx: fix section mismatch of the probe() function
Date:   Fri, 29 Jun 2012 11:09:41 +0200
Message-Id: <1340960981-25773-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 33866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ralf, since the random driver will be merged via your tree, can you
fold it in the patch "hw_random: add Broadcom BCM63xx RNG driver"?

Thanks!

 drivers/char/hw_random/bcm63xx-rng.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
index b789dbf..aec6a42 100644
--- a/drivers/char/hw_random/bcm63xx-rng.c
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -61,7 +61,7 @@ static int bcm63xx_rng_data_read(struct hwrng *rng, u32 *data)
 	return 4;
 }
 
-static int __init bcm63xx_rng_probe(struct platform_device *pdev)
+static int __devinit bcm63xx_rng_probe(struct platform_device *pdev)
 {
 	struct resource *r;
 	struct clk *clk;
-- 
1.7.9.5
