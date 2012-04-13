Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2012 02:10:52 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:44002 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903724Ab2DMAKg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2012 02:10:36 +0200
Received: by obhx4 with SMTP id x4so4183557obh.36
        for <multiple recipients>; Thu, 12 Apr 2012 17:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=v0TDxjcv2GmlzfGeTYToz/I3j0c6FcnlxCDK8gPQe4I=;
        b=FbIAZQfNF2p7Bh1FguJ4B25j5/S8nSh30ZZyfUsjIjf9O9WyXlfqJUDF1/P5ZLwq6a
         G+m4Ew+RNGsTxmJBJGqNvPXVP9Evw0ylSKJ3typ58wgwruxzBrzrmOg2R494WVQfDzt5
         SZM5L/Yfe3LXIWTb5fjNLo2DPDGAn2eqYZTUxN46R42F0pXNTJ/S4JSzfMBgUsLXE8VM
         B7dKp+YSATVpqkDC58txfgIdrF6YFFuy0x1jWBu+HHRX++ZEsuHQQP1AO9z3VKRpKPCV
         xTV0XBKmYZ7ZXqr0glfZF4f+x1plcl0NNBoLvTHV1PF8AHSq+yzIH5axCQY/nPCZdcQA
         fsOA==
Received: by 10.60.20.10 with SMTP id j10mr236909oee.33.1334275830548;
        Thu, 12 Apr 2012 17:10:30 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id in4sm8499620obb.2.2012.04.12.17.10.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 17:10:29 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3D0ARci007828;
        Thu, 12 Apr 2012 17:10:27 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3D0ARiO007827;
        Thu, 12 Apr 2012 17:10:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>, ralf@linux-mips.org,
        linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@stericsson.com>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: OCTEON: Select ARCH_REQUIRE_GPIOLIB
Date:   Thu, 12 Apr 2012 17:10:19 -0700
Message-Id: <1334275820-7791-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

... and create asm/mach-cavium-octeon/gpio.h so that things continue
to build.

This allows us to use the existing I2C connected GPIO expanders.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                               |    1 +
 arch/mips/include/asm/mach-cavium-octeon/gpio.h |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/gpio.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d0011ef..3134457 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -744,6 +744,7 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
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
1.7.2.3
