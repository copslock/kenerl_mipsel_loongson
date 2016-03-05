Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2016 23:39:45 +0100 (CET)
Received: from rev33.vpn.fdn.fr ([80.67.179.33]:41007 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014915AbcCEWjbSfaDb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Mar 2016 23:39:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: [PATCH 2/5] Documentation: dt: Add binding info for jz4740-rtc driver
Date:   Sat,  5 Mar 2016 23:38:48 +0100
Message-Id: <1457217531-26064-2-git-send-email-paul@crapouillou.net>
In-Reply-To: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52466
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

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
new file mode 100644
index 0000000..71e4ad0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
@@ -0,0 +1,38 @@
+JZ4740 and similar SoCs real-time clock driver
+
+Required properties:
+
+- compatible: One of:
+  - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
+  - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
+- reg: Address range of rtc register set
+- interrupts: IRQ number for the alarm interrupt
+- interrupt-parent: phandle of the interrupt controller
+- clocks: phandle to the "rtc" clock
+- clock-names: must be "rtc"
+
+Optional properties:
+- system-power-controller: To use this component as the
+  system power controller
+- reset-pin-assert-time: Reset pin low-level assertion time
+  after wakeup (default 60ms; range 0-125ms if RTC clock at 
+  32 kHz)
+- min-wakeup-pin-assert-time: Minimum wakeup pin assertion time
+  (default 100ms; range 0-2s if RTC clock at 32 kHz)
+
+Example:
+
+rtc@10003000 {
+	compatible = "ingenic,jz4740-rtc";
+	reg = <0x10003000 0x3F>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <32>;
+
+	clocks = <&rtc_clock>;
+	clock-names = "rtc";
+
+	system-power-controller;
+	reset-pin-assert-time = <60>;
+	min-wakeup-pin-assert-time = <100>;
+};
-- 
2.7.0
