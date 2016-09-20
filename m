Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 17:55:20 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36426 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992688AbcITPzOT4D5o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 17:55:14 +0200
Received: by mail-pf0-f195.google.com with SMTP id n24so1136925pfb.3
        for <linux-mips@linux-mips.org>; Tue, 20 Sep 2016 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UHQ5juj6czyfuLwJ4ueAm3ZPdyLGCE6IaeLQLkbyD+Y=;
        b=lL5mKw2KHUJLDJ5a04hsadMY6kOdGcaCZqBY5J5eNiO2SncYJJ193YtPeAmRfHzj3S
         SmhROKbSjYoB+ceZgTNrhvPOjS3qpXs/RidHEWdfZTXrL0/bcA8siBIVrE9w/MQjGCPi
         sSGpo6NXFF5ZiK+VsY4KcQphzc+qT0r2XWdxHTdKSfSoDcJYufOg437TR+K2RD0RdJSs
         MLOgOUsWJN+9xKndJVtrx5DGnN4ScybRW4MvvWUAHnykXzXhgPV6+fktbpKLD0cyn1qy
         PgPctq7NFok9KG+xD0/smHNiIdVxwNWzbvCd+/0s6sPkBeRWHqXxVf5S2NZipO5IxcB1
         it7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UHQ5juj6czyfuLwJ4ueAm3ZPdyLGCE6IaeLQLkbyD+Y=;
        b=PdLtB0/nQQkhK/24t5BCO6CRURkWEo8h/zGCqNXxY7Ww9AqH2pfjM6D1vxiXINlq08
         x0yiRu4/9SMPihXaiGIvZ2+Wv6E3H4F8rhB6o1vXhyzOjBAefv75HUt+Dx/J96wy5oD0
         QkiV7QfUiYd5vFN+L9hOc3taUhQ4nQTDkCnNzdvieFIeL0jMC6p+JvfvGzd299zBp65l
         qGgZtDtDTHmoq23frHqECpaWP4SYXcP8aBbt5wgzTkENChLlBFiFA7lBliJqGhmCBFA6
         KiDw9aL0jHJS7oQ70dsr0ifscFQCKAU778vXPR+EIK02JHCuf6eF6i07ImNDuBtRQKlC
         CQxA==
X-Gm-Message-State: AE9vXwOL4H0vUiyjiXScl8kyEOdr+rXFSUGTLscigbSg0TQzfZnoV77FId3aHgWuWgjJgw==
X-Received: by 10.98.22.21 with SMTP id 21mr27306469pfw.4.1474386908429;
        Tue, 20 Sep 2016 08:55:08 -0700 (PDT)
Received: from ubuntu ([121.237.185.127])
        by smtp.gmail.com with ESMTPSA id p7sm32543443paa.3.2016.09.20.08.55.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 08:55:07 -0700 (PDT)
Date:   Tue, 20 Sep 2016 23:54:56 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     mturquette@baylibre.com, sboyd@codeaurora.org,
        keguang.zhang@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, gnaygnil@gmail.com
Subject: [PATCH v3] CLK: Add Loongson1C clock support
Message-ID: <20160920155439.GA26095@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55217
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
V3:
 clk: loongson1c: Migrate to clk_hw based OF and registration APIs.
---
V2:
 Use loongson1 generic clock interface.
---
 drivers/clk/loongson1/Makefile         |  1 +
 drivers/clk/loongson1/clk-loongson1c.c | 97 ++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
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
index 0000000..3466f73
--- /dev/null
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -0,0 +1,97 @@
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
+	.recalc_rate = ls1x_pll_recalc_rate,
+};
+
+static const struct clk_div_table ahb_div_table[] = {
+	[0] = { .val = 0, .div = 2 },
+	[1] = { .val = 1, .div = 4 },
+	[2] = { .val = 2, .div = 3 },
+	[3] = { .val = 3, .div = 3 },
+};
+
+void __init ls1x_clk_init(void)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
+	clk_hw_register_clkdev(hw, "osc_clk", NULL);
+
+	/* clock derived from 24 MHz OSC clk */
+	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
+				&ls1x_pll_clk_ops, 0);
+	clk_hw_register_clkdev(hw, "pll_clk", NULL);
+
+	hw = clk_hw_register_divider(NULL, "cpu_clk_div", "pll_clk",
+				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
+				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
+				   CLK_DIVIDER_ONE_BASED |
+				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
+	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
+	hw = clk_hw_register_fixed_factor(NULL, "cpu_clk", "cpu_clk_div",
+					0, 1, 1);
+	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
+
+	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
+				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
+				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
+	hw = clk_hw_register_fixed_factor(NULL, "dc_clk", "dc_clk_div",
+					0, 1, 1);
+	clk_hw_register_clkdev(hw, "dc_clk", NULL);
+
+	hw = clk_hw_register_divider_table(NULL, "ahb_clk_div", "cpu_clk_div",
+				0, LS1X_CLK_PLL_FREQ, DIV_DDR_SHIFT,
+				DIV_DDR_WIDTH, CLK_DIVIDER_ALLOW_ZERO,
+				ahb_div_table, &_lock);
+	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
+	hw = clk_hw_register_fixed_factor(NULL, "ahb_clk", "ahb_clk_div",
+					0, 1, 1);
+	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
+	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
+
+	/* clock derived from AHB clk */
+	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
+					DIV_APB);
+	clk_hw_register_clkdev(hw, "apb_clk", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-nand", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-pwmtimer", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-spi", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
+	clk_hw_register_clkdev(hw, "serial8250", NULL);
+}
-- 
1.9.1
