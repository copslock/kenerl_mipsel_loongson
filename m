Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 03:33:43 +0100 (CET)
Received: from SMTPBG7.QQ.COM ([183.60.61.200]:54100 "EHLO smtpbg7.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008621AbbCMCdlf-Lyp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Mar 2015 03:33:41 +0100
X-QQ-mid: bizesmtp1t1426213679t550t305
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 13 Mar 2015 10:27:58 +0800 (CST)
X-QQ-SSF: 01100000000000F0FJ52B00A0000000
X-QQ-FEAT: xflb0yrtfs8u6oXk9wVqDAb/hrCgmoTAuiRdGxQtv9yz1CqkcXPt+2emzHAHy
        3tpCOpfFbnoBWfh8Fdv1I0QPdiuy+x2OEeBZehaWXHjL6YYQvCBgnt7ygbIkGx2cYaUeRJd
        boFw5eXF58ywL/xvmHVOPGJnCQX1UpK0E1DwdoNWGxd3IRsIPvKl9+blCY5r885faShMwd4
        Z3UUzvqgfQO92oMhEmkelwX/C5WOtx7EgbJdmmItw8A==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-gpio@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V8 4/8] MIPS: Move Loongson GPIO driver to drivers/gpio
Date:   Fri, 13 Mar 2015 10:26:34 +0800
Message-Id: <1426213595-28454-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
References: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46360
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
index e51aad9..0cbc986 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -171,6 +171,7 @@ CONFIG_SERIAL_8250_FOURPORT=y
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
index c1e2ca3..6454160 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -499,6 +499,12 @@ config GPIO_GRGPIO
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
index bdda6a9..1b5be76 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
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



By	
