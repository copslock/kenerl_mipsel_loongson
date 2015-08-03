Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 17:04:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35134 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011555AbbHCPEEgeTmv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 17:04:04 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t73F426J007824;
        Mon, 3 Aug 2015 17:04:02 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t73F41kS007823;
        Mon, 3 Aug 2015 17:04:02 +0200
Date:   Mon, 3 Aug 2015 17:04:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-leds@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v2] LED/MIPS: Move SEAD3 LED driver to where it belongs.
Message-ID: <20150803150401.GD2843@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Fixes the following randconfig problem

leds-sead3.c:(.text+0x7dc): undefined reference to `led_classdev_unregister'
leds-sead3.c:(.text+0x7e8): undefined reference to `led_classdev_unregister'

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-leds@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/mti-sead3/Makefile                       |  2 --
 drivers/leds/Kconfig                               | 10 ++++++++++
 drivers/leds/Makefile                              |  1 +
 {arch/mips/mti-sead3 => drivers/leds}/leds-sead3.c |  1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index 2e52cbd..7a584e0 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -12,6 +12,4 @@ obj-y				:= sead3-lcd.o sead3-display.o sead3-init.o \
 				   sead3-int.o sead3-platform.o sead3-reset.o \
 				   sead3-setup.o sead3-time.o
 
-obj-y				+= leds-sead3.o
-
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9ad35f7..531729c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -550,6 +550,16 @@ config LEDS_KTD2692
 
 	  Say Y to enable this driver.
 
+config LEDS_SEAD3
+	tristate "LED support for the MIPS SEAD 3 board"
+	depends on LEDS_CLASS && MIPS_SEAD3
+	help
+	  Say Y here to include support for the FLED and PLED LEDs on SEAD3 eval
+	  boards.
+
+	  This driver can also be built as a module. If so the module
+	  will be called leds-sead3.
+
 comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
 
 config LEDS_BLINKM
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 8d6a24a..a976161 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
 obj-$(CONFIG_LEDS_PM8941_WLED)		+= leds-pm8941-wled.o
 obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
+obj-$(CONFIG_LEDS_SEAD3)		+= leds-sead3.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/arch/mips/mti-sead3/leds-sead3.c b/drivers/leds/leds-sead3.c
similarity index 99%
rename from arch/mips/mti-sead3/leds-sead3.c
rename to drivers/leds/leds-sead3.c
index c938cee..eb97a32 100644
--- a/arch/mips/mti-sead3/leds-sead3.c
+++ b/drivers/leds/leds-sead3.c
@@ -59,6 +59,7 @@ static int sead3_led_remove(struct platform_device *pdev)
 {
 	led_classdev_unregister(&sead3_pled);
 	led_classdev_unregister(&sead3_fled);
+
 	return 0;
 }
 
