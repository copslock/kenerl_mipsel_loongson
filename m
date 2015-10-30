Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 15:02:33 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32808 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011874AbbJ3OBuuD8C0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 15:01:50 +0100
Received: by padhy1 with SMTP id hy1so69587302pad.0;
        Fri, 30 Oct 2015 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FbDrxks1ipiPUiDIMT+OOB8SvoRyDqMHTcnnmlm1mVI=;
        b=YwVj69fNHIy90cqBPa4YdGi8B4F9HfqVnjKTFlpPDMYqOUQxANjTCno0ObXWsC89Bs
         x2qhumf9c/JuhP/m0W2itnGiWraJUp8he9wC9BlYVFiepLTYNoXLYz2dGQ5LO1cCppNX
         wxhs+1vChdOQEYt9JsAPifmXEpXO2KTi4WrQiLEMPVI2QBxLEA84WUI+qJ0L4NoKiMfq
         pgHfGcHp42vE2d9ze4jyyeqzdX+FLOM1FH6G/1UiaZbyWx+loXbHKgpxkvQMzHlb//TO
         rg2ElAd5zbEi3jAzxKy+S3WX52PGG8OQ5A0IkZqO70MmJIhMeeXlo/UyYlzxyfUL4C0+
         orHA==
X-Received: by 10.68.182.5 with SMTP id ea5mr9183496pbc.148.1446213705164;
        Fri, 30 Oct 2015 07:01:45 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id zk3sm8473164pbb.41.2015.10.30.07.01.41
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 07:01:44 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 03/10] ata: ahci_brcmstb: add quirk for different phy
Date:   Fri, 30 Oct 2015 23:01:17 +0900
Message-Id: <1446213684-2625-4-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Add quirk for phy interface of MIPS-based chipsets. The ARM-based
chipsets have four phy interface control registers and each port has two
registers but the MIPS-based chipsets have three. There are no
information and documentation.

The Broadcom strict-ahci based BSP of legacy version did not control
these registers.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 194aeda8f14d..5098e6c041ac 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -71,6 +71,7 @@
 
 enum brcm_ahci_quirks {
 	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
+	BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE	= BIT(1),
 };
 
 struct brcm_ahci_priv {
@@ -119,6 +120,9 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
 	void __iomem *p;
 	u32 reg;
 
+	if (priv->quirks & BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE)
+		return;
+
 	/* clear PHY_DEFAULT_POWER_STATE */
 	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
 	reg = brcm_sata_readreg(p);
@@ -148,6 +152,9 @@ static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
 	void __iomem *p;
 	u32 reg;
 
+	if (priv->quirks & BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE)
+		return;
+
 	/* power-off the PHY digital logic */
 	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
 	reg = brcm_sata_readreg(p);
@@ -297,8 +304,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
-	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
+	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci")) {
 		priv->quirks |= BRCM_AHCI_QUIRK_NONCQ;
+		priv->quirks |= BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE;
+	}
 
 	brcm_sata_quirks(pdev, priv);
 
-- 
2.6.2
