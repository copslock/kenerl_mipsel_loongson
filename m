Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:16:43 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:38679
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992974AbdITLQOiOXYX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:16:14 +0200
Received: by mail-wm0-x242.google.com with SMTP id x17so2101022wmd.5;
        Wed, 20 Sep 2017 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=97qXopsV2c2bIYyxmr9tSWtniKuQa146sh18jcakX+4=;
        b=mdFenZyNhLWyZLx3yYrCZAbvosJ55/3qNWJyHa9ETuyKnY3exyXdLFfwra+r2bUYNr
         hs+QPlJVfbL29+OHwBmdQJ5n5hH4WOBm+PrChHIJpa5X/3oMbcKNAGi9NPJ93VzYjC29
         oO5KQBeU8KoIdtxXO2kJOsDdvUadcQrM5rFX5r/7H01KYY3/ceWIhdxoGPtn5tFku8ir
         GY6mC4RBaMaRk31630OIV3rnMD2bFrCWd0zA8TIDq38ZYBxRXsthTv5Z9kutl4b1FXHI
         mxqX0wO/VKtVuWzE4SPjjn9zCejzHcolUgK4QzmEIobsdC0AvpIpewLpTedz+ySogdjN
         5cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=97qXopsV2c2bIYyxmr9tSWtniKuQa146sh18jcakX+4=;
        b=G7BvPCbteTVITdkoQa36LBotGSAz1mB0o6oxAf77RG3tZYvnWElpMbRkWdB1U66TQT
         h6PzSoEmPN8X+Lh0Fhs7K+JG/K0/IhJ+C3IjzCzWXP70HJtHujjiLzwnpOoD0jdHKq0j
         u7HCNWhB0omnmIhW0gjOXn6fizXsnUz3QYCgvyUFULm0th8uhcsF1jXFmRk51y1yI09m
         LibApVwjdEi1SHwa4PG6boIMeGwGqTAxiJwQvuQt61RMs9j/LE+o/DoNBnY5CZNyzsN1
         cSLPBIaulbuxxWmPU5AT1VoLqjql8/Zagqrou9nbvqRqON6qHLD+jIW6RX2mx6TC+U2i
         6n7w==
X-Gm-Message-State: AHPjjUj6T4bGw4y+a/S1vKPDqIXwdszWBT//XxZyZ1EQSMqa9UgRPUiA
        oezemuVCchxkJpcKlAsWKjiFZA==
X-Google-Smtp-Source: AOwi7QD3W+NuQP87cTcaP/pKppk87aTi95VufwXBAyAa5dlxqD0CWZofZ0ZjzwN97HDqhgdGx/v8FQ==
X-Received: by 10.80.140.251 with SMTP id r56mr4156511edr.299.1505906169108;
        Wed, 20 Sep 2017 04:16:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:16:08 -0700 (PDT)
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
Subject: [PATCH V2 2/8] MIPS: BCM63XX: provide periph clock as refclk for uart
Date:   Wed, 20 Sep 2017 13:14:02 +0200
Message-Id: <20170920111408.29711-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60086
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

Add a lookup as "refclk" to describe its function for the uarts.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index f712c9558d57..d8dac1f9a65a 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -363,6 +363,8 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
 static struct clk_lookup bcm3368_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -376,6 +378,8 @@ static struct clk_lookup bcm3368_clks[] = {
 static struct clk_lookup bcm6328_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -387,6 +391,7 @@ static struct clk_lookup bcm6328_clks[] = {
 static struct clk_lookup bcm6338_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -399,6 +404,7 @@ static struct clk_lookup bcm6338_clks[] = {
 static struct clk_lookup bcm6345_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -411,6 +417,7 @@ static struct clk_lookup bcm6345_clks[] = {
 static struct clk_lookup bcm6348_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -423,6 +430,8 @@ static struct clk_lookup bcm6348_clks[] = {
 static struct clk_lookup bcm6358_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -436,6 +445,8 @@ static struct clk_lookup bcm6358_clks[] = {
 static struct clk_lookup bcm6362_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -449,6 +460,8 @@ static struct clk_lookup bcm6362_clks[] = {
 static struct clk_lookup bcm6368_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
-- 
2.13.2
