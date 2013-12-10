Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2013 16:24:45 +0100 (CET)
Received: from mail-ea0-f179.google.com ([209.85.215.179]:41457 "EHLO
        mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823017Ab3LJPYnF-Jma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Dec 2013 16:24:43 +0100
Received: by mail-ea0-f179.google.com with SMTP id r15so2328865ead.10
        for <multiple recipients>; Tue, 10 Dec 2013 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YKJd5s04BjrZCBT1Ddo/q2DYsws1qwOU8VtmYaUXdV8=;
        b=oF/9ZV8gydw6mWXZPT4byGV87dTB387Z4rqPTW4lOABuY1geRyD9dbuSMKDfUJVw2l
         IvtVrJd/riMIM5fqoiOGQSZPnexzgvMi6UBQsoSaXxK2pJDJ7Z3GKWfr6W6IuR9QIgJb
         lLuU1jrJ8HKLebH2x0orGD+zF0vsGUpUd9YtnEuMEh56e/+AWTJSc3xnnlINWjfs7bdI
         5ARj5FOwAjtV2IhKn0mzHNJllQ/61lqbFZiRETEvQUd8OnK1sfhr1AYJWf2443GKIXhM
         RUn+0j7M0voNTYsHP3/TXZWEbHPwAtTSa7yzJktIqRFlstH/N39nomkj1tnTaBpIKz+K
         uPcA==
X-Received: by 10.14.175.131 with SMTP id z3mr8362168eel.65.1386689077743;
        Tue, 10 Dec 2013 07:24:37 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id e43sm42368747eep.7.2013.12.10.07.24.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2013 07:24:36 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V3 2/2] MIPS: BCM47XX: Prepare support for GPIO buttons
Date:   Tue, 10 Dec 2013 16:24:31 +0100
Message-Id: <1386689071-13170-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1385741397-32740-2-git-send-email-zajec5@gmail.com>
References: <1385741397-32740-2-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38691
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

So far this adds support for one Netgear model only, but it's designed
and ready to add many more device. We could hopefully import database
from OpenWrt.
Support for SSB is currently disabled, because SSB doesn't implement IRQ
domain yet.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
V3: Use __initconst and copy data for detected device. This will allow
    us to free some memory after init.
---
 arch/mips/bcm47xx/Makefile          |    2 +-
 arch/mips/bcm47xx/bcm47xx_private.h |    3 ++
 arch/mips/bcm47xx/buttons.c         |   95 +++++++++++++++++++++++++++++++++++
 arch/mips/bcm47xx/setup.c           |    1 +
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm47xx/buttons.c

diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 84e9aed..006a05e 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -4,5 +4,5 @@
 #
 
 obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
-obj-y				+= board.o leds.o
+obj-y				+= board.o buttons.o leds.o
 obj-$(CONFIG_BCM47XX_SSB)	+= wgt634u.o
diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index 1a1e600..5c94ace 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -3,6 +3,9 @@
 
 #include <linux/kernel.h>
 
+/* buttons.c */
+int __init bcm47xx_buttons_register(void);
+
 /* leds.c */
 void __init bcm47xx_leds_register(void);
 
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
new file mode 100644
index 0000000..3138f03
--- /dev/null
+++ b/arch/mips/bcm47xx/buttons.c
@@ -0,0 +1,95 @@
+#include "bcm47xx_private.h"
+
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/interrupt.h>
+#include <linux/ssb/ssb_embedded.h>
+#include <bcm47xx_board.h>
+#include <bcm47xx.h>
+
+/**************************************************
+ * Database
+ **************************************************/
+
+static struct gpio_keys_button
+bcm47xx_buttons_netgear_wndr4500_v1[] __initconst = {
+	{
+		.code		= KEY_WPS_BUTTON,
+		.gpio		= 4,
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_RFKILL,
+		.gpio		= 5,
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_RESTART,
+		.gpio		= 6,
+		.active_low	= 1,
+	},
+};
+
+/**************************************************
+ * Init
+ **************************************************/
+
+static struct gpio_keys_platform_data bcm47xx_button_pdata;
+
+static struct platform_device bcm47xx_buttons_gpio_keys = {
+	.name = "gpio-keys",
+	.dev = {
+		.platform_data = &bcm47xx_button_pdata,
+	}
+};
+
+/* Copy data from __initconst */
+static int __init bcm47xx_buttons_copy(struct gpio_keys_button *buttons,
+					size_t nbuttons)
+{
+	size_t size = nbuttons * sizeof(*buttons);
+
+	bcm47xx_button_pdata.buttons = kmalloc(size, GFP_KERNEL);
+	if (!bcm47xx_button_pdata.buttons)
+		return -ENOMEM;
+	memcpy(bcm47xx_button_pdata.buttons, buttons, size);
+	bcm47xx_button_pdata.nbuttons = nbuttons;
+
+	return 0;
+}
+
+#define bcm47xx_copy_bdata(dev_buttons)					\
+	bcm47xx_buttons_copy(dev_buttons, ARRAY_SIZE(dev_buttons));
+
+int __init bcm47xx_buttons_register(void)
+{
+	enum bcm47xx_board board = bcm47xx_board_get();
+	int err;
+
+#ifdef CONFIG_BCM47XX_SSB
+	if (bcm47xx_bus_type == BCM47XX_BUS_TYPE_SSB) {
+		pr_debug("Buttons on SSB are not supported yet.\n");
+		return -ENOTSUPP;
+	}
+#endif
+
+	switch (board) {
+	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500_v1);
+		break;
+	default:
+		pr_debug("No buttons configuration found for this device\n");
+		return -ENOTSUPP;
+	}
+
+	if (err)
+		return -ENOMEM;
+
+	err = platform_device_register(&bcm47xx_buttons_gpio_keys);
+	if (err) {
+		pr_err("Failed to register platform device: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 7e61c0b..a791124 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -242,6 +242,7 @@ static int __init bcm47xx_register_bus_complete(void)
 #endif
 	}
 
+	bcm47xx_buttons_register();
 	bcm47xx_leds_register();
 
 	return 0;
-- 
1.7.10.4
