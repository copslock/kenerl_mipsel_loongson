Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:45:52 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35583 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011127AbbJWBp2g0fVB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:45:28 +0200
Received: by pasz6 with SMTP id z6so102433678pas.2;
        Thu, 22 Oct 2015 18:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6HA0VS0WRAkICufzPO4/lurAj2Pe9l0ybJK5O6inh3w=;
        b=e20qAH9r8Lw9ke6JtIoqhr1W4MH12dBKPzcj8WX6ofUR/GVh6opz/3IIAkF7wuoXV7
         //gJq9K2SBmjdAd36MXammycEtIDb2Wpd5fuAZ+KKMa/4ijLlER6nTexTKRkJmjPT6z/
         AY5jKF7OBSUe+Lyq+OSOst9QxMSDJzQHkJSw32/BIngS6Ux++YhrM8dLohXjeYoV4GqS
         jjlGmfKAak0w7oeKzKwzPcM9/JZViEoSE/+QN2MD/q8yy1p5AXX+W0luYf3BIefGivFN
         87E4BlxjPV6XSsyr0uwQTrE8QgbLN+mOImOKXZ7s6joZBKfEzDfb56o4ZLM5KKQyvdnK
         b+Hw==
X-Received: by 10.66.248.170 with SMTP id yn10mr1678761pac.74.1445564722988;
        Thu, 22 Oct 2015 18:45:22 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.15
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:19 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 02/10] ata: ahch_brcmstb: add data for port offset
Date:   Fri, 23 Oct 2015 10:44:15 +0900
Message-Id: <1445564663-66824-3-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49643
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

Add data of device node for port offset.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 14b7305d2ba0..8cf6f7d4798f 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -72,6 +72,7 @@
 struct brcm_ahci_priv {
 	struct device *dev;
 	void __iomem *top_ctrl;
+	u32 port_offset;
 	u32 port_mask;
 };
 
@@ -110,7 +111,7 @@ static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
 static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
 {
 	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
-				(port * SATA_TOP_CTRL_PHY_OFFS);
+				(port * priv->port_offset);
 	void __iomem *p;
 	u32 reg;
 
@@ -139,7 +140,7 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
 static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
 {
 	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
-				(port * SATA_TOP_CTRL_PHY_OFFS);
+				(port * priv->port_offset);
 	void __iomem *p;
 	u32 reg;
 
@@ -234,6 +235,13 @@ static int brcm_ahci_resume(struct device *dev)
 }
 #endif
 
+static const struct of_device_id ahci_of_match[] = {
+	{.compatible = "brcm,bcm7445-ahci",
+			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
 static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
 };
@@ -241,6 +249,7 @@ static struct scsi_host_template ahci_platform_sht = {
 static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -256,6 +265,12 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	of_id = of_match_node(ahci_of_match, dev->of_node);
+	if (!of_id)
+		return -EINVAL;
+
+	priv->port_offset = (u32)of_id->data;
+
 	brcm_sata_init(priv);
 
 	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
@@ -299,12 +314,6 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ahci_of_match[] = {
-	{.compatible = "brcm,bcm7445-ahci"},
-	{},
-};
-MODULE_DEVICE_TABLE(of, ahci_of_match);
-
 static SIMPLE_DEV_PM_OPS(ahci_brcm_pm_ops, brcm_ahci_suspend, brcm_ahci_resume);
 
 static struct platform_driver brcm_ahci_driver = {
-- 
2.6.2
