Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:52:54 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35486 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826609Ab2KKMuqHXwMa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:46 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053444bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o1j8t4tyqjOc3R6Kkv7FyAq+/ksowhquNFVVmhZH22I=;
        b=LSJVk/ChyXp4VS+THVe2VjW8lRKX0Q/aMVlEsvhoGl6BQEiuFJZYaHT5nmaSryCeeH
         9e3rKSRrQxc4MBKV+4jmZru4s6xob6izhvLmj2KpKWXCVz0XnGt9pLDKRkRKZfxEiEnw
         APjLmbsWy9Q8dQsDisRTHLsCTN2vPknaENKHXhs6uMtQguL5Q6ckDng63mS4nPrxmbwo
         cE73UqZuRSLmJgA+1Olq9epqTvupyhshEWq+e6fA9MgHyPZAUzN3Eq3fN7dagz5Voqmd
         R7pADGf1hTxdv3uIIoWF5b5gcO1CUItfjUFR8PL2UYcYZ8nSYVaN/bkZLVOwMbVCvJuT
         tSlg==
Received: by 10.204.146.83 with SMTP id g19mr6092415bkv.33.1352638245890;
        Sun, 11 Nov 2012 04:50:45 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.44
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:45 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] net: ethernet: bcm63xx_enet: use clk_{prepare_enable,disable_unprepare}
Date:   Sun, 11 Nov 2012 13:50:41 +0100
Message-Id: <1352638249-29298-8-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34938
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
 drivers/net/ethernet/broadcom/bcm63xx_enet.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index c7ca7ec..9449e13 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1677,7 +1677,7 @@ static int __devinit bcm_enet_probe(struct platform_device *pdev)
 		ret = PTR_ERR(priv->mac_clk);
 		goto out_unmap;
 	}
-	clk_enable(priv->mac_clk);
+	clk_prepare_enable(priv->mac_clk);
 
 	/* initialize default and fetch platform data */
 	priv->rx_ring_size = BCMENET_DEF_RX_DESC;
@@ -1706,7 +1706,7 @@ static int __devinit bcm_enet_probe(struct platform_device *pdev)
 			priv->phy_clk = NULL;
 			goto out_put_clk_mac;
 		}
-		clk_enable(priv->phy_clk);
+		clk_prepare_enable(priv->phy_clk);
 	}
 
 	/* do minimal hardware init to be able to probe mii bus */
@@ -1808,12 +1808,12 @@ out_uninit_hw:
 	/* turn off mdc clock */
 	enet_writel(priv, 0, ENET_MIISC_REG);
 	if (priv->phy_clk) {
-		clk_disable(priv->phy_clk);
+		clk_disable_unprepare(priv->phy_clk);
 		clk_put(priv->phy_clk);
 	}
 
 out_put_clk_mac:
-	clk_disable(priv->mac_clk);
+	clk_disable_unprepare(priv->mac_clk);
 	clk_put(priv->mac_clk);
 
 out_unmap:
@@ -1864,10 +1864,10 @@ static int __devexit bcm_enet_remove(struct platform_device *pdev)
 
 	/* disable hw block clocks */
 	if (priv->phy_clk) {
-		clk_disable(priv->phy_clk);
+		clk_disable_unprepare(priv->phy_clk);
 		clk_put(priv->phy_clk);
 	}
-	clk_disable(priv->mac_clk);
+	clk_disable_unprepare(priv->mac_clk);
 	clk_put(priv->mac_clk);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.2.5
