Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:57:11 +0100 (CET)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47624 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013573AbaKLUyyM-r7H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:54 +0100
Received: by mail-pd0-f182.google.com with SMTP id fp1so13003858pdb.13
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TxPFmkGCCy8Z8JYpbUB7ODbj3L9r0Pn4EwtvWXhZ5bA=;
        b=xVUQQH74q3YRWs55m9+qi5UxC2eHMHpCNIJCjH7DBLVRoFIbRsJ2bzcBoSe5+VsGcS
         0WlNYWvJWce1V+Ti6DSn0SgBWHoCUGPrnWWIQHltk7Xm0znCXW7elR0fGFsgQAcobZkk
         Wp7r4w4L3N6EfHhjUvD1x+V4Y2fU/xryQ5aJ19rVVEuK4KbmlS7fdqrl7U5z5SrLmLic
         x6U7Acu3naWKyfNjI8nlR8XS9bRPFksTzt9mpK6fVX3z6TukLQPlCcugOlmN0rI9qh6N
         SonrnIbVd2hOxaQ57rVYgpD+L0iEk3TtfYPEoE8VD4MOVNevF2nVTW4pqb8Ffr5XtXe2
         YE4A==
X-Received: by 10.68.202.1 with SMTP id ke1mr50094352pbc.60.1415825688591;
        Wed, 12 Nov 2014 12:54:48 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:48 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 09/10] serial: earlycon: Set UPIO_MEM32BE based on DT properties
Date:   Wed, 12 Nov 2014 12:54:06 -0800
Message-Id: <1415825647-6024-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

If an earlycon (stdout-path) node is being used, check for "big-endian"
or "native-endian" properties and pass the appropriate iotype to the
driver.

Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
big-endian property only really makes sense in the context of 32-bit
registers, since 8-bit accesses never require data swapping.

At some point, the of_earlycon code may want to pass in the reg-io-width,
reg-offset, and reg-shift parameters too.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c              | 9 ++++++++-
 drivers/tty/serial/earlycon.c | 4 ++--
 include/linux/serial_core.h   | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 30e97bc..15f80c9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kconfig.h>
 #include <linux/initrd.h>
 #include <linux/memblock.h>
 #include <linux/of.h>
@@ -784,7 +785,13 @@ int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		if (fdt_getprop(fdt, offset, "big-endian", NULL) ||
+		    (fdt_getprop(fdt, offset, "native-endian", NULL) &&
+		     IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))) {
+			of_setup_earlycon(addr, UPIO_MEM32BE, match->data);
+		} else {
+			of_setup_earlycon(addr, UPIO_MEM, match->data);
+		}
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a514ee6..548f7d7 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -148,13 +148,13 @@ int __init setup_earlycon(char *buf, const char *match,
 	return 0;
 }
 
-int __init of_setup_earlycon(unsigned long addr,
+int __init of_setup_earlycon(unsigned long addr, unsigned char iotype,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
 
-	port->iotype = UPIO_MEM;
+	port->iotype = iotype;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d2d5bf6..0d60c64 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -310,7 +310,7 @@ struct earlycon_device {
 int setup_earlycon(char *buf, const char *match,
 		   int (*setup)(struct earlycon_device *, const char *));
 
-extern int of_setup_earlycon(unsigned long addr,
+extern int of_setup_earlycon(unsigned long addr, unsigned char iotype,
 			     int (*setup)(struct earlycon_device *, const char *));
 
 #define EARLYCON_DECLARE(name, func) \
-- 
2.1.1
