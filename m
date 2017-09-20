Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:18:15 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:35290
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdITLQVUZtVX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:16:21 +0200
Received: by mail-wm0-x241.google.com with SMTP id e64so2126166wmi.2;
        Wed, 20 Sep 2017 04:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPUolmFy9iORxNngwhGLWGNonJwJajffSM+pA1k3g2M=;
        b=qsLPR6EQZGW1Jv2IBl1ufm6ly2lg+BzmgAvSqFB6mbP1hMPYyf4Wk61S8nVrZR8aS1
         rmAuD0cQ5v32OMAquR9jfNdk3ASl/Yu/hIIQQbOxrwOZmoPrzPEt4AbtW0plmmDrezjG
         6+Tu+2JXmoBjeShBf1a68UZxgSVy5M6YXBD+j3c3idcLOI/ifD2somp/stJS9o7KZ03F
         /wIR57vwEMsbfofULvTZUgUv7AFYiaA6LSSY9lmKmxAvzVNb036eSarfTXFxeL7nrhk5
         3sM5PiJFbWMrysnto9FB/l10PBsXkNZQn3JKxaoRuWVEp1J9DqK2itS/+RtgcjAvy9q/
         kRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPUolmFy9iORxNngwhGLWGNonJwJajffSM+pA1k3g2M=;
        b=APFPQur8PmxwTwnsqalQG2AL5vhae/k6HpzpNHvwk90jT0p7DXoEk7FzygJYVCC/3Y
         jvhTHZu//tJkctiebOhvKeuxGkAX5/vXZC2jAfJMdBy3qZk7PEtxcVqCUby6aBWXdiQL
         zUr1cf/PveQRZZQYLyERAUNzcf5Q0NEv00NV/6aUu+15nvvCOVd5R6EcntMWYZ8cGPm/
         L1poGj6IYUcYL3h62jRSkp9ysHVvxc9hGkcb17I/OlMSZe1PENnAoI/vuN+OXq6xCk+w
         j8In/+OhT4K4W5tHH9DliaUIoli1TYH2Jea48vtc9oEyiJyUsl9qTuAl12Md6FfF1G7F
         Vffg==
X-Gm-Message-State: AHPjjUhivT7MTExs7PaP7ujKEK1fxk4501xz1vDuotABEoiHHO2UtApJ
        a8HOaYQwizhVcayNnjdvg8qm+w==
X-Google-Smtp-Source: AOwi7QA0yDkHI+uVe82yMwGRacA5K/Brjkxyb7R3TCG48XrVedQJ2pv/ljJUXJGIuARpTDOA3HmDIw==
X-Received: by 10.80.192.20 with SMTP id r20mr4288837edb.37.1505906175830;
        Wed, 20 Sep 2017 04:16:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:16:15 -0700 (PDT)
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
Subject: [PATCH V2 6/8] MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
Date:   Wed, 20 Sep 2017 13:14:06 +0200
Message-Id: <20170920111408.29711-7-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60090
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

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index d8dac1f9a65a..ba5758551c94 100644
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
@@ -380,6 +384,7 @@ static struct clk_lookup bcm6328_clks[] = {
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx-hsspi.0", "pll", &clk_hsspi_pll),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -447,6 +452,7 @@ static struct clk_lookup bcm6362_clks[] = {
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx-hsspi.0", "pll", &clk_hsspi_pll),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -481,7 +487,7 @@ static int __init bcm63xx_clk_init(void)
 		clkdev_add_table(bcm3368_clks, ARRAY_SIZE(bcm3368_clks));
 		break;
 	case BCM6328_CPU_ID:
-		clk_hsspi.rate = HSSPI_PLL_HZ_6328;
+		clk_hsspi_pll.rate = HSSPI_PLL_HZ_6328;
 		clkdev_add_table(bcm6328_clks, ARRAY_SIZE(bcm6328_clks));
 		break;
 	case BCM6338_CPU_ID:
@@ -497,7 +503,7 @@ static int __init bcm63xx_clk_init(void)
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
