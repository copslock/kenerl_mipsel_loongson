Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 20:03:05 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:57070 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012171AbbKUTDDDrNcI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Nov 2015 20:03:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To; bh=90GbdCqa9mjJeGRJamV5S8pkghip46MNdovc0PfMsOg=;
        b=kL7oiGa31IAy2dD9nHN4V4qaChN39cLEvJ7i/xtbkS2fuTNRrnH82DXGK6OxpSht1ZLRIzlro85d07IvSuW7dXfzG6XJKgaj/nTWSP611tFxPgUv57PqcTUFsdHHC+oYjDZf10FQQueEq7PSR7m9SI8JLscy6HXaLmptmQCwe0/bCOBDdiu17yCfiGaGYsj7GeJnoy93myOuX6wrUCXVXuxOJIWsmH3lNvuzzUxOXn9OxRbbOq7slOroacxIveWI792/3KC48sk5/A8/Vdi8TXM7Qqo31tyEJaSCSSfgzKwqSoo8PdgGWCBezRWaVlainvmEwmb8PIQq/RTRZ+OnhQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:58015 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a0DQt-0006DD-Pu (Exim); Sat, 21 Nov 2015 19:02:48 +0000
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Miguel Gaio <miguel.gaio@efixo.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
From:   Simon Arlott <simon@fire.lp0.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH 1/4] clocksource: Add brcm,bcm6345-timer device tree binding
Message-ID: <5650BFD6.5030700@simon.arlott.org.uk>
Date:   Sat, 21 Nov 2015 19:02:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50027
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

Add device tree binding for the BCM6345 timer. This is required for the
BCM6345 watchdog which needs to respond to one of the timer interrupts.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 .../bindings/timer/brcm,bcm6345-timer.txt          | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
new file mode 100644
index 0000000..2593907
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
@@ -0,0 +1,57 @@
+Broadcom BCM6345 Timer
+
+This block is a timer that is connected to one interrupt on the main interrupt
+controller and functions as a programmable interrupt controller for timer events.
+
+- 3 to 4 independent timers with their own maskable level interrupt bit (but not
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
+The BCM6318 also has a separate interrupt for every timer except the watchdog.
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
+  node for the main timer interrupt, followed by the individual timer interrupts
+  if present; valid values depend on the type of parent interrupt controller
+
+Example:
+
+timer: timer@0x10000080 {
+        compatible = "brcm,bcm63168-timer", "brcm,bcm6345-timer";
+        reg = <0x10000080 0x1c>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        interrupt-parent = <&periph_intc>;
+        interrupts = <0>;
+};
+
+timer: timer@0x10000040 {
+        compatible = "brcm,bcm6318-timer", "brcm,bcm6345-timer";
+        reg = <0x10000040 0x28>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        interrupt-parent = <&periph_intc>;
+        interrupts = <31>, <0>, <1>, <2>, <3>;
+};
-- 
2.1.4

-- 
Simon Arlott
