Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 07:50:23 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34350 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011538AbbJ0GtDE6Kw9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 07:49:03 +0100
Received: by padhk11 with SMTP id hk11so213305712pad.1;
        Mon, 26 Oct 2015 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ic288oHJOdhipgJ+Q5T5jqmeM2Vos3aoLN8G9pJ/LXI=;
        b=KhJ0s6vYM2YERt+4rP8fqoMZK5Ud2/IEHKyImfMyUPIZ9fsTISBpsw/f/IKGIpw5fh
         yAWrwD6BH/28EZEU1z3NuXQBWiys+o/D6Sf4RUu7G1smkuM0t+ew2hX14JlvC6B6No0k
         WWVM/SHxq/m9UM9z0NUpP9JOGmd8FgQh/O+aKzwAADv/fqwQ4Vpy1Dd/vV8Kr7FuTGQg
         L7y4A4uT314g7Mv9ec57RQp64tcds97E28i5q2lJ06LS07JXjz/DBKFlbS1RYROuKvR4
         Swh1n1b6vxNk1tGnkS+PPlXgy+Wqyg6KHbXi16zlufv7pez6+UbXs6FHTRyhR7Fxf1Rs
         lVDw==
X-Received: by 10.68.193.5 with SMTP id hk5mr26398710pbc.152.1445928537444;
        Mon, 26 Oct 2015 23:48:57 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id tt7sm1564458pab.45.2015.10.26.23.48.53
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 23:48:57 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 06/10] phy: phy_brcmstb_sata: add data for phy version
Date:   Tue, 27 Oct 2015 15:48:07 +0900
Message-Id: <1445928491-7320-7-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49710
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
