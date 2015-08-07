Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 02:33:31 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35946 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012975AbbHGAdaRfWQe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 02:33:30 +0200
Received: by igbij6 with SMTP id ij6so21925652igb.1
        for <linux-mips@linux-mips.org>; Thu, 06 Aug 2015 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m5jZHRy5mnQ36NbrSScEtoA7DEweqd+OHGmnykfpy78=;
        b=viBs+KoUWMmUtrzZQBrj3gidUXfhl6qEk9a8I9yZB82viwLrb2X7pFlXvmSiFnKor8
         W18qTxGsb5RleXwnUWcJrvwCx2UyPb0GVEozu9u/4YXceHrExwg3pkSGL5qCkMm4GKJE
         7oGMlp68HPUXJOOammhFcDn6U4wPF9F7974s82xZMADbQUdWjnX0ACb+Z9UzpxwWWo+W
         cAaxXx2mh1hcwO4LHLH9rFdsnnhr3Zh9MGg1p45r+Hh3t7bMmrML8B3zfDLR6HzUuVCR
         fIMXSS0eunw/DJMM+hz4Ohb0LzqnBU1pVnwIurb9R+7DVLDwBuspeo/vy/8ouWqgqQyS
         qBeA==
X-Received: by 10.50.108.100 with SMTP id hj4mr191648igb.65.1438907604373;
        Thu, 06 Aug 2015 17:33:24 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.gmail.com with ESMTPSA id ii1sm2591531igb.10.2015.08.06.17.33.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 17:33:23 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t770XLKK029689;
        Thu, 6 Aug 2015 17:33:21 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t770XLst029688;
        Thu, 6 Aug 2015 17:33:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] net: thunder: Factor out DT specific code in BGX
Date:   Thu,  6 Aug 2015 17:33:09 -0700
Message-Id: <1438907590-29649-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: Robert Richter <rrichter@cavium.com>

Separate DT code in preparation for follow-on ACPI integration.

Based on code from: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 48 +++++++++++++++++------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index b961a89..615b2af 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -835,18 +835,28 @@ static void bgx_get_qlm_mode(struct bgx *bgx)
 	}
 }
 
-static void bgx_init_of(struct bgx *bgx, struct device_node *np)
+#if IS_ENABLED(CONFIG_OF_MDIO)
+
+static int bgx_init_of_phy(struct bgx *bgx)
 {
+	struct device_node *np;
 	struct device_node *np_child;
 	u8 lmac = 0;
+	char bgx_sel[5];
+	const char *mac;
 
-	for_each_child_of_node(np, np_child) {
-		struct device_node *phy_np;
-		const char *mac;
+	/* Get BGX node from DT */
+	snprintf(bgx_sel, 5, "bgx%d", bgx->bgx_id);
+	np = of_find_node_by_name(NULL, bgx_sel);
+	if (!np)
+		return -ENODEV;
 
-		phy_np = of_parse_phandle(np_child, "phy-handle", 0);
-		if (phy_np)
-			bgx->lmac[lmac].phydev = of_phy_find_device(phy_np);
+	for_each_child_of_node(np, np_child) {
+		struct device_node *phy_np = of_parse_phandle(np_child,
+							      "phy-handle", 0);
+		if (!phy_np)
+			continue;
+		bgx->lmac[lmac].phydev = of_phy_find_device(phy_np);
 
 		mac = of_get_mac_address(np_child);
 		if (mac)
@@ -858,6 +868,21 @@ static void bgx_init_of(struct bgx *bgx, struct device_node *np)
 		if (lmac == MAX_LMAC_PER_BGX)
 			break;
 	}
+	return 0;
+}
+
+#else
+
+static int bgx_init_of_phy(struct bgx *bgx)
+{
+	return -ENODEV;
+}
+
+#endif /* CONFIG_OF_MDIO */
+
+static int bgx_init_phy(struct bgx *bgx)
+{
+	return bgx_init_of_phy(bgx);
 }
 
 static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -865,8 +890,6 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int err;
 	struct device *dev = &pdev->dev;
 	struct bgx *bgx = NULL;
-	struct device_node *np;
-	char bgx_sel[5];
 	u8 lmac;
 
 	bgx = devm_kzalloc(dev, sizeof(*bgx), GFP_KERNEL);
@@ -902,10 +925,9 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bgx_vnic[bgx->bgx_id] = bgx;
 	bgx_get_qlm_mode(bgx);
 
-	snprintf(bgx_sel, 5, "bgx%d", bgx->bgx_id);
-	np = of_find_node_by_name(NULL, bgx_sel);
-	if (np)
-		bgx_init_of(bgx, np);
+	err = bgx_init_phy(bgx);
+	if (err)
+		goto err_enable;
 
 	bgx_init_hw(bgx);
 
-- 
1.9.1
