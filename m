Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 10:08:24 +0100 (CET)
Received: from mail-ee0-f45.google.com ([74.125.83.45]:43239 "EHLO
        mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815989AbaCUJIV502Of (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2014 10:08:21 +0100
Received: by mail-ee0-f45.google.com with SMTP id d17so1560360eek.4
        for <multiple recipients>; Fri, 21 Mar 2014 02:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=56CDS9tx36kGzrhm1qIhJzF6aROylnT6BnK/djkqdkI=;
        b=Pue3Qo96eXR47RrsZ9jO8dTK1mtwVhbKLYne0xCEyCp2S+72N19dXmdC5A2JjcGiqy
         WxcWbkrLFSc5rbjckyoHpu4kqKhGh01FF0OQ9UK7kUbt34Ksi6XJYNqldISfSCy98ml8
         lz1JLIvHsihKPAsK0YmXN07q8jjgcItQmRtcCQvhEsxQ14zsa9Xo2OruWghnTl1v66Wd
         nPsLb4NgPxwRXgozn+n55dHylE4lTi/WW9nUbvQFB6kAvGw38VNniFtwtE1e92+eySb4
         0oxlYSk5B21sdjGOlefiJgk1HZi1l6f/teHWwjSIPULOMAUsAjqOjPm+VdDiwPVk8n34
         UlFw==
X-Received: by 10.15.54.70 with SMTP id s46mr14360398eew.83.1395392896555;
        Fri, 21 Mar 2014 02:08:16 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id u1sm10240532eex.31.2014.03.21.02.08.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Mar 2014 02:08:15 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V3] MIPS: BCM47XX: Add new file for device specific workarounds
Date:   Fri, 21 Mar 2014 10:08:08 +0100
Message-Id: <1395392888-29945-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1391286733-14333-1-git-send-email-zajec5@gmail.com>
References: <1391286733-14333-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39523
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

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
V2: Drop pr_debug for devices we don't need workarounds for. It was too
    load and not useful at all.
V3: Use gpio_request_one in WNR3500L workaround. In V2 we were directly
    calling gpio_set_value, which doesn't guarantee GPIO to be in OUT
    direction.

Hauke: does V3 still get your ack?
---
 arch/mips/bcm47xx/Makefile          |  2 +-
 arch/mips/bcm47xx/bcm47xx_private.h |  3 +++
 arch/mips/bcm47xx/setup.c           |  1 +
 arch/mips/bcm47xx/workarounds.c     | 31 +++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)
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
index b847d03..63a4b0e 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -282,6 +282,7 @@ static int __init bcm47xx_register_bus_complete(void)
 	}
 	bcm47xx_buttons_register();
 	bcm47xx_leds_register();
+	bcm47xx_workarounds();
 
 	fixed_phy_add(PHY_POLL, 0, &bcm47xx_fixed_phy_status);
 	return 0;
diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
new file mode 100644
index 0000000..e81ce46
--- /dev/null
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -0,0 +1,31 @@
+#include "bcm47xx_private.h"
+
+#include <linux/gpio.h>
+#include <bcm47xx_board.h>
+#include <bcm47xx.h>
+
+static void __init bcm47xx_workarounds_netgear_wnr3500l(void)
+{
+	const int usb_power = 12;
+	int err;
+
+	err = gpio_request_one(usb_power, GPIOF_OUT_INIT_HIGH, "usb_power");
+	if (err)
+		pr_err("Failed to request USB power gpio: %d\n", err);
+	else
+		gpio_free(usb_power);
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
