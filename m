Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 22:59:42 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33799 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012286AbcBMV6ejZRpi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:34 +0100
Received: by mail-lf0-f67.google.com with SMTP id 78so5751893lfy.1;
        Sat, 13 Feb 2016 13:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0frF0qEC14VycxeRq1php3rMz7JF8qkgZFTfmw2ipr4=;
        b=AMR2ryvczFg1LfUtGFh0PDr5+btWsIg85HT7b87m6+eQODn22WmmJtM0Izxr9WJBqy
         rfzSxtSVyV7U/wsKI5SqZQKrqIumjSbONpslpUGC5wc/W3aoi7A4nNcSptl7DuZYLfxd
         KD3kEbtlZv1lTemgCGAYkdv5TXdZjvqTKgQWAFguPmtfakSmx01gdOTfeq3QzDaPqatS
         Kl7ikqQVo+xx8nbg0vUWz8fFAVGtm4q2Oqq8sET6GLwepQ/dwvvPQWlDPkhoDTMTWvxh
         Ekgt2S0lpKybFqnQtMT9FXvQjIMTtHwYNDsiYjMOZs6QQrNwAv3XN6YTI59etAxRUcxx
         aMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0frF0qEC14VycxeRq1php3rMz7JF8qkgZFTfmw2ipr4=;
        b=LJpVBN8y6dtXuPV6w9aqXosLvpWF8v0j4FuIRhqeFpRD2fi+dkgkAubKxU1Rp4431l
         2PIpv1n63eNj2ZKVEVQQSJJQKfGDpwhOGqA1DGKSvuS8DUKu9FTI4ch0MtQTTKZnFpAe
         CtUecOWNpgzGfWWtxWKhnEa1Y/3V7ALRBfgq9UEnJJY5SGuTeU0+xDQ9wE93xmbHAE5o
         UBN2d5XKUSMd8sPwXIvH9HjY4SPWshTlqV+BhZkuEgop1hg1zWkBHVEc3xyK9lL7Gg/U
         k/CctDvI545KPxi8dvpgKyB9gMLO/Cfxlpyo3i0C1hOJH9/pxKvtqCcyG5x2k8s5xrx+
         Ki8A==
X-Gm-Message-State: AG10YORASVgppxdWPfS7UXi6sz87I2sL7T58kY38jBNCMJRrNBv2EDd3a7qnSyLB83DpbQ==
X-Received: by 10.25.41.140 with SMTP id p134mr3824841lfp.15.1455400709431;
        Sat, 13 Feb 2016 13:58:29 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:28 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH 04/10] MIPS: ath79: Fix the ar913x reference clock rate
Date:   Sun, 14 Feb 2016 00:58:11 +0300
Message-Id: <1455400697-29898-5-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52036
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

From: Alban Bedel <albeu@free.fr>

The reference clock on ar913x is at 40MHz and not 5MHz. The current
implementation use the wrong reference rate because it doesn't take
the PLL divider in account. But if we fix the code to use the divider
it becomes identical with the implementation for ar724x, so just drop
the broken ar913x implementation.

Signed-off-by: Alban Bedel <albeu@free.fr>
Tested-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ath79/clock.c | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index ed28465..618dfd7 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -27,7 +27,6 @@
 
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	40000000
-#define AR913X_BASE_FREQ	5000000
 
 static struct clk *clks[3];
 static struct clk_onecell_data clk_data = {
@@ -123,39 +122,6 @@ static void __init ar724x_clocks_init(void)
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
-static void __init ar913x_clocks_init(void)
-{
-	unsigned long ref_rate;
-	unsigned long cpu_rate;
-	unsigned long ddr_rate;
-	unsigned long ahb_rate;
-	u32 pll;
-	u32 freq;
-	u32 div;
-
-	ref_rate = AR913X_BASE_FREQ;
-	pll = ath79_pll_rr(AR913X_PLL_REG_CPU_CONFIG);
-
-	div = ((pll >> AR913X_PLL_FB_SHIFT) & AR913X_PLL_FB_MASK);
-	freq = div * ref_rate;
-
-	cpu_rate = freq;
-
-	div = ((pll >> AR913X_DDR_DIV_SHIFT) & AR913X_DDR_DIV_MASK) + 1;
-	ddr_rate = freq / div;
-
-	div = (((pll >> AR913X_AHB_DIV_SHIFT) & AR913X_AHB_DIV_MASK) + 1) * 2;
-	ahb_rate = cpu_rate / div;
-
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ahb", NULL);
-}
-
 static void __init ar933x_clocks_init(void)
 {
 	unsigned long ref_rate;
@@ -443,10 +409,8 @@ void __init ath79_clocks_init(void)
 {
 	if (soc_is_ar71xx())
 		ar71xx_clocks_init();
-	else if (soc_is_ar724x())
+	else if (soc_is_ar724x() || soc_is_ar913x())
 		ar724x_clocks_init();
-	else if (soc_is_ar913x())
-		ar913x_clocks_init();
 	else if (soc_is_ar933x())
 		ar933x_clocks_init();
 	else if (soc_is_ar934x())
-- 
2.7.0
