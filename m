Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:11:09 +0200 (CEST)
Received: from exsmtp01.microchip.com ([198.175.253.37]:22451 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029432AbcEQFJUs4i16 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:09:20 +0200
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Mon, 16 May 2016
 22:09:13 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Tue, 17 May 2016
 10:37:25 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        <devicetree@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 10/11] dt/bindings: Correct clk binding example for PIC32 WDT.
Date:   Tue, 17 May 2016 10:35:59 +0530
Message-ID: <1463461560-9629-10-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53476
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

 Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt b/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
index d140103..f03a29a 100644
--- a/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
@@ -7,12 +7,12 @@ Required properties:
 - compatible: must be "microchip,pic32mzda-wdt".
 - reg: physical base address of the controller and length of memory mapped
   region.
-- clocks: phandle of source clk. should be <&LPRC> clk.
+- clocks: phandle of source clk. Should be <&rootclk LPRCCLK>.
 
 Example:
 
 	watchdog@1f800800 {
 		compatible = "microchip,pic32mzda-wdt";
 		reg = <0x1f800800 0x200>;
-		clocks = <&LPRC>;
+		clocks = <&rootclk LPRCCLK>;
 	};
-- 
1.8.3.1
