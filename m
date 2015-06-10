Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 23:05:52 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38663 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007838AbbFJVFrmdKlU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2015 23:05:47 +0200
Received: by wibdq8 with SMTP id dq8so58698265wib.1;
        Wed, 10 Jun 2015 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=pVL4m8oRNMvMnygdy/GB6iOqifsmEDOklUe8gS4D//0=;
        b=L8eg25Uo0RKeILf+k1dGjitBx7a5HYdGwH1R0YSy882Hd8yzU2TgkkFKppg3/pGq7o
         j2Ix45Izcn3UCXGGQq0Ds1xdYjgl/LFtsttMm1G+ymAIb4f4s4S0uHLHC6XetggoMoD9
         XRTPZ6D4ESrP7gOt2Cxza+4xQtH4QDZ0IZVn+QxcJLLOwywvHF6z8n7lNoBeqR5avOIi
         +kJdjnphRBlEDjvtL9kTtFBnOzsGzZ5g4rpFkKD3XiBfjIPCrf0uT4UcjYXmugh47L0N
         FfUlkAlpXhf3ToNq6P4l03ldbuxKf4HWpU3c7yhIChezrrJ7jyvu9uLfWEdpw0Wxl8av
         iYOg==
X-Received: by 10.180.198.199 with SMTP id je7mr12309330wic.34.1433970342437;
        Wed, 10 Jun 2015 14:05:42 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id i14sm16238874wjr.7.2015.06.10.14.05.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 14:05:41 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Paul Walmsley <paul@pwsan.com>,
        Seiji Aguchi <seiji.aguchi@hds.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mike Waychison <mikew@google.com>,
        Roy Franz <roy.franz@linaro.org>,
        Matt Fleming <matt.fleming@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Move NVRAM driver to the drivers/firmware/
Date:   Wed, 10 Jun 2015 23:05:08 +0200
Message-Id: <1433970308-5158-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

After Broadcom switched from MIPS to ARM for their home routers we need
to have NVRAM driver in some common place (not arch/mips/). As explained
in Kconfig, this driver is responsible for parsing SoC configuration
data that is passed to the kernel in flash from the bootloader firmware
called "CFE".

We were thinking about putting it in bus directory, however there are
two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
won't fit there and this is why I would like to move this driver to the
drivers/firmware/.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
---
Hi,

This is my real try of finally moving this driver out of MIPS code. By
real I mean the first non-RFC :)

I was trying to get more Reviewed-by -s from ppl involved in
drivers/firmware, but unfortunately I didn't get any (I tried few
times). So I can only hope the lack of Nack-s will do.

For the RFC version of this patch you may want to see:
http://patchwork.linux-mips.org/patch/8663/
Its history is described a bit better there if you want to track it.
The only change since RFC is MAINTAINERS update.

Paul: I took a one sentence of commit description from your e-mail, hope
you won't mind.

There isn't any ML dedicated to the drivers/firmware/ so I put ppl from
git log drivers/firmware/ | grep Author | head -n 500 | sort | uniq -c | sort -n | tail -n 7
on Cc.
---
 MAINTAINERS                                                   |  6 ++++++
 arch/mips/Kconfig                                             |  1 +
 arch/mips/bcm47xx/Makefile                                    |  2 +-
 drivers/firmware/Kconfig                                      |  1 +
 drivers/firmware/Makefile                                     |  1 +
 drivers/firmware/broadcom/Kconfig                             | 11 +++++++++++
 drivers/firmware/broadcom/Makefile                            |  1 +
 .../nvram.c => drivers/firmware/broadcom/bcm47xx_nvram.c      |  2 ++
 include/linux/bcm47xx_nvram.h                                 |  2 +-
 9 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/broadcom/Kconfig
 create mode 100644 drivers/firmware/broadcom/Makefile
 rename arch/mips/bcm47xx/nvram.c => drivers/firmware/broadcom/bcm47xx_nvram.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43043f0..25a17aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2265,6 +2265,12 @@ S:	Supported
 F:	drivers/gpio/gpio-bcm-kona.c
 F:	Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
 
+BROADCOM NVRAM DRIVER
+M:	Rafał Miłecki <zajec5@gmail.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	drivers/firmware/broadcom/*
+
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
 M:	Rafał Miłecki <zajec5@gmail.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3f82c7d..cf09f42 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -191,6 +191,7 @@ config BCM47XX
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select GPIOLIB
 	select LEDS_GPIO_REGISTER
+	select BCM47XX_NVRAM
 	help
 	 Support for BCM47XX based boards
 
diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index d58c51b..66bea4e 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,5 +3,5 @@
 # under Linux.
 #
 
-obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
+obj-y				+= irq.o prom.o serial.o setup.o time.o sprom.o
 obj-y				+= board.o buttons.o leds.o workarounds.o
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6517132..99c69a3 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -136,6 +136,7 @@ config QCOM_SCM
 	bool
 	depends on ARM || ARM64
 
+source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 3fdd391..210c6e0 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
 CFLAGS_qcom_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
 
+obj-y				+= broadcom/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
new file mode 100644
index 0000000..6bed119
--- /dev/null
+++ b/drivers/firmware/broadcom/Kconfig
@@ -0,0 +1,11 @@
+config BCM47XX_NVRAM
+	bool "Broadcom NVRAM driver"
+	depends on BCM47XX || ARCH_BCM_5301X
+	help
+	  Broadcom home routers contain flash partition called "nvram" with all
+	  important hardware configuration as well as some minor user setup.
+	  NVRAM partition contains a text-like data representing name=value
+	  pairs.
+	  This driver provides an easy way to get value of requested parameter.
+	  It simply reads content of NVRAM and parses it. It doesn't control any
+	  hardware part itself.
diff --git a/drivers/firmware/broadcom/Makefile b/drivers/firmware/broadcom/Makefile
new file mode 100644
index 0000000..d0e6835
--- /dev/null
+++ b/drivers/firmware/broadcom/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_BCM47XX_NVRAM)		+= bcm47xx_nvram.o
diff --git a/arch/mips/bcm47xx/nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
similarity index 99%
rename from arch/mips/bcm47xx/nvram.c
rename to drivers/firmware/broadcom/bcm47xx_nvram.c
index 9ccdce8..87add3f 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -244,3 +244,5 @@ char *bcm47xx_nvram_get_contents(size_t *nvram_size)
 	return nvram;
 }
 EXPORT_SYMBOL(bcm47xx_nvram_get_contents);
+
+MODULE_LICENSE("GPLv2");
diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
index c73927c..2793652 100644
--- a/include/linux/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 
-#ifdef CONFIG_BCM47XX
+#ifdef CONFIG_BCM47XX_NVRAM
 int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
 int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
 int bcm47xx_nvram_gpio_pin(const char *name);
-- 
1.8.4.5
