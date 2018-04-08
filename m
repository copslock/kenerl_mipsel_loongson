Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2018 10:32:58 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:38894
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeDHIcvcdqgd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2018 10:32:51 +0200
Received: by mail-wm0-x244.google.com with SMTP id i3so9899219wmf.3
        for <linux-mips@linux-mips.org>; Sun, 08 Apr 2018 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VG06D/NsZWXo1xNHQMwheLQf5Yuz3NVXtyT8KQuDlGI=;
        b=KV/or28b1j9zyxQTHhTNjSL/ftkSVA1uVcn+PUW4QA+3wr3V4zkXbxbJqfv9NxtImE
         MgAV89A4Kl0aH7sgpziiB3pT/r/FlmLocc6gaL13NjzvUHvidIc6oZ1S0RBjbxVJ2xS4
         pCcYNV6AFzORTAddcFkv6e5UAKVgMxxF3Z7XXTBMA7hbwBg1waM4APYefAnPwIAmcfWP
         TMkNvx/aeyI0bnOLeer/LnMwOaKno7Bk6hS8F8PTMqpIaw3Ve+HB3tty5DM6Ry/uqIPM
         orS8u7YdHRfHUsWjQYvwbvd2p7XnsZz/B95uMzbLxf+cv5yT6NfSH4Mjmd8DUSpwogic
         zKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VG06D/NsZWXo1xNHQMwheLQf5Yuz3NVXtyT8KQuDlGI=;
        b=cmqmwshImZK2jtNHed3xU7gH2FO16SGpKnzx9WnM2LDnEqRPPDxAC2nS5C2rg0Q4Yz
         Ls7nNX1/sG0tOqaMIuLYuwucu97eL/XGJmQaTyzv/WgTSBq+dLCHYalJZFHCIAIyuXxt
         3RDuxtUvt7obxkHdwrHID/u04WXbZcySBaOPAu0n0fItUSRtx0dtbScQ3vXZIQNKNovV
         sf7jyIXgLipyDni41hDT4B9vvQLg9zOJwNzXmmPZ28hvmWh8+v1WwY1x8g0XP4RW+oWb
         PioJSOyl/k1iQwKVuViuAFV1FUV4ANuAVIt5Ou9UNwvgZWL8RU4MqpbNGrGSmWgAIwwV
         Z9EA==
X-Gm-Message-State: AElRT7HNlTioj9htgjWPHs5lpAQIXNKzSAfElOhcWITHPctyF9iblP0s
        tncQefA4N44mrt7yyV79ER9r9g==
X-Google-Smtp-Source: AIpwx4+PpHmh33bsHFSHu38EylOQ3J4Fok+cpJnChFWZpNyTZWq2B2anDZYf67mB5imTD+3gnMK+bA==
X-Received: by 10.28.87.73 with SMTP id l70mr18897862wmb.123.1523176366066;
        Sun, 08 Apr 2018 01:32:46 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p2003008C2F64C100E07D0BF39ABE0ACD.dip0.t-ipconnect.de. [2003:8c:2f64:c100:e07d:bf3:9abe:acd])
        by smtp.gmail.com with ESMTPSA id v74sm9014234wmv.48.2018.04.08.01.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Apr 2018 01:32:45 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     martin.blumenstingl@googlemail.com, hauke@hauke-m.de,
        stable@vger.kernel.org
Subject: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
Date:   Sun,  8 Apr 2018 10:30:03 +0200
Message-Id: <1523176203-18926-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

While doing a global software reset, these bits are not cleared and let
some bootloader fail to initialise the GPHYs. The bootloader don't
expect the GPHYs in reset, as they aren't during power on.

The asserts were a workaround for a wrong syscon-reboot mask. With a
mask set which includes the GPHY resets, these resets aren't required
any more.

Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd")
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 drivers/soc/lantiq/gphy.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
index 8d86594..8c31ae7 100644
--- a/drivers/soc/lantiq/gphy.c
+++ b/drivers/soc/lantiq/gphy.c
@@ -30,7 +30,6 @@ struct xway_gphy_priv {
 	struct clk *gphy_clk_gate;
 	struct reset_control *gphy_reset;
 	struct reset_control *gphy_reset2;
-	struct notifier_block gphy_reboot_nb;
 	void __iomem *membase;
 	char *fw_name;
 };
@@ -64,24 +63,6 @@ static const struct of_device_id xway_gphy_match[] = {
 };
 MODULE_DEVICE_TABLE(of, xway_gphy_match);
 
-static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
-{
-	return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
-}
-
-static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
-				   unsigned long code, void *unused)
-{
-	struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
-
-	if (priv) {
-		reset_control_assert(priv->gphy_reset);
-		reset_control_assert(priv->gphy_reset2);
-	}
-
-	return NOTIFY_DONE;
-}
-
 static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
 			  dma_addr_t *dev_addr)
 {
@@ -205,14 +186,6 @@ static int xway_gphy_probe(struct platform_device *pdev)
 	reset_control_deassert(priv->gphy_reset);
 	reset_control_deassert(priv->gphy_reset2);
 
-	/* assert the gphy reset because it can hang after a reboot: */
-	priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
-	priv->gphy_reboot_nb.priority = -1;
-
-	ret = register_reboot_notifier(&priv->gphy_reboot_nb);
-	if (ret)
-		dev_warn(dev, "Failed to register reboot notifier\n");
-
 	platform_set_drvdata(pdev, priv);
 
 	return ret;
@@ -224,17 +197,10 @@ static int xway_gphy_remove(struct platform_device *pdev)
 	struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
 	int ret;
 
-	reset_control_assert(priv->gphy_reset);
-	reset_control_assert(priv->gphy_reset2);
-
 	iowrite32be(0, priv->membase);
 
 	clk_disable_unprepare(priv->gphy_clk_gate);
 
-	ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
-	if (ret)
-		dev_warn(dev, "Failed to unregister reboot notifier\n");
-
 	return 0;
 }
 
-- 
2.7.4
