Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:49:07 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60371 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013489AbaKLIrWhN3h1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:22 +0100
Received: by mail-pd0-f180.google.com with SMTP id ft15so11727089pdb.25
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sz5muX7LNOsLWkm2Ey0xvIBmLE+OUjO/6jNry0O9MOY=;
        b=um4oSdFeaHaG9+8daZrTHvIMWrB5QPWo8PxY1mESllR6GPMP8iYDaDNFxHugFppt3v
         SltsvU4rrS+dVn2oPABCjm6fVCpLpmyF42RtcMzaCRMvqdGQf4xeCgg38Jy5v8J6Y7AL
         yEeWhx5DjSfv2ujrThnYxVROCn5fTg19DsA5t8kfyYPVZN54Uj/r9U70+Xjo9YFCHqg/
         W0hhymSRnFo1vtIttKBK/8scwnxdpxEIPUIjiBLFTP7I7C8yn3qlLC1luDERUxUkUoMw
         Ym8DjTm2Doh2Hohm5C3+5QNWiDngT1dn5FAkF0ehP39C6SsoQC4fIekqm4WnvBYzEB0W
         r5Fw==
X-Received: by 10.68.211.73 with SMTP id na9mr18197502pbc.132.1415782036592;
        Wed, 12 Nov 2014 00:47:16 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:16 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 7/8] serial: earlycon: Set uart_port->big_endian based on DT properties
Date:   Wed, 12 Nov 2014 00:46:32 -0800
Message-Id: <1415781993-7755-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44035
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
and "native-endian" properties and pass that information to the driver.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c              | 9 ++++++++-
 drivers/tty/serial/earlycon.c | 3 ++-
 include/linux/serial_core.h   | 3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 30e97bc..2668097 100644
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
+			of_setup_earlycon(addr, true, match->data);
+		} else {
+			of_setup_earlycon(addr, false, match->data);
+		}
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a514ee6..7556280 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -148,13 +148,14 @@ int __init setup_earlycon(char *buf, const char *match,
 	return 0;
 }
 
-int __init of_setup_earlycon(unsigned long addr,
+int __init of_setup_earlycon(unsigned long addr, bool big_endian,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
 
 	port->iotype = UPIO_MEM;
+	port->big_endian = big_endian;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index ae372f4..1937fca 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -29,6 +29,7 @@
 #include <linux/tty.h>
 #include <linux/mutex.h>
 #include <linux/sysrq.h>
+#include <linux/types.h>
 #include <uapi/linux/serial_core.h>
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
@@ -309,7 +310,7 @@ struct earlycon_device {
 int setup_earlycon(char *buf, const char *match,
 		   int (*setup)(struct earlycon_device *, const char *));
 
-extern int of_setup_earlycon(unsigned long addr,
+extern int of_setup_earlycon(unsigned long addr, bool big_endian,
 			     int (*setup)(struct earlycon_device *, const char *));
 
 #define EARLYCON_DECLARE(name, func) \
-- 
2.1.1
