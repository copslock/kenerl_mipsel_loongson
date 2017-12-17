Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Dec 2017 17:03:56 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:36526
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990596AbdLQQDVsQXDz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Dec 2017 17:03:21 +0100
Received: by mail-wm0-x243.google.com with SMTP id b76so25467354wmg.1;
        Sun, 17 Dec 2017 08:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w27KZXIwfBNaATUSSccmRx/zCZmE47tJ8h3os6vaOhs=;
        b=XPwz0Cf1PfyjyTQqunrn8vmggm1SGkdtNKa3dabolaZqFFnVT99At653oVppR1Huwm
         ZtGTXoSFlWZY969xo2GAJBMzE5TDxqosb/PbJo5ADcYFVUIA5Ylw3yRisHOvj+8ui8v2
         Ijz8KfUduS8Xf8xz8ncVzt688xJZWb0j0twzLTTfSPOR5pmHxo9KR2Hsozqh8DSHvp9H
         gIBILaPQY8Y04SlTfsyIQle1rOCUw1jOvv47+Jrko7lb7qOshdVK2igaBKUhVqG0QoeY
         PFY7ONe4j1dD7tbEJyvi296q1tzik1U3zX114mviebA70mwmT5kYDep2WP2uABkyDAr1
         SAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w27KZXIwfBNaATUSSccmRx/zCZmE47tJ8h3os6vaOhs=;
        b=IpWGuyIR+B+AmOvG2EUO8Ze2zRF8cz0m4ucYL10bvkgfWB6XNUMsHbrZGx7uwKVXB/
         YhwqQuBDHG49G2dzeq0OjTWizy17HE4tV4PEkQ60KKTcsyLaDAMqcakEvFK0qCKU3OgP
         lCmsBoZ3/mx2hzxoXZ+A64WfQO3Buyh6z+V5cL/y0/LOlvq5bZQhXcgSFyWmSy8vrlvi
         QFlndo9rBRzlOfLNd7E2UnhJQa7dA2lDdPUfiyfi8ozKKAlRL4YWNWCUWI1ojTX07Va+
         mBHWZBYSwzX0gOQIvDLo+p1XJ0/+Vg5t6r23s27d8VC7rio0DH2VNszcga5ZzdLK8Tyd
         2yUA==
X-Gm-Message-State: AKGB3mKefzfmNAInLf0WM7IqW2paQpxj7UAmK9iwZsm+9pQtWslkZgSM
        ekd6KXWBORbG9uKW0ZS7iTQ=
X-Google-Smtp-Source: ACJfBotsPFX8KfZNCWgGfnip9XLx+6mODToxSbLf+R2qvKW0Qu9i+lYpLGLvgE1Hs/6gkbUQdTjmWQ==
X-Received: by 10.28.5.198 with SMTP id 189mr9850289wmf.29.1513526596411;
        Sun, 17 Dec 2017 08:03:16 -0800 (PST)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id e197sm6336019wmf.4.2017.12.17.08.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2017 08:03:15 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 1/4] bcm63xx_enet: just use "enet" as the clock name
Date:   Sun, 17 Dec 2017 17:02:52 +0100
Message-Id: <20171217160255.30342-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171217160255.30342-1-jonas.gorski@gmail.com>
References: <20171217160255.30342-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61504
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

Now that we have the individual clocks available as "enet" we
don't need to rely on the device id for them anymore.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index d9346e2ac720..5a5886345da2 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1716,7 +1716,6 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	struct bcm63xx_enet_platform_data *pd;
 	struct resource *res_mem, *res_irq, *res_irq_rx, *res_irq_tx;
 	struct mii_bus *bus;
-	const char *clk_name;
 	int i, ret;
 
 	if (!bcm_enet_shared_base[0])
@@ -1757,14 +1756,12 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	if (priv->mac_id == 0) {
 		priv->rx_chan = 0;
 		priv->tx_chan = 1;
-		clk_name = "enet0";
 	} else {
 		priv->rx_chan = 2;
 		priv->tx_chan = 3;
-		clk_name = "enet1";
 	}
 
-	priv->mac_clk = devm_clk_get(&pdev->dev, clk_name);
+	priv->mac_clk = devm_clk_get(&pdev->dev, "enet");
 	if (IS_ERR(priv->mac_clk)) {
 		ret = PTR_ERR(priv->mac_clk);
 		goto out;
-- 
2.13.2
