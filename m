Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2016 13:43:29 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33780 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006842AbcDHLn1sNpfB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2016 13:43:27 +0200
Received: by mail-pf0-f196.google.com with SMTP id e190so9362611pfe.0;
        Fri, 08 Apr 2016 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VACHnLkxMm+PDQTwV3M78XBf2fo3YqZm5MiTMHtkgWE=;
        b=b0m1Kf7qcmB/uJ2E4dVHYu0rz0RZ6o7Ic9rLdJ+ruRmfDsrhkix7uPdcU0wL8I9lj/
         WzgZzSLBn9XnAyKsLBazjIdSDag22HmNgwcADeqEDgRx3dB9XrjOsK3x0XJMU5M/fgkd
         OrSMTYx6lQJPoRgOYAge/aH/Ue0YV7RXYA6d7wN3SSMjiAv4mt/DlM9nWkzPSv96y65W
         I9H0Zv+MgjdEjTKnbekHbLEcLF11Fmzondj0jqb4LaRg//sYYL0pHVOHqBZYC9fFymfh
         kBuyE5F7Zn7/pHMpmJPpbjh/A4IAigzWyXqlGzQRAHQ6ERWoVJDdohtgdZZmoB0Szha7
         wI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VACHnLkxMm+PDQTwV3M78XBf2fo3YqZm5MiTMHtkgWE=;
        b=OU11RUobhvzT22f89v/RlSHZa7lD26ZZn2jEs0HiWey0lZ5FY35K7pHIqNo5XkZpLj
         f7GwSG6dUVBxH2c7rScDC2aLleeiwFVKYd7U6hJ4ALNl6xae8UA1EFhipk+eTf1EhJCt
         UN56QFSC6bR6ZFFB5+EAK4h2ZtOMAfDKcTp95lDBUYJY4pW3mhAGqKrX19BpC6EQkAF2
         ND4gqx1SHxGEDLuaGsi5t8kkCO1nT/QNYgFnVZXgUgtngMUhj2RnwJGqelqTdiJ/ZN7F
         K8FV83cZDD9MLwgOqj12yNoxiFUv4hzJkRCIMeMPGoZKymCAaPMVq/gEhZQcxTyP/U+B
         xiyQ==
X-Gm-Message-State: AD7BkJIfsHHVt3Shfjcolafk6Q1GRj+xYFuVEaFuObqu7GU14PGBWvqInL8Jz/VIHkduhw==
X-Received: by 10.98.71.70 with SMTP id u67mr12158194pfa.85.1460115801600;
        Fri, 08 Apr 2016 04:43:21 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id p75sm18350744pfi.29.2016.04.08.04.43.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2016 04:43:20 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V2 1/7] clk: Loongson1: Update clocks of Loongson1B
Date:   Fri,  8 Apr 2016 19:42:55 +0800
Message-Id: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

- Rename the file to clk-loongson1.c
- Add AC97, DMA and NAND clock
- Update clock names
- Remove superfluous error messages

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
V2:
   Regenerate the patch to make it review-able.
---
 drivers/clk/Makefile                        |  2 +-
 drivers/clk/{clk-ls1x.c => clk-loongson1.c} | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)
 rename drivers/clk/{clk-ls1x.c => clk-loongson1.c} (86%)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 46869d6..5845b2c 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
-obj-$(CONFIG_MACH_LOONGSON32)		+= clk-ls1x.o
+obj-$(CONFIG_MACH_LOONGSON32)		+= clk-loongson1.o
 obj-$(CONFIG_COMMON_CLK_MAX_GEN)	+= clk-max-gen.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX77802)	+= clk-max77802.o
diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-loongson1.c
similarity index 86%
rename from drivers/clk/clk-ls1x.c
rename to drivers/clk/clk-loongson1.c
index d4c6198..ce2135c 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-loongson1.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -58,11 +58,9 @@ static struct clk *__init clk_register_pll(struct device *dev,
 	struct clk_init_data init;
 
 	/* allocate the divider */
-	hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
-	if (!hw) {
-		pr_err("%s: could not allocate clk_hw\n", __func__);
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	if (!hw)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	init.name = name;
 	init.ops = &ls1x_pll_clk_ops;
@@ -80,9 +78,9 @@ static struct clk *__init clk_register_pll(struct device *dev,
 	return clk;
 }
 
-static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
-static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
-static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+static const char *const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
+static const char *const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
+static const char *const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
 
 void __init ls1x_clk_init(void)
 {
@@ -147,6 +145,7 @@ void __init ls1x_clk_init(void)
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
 	clk_register_clkdev(clk, "ahb_clk", NULL);
+	clk_register_clkdev(clk, "ls1x-dma", NULL);
 	clk_register_clkdev(clk, "stmmaceth", NULL);
 
 	/* clock derived from AHB clk */
@@ -154,9 +153,11 @@ void __init ls1x_clk_init(void)
 	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
 					DIV_APB);
 	clk_register_clkdev(clk, "apb_clk", NULL);
-	clk_register_clkdev(clk, "ls1x_i2c", NULL);
-	clk_register_clkdev(clk, "ls1x_pwmtimer", NULL);
-	clk_register_clkdev(clk, "ls1x_spi", NULL);
-	clk_register_clkdev(clk, "ls1x_wdt", NULL);
+	clk_register_clkdev(clk, "ls1x-ac97", NULL);
+	clk_register_clkdev(clk, "ls1x-i2c", NULL);
+	clk_register_clkdev(clk, "ls1x-nand", NULL);
+	clk_register_clkdev(clk, "ls1x-pwmtimer", NULL);
+	clk_register_clkdev(clk, "ls1x-spi", NULL);
+	clk_register_clkdev(clk, "ls1x-wdt", NULL);
 	clk_register_clkdev(clk, "serial8250", NULL);
 }
-- 
1.9.1
