Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:22:31 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:40534 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990435AbeENGWXeD8IO (ORCPT
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
Subject: [PATCH v3 6/8] MIPS: jz4780: dts: Fix watchdog node
Date:   Thu, 10 May 2018 20:47:49 +0200
Message-Id: <20180510184751.13416-6-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1525978115; bh=cho6jdLmU1bygSxSTOFRHZE2MnT+tIBVQx8REcN8NuQ=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QQlqA2L1oVOBrQjgDFa7Xah1W1Ne4QuMy6fHbuUHyrNrZTpSSzvnomOmajRP9lcDVYDKBZ5rSIIs6qJ16rMGKJ3oJjVJ3TjUgF1ZVFMg7ngJK09PUXfwXHV26Ex7Acs7XUkp+wnWECCzEnrEC0vnzlEo8K36Xhl24u0kirXTBuw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63908
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

- The previous node requested a memory area of 0x100 bytes, while the
  driver only manipulates four registers present in the first 0x10 bytes.

- The driver requests for the "rtc" clock, but the previous node did not
  provide any.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Mathieu Malaterre <malat@debian.org>
Acked-by: James Hogan <jhogan@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt | 7 ++++++-
 arch/mips/boot/dts/ingenic/jz4780.dtsi                            | 5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

 v2: No change
 v3: Also fix documentation

diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
index cb44918f01a8..ce1cb72d5345 100644
--- a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
@@ -3,10 +3,15 @@ Ingenic Watchdog Timer (WDT) Controller for JZ4740 & JZ4780
 Required properties:
 compatible: "ingenic,jz4740-watchdog" or "ingenic,jz4780-watchdog"
 reg: Register address and length for watchdog registers
+clocks: phandle to the RTC clock
+clock-names: should be "rtc"
 
 Example:
 
 watchdog: jz4740-watchdog@10002000 {
 	compatible = "ingenic,jz4740-watchdog";
-	reg = <0x10002000 0x100>;
+	reg = <0x10002000 0x10>;
+
+	clocks = <&cgu JZ4740_CLK_RTC>;
+	clock-names = "rtc";
 };
diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9b5794667aee..a52f59bf58c7 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -221,7 +221,10 @@
 
 	watchdog: watchdog@10002000 {
 		compatible = "ingenic,jz4780-watchdog";
-		reg = <0x10002000 0x100>;
+		reg = <0x10002000 0x10>;
+
+		clocks = <&cgu JZ4780_CLK_RTCLK>;
+		clock-names = "rtc";
 	};
 
 	nemc: nemc@13410000 {
-- 
2.11.0
