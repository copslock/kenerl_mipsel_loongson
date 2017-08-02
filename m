Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 11:36:57 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:38870
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993155AbdHBJfS1y3cy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 11:35:18 +0200
Received: by mail-wm0-x243.google.com with SMTP id y206so6408880wmd.5;
        Wed, 02 Aug 2017 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aRyFCoe117iGY9GNtxAzGRAcuRM5BCQSJyw4QdiD1ms=;
        b=jp+LcrgercB3195ZS9x6yb7nh426BHgbNyiI/uFVdmTaIoT/+d48UwS4c+vppmpaRc
         b1AOWTOOkEM1r6EaoVkysAHIeUZxstK/Y4fu44Gttu9lfbwBnBiaPQ1YA75wyw7VZnI1
         xjXpNQPSFxdw1VDkaNkZ8fvogfF6Fwykvx1nyKB89LAREtRQcblLoVYGhDKy9kRNlwhZ
         U8rnJq/zjAxt4ogc+4dCfOI0AsumZi1PGWM1ExJ6enqcgdYrKYRQaH3U7Hzd7BL+k0zn
         zsESnZ92X0G4Fd8kTAMEWVgQowN57uPJSlKhrMCP6JYB0qAoJmhk7VqOPCly71cORlOC
         r8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aRyFCoe117iGY9GNtxAzGRAcuRM5BCQSJyw4QdiD1ms=;
        b=esNNkET/+e8g0YUAAfs7m4gtF0Au46SW8S/tcBBIL+t+RToohG28CzI55qfmt1ORJy
         EXekhdeNtdcK2ltDquLZ01JRVwbdkuunYr/xW4wpC0XcYHS6vowaN30lOymSvNKDQCa0
         oxtz3wlxvffX/ZL+8GsA37H26xf6t/NY6FipqYIGC5SwaNZffbL07ZUJFe0UWC7f+XPc
         XBzcdAqp3qa5XtqD5Od28FazNR9gLjsh3jP3AydEvH8p23ipCVHY4ARValoeKAX3ODmh
         yRsT2hm4UOgIFMMZ9Z7LFQF4VqzjI7TTxfO45QigjFCUroz4Vlb8F+oYcckU/g2uMYRj
         Gk5w==
X-Gm-Message-State: AIVw110VQ7+mEr2DFAhy3xQwR9VaraRUOL5uhFReWjZ2PCEToV41RZxd
        LO+rZaz5xLT4nZy77Vc=
X-Received: by 10.28.105.210 with SMTP id z79mr3436259wmh.33.1501666512655;
        Wed, 02 Aug 2017 02:35:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 91sm32058876wrg.83.2017.08.02.02.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 02:35:12 -0700 (PDT)
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
Subject: [PATCH 4/8] tty/bcm63xx_uart: allow naming clock in device tree
Date:   Wed,  2 Aug 2017 11:34:25 +0200
Message-Id: <20170802093429.12572-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59320
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

Codify using a named clock for the refclk of the uart. This makes it
easier if we might need to add a gating clock (like present on the
BCM6345).

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt | 6 ++++++
 drivers/tty/serial/bcm63xx_uart.c                              | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
index 5c52e5eef16d..8b2b0460259a 100644
--- a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
@@ -11,6 +11,11 @@ Required properties:
 - clocks: Clock driving the hardware; used to figure out the baud rate
   divisor.
 
+
+Optional properties:
+
+- clock-names: Should be "refclk".
+
 Example:
 
 	uart0: serial@14e00520 {
@@ -19,6 +24,7 @@ Example:
 		interrupt-parent = <&periph_intc>;
 		interrupts = <2>;
 		clocks = <&periph_clk>;
+		clock-names = "refclk";
 	};
 
 	clocks {
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index a2b9376ec861..f227eff28d3a 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -841,8 +841,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (!res_irq)
 		return -ENODEV;
 
-	clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
-				  clk_get(&pdev->dev, "refclk");
+	clk = clk_get(&pdev->dev, "refclk");
+	if (IS_ERR(clk) && pdev->dev.of_node)
+		clk = of_clk_get(pdev->dev.of_node, 0);
+
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-- 
2.13.2
