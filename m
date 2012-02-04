Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Feb 2012 11:08:38 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35340 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903604Ab2BDKIb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Feb 2012 11:08:31 +0100
Received: by bkcjk13 with SMTP id jk13so18648bkc.36
        for <multiple recipients>; Sat, 04 Feb 2012 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5DbAKFYwy9Pcg1BtxsGhRbHPD1tUZtU03iH+TQ8Jsrc=;
        b=i5r7zPKtsJ/1IEUu/VPcf7UAJ1qqjhOPGM6uDS8gdo230BqkkPGYbYw07gmGvmMuCB
         tzXt9ygtBWg+mxcW5j+wInsghXbJaQ4N4ZcQxhulukddzgh3DUjpSiR1CetNOhhx7Ivq
         gHmbuKmmSxfBs7nQpQ5t1gJUZwe9N1KLrGUYE=
Received: by 10.204.9.198 with SMTP id m6mr4960192bkm.74.1328350105851;
        Sat, 04 Feb 2012 02:08:25 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-058-217.pools.arcor-ip.net. [88.73.58.217])
        by mx.google.com with ESMTPS id ez5sm24774605bkc.15.2012.02.04.02.08.24
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 02:08:24 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>, stable@vger.kernel.org
Subject: [PATCH V2] MIPS: BCM63XX: add missing include for bcm63xx_gpio.h
Date:   Sat,  4 Feb 2012 11:07:37 +0100
Message-Id: <1328350057-10797-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32404
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

Cc: stable@vger.kernel.org
---
V1 -> V2
 * added cc to stable


This is also needed for all supported stable versions. The include is
missing from the beginning, breaking any driver using linux/gpio.h (but
they don't seem to be used often used on bcm63xx).

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
