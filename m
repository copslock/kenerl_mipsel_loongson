Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:35:31 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35608 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006933AbcCQDemP3VFp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:42 +0100
Received: by mail-lf0-f68.google.com with SMTP id e138so2230900lfe.2;
        Wed, 16 Mar 2016 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0frF0qEC14VycxeRq1php3rMz7JF8qkgZFTfmw2ipr4=;
        b=J5AVQELPnU7O1QQfdZHwLER4j9y6bhu53SracjGwfV+NiPUQddgbzk/sLBOHGtksLL
         ROuJOd9zvYCdruHBmNLDCf45qsCLFuX3zIGg5DB8hcE/NYqwOZ+rWr0i7tmvakZgqYEq
         lvPNAI6oEfuOfvgHcjktnv2PTy29bbVv5wOSFWoFkxtn7+93HDAcHsPub3ncGiqX96ec
         K0uSKqYPcb0ofd2J4Z5Alc0gMoPTmv3FZpFT+acdhj+eKeO6dgUwaxou1VU+MMqXlkZ0
         pHHDXmIELjBIVdVhqPUcBcaZVCbSFKNiqJuZVnvKYhqQzj3J6btG+Yu4l4f+Bm2ru2oJ
         INPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0frF0qEC14VycxeRq1php3rMz7JF8qkgZFTfmw2ipr4=;
        b=TyX99p4hkNjBlp+xW/Ns3dtbZM3z6kPa9jHpfqqrOXIc3uPZrO7iW7d2tUbGt8kJXS
         MhZe3O8IjWQhV54fxPk500N8WjKMs3EZORhjSvaiJfjwwRcuT6QW7FkFRV36KpCXgLAO
         qYcopfHWYo8xBiPP/Czk2jICaWyYZS6EJN8CGHhIR+SUl/g1IvJKK4pYsUF+HWKP1ivM
         dBdJyWDS2AP/zVndI0ucAEgdUrfQaRX8rZ37DGwn+f0LcMMh8yfPk514n5uWHNMwlP+Z
         wvv6X26fFQGo+qhUeJ0xLKvIiizb9KKBzB7rdnR6P/9YSZXkYdwhc/Xk0BbzW20riC5o
         bh2w==
X-Gm-Message-State: AD7BkJJ6sPBCi8a2cK3prb/T6V68y8I0L1EO5GsqREQf0MoUcfCvsWrISBLhBzgpuTzRiA==
X-Received: by 10.25.5.10 with SMTP id 10mr2233558lff.123.1458185677023;
        Wed, 16 Mar 2016 20:34:37 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:36 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 03/18] MIPS: ath79: Fix the ar913x reference clock rate
Date:   Thu, 17 Mar 2016 06:34:10 +0300
Message-Id: <1458185665-4521-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52617
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
