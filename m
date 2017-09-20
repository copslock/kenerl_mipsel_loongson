Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:17:30 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:36526
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993915AbdITLQSdZX-X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:16:18 +0200
Received: by mail-wm0-x243.google.com with SMTP id r136so2119410wmf.3;
        Wed, 20 Sep 2017 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aoZqJe/zJsKqD6CDebjOGOq+Cjc7ASV8t1qCFib6cac=;
        b=s3+KtIu2W/1tt8ZCY4noZpgLx7eLclxZrZwAJO9oVj/3qpxHnETqpbOqbGsYTrZiSk
         Iu0fazp9VCX5H/XmXAu8Gr+P3tMgi4bs3O5JYv/9hxf7lN6M9ujSdSUSOnCjgqg2fina
         QBRtoU75TBmUJRwohj5z6YKi4vRuiwxyO1CyyIIcAyxljhHJF2L8Umny3zKPqdTqOVK7
         R8j9ByT1FRxcSi/gzvPIS7uSk2N4so1hobPu+gojDBoXf2Qrmwi85nwDZymrKU+y1NAX
         Nmz7TRgDPtni0EK6uDl9u9614C5tjq/dmEbobveoe4E+KHr12a+4DViYwg5ydfsZsugw
         YOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aoZqJe/zJsKqD6CDebjOGOq+Cjc7ASV8t1qCFib6cac=;
        b=Fn6IMlvAVykC+R++XoV1iA34g/d1CWrOsD7bIk3mRfJqcGA41jHupwMEkYOmjX/Sb2
         FZ8Er9nCEnKH3RP9Qc9wMIHmVf8ypvZXafQXfXxf36OpS3mkjn9P58jqYtkyrcLh0GzF
         z4waPa09tDtdiDQ4m6IoYRlPWcVbpadTn94mMLs552wcZ9BQ0/gm+CFoLcLNQXXN8eyg
         lurW6E6gf6wqdHIX5zvM7JA93K1MeJAfAIszhLhQR8/UaVAgS1iMY2V/gR9etMLB0DbC
         qPyriCp5HsvA0xJ2L0ImGyvj4VXbL5sJ+6s62uHs92Op50a/0BVuspFT834MulLeDBdQ
         vCFg==
X-Gm-Message-State: AHPjjUjYDP5qkuby6lgQsrePXEB1NMOfsflgfES0dEiWgQcf7CZ3sH8q
        uxbXvkgSsZXskhhP5xKTgZrtMQ==
X-Google-Smtp-Source: AOwi7QAKV3xyf91HFB7r9ib7XtlLLbOzoLuVQYI0e3+jVyY44iSsWc4BZqjtfAzvrSZmzk8pMTMSnw==
X-Received: by 10.80.206.11 with SMTP id y11mr4398662edi.94.1505906172634;
        Wed, 20 Sep 2017 04:16:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:16:12 -0700 (PDT)
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
Subject: [PATCH V2 4/8] tty/bcm63xx_uart: allow naming clock in device tree
Date:   Wed, 20 Sep 2017 13:14:04 +0200
Message-Id: <20170920111408.29711-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60088
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

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
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
