Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:23:10 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:40530 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990431AbeENGWXsuKzO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 08:22:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 5/8] MIPS: jz4740: dts: Add bindings for the jz4740-wdt driver
Date:   Thu, 10 May 2018 20:47:48 +0200
Message-Id: <20180510184751.13416-5-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1525978110; bh=4nus55XOsnPN2DkJJ5PA0tiM2FydUqp4+ratN6Y+oxY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vz+fqviswLzgdWymPCkoYp3OFrmy+7XUtprDef2I98WRdv6iATHUJTCIuLfs1r1TsgJLDI1f6f1rF/XXmUDaTGwCNU2GFEevb8IiVrQxzTX1AjUHbgvd0xwUVU66ebKQ7/d7RqQMwWUFS3h9n5EO2kWkugp4DSRJ2ZEuehWHP5k=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Also remove the watchdog platform_device from platform.c, since it
wasn't used anywhere anyway.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi |  8 ++++++++
 arch/mips/jz4740/platform.c            | 16 ----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

 v2: No change
 v3: No change

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index cd5185bb90ae..26c6b561d6f7 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -45,6 +45,14 @@
 		#clock-cells = <1>;
 	};
 
+	watchdog: watchdog@10002000 {
+		compatible = "ingenic,jz4740-watchdog";
+		reg = <0x10002000 0x10>;
+
+		clocks = <&cgu JZ4740_CLK_RTC>;
+		clock-names = "rtc";
+	};
+
 	rtc_dev: rtc@10003000 {
 		compatible = "ingenic,jz4740-rtc";
 		reg = <0x10003000 0x40>;
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index 5b7cdd67a9d9..cbc5f8e87230 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -233,22 +233,6 @@ struct platform_device jz4740_adc_device = {
 	.resource	= jz4740_adc_resources,
 };
 
-/* Watchdog */
-static struct resource jz4740_wdt_resources[] = {
-	{
-		.start = JZ4740_WDT_BASE_ADDR,
-		.end   = JZ4740_WDT_BASE_ADDR + 0x10 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device jz4740_wdt_device = {
-	.name	       = "jz4740-wdt",
-	.id	       = -1,
-	.num_resources = ARRAY_SIZE(jz4740_wdt_resources),
-	.resource      = jz4740_wdt_resources,
-};
-
 /* PWM */
 struct platform_device jz4740_pwm_device = {
 	.name = "jz4740-pwm",
-- 
2.11.0
