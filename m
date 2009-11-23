Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 23:35:28 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:58188 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1493487AbZKWWfW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 23:35:22 +0100
Received: by ewy23 with SMTP id 23so1944711ewy.24
        for <linux-mips@linux-mips.org>; Mon, 23 Nov 2009 14:35:15 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yBmjIykZBUsJlhNLuYEXp6mO7VbW0nLjmoXffP3jHy0=;
        b=hlJJ6JGSNyOnKbG6KOG8G2KfnponTVw6HxR70X5W/KMNg4Kj0e5I6VzbVxqEVq4clQ
         MvqdsKB7EScyY2qhZ8pFEOtqZewFuA9x16tRXmAIsw2c70RO8A/vKqtgWUc/YjsOffFr
         TVsnwU/N+B6U6gw3505cbfU/d5zBvoouaDfYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=THV8F35YEOUfz9OYrS3RG6/918nekz3+aFHAeP4Kh35isTCHxtoVuvkmZJ/uR0ZCZy
         8c/D42oqYmF7uttNqVnSnNkbBVdk9uEqvj5oz5EJ9LrYkIt+pio4+ctIEWTKYp2vk2ca
         iiWN9yyCvjc+Pzwq80zNU+6bsRDB3uWC+ZE7Q=
Received: by 10.216.87.133 with SMTP id y5mr1667022wee.139.1259005195670;
        Mon, 23 Nov 2009 11:39:55 -0800 (PST)
Received: from localhost.localdomain (p5496D521.dip.t-dialin.net [84.150.213.33])
        by mx.google.com with ESMTPS id g11sm10270817gve.3.2009.11.23.11.39.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 11:39:54 -0800 (PST)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/3] MIPS: Alchemy: Only build AU1000 INTC code for compatible cpus
Date:	Mon, 23 Nov 2009 20:40:01 +0100
Message-Id: <1259005202-7771-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1259005202-7771-1-git-send-email-manuel.lauss@gmail.com>
References: <1259005202-7771-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Use the GPIO config symbol to only build Au1000 interrupt code on
chips with compatible hw.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/Kconfig                |   14 +++++++-------
 arch/mips/alchemy/common/Makefile        |    6 ++++--
 arch/mips/include/asm/mach-au1x00/gpio.h |    2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 22f4ff5..df3b1a7 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -1,5 +1,5 @@
-# au1000-style gpio
-config ALCHEMY_GPIO_AU1000
+# au1000-style gpio and interrupt controllers
+config ALCHEMY_GPIOINT_AU1000
 	bool
 
 # select this in your board config if you don't want to use the gpio
@@ -133,27 +133,27 @@ endchoice
 config SOC_AU1000
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1100
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1500
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1550
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1200
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1X00
 	bool
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index abf0eb1..f46b351 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -5,14 +5,16 @@
 # Makefile for the Alchemy Au1xx0 CPUs, generic files.
 #
 
-obj-y += prom.o irq.o time.o reset.o \
+obj-y += prom.o time.o reset.o \
 	clocks.o platform.o power.o setup.o \
 	sleeper.o dma.o dbdma.o
 
+obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += irq.o
+
 # optional gpiolib support
 ifeq ($(CONFIG_ALCHEMY_GPIO_INDIRECT),)
  ifeq ($(CONFIG_GPIOLIB),y)
-  obj-$(CONFIG_ALCHEMY_GPIO_AU1000) += gpiolib-au1000.o
+  obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += gpiolib-au1000.o
  endif
 endif
 
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index f9b7d41..c3f60cd 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -1,7 +1,7 @@
 #ifndef _ALCHEMY_GPIO_H_
 #define _ALCHEMY_GPIO_H_
 
-#if defined(CONFIG_ALCHEMY_GPIO_AU1000)
+#if defined(CONFIG_ALCHEMY_GPIOINT_AU1000)
 
 #include <asm/mach-au1x00/gpio-au1000.h>
 
-- 
1.6.5.3
