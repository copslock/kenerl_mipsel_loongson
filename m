Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5686C4360F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9803A217D7
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/ype9SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfDEACP (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:02:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36901 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDEACP (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 4 Apr 2019 20:02:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so2210340pfr.4;
        Thu, 04 Apr 2019 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSap+Y0kjJ9K6Z2bmIVf32iY0UIhxaTdVyv3/CFwA9Y=;
        b=L/ype9SH+6hmbRci1oZsRl11GxRhOrL2Wazi0diPDjn9lDo8JH41FkigDd35lLPCq7
         Ch8c53YHxgjo0QfUTIC/IyS6tF0i/POAloxFMAJv3h+xMrOZDnma68JZoF3sw/c5ABwA
         8dys0oO32uPTIdLIVnB5lzahMGXC1b+vEepyXoigwqWDK7KKGGKov5VKtpHDxqE+uHkO
         Wekgc95PVpGGzAScdjlziodAsfKEIqSsE1VOwOsp1a6xIYeuhPJb57SrlEH4xKPz5Byj
         8/wtFV9zv/ReZcFGjNixwgK5SqRey6c4am4NgWPur8pBRgLhYRredMcuqn+fRgD9Ln4n
         etig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSap+Y0kjJ9K6Z2bmIVf32iY0UIhxaTdVyv3/CFwA9Y=;
        b=EONtpFb/mBqjKX8fEWyF8LQz1YbTjEpDnlFtF05lHEUjbUNlyQVa6L/PWRLRfYAD7j
         cJ2veUafjSxIKiHQmnqPezcKa5vSNSwYvS4wV3bVHzMTBj5ZWZrGNBTjXEiqjlXy0rQZ
         gwA6dzGd72CLkNeva+f8UqHp/PTVf+9FbCUhszCTJLyZAlnL0Vfoyxy0QuWEV5YxTB5u
         pg1Irc+tZ/zA0MrOQL9p5cFSgi/N/8g5J2MvcUqvMf803VtByhsya0d6IgNMsHcezu7D
         Uz69re24JTuA4Ij/cmLhRpYPyMktpZ5w1QHErQ3stvW2YBmNgO0oh/6xfyCCfPTmz1w3
         M6Qw==
X-Gm-Message-State: APjAAAWsZULFhYd2NIIG9jitly7Bqx5DS0QPLs8UrVPCW38MYDLz2l1u
        3xCPx/6AUE3Q56j+LacSwqo=
X-Google-Smtp-Source: APXvYqyQtn26QFUH0FquAYjzLRCkzceusK/vnXQWPEWET3DoTMjKyB2H47BtCYMRfGx/TsYSq7BJqA==
X-Received: by 2002:a62:474a:: with SMTP id u71mr8953171pfa.87.1554422534128;
        Thu, 04 Apr 2019 17:02:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id p26sm43755664pfa.49.2019.04.04.17.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 17:02:13 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC v2 3/5] mips: ralink: mt7620/76x8 use common clk framework
Date:   Fri,  5 Apr 2019 09:01:27 +0900
Message-Id: <20190405000129.19331-4-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405000129.19331-1-drvlabo@gmail.com>
References: <20190405000129.19331-1-drvlabo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch replaces PLL clks with fixed rate clock provider.

Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
---
 arch/mips/ralink/Kconfig               |  2 +
 arch/mips/ralink/clk.c                 | 33 +++++++++++
 arch/mips/ralink/common.h              |  4 ++
 arch/mips/ralink/mt7620.c              | 82 ++++++++++++++++++--------
 include/dt-bindings/clock/mt7620-clk.h | 17 ++++++
 5 files changed, 113 insertions(+), 25 deletions(-)
 create mode 100644 include/dt-bindings/clock/mt7620-clk.h

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 49c22ddd9c41..afe0576f896f 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -40,6 +40,8 @@ choice
 		bool "MT7620/8"
 		select CPU_MIPSR2_IRQ_VI
 		select HAVE_PCI
+		select COMMON_CLK
+		select COMMON_CLK_RT2880
 
 	config SOC_MT7621
 		bool "MT7621"
diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 1b7df115eb60..0fd2f0091ea4 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -15,8 +15,15 @@
 
 #include <asm/time.h>
 
+#if IS_ENABLED(CONFIG_COMMON_CLK)
+#include <linux/clk-provider.h>
+#endif
+
 #include "common.h"
 
+
+#if !IS_ENABLED(CONFIG_COMMON_CLK)
+
 struct clk {
 	struct clk_lookup cl;
 	unsigned long rate;
@@ -72,6 +79,28 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
+#else	/* CONFIG_COMMON_CLK */
+
+struct clk_hw * __init add_sys_clkdev(const char *id, unsigned long rate)
+{
+	struct clk_hw *clk_hw;
+	int err;
+
+	clk_hw = clk_hw_register_fixed_rate(NULL, id, NULL, 0, rate);
+	if (IS_ERR(clk_hw))
+		panic("failed to allocate %s clock structure", id);
+
+	err = clk_hw_register_clkdev(clk_hw, NULL, id);
+	if (err) {
+		pr_err("unable to register %s clock device\n", id);
+		clk_hw = ERR_PTR(err);
+	}
+
+	return clk_hw;
+}
+
+#endif	/* CONFIG_COMMON_CLK */
+
 void __init plat_time_init(void)
 {
 	struct clk *clk;
@@ -79,6 +108,10 @@ void __init plat_time_init(void)
 	ralink_of_remap();
 
 	ralink_clk_init();
+
+	if (IS_ENABLED(CONFIG_COMMON_CLK))
+		of_clk_init(NULL);
+
 	clk = clk_get_sys("cpu", NULL);
 	if (IS_ERR(clk))
 		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index b8245d0940d6..3c56a8d0517f 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -25,7 +25,11 @@ extern struct ralink_soc_info soc_info;
 extern void ralink_of_remap(void);
 
 extern void ralink_clk_init(void);
+#if IS_ENABLED(CONFIG_COMMON_CLK)
+extern struct clk_hw *add_sys_clkdev(const char *id, unsigned long rate);
+#else
 extern void ralink_clk_add(const char *dev, unsigned long rate);
+#endif
 
 extern void ralink_rst_init(void);
 
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index c1ce6f43642b..74aed8f7e502 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -10,9 +10,10 @@
  * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/bug.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/clk-provider.h>
+#include <dt-bindings/clock/mt7620-clk.h>
 
 #include <asm/mipsregs.h>
 #include <asm/mach-ralink/ralink_regs.h>
@@ -504,6 +505,12 @@ mt7620_get_sys_rate(unsigned long cpu_rate)
 	return cpu_rate / div;
 }
 
+static struct clk_hw_onecell_data *clk_data;
+
+#define RFMT(label)	label ":%lu.%03luMHz "
+#define RINT(x)		((x) / 1000000)
+#define RFRAC(x)	(((x) / 1000) % 1000)
+
 void __init ralink_clk_init(void)
 {
 	unsigned long xtal_rate;
@@ -517,10 +524,6 @@ void __init ralink_clk_init(void)
 
 	xtal_rate = mt7620_get_xtal_rate();
 
-#define RFMT(label)	label ":%lu.%03luMHz "
-#define RINT(x)		((x) / 1000000)
-#define RFRAC(x)	(((x) / 1000) % 1000)
-
 	if (is_mt76x8()) {
 		if (xtal_rate == MHZ(40))
 			cpu_rate = MHZ(580);
@@ -529,9 +532,6 @@ void __init ralink_clk_init(void)
 		dram_rate = sys_rate = cpu_rate / 3;
 		periph_rate = MHZ(40);
 		pcmi2s_rate = MHZ(480);
-
-		ralink_clk_add("10000d00.uartlite", periph_rate);
-		ralink_clk_add("10000e00.uartlite", periph_rate);
 	} else {
 		cpu_pll_rate = mt7620_get_cpu_pll_rate(xtal_rate);
 		pll_rate = mt7620_get_pll_rate(xtal_rate, cpu_pll_rate);
@@ -547,7 +547,6 @@ void __init ralink_clk_init(void)
 			 RINT(cpu_pll_rate), RFRAC(cpu_pll_rate),
 			 RINT(pll_rate), RFRAC(pll_rate));
 
-		ralink_clk_add("10000500.uart", periph_rate);
 	}
 
 	pr_debug(RFMT("CPU") RFMT("DRAM") RFMT("SYS") RFMT("PERIPH"),
@@ -555,21 +554,29 @@ void __init ralink_clk_init(void)
 		 RINT(dram_rate), RFRAC(dram_rate),
 		 RINT(sys_rate), RFRAC(sys_rate),
 		 RINT(periph_rate), RFRAC(periph_rate));
-#undef RFRAC
-#undef RINT
-#undef RFMT
 
-	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("10000100.timer", periph_rate);
-	ralink_clk_add("10000120.watchdog", periph_rate);
-	ralink_clk_add("10000900.i2c", periph_rate);
-	ralink_clk_add("10000a00.i2s", pcmi2s_rate);
-	ralink_clk_add("10000b00.spi", sys_rate);
-	ralink_clk_add("10000b40.spi", sys_rate);
-	ralink_clk_add("10000c00.uartlite", periph_rate);
-	ralink_clk_add("10000d00.uart1", periph_rate);
-	ralink_clk_add("10000e00.uart2", periph_rate);
-	ralink_clk_add("10180000.wmac", xtal_rate);
+	clk_data = kzalloc(struct_size(clk_data, hws, MT7620_CLK_MAX),
+				GFP_KERNEL);
+	if (!clk_data)
+		return;
+	clk_data->num = MT7620_CLK_MAX;
+
+	/* system global */
+	clk_data->hws[MT7620_CLK_CPU] = add_sys_clkdev("cpu", cpu_rate);
+
+	/* parent reference clocks */
+	clk_data->hws[MT7620_CLK_SYS] =
+		clk_hw_register_fixed_rate(NULL, "sys", NULL,
+						0, sys_rate);
+	clk_data->hws[MT7620_CLK_PERIPH] =
+		clk_hw_register_fixed_rate(NULL, "periph", NULL,
+						0, periph_rate);
+	clk_data->hws[MT7620_CLK_PCMI2S] =
+		clk_hw_register_fixed_rate(NULL, "pcmi2s", NULL,
+						0, pcmi2s_rate);
+	clk_data->hws[MT7620_CLK_XTAL] =
+		clk_hw_register_fixed_rate(NULL, "xtal", NULL,
+						0, xtal_rate);
 
 	if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
 		/*
@@ -586,6 +593,31 @@ void __init ralink_clk_init(void)
 	}
 }
 
+#undef RFRAC
+#undef RINT
+#undef RFMT
+
+static int mt7620_pll_probe(struct platform_device *pdev)
+{
+	of_clk_add_hw_provider(pdev->dev.of_node,
+				of_clk_hw_onecell_get, clk_data);
+	return 0;
+}
+
+static const struct of_device_id mt7620_pll_ids[] = {
+	{ .compatible = "mediatek,mt7620-pll" },
+	{ },
+};
+
+static struct platform_driver mt7620_pll_driver = {
+	.probe = mt7620_pll_probe,
+	.driver = {
+		.name = "mt7620-pll",
+		.of_match_table = mt7620_pll_ids,
+	},
+};
+builtin_platform_driver(mt7620_pll_driver);
+
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,mt7620a-sysc");
diff --git a/include/dt-bindings/clock/mt7620-clk.h b/include/dt-bindings/clock/mt7620-clk.h
new file mode 100644
index 000000000000..54d3c582ca7f
--- /dev/null
+++ b/include/dt-bindings/clock/mt7620-clk.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 NOGUCHI Hiroshi <drvlabo@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_MT7620_CLK_H
+#define __DT_BINDINGS_MT7620_CLK_H
+
+#define MT7620_CLK_CPU		0
+#define	MT7620_CLK_SYS		1
+#define	MT7620_CLK_PERIPH	2
+#define	MT7620_CLK_PCMI2S	3
+#define	MT7620_CLK_XTAL		4
+
+#define MT7620_CLK_MAX		5
+
+#endif /* __DT_BINDINGS_MT7620_CLK_H */
-- 
2.20.1

