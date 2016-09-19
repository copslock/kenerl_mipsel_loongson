Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 06:40:14 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33217 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbcISEj1SH8nr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Sep 2016 06:39:27 +0200
Received: by mail-pf0-f193.google.com with SMTP id q2so3977754pfj.0
        for <linux-mips@linux-mips.org>; Sun, 18 Sep 2016 21:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=psKvUvbn2gDx+BqanHU13UX+68fBJlwPN9X2+ucFxqY=;
        b=1C5AESFw+C/UG7wsWTFuRijPMLuFb05Yj6A1e+b16TZLT03Q/E61SNnKv9VVmxJ8BW
         /8l0i2h9xMCJsd1x94hlydmjg3A3UMEHv1QiDMM7J67T7q8eNVBfaazH5f5rXlNHbC4x
         W4xpKBCZ42VPJG6go9paTAE9oqQSkwM31Pv03N4qVOSpZqy6KOaTn1p0GUSo0EwDhbkg
         brt5xXnlMXuarWw8PorRkOzTXDWypNkHawRnQv4NCLS3tMf/pccGaVft0gWfqQOkT2vA
         RbPM7AJzn2l+zm01e0xEfiag/1sZBgcPcFamKK3xF+JiEcB+JONywMrb2LgSnjlbWevm
         hAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=psKvUvbn2gDx+BqanHU13UX+68fBJlwPN9X2+ucFxqY=;
        b=VykCEmbVd+G8Pl6mak9WxCsKtmKx4YQMsSuFLJt6EDkraGRaP9J9VLz5C3ztrzoRI6
         lTVz+LFLfQyIuaUhHDD57rwhbpfqhD6tsT6wuWYJuio5TzQieAnlUW6u8/EtrmF18G/s
         jMmal1xeHNQ3lhMG+hQMDRE19clF0mvjk+D9PZ3bF5QaG3Dtk8mFBb2CFq/jFRZb0b9Z
         O8UEWL6EIxCgXXApNTpj2NblsdEjOOjS66vuMc/FJL++bdoANXjslwGb85lpwLtlp7g1
         LFyNJjmIIAx0WP/HAPkoLvIODDPXSphar0OM57/0FULR48RDnU/DyzviSLVrkIhGnPb5
         5E7A==
X-Gm-Message-State: AE9vXwM8tbxWdME99JDUkZMRRrI3ZX9057yJOfp4dcWd460YgzBVXCQVbzexqY7EBpwHww==
X-Received: by 10.98.64.93 with SMTP id n90mr43535547pfa.29.1474259961492;
        Sun, 18 Sep 2016 21:39:21 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id p7sm19598950paa.3.2016.09.18.21.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Sep 2016 21:39:20 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1 2/3] clk: Loongson1: Update clocks of Loongson1B
Date:   Mon, 19 Sep 2016 12:38:55 +0800
Message-Id: <1474259936-9657-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1474259936-9657-1-git-send-email-keguang.zhang@gmail.com>
References: <1474259936-9657-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55163
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

This patch updates some clock names of Loongson1B,
and adds AC97, DMA and NAND clock.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
v1:
   Rebase the patch on clk: ls1x: Migrate to clk_hw based OF
   and registration APIs.
---
 drivers/clk/loongson1/clk-loongson1b.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongson1/clk-loongson1b.c
index 5b6817e..4b3d9d2 100644
--- a/drivers/clk/loongson1/clk-loongson1b.c
+++ b/drivers/clk/loongson1/clk-loongson1b.c
@@ -37,19 +37,19 @@ static const struct clk_ops ls1x_pll_clk_ops = {
 	.recalc_rate = ls1x_pll_recalc_rate,
 };
 
-static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
-static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
-static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+static const char *const cpu_parents[] = { "cpu_clk_div", "osc_clk", };
+static const char *const ahb_parents[] = { "ahb_clk_div", "osc_clk", };
+static const char *const dc_parents[] = { "dc_clk_div", "osc_clk", };
 
 void __init ls1x_clk_init(void)
 {
 	struct clk_hw *hw;
 
-	hw = clk_hw_register_fixed_rate(NULL, "osc_33m_clk", NULL, 0, OSC);
-	clk_hw_register_clkdev(hw, "osc_33m_clk", NULL);
+	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
+	clk_hw_register_clkdev(hw, "osc_clk", NULL);
 
 	/* clock derived from 33 MHz OSC clk */
-	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_33m_clk",
+	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
 				 &ls1x_pll_clk_ops, 0);
 	clk_hw_register_clkdev(hw, "pll_clk", NULL);
 
@@ -104,6 +104,7 @@ void __init ls1x_clk_init(void)
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
 	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
 	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
 
 	/* clock derived from AHB clk */
@@ -111,9 +112,11 @@ void __init ls1x_clk_init(void)
 	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
 					DIV_APB);
 	clk_hw_register_clkdev(hw, "apb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x_i2c", NULL);
-	clk_hw_register_clkdev(hw, "ls1x_pwmtimer", NULL);
-	clk_hw_register_clkdev(hw, "ls1x_spi", NULL);
-	clk_hw_register_clkdev(hw, "ls1x_wdt", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-nand", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-pwmtimer", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-spi", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
 	clk_hw_register_clkdev(hw, "serial8250", NULL);
 }
-- 
1.9.1
