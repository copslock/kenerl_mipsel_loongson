Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:10:43 +0200 (CEST)
Received: from smtpout.microchip.com ([198.175.253.82]:57268 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029465AbcEQFJIbHwd6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:09:08 +0200
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.181.6; Mon, 16 May 2016
 22:09:00 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Tue, 17 May 2016
 10:37:12 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        <devicetree@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 09/11] dt/bindings: Correct clk binding example for PIC32 DMT.
Date:   Tue, 17 May 2016 10:35:58 +0530
Message-ID: <1463461560-9629-9-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53475
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

 Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt b/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt
index 852f694..49485f8 100644
--- a/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt
+++ b/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt
@@ -8,12 +8,12 @@ Required properties:
 - compatible: must be "microchip,pic32mzda-dmt".
 - reg: physical base address of the controller and length of memory mapped
   region.
-- clocks: phandle of parent clock (should be &PBCLK7).
+- clocks: phandle of source clk. Should be <&rootclk PB7CLK>.
 
 Example:
 
 	watchdog@1f800a00 {
 		compatible = "microchip,pic32mzda-dmt";
 		reg = <0x1f800a00 0x80>;
-		clocks = <&PBCLK7>;
+		clocks = <&rootclk PB7CLK>;
 	};
-- 
1.8.3.1
