Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 15:13:59 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:36861
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993886AbdJFNNxDqDTS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 15:13:53 +0200
Received: by mail-pg0-x244.google.com with SMTP id u144so314001pgb.3;
        Fri, 06 Oct 2017 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fpAdbgW6cAXIt5rcE93j1TcNGZ5jid/ujIamWsf5vdM=;
        b=qrdfWX0/pOkHGBniHNfuJyN4zeGpqhl43rZ1r0W5Y0qRbhzPwicWyJvQP2Zxm6Wdcf
         aJ7CCdQD24M08RHFwBKyZKH8AapzuJKPpPYahPTsh/WtaDPLLx5w7odGRbTOoKp0UiRa
         ZFEKuzhwE7el8yGJ8LAwGIxKP2m85MuFYTae/Buzczl0nQj58JNuv4/hC6+lFoerlGV0
         WnkmLrUki/gCkQyLQxzEj5TN464f1qiBpv8F5XZihZVQTCKf5oZfeaxb8PUkBBBn4Z5S
         8crqA+X3swrSxbfv232a+dgR4IthTrGJT6Atl8WyejFGOAZUPGQR+qb4M2V5BEXPr3u4
         vHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fpAdbgW6cAXIt5rcE93j1TcNGZ5jid/ujIamWsf5vdM=;
        b=q/zI5j5PsqFExMN07bgwG9OgYFFCjecvU6Gq4FPLLzNexm8KHE6A7tx4hCHKvgJz2s
         YIYogZF3+/cjJZICHR5K7WHA1p0/sYM/gGs9n67RlvkufWYQ9enCGs5GWoLDW90DSpXQ
         LGJucuMMY7caL2BfPLkiOeGIVCwNJqgDx+aBNs2K8llRPNCHQ3tLbnDnWy5foirKYGe3
         5NQlrDn/rBsxq3NwhbL348rdta+aetx8jvRnomJmv7HmQc0I67M10EVjtqHa0UdWDV2J
         M3h3pee6oNaQ4Ov/efum/DwVfo2T09vnDBuhna9CIdiI737B/ZFWQtkkADyogsx6UJaT
         GZqg==
X-Gm-Message-State: AMCzsaXtJ7exkvAIdREh0d/03mnYE2FGVsma/3GV0ncv9bN/fgXV6Lv0
        ttER1TfjGBrBnrGnDHefznAK4SlD
X-Google-Smtp-Source: AOwi7QBYd+RIPGGs6/fBP/zUISxyX/LTjLA0RLPjDlxGhEJXiXo//yD8ilTqANElu8uQj/4OX1Bcwg==
X-Received: by 10.84.224.76 with SMTP id a12mr1969946plt.207.1507295626190;
        Fri, 06 Oct 2017 06:13:46 -0700 (PDT)
Received: from localhost.lan ([117.175.131.50])
        by smtp.gmail.com with ESMTPSA id v10sm2796599pgf.8.2017.10.06.06.13.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 06:13:45 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: loongson1: set default number of rx and tx queues for stmmac
Date:   Fri,  6 Oct 2017 21:13:18 +0800
Message-Id: <20171006131318.9033-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.13.6
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

Set the default number of RX and TX queues due to
the recent changes of stmmac driver.
Otherwise the ethernet will crash once it starts.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/loongson32/common/platform.c | 38 +++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 100f23d..ac584c5 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -183,18 +183,20 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 }
 
 static struct plat_stmmacenet_data ls1x_eth0_pdata = {
-	.bus_id		= 0,
-	.phy_addr	= -1,
+	.bus_id			= 0,
+	.phy_addr		= -1,
 #if defined(CONFIG_LOONGSON1_LS1B)
-	.interface	= PHY_INTERFACE_MODE_MII,
+	.interface		= PHY_INTERFACE_MODE_MII,
 #elif defined(CONFIG_LOONGSON1_LS1C)
-	.interface	= PHY_INTERFACE_MODE_RMII,
+	.interface		= PHY_INTERFACE_MODE_RMII,
 #endif
-	.mdio_bus_data	= &ls1x_mdio_bus_data,
-	.dma_cfg	= &ls1x_eth_dma_cfg,
-	.has_gmac	= 1,
-	.tx_coe		= 1,
-	.init		= ls1x_eth_mux_init,
+	.mdio_bus_data		= &ls1x_mdio_bus_data,
+	.dma_cfg		= &ls1x_eth_dma_cfg,
+	.has_gmac		= 1,
+	.tx_coe			= 1,
+	.rx_queues_to_use	= 1,
+	.tx_queues_to_use	= 1,
+	.init			= ls1x_eth_mux_init,
 };
 
 static struct resource ls1x_eth0_resources[] = {
@@ -222,14 +224,16 @@ struct platform_device ls1x_eth0_pdev = {
 
 #ifdef CONFIG_LOONGSON1_LS1B
 static struct plat_stmmacenet_data ls1x_eth1_pdata = {
-	.bus_id		= 1,
-	.phy_addr	= -1,
-	.interface	= PHY_INTERFACE_MODE_MII,
-	.mdio_bus_data	= &ls1x_mdio_bus_data,
-	.dma_cfg	= &ls1x_eth_dma_cfg,
-	.has_gmac	= 1,
-	.tx_coe		= 1,
-	.init		= ls1x_eth_mux_init,
+	.bus_id			= 1,
+	.phy_addr		= -1,
+	.interface		= PHY_INTERFACE_MODE_MII,
+	.mdio_bus_data		= &ls1x_mdio_bus_data,
+	.dma_cfg		= &ls1x_eth_dma_cfg,
+	.has_gmac		= 1,
+	.tx_coe			= 1,
+	.rx_queues_to_use	= 1,
+	.tx_queues_to_use	= 1,
+	.init			= ls1x_eth_mux_init,
 };
 
 static struct resource ls1x_eth1_resources[] = {
-- 
1.9.1
