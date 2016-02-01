Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 23:39:49 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:54196 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012030AbcBAWjs0504J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 23:39:48 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Mon, 1 Feb 2016
 15:39:40 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Mon, 01 Feb 2016
 15:43:30 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt/bindings: Add bindings for the PIC32 real time clock
Date:   Mon, 1 Feb 2016 15:43:21 -0700
Message-ID: <1454366606-10779-1-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

Document the devicetree bindings for the real time clock found
on Microchip PIC32 class devices.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 .../bindings/rtc/microchip,pic32-rtc.txt           |   21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt b/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
new file mode 100644
index 0000000..1ad3ae8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
@@ -0,0 +1,21 @@
+* Microchip PIC32 Real Time Clock and Calendar
+
+The RTCC keeps time in hours, minutes, and seconds, and one half second. It
+provides a calendar in weekday, date, month, and year. It also provides a
+configurable alarm.
+
+Required properties:
+- compatible: should be: "microchip,pic32mzda-rtc"
+- reg: physical base address of the controller and length of memory mapped
+    region.
+- interrupts: RTC alarm/event interrupt
+- clocks: clock phandle
+
+Example:
+
+	rtc0: rtc@1f8c0000 {
+		compatible = "microchip,pic32mzda-rtc";
+		reg = <0x1f8c0000 0x60>;
+		interrupts = <166 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&PBCLK6>;
+	};
-- 
1.7.9.5
