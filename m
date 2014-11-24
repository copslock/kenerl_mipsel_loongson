Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:37:59 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:37421 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013564AbaKXXgl3gPoA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:36:41 +0100
Received: by mail-pa0-f45.google.com with SMTP id lj1so10530349pab.32
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oar8dsXQRFSz0jVQZg3KuHqweANNQsb/tCIxQROwYq8=;
        b=T+mmcW9MPDOrX2fyH/oOgYStddx71PEI2lRzzqKgfZ/2vgYnpxSJUMsn2AfE5UV7PQ
         ye5hCHahb1m2SQuqJj3ddbRw3682iTOV6wVX1gOYP6AFPI9G23EnwaYq1yUpmf/JFmrW
         LW+4MlRS4ETHJ5AMjw4eJpgcDwUoEO3gD6kz05SZirrdr2SkR0SnHn22Qpz7MTxRCbhw
         +AZCnNzkotBlVIxDPnM0Wy6QuHs3xx2FZ0XQI9EDpambniZqA+qXArzEmlGVo+N4Bptd
         2IE/IlvWCrE/7zak+ZBsclNRenOGP0IR6Ohv98jcQy+GXsqPFbvPmgAKpfG2pI4mxxD3
         l5Lg==
X-Received: by 10.66.118.198 with SMTP id ko6mr37642431pab.19.1416872195864;
        Mon, 24 Nov 2014 15:36:35 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id aq1sm13382876pbd.29.2014.11.24.15.36.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 15:36:35 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT properties
Date:   Mon, 24 Nov 2014 15:36:20 -0800
Message-Id: <1416872182-6440-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44417
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
 drivers/of/fdt.c              | 7 ++++++-
 drivers/tty/serial/earlycon.c | 4 ++--
 include/linux/serial_core.h   | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 658656f..9d21472 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
 
 	while (match->compatible[0]) {
 		unsigned long addr;
+		unsigned char iotype = UPIO_MEM;
+
 		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
 			match++;
 			continue;
@@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		if (of_fdt_is_big_endian(fdt, offset))
+			iotype = UPIO_MEM32BE;
+
+		of_setup_earlycon(addr, iotype, match->data);
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
2.1.0
