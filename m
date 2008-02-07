Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 02:17:01 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:61385 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20036629AbYBGCQx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2008 02:16:53 +0000
Received: from volta.aurel32.net ([2002:52e8:2fb:1:216:d3ff:fe17:fd00])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JMwJj-0006HT-N8; Thu, 07 Feb 2008 03:16:47 +0100
Received: from aurel32 by volta.aurel32.net with local (Exim 4.68)
	(envelope-from <aurelien@aurel32.net>)
	id 1JMwKC-0000vM-Kc; Thu, 07 Feb 2008 03:17:16 +0100
Date:	Thu, 7 Feb 2008 03:17:16 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS] Add platform MTD support for the WGT634U machine
Message-ID: <20080207021716.GA3350@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.17 (2007-12-11)
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below adds MTD support for the WGT634U machine by defining a
new platform_device for the flash.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/bcm47xx/wgt634u.c |   69 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/wgt634u.c b/arch/mips/bcm47xx/wgt634u.c
index 5a017ea..997e540 100644
--- a/arch/mips/bcm47xx/wgt634u.c
+++ b/arch/mips/bcm47xx/wgt634u.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/leds.h>
+#include <linux/mtd/physmap.h>
 #include <linux/ssb/ssb.h>
 #include <asm/mach-bcm47xx/bcm47xx.h>
 
@@ -43,6 +44,61 @@ static struct platform_device wgt634u_gpio_leds = {
 	}
 };
 
+
+/* 8MiB flash. The struct mtd_partition matches original Netgear WGT634U
+   firmware. */
+static struct mtd_partition wgt634u_partitions[] = {
+	{
+		.name       = "cfe",
+		.offset     = 0,
+		.size       = 0x60000,		/* 384k */
+		.mask_flags = MTD_WRITEABLE 	/* force read-only */
+	},
+	{
+		.name   = "config",
+		.offset = 0x60000,
+		.size   = 0x20000		/* 128k */
+	},
+	{
+		.name   = "linux",
+		.offset = 0x80000,
+		.size   = 0x140000 		/* 1280k */
+	},
+	{
+		.name   = "jffs",
+		.offset = 0x1c0000,
+		.size   = 0x620000 		/* 6272k */
+	},
+	{
+		.name   = "nvram",
+		.offset = 0x7e0000,
+		.size   = 0x20000		/* 128k */
+	},
+};
+
+static struct physmap_flash_data wgt634u_flash_data = {
+	.parts    = wgt634u_partitions,
+	.nr_parts = ARRAY_SIZE(wgt634u_partitions)
+};
+
+static struct resource wgt634u_flash_resource = {
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device wgt634u_flash = {
+	.name          = "physmap-flash",
+	.id            = 0,
+	.dev           = { .platform_data = &wgt634u_flash_data, },
+	.resource      = &wgt634u_flash_resource,
+	.num_resources = 1,
+};
+
+/* Platform devices */
+static struct platform_device *wgt634u_devices[] __initdata = {
+	&wgt634u_flash,
+	&wgt634u_gpio_leds,
+};
+
 static int __init wgt634u_init(void)
 {
 	/* There is no easy way to detect that we are running on a WGT634U
@@ -54,9 +110,16 @@ static int __init wgt634u_init(void)
 
 	if (et0mac[0] == 0x00 &&
 	    ((et0mac[1] == 0x09 && et0mac[2] == 0x5b) ||
-	     (et0mac[1] == 0x0f && et0mac[2] == 0xb5)))
-		return platform_device_register(&wgt634u_gpio_leds);
-	else
+	     (et0mac[1] == 0x0f && et0mac[2] == 0xb5))) {
+		struct ssb_mipscore *mcore = &ssb_bcm47xx.mipscore;
+		wgt634u_flash_data.width = mcore->flash_buswidth;
+		wgt634u_flash_resource.start = mcore->flash_window;
+		wgt634u_flash_resource.end = mcore->flash_window
+					   + mcore->flash_window_size
+					   - 1;
+		return platform_add_devices(wgt634u_devices,
+					    ARRAY_SIZE(wgt634u_devices));
+	} else
 		return -ENODEV;
 }
 

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
