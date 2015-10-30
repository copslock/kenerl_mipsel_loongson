Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 15:02:16 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36402 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011870AbbJ3OBrTm2U0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 15:01:47 +0100
Received: by pacfv9 with SMTP id fv9so78702746pac.3;
        Fri, 30 Oct 2015 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bMdYLF0tqeoy9Wxa5REjGKh/E3/GHbUl/Qk9dkXyR44=;
        b=Yj8eqSjmsDUaY5BmWZLk49jAy/0FalMFPZSUAzasEFekiOy1A946ofQMnSGpEG3+NT
         0902k9RfjZvgAqWOmjqxX730O8QxjEqUHJTdJ3cxGfKlqBIUJWxuYliImrj4dn/JBIIV
         0iH0NtyOUdgNajTdek1ovYTR97cFR5IPAIo6Vn5OrsbwC1qUYQMDyDbiOQeNwW0p48g9
         pcdMYVxIJYHg5l4I9DOSFl46NfE6QYjxdAVNXGFfEsT8a46MGGAxd+ljwhFwgoKRdHIr
         DlTlpYv/jGWgz/tgLawGUuRv/BZ6HeLmP4/H5Uo6L2rZCvZKJ13buvuHActtmoLyL6eZ
         2clg==
X-Received: by 10.68.131.161 with SMTP id on1mr9010330pbb.144.1446213701652;
        Fri, 30 Oct 2015 07:01:41 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id zk3sm8473164pbb.41.2015.10.30.07.01.38
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 07:01:41 -0700 (PDT)
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
Subject: [v4 02/10] ata: ahci_brcmstb: add quirk for broken ncq
Date:   Fri, 30 Oct 2015 23:01:16 +0900
Message-Id: <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49790
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

Add quirk for broken ncq. Some chipsets (eg. BCM7349A0, BCM7445A0,
BCM7445B0, and all 40nm chipsets including BCM7425) need a workaround
disabling NCQ.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 73e3b0b2a3c2..194aeda8f14d 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -69,10 +69,15 @@
 	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
 	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
 
+enum brcm_ahci_quirks {
+	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
+};
+
 struct brcm_ahci_priv {
 	struct device *dev;
 	void __iomem *top_ctrl;
 	u32 port_mask;
+	u32 quirks;
 };
 
 static const struct ata_port_info ahci_brcm_port_info = {
@@ -202,6 +207,42 @@ static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
 	return impl;
 }
 
+static void brcm_sata_quirks(struct platform_device *pdev,
+			     struct brcm_ahci_priv *priv)
+{
+	if (priv->quirks & BRCM_AHCI_QUIRK_NONCQ) {
+		void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
+		void __iomem *ahci;
+		struct resource *res;
+		u32 reg;
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "ahci");
+		ahci = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(ahci))
+			return;
+
+		reg = brcm_sata_readreg(ctrl);
+		reg |= OVERRIDE_HWINIT;
+		brcm_sata_writereg(reg, ctrl);
+
+		/* Clear out the NCQ bit so the AHCI driver will not issue
+		 * FPDMA/NCQ commands.
+		 */
+		reg = readl(ahci + HOST_CAP);
+		reg &= ~HOST_CAP_NCQ;
+		writel(reg, ahci + HOST_CAP);
+
+		reg = brcm_sata_readreg(ctrl);
+		reg &= ~OVERRIDE_HWINIT;
+		brcm_sata_writereg(reg, ctrl);
+
+		devm_iounmap(&pdev->dev, ahci);
+		devm_release_mem_region(&pdev->dev, res->start,
+					resource_size(res));
+	}
+}
+
 static void brcm_sata_init(struct brcm_ahci_priv *priv)
 {
 	/* Configure endianness */
@@ -256,6 +297,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
+		priv->quirks |= BRCM_AHCI_QUIRK_NONCQ;
+
+	brcm_sata_quirks(pdev, priv);
+
 	brcm_sata_init(priv);
 
 	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
-- 
2.6.2
