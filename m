Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:09:45 +0200 (CEST)
Received: from exsmtp03.microchip.com ([198.175.253.49]:39349 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029448AbcEQFInT2I96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:08:43 +0200
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Mon, 16 May 2016
 22:08:34 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Tue, 17 May 2016
 10:36:45 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/11] dt/bindings: Correct clk binding example for PIC32 SDHCI
Date:   Tue, 17 May 2016 10:35:55 +0530
Message-ID: <1463461560-9629-6-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53472
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

Update binding example based on new clock binding documentation.
[1] Documentation/devicetree/bindings/clock/microchip,pic32.txt

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
---

 Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
index 71ad57e..3149297 100644
--- a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
+++ b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
@@ -20,7 +20,7 @@ Example:
 		compatible = "microchip,pic32mzda-sdhci";
 		reg = <0x1f8ec000 0x100>;
 		interrupts = <191 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&REFCLKO4>, <&PBCLK5>;
+		clocks = <&rootclk REF4CLK>, <&rootclk PB5CLK>;
 		clock-names = "base_clk", "sys_clk";
 		bus-width = <4>;
 		cap-sd-highspeed;
-- 
1.8.3.1
