Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 11:41:50 +0200 (CEST)
Received: from mail-lf0-x22b.google.com ([IPv6:2a00:1450:4010:c07::22b]:53294
        "EHLO mail-lf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992625AbdIQJkUJZSyP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 11:40:20 +0200
Received: by mail-lf0-x22b.google.com with SMTP id k9so5569457lfe.10
        for <linux-mips@linux-mips.org>; Sun, 17 Sep 2017 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gCUiTTfNN4A0Ks5ICP11L6908VWob6q3aNpZBxzMr2o=;
        b=EJcODZSdpg3anuolr3cBANwdDM8I3E5iGHNAV6io8KZ76ctPs1N8pDHUd5hSGKBLmS
         PWtS4Z0u2rQ02mW/KebTOT15ijAUtZAR325dmSS6xwD2tQcKoSAwgvypytV92QiQmxTf
         dG62zACB18ekGsRb0Lruib8UTN498A80hzV68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gCUiTTfNN4A0Ks5ICP11L6908VWob6q3aNpZBxzMr2o=;
        b=Nxj3NTEqmqunfjHXalLFE+0xwRk2jkQrQJ44M0n1EnA0dQci6wHiSzWRyH2E+QgEET
         dz1nG14XETBbu/rfprpof/MmoupqW4h5hXib0D/gVuBmEGLEI6lNckTc5zAjhmVvIGHO
         wjLuYTooJZu28AlGjGg3dhbk0YS7DqOM/UV0nHfPSKdpGo9oDNgi8bSvYa6PCH0ZHw7c
         yb7AhCNtCrIC07+KA11zA8N1qaGaCVPFF7TiGCrgg3TamoqrYYVJ7Z9uJSW0Ubi0TrHp
         wvSsTpX91pCpfMgQkrI23wpd8Bipl9x+TjOuC789MzdPstRt7WKEtFEqVNOg+d22mP8f
         T5hQ==
X-Gm-Message-State: AHPjjUiZbpppw+crlVag+3OYk8BMrf21u71TiHKzJIiYl06nJv2S8woh
        X9xlMHwgYwHcoGvk
X-Google-Smtp-Source: AOwi7QDWbRvs7Toyp6taphGqkvNt0d7MrNzgbP/livSNkIwozyUchtApTPh4f+O29jWcgjEgCNNigg==
X-Received: by 10.25.217.213 with SMTP id s82mr2511208lfi.176.1505641214477;
        Sun, 17 Sep 2017 02:40:14 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id t84sm974559lfi.21.2017.09.17.02.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Sep 2017 02:40:13 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        geert.renesas@glider.be, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/7] dt-bindings: i2c: i2c-gpio: Add support for named gpios
Date:   Sun, 17 Sep 2017 11:39:05 +0200
Message-Id: <20170917093906.16325-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

From: Geert Uytterhoeven <geert+renesas () glider ! be>

The current i2c-gpio DT bindings use a single unnamed "gpios" property
to refer to the SDA and SCL signal lines by index.  This is error-prone
for the casual DT writer and reviewer, as one has to look up the order
in the DT bindings.

Fix this by amending the DT bindings to use two separate named gpios
properties, and deprecate the old unnamed variant.

Take this opportunity to clearly deprecate the "i2c-gpio,sda-open-drain"
and "i2c-gpio,scl-open-drain" flags as well. The commit describes
in detail what these flags actually mean, and why they should not be
used in new device trees.

Cc: devicetree@vger.kernel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Augmented to what I and Rob would like]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Create a special section for the deprecated bindings
- Also deprecate the open drain bool properties
- Update the example to use the new style of bindings
---
 Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 32 ++++++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
index 4f8ec947c6bd..38a05562d1d2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
@@ -2,25 +2,39 @@ Device-Tree bindings for i2c gpio driver
 
 Required properties:
 	- compatible = "i2c-gpio";
-	- gpios: sda and scl gpio
-
+	- sda-gpios: gpio used for the sda signal, this should be flagged as
+	  active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
+	  from <dt-bindings/gpio/gpio.h> since the signal is by definition
+	  open drain.
+	- scl-gpios: gpio used for the scl signal, this should be flagged as
+	  active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
+	  from <dt-bindings/gpio/gpio.h> since the signal is by definition
+	  open drain.
 
 Optional properties:
-	- i2c-gpio,sda-open-drain: sda as open drain
-	- i2c-gpio,scl-open-drain: scl as open drain
 	- i2c-gpio,scl-output-only: scl as output only
 	- i2c-gpio,delay-us: delay between GPIO operations (may depend on each platform)
 	- i2c-gpio,timeout-ms: timeout to get data
 
+Deprecated properties, do not use in new device tree sources:
+	- gpios: sda and scl gpio, alternative for {sda,scl}-gpios
+	- i2c-gpio,sda-open-drain: this means that something outside of our
+	  control has put the GPIO line used for SDA into open drain mode, and
+	  that something is not the GPIO chip. It is essentially an
+	  inconsistency flag.
+	- i2c-gpio,scl-open-drain: this means that something outside of our
+	  control has put the GPIO line used for SCL into open drain mode, and
+	  that something is not the GPIO chip. It is essentially an
+	  inconsistency flag.
+
 Example nodes:
 
+#include <dt-bindings/gpio/gpio.h>
+
 i2c@0 {
 	compatible = "i2c-gpio";
-	gpios = <&pioA 23 0 /* sda */
-		 &pioA 24 0 /* scl */
-		>;
-	i2c-gpio,sda-open-drain;
-	i2c-gpio,scl-open-drain;
+	sda-gpios = <&pioA 23 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&pioA 24 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 	i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.13.5
