Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:47:02 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34834 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011180AbbJWBpq0hIIB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:45:46 +0200
Received: by pasz6 with SMTP id z6so102440613pas.2;
        Thu, 22 Oct 2015 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVx/Ydun2V0gn8MvHiQhiGHRecDKew3W3Xqp5VSFL/o=;
        b=hMRQoQAIZSwky8XNcEAYDD2bs00QB4RA8iIuK29zqsJdpu8WqlGPjloVFllEB8LfkQ
         Y9jTtG3yeyizViYzdJ9rANIK0ETAKnes9Mqi2vie4D+iLhw3QohjQnNidB+GytrAh0PS
         J4biczuSh/r3GBGQO8gyv8TA8hGZg711P5O3yWsk8wnQMAwq7nlDBUBLD2Wp8PavYgXL
         l5Nwy3ddmu1j3gKGUYcSbssl2YxWSVH4KT/MY8G06J33xci3phRxRoZ9+s2TppDi0LZb
         Q4zE30qofm7MbWdOb+D80Iek+MO0S0qBIeBf7Q9uwmoB+weSmzXvXwAJoq3er3DmTw+j
         vYCQ==
X-Received: by 10.66.152.44 with SMTP id uv12mr7638290pab.110.1445564740399;
        Thu, 22 Oct 2015 18:45:40 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.36
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:40 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 06/10] phy: phy_brcmstb_sata: add data for phy offset
Date:   Fri, 23 Oct 2015 10:44:19 +0900
Message-Id: <1445564663-66824-7-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49647
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

Add data of device node for phy offset.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/phy/phy-brcmstb-sata.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 0be55dafe9ea..41c7535d706b 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -42,6 +42,7 @@ struct brcm_sata_port {
 struct brcm_sata_phy {
 	struct device *dev;
 	void __iomem *phy_base;
+	u32 phy_offset;
 
 	struct brcm_sata_port phys[MAX_PORTS];
 };
@@ -65,7 +66,7 @@ static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
 {
 	struct brcm_sata_phy *priv = port->phy_priv;
 
-	return priv->phy_base + (port->portnum * SATA_MDIO_REG_SPACE_SIZE);
+	return priv->phy_base + (port->portnum * priv->phy_offset);
 }
 
 static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
@@ -126,7 +127,8 @@ static const struct phy_ops phy_ops_28nm = {
 };
 
 static const struct of_device_id brcm_sata_phy_of_match[] = {
-	{ .compatible	= "brcm,bcm7445-sata-phy" },
+	{ .compatible	= "brcm,bcm7445-sata-phy",
+			.data = (void *)SATA_MDIO_REG_SPACE_SIZE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
@@ -135,6 +137,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node, *child;
+	const struct of_device_id *of_id = NULL;
 	struct brcm_sata_phy *priv;
 	struct resource *res;
 	struct phy_provider *provider;
@@ -154,6 +157,12 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->phy_base))
 		return PTR_ERR(priv->phy_base);
 
+	of_id = of_match_node(brcm_sata_phy_of_match, dn);
+	if (!of_id)
+		return -EINVAL;
+
+	priv->phy_offset = (u32)of_id->data;
+
 	for_each_available_child_of_node(dn, child) {
 		unsigned int id;
 		struct brcm_sata_port *port;
-- 
2.6.2
