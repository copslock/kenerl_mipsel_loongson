Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:27:25 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:58294 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993029AbeFYRYaOwBFv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:24:30 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 18/25] MIPS: ath79: support setting up clock via DT on all SoC types
Date:   Mon, 25 Jun 2018 19:15:42 +0200
Message-Id: <20180625171549.4618-19-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171549.4618-1-john@phrozen.org>
References: <20180625171549.4618-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

From: Felix Fietkau <nbd@nbd.name>

Use the same functions as the legacy code

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/ath79/clock.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 6262253622b3..c234818b30e1 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -669,16 +669,6 @@ ath79_get_sys_clk_rate(const char *id)
 #ifdef CONFIG_OF
 static void __init ath79_clocks_init_dt(struct device_node *np)
 {
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-}
-
-CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
-
-static void __init ath79_clocks_init_dt_ng(struct device_node *np)
-{
 	struct clk *ref_clk;
 	void __iomem *pll_base;
 
@@ -692,14 +682,21 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 		goto err_clk;
 	}
 
-	if (of_device_is_compatible(np, "qca,ar9130-pll"))
+	if (of_device_is_compatible(np, "qca,ar7100-pll"))
+		ar71xx_clocks_init(pll_base);
+	else if (of_device_is_compatible(np, "qca,ar7240-pll") ||
+		 of_device_is_compatible(np, "qca,ar9130-pll"))
 		ar724x_clocks_init(pll_base);
 	else if (of_device_is_compatible(np, "qca,ar9330-pll"))
 		ar933x_clocks_init(pll_base);
-	else {
-		pr_err("%pOF: could not find any appropriate clk_init()\n", np);
-		goto err_iounmap;
-	}
+	else if (of_device_is_compatible(np, "qca,ar9340-pll"))
+		ar934x_clocks_init(pll_base);
+	else if (of_device_is_compatible(np, "qca,qca9530-pll"))
+		qca953x_clocks_init(pll_base);
+	else if (of_device_is_compatible(np, "qca,qca9550-pll"))
+		qca955x_clocks_init(pll_base);
+	else if (of_device_is_compatible(np, "qca,qca9560-pll"))
+		qca956x_clocks_init(pll_base);
 
 	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data)) {
 		pr_err("%pOF: could not register clk provider\n", np);
@@ -714,6 +711,14 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 err_clk:
 	clk_put(ref_clk);
 }
-CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ath79_clocks_init_dt_ng);
-CLK_OF_DECLARE(ar9330_clk, "qca,ar9330-pll", ath79_clocks_init_dt_ng);
+
+CLK_OF_DECLARE(ar7100_clk, "qca,ar7100-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar7240_clk, "qca,ar7240-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9330_clk, "qca,ar9330-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9340_clk, "qca,ar9340-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9530_clk, "qca,qca9530-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9550_clk, "qca,qca9550-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9560_clk, "qca,qca9560-pll", ath79_clocks_init_dt);
+
 #endif
-- 
2.11.0
