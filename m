Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2012 21:53:13 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:57463 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904172Ab2BBUxH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2012 21:53:07 +0100
Received: by eeke50 with SMTP id e50so960688eek.36
        for <multiple recipients>; Thu, 02 Feb 2012 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=E3Ds6aSjv9ScZRlOTBF01PWW8fBnkmfzTEA0277ZOTg=;
        b=QvAOu1DRYdp3TgrerMiZLcYZeeuBs1WkZOlFnKJMNLg2qamrZiKylrdOgc/IEpOHWL
         TF2ejha/lcUNvuXVa1Xba0aGZcIiXdVvOfnuV82/KqQsWj+nKOu1Z+zb/56ud77sn/uN
         D8HE4FgOhWfwspE0Ks77jDUr//dzv1p+G+DaY=
Received: by 10.14.131.13 with SMTP id l13mr1376434eei.45.1328215981802;
        Thu, 02 Feb 2012 12:53:01 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-058-217.pools.arcor-ip.net. [88.73.58.217])
        by mx.google.com with ESMTPS id x4sm13350636eeb.4.2012.02.02.12.53.00
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:53:00 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: BCM63XX: add missing include for bcm63xx_gpio.h
Date:   Thu,  2 Feb 2012 21:52:11 +0100
Message-Id: <1328215931-24817-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

bcm63xx_gpio.h uses macros defined in bcm63xx_cpu.h without including it,
leading to the following build failure:

  CC [M]  drivers/mmc/core/cd-gpio.o
In file included from arch/mips/include/asm/mach-bcm63xx/gpio.h:4:0,
                 from arch/mips/include/asm/gpio.h:4,
                 from include/linux/gpio.h:30,
                 from drivers/mmc/core/cd-gpio.c:12:

arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h: In function 'bcm63xx_gpio_count':
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:10:2: error: implicit declaration of function 'bcm63xx_get_cpu_id'
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:11:7: error: 'BCM6358_CPU_ID' undeclared (first use in this function)
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:11:7: note: each undeclared identifier is reported only once for each function it appears in
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:13:7: error: 'BCM6338_CPU_ID' undeclared (first use in this function)
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:15:7: error: 'BCM6345_CPU_ID' undeclared (first use in this function)
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:17:7: error: 'BCM6368_CPU_ID' undeclared (first use in this function)
arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:19:7: error: 'BCM6348_CPU_ID' undeclared (first use in this function)

make[7]: *** [drivers/mmc/core/cd-gpio.o] Error 1

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

Looking at the file's history, it looks like the problem was there from
the beginning. So it probably should go into all supported (stable)
versions up to 3.3-rc2, even if this particular build failure popped up
first in 3.3.

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 3d5de96..1d7dd96 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -2,6 +2,7 @@
 #define BCM63XX_GPIO_H
 
 #include <linux/init.h>
+#include <bcm63xx_cpu.h>
 
 int __init bcm63xx_gpio_init(void);
 
-- 
1.7.2.5
