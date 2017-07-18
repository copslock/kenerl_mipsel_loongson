Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 23:44:04 +0200 (CEST)
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33331 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994850AbdGRVn537aRF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 23:43:57 +0200
Received: by mail-pg0-f67.google.com with SMTP id z1so4351489pgs.0;
        Tue, 18 Jul 2017 14:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aZM+IrvjuPBMkicRAGG/5BeVUidQLhfqtCyceyrRLv0=;
        b=eqleW3C+m4qn17aV/6cWER0s4Nf9emH/gUnahYeH8+m4oxmPbaY2GDYtOWjkGk2NUi
         Bc18cDrwWvAQYfyiNquBdUIEwMTUzJ9Ru9Yc7vmJNiCum8Q6GmpWOetQHF/BCe+1sCm/
         d6mDcJ33Z8NbTJn+5j9M0IgpQlw49QPag84GPrHFE9w3lgTAXPZbTOYR9N+qkU272mLJ
         e0syeCaidptSRC2L0JutUbEf0o5AiQLnh/GYMNNBB/CTpQFAhOCWKQ4ibKE7PypqXqzs
         GWw18BxbQwmeO7375w6yjF3qzuyWOqK7maYnvMSXbibND2Nw7tNIjfuKT6+ehsirba26
         iLTw==
X-Gm-Message-State: AIVw113JxMsCSLoaDOKiuLiD4otyYdRYX3iZrLvEZfTvWlOP2IKiK7S+
        KCIw9FPGkCGKAyPdQdE=
X-Received: by 10.101.91.137 with SMTP id i9mr3724545pgr.27.1500414231356;
        Tue, 18 Jul 2017 14:43:51 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id r207sm7186560pfr.106.2017.07.18.14.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 14:43:50 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Convert to using %pOF instead of full_name
Date:   Tue, 18 Jul 2017 16:42:45 -0500
Message-Id: <20170718214339.7774-5-robh@kernel.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ath79/clock.c    |  9 ++++-----
 arch/mips/pci/pci-legacy.c |  2 +-
 arch/mips/pci/pci-rt3883.c | 11 +++++------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index fa845953f736..6b1000b6a6a6 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -487,17 +487,16 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 {
 	struct clk *ref_clk;
 	void __iomem *pll_base;
-	const char *dnfn = of_node_full_name(np);

 	ref_clk = of_clk_get(np, 0);
 	if (IS_ERR(ref_clk)) {
-		pr_err("%s: of_clk_get failed\n", dnfn);
+		pr_err("%pOF: of_clk_get failed\n", np);
 		goto err;
 	}

 	pll_base = of_iomap(np, 0);
 	if (!pll_base) {
-		pr_err("%s: can't map pll registers\n", dnfn);
+		pr_err("%pOF: can't map pll registers\n", np);
 		goto err_clk;
 	}

@@ -506,12 +505,12 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 	else if (of_device_is_compatible(np, "qca,ar9330-pll"))
 		ar9330_clk_init(ref_clk, pll_base);
 	else {
-		pr_err("%s: could not find any appropriate clk_init()\n", dnfn);
+		pr_err("%pOF: could not find any appropriate clk_init()\n", np);
 		goto err_iounmap;
 	}

 	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data)) {
-		pr_err("%s: could not register clk provider\n", dnfn);
+		pr_err("%pOF: could not register clk provider\n", np);
 		goto err_iounmap;
 	}

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 174575a9a112..958f47c1f558 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -127,7 +127,7 @@ void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;

-	pr_info("PCI host bridge %s ranges:\n", node->full_name);
+	pr_info("PCI host bridge %pOF ranges:\n", node);
 	hose->of_node = node;

 	if (of_pci_range_parser_init(&parser, node))
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 3520e9b414e7..04f8ea953297 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -207,8 +207,7 @@ static int rt3883_pci_irq_init(struct device *dev,

 	irq = irq_of_parse_and_map(rpc->intc_of_node, 0);
 	if (irq == 0) {
-		dev_err(dev, "%s has no IRQ",
-			of_node_full_name(rpc->intc_of_node));
+		dev_err(dev, "%pOF has no IRQ", rpc->intc_of_node);
 		return -EINVAL;
 	}

@@ -438,8 +437,8 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	}

 	if (!rpc->intc_of_node) {
-		dev_err(dev, "%s has no %s child node",
-			of_node_full_name(rpc->intc_of_node),
+		dev_err(dev, "%pOF has no %s child node",
+			rpc->intc_of_node,
 			"interrupt controller");
 		return -EINVAL;
 	}
@@ -454,8 +453,8 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	}

 	if (!rpc->pci_controller.of_node) {
-		dev_err(dev, "%s has no %s child node",
-			of_node_full_name(rpc->intc_of_node),
+		dev_err(dev, "%pOF has no %s child node",
+			rpc->intc_of_node,
 			"PCI host bridge");
 		err = -EINVAL;
 		goto err_put_intc_node;
--
2.11.0
