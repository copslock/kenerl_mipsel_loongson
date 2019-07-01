Return-Path: <SRS0=dgrR=U6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCE9C46478
	for <linux-mips@archiver.kernel.org>; Mon,  1 Jul 2019 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560F220B7C
	for <linux-mips@archiver.kernel.org>; Mon,  1 Jul 2019 15:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="aw6+qUhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfGAPOW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:14:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57234 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfGAPOW (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 1 Jul 2019 11:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561994059; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3iG/u0MdVd8fiIQ3z2OQEF8lbIBGiEKZ3pPDjuVfZqw=;
        b=aw6+qUhEf7Wv1RRa2AIe7xrLZYHi8FN3zHoc1A3uVxs9qO/3Rx2ZKooqYGcCY+OEju8Fk4
        841J3ItFMyAFZRg+OscUGHKzzdLqC/Ja41G6F7T8kDEJ6zktLuNXm922YNIarwTdn8wEe9
        TDIKbi4kbPM0QNhdB5WpQrI83W5Vqag=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v14 02/13] doc: Add doc for the Ingenic TCU hardware
Date:   Mon,  1 Jul 2019 17:13:59 +0200
Message-Id: <20190701151410.23127-3-paul@crapouillou.net>
In-Reply-To: <20190701151410.23127-1-paul@crapouillou.net>
References: <20190701151410.23127-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add documentation about the Timer/Counter Unit (TCU) present in the
Ingenic JZ47xx SoCs.

The Timer/Counter Unit (TCU) in Ingenic JZ47xx SoCs is a multi-function
hardware block. It features up to to eight channels, that can be used as
counters, timers, or PWM.

- JZ4725B, JZ4750, JZ4755 only have six TCU channels. The other SoCs all
  have eight channels.

- JZ4725B introduced a separate channel, called Operating System Timer
  (OST). It is a 32-bit programmable timer. On JZ4770 and above, it is
  64-bit.

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
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v4: New patch in this series
    
    v5: Added information about number of channels, and improved
        documentation about channel modes
    
    v6: Add info about OST (can be 32-bit on older SoCs)
    
    v7-v11: No change
    
    v12: Add details about new implementation
    
    v13: No change
    
    v14: Convert to ReStructured Text

 Documentation/index.rst            |  1 +
 Documentation/mips/index.rst       | 11 +++++
 Documentation/mips/ingenic-tcu.rst | 72 ++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 Documentation/mips/index.rst
 create mode 100644 Documentation/mips/ingenic-tcu.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index a7566ef62411..00481ac8d75f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -115,6 +115,7 @@ implementation.
    x86/index
    sh/index
    x86/index
+   mips/index
 
 Filesystem Documentation
 ------------------------
diff --git a/Documentation/mips/index.rst b/Documentation/mips/index.rst
new file mode 100644
index 000000000000..321b4794f3b8
--- /dev/null
+++ b/Documentation/mips/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+MIPS-specific Documentation
+===========================
+
+.. toctree::
+   :maxdepth: 1
+   :numbered:
+
+   ingenic-tcu
diff --git a/Documentation/mips/ingenic-tcu.rst b/Documentation/mips/ingenic-tcu.rst
new file mode 100644
index 000000000000..651c2ebccf71
--- /dev/null
+++ b/Documentation/mips/ingenic-tcu.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================
+Ingenic JZ47xx SoCs Timer/Counter Unit hardware
+===============================================
+
+The Timer/Counter Unit (TCU) in Ingenic JZ47xx SoCs is a multi-function
+hardware block. It features up to to eight channels, that can be used as
+counters, timers, or PWM.
+
+- JZ4725B, JZ4750, JZ4755 only have six TCU channels. The other SoCs all
+  have eight channels.
+
+- JZ4725B introduced a separate channel, called Operating System Timer
+  (OST). It is a 32-bit programmable timer. On JZ4760B and above, it is
+  64-bit.
+
+- Each one of the TCU channels has its own clock, which can be reparented to three
+  different clocks (pclk, ext, rtc), gated, and reclocked, through their TCSR register.
+
+    - The watchdog and OST hardware blocks also feature a TCSR register with the same
+      format in their register space.
+    - The TCU registers used to gate/ungate can also gate/ungate the watchdog and
+      OST clocks.
+
+- Each TCU channel works in one of two modes:
+
+    - mode TCU1: channels cannot work in sleep mode, but are easier to
+      operate.
+    - mode TCU2: channels can work in sleep mode, but the operation is a bit
+      more complicated than with TCU1 channels.
+
+- The mode of each TCU channel depends on the SoC used:
+
+    - On the oldest SoCs (up to JZ4740), all of the eight channels operate in
+      TCU1 mode.
+    - On JZ4725B, channel 5 operates as TCU2, the others operate as TCU1.
+    - On newest SoCs (JZ4750 and above), channels 1-2 operate as TCU2, the
+      others operate as TCU1.
+
+- Each channel can generate an interrupt. Some channels share an interrupt
+  line, some don't, and this changes between SoC versions:
+
+    - on older SoCs (JZ4740 and below), channel 0 and channel 1 have their
+      own interrupt line; channels 2-7 share the last interrupt line.
+    - On JZ4725B, channel 0 has its own interrupt; channels 1-5 share one
+      interrupt line; the OST uses the last interrupt line.
+    - on newer SoCs (JZ4750 and above), channel 5 has its own interrupt;
+      channels 0-4 and (if eight channels) 6-7 all share one interrupt line;
+      the OST uses the last interrupt line.
+
+Implementation
+==============
+
+The functionalities of the TCU hardware are spread across multiple drivers:
+
+===========  =====
+boilerplate  drivers/mfd/ingenic-tcu.c
+clocks       drivers/clk/ingenic/tcu.c
+interrupts   drivers/irqchip/irq-ingenic-tcu.c
+timers       drivers/clocksource/ingenic-timer.c
+OST          drivers/clocksource/ingenic-ost.c
+PWM          drivers/pwm/pwm-jz4740.c
+watchdog     drivers/watchdog/jz4740_wdt.c
+===========  =====
+
+Because various functionalities of the TCU that belong to different drivers
+and frameworks can be controlled from the same registers, all of these
+drivers access their registers through the same regmap.
+
+For more information regarding the devicetree bindings of the TCU drivers,
+have a look at Documentation/devicetree/bindings/mfd/ingenic,tcu.txt.
-- 
2.21.0.593.g511ec345e18

