Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Feb 2014 21:33:46 +0100 (CET)
Received: from mail-ea0-f178.google.com ([209.85.215.178]:35180 "EHLO
        mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825491AbaBAUcpGtLHT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Feb 2014 21:32:45 +0100
Received: by mail-ea0-f178.google.com with SMTP id a15so3041014eae.9
        for <multiple recipients>; Sat, 01 Feb 2014 12:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=96ZAKPJfaPX5ClPzUMJ6djj51Ng6vHROqbOIk9TD41M=;
        b=nS7BUXwXWDNKesOAmqDfxo6EvkvUMGO6UKYr71BWy5YE+GmpYfzzSygwTA3kWBj+3B
         T0qfxU+fa8wRg7Hx0od9gn0BwM4h1O2ZEbJ7gLH/cGWQLV9HNtUSCDo1qFb91KWQndgX
         nNkQBHzKafoea5eHzHex2SaAEtlnacJSSPUiddi3SIYvuxICFH7w2+SrvHhsqCsbivM6
         th62bIuMZEftlJhHThqXlpFpN6pMx/ngC0U8Gm2hI32bGVSi9wxO9GmJjtY9kLAyYDWc
         OT8RWN7PmdyKkF1vMyeUTRkieNKGHgIxiVyRM4r1E8b3L1z82aEbKoZnfHEGfKvceNq2
         +jWQ==
X-Received: by 10.14.172.69 with SMTP id s45mr33453709eel.9.1391286743574;
        Sat, 01 Feb 2014 12:32:23 -0800 (PST)
Received: from linux-x91w.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id 8sm48034671eef.1.2014.02.01.12.32.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Feb 2014 12:32:22 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [RFC V2][PATCH] MIPS: BCM47XX: Add new file for device specific workarounds
Date:   Sat,  1 Feb 2014 21:32:13 +0100
Message-Id: <1391286733-14333-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39201
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

---
V2: Drop pr_debug for devices we don't need workarounds for. It was too
    load and not useful at all.
---
 arch/mips/bcm47xx/Makefile          |  2 +-
 arch/mips/bcm47xx/bcm47xx_private.h |  3 +++
 arch/mips/bcm47xx/setup.c           |  1 +
 arch/mips/bcm47xx/workarounds.c     | 25 +++++++++++++++++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm47xx/workarounds.c

diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 4688b6a..d58c51b 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
-obj-y				+= board.o buttons.o leds.o
+obj-y				+= board.o buttons.o leds.o workarounds.o
diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index 5c94ace..0194c3b 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -9,4 +9,7 @@ int __init bcm47xx_buttons_register(void);
 /* leds.c */
 void __init bcm47xx_leds_register(void);
 
+/* workarounds.c */
+void __init bcm47xx_workarounds(void);
+
 #endif
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 12d77e9..fdd9692 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -273,6 +273,7 @@ static int __init bcm47xx_register_bus_complete(void)
 	}
 	bcm47xx_buttons_register();
 	bcm47xx_leds_register();
+	bcm47xx_workarounds();
 
 	return 0;
 }
diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
new file mode 100644
index 0000000..24b850c
--- /dev/null
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -0,0 +1,25 @@
+#include "bcm47xx_private.h"
+
+#include <linux/gpio.h>
+#include <bcm47xx_board.h>
+#include <bcm47xx.h>
+
+static void __init bcm47xx_workarounds_netgear_wnr3500l(void)
+{
+	/* Set GPIO 12 to 1 to pass power to the USB port */
+	gpio_set_value(12, 1);
+}
+
+void __init bcm47xx_workarounds(void)
+{
+	enum bcm47xx_board board = bcm47xx_board_get();
+
+	switch (board) {
+	case BCM47XX_BOARD_NETGEAR_WNR3500L:
+		bcm47xx_workarounds_netgear_wnr3500l();
+		break;
+	default:
+		/* No workaround(s) needed */
+		break;
+	}
+}
-- 
1.8.4.5
