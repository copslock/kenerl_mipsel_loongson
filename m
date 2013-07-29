Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 23:29:38 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:65028 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831311Ab3G2V30ayvCt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jul 2013 23:29:26 +0200
Received: by mail-pa0-f45.google.com with SMTP id bg4so6311453pad.18
        for <multiple recipients>; Mon, 29 Jul 2013 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IIGGMWZnYFkI+CRFyCmQcJooQwvKjuZABKNVY7DVIKE=;
        b=jdzvgS6OfWPSwLhNxGINe5Mo0TmagN1Kzts1cA+/fNPmKb3QbO6YHE1hAnHWEXqAGA
         g0Na3qDAzHev1i/nbD9yxo2s2FmJOWhMlK8XLAL8u+TWVLqfntwHwHzSyDAHi98K6iNb
         ohLCJpW+JibXDyGv6pakTQ8HvTct1b6TxmwE3CQKxm6mrLMywsBCFbMyvOMR/vGF32EG
         iAn/Npycc7ZjRFIdQIENshW2KrVB4fZMlBsvAPN3zZnJy7otmgr6lHnsTt7Rgt6FyTuC
         BMGwgUSgo3trRRfslyD2YWOcJ0W234MA4AovPvWkfUCFkP4etgE0F5hUkZR1z/Zadf5B
         aAZw==
X-Received: by 10.68.200.104 with SMTP id jr8mr70665401pbc.43.1375133359415;
        Mon, 29 Jul 2013 14:29:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qh10sm38959317pbb.33.2013.07.29.14.29.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 14:29:18 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TLTGKi018867;
        Mon, 29 Jul 2013 14:29:16 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TLTGAi018866;
        Mon, 29 Jul 2013 14:29:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/2] MIPS: OCTEON: Select ARCH_REQUIRE_GPIOLIB
Date:   Mon, 29 Jul 2013 14:29:09 -0700
Message-Id: <1375133350-18828-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

... and create asm/mach-cavium-octeon/gpio.h so that things continue
to build.

This allows us to use the existing I2C connected GPIO expanders.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                               |  1 +
 arch/mips/include/asm/mach-cavium-octeon/gpio.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/gpio.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c3abed3..9c2293a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -731,6 +731,7 @@ config CAVIUM_OCTEON_SOC
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
 	select HOLES_IN_ZONE
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
diff --git a/arch/mips/include/asm/mach-cavium-octeon/gpio.h b/arch/mips/include/asm/mach-cavium-octeon/gpio.h
new file mode 100644
index 0000000..34e9f7a
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/gpio.h
@@ -0,0 +1,21 @@
+#ifndef __ASM_MACH_CAVIUM_OCTEON_GPIO_H
+#define __ASM_MACH_CAVIUM_OCTEON_GPIO_H
+
+#ifdef CONFIG_GPIOLIB
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#else
+int gpio_request(unsigned gpio, const char *label);
+void gpio_free(unsigned gpio);
+int gpio_direction_input(unsigned gpio);
+int gpio_direction_output(unsigned gpio, int value);
+int gpio_get_value(unsigned gpio);
+void gpio_set_value(unsigned gpio, int value);
+#endif
+
+#include <asm-generic/gpio.h>
+
+#define gpio_to_irq	__gpio_to_irq
+
+#endif /* __ASM_MACH_GENERIC_GPIO_H */
-- 
1.7.11.7
