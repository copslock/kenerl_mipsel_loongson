Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2007 16:31:10 +0100 (BST)
Received: from p549F758F.dip.t-dialin.net ([84.159.117.143]:13718 "EHLO
	p549F758F.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20022516AbXD3PbJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Apr 2007 16:31:09 +0100
Received: from mba.ocn.ne.jp ([122.1.175.29]:54780 "HELO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with SMTP id S1098809AbXD3P3t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2007 17:29:49 +0200
Received: from localhost (p4067-ipad203funabasi.chiba.ocn.ne.jp [222.146.83.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 87065A012; Tue,  1 May 2007 00:27:54 +0900 (JST)
Date:	Tue, 01 May 2007 00:27:58 +0900 (JST)
Message-Id: <20070501.002758.15250764.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	netdev@vger.kernel.org, jeff@garzik.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: [PATCH 4/5] ne: MIPS: Use platform_driver for ne on RBTX49XX
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch lets RBTX49XX boards use generic platform_driver interface
for the ne driver.

* Use platform_device to pass ioaddr and irq to the ne driver.
* Remove unnecessary ifdefs for RBTX49XX from the ne driver.
* Make the ne driver selectable on these boards regardless of CONFIG_ISA

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |   19 +++++++++++++++++++
 arch/mips/tx4938/toshiba_rbtx4938/setup.c          |   20 ++++++++++++++++++++
 drivers/net/Kconfig                                |    2 +-
 drivers/net/ne.c                                   |    8 --------
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index 0f7576d..a0c11ef 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -1049,3 +1049,22 @@ static int __init toshiba_rbtx4927_rtc_init(void)
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
 device_initcall(toshiba_rbtx4927_rtc_init);
+
+static int __init rbtx4927_ne_init(void)
+{
+	static struct resource __initdata res[] = {
+		{
+			.start	= RBTX4927_RTL_8019_BASE,
+			.end	= RBTX4927_RTL_8019_BASE + 0x20 - 1,
+			.flags	= IORESOURCE_IO,
+		}, {
+			.start	= RBTX4927_RTL_8019_IRQ,
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("ne", -1,
+						res, ARRAY_SIZE(res));
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+device_initcall(rbtx4927_ne_init);
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 66163ba..f5d1ce7 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -20,6 +20,7 @@
 #include <linux/console.h>
 #include <linux/pci.h>
 #include <linux/pm.h>
+#include <linux/platform_device.h>
 
 #include <asm/wbflush.h>
 #include <asm/reboot.h>
@@ -1037,3 +1038,22 @@ static int __init tx4938_spi_proc_setup(void)
 
 __initcall(tx4938_spi_proc_setup);
 #endif
+
+static int __init rbtx4938_ne_init(void)
+{
+	struct resource res[] = {
+		{
+			.start	= RBTX4938_RTL_8019_BASE,
+			.end	= RBTX4938_RTL_8019_BASE + 0x20 - 1,
+			.flags	= IORESOURCE_IO,
+		}, {
+			.start	= RBTX4938_RTL_8019_IRQ,
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("ne", -1,
+						res, ARRAY_SIZE(res));
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+device_initcall(rbtx4938_ne_init);
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 88d924d..3796366 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1088,7 +1088,7 @@ config ETH16I
 
 config NE2000
 	tristate "NE2000/NE1000 support"
-	depends on NET_ISA || (Q40 && m) || M32R
+	depends on NET_ISA || (Q40 && m) || M32R || TOSHIBA_RBTX4927 || TOSHIBA_RBTX4938
 	select CRC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
diff --git a/drivers/net/ne.c b/drivers/net/ne.c
index 22d6fe4..c9f74bf 100644
--- a/drivers/net/ne.c
+++ b/drivers/net/ne.c
@@ -56,10 +56,6 @@ static const char version2[] =
 #include <asm/system.h>
 #include <asm/io.h>
 
-#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
-#include <asm/tx4938/rbtx4938.h>
-#endif
-
 #include "8390.h"
 
 #define DRV_NAME "ne"
@@ -232,10 +228,6 @@ struct net_device * __init ne_probe(int unit)
 	sprintf(dev->name, "eth%d", unit);
 	netdev_boot_setup_check(dev);
 
-#ifdef CONFIG_TOSHIBA_RBTX4938
-	dev->base_addr = RBTX4938_RTL_8019_BASE;
-	dev->irq = RBTX4938_RTL_8019_IRQ;
-#endif
 	err = do_ne_probe(dev);
 	if (err)
 		goto out;
