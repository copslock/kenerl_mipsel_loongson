Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 20:03:18 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59800 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903741Ab1LITBy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 20:01:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 2C7AE38F867;
        Fri,  9 Dec 2011 20:01:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id akVCdUtynodv; Fri,  9 Dec 2011 20:01:53 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id BD7893616BD;
        Fri,  9 Dec 2011 20:01:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     Matt Mackall <mpm@selenic.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/5] MIPS: BCM63XX: add support for "ipsec" clock
Date:   Fri,  9 Dec 2011 20:01:07 +0100
Message-Id: <1323457270-16330-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1323457270-16330-1-git-send-email-florian@openwrt.org>
References: <1323457270-16330-1-git-send-email-florian@openwrt.org>
X-archive-position: 32073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7988

This module is only available on BCM6368 so far and does not require
resetting the block.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/clk.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 9d57c71..28137d5 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -222,6 +222,18 @@ static struct clk clk_xtm = {
 };
 
 /*
+ * IPsec clock
+ */
+static void ipsec_set(struct clk *clk, int enable)
+{
+	bcm_hwclock_set(CKCTL_6368_IPSEC_CLK_EN, enable);
+}
+
+static struct clk clk_ipsec = {
+	.set	= ipsec_set,
+};
+
+/*
  * Internal peripheral clock
  */
 static struct clk clk_periph = {
@@ -278,6 +290,8 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_periph;
 	if (BCMCPU_IS_6358() && !strcmp(id, "pcm"))
 		return &clk_pcm;
+	if (BCMCPU_IS_6368() && !strcmp(id, "ipsec"))
+		return &clk_ipsec;
 	return ERR_PTR(-ENOENT);
 }
 
-- 
1.7.5.4
