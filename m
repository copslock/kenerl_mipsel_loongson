Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 11:36:07 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:33344
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbdHBJfPH4eZy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 11:35:15 +0200
Received: by mail-wm0-x242.google.com with SMTP id q189so6457097wmd.0;
        Wed, 02 Aug 2017 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z3bSc4kGKLeaSmAxUwASxcQq0RmD0aoerhdUQfCHq28=;
        b=FXHe15gt3hde/iBUkjdYwEzGu2hCQ5uc9G2h4hPOSvM2igA0VqOD+Hb8HLYBmQDVNH
         wF+DVOoi2JJ6lG7tgYBKu6V0YEc8pDO3a1vwcYaLOlnEcQB5C65GOrUzE5t6Ynm7EbZZ
         oGxKdsEsSzaEBlN3r2CqcxUh78kg2aemheHGQ3eOAgZfk1ZvozL9a3est12KBrrUq0Ac
         ZKHlPBPLC83TWyZFdpEUVVKnE3QX6ac4QRXlEewkPKNycL2ixprU44sQrovmS7oXYX4u
         Kh6QPf7g3YkPmcr6UbxbZJtb8Vkj1Pjv3p6gjrGyyvF2l2BAQHerzkBEiZ1EmoceZpyl
         dKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z3bSc4kGKLeaSmAxUwASxcQq0RmD0aoerhdUQfCHq28=;
        b=CWWlpm9HgtxqoGOQskutiXXsaUpTf1XrjKk91rGfKFcCYoE8L64ETWBFw/bb+Y2pdS
         PZda/Bb28qR4DM4OZfWF6vGMi2rsYaRPA+GFSsQBEWfJEsiSG+NJM5ZV3nt2oTK/EtdW
         DAVEGN8jmXL344+o/EEof4ECEzxkxNx8bfe1RtdAi0a41yaY0yIDxkcXRVNz15j+lAUU
         4BQL4wNRwRUQ2dOOLTof8CJXQcUFES9viSUkv/oeN85Jjg8jZvj65+b7ynZLV/ovwbZQ
         zeb8g+mZZRkICx/mpiVktqkj4IpESpB9sQTiLxY7l8R9SbN8CeBDdEo5FDNfe3XhD45v
         UHBQ==
X-Gm-Message-State: AIVw111uoVc0VBSrPmcCb134r/a4enODawArPkJsvtKBQiejqHBOH2p5
        pHK+rvOXU12vhAUEZmc=
X-Received: by 10.28.5.19 with SMTP id 19mr3317087wmf.20.1501666509616;
        Wed, 02 Aug 2017 02:35:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 91sm32058876wrg.83.2017.08.02.02.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 02:35:09 -0700 (PDT)
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
Subject: [PATCH 2/8] MIPS: BCM63XX: provide periph clock as refclk for uart
Date:   Wed,  2 Aug 2017 11:34:23 +0200
Message-Id: <20170802093429.12572-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59318
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

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index eb1cb0bf930b..0b898e5e4c5b 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -360,6 +360,8 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
 static struct clk_lookup bcm3368_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -373,6 +375,8 @@ static struct clk_lookup bcm3368_clks[] = {
 static struct clk_lookup bcm6328_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -384,6 +388,7 @@ static struct clk_lookup bcm6328_clks[] = {
 static struct clk_lookup bcm6338_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -396,6 +401,7 @@ static struct clk_lookup bcm6338_clks[] = {
 static struct clk_lookup bcm6345_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -408,6 +414,7 @@ static struct clk_lookup bcm6345_clks[] = {
 static struct clk_lookup bcm6348_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -420,6 +427,8 @@ static struct clk_lookup bcm6348_clks[] = {
 static struct clk_lookup bcm6358_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enet0", &clk_enet0),
 	CLKDEV_INIT(NULL, "enet1", &clk_enet1),
@@ -433,6 +442,8 @@ static struct clk_lookup bcm6358_clks[] = {
 static struct clk_lookup bcm6362_clks[] = {
 	/* fixed rate clocks */
 	CLKDEV_INIT(NULL, "periph", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.0", "refclk", &clk_periph),
+	CLKDEV_INIT("bcm63xx_uart.1", "refclk", &clk_periph),
 	/* gated clocks */
 	CLKDEV_INIT(NULL, "enetsw", &clk_enetsw),
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
@@ -446,6 +457,8 @@ static struct clk_lookup bcm6362_clks[] = {
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
