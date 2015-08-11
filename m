Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 02:59:14 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34690 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012505AbbHKA6yAnTEm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 02:58:54 +0200
Received: by igui7 with SMTP id i7so30490740igu.1
        for <linux-mips@linux-mips.org>; Mon, 10 Aug 2015 17:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f0O6f9PLCZctncUGT+kTwd59wVf4SpuLITC+9jFjRqw=;
        b=kRy8Do6FsmfHJ8or57jMeLCMlNDls5RurPqCFMxSA99mVCbUtZvyEC/aMm1LMigXUb
         1sq3meELuFINQBUis58cgYaUz9+z78k0oWW1kqrFFLkOf55RQEI8BJfJ3s7IXnYSq230
         TUM6pAXPpW5eIU0bm32qntuBUGNV8tIQb4lWNbDH9ZJ+BfCAKlGMOyIPxXSQmITsDJzs
         /J4EBjtUztVJKG6R1ifHb0F481dNcjAZ+DFGsDX4YQcvE9LP2Pl5bMuTpvZNcjoZhhM6
         34nVPGlxQxjyhgRaEx1npGN1cSlE/vrk1AwTjz8oW2ZLHZnZ39wJF08eO5pPwwMd0Ga5
         jnvA==
X-Received: by 10.50.112.166 with SMTP id ir6mr10974043igb.75.1439254728111;
        Mon, 10 Aug 2015 17:58:48 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.gmail.com with ESMTPSA id 90sm415122iog.35.2015.08.10.17.58.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 17:58:46 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t7B0wiJx002915;
        Mon, 10 Aug 2015 17:58:44 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t7B0widf002914;
        Mon, 10 Aug 2015 17:58:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, rafael@kernel.org,
        Robert Richter <rrichter@redhat.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/2] net: thunder: Factor out DT specific code in BGX
Date:   Mon, 10 Aug 2015 17:58:36 -0700
Message-Id: <1439254717-2875-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48760
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

From: Robert Richter <rrichter@redhat.com>

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
