Return-Path: <SRS0=QmNv=OV=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780EC67839
	for <linux-mips@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0271F20851
	for <linux-mips@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AATn46gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0271F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeLLWQv (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:16:51 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40710 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeLLWQu (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 12 Dec 2018 17:16:50 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 02/26] doc: Add doc for the Ingenic TCU hardware
Date:   Wed, 12 Dec 2018 23:08:57 +0100
Message-Id: <20181212220922.18759-3-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544652576; bh=hE24jDXobuv4NYtnUFddYqltMyTqMk1Kuy+rwuBR66Q=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AATn46gho76POgJAQI+VvJv+F41/a0zV0PusfHV9tKs4vKU+r2J6CiwPpqgViRkVNvICMcwYSL5n2z7Aa/1yyY5MhFijX+xK0f1eC+7c69kAqhZqXhayBfdcDHMBNeaSYqrsVjYAcy0+6uMCM8ctVlxOCocaUY5ptoe2WTzD/Kc=
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add a documentation file about the Timer/Counter Unit (TCU) present in
the Ingenic JZ47xx SoCs.

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
---

Notes:
     v4: New patch in this series
    
     v5: Added information about number of channels, and improved
         documentation about channel modes
    
     v6: Add info about OST (can be 32-bit on older SoCs)
    
     v7: No change
    
     v8: No change

 Documentation/mips/ingenic-tcu.txt | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/mips/ingenic-tcu.txt

diff --git a/Documentation/mips/ingenic-tcu.txt b/Documentation/mips/ingenic-tcu.txt
new file mode 100644
index 000000000000..0ea35b2a46da
--- /dev/null
+++ b/Documentation/mips/ingenic-tcu.txt
@@ -0,0 +1,60 @@
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
+  (OST). It is a 32-bit programmable timer. On JZ4770 and above, it is
+  64-bit.
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

