Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 07:30:10 +0100 (CET)
Received: from mail-ea0-f170.google.com ([209.85.215.170]:63829 "EHLO
        mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820116Ab3KGGaCItBx4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Nov 2013 07:30:02 +0100
Received: by mail-ea0-f170.google.com with SMTP id q10so43712eaj.1
        for <linux-mips@linux-mips.org>; Wed, 06 Nov 2013 22:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W+WNUNDq6sKX6uv4zHoyvqz7sWLEun9P6msFlD8G+yc=;
        b=owt9XMPdNbOBZwp3EQlNiWHRQTM7hM0DUHvrXcgOn7ZwA2cHjcZXY3/Ks8iy2x2Grk
         fR4GkVbLZX7RKYpj9nZRLXT5A9kXgjiDfWs6kBpKbRrzTvnX4idgdWsrWzEhBKFhtwPl
         jiz0EyjCroClfwFDsRi1FoUGU7GA8JcxwXy01ITESkLUoI3BQYi9rG7HtDMHlz4Nskwf
         3hQjNKXfcTkwQxgF3B3a2KHghM+HFgB4BhKJf/VmeQy1yp3QHZ5Frr7YwnzaWkmgp87A
         D9k0qHqsw14Bbd2VsNPu/2ZvM5BOtKlxHWVqpdsiMJdPvmnB8Wi063Uq1gAPsMEZrA2I
         O3NQ==
X-Received: by 10.15.83.9 with SMTP id b9mr7474319eez.34.1383805796690;
        Wed, 06 Nov 2013 22:29:56 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id i1sm5150586eeg.0.2013.11.06.22.29.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2013 22:29:56 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V4] MIPS: BCM47XX: Prepare support for LEDs
Date:   Thu,  7 Nov 2013 07:29:50 +0100
Message-Id: <1383805790-16196-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1383772274-12571-1-git-send-email-zajec5@gmail.com>
References: <1383772274-12571-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38469
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
index 2b8b118..09fc922 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -11,6 +11,7 @@ config BCM47XX_SSB
 	select SSB_PCICORE_HOSTMODE if PCI
 	select SSB_DRIVER_GPIO
 	select GPIOLIB
+	select LEDS_GPIO_REGISTER
 	default y
 	help
 	 Add support for old Broadcom BCM47xx boards with Sonics Silicon Backplane support.
@@ -27,6 +28,7 @@ config BCM47XX_BCMA
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
index 1f30571..7e61c0b 100644
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
@@ -239,6 +241,9 @@ static int __init bcm47xx_register_bus_complete(void)
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
