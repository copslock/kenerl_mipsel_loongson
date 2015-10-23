Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:47:20 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34614 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011182AbbJWBpuTyEPB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:45:50 +0200
Received: by padhk11 with SMTP id hk11so102656356pad.1;
        Thu, 22 Oct 2015 18:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hwaG1wkXEz0u5D1pODUoyClNMzZGdcBv3k5FpeQfZAA=;
        b=S1poZm+3RAW/eGqUxogREPuGXH+rBZ1D/loabs6HNqrEkRx1MgPvfhwGR+f1aHXzhG
         EoCV62oeZC6oMSB13+sXqr39LUQ7kUJJSvNanm0Yy/kdFOONkTRnlZdFA09r/jHIzciR
         booyPoG222/K7GX7FzCgPqEWrkbYLqzrAb+jRCJDc2Tc1ga7/YetuYEIYzcahOi6aWF8
         yWcC7Fvh5WTPwZDYVPsCIZVr+XbvTSp22sS9/F2qiEyAteuBTZsZa1sijFIA4Y4R+h3+
         PvEacaBKXOjH/OqeBz4M+YTRyTv2EPDfbJwEl5OANSfmyorL0t4e9ZKuO93pEp5XhIx2
         TetQ==
X-Received: by 10.66.221.6 with SMTP id qa6mr1667390pac.9.1445564744714;
        Thu, 22 Oct 2015 18:45:44 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.40
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:44 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 07/10] phy: phy_brcmstb_sata: add support 40nm platforms
Date:   Fri, 23 Oct 2015 10:44:20 +0900
Message-Id: <1445564663-66824-8-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49648
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

Add offsets for 40nm BMIPS based set-top box platforms.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/phy/phy-brcmstb-sata.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 41c7535d706b..1cc80743b1b6 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -30,7 +30,8 @@
 #define MAX_PORTS					2
 
 /* Register offset between PHYs in PCB space */
-#define SATA_MDIO_REG_SPACE_SIZE			0x1000
+#define SATA_MDIO_REG_28NM_SPACE_SIZE			0x1000
+#define SATA_MDIO_REG_40NM_SPACE_SIZE			0x10
 
 struct brcm_sata_port {
 	int portnum;
@@ -47,7 +48,7 @@ struct brcm_sata_phy {
 	struct brcm_sata_port phys[MAX_PORTS];
 };
 
-enum sata_mdio_phy_regs_28nm {
+enum sata_mdio_phy_regs {
 	PLL_REG_BANK_0				= 0x50,
 	PLL_REG_BANK_0_PLLCONTROL_0		= 0x81,
 
@@ -85,7 +86,7 @@ static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
 #define FMAX_VAL_DEFAULT	0x3df
 #define FMAX_VAL_SSC		0x83
 
-static void brcm_sata_cfg_ssc_28nm(struct brcm_sata_port *port)
+static void brcm_sata_cfg_ssc(struct brcm_sata_port *port)
 {
 	void __iomem *base = brcm_sata_phy_base(port);
 	struct brcm_sata_phy *priv = port->phy_priv;
@@ -116,19 +117,25 @@ static int brcm_sata_phy_init(struct phy *phy)
 {
 	struct brcm_sata_port *port = phy_get_drvdata(phy);
 
-	brcm_sata_cfg_ssc_28nm(port);
+	brcm_sata_cfg_ssc(port);
 
 	return 0;
 }
 
-static const struct phy_ops phy_ops_28nm = {
+static const struct phy_ops phy_ops = {
 	.init		= brcm_sata_phy_init,
 	.owner		= THIS_MODULE,
 };
 
 static const struct of_device_id brcm_sata_phy_of_match[] = {
 	{ .compatible	= "brcm,bcm7445-sata-phy",
-			.data = (void *)SATA_MDIO_REG_SPACE_SIZE },
+			.data = (void *)SATA_MDIO_REG_28NM_SPACE_SIZE },
+	{ .compatible   = "brcm,bcm7346-sata-phy",
+			.data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
+	{ .compatible   = "brcm,bcm7360-sata-phy",
+			.data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
+	{ .compatible   = "brcm,bcm7362-sata-phy",
+			.data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
@@ -185,7 +192,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 		port = &priv->phys[id];
 		port->portnum = id;
 		port->phy_priv = priv;
-		port->phy = devm_phy_create(dev, child, &phy_ops_28nm);
+		port->phy = devm_phy_create(dev, child, &phy_ops);
 		port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
 		if (IS_ERR(port->phy)) {
 			dev_err(dev, "failed to create PHY\n");
-- 
2.6.2
