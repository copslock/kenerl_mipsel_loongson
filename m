Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:16:22 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:32915
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992297AbdITLQOdZX-X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:16:14 +0200
Received: by mail-wm0-x243.google.com with SMTP id m127so2131872wmm.0;
        Wed, 20 Sep 2017 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UFzp1BLrD6XtwIMZb639qISuYhjHm3aCUJczld0csbs=;
        b=ZhE1HrgVS5LrHNhui3UOmlQRj4TXAaGoxDBLXSYLPUTz97OnwXCQ1hxwNLpxhFh7Dx
         OrW7gH2cTcOmsLE3URCrQ8l/JUv8+xpUw7th2lVKibtFfIT9wvCJOgYbdA+Z8nl/SLBu
         cb91aiSicd2EUltlZOF6Xtn8ITzHiBr8GtcwfNKUyhlaH5WZE6iGLndB0le75U0EdWAT
         L1fv5w4msxqoZuOhzOmdPaFhL9p3YD2NAGPgdXGutp8gKxSDK10kM0p0Cyp4V7lwrSD/
         JvxjVEgw7nDKjCWIeJYBygyvhf5H0seKiTCxPGlVCriPgJP0jlDfLSJMNxM6b9nolwqc
         7yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UFzp1BLrD6XtwIMZb639qISuYhjHm3aCUJczld0csbs=;
        b=EVO1P9+cK7bGkM3zOTB6QfwcrX2334TiI9vt60CjtUwdddEQh5xrd01Fb34l6N3GY9
         ParJtk70jvNVuu6rWbX3hhnZixllxy7vI6IbbK0zhndIa1jP01oyzSiwLZwizkNaKeBa
         FXhPnZ+dALlxU+umq4vetjWAhfwUTKytFB+v1Bf80K7dC2vfvpdSx2gjnRfTJjNH620/
         rbmcUKtcZ7rnM45d7NCmXkV5meve0raluOOJwFChjT9Puk0UvKAr85UCVXwKmZJlFCuE
         iSJaKIpgemRYOx3My7L/NGYz0mVYs9RwovWA39aq3nnglhlGWMhrCCshcc+vQ2LECyU/
         yR0A==
X-Gm-Message-State: AHPjjUjUQ4Dk/1TAB3gk/BrWsMCHOEihyZ+S08AIIwXxvACPwgCUfnwG
        G2h8Xu50QdItltBnIP1Z3SgvsA==
X-Google-Smtp-Source: AOwi7QARqHNyim7ZApDMODx/Grj5YiIGeDnFNLp77B4hputK38bUyP2TuCs0xRWPJbzf3/pvlbm5Dg==
X-Received: by 10.80.173.37 with SMTP id y34mr4198511edc.295.1505906166828;
        Wed, 20 Sep 2017 04:16:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:16:06 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH V2 1/8] MIPS: BCM63XX: add clkdev lookup support
Date:   Wed, 20 Sep 2017 13:14:01 +0200
Message-Id: <20170920111408.29711-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Enable clkdev lookup support to allow us providing clocks under
different names to devices more easily, so we don't need to care
about clock name clashes anymore.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/Kconfig       |   1 +
 arch/mips/bcm63xx/clk.c | 150 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 116 insertions(+), 35 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cb7fcc4216fd..8e3f642fb9f9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -275,6 +275,7 @@ config BCM63XX
 	select GPIOLIB
 	select HAVE_CLK
 	select MIPS_L1_CACHE_SHIFT_4
+	select CLKDEV_LOOKUP
 	help
 	 Support for BCM63XX based boards
 
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 19577f771c1f..f712c9558d57 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
@@ -359,44 +360,103 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "enet0"))
-		return &clk_enet0;
-	if (!strcmp(id, "enet1"))
-		return &clk_enet1;
-	if (!strcmp(id, "enetsw"))
-		return &clk_enetsw;
-	if (!strcmp(id, "ephy"))
-		return &clk_ephy;
-	if (!strcmp(id, "usbh"))
-		return &clk_usbh;
-	if (!strcmp(id, "usbd"))
-		return &clk_usbd;
-	if (!strcmp(id, "spi"))
-		return &clk_spi;
-	if (!strcmp(id, "hsspi"))
-		return &clk_hsspi;
-	if (!strcmp(id, "xtm"))
-		return &clk_xtm;
-	if (!strcmp(id, "periph"))
-		return &clk_periph;
-	if ((BCMCPU_IS_3368() || BCMCPU_IS_6358()) && !strcmp(id, "pcm"))
-		return &clk_pcm;
-	if ((BCMCPU_IS_6362() || BCMCPU_IS_6368()) && !strcmp(id, "ipsec"))
-		return &clk_ipsec;
-	if ((BCMCPU_IS_6328() || BCMCPU_IS_6362()) && !strcmp(id, "pcie"))
-		return &clk_pcie;
-	return ERR_PTR(-ENOENT);
-}
+static struct clk_lookup bcm3368_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+};
 
-EXPORT_SYMBOL(clk_get);
+static struct clk_lookup bcm6328_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "hsspi", &clk_hsspi),
+	CLKDEV_INIT(NULL, "pcie", &clk_pcie),
+};
 
-void clk_put(struct clk *clk)
-{
-}
+static struct clk_lookup bcm6338_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+};
+
+static struct clk_lookup bcm6345_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+};
+
+static struct clk_lookup bcm6348_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+};
 
-EXPORT_SYMBOL(clk_put);
+static struct clk_lookup bcm6358_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
+	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
+	CLKDEV_INIT(NULL, "ephy", &clk_ephy),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+};
+
+static struct clk_lookup bcm6362_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT(NULL, "hsspi", &clk_hsspi),
+	CLKDEV_INIT(NULL, "pcie", &clk_pcie),
+	CLKDEV_INIT(NULL, "ipsec", &clk_ipsec),
+};
+
+static struct clk_lookup bcm6368_clks[] = {
+	/* fixed rate clocks */
+	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	/* gated clocks */
+	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
+	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
+	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
+	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT(NULL, "xtm", &clk_xtm),
+	CLKDEV_INIT(NULL, "ipsec", &clk_ipsec),
+};
 
 #define HSSPI_PLL_HZ_6328	133333333
 #define HSSPI_PLL_HZ_6362	400000000
@@ -404,11 +464,31 @@ EXPORT_SYMBOL(clk_put);
 static int __init bcm63xx_clk_init(void)
 {
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM3368_CPU_ID:
+		clkdev_add_table(bcm3368_clks, ARRAY_SIZE(bcm3368_clks));
+		break;
 	case BCM6328_CPU_ID:
 		clk_hsspi.rate = HSSPI_PLL_HZ_6328;
+		clkdev_add_table(bcm6328_clks, ARRAY_SIZE(bcm6328_clks));
+		break;
+	case BCM6338_CPU_ID:
+		clkdev_add_table(bcm6338_clks, ARRAY_SIZE(bcm6338_clks));
+		break;
+	case BCM6345_CPU_ID:
+		clkdev_add_table(bcm6345_clks, ARRAY_SIZE(bcm6345_clks));
+		break;
+	case BCM6348_CPU_ID:
+		clkdev_add_table(bcm6348_clks, ARRAY_SIZE(bcm6348_clks));
+		break;
+	case BCM6358_CPU_ID:
+		clkdev_add_table(bcm6358_clks, ARRAY_SIZE(bcm6358_clks));
 		break;
 	case BCM6362_CPU_ID:
 		clk_hsspi.rate = HSSPI_PLL_HZ_6362;
+		clkdev_add_table(bcm6362_clks, ARRAY_SIZE(bcm6362_clks));
+		break;
+	case BCM6368_CPU_ID:
+		clkdev_add_table(bcm6368_clks, ARRAY_SIZE(bcm6368_clks));
 		break;
 	}
 
-- 
2.13.2
