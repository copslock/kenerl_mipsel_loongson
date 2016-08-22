Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2016 06:50:53 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36472 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990518AbcHVEuqo2rUA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2016 06:50:46 +0200
Received: by mail-pf0-f194.google.com with SMTP id y134so5572074pfg.3
        for <linux-mips@linux-mips.org>; Sun, 21 Aug 2016 21:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=upW2vr8mnv5WEblHfoPvbhYidJWqLYNG5mLbTkRisNI=;
        b=UgI0X+XiJkvoGq/YioP+foklpz0LeJrS1hcHHQB57hkYt6ZjWgQ5ipvusccxKJ1Y8d
         azcd+S3uDHCKdSnlrPSF9575YoIiCvhiZKACiV8cuD4h4DbzMOryD0GyIEGVKd8vz+eh
         pAUGjeh//YZloPTO9OnptiGGMtgDkIaDYDDOksuTrMQ123V2PIp+3MTCBbzXqzY6SH90
         2TUDMV677VHb3xjDybm+DPyWzqqlCOel98dN1pLlXU9xbGP4c3wB7qvj40NDk+DegURF
         IiDcSKC48fmk5D8ZEvTfYtlJgrUQMpG0uERbWAEy4wRwLrqz34tB3tYY5kalGM9fSuhv
         dbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=upW2vr8mnv5WEblHfoPvbhYidJWqLYNG5mLbTkRisNI=;
        b=b+DKrwuDjo2QBIpvMK8f7qvcqwGVkUMDoGiMUr8eSKAeMWtFbmnONVkPKal13tpYea
         ncdHf9f/yI7XwWzK4wnwNGtsdE27YJFB0GYZOur+FLodIstStqdpu0aVlxObDJ9qe0Eh
         ogd5rB7paxjRaPmhrvTzruiGobzBnV47GQiSdvaBCiJ2UWkkLL38ykGKQmx965MakiDP
         WUoUvnssbhxSvZ+t3IuTAoSbShTdnj7UAWB662+cTOOpE7JRm3PNyginlG371+UxLVxa
         aCVkix4INIb0lwohMjiDDf8UaCs6p6x21Zp9HK3rC36/CAa/Z/PRyOOFfP5o2Yz4tZAU
         xsvw==
X-Gm-Message-State: AEkooutAlyHkwiTd1/y3/ZOZ/b10neQNLB9+ugDisWUVNI3qbPBN7uV+jwwH3zLnDdBJSA==
X-Received: by 10.98.98.193 with SMTP id w184mr39364389pfb.120.1471841440722;
        Sun, 21 Aug 2016 21:50:40 -0700 (PDT)
Received: from ly-pc ([114.221.236.83])
        by smtp.gmail.com with ESMTPSA id d9sm28533631pan.7.2016.08.21.21.50.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 Aug 2016 21:50:39 -0700 (PDT)
Date:   Mon, 22 Aug 2016 12:50:39 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     keguang.zhang@gmail.com, mturquette@baylibre.com,
        sboyd@codeaurora.org
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] CLK: Add Loongson1C clock support
Message-ID: <20160822045034.GA6545@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

This patch adds clock support to Loongson1C SoC.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>

---
V2:
  Use loongson1 generic clock interface.
---
 drivers/clk/loongson1/Makefile         |   1 +
 drivers/clk/loongson1/clk-loongson1c.c | 102 +++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 drivers/clk/loongson1/clk-loongson1c.c

diff --git a/drivers/clk/loongson1/Makefile b/drivers/clk/loongson1/Makefile
index 5a162a1..b7f6a16 100644
--- a/drivers/clk/loongson1/Makefile
+++ b/drivers/clk/loongson1/Makefile
@@ -1,2 +1,3 @@
 obj-y				+= clk.o
 obj-$(CONFIG_LOONGSON1_LS1B)	+= clk-loongson1b.o
+obj-$(CONFIG_LOONGSON1_LS1C)	+= clk-loongson1c.o
diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
new file mode 100644
index 0000000..7e7e5ff
--- /dev/null
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+
+#include <loongson1.h>
+#include "clk.h"
+
+#define OSC		(24 * 1000000)
+#define DIV_APB		1
+
+static DEFINE_SPINLOCK(_lock);
+
+static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	u32 pll, rate;
+
+	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
+	rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
+	rate *= OSC;
+	rate >>= 2;
+
+	return rate;
+}
+
+static const struct clk_ops ls1x_pll_clk_ops = {
+	.enable = ls1x_pll_clk_enable,
+	.disable = ls1x_pll_clk_disable,
+	.recalc_rate = ls1x_pll_recalc_rate,
+};
+
+static const char *const cpu_parents[] = { "cpu_clk_div", "osc_clk", };
+static const char *const ahb_parents[] = { "ahb_clk_div", "osc_clk", };
+static const char *const dc_parents[] = { "dc_clk_div", "osc_clk", };
+
+static const struct clk_div_table ahb_div_table[] = {
+	[0] = {	.val = 0, .div = 2 },
+	[1] = {	.val = 1, .div = 4 },
+	[2] = {	.val = 2, .div = 3 },
+	[3] = {	.val = 3, .div = 3 },
+};
+
+void __init ls1x_clk_init(void)
+{
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
+	clk_register_clkdev(clk, "osc_clk", NULL);
+
+	/* clock derived from 24 MHz OSC clk */
+	clk = clk_register_pll(NULL, "pll_clk", "osc_clk",
+				&ls1x_pll_clk_ops, 0);
+	clk_register_clkdev(clk, "pll_clk", NULL);
+
+	clk = clk_register_divider(NULL, "cpu_clk_div", "pll_clk",
+				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
+				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
+				   CLK_DIVIDER_ONE_BASED |
+				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
+	clk_register_clkdev(clk, "cpu_clk_div", NULL);
+	clk = clk_register_fixed_factor(NULL, "cpu_clk", "cpu_clk_div",
+					0, 1, 1);
+	clk_register_clkdev(clk, "cpu_clk", NULL);
+
+	clk = clk_register_divider(NULL, "dc_clk_div", "pll_clk",
+				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
+				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+	clk_register_clkdev(clk, "dc_clk_div", NULL);
+	clk = clk_register_fixed_factor(NULL, "dc_clk", "dc_clk_div", 0, 1, 1);
+	clk_register_clkdev(clk, "dc_clk", NULL);
+
+	clk = clk_register_divider_table(NULL, "ahb_clk_div", "cpu_clk_div",
+				0, LS1X_CLK_PLL_FREQ, DIV_DDR_SHIFT,
+				DIV_DDR_WIDTH, CLK_DIVIDER_ALLOW_ZERO,
+				ahb_div_table, &_lock);
+	clk_register_clkdev(clk, "ahb_clk_div", NULL);
+	clk = clk_register_fixed_factor(NULL, "ahb_clk", "ahb_clk_div",
+					0, 1, 1);
+	clk_register_clkdev(clk, "ahb_clk", NULL);
+	clk_register_clkdev(clk, "ls1x-dma", NULL);
+	clk_register_clkdev(clk, "stmmaceth", NULL);
+
+	/* clock derived from AHB clk */
+	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
+					DIV_APB);
+	clk_register_clkdev(clk, "apb_clk", NULL);
+	clk_register_clkdev(clk, "ls1x-ac97", NULL);
+	clk_register_clkdev(clk, "ls1x-i2c", NULL);
+	clk_register_clkdev(clk, "ls1x-nand", NULL);
+	clk_register_clkdev(clk, "ls1x-pwmtimer", NULL);
+	clk_register_clkdev(clk, "ls1x-spi", NULL);
+	clk_register_clkdev(clk, "ls1x-wdt", NULL);
+	clk_register_clkdev(clk, "serial8250", NULL);
+}
-- 
1.9.1
