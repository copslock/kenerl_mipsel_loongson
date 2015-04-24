Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 13:44:11 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:24613 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025401AbbDXLoBtltwj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Apr 2015 13:44:01 +0200
Received: from localhost.localdomain (unknown [85.177.202.128])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id EA491822CE;
        Fri, 24 Apr 2015 13:41:26 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/12] MIPS: ath79: Add OF support to the clocks
Date:   Fri, 24 Apr 2015 13:41:15 +0200
Message-Id: <1429875679-14973-9-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429875679-14973-1-git-send-email-albeu@free.fr>
References: <1429875679-14973-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Allow using the SoC clocks in the device tree.
---
v3: * Fix the compatible string for qca9550
---
 arch/mips/ath79/clock.c | 63 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 1fcb691..eb5117c 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -29,7 +29,14 @@
 #define AR724X_BASE_FREQ	5000000
 #define AR913X_BASE_FREQ	5000000
 
-static void __init ath79_add_sys_clkdev(const char *id, unsigned long rate)
+static struct clk *clks[3];
+static struct clk_onecell_data clk_data = {
+	.clks = clks,
+	.clk_num = ARRAY_SIZE(clks),
+};
+
+static struct clk *__init ath79_add_sys_clkdev(
+	const char *id, unsigned long rate)
 {
 	struct clk *clk;
 	int err;
@@ -41,6 +48,8 @@ static void __init ath79_add_sys_clkdev(const char *id, unsigned long rate)
 	err = clk_register_clkdev(clk, id, NULL);
 	if (err)
 		panic("unable to register %s clock device", id);
+
+	return clk;
 }
 
 static void __init ar71xx_clocks_init(void)
@@ -70,9 +79,9 @@ static void __init ar71xx_clocks_init(void)
 	ahb_rate = cpu_rate / div;
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
@@ -106,9 +115,9 @@ static void __init ar724x_clocks_init(void)
 	ahb_rate = cpu_rate / div;
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
@@ -139,9 +148,9 @@ static void __init ar913x_clocks_init(void)
 	ahb_rate = cpu_rate / div;
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
@@ -201,9 +210,9 @@ static void __init ar933x_clocks_init(void)
 	}
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -335,9 +344,9 @@ static void __init ar934x_clocks_init(void)
 		ahb_rate = cpu_pll / (postdiv + 1);
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -422,9 +431,9 @@ static void __init qca955x_clocks_init(void)
 		ahb_rate = cpu_pll / (postdiv + 1);
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -446,6 +455,8 @@ void __init ath79_clocks_init(void)
 		qca955x_clocks_init();
 	else
 		BUG();
+
+	of_clk_init(NULL);
 }
 
 unsigned long __init
@@ -463,3 +474,17 @@ ath79_get_sys_clk_rate(const char *id)
 
 	return rate;
 }
+
+#ifdef CONFIG_OF
+static void __init ath79_clocks_init_dt(struct device_node *np)
+{
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+
+CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9130, "qca,ar9130-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
+#endif
-- 
2.0.0
