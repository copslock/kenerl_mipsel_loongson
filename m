Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jun 2013 00:58:08 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50499 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825737Ab3FNW6GYXRxt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Jun 2013 00:58:06 +0200
Received: by mail-pa0-f41.google.com with SMTP id bj3so1079453pad.14
        for <multiple recipients>; Fri, 14 Jun 2013 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yqMUxm3BtjcRYmQxm3q8x7OByFYt7HyMQQEoRL23HaI=;
        b=OKZWTt7RoSOOUEGguA1/UL5iggTZs6qFcS3kQA3vlZsjCYL6oJ7eEcQG7QwcrZ82UU
         H38KrW57QGUHT1OsCGmIXB4VzrUO/gVsYTFhcSIc8LQIrSntEanpKgIg8lccZYyYwuyh
         jdy42xfwW+g7V2v4sRvthcr0PFIdtjhxXW2cMFIAFKMawSwDlquOM6x7UxUrbw+X9KIx
         O4LfDK76NotsEfDqm9k3MoKzrSlNC5ZAWsKd2OcYBIXXIkStby3HCnkN94M9SvEWoLVw
         JoZ0t+hAmuY1xt3/ORM8lzeGjhVfigo3LVp/5SGO1/yx6KQN8TdJQAHoXAbTMEdvOPmo
         QPBQ==
X-Received: by 10.66.169.42 with SMTP id ab10mr4537838pac.14.1371250679640;
        Fri, 14 Jun 2013 15:57:59 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ib9sm3696129pbc.43.2013.06.14.15.57.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 15:57:58 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5EMvuf1013373;
        Fri, 14 Jun 2013 15:57:56 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5EMvtAt013372;
        Fri, 14 Jun 2013 15:57:55 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: OCTEON: Select ARCH_REQUIRE_GPIOLIB
Date:   Fri, 14 Jun 2013 15:57:54 -0700
Message-Id: <1371250674-13337-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36913
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
index b599130..5bd7887 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -751,6 +751,7 @@ config CAVIUM_OCTEON_SOC
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
