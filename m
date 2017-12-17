Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Dec 2017 17:05:03 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:35236
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991534AbdLQQDZAGF1z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Dec 2017 17:03:25 +0100
Received: by mail-wr0-x244.google.com with SMTP id z104so2998724wrb.2;
        Sun, 17 Dec 2017 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gEtf1b6b8xM7vtvcIuT/adaeyiuLdF3ms8NE6QwmSSk=;
        b=XUwr84PnxYB96g/DJZ5IQc/741tvkmwAt0q3bbLokLnOporxzsIR+q8VyY9Bp3IPiR
         7gKoeILxDip18MMcF+4+yQS3+moeV3Je5cGmLwwxeR0StlxOkc1RT1hYwtZpjEuA98YO
         y51eqXCiQ1CwnyG28DjJQUwboj00GWsiKJp8DeN1dgczhB7UfdMjJeM9WkEROg1NdfTz
         4nCMEJuZHmZzKYwS/paVylyRGxue9VNxnp37d8NTxVGm0v32YSfYv95Gr8m7PuQGft2g
         KeYZkOPR6uz9p4eEu27gL9nVbIoHdiIt+70NH+JOGPF3giBjZsGrEBhPvfOZk8KPmeOK
         BYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gEtf1b6b8xM7vtvcIuT/adaeyiuLdF3ms8NE6QwmSSk=;
        b=o/ofh77yHLEHe9VUb398R1ucAsSZW5L9NIRdcGHhPNepjWRdysYQieQJgJh6duj/db
         PKefXbRnzj8C8OtwzondJ47g8RWgD+TT6w7/Me5N89OUm268cmVzKw++MENiz/247ETq
         e/ihntfMvrlnpK8K6agbNTc00hodcrR2cZUJ093rvOsZQzNSvsNZXgJeVuVL9UDhmv/2
         D3Zizug8Arqebb4K3ZWsbdjz4bzFJFSvSsuhZkWn+lC6LslDsZb9r4T1qopB5/5yhHpK
         8sjDJO3u5SqqVStAUoN+tSeooSqR20LEvohZ8quMpBRMcABCkwyjc1WWRmVA1o53cJtn
         xw7A==
X-Gm-Message-State: AKGB3mIpN4gH09kSYttjng/MgzuuvLhfVCuOmqHHigw/25c/qUeLHBHG
        G2POhoAS7P5Zc4fIZKtZF83+dg==
X-Google-Smtp-Source: ACJfBosel9UFZYnTkh2TJwwz9ZuHnD4NzlQG2cLBO/oBQWEiuqWrhPbNLBcJHO6S4pXZUUJvVELiCQ==
X-Received: by 10.223.182.147 with SMTP id j19mr14709002wre.159.1513526599696;
        Sun, 17 Dec 2017 08:03:19 -0800 (PST)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id e197sm6336019wmf.4.2017.12.17.08.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2017 08:03:19 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 4/4] bcm63xx_enet: use platform device id directly for miibus name
Date:   Sun, 17 Dec 2017 17:02:55 +0100
Message-Id: <20171217160255.30342-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171217160255.30342-1-jonas.gorski@gmail.com>
References: <20171217160255.30342-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61507
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

Directly use the platform device for generating the miibus name. This
removes the last user of bcm_enet_priv::mac_id and we can remove the
field.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 3 +--
 drivers/net/ethernet/broadcom/bcm63xx_enet.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index d4519c621d08..1fbbbabe7588 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1750,7 +1750,6 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	dev->irq = priv->irq = res_irq->start;
 	priv->irq_rx = res_irq_rx->start;
 	priv->irq_tx = res_irq_tx->start;
-	priv->mac_id = pdev->id;
 
 	priv->mac_clk = devm_clk_get(&pdev->dev, "enet");
 	if (IS_ERR(priv->mac_clk)) {
@@ -1818,7 +1817,7 @@ static int bcm_enet_probe(struct platform_device *pdev)
 		bus->priv = priv;
 		bus->read = bcm_enet_mdio_read_phylib;
 		bus->write = bcm_enet_mdio_write_phylib;
-		sprintf(bus->id, "%s-%d", pdev->name, priv->mac_id);
+		sprintf(bus->id, "%s-%d", pdev->name, pdev->id);
 
 		/* only probe bus where we think the PHY is, because
 		 * the mdio read operation return 0 instead of 0xffff
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.h b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
index 5a66728d4776..1d3c917eb830 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.h
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
@@ -193,9 +193,6 @@ struct bcm_enet_mib_counters {
 
 struct bcm_enet_priv {
 
-	/* mac id (from platform device id) */
-	int mac_id;
-
 	/* base remapped address of device */
 	void __iomem *base;
 
-- 
2.13.2
