Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 01:20:45 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:53928 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994551AbeGXXUOJlacu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 01:20:14 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 03/21] doc: Add doc for the Ingenic TCU hardware
Date:   Wed, 25 Jul 2018 01:19:40 +0200
Message-Id: <20180724231958.20659-4-paul@crapouillou.net>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474412; bh=Qz/f6huBL7dubSMGup9lH9sq7TXwVCtzzJkCy4iMjRU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tBryH4m9MSxWadmWl3dno5uYAx5LJmyZl0AxjhO29dpHnCP6zViCSpL4xgFpGILeIoOWfByS4tEKo+ZZ62Egtgqh6nwOa9llphDpGfa3TySaTHU3QgT++09IrxTrS6HGTChKhs+wphtNvGzfDDYDxEPCxtYf/zfU2FkZwbIc/Ik=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65102
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

Add a documentation file about the Timer/Counter Unit (TCU) present in
the Ingenic JZ47xx SoCs.

The Timer/Counter Unit (TCU) in Ingenic JZ47xx SoCs is a multi-function
hardware block. It features up to to eight channels, that can be used as
counters, timers, or PWM.

- JZ4725B, JZ4750, JZ4755 only have six TCU channels. The other SoCs all
  have eight channels.

- JZ4725B introduced a separate channel, called Operating System Timer
  (OST). It is a 64-bit programmable timer.

- Each one of the TCU channels has its own clock, which can be reparented
  to three different clocks (pclk, ext, rtc), gated, and reclocked, through
  their TCSR register.
  * The watchdog and OST hardware blocks also feature a TCSR register with
    the same format in their register space.
  * The TCU registers used to gate/ungate can also gate/ungate the watchdog
    and OST clocks.

- Each TCU channel works in one of two modes:
  * mode TCU1: channels cannot work in sleep mode, but are easier to
    operate.
  * mode TCU2: channels can work in sleep mode, but the operation is a bit
    more complicated than with TCU1 channels.

- The mode of each TCU channel depends on the SoC used:
  * On the oldest SoCs (up to JZ4740), all of the eight channels operate in
    TCU1 mode.
  * On JZ4725B, channel 5 operates as TCU2, the others operate as TCU1.
  * On newest SoCs (JZ4750 and above), channels 1-2 operate as TCU2, the
    others operate as TCU1.

- Each channel can generate an interrupt. Some channels share an interrupt
  line, some don't, and this changes between SoC versions:
  * on older SoCs (JZ4740 and below), channel 0 and channel 1 have their
    own interrupt line; channels 2-7 share the last interrupt line.
  * On JZ4725B, channel 0 has its own interrupt; channels 1-5 share one
    interrupt line; the OST uses the last interrupt line.
  * on newer SoCs (JZ4750 and above), channel 5 has its own interrupt;
    channels 0-4 and (if eight channels) 6-7 all share one interrupt line;
    the OST uses the last interrupt line.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/mips/00-INDEX        |  3 ++
 Documentation/mips/ingenic-tcu.txt | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/mips/ingenic-tcu.txt

 v4: New patch in this series

 v5: Added information about number of channels, and improved
     documentation about channel modes

diff --git a/Documentation/mips/00-INDEX b/Documentation/mips/00-INDEX
index 8ae9cffc2262..8ab8c3f83771 100644
--- a/Documentation/mips/00-INDEX
+++ b/Documentation/mips/00-INDEX
@@ -2,3 +2,6 @@
 	- this file.
 AU1xxx_IDE.README
 	- README for MIPS AU1XXX IDE driver.
+ingenic-tcu.txt
+	- Information file about the Timer/Counter Unit present
+	  in Ingenic JZ47xx SoCs.
diff --git a/Documentation/mips/ingenic-tcu.txt b/Documentation/mips/ingenic-tcu.txt
new file mode 100644
index 000000000000..dd044c40dbfe
--- /dev/null
+++ b/Documentation/mips/ingenic-tcu.txt
@@ -0,0 +1,59 @@
+Ingenic JZ47xx SoCs Timer/Counter Unit hardware
+-----------------------------------------------
+
+The Timer/Counter Unit (TCU) in Ingenic JZ47xx SoCs is a multi-function
+hardware block. It features up to to eight channels, that can be used as
+counters, timers, or PWM.
+
+- JZ4725B, JZ4750, JZ4755 only have six TCU channels. The other SoCs all
+  have eight channels.
+
+- JZ4725B introduced a separate channel, called Operating System Timer
+  (OST). It is a 64-bit programmable timer.
+
+- Each one of the TCU channels has its own clock, which can be reparented
+  to three different clocks (pclk, ext, rtc), gated, and reclocked, through
+  their TCSR register.
+  * The watchdog and OST hardware blocks also feature a TCSR register with
+    the same format in their register space.
+  * The TCU registers used to gate/ungate can also gate/ungate the watchdog
+    and OST clocks.
+
+- Each TCU channel works in one of two modes:
+  * mode TCU1: channels cannot work in sleep mode, but are easier to
+    operate.
+  * mode TCU2: channels can work in sleep mode, but the operation is a bit
+    more complicated than with TCU1 channels.
+
+- The mode of each TCU channel depends on the SoC used:
+  * On the oldest SoCs (up to JZ4740), all of the eight channels operate in
+    TCU1 mode.
+  * On JZ4725B, channel 5 operates as TCU2, the others operate as TCU1.
+  * On newest SoCs (JZ4750 and above), channels 1-2 operate as TCU2, the
+    others operate as TCU1.
+
+- Each channel can generate an interrupt. Some channels share an interrupt
+  line, some don't, and this changes between SoC versions:
+  * on older SoCs (JZ4740 and below), channel 0 and channel 1 have their
+    own interrupt line; channels 2-7 share the last interrupt line.
+  * On JZ4725B, channel 0 has its own interrupt; channels 1-5 share one
+    interrupt line; the OST uses the last interrupt line.
+  * on newer SoCs (JZ4750 and above), channel 5 has its own interrupt;
+    channels 0-4 and (if eight channels) 6-7 all share one interrupt line;
+    the OST uses the last interrupt line.
+
+Implementation
+--------------
+
+The functionalities of the TCU hardware are spread across multiple drivers:
+- clocks/irq/timer: drivers/clocksource/ingenic-timer.c
+- PWM:              drivers/pwm/pwm-jz4740.c
+- watchdog:         drivers/watchdog/jz4740_wdt.c
+- OST:              drivers/clocksource/ingenic-ost.c
+
+Because various functionalities of the TCU that belong to different drivers
+and frameworks can be controlled from the same registers, all of these
+drivers access their registers through the same regmap.
+
+For more information regarding the devicetree bindings of the TCU drivers,
+have a look at Documentation/devicetree/bindings/mfd/ingenic,tcu.txt.
-- 
2.11.0
