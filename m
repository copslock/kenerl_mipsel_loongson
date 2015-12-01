Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 14:02:18 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:53766 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006924AbbLANCPbOt8d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2015 14:02:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To; bh=OyoUBdPoKuKGN63tUfMth8M2Tm8d5ZelvaFX3JOeAnk=;
        b=bxQJS9J3aBgdDoZ9HS4jmRBpluOC0U8Lu0hmtCCIrUr4G+vwqL1gkmQ1qXqkWhMZJ1XTMu62TiV49neM4QPUsv2xBHQHzDrJrqfDFiGp2TQUjzvfOrniBBK4KoR8Svb5CY6+iUoo1BaXVAe+641QeJXqQ4FJsvLIApF+zhcIfn5vN/J3pUMthFUFeyHf1TW1DLZvjiNHHPr7xPxBdyfTyc7dpzIFIWd2zUshc8ZgZSE/caJMANZ1+EiokmnyEcztboVZ38pZDfqH7vzYJFVwRcA8LbUG3Rumw5gDRHi1qfeS+AtF9trz//7ht5WA70OOT26aaGTLwQhXO3LkROT13Q==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45576 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3kZ8-0007ZC-7l (Exim); Tue, 01 Dec 2015 13:01:55 +0000
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Simon Arlott <simon@fire.lp0.eu>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH 01/11] clocksource: Add brcm,bcm6345-timer/brcm,bcm6318-timer
 device tree binding
Message-ID: <565D9A40.60409@simon.arlott.org.uk>
Date:   Tue, 1 Dec 2015 13:01:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Add device tree bindings for the BCM6345/BCM6318 timers. This is required
for the BCM6345 watchdog which needs to respond to one of the timer
interrupts.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timer/brcm,bcm6318-timer.txt          | 44 ++++++++++++++++++++
 .../bindings/timer/brcm,bcm6345-timer.txt          | 47 ++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
new file mode 100644
index 0000000..cf4be7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
@@ -0,0 +1,44 @@
+Broadcom BCM6318 Timer
+
+This block is a timer that is connected to multiple interrupts on the main
+interrupt controller and functions as a programmable interrupt controller for
+timer events. There is a main timer interrupt for all timers.
+
+- 4 independent timers with their own interrupt, and own maskable level
+  interrupt bit in the main timer interrupt
+
+- 1 watchdog timer with an unmaskable level interrupt bit in the main timer
+  interrupt
+
+- Contains one enable/status word pair
+
+- No atomic set/clear operations
+
+Required properties:
+
+- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6318-timer"
+- reg: specifies the base physical address and size of the registers, excluding
+  the watchdog registers
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 1.
+- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
+  this one is cascaded from
+- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
+  node for the main timer interrupt, followed by the individual timer
+  interrupts; valid values depend on the type of parent interrupt controller
+- clocks: phandle of timer reference clock (periph)
+
+Example:
+
+timer: timer@10000040 {
+	compatible = "brcm,bcm63148-timer", "brcm,bcm6318-timer";
+	reg = <0x10000040 0x28>;
+
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	interrupt-parent = <&periph_intc>;
+	interrupts = <31>, <0>, <1>, <2>, <3>;
+	clock = <&periph_osc>;
+};
diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
new file mode 100644
index 0000000..03250dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
@@ -0,0 +1,47 @@
+Broadcom BCM6345 Timer
+
+This block is a timer that is connected to one interrupt on the main interrupt
+controller and functions as a programmable interrupt controller for timer
+events.
+
+- 3 independent timers with their own maskable level interrupt bit (but not
+  per CPU because there is only one parent interrupt and the timers share it)
+
+- 1 watchdog timer with an unmaskable level interrupt
+
+- Contains one enable/status word pair
+
+- No atomic set/clear operations
+
+The lack of per CPU ability of timers makes them unusable as a set of
+clockevent devices, otherwise they could be attached to the remaining
+interrupts.
+
+Required properties:
+
+- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6345-timer"
+- reg: specifies the base physical address and size of the registers, excluding
+  the watchdog registers
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 1.
+- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
+  this one is cascaded from
+- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
+  node for the timer interrupt; valid values depend on the type of parent
+  interrupt controller
+- clocks: phandle of timer reference clock (periph)
+
+Example:
+
+timer: timer@10000080 {
+	compatible = "brcm,bcm63168-timer", "brcm,bcm6345-timer";
+	reg = <0x10000080 0x1c>;
+
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	interrupt-parent = <&periph_intc>;
+	interrupts = <0>;
+	clock·=·<&periph_osc>;
+};
-- 
2.1.4

-- 
Simon Arlott
