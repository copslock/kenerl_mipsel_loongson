Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Dec 2017 17:04:19 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:42719
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990921AbdLQQDWn54uz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Dec 2017 17:03:22 +0100
Received: by mail-wr0-x241.google.com with SMTP id s66so11938708wrc.9;
        Sun, 17 Dec 2017 08:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sz94BientDdbnXedge4DCQdUgDFRrgLWuCMGlT/8utA=;
        b=hKM6ijxuB9RvUGawfyIR3HR6D0mHwC/A3nAGStuFaMYp5IqSHfCf0x57Hbs1zocVTA
         zusbb0x7qt4N8OY6SNWoQa5pAer9d5yFpM/XPROVuw6MX66Rb18R7ylM2DEYOVixT7xl
         FgBJSGho1EZAm5lVrnV5qrVOweXdrrCi6saoeqYGBziho/MxbfdpfFyHrIp/G1YGEcPo
         j9iMe7MPWpBWk/Pc3V+j7mK7kGsTOoZKXmPs640wFo2YvR3Q6vFRjhopUKJqv6zWkQxB
         uLmGSbPSd6rcfQ46teSa9+W9mcT8FdNqLR032zwqFZI//V2wC06YSMAGFBRDrsaXPxUT
         w2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sz94BientDdbnXedge4DCQdUgDFRrgLWuCMGlT/8utA=;
        b=HP58e3KgFk4pQPuykxcWUzIMfAANtDU1EwooZID/qnkaypmRUucl2n8/+v3F6QAJd9
         IIaq1rEposn/YjHsvsLJ9seGSebfw21Kwd8YVhMKj8Cglv7JBD/J/w1ohYSaFw/iN0RU
         LI8XgaErr8JFE3DVC1fz0V2jRBqtHMrJpqOuUEUdgmGM+dFuhiaSWCDiZiGS2WjeP3AH
         eSySnYdz4fGeLAmzMaFOX/7bWq7RYT+rAZCJhvLuFoocJH3+flJ/IOvzrMdyDXk5eoFZ
         iDcfMwYCQKoVlLDsm380/BiRc0gfAAHnwcGjT6PCdRe6Lhku3wlfVGj+w4B3J7AWGBPU
         Ks8w==
X-Gm-Message-State: AKGB3mLmtkG4FNC8R9Y0SDbl/f3/BzoX4camXVLUTR8RnOrc6rpXs0/3
        kDoJtprKWH7Ls9AVaYsGgb4=
X-Google-Smtp-Source: ACJfBouG4ucvIE6ROzwozkeuqiKTSMynl6JEq8JFJfk+JH9V+k7p7xiXokjEB9Sy+yQloG3a4VJhHw==
X-Received: by 10.223.170.150 with SMTP id h22mr14952411wrc.26.1513526597458;
        Sun, 17 Dec 2017 08:03:17 -0800 (PST)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id e197sm6336019wmf.4.2017.12.17.08.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2017 08:03:17 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 2/4] bcm63xx_enet: use platform data for dma channel numbers
Date:   Sun, 17 Dec 2017 17:02:53 +0100
Message-Id: <20171217160255.30342-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171217160255.30342-1-jonas.gorski@gmail.com>
References: <20171217160255.30342-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61505
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

To reduce the reliance on device ids, pass the dma channel numbers to
the enet devices as platform data.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/dev-enet.c                          |  8 ++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h |  4 ++++
 drivers/net/ethernet/broadcom/bcm63xx_enet.c          | 11 ++---------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index e8284771d620..07b4c65a88a4 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -265,6 +265,14 @@ int __init bcm63xx_enet_register(int unit,
 		dpd->dma_chan_width = ENETDMA_CHAN_WIDTH;
 	}
 
+	if (unit == 0) {
+		dpd->rx_chan = 0;
+		dpd->tx_chan = 1;
+	} else {
+		dpd->rx_chan = 2;
+		dpd->tx_chan = 3;
+	}
+
 	ret = platform_device_register(pdev);
 	if (ret)
 		return ret;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
index c0bd47444cff..da39e4d326ba 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
@@ -55,6 +55,10 @@ struct bcm63xx_enet_platform_data {
 
 	/* DMA descriptor shift */
 	unsigned int dma_desc_shift;
+
+	/* dma channel ids */
+	int rx_chan;
+	int tx_chan;
 };
 
 /*
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 5a5886345da2..e603a6fe6349 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1752,15 +1752,6 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	priv->irq_tx = res_irq_tx->start;
 	priv->mac_id = pdev->id;
 
-	/* get rx & tx dma channel id for this mac */
-	if (priv->mac_id == 0) {
-		priv->rx_chan = 0;
-		priv->tx_chan = 1;
-	} else {
-		priv->rx_chan = 2;
-		priv->tx_chan = 3;
-	}
-
 	priv->mac_clk = devm_clk_get(&pdev->dev, "enet");
 	if (IS_ERR(priv->mac_clk)) {
 		ret = PTR_ERR(priv->mac_clk);
@@ -1792,6 +1783,8 @@ static int bcm_enet_probe(struct platform_device *pdev)
 		priv->dma_chan_width = pd->dma_chan_width;
 		priv->dma_has_sram = pd->dma_has_sram;
 		priv->dma_desc_shift = pd->dma_desc_shift;
+		priv->rx_chan = pd->rx_chan;
+		priv->tx_chan = pd->tx_chan;
 	}
 
 	if (priv->mac_id == 0 && priv->has_phy && !priv->use_external_mii) {
-- 
2.13.2
