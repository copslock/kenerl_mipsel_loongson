Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 12:18:28 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:57600 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903626Ab2EHKSR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 12:18:17 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 08 May 2012 03:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="scan'208";a="140264858"
Received: from blue.fi.intel.com ([10.237.72.50])
  by azsmga001.ch.intel.com with ESMTP; 08 May 2012 03:18:08 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     Linux Kernel Maling List <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: bcm63xx: fix compilation problems
Date:   Tue,  8 May 2012 13:19:07 +0300
Message-Id: <1336472347-25822-1-git-send-email-dedekind1@gmail.com>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

I get the following build error when I am compiling the MTD gpio-nand driver
for bcm63xx:

In file included from arch/mips/include/asm/mach-bcm63xx/gpio.h:4:0,
                 from arch/mips/include/asm/gpio.h:4,
                 from include/linux/gpio.h:36,
                 from drivers/mtd/maps/gpio-addr-flash.c:16:
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h: In function 'bcm63xx_gpio_count':
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:10:2: error: implicit declaration of function 'bcm63xx_get_cpu_id' [-Werror=implicit-function-declaration]
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:11:7: error: 'BCM6358_CPU_ID' undeclared (first use in this function)
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:11:7: note: each undeclared identifier is reported only once for each function it appears in
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:13:7: error: 'BCM6338_CPU_ID' undeclared (first use in this function)
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:15:7: error: 'BCM6345_CPU_ID' undeclared (first use in this function)
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:17:7: error: 'BCM6368_CPU_ID' undeclared (first use in this function)
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:19:7: error: 'BCM6348_CPU_ID' undeclared (first use in this function)

This patch sloves the problem.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 3d5de96..b4b9103 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -1,6 +1,7 @@
 #ifndef BCM63XX_GPIO_H
 #define BCM63XX_GPIO_H
 
+#include "bcm63xx_cpu.h"
 #include <linux/init.h>
 
 int __init bcm63xx_gpio_init(void);
-- 
1.7.9.1
