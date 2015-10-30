Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 14:41:15 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35166 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011847AbbJ3NjxyWiK0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 14:39:53 +0100
Received: by pasz6 with SMTP id z6so75130345pas.2;
        Fri, 30 Oct 2015 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ic288oHJOdhipgJ+Q5T5jqmeM2Vos3aoLN8G9pJ/LXI=;
        b=tDbOJ+z2f27nXvM3bdRguDxWxli/AFc3JTjiI5+5/SnCUBXrlouFHQtDVlpmcsvJxP
         nUTwlkWrSluqQ+mw/4nowt+uSzTsMWs5dkQ/TO0CPnKPgjOChkAkn8r9xOBNTY1zjQtu
         0yqZat6CLFfPSJnrqiTjmhaVgXcUQn6gV6nLTx7INxxVrl7Gy/lXyPWUiCUkq8wcKexi
         pzXedcsyT3yzcjP4/vAQVFbHzXfRUjXR5iZuJUUiDIlq6GW1C+L/xZsn/+ncec6/cdub
         sBzKMDnkQ+eQdOllMphcVhWhjDtk2UijDv/lImRZaHdw8/kSTzRNuYKH8vCKlK9xhCse
         PbKw==
X-Received: by 10.68.254.137 with SMTP id ai9mr8785290pbd.68.1446212388266;
        Fri, 30 Oct 2015 06:39:48 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id d13sm8391293pbu.20.2015.10.30.06.39.44
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 06:39:47 -0700 (PDT)
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
Subject: [v3 06/10] phy: phy_brcmstb_sata: add data for phy version
Date:   Fri, 30 Oct 2015 22:38:55 +0900
Message-Id: <1446212339-1210-7-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49781
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

Add data of device for phy version. and 28nm version is default.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/phy/phy-brcmstb-sata.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 0be55dafe9ea..5de394f589c8 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -30,7 +30,11 @@
 #define MAX_PORTS					2
 
 /* Register offset between PHYs in PCB space */
-#define SATA_MDIO_REG_SPACE_SIZE			0x1000
+#define SATA_MDIO_REG_28NM_SPACE_SIZE			0x1000
+
+enum brcm_sata_phy_version {
+	BRCM_SATA_PHY_28NM,
+};
 
 struct brcm_sata_port {
 	int portnum;
@@ -42,6 +46,7 @@ struct brcm_sata_port {
 struct brcm_sata_phy {
 	struct device *dev;
 	void __iomem *phy_base;
+	enum brcm_sata_phy_version version;
 
 	struct brcm_sata_port phys[MAX_PORTS];
 };
@@ -64,8 +69,12 @@ enum sata_mdio_phy_regs_28nm {
 static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
 {
 	struct brcm_sata_phy *priv = port->phy_priv;
+	u32 offset;
 
-	return priv->phy_base + (port->portnum * SATA_MDIO_REG_SPACE_SIZE);
+	if (priv->version == BRCM_SATA_PHY_28NM)
+		offset = SATA_MDIO_REG_28NM_SPACE_SIZE;
+
+	return priv->phy_base + (port->portnum * offset);
 }
 
 static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
@@ -126,7 +135,8 @@ static const struct phy_ops phy_ops_28nm = {
 };
 
 static const struct of_device_id brcm_sata_phy_of_match[] = {
-	{ .compatible	= "brcm,bcm7445-sata-phy" },
+	{ .compatible	= "brcm,bcm7445-sata-phy",
+	  .data = (void *)BRCM_SATA_PHY_28NM },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
@@ -135,6 +145,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node, *child;
+	const struct of_device_id *of_id;
 	struct brcm_sata_phy *priv;
 	struct resource *res;
 	struct phy_provider *provider;
@@ -154,6 +165,12 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->phy_base))
 		return PTR_ERR(priv->phy_base);
 
+	of_id = of_match_node(brcm_sata_phy_of_match, dn);
+	if (of_id)
+		priv->version = (enum brcm_sata_phy_version)of_id->data;
+	else
+		priv->version = BRCM_SATA_PHY_28NM;
+
 	for_each_available_child_of_node(dn, child) {
 		unsigned int id;
 		struct brcm_sata_port *port;
-- 
2.6.2
