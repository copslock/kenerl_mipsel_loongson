Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Dec 2017 17:04:41 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:35234
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbdLQQDXsjP5z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Dec 2017 17:03:23 +0100
Received: by mail-wr0-x242.google.com with SMTP id z104so2998695wrb.2;
        Sun, 17 Dec 2017 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHKOb+MRH5zMX2KgeF7i9ex4zIEEdtfK1Zx4hI8sW+c=;
        b=c1CMEIBQXkmw1zQnyQpXdnXUN7XEoj6rqVrB7mF6JkB1OxVby32HaNn7OHT2mW1vmE
         BNxS2Xx2tbb5UdDtBBCqyVi1H90FtRUF81LVHrfK2a+Iyc2ZYx/ufCzk/5yuPK65osCO
         BuHWRJyviBbJvfbSTL98RKyDhqFgh87zpHl15WEYjzydI9nOLia4KPgKhjXbvSCkRr5e
         MJWjhV99bueiJGGXUec9vAaRMb3giuyRW4PiwvhxUU8x3It/ko8Nola8zU/q6/t606ID
         L/EP4WXotc7QIaTBS7bm8VQMIQWCHPGnOXq/PYpuYmOWnP7b4vmdEVxN+atQurOdrMSs
         gyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cHKOb+MRH5zMX2KgeF7i9ex4zIEEdtfK1Zx4hI8sW+c=;
        b=lhWHaFJ7fcp3zAl8ArmcuHUVdVJrjFORNYxaKCeo7yQ2rIl1dYclnEXKyWbeEGNMRU
         z83g1q19yEB0nfzWNk0iZ+5q28yCnZ5UyUCYb0y0HvrxS41zLwJUvFYdftOoI510Xedz
         UqwGDnlM+Lowr2KaI1nfJ5jbk7ky6UjVDG4yQQlY/wa4ckM7mIyP18TKX0Vxix4C/AmK
         3rpA8KZ4SgbifSceExBJCLifm5G4998dbuEnC0BtKnDb+j7vLVZp0Ukk0AjhmoePLgZv
         30MvnkzCV6+68LDiNiXtiHBAFi4C2FVwxLYcRBetasEPiRZfbwOOglzI44RTUtNlHjYj
         KwLg==
X-Gm-Message-State: AKGB3mJOUa+dvOcukAH+shtdZEw4u+CZeROLM8Z/8my6fw17pA++Xdha
        ssKjIdgYPmKNYYgF08BX4fk=
X-Google-Smtp-Source: ACJfBov1ve+htjJtDxAekZ1A1vGFeq4z+SUnPGHyK0SxMf901x0G9FoCIpIZbsodlsrgWCnV/ABR1A==
X-Received: by 10.223.163.216 with SMTP id m24mr15440408wrb.107.1513526598539;
        Sun, 17 Dec 2017 08:03:18 -0800 (PST)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id e197sm6336019wmf.4.2017.12.17.08.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2017 08:03:18 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 3/4] bcm63xx_enet: remove pointless mac_id check
Date:   Sun, 17 Dec 2017 17:02:54 +0100
Message-Id: <20171217160255.30342-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171217160255.30342-1-jonas.gorski@gmail.com>
References: <20171217160255.30342-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61506
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

Enabling the ephy clock for mac 1 is harmless, and the actual usage of
the ephy is not restricted to mac 0, so we might as well remove the
check.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index e603a6fe6349..d4519c621d08 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1787,7 +1787,7 @@ static int bcm_enet_probe(struct platform_device *pdev)
 		priv->tx_chan = pd->tx_chan;
 	}
 
-	if (priv->mac_id == 0 && priv->has_phy && !priv->use_external_mii) {
+	if (priv->has_phy && !priv->use_external_mii) {
 		/* using internal PHY, enable clock */
 		priv->phy_clk = devm_clk_get(&pdev->dev, "ephy");
 		if (IS_ERR(priv->phy_clk)) {
-- 
2.13.2
