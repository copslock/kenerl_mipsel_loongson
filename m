Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:11:29 +0200 (CEST)
Received: from smtpout.microchip.com ([198.175.253.82]:11296 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029438AbcEQFJ1IxH76 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:09:27 +0200
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.181.6; Mon, 16 May 2016
 22:09:19 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Tue, 17 May 2016
 10:37:31 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH 11/11] dt/bindings: Correct clk binding example for PIC32 gpio.
Date:   Tue, 17 May 2016 10:36:00 +0530
Message-ID: <1463461560-9629-11-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

Update binding example based on new clock binding scheme.
[1] Documentation/devicetree/bindings/clock/microchip,pic32.txt

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
---

 Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt b/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
index ef37528..dd031fc 100644
--- a/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
@@ -33,7 +33,7 @@ gpio0: gpio0@1f860000 {
 	gpio-controller;
 	interrupt-controller;
 	#interrupt-cells = <2>;
-	clocks = <&PBCLK4>;
+	clocks = <&rootclk PB4CLK>;
 	microchip,gpio-bank = <0>;
 	gpio-ranges = <&pic32_pinctrl 0 0 16>;
 };
-- 
1.8.3.1
