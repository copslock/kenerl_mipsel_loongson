Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 14:32:10 +0100 (CET)
Received: from mail-ea0-f177.google.com ([209.85.215.177]:35494 "EHLO
        mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823024Ab2KBNcIXjdrv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2012 14:32:08 +0100
Received: by mail-ea0-f177.google.com with SMTP id n13so1397065eaa.36
        for <linux-mips@linux-mips.org>; Fri, 02 Nov 2012 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=g3QaeieCpDYQ5SlLrA1T3LBfoKejGK8upHw1ptTZ5mQ=;
        b=XOnSORG5yLwEeqgl6xJa2YOgakIJFLp1wB0EDeuC2uYXDLDblsyUk+bydzVpHlUQmk
         kkAPNm6inaI9piOOo8Q5vlOAZZQWrB2pd0YL9AGyVG86yFSm5rw2NX1HaUX33cgk6xLg
         ctVod4+uQylxq/HQt3qYykO77N/MoDgqi0N1UwhImWo4h8yt9Fc4DikHwjTuQD0qe4Gh
         PdP4/SZZYoN39H0A4O5ZnW5o3IzwC6lpBMEiPzgPW9sAzEnDY9zI2XILgH8Oyc/qYsMF
         uXFPZtm0+UUZAQzDFtQI09kNin2m4EjhN6daW8Y1amxZheoOg6Iw727UYJXx4/74ViHT
         915g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:x-gm-message-state;
        bh=g3QaeieCpDYQ5SlLrA1T3LBfoKejGK8upHw1ptTZ5mQ=;
        b=P5uldY7aIDPvauyPzmfZRjOe7oo4IRn5RHbebWs7St2LCdf4Afv0bbYfybpeuIziLV
         9tmlDVkRg5L4P6ME8VqNeJCduX49McGyGHNMK3OPd9HdSLNOngiGbBrSqYw7N+1n9ROY
         gtZ2rkq3ynTTr4OK/Uv5Z5mG/A8XHyDZTKfc/jiLwlrpqIh8qws90Waud9zxxdzwReth
         CNgLkuYapDwE4IUIykdfKtbrnEepuVryVuVXz5qjGS06dgWvU/cCC9MhavueaL0omQwV
         pcEPLviBFiHCc7Myi8yUqsgcMXlQxLzCd2f3FdT/86R8Uaoj6GOuj/ZXlYfAIr6t9XDq
         65SA==
Received: by 10.14.221.194 with SMTP id r42mr6739129eep.25.1351863122611;
        Fri, 02 Nov 2012 06:32:02 -0700 (PDT)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:984c:bba:1cf6:38eb])
        by mx.google.com with ESMTPS id 42sm23090115eee.0.2012.11.02.06.32.00
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 06:32:01 -0700 (PDT)
From:   Michal Nazarewicz <mpn@google.com>
To:     Felipe Balbi <balbi@ti.com>
Cc:     linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Michal Nazarewicz <mina86@mina86.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mike Frysinger <vapier@gentoo.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Subject: [PATCHv2 1/6] arch: Change defconfigs to point to g_mass_storage.
Date:   Fri,  2 Nov 2012 14:31:50 +0100
Message-Id: <46dde680f525562e9fd19567deb5247f0bf26842.1351715302.v2.git.mina86@mina86.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <cover.1351715302.v2.git.mina86@mina86.com>
References: <cover.1351715302.v2.git.mina86@mina86.com>
In-Reply-To: <cover.1351715302.v2.git.mina86@mina86.com>
References: <cover.1351715302.v2.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQnEya+W9O/wPizeMSRiln00jWm/KjIStwEeU+P33utSKPHwSQVJEeoyyO/+Lyixhq6InuGOCJT3ghHVAnW0ZghRcM1uFbP0+tZY1QMQ51rWViPVNKA+TMjdl23dUgLiOfZMtjO93Ko8hJHpslQaYw0TIVo2cKM8jAeEUZ+w2dgDd1DEjQ4rEU2RXW+csrXMHPawo4tMnHDeerm6WDLt977vtvbKVA==
X-archive-position: 34854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpn@google.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Michal Nazarewicz <mina86@mina86.com>

The File-backed Storage Gadget (g_file_storage) is being removed, since
it has been replaced by Mass Storage Gadget (g_mass_storage).  This commit
changes defconfigs point to the new gadget.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 arch/arm/configs/afeb9260_defconfig                |    2 +-
 arch/arm/configs/at91sam9260_defconfig             |    2 +-
 arch/arm/configs/at91sam9261_defconfig             |    2 +-
 arch/arm/configs/at91sam9263_defconfig             |    2 +-
 arch/arm/configs/at91sam9g20_defconfig             |    2 +-
 arch/arm/configs/corgi_defconfig                   |    2 +-
 arch/arm/configs/davinci_all_defconfig             |    2 +-
 arch/arm/configs/h7202_defconfig                   |    3 +--
 arch/arm/configs/magician_defconfig                |    2 +-
 arch/arm/configs/mini2440_defconfig                |    2 +-
 arch/arm/configs/omap1_defconfig                   |    3 +--
 arch/arm/configs/prima2_defconfig                  |    1 -
 arch/arm/configs/spitz_defconfig                   |    2 +-
 arch/arm/configs/stamp9g20_defconfig               |    2 +-
 arch/arm/configs/viper_defconfig                   |    2 +-
 arch/arm/configs/zeus_defconfig                    |    2 +-
 arch/avr32/configs/atngw100_defconfig              |    2 +-
 arch/avr32/configs/atngw100_evklcd100_defconfig    |    2 +-
 arch/avr32/configs/atngw100_evklcd101_defconfig    |    2 +-
 arch/avr32/configs/atngw100_mrmt_defconfig         |    2 +-
 arch/avr32/configs/atngw100mkii_defconfig          |    2 +-
 .../avr32/configs/atngw100mkii_evklcd100_defconfig |    2 +-
 .../avr32/configs/atngw100mkii_evklcd101_defconfig |    2 +-
 arch/avr32/configs/atstk1002_defconfig             |    2 +-
 arch/avr32/configs/atstk1003_defconfig             |    2 +-
 arch/avr32/configs/atstk1004_defconfig             |    2 +-
 arch/avr32/configs/atstk1006_defconfig             |    2 +-
 arch/avr32/configs/favr-32_defconfig               |    2 +-
 arch/avr32/configs/hammerhead_defconfig            |    2 +-
 arch/blackfin/configs/CM-BF527_defconfig           |    2 +-
 arch/blackfin/configs/CM-BF548_defconfig           |    2 +-
 arch/blackfin/configs/CM-BF561_defconfig           |    2 +-
 arch/mips/configs/bcm47xx_defconfig                |    2 +-
 arch/mips/configs/mtx1_defconfig                   |    2 +-
 arch/sh/configs/ecovec24_defconfig                 |    2 +-
 arch/sh/configs/se7724_defconfig                   |    2 +-
 37 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/arch/arm/configs/afeb9260_defconfig b/arch/arm/configs/afeb9260_defconfig
index c285a9d..a8dbc1e 100644
--- a/arch/arm/configs/afeb9260_defconfig
+++ b/arch/arm/configs/afeb9260_defconfig
@@ -79,7 +79,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DEBUG=y
diff --git a/arch/arm/configs/at91sam9260_defconfig b/arch/arm/configs/at91sam9260_defconfig
index 505b376..0ea5d2c 100644
--- a/arch/arm/configs/at91sam9260_defconfig
+++ b/arch/arm/configs/at91sam9260_defconfig
@@ -75,7 +75,7 @@ CONFIG_USB_STORAGE_DEBUG=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AT91SAM9=y
diff --git a/arch/arm/configs/at91sam9261_defconfig b/arch/arm/configs/at91sam9261_defconfig
index 1e8712e..c87beb9 100644
--- a/arch/arm/configs/at91sam9261_defconfig
+++ b/arch/arm/configs/at91sam9261_defconfig
@@ -125,7 +125,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_ATMELMCI=m
diff --git a/arch/arm/configs/at91sam9263_defconfig b/arch/arm/configs/at91sam9263_defconfig
index d2050ca..c5212f4 100644
--- a/arch/arm/configs/at91sam9263_defconfig
+++ b/arch/arm/configs/at91sam9263_defconfig
@@ -133,7 +133,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_SDIO_UART=m
diff --git a/arch/arm/configs/at91sam9g20_defconfig b/arch/arm/configs/at91sam9g20_defconfig
index e1b0e80..3b18810 100644
--- a/arch/arm/configs/at91sam9g20_defconfig
+++ b/arch/arm/configs/at91sam9g20_defconfig
@@ -96,7 +96,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_ATMELMCI=m
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 4b8a25d..1fd1d1d 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -218,7 +218,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_PXA=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 67b5abb6..4ea7c95 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -144,7 +144,7 @@ CONFIG_USB_GADGET_DEBUG_FS=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_USB_CDC_COMPOSITE=m
diff --git a/arch/arm/configs/h7202_defconfig b/arch/arm/configs/h7202_defconfig
index 69405a7..e16d3f3 100644
--- a/arch/arm/configs/h7202_defconfig
+++ b/arch/arm/configs/h7202_defconfig
@@ -34,8 +34,7 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_USB_GADGET=m
 CONFIG_USB_ZERO=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
-CONFIG_USB_FILE_STORAGE_TEST=y
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_EXT2_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index a691ef4..557dd29 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -136,7 +136,7 @@ CONFIG_USB_PXA27X=y
 CONFIG_USB_ETH=m
 # CONFIG_USB_ETH_RNDIS is not set
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_USB_GPIO_VBUS=y
diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 00630e6..a07948a 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -240,7 +240,7 @@ CONFIG_USB_GADGET_S3C2410=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index dde2a1a..42eab9a 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -214,8 +214,7 @@ CONFIG_USB_TEST=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
 # CONFIG_USB_ETH_RNDIS is not set
-CONFIG_USB_FILE_STORAGE=m
-CONFIG_USB_FILE_STORAGE_TEST=y
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index 807d4e2..6a936c7 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -37,7 +37,6 @@ CONFIG_SPI_SIRF=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
 CONFIG_USB_GADGET=y
-CONFIG_USB_FILE_STORAGE=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index df77931..2e0419d 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -214,7 +214,7 @@ CONFIG_USB_GADGET_DUMMY_HCD=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_PXA=y
diff --git a/arch/arm/configs/stamp9g20_defconfig b/arch/arm/configs/stamp9g20_defconfig
index 52f1488..b845f55 100644
--- a/arch/arm/configs/stamp9g20_defconfig
+++ b/arch/arm/configs/stamp9g20_defconfig
@@ -97,7 +97,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=m
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_ATMELMCI=y
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 1d01ddd..d36e0d3 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -139,7 +139,7 @@ CONFIG_USB_SERIAL_MCT_U232=m
 CONFIG_USB_GADGET=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_RTC_CLASS=y
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index 547a3c1..731d4f9 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -143,7 +143,7 @@ CONFIG_USB_GADGET=m
 CONFIG_USB_PXA27X=y
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atngw100_defconfig b/arch/avr32/configs/atngw100_defconfig
index a06bfcc..f4025db 100644
--- a/arch/avr32/configs/atngw100_defconfig
+++ b/arch/avr32/configs/atngw100_defconfig
@@ -109,7 +109,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=350
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atngw100_evklcd100_defconfig b/arch/avr32/configs/atngw100_evklcd100_defconfig
index d8f1fe8..c76a49b 100644
--- a/arch/avr32/configs/atngw100_evklcd100_defconfig
+++ b/arch/avr32/configs/atngw100_evklcd100_defconfig
@@ -125,7 +125,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=350
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atngw100_evklcd101_defconfig b/arch/avr32/configs/atngw100_evklcd101_defconfig
index d4c5b19..2d8ab08 100644
--- a/arch/avr32/configs/atngw100_evklcd101_defconfig
+++ b/arch/avr32/configs/atngw100_evklcd101_defconfig
@@ -124,7 +124,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=350
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atngw100_mrmt_defconfig b/arch/avr32/configs/atngw100_mrmt_defconfig
index 77ca4f9..b189e0c 100644
--- a/arch/avr32/configs/atngw100_mrmt_defconfig
+++ b/arch/avr32/configs/atngw100_mrmt_defconfig
@@ -99,7 +99,7 @@ CONFIG_SND_ATMEL_AC97C=m
 # CONFIG_SND_SPI is not set
 CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_DEBUG_FILES=y
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_ATMELMCI=y
diff --git a/arch/avr32/configs/atngw100mkii_defconfig b/arch/avr32/configs/atngw100mkii_defconfig
index 6e0dca4..2e4de42 100644
--- a/arch/avr32/configs/atngw100mkii_defconfig
+++ b/arch/avr32/configs/atngw100mkii_defconfig
@@ -111,7 +111,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=350
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atngw100mkii_evklcd100_defconfig b/arch/avr32/configs/atngw100mkii_evklcd100_defconfig
index 7f2a344..fad3cd2 100644
--- a/arch/avr32/configs/atngw100mkii_evklcd100_defconfig
+++ b/arch/avr32/configs/atngw100mkii_evklcd100_defconfig
@@ -128,7 +128,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=350
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atngw100mkii_evklcd101_defconfig b/arch/avr32/configs/atngw100mkii_evklcd101_defconfig
index 085eeba..2998623 100644
--- a/arch/avr32/configs/atngw100mkii_evklcd101_defconfig
+++ b/arch/avr32/configs/atngw100mkii_evklcd101_defconfig
@@ -127,7 +127,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=350
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atstk1002_defconfig b/arch/avr32/configs/atstk1002_defconfig
index d1a887e..a582465 100644
--- a/arch/avr32/configs/atstk1002_defconfig
+++ b/arch/avr32/configs/atstk1002_defconfig
@@ -126,7 +126,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atstk1003_defconfig b/arch/avr32/configs/atstk1003_defconfig
index 956f281..57a79df 100644
--- a/arch/avr32/configs/atstk1003_defconfig
+++ b/arch/avr32/configs/atstk1003_defconfig
@@ -105,7 +105,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atstk1004_defconfig b/arch/avr32/configs/atstk1004_defconfig
index 40c69f3..1a49bd8 100644
--- a/arch/avr32/configs/atstk1004_defconfig
+++ b/arch/avr32/configs/atstk1004_defconfig
@@ -104,7 +104,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/atstk1006_defconfig b/arch/avr32/configs/atstk1006_defconfig
index 511eb8a..206a1b6 100644
--- a/arch/avr32/configs/atstk1006_defconfig
+++ b/arch/avr32/configs/atstk1006_defconfig
@@ -129,7 +129,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/favr-32_defconfig b/arch/avr32/configs/favr-32_defconfig
index 19973b0..0421498 100644
--- a/arch/avr32/configs/favr-32_defconfig
+++ b/arch/avr32/configs/favr-32_defconfig
@@ -117,7 +117,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/avr32/configs/hammerhead_defconfig b/arch/avr32/configs/hammerhead_defconfig
index 6f45681..82f24eb 100644
--- a/arch/avr32/configs/hammerhead_defconfig
+++ b/arch/avr32/configs/hammerhead_defconfig
@@ -127,7 +127,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=m
 CONFIG_MMC_ATMELMCI=m
diff --git a/arch/blackfin/configs/CM-BF527_defconfig b/arch/blackfin/configs/CM-BF527_defconfig
index c280a50..f59c80e 100644
--- a/arch/blackfin/configs/CM-BF527_defconfig
+++ b/arch/blackfin/configs/CM-BF527_defconfig
@@ -106,7 +106,7 @@ CONFIG_MUSB_PIO_ONLY=y
 CONFIG_USB_STORAGE=m
 CONFIG_USB_GADGET=m
 CONFIG_USB_ETH=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_RTC_CLASS=y
diff --git a/arch/blackfin/configs/CM-BF548_defconfig b/arch/blackfin/configs/CM-BF548_defconfig
index 349922b..e961483 100644
--- a/arch/blackfin/configs/CM-BF548_defconfig
+++ b/arch/blackfin/configs/CM-BF548_defconfig
@@ -107,7 +107,7 @@ CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 # CONFIG_USB_ETH_RNDIS is not set
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_MMC=m
diff --git a/arch/blackfin/configs/CM-BF561_defconfig b/arch/blackfin/configs/CM-BF561_defconfig
index 0456dea..24936b9 100644
--- a/arch/blackfin/configs/CM-BF561_defconfig
+++ b/arch/blackfin/configs/CM-BF561_defconfig
@@ -83,7 +83,7 @@ CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_USB_GADGET=m
 CONFIG_USB_ETH=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_MMC=y
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index b6fde2b..4ca8e5c 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -473,7 +473,7 @@ CONFIG_USB_GADGET_NET2280=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_MIDI_GADGET=m
 CONFIG_LEDS_CLASS=y
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 46c61edc..a0277d4 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -661,7 +661,7 @@ CONFIG_USB_GADGET_NET2280=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_MIDI_GADGET=m
 CONFIG_MMC=m
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 911e30c9..c6c2bec 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -112,7 +112,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SDHI=y
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index ed35093..1faa788 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -109,7 +109,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
-- 
1.7.7.3
