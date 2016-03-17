Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:36:38 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32969 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007013AbcCQDerQd-jp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:47 +0100
Received: by mail-lf0-f65.google.com with SMTP id l83so2209095lfd.0
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+X4Ua2WcHtrMDjl+/85wPmyZV/ZgeSsDqLrHZrZzubs=;
        b=WRN7l/3HxnuiXff6zT0SbvLTTaXfo6+OBg4K/yhp97WLtqfnwskTdkZksB/+72JGSH
         Dedxooy1XAPnH8r6rdyJjJ4tGk9QqAeiwkpW7XHPNiwC/Yf9ZQm079d3v6+1KF0dwm4f
         1tOUROsYtFrjP2dkK6rNhVqK/bdiB6jhOM0+P9Unb7ygLnDuSmakTA1vIOC/e32nWg98
         aOUFglJ3VYj7+ydGcjI70eIYoJW1Q6lxEaFD2e1ygDojtcyhl2Lc6NZlZsX4wl5zei0c
         uNffG9jpjrKacNkf5ycklRchAhGmomjHqYpIv1Lpji2GZHicvtf0gym8FqPh4PPJ3odM
         IC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+X4Ua2WcHtrMDjl+/85wPmyZV/ZgeSsDqLrHZrZzubs=;
        b=CJHUQhoJhuZ6wcVbzzwMC404+PL7MF0at74DF74mfNQy0dMFdE8MZPlaeHC4LYJc33
         nVZcJ0l/VbWhfzYbsxLVxwC0CDzfQ/hn5olkrXqoJOYAf9mm2pUgI5epCS0ok61DJBzQ
         dnw+SyJkKxj4KKcKeuUzdSBWhP4hq8OdcxFleZ8nSLwks1ZkGMAbvs5/q/kI8FUEOUPL
         3jAAv6og9xWYygUMpfoRK0OYofyUoWAEpa8gKhvaPlkW26FLiBjtv2H//QdWpbFcZF8r
         xSrgyFnU8ggrTnae1PcyxIXG+WKPwf4xieoPJ9ndBiRT7dCYVuArSb2rkX2G95OuWPtS
         30MQ==
X-Gm-Message-State: AD7BkJLIP+Xuv/iYg7LqqIU1AyHRKwvBQK69kSFGUg4yO1kRabLg/JiTqHNKZKfDXUuRlA==
X-Received: by 10.25.78.137 with SMTP id c131mr2219931lfb.21.1458185681983;
        Wed, 16 Mar 2016 20:34:41 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:41 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 07/18] MIPS: ath79: introduce <dt-bindings/clock/ath79-clk.h>
Date:   Thu, 17 Mar 2016 06:34:14 +0300
Message-Id: <1458185665-4521-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

The include/dt-bindings/clock/ath79-clk.h header file
is introduced so we can use symbolic identifiers for SoC clocks.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/ath79/clock.c               | 33 +++++++++++++++++----------------
 arch/mips/boot/dts/qca/ar9132.dtsi    |  8 +++++---
 include/dt-bindings/clock/ath79-clk.h | 19 +++++++++++++++++++
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 618dfd7..c3a94ea 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <dt-bindings/clock/ath79-clk.h>
 
 #include <asm/div64.h>
 
@@ -28,7 +29,7 @@
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	40000000
 
-static struct clk *clks[3];
+static struct clk *clks[ATH79_CLK_END];
 static struct clk_onecell_data clk_data = {
 	.clks = clks,
 	.clk_num = ARRAY_SIZE(clks),
@@ -78,9 +79,9 @@ static void __init ar71xx_clocks_init(void)
 	ahb_rate = cpu_rate / div;
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
@@ -114,9 +115,9 @@ static void __init ar724x_clocks_init(void)
 	ahb_rate = cpu_rate / div;
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
@@ -176,9 +177,9 @@ static void __init ar933x_clocks_init(void)
 	}
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -310,9 +311,9 @@ static void __init ar934x_clocks_init(void)
 		ahb_rate = cpu_pll / (postdiv + 1);
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -397,9 +398,9 @@ static void __init qca955x_clocks_init(void)
 		ahb_rate = cpu_pll / (postdiv + 1);
 
 	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 3bff63b..2f9a3ee 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -1,3 +1,5 @@
+#include <dt-bindings/clock/ath79-clk.h>
+
 / {
 	compatible = "qca,ar9132";
 
@@ -57,7 +59,7 @@
 				reg = <0x18020000 0x20>;
 				interrupts = <3>;
 
-				clocks = <&pll 2>;
+				clocks = <&pll ATH79_CLK_AHB>;
 				clock-names = "uart";
 
 				reg-io-width = <4>;
@@ -100,7 +102,7 @@
 
 				interrupts = <4>;
 
-				clocks = <&pll 2>;
+				clocks = <&pll ATH79_CLK_AHB>;
 				clock-names = "wdt";
 			};
 
@@ -144,7 +146,7 @@
 			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
 			reg = <0x1f000000 0x10>;
 
-			clocks = <&pll 2>;
+			clocks = <&pll ATH79_CLK_AHB>;
 			clock-names = "ahb";
 
 			status = "disabled";
diff --git a/include/dt-bindings/clock/ath79-clk.h b/include/dt-bindings/clock/ath79-clk.h
new file mode 100644
index 0000000..27359ad
--- /dev/null
+++ b/include/dt-bindings/clock/ath79-clk.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2014, 2016 Antony Pavlov <antonynpavlov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_ATH79_CLK_H
+#define __DT_BINDINGS_ATH79_CLK_H
+
+#define ATH79_CLK_CPU		0
+#define ATH79_CLK_DDR		1
+#define ATH79_CLK_AHB		2
+
+#define ATH79_CLK_END		3
+
+#endif /* __DT_BINDINGS_ATH79_CLK_H */
-- 
2.7.0
