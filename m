Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:53:11 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62665 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013676AbaKZAvlgOhxm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:41 +0100
Received: by mail-pa0-f51.google.com with SMTP id ey11so1685661pad.38
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7KMCP238Z6LuETtCmRUKM29c9JQmTRiloZyFV9SAEwg=;
        b=jcB0i7cFqeJuQ6etbmmCVbzYVxbwejEQMwOxn+qNEgt+XNRMpZhuklL2m/IaCGm852
         AwKc5AyUlWNeT7UwVxlvPgK1lr054xqEOPCzAN5+gvl/KSrpvEA6djQcUsiKRDkJD/K+
         WQ2OZYRzpuZ7pvWw4FOkisZDpDbm597bPtLNIyx42l9tOl9lN1jLUU0SHCeGKUJriSGK
         18a8p8DLbF7pqN1mQIrluMXu9LZJmt8DSwbHKgrDrmmVqPecdiWSPmOkcokz9CoM3ZF1
         iiNQZ8kxkBhqnONLIjLjg8+NoW01DxxAtPDXfCOLQJ2FMcYHdQ+pmQnxwEkfoxu5KbAI
         7KjA==
X-Received: by 10.70.48.166 with SMTP id m6mr49638008pdn.22.1416963095949;
        Tue, 25 Nov 2014 16:51:35 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:35 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 7/9] bus: brcmstb_gisb: Add register offset tables for older chips
Date:   Tue, 25 Nov 2014 16:49:52 -0800
Message-Id: <1416962994-27095-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This will select the appropriate register layout based on the DT
"compatible" string.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |  6 ++-
 drivers/bus/brcmstb_gisb.c                         | 52 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
index e2d501d..1eceefb 100644
--- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
@@ -2,7 +2,11 @@ Broadcom GISB bus Arbiter controller
 
 Required properties:
 
-- compatible: should be "brcm,gisb-arb"
+- compatible:
+    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for 28nm chips
+    "brcm,bcm7435-gisb-arb" for newer 40nm chips
+    "brcm,bcm7400-gisb-arb" for older 40nm chips and all 65nm chips
+    "brcm,bcm7038-gisb-arb" for 130nm chips
 - reg: specifies the base physical address and size of the registers
 - interrupt-parent: specifies the phandle to the parent interrupt controller
   this arbiter gets interrupt line from
diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index ef1e423..172908d 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -47,6 +47,36 @@ enum {
 	ARB_ERR_CAP_MASTER,
 };
 
+static const int gisb_offsets_bcm7038[] = {
+	[ARB_TIMER]		= 0x00c,
+	[ARB_ERR_CAP_CLR]	= 0x0c4,
+	[ARB_ERR_CAP_HI_ADDR]	= -1,
+	[ARB_ERR_CAP_ADDR]	= 0x0c8,
+	[ARB_ERR_CAP_DATA]	= 0x0cc,
+	[ARB_ERR_CAP_STATUS]	= 0x0d0,
+	[ARB_ERR_CAP_MASTER]	= -1,
+};
+
+static const int gisb_offsets_bcm7400[] = {
+	[ARB_TIMER]		= 0x00c,
+	[ARB_ERR_CAP_CLR]	= 0x0c8,
+	[ARB_ERR_CAP_HI_ADDR]	= -1,
+	[ARB_ERR_CAP_ADDR]	= 0x0cc,
+	[ARB_ERR_CAP_DATA]	= 0x0d0,
+	[ARB_ERR_CAP_STATUS]	= 0x0d4,
+	[ARB_ERR_CAP_MASTER]	= 0x0d8,
+};
+
+static const int gisb_offsets_bcm7435[] = {
+	[ARB_TIMER]		= 0x00c,
+	[ARB_ERR_CAP_CLR]	= 0x168,
+	[ARB_ERR_CAP_HI_ADDR]	= -1,
+	[ARB_ERR_CAP_ADDR]	= 0x16c,
+	[ARB_ERR_CAP_DATA]	= 0x170,
+	[ARB_ERR_CAP_STATUS]	= 0x174,
+	[ARB_ERR_CAP_MASTER]	= 0x178,
+};
+
 static const int gisb_offsets_bcm7445[] = {
 	[ARB_TIMER]		= 0x008,
 	[ARB_ERR_CAP_CLR]	= 0x7e4,
@@ -230,10 +260,20 @@ static struct attribute_group gisb_arb_sysfs_attr_group = {
 	.attrs = gisb_arb_sysfs_attrs,
 };
 
+static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
+	{ .compatible = "brcm,gisb-arb",         .data = gisb_offsets_bcm7445 },
+	{ .compatible = "brcm,bcm7445-gisb-arb", .data = gisb_offsets_bcm7445 },
+	{ .compatible = "brcm,bcm7435-gisb-arb", .data = gisb_offsets_bcm7435 },
+	{ .compatible = "brcm,bcm7400-gisb-arb", .data = gisb_offsets_bcm7400 },
+	{ .compatible = "brcm,bcm7038-gisb-arb", .data = gisb_offsets_bcm7038 },
+	{ },
+};
+
 static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
 	struct brcmstb_gisb_arb_device *gdev;
+	const struct of_device_id *of_id;
 	struct resource *r;
 	int err, timeout_irq, tea_irq;
 	unsigned int num_masters, j = 0;
@@ -254,7 +294,12 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	if (IS_ERR(gdev->base))
 		return PTR_ERR(gdev->base);
 
-	gdev->gisb_offsets = gisb_offsets_bcm7445;
+	of_id = of_match_node(brcmstb_gisb_arb_of_match, dn);
+	if (!of_id) {
+		pr_err("failed to look up compatible string\n");
+		return -EINVAL;
+	}
+	gdev->gisb_offsets = of_id->data;
 
 	err = devm_request_irq(&pdev->dev, timeout_irq,
 				brcmstb_gisb_timeout_handler, 0, pdev->name,
@@ -307,11 +352,6 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
-	{ .compatible = "brcm,gisb-arb" },
-	{ },
-};
-
 static struct platform_driver brcmstb_gisb_arb_driver = {
 	.probe	= brcmstb_gisb_arb_probe,
 	.driver = {
-- 
2.1.0
