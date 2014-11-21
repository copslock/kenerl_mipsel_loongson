Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 10:18:22 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38250 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006543AbaKUJSEI3c7a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2014 10:18:04 +0100
Received: by mail-pd0-f173.google.com with SMTP id ft15so4908713pdb.4
        for <multiple recipients>; Fri, 21 Nov 2014 01:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j3HkV34s7dhT6b9cxo4lGDWlLQO2B6P1fF3/Mc2DFDo=;
        b=M4w901we6c9yO06UnqAG9TBklYqiNm82YtTJI41gBqikJSAwGQMskXoGan7fmUcMCY
         Ag7vBgzgxtWc8e6K1vP7WSIjbLlYOhIvGMgLvPEoWEUxcsZPpedS+oaLxzLlUUHmuwWY
         yRcfqta/JcSvujjhimZacAdU/z1eBhbFHtjajBrGsJXjNpGSOvaskwQWZuwdi6x786ct
         cUU18WPAQVGmbGJsCSc2p2fZPEsbz4VUdvXXzdV7NOjNkbRTnT4u0Uuinbfm1LAf/qjz
         Pkk0fdWlOH45IR1PxFc6wpkBSbV9cF6hIK9jhVsbWzk2rSWETESvQXIco5mCe5eiqn+0
         aGyg==
X-Received: by 10.70.61.136 with SMTP id p8mr5126544pdr.98.1416561478468;
        Fri, 21 Nov 2014 01:17:58 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id b16sm4227557pdl.56.2014.11.21.01.17.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Nov 2014 01:17:58 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-gpio@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V5 3/7] MIPS: Move Loongson GPIO driver to drivers/gpio
Date:   Fri, 21 Nov 2014 17:16:28 +0800
Message-Id: <1416561389-1046-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1416561389-1046-1-git-send-email-chenhc@lemote.com>
References: <1416561389-1046-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Move Loongson-2's GPIO driver to drivers/gpio and add Kconfig options.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/configs/lemote2f_defconfig               |    1 +
 arch/mips/loongson/common/Makefile                 |    1 -
 drivers/gpio/Kconfig                               |    6 ++++++
 drivers/gpio/Makefile                              |    1 +
 .../common/gpio.c => drivers/gpio/gpio-loongson.c  |    0
 5 files changed, 8 insertions(+), 1 deletions(-)
 rename arch/mips/loongson/common/gpio.c => drivers/gpio/gpio-loongson.c (100%)

diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 227a9de..0549b01 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -172,6 +172,7 @@ CONFIG_SERIAL_8250_FOURPORT=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_HW_RANDOM=y
 CONFIG_RTC=y
+CONFIG_GPIO_LOONGSON=y
 CONFIG_THERMAL=y
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_VIDEO_DEV=m
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index d87e033..e70c33f 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -4,7 +4,6 @@
 
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
     bonito-irq.o mem.o machtype.o platform.o
-obj-$(CONFIG_GPIOLIB) += gpio.o
 obj-$(CONFIG_PCI) += pci.o
 
 #
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0959ca9..bc5ffac 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -452,6 +452,12 @@ config GPIO_GRGPIO
 	  Select this to support Aeroflex Gaisler GRGPIO cores from the GRLIB
 	  VHDL IP core library.
 
+config GPIO_LOONGSON
+	tristate "Loongson-2 GPIO support"
+	depends on CPU_LOONGSON2
+	help
+	  driver for GPIO functionality on Loongson-2F processors.
+
 config GPIO_TB10X
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index e5d346c..2153a71 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)	+= gpio-kempld.o
 obj-$(CONFIG_ARCH_KS8695)	+= gpio-ks8695.o
 obj-$(CONFIG_GPIO_INTEL_MID)	+= gpio-intel-mid.o
+obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
 obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
diff --git a/arch/mips/loongson/common/gpio.c b/drivers/gpio/gpio-loongson.c
similarity index 100%
rename from arch/mips/loongson/common/gpio.c
rename to drivers/gpio/gpio-loongson.c
-- 
1.7.7.3
