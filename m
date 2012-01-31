Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:16:11 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59760 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904036Ab2AaOMs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:12:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 467B635D006;
        Tue, 31 Jan 2012 15:12:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FLXBmDzUp8xV; Tue, 31 Jan 2012 15:12:47 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id B6117358976;
        Tue, 31 Jan 2012 15:12:47 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/5 v2] MIPS: BCM63XX: add support for "ipsec" clock
Date:   Tue, 31 Jan 2012 15:12:22 +0100
Message-Id: <1328019145-5946-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019145-5946-1-git-send-email-florian@openwrt.org>
References: <1328019145-5946-1-git-send-email-florian@openwrt.org>
X-archive-position: 32360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This module is only available on BCM6368 so far and does not require
resetting the block.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- rebased against "MIPS: BCM63XX: misc cleanup"

 arch/mips/bcm63xx/clk.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index be49b9a..1db48ad 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -224,6 +224,18 @@ static struct clk clk_xtm = {
 };
 
 /*
+ * IPsec clock
+ */
+static void ipsec_set(struct clk *clk, int enable)
+{
+	bcm_hwclock_set(CKCTL_6368_IPSEC_EN, enable);
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
@@ -280,6 +292,8 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_periph;
 	if (BCMCPU_IS_6358() && !strcmp(id, "pcm"))
 		return &clk_pcm;
+	if (BCMCPU_IS_6368() && !strcmp(id, "ipsec"))
+		return &clk_ipsec;
 	return ERR_PTR(-ENOENT);
 }
 
-- 
1.7.5.4
