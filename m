Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2014 19:25:33 +0100 (CET)
Received: from mail-ea0-f170.google.com ([209.85.215.170]:54628 "EHLO
        mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827297AbaA2SZ1XhZdr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jan 2014 19:25:27 +0100
Received: by mail-ea0-f170.google.com with SMTP id k10so1124215eaj.15
        for <multiple recipients>; Wed, 29 Jan 2014 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SvoRbrVmp60ai1VQKsXe7mjLXEozwbgXAt1zi7GsHXM=;
        b=O0TRm3TPbaP/Xcs/ww72DL/jTnUENuV2lFTgcfBvK5AQgokDp1MuFIIY57pNvYFoEc
         2YViZLMW9RFP76dMeJvwX+0IAf/1ssV003YDZi++9Mfsn/vej6veUujk4n+RNJbWTh9i
         5gfrGMqz72Xu1iU2DQ1DAYjE0Xq8MzpyVuTZvvLKS8rxwWn6FCCVMmVdPOYl3wkfBRuH
         7Zws+S+rZCR2cg5/WTg7o5pC6kqTDi0iP1quwCgh8BeSjZy00CNE95kXixPTYTkvOjnn
         hVzWpWwuOc/SbNP06Zvu1FYDcv8WGODO3kn8v0zZ/4yQaedBpYDmcDxWTn87Io3+psTC
         GYEw==
X-Received: by 10.15.75.67 with SMTP id k43mr4810194eey.59.1391019921893;
        Wed, 29 Jan 2014 10:25:21 -0800 (PST)
Received: from linux-x91w.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id d43sm11992121eep.18.2014.01.29.10.25.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2014 10:25:21 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [RFC][PATCH] MIPS: BCM47XX: Add new file for device specific workarounds
Date:   Wed, 29 Jan 2014 19:25:12 +0100
Message-Id: <1391019912-27118-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39192
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
This can calmly wait for 3.15, just wanted to share it.
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
index 0000000..1644bfc
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
+
+	default:
+		pr_debug("No workarounds found (needed?) for this device\n");
+	}
+}
-- 
1.8.4.5
