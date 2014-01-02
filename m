Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 13:27:38 +0100 (CET)
Received: from mail-ea0-f181.google.com ([209.85.215.181]:51518 "EHLO
        mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824805AbaABM1eBbIKt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 13:27:34 +0100
Received: by mail-ea0-f181.google.com with SMTP id m10so6192145eaj.26
        for <multiple recipients>; Thu, 02 Jan 2014 04:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4X90g1XbESGqR5TlPVmSeX5I2nEw8eBK2tljdiOJdsc=;
        b=G0ua4nL7vCtiQ936g463ffxWVVhGn2tUwH0Uw2fUxKDlN2wVVxzUNOiCpGPj2sSBy1
         mnrUhC3SpsThV0qlIpRC16QjVKJ5FyDL46yYlORPLT9Pg8cL7pp3gQHPGQcxWOSSQg6E
         2DSvs3kI+pHSVQ5t6qLD+HTxWyzn0pGrSWosb2w07h/4g7WGALM9jBmz/irwXEcvNbt6
         Lv5cyF1Qh/DWwIuIN/1EFD7SON6OC17TRci4Dk61NEP9f9XqCIl2VpJ9FHOJMaukl9eP
         FukQnmI8XeCo2kpmEGnljN8sFdByf6lCOhCqpXRpMI/1cWmxO3r6UyFcR5qdIGUo6NB/
         06og==
X-Received: by 10.14.210.200 with SMTP id u48mr15139785eeo.63.1388665648677;
        Thu, 02 Jan 2014 04:27:28 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id o1sm135634210eea.10.2014.01.02.04.27.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2014 04:27:27 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V4 REBASED] MIPS: BCM47XX: Prepare support for LEDs
Date:   Thu,  2 Jan 2014 13:27:15 +0100
Message-Id: <1388665635-12771-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1383805790-16196-1-git-send-email-zajec5@gmail.com>
References: <1383805790-16196-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38832
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
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
V2: use bcm47xx_private.h instead of ugly define in setup.c
V3: don't add #include <bcm47xx_data.h> in setup.c. No need to.
V4: rebase on top of upstream-sfr. I pray this to be the correct one
REBASED on top of linux-john.git mips-next-3.14
---
 arch/mips/bcm47xx/Kconfig           |    2 +
 arch/mips/bcm47xx/Makefile          |    2 +-
 arch/mips/bcm47xx/bcm47xx_private.h |    9 +++++
 arch/mips/bcm47xx/leds.c            |   73 +++++++++++++++++++++++++++++++++++
 arch/mips/bcm47xx/setup.c           |    6 +++
 5 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm47xx/bcm47xx_private.h
 create mode 100644 arch/mips/bcm47xx/leds.c

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index df549af..09cb6f7 100644
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
@@ -29,6 +30,7 @@ config BCM47XX_BCMA
 	select BCMA_DRIVER_PCI_HOSTMODE if PCI
 	select BCMA_DRIVER_GPIO
 	select GPIOLIB
+	select LEDS_GPIO_REGISTER
 	default y
 	help
 	 Add support for new Broadcom BCM47xx boards with Broadcom specific Advanced Microcontroller Bus.
diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index c52daf9..84e9aed 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -4,5 +4,5 @@
 #
 
 obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
-obj-y				+= board.o
+obj-y				+= board.o leds.o
 obj-$(CONFIG_BCM47XX_SSB)	+= wgt634u.o
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
index d0bfc86..bd84473 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -26,6 +26,8 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include "bcm47xx_private.h"
+
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/ethtool.h>
@@ -262,7 +264,11 @@ static int __init bcm47xx_register_bus_complete(void)
 		break;
 #endif
 	}
+
+	bcm47xx_leds_register();
+
 	fixed_phy_add(PHY_POLL, 0, &bcm47xx_fixed_phy_status);
+
 	return 0;
 }
 device_initcall(bcm47xx_register_bus_complete);
-- 
1.7.10.4
