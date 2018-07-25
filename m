Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 14:27:10 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:41685 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993003AbeGYM1HxQzB8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 14:27:07 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D0940208FF; Wed, 25 Jul 2018 14:27:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4FFE8207AD;
        Wed, 25 Jul 2018 14:26:51 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linus.walleij@linaro.org
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 1/2] MIPS: mscc: ocelot: add interrupt controller properties to GPIO controller
Date:   Wed, 25 Jul 2018 14:26:20 +0200
Message-Id: <20180725122621.31713-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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

The GPIO controller also serves as an interrupt controller for events
on the GPIO it handles.

An interrupt occurs whenever a GPIO line has changed.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index d7f0e3551500..afe8fc9011ea 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -168,6 +168,9 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&gpio 0 0 22>;
+			interrupt-controller;
+			interrupts = <13>;
+			#interrupt-cells = <2>;
 
 			uart_pins: uart-pins {
 				pins = "GPIO_6", "GPIO_7";
-- 
2.14.1
