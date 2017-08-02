Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 11:38:11 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:33989
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994831AbdHBJfWr8A5y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 11:35:22 +0200
Received: by mail-wr0-x241.google.com with SMTP id o33so3226470wrb.1;
        Wed, 02 Aug 2017 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBXoWTg5O080xd1FmyDUNsYoOeiodf0YZmKv1VSIRmQ=;
        b=Sw/jmBnv+3d9DSdkL1NwrY2K+iDrNXTag4eo/gnyck+zVR0qZGIssfHxdBJBF76d7J
         LVdbX4DptvmCpu0nmDOqWfTgZp1RS2AcwI2B7VUgIRYnbHQt0hFG4ufeDsnknsaXEUHC
         Nw8k2bxDf7U0wR9nlPAcEWprxyIIZM0viC1HCs7hxVBflu/Srn8u/WWcqllhCUmDj+1E
         C0snG7JuPGKl4dckM9I5C5X66lkhyIjjJA4BsQMgZIJ9Rsm0S7ATc2rSvVN9fbkK4LrR
         roLVqQKknqY+mE6pvBEq1AoRGo3giQAHhwCyTXaC6WjR+VnD42sqJxySHv6m2Nj+LtNg
         igVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBXoWTg5O080xd1FmyDUNsYoOeiodf0YZmKv1VSIRmQ=;
        b=I6yekiUtlVZmYVjIl1OMunmqb1fXHt2WZJRk9iNZVLXB99WA12Vre2yJm75KtF2f27
         y7x9hnUgggL1b+2hlcTGqp60lIVc2EyQK8DdaVwLKXYr3CcPIIOHxuQUlQ3sYJx/GIeX
         ElYAEC6YCsYN4xw6OZ9KmkY63hV/NLF1ZSxnIImbCj10co/QJltLY2lII2AntgmYj712
         oY/cDE32NMf84QkoLTuYVo1QmFycS6TlqXohYmzHbpnbsaMxNaFOteoB8CJfCY/3/LWH
         vtTny7rmbA92UeYiRgg/UZpi8C5R8Mv0+BnZsYQ6NHdyx1QGRvSqqf4TvwS2WKmXr+MB
         Ab4w==
X-Gm-Message-State: AIVw112zCizyls0ky7tTpjzfbM5B7ZHbSX8Jd9I9jNkr/JtdFrRC3wSc
        LCg93AFEvb1LWRY9IW8=
X-Received: by 10.223.172.230 with SMTP id o93mr18959092wrc.273.1501666517281;
        Wed, 02 Aug 2017 02:35:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 91sm32058876wrg.83.2017.08.02.02.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 02:35:16 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 7/8] MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
Date:   Wed,  2 Aug 2017 11:34:28 +0200
Message-Id: <20170802093429.12572-8-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59323
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

Split up the HSSPL clock into rate and a gate clock, to more closely
match the actual hardware.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 8a089a92e029..884099de097f 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -248,6 +248,10 @@ static struct clk clk_hsspi = {
 	.set	= hsspi_set,
 };
 
+/*
+ * HSSPI PLL
+ */
+static struct clk clk_hsspi_pll;
 
 /*
  * XTM clock
@@ -379,6 +383,7 @@ static struct clk_lookup bcm6328_clks[] = {
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx-hsspi.0", "pll", &clk_hsspi_pll),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -452,6 +457,7 @@ static struct clk_lookup bcm6362_clks[] = {
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx-hsspi.0", "pll", &clk_hsspi_pll),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -486,7 +492,7 @@ static int __init bcm63xx_clk_init(void)
 		clkdev_add_table(bcm3368_clks, ARRAY_SIZE(bcm3368_clks));
 		break;
 	case BCM6328_CPU_ID:
-		clk_hsspi.rate = HSSPI_PLL_HZ_6328;
+		clk_hsspi_pll.rate = HSSPI_PLL_HZ_6328;
 		clkdev_add_table(bcm6328_clks, ARRAY_SIZE(bcm6328_clks));
 		break;
 	case BCM6338_CPU_ID:
@@ -502,7 +508,7 @@ static int __init bcm63xx_clk_init(void)
 		clkdev_add_table(bcm6358_clks, ARRAY_SIZE(bcm6358_clks));
 		break;
 	case BCM6362_CPU_ID:
-		clk_hsspi.rate = HSSPI_PLL_HZ_6362;
+		clk_hsspi_pll.rate = HSSPI_PLL_HZ_6362;
 		clkdev_add_table(bcm6362_clks, ARRAY_SIZE(bcm6362_clks));
 		break;
 	case BCM6368_CPU_ID:
-- 
2.13.2
