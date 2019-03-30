Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD6C43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBD12184D
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3+F6i5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfC3MeR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:34:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36463 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbfC3MeR (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 30 Mar 2019 08:34:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so2492050pgc.3;
        Sat, 30 Mar 2019 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xv1+U32HKvmWopQ1YYxFT0dYMaCj/Joq+aWUbYW6V8Y=;
        b=H3+F6i5gGNDrl1rqaDMoMz57iwZ2EsHugL9s0jRnwuEjAmEX9EGS2vCb14+tkYeb8y
         FJt55bot/xTW5KiEjjct6kE7RN/7J1oDIVnJWNAABtXKFaGnRtEljFZ7inr1MGNzQk1b
         KuM0MvD7G9CG+KsO8cWkBAgPg8plL7Brktr2808un7venmjuxLc2ZE6ud420kuQUPz6l
         JeTlrzY/sXE3g2oLSpCjjrYOH/zzjamI3a1BtYDUFqMey5ivFSowi4F/laJnpwyKKd80
         HHI6rfyvyCx6koXD0N7i69yesLn/jVoR9giVVUCkMBDwICHu00FPMRumVLh4GftDNwZw
         zMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xv1+U32HKvmWopQ1YYxFT0dYMaCj/Joq+aWUbYW6V8Y=;
        b=ACHxOjtexMK9HAnzzMFavgxKj53Tu0LkS8SVYHs7HyzeWp2fAT6P6t/j2bpqipWiZV
         I53asHGdpdZA1Sq7tyfKr94RdcZvVrVE60xH+DDAEbDlgWQBoMph5Rf1V9vZH2Jxj8eo
         GuE3QezELqFOS/iO+U0BoUQBFh4xMUaLqaMcwC+s3xITZRTDdqjMWR9iRYoslVmmwAJz
         BO/fXbqWwWDOx8pBsD+Ks7+hfg/hsrS6mP3uq/z121LNAIhXqj65DLDBtGt7Gjmk4/9U
         +9B/1Cg0Y10PAb7ENf0tOqE1cSDCAZ7CLU4gyHUb5d/f/go4i4J/eRlc6NSZu921zObn
         Ziow==
X-Gm-Message-State: APjAAAUC1skptJj5QHV9VIkxqDSog9jvoMZw9zcs0GH7NTLfy8LYpugs
        yNTptIVQWqH1Z+HNv/tYM94=
X-Google-Smtp-Source: APXvYqyhVo4W29O7GUeFTMJvn0DmQCqdAccbRfSXtpuGbL902+12drspGGz9p/3wTLxnBtAT2Dfe4A==
X-Received: by 2002:a62:1c07:: with SMTP id c7mr14317853pfc.159.1553949255947;
        Sat, 30 Mar 2019 05:34:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id m23sm7864309pfa.117.2019.03.30.05.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 05:34:15 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC 3/5] mips: ralink: mt7620/76x8 use clk framework and rt2880-clock driver
Date:   Sat, 30 Mar 2019 21:33:15 +0900
Message-Id: <20190330123317.16821-4-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330123317.16821-1-drvlabo@gmail.com>
References: <20190330123317.16821-1-drvlabo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

- add clock provider for reference clocks by PLL
- add gating clock tables referred by rt2880-clock driver

Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
---
 arch/mips/ralink/Kconfig               |   6 ++
 arch/mips/ralink/Makefile              |   2 +
 arch/mips/ralink/clk.c                 |  30 ++++++
 arch/mips/ralink/common.h              |   3 +
 arch/mips/ralink/mt7620.c              | 132 ++++++++++++++++++++-----
 include/dt-bindings/clock/mt7620-clk.h |  17 ++++
 6 files changed, 168 insertions(+), 22 deletions(-)
 create mode 100644 include/dt-bindings/clock/mt7620-clk.h

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 49c22ddd9c41..13301de113bb 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -18,6 +18,10 @@ config IRQ_INTC
 	default y
 	depends on !SOC_MT7621
 
+config RT2880_CLK
+	bool
+	default n
+
 choice
 	prompt "Ralink SoC selection"
 	default SOC_RT305X
@@ -40,6 +44,8 @@ choice
 		bool "MT7620/8"
 		select CPU_MIPSR2_IRQ_VI
 		select HAVE_PCI
+		select COMMON_CLK
+		select RT2880_CLK
 
 	config SOC_MT7621
 		bool "MT7621"
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index fe3471533820..af72c03ed544 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -25,6 +25,8 @@ obj-$(CONFIG_SOC_RT3883) += rt3883.o
 obj-$(CONFIG_SOC_MT7620) += mt7620.o
 obj-$(CONFIG_SOC_MT7621) += mt7621.o
 
+obj-$(CONFIG_RT2880_CLK) += rt2880-clock.o
+
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 obj-$(CONFIG_DEBUG_FS) += bootrom.o
diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 1b7df115eb60..8715a44ebc4c 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -15,8 +15,15 @@
 
 #include <asm/time.h>
 
+#ifdef CONFIG_COMMON_CLK
+#include <linux/clk-provider.h>
+#endif
+
 #include "common.h"
 
+
+#ifndef CONFIG_COMMON_CLK
+
 struct clk {
 	struct clk_lookup cl;
 	unsigned long rate;
@@ -72,6 +79,26 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
+#else	/* CONFIG_COMMON_CLK */
+
+struct clk * __init add_sys_clkdev(const char *id, unsigned long rate)
+{
+	struct clk *clk;
+	int err;
+
+	clk = clk_register_fixed_rate(NULL, id, NULL, 0, rate);
+	if (IS_ERR(clk))
+		panic("failed to allocate %s clock structure", id);
+
+	err = clk_register_clkdev(clk, NULL, id);
+	if (err)
+		panic("unable to register %s clock device", id);
+
+	return clk;
+}
+
+#endif	/* CONFIG_COMMON_CLK */
+
 void __init plat_time_init(void)
 {
 	struct clk *clk;
@@ -79,6 +106,9 @@ void __init plat_time_init(void)
 	ralink_of_remap();
 
 	ralink_clk_init();
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#endif
 	clk = clk_get_sys("cpu", NULL);
 	if (IS_ERR(clk))
 		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index b8245d0940d6..9f26ca96c411 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -26,6 +26,9 @@ extern void ralink_of_remap(void);
 
 extern void ralink_clk_init(void);
 extern void ralink_clk_add(const char *dev, unsigned long rate);
+#ifdef CONFIG_COMMON_CLK
+extern struct clk *add_sys_clkdev(const char *id, unsigned long rate);
+#endif
 
 extern void ralink_rst_init(void);
 
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index c1ce6f43642b..65dd8f7b7b9a 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -12,7 +12,13 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <dt-bindings/clock/mt7620-clk.h>
 #include <linux/bug.h>
+#include <linux/of.h>
 
 #include <asm/mipsregs.h>
 #include <asm/mach-ralink/ralink_regs.h>
@@ -20,6 +26,7 @@
 #include <asm/mach-ralink/pinmux.h>
 
 #include "common.h"
+#include "rt2880-clk_internal.h"
 
 /* analog */
 #define PMU0_CFG		0x88
@@ -504,6 +511,17 @@ mt7620_get_sys_rate(unsigned long cpu_rate)
 	return cpu_rate / div;
 }
 
+static struct clk *clks[MT7620_CLK_MAX];
+
+static struct clk_onecell_data	clk_data = {
+	.clks	= clks,
+	.clk_num = ARRAY_SIZE(clks),
+};
+
+#define RFMT(label)	label ":%lu.%03luMHz "
+#define RINT(x)		((x) / 1000000)
+#define RFRAC(x)	(((x) / 1000) % 1000)
+
 void __init ralink_clk_init(void)
 {
 	unsigned long xtal_rate;
@@ -517,10 +535,6 @@ void __init ralink_clk_init(void)
 
 	xtal_rate = mt7620_get_xtal_rate();
 
-#define RFMT(label)	label ":%lu.%03luMHz "
-#define RINT(x)		((x) / 1000000)
-#define RFRAC(x)	(((x) / 1000) % 1000)
-
 	if (is_mt76x8()) {
 		if (xtal_rate == MHZ(40))
 			cpu_rate = MHZ(580);
@@ -529,9 +543,6 @@ void __init ralink_clk_init(void)
 		dram_rate = sys_rate = cpu_rate / 3;
 		periph_rate = MHZ(40);
 		pcmi2s_rate = MHZ(480);
-
-		ralink_clk_add("10000d00.uartlite", periph_rate);
-		ralink_clk_add("10000e00.uartlite", periph_rate);
 	} else {
 		cpu_pll_rate = mt7620_get_cpu_pll_rate(xtal_rate);
 		pll_rate = mt7620_get_pll_rate(xtal_rate, cpu_pll_rate);
@@ -547,7 +558,6 @@ void __init ralink_clk_init(void)
 			 RINT(cpu_pll_rate), RFRAC(cpu_pll_rate),
 			 RINT(pll_rate), RFRAC(pll_rate));
 
-		ralink_clk_add("10000500.uart", periph_rate);
 	}
 
 	pr_debug(RFMT("CPU") RFMT("DRAM") RFMT("SYS") RFMT("PERIPH"),
@@ -555,21 +565,19 @@ void __init ralink_clk_init(void)
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
+	/* system global */
+	clks[MT7620_CLK_CPU] = add_sys_clkdev("cpu", cpu_rate);
+
+	/* parent reference clocks */
+	clks[MT7620_CLK_SYS] =
+		clk_register_fixed_rate(NULL, "sys", NULL, 0, sys_rate);
+	clks[MT7620_CLK_PERIPH] =
+		clk_register_fixed_rate(NULL, "periph", NULL, 0, periph_rate);
+	clks[MT7620_CLK_PCMI2S] =
+		clk_register_fixed_rate(NULL, "pcmi2s", NULL, 0, pcmi2s_rate);
+	clks[MT7620_CLK_XTAL] =
+		clk_register_fixed_rate(NULL, "xtal", NULL, 0, xtal_rate);
 
 	if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
 		/*
@@ -586,6 +594,86 @@ void __init ralink_clk_init(void)
 	}
 }
 
+#undef RFRAC
+#undef RINT
+#undef RFMT
+
+static void __init mt7620_clk_init_dt(struct device_node *np)
+{
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+CLK_OF_DECLARE(mt7620, "mediatek,mt7620-pll", mt7620_clk_init_dt);
+
+
+/*
+ * resources for rt2880-clock
+ */
+
+static const struct gate_clk_desc clk_mt7620[GATE_CLK_NUM] __initconst = {
+	[12] = { .name = "uart", .parent_name = "periph" },
+	[16] = { .name = "i2c", .parent_name = "periph" },
+	[17] = { .name = "i2s", .parent_name = "pcmi2s" },
+	[18] = { .name = "spi", .parent_name = "sys" },
+	[19] = { .name = "uartl", .parent_name = "periph" },
+	/*
+	 * Now we exclude to avoid that clk framework disables no used clocks.
+	 * After implementing clk API calls in peripheral drivers,
+	 * we can activate their entries.
+	 */
+#if 0
+	[6] = { .name = "ge1" },
+	[7] = { .name = "ge2" },
+	[8] = { .name = "timer", .parent_name = "periph" },
+	[9] = { .name = "intc" },
+	[10] = { .name = "mc" },
+	[11] = { .name = "pcm" },
+	[13] = { .name = "pio" },
+	[14] = { .name = "gdma" },
+	[15] = { .name = "nand" },
+	[21] = { .name = "fe" },
+	[23] = { .name = "esw" },
+	[25] = { .name = "uphy" },
+	[26] = { .name = "pcie" },
+	[28] = { .name = "aux" },
+	[30] = { .name = "sdhc" },
+#endif
+};
+
+static const struct gate_clk_desc clk_mt76x8[GATE_CLK_NUM] __initconst = {
+	[12] = { .name = "uart0", .parent_name = "periph" },
+	[16] = { .name = "i2c", .parent_name = "periph" },
+	[17] = { .name = "i2s", .parent_name = "pcmi2s" },
+	[18] = { .name = "spi", .parent_name = "sys" },
+	[19] = { .name = "uart1", .parent_name = "periph" },
+	[20] = { .name = "uart2", .parent_name = "periph" },
+#if 0
+	[8] = { .name = "timer", .parent_name = "periph" },
+	[9] = { .name = "intc" },
+	[10] = { .name = "mc" },
+	[11] = { .name = "pcm" },
+	[13] = { .name = "pio" },
+	[14] = { .name = "gdma" },
+	[23] = { .name = "eth" },
+	[25] = { .name = "uphy" },
+	[26] = { .name = "pcie" },
+	[28] = { .name = "mipsc" },
+	[29] = { .name = "crypto" },
+	[30] = { .name = "sdxc" },
+	[31] = { .name = "pwm", .parent_name = "periph" },
+#endif
+};
+
+const struct of_device_id of_match_rt2880_clk[] __initconst = {
+	{
+		.compatible = "mediatek,mt7620-clock",
+		.data = clk_mt7620 },
+	{
+		.compatible = "mediatek,mt7628-clock",
+		.data = clk_mt76x8 },
+	{	/* sentinel */	},
+};
+
+
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,mt7620a-sysc");
diff --git a/include/dt-bindings/clock/mt7620-clk.h b/include/dt-bindings/clock/mt7620-clk.h
new file mode 100644
index 000000000000..2e70e7df2ed2
--- /dev/null
+++ b/include/dt-bindings/clock/mt7620-clk.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
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

