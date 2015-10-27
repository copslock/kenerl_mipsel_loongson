Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 07:49:32 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34160 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011530AbbJ0Gsuq3Ax9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 07:48:50 +0100
Received: by padhk11 with SMTP id hk11so213300007pad.1;
        Mon, 26 Oct 2015 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u4kMpNaFkbeh/MHZUMiL+wxrSxqlwHYRhcUeYeV48L0=;
        b=Bb3AJiFKA0J/dUnowoTwhAzcyqzoahQ/CzDhNrh3wiEABV1cYgSHePGY9wabRvveUb
         KzcYph7qrHg8k97pujF/cuRJCe0MqM/Zp0NahGcgnGyiDtbn4gGeJkRyBye/HDmUeqa8
         +AULU11eszExWqAMjuQtsAW4n4qLg4ZSOeV+mE06Q+oHMuaGdbNVp2Nb9bBRry0jyP8M
         jBOavBseWhS1Lyx3vLVZ5lj4qqVmpmTgwmO4o2vF/u3zw0+O5qSE0jnL/MqYxSRbRv9W
         WXAY8jr9sNHI5p47AQbFcZR3DCyvr9pGCPIP7mzhnpO5ROwklLVwk0w1KXPmlROmXWEz
         MhSg==
X-Received: by 10.67.30.74 with SMTP id kc10mr44599859pad.147.1445928525128;
        Mon, 26 Oct 2015 23:48:45 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id tt7sm1564458pab.45.2015.10.26.23.48.41
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 23:48:44 -0700 (PDT)
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
Subject: [v2 03/10] ata: ahci_brcmstb: add quick for broken phy
Date:   Tue, 27 Oct 2015 15:48:04 +0900
Message-Id: <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49707
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

Add quick for broken phy. The ARM-based 28nm chipsets have four phy
interface control registers and each port has two registers. But, The
MIPS-based 40nm chipsets have three. and there are no information and
documentation. The legacy version of broadcom's strict-ahci based
initial code did not control these registers.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt |  1 +
 drivers/ata/ahci_brcmstb.c                                  | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
index 488a383ce202..0f0925d58188 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
@@ -12,6 +12,7 @@ Required properties:
 
 Optional properties:
 - brcm,broken-ncq    : if present, NCQ is unusable
+- brcm,broken-phy    : if present, to control phy interface is unusable
 
 Also see ahci-platform.txt.
 
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index e53962cb48ee..c61303f7c7dc 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -71,6 +71,7 @@
 
 enum brcm_ahci_quicks {
 	BRCM_AHCI_QUICK_NONCQ		= BIT(0),
+	BRCM_AHCI_QUICK_NOPHY		= BIT(1),
 };
 
 struct brcm_ahci_priv {
@@ -119,6 +120,9 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
 	void __iomem *p;
 	u32 reg;
 
+	if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
+		return;
+
 	/* clear PHY_DEFAULT_POWER_STATE */
 	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
 	reg = brcm_sata_readreg(p);
@@ -148,6 +152,9 @@ static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
 	void __iomem *p;
 	u32 reg;
 
+	if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
+		return;
+
 	/* power-off the PHY digital logic */
 	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
 	reg = brcm_sata_readreg(p);
@@ -297,6 +304,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
 		priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
 
+	if (of_property_read_bool(dev->of_node, "brcm,broken-phy"))
+		priv->quicks |= BRCM_AHCI_QUICK_NOPHY;
+
 	brcm_sata_init(priv);
 	brcm_sata_quick(pdev, priv);
 
-- 
2.6.2
