Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2013 22:11:29 +0100 (CET)
Received: from mail-ee0-f48.google.com ([74.125.83.48]:38206 "EHLO
        mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816841Ab3KFVL1Wa7h0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Nov 2013 22:11:27 +0100
Received: by mail-ee0-f48.google.com with SMTP id d49so31688eek.35
        for <linux-mips@linux-mips.org>; Wed, 06 Nov 2013 13:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oUbdnmm49C6/r6GgvojzONQ2fJQAqbn3+qhJkMO66h4=;
        b=uQCzI0WKCyFYI3egsOZPmOmeHi6TbcU9WVDN3abOUEfWezO3Xg2xAkjNWPMjp+UY7W
         BmnczgOy93QQsNFQL7j60as7e7cuq/jh9ZWXYlhljJjnXbN6iCJmE5TY32bEPLH/rzsQ
         stnSnDBZp/hdvlBjY29XlghplSahGrzaJHdzFE+Fsuf8a0Q6o9TSP0pEmPNIYUGw7LMU
         Ja6nCV6ljablx5T2+Pm+XrWSpgtKFC4Os6HnkB1/BnM8SJ64dtqR0C1vJ4C61iBtyOs5
         8f3CpxTE1S/AwZUnKXlskpRFEJVjwLuh+rJgpwRXPOqLZFT9b/6g3EFZvXCwRiIn6Bow
         XwIQ==
X-Received: by 10.14.53.69 with SMTP id f45mr234988eec.118.1383772282060;
        Wed, 06 Nov 2013 13:11:22 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id 8sm277203eem.15.2013.11.06.13.11.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2013 13:11:21 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V3] MIPS: BCM47XX: Prepare support for LEDs
Date:   Wed,  6 Nov 2013 22:11:14 +0100
Message-Id: <1383772274-12571-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1383771746-31119-1-git-send-email-zajec5@gmail.com>
References: <1383771746-31119-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38466
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

So far this is mostly just a proof of concept, database consists of a
single device. Creating a nice iterateable array wasn't an option
because devices have different amount of LEDs. And we don't want to
waste memory just because of support for a device with dozens on LEDs.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
V2: use bcm47xx_private.h instead of ugly define in setup.c
V3: don't add #include <bcm47xx_data.h> in setup.c. No need to.
---
 arch/mips/bcm47xx/Kconfig           |    2 +
 arch/mips/bcm47xx/Makefile          |    2 +-
 arch/mips/bcm47xx/bcm47xx_private.h |    9 +++++
 arch/mips/bcm47xx/leds.c            |   73 +++++++++++++++++++++++++++++++++++
 arch/mips/bcm47xx/setup.c           |    5 +++
 5 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm47xx/bcm47xx_private.h
 create mode 100644 arch/mips/bcm47xx/leds.c

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index ba61192..81a3d28 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -12,6 +12,7 @@ config BCM47XX_SSB
 	select SSB_PCICORE_HOSTMODE if PCI
 	select SSB_DRIVER_GPIO
 	select GPIOLIB
+	select LEDS_GPIO_REGISTER
 	default y
 	help
 	 Add support for old Broadcom BCM47xx boards with Sonics Silicon Backplane support.
@@ -28,6 +29,7 @@ config BCM47XX_BCMA
 	select BCMA_DRIVER_PCI_HOSTMODE if PCI
 	select BCMA_DRIVER_GPIO
 	select GPIOLIB
+	select LEDS_GPIO_REGISTER
 	default y
 	help
 	 Add support for new Broadcom BCM47xx boards with Broadcom specific Advanced Microcontroller Bus.
diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 571c15e..8d4a66c 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -4,6 +4,6 @@
 #
 
 obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
-obj-y				+= board.o
+obj-y				+= board.o leds.o
 obj-y				+= gpio.o
 obj-y				+= cfe_env.o
diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
new file mode 100644
index 0000000..1a1e600
--- /dev/null
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -0,0 +1,9 @@
+#ifndef LINUX_BCM47XX_PRIVATE_H_
+#define LINUX_BCM47XX_PRIVATE_H_
+
+#include <linux/kernel.h>
+
+/* leds.c */
+void __init bcm47xx_leds_register(void);
+
+#endif
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
new file mode 100644
index 0000000..6a49d4c
--- /dev/null
+++ b/arch/mips/bcm47xx/leds.c
@@ -0,0 +1,73 @@
+#include "bcm47xx_private.h"
+
+#include <linux/leds.h>
+#include <bcm47xx_board.h>
+
+static const struct gpio_led
+bcm47xx_leds_netgear_wndr4500_v1_leds[] __initconst = {
+	{
+		.name		= "bcm47xx:green:wps",
+		.gpio		= 1,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
+	},
+	{
+		.name		= "bcm47xx:green:power",
+		.gpio		= 2,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
+	},
+	{
+		.name		= "bcm47xx:orange:power",
+		.gpio		= 3,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
+	},
+	{
+		.name		= "bcm47xx:green:usb1",
+		.gpio		= 8,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
+	},
+	{
+		.name		= "bcm47xx:green:2ghz",
+		.gpio		= 9,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
+	},
+	{
+		.name		= "bcm47xx:blue:5ghz",
+		.gpio		= 11,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
+	},
+	{
+		.name		= "bcm47xx:green:usb2",
+		.gpio		= 14,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
+	},
+};
+
+static struct gpio_led_platform_data bcm47xx_leds_pdata;
+
+#define bcm47xx_set_pdata(dev_leds) do {				\
+	bcm47xx_leds_pdata.leds = dev_leds;				\
+	bcm47xx_leds_pdata.num_leds = ARRAY_SIZE(dev_leds);		\
+} while (0)
+
+void __init bcm47xx_leds_register(void)
+{
+	enum bcm47xx_board board = bcm47xx_board_get();
+
+	switch (board) {
+	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
+		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr4500_v1_leds);
+		break;
+	default:
+		pr_debug("No LEDs configuration found for this device\n");
+		return;
+	}
+
+	gpio_led_register_device(-1, &bcm47xx_leds_pdata);
+}
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 4b1e229..5291bda 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -26,6 +26,8 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include "bcm47xx_private.h"
+
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/ssb/ssb.h>
@@ -272,6 +274,9 @@ static int __init bcm47xx_register_bus_complete(void)
 		break;
 #endif
 	}
+
+	bcm47xx_leds_register();
+
 	return 0;
 }
 device_initcall(bcm47xx_register_bus_complete);
-- 
1.7.10.4
