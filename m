Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 07:48:58 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34059 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011523AbbJ0GsoAFL19 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 07:48:44 +0100
Received: by padhk11 with SMTP id hk11so213296796pad.1;
        Mon, 26 Oct 2015 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mVeSw7mUuPA4YGA9q14gseRz2WEMfinhDa/+sPd+TDY=;
        b=cwhrj9BA0rRjW522qFlp3q9mPJyZ4NDEZRQ7PEUizn6x9d5U9w4vcD88hB9lg+hhAF
         lWu2ZSTpeD1JUxeadzfnP6njJsYHkbbnPGrc/9N0PQnwxgSlvXFU9i8NNGEKq9p1vxfv
         UYx5+A8ZT6BsBG/x+VqGuD+i7hHycuYkF+wslmpT4O3Z0DgkHgazb6X/eDqDTjlc8IDg
         uW3FHJIn5RBY9kqDlV5lBgC7dk0q9uGYb19OIBZ89yYd/3ZQjd7nPkq3QGCdz1j8noKo
         +XisPenkUxHxBLil3NeS2uQ2XACDQuO6SmZwpLCVvl7/qljQjcbDFqKsCoFdFuUQWrUo
         dlYQ==
X-Received: by 10.68.57.175 with SMTP id j15mr45482823pbq.34.1445928518119;
        Mon, 26 Oct 2015 23:48:38 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id tt7sm1564458pab.45.2015.10.26.23.48.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 23:48:37 -0700 (PDT)
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
Subject: [v2 01/10] ata: ahci_brcmstb: add quick for broken ncq
Date:   Tue, 27 Oct 2015 15:48:02 +0900
Message-Id: <1445928491-7320-2-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49705
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

Add quick for bronken ncq. The chipsets (eg. BCM7439A0, BCM7445A0 and
BCM7445B0) need a workaround disabling NCQ. and it may need the
MIPS-based set-top box platforms.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  3 ++
 drivers/ata/ahci_brcmstb.c                         | 42 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
index 20ac9bbfa1fd..4650c0aff6b3 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
@@ -10,6 +10,9 @@ Required properties:
 - reg-names          : "ahci" and "top-ctrl"
 - interrupts         : interrupt mapping for SATA IRQ
 
+Optional properties:
+- brcm,broken-ncq    : if present, NCQ is unusable
+
 Also see ahci-platform.txt.
 
 Example:
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 14b7305d2ba0..a2df76698adb 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -69,10 +69,15 @@
 	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
 	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
 
+enum brcm_ahci_quicks {
+	BRCM_AHCI_QUICK_NONCQ		= BIT(0),
+};
+
 struct brcm_ahci_priv {
 	struct device *dev;
 	void __iomem *top_ctrl;
 	u32 port_mask;
+	u32 quicks;
 };
 
 static const struct ata_port_info ahci_brcm_port_info = {
@@ -209,6 +214,39 @@ static void brcm_sata_init(struct brcm_ahci_priv *priv)
 			   priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
 }
 
+static void brcm_sata_quick(struct platform_device *pdev,
+			    struct brcm_ahci_priv *priv)
+{
+	void __iomem *ahci;
+	struct resource *res;
+	u32 reg;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
+	ahci = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ahci))
+		return;
+
+	if (priv->quicks & BRCM_AHCI_QUICK_NONCQ) {
+		reg  = readl(priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+		reg |= OVERRIDE_HWINIT;
+		writel(reg, priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+
+		/* Clear out the NCQ bit so the AHCI driver will not issue
+		 * FPDMA/NCQ commands.
+		 */
+		reg = readl(ahci + HOST_CAP);
+		reg &= ~HOST_CAP_NCQ;
+		writel(reg, ahci + HOST_CAP);
+
+		reg = readl(priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+		reg &= ~OVERRIDE_HWINIT;
+		writel(reg, priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+	}
+
+	devm_iounmap(&pdev->dev, ahci);
+	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int brcm_ahci_suspend(struct device *dev)
 {
@@ -256,7 +294,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
+		priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
+
 	brcm_sata_init(priv);
+	brcm_sata_quick(pdev, priv);
 
 	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
 	if (!priv->port_mask)
-- 
2.6.2
