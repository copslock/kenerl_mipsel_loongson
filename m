Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 00:42:31 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:35800 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994673AbeIFWjbrVG1L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 00:39:31 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA18B20A8F; Fri,  7 Sep 2018 00:39:26 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 34985207AD;
        Fri,  7 Sep 2018 00:39:14 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Alexander Clouter <alex@digriz.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 14/19] mtd: rawnand: Move platform_nand_xxx definitions out of rawnand.h
Date:   Fri,  7 Sep 2018 00:38:46 +0200
Message-Id: <20180906223851.6964-15-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

platform_nand_xxx definitions are just used by the plat_nand driver.
Let's move those definitions out of the core/driver-agnostic rawnand.h
header.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 arch/arm/mach-ep93xx/snappercl15.c      |  3 +-
 arch/arm/mach-ep93xx/ts72xx.c           |  3 +-
 arch/arm/mach-imx/mach-qong.c           |  2 +-
 arch/arm/mach-omap1/board-fsample.c     |  3 +-
 arch/arm/mach-omap1/board-h2.c          |  3 +-
 arch/arm/mach-omap1/board-h3.c          |  2 +-
 arch/arm/mach-omap1/board-perseus2.c    |  3 +-
 arch/arm/mach-orion5x/ts78xx-setup.c    |  3 +-
 arch/arm/mach-pxa/balloon3.c            |  3 +-
 arch/arm/mach-pxa/em-x270.c             |  3 +-
 arch/arm/mach-pxa/palmtx.c              |  3 +-
 arch/mips/alchemy/devboards/db1200.c    |  3 +-
 arch/mips/alchemy/devboards/db1300.c    |  3 +-
 arch/mips/alchemy/devboards/db1550.c    |  3 +-
 arch/mips/netlogic/xlr/platform-flash.c |  3 +-
 arch/mips/pnx833x/common/platform.c     |  3 +-
 arch/mips/rb532/devices.c               |  3 +-
 arch/sh/boards/mach-migor/setup.c       |  2 +-
 drivers/mtd/nand/raw/plat_nand.c        |  3 +-
 include/linux/mtd/platnand.h            | 74 +++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h             | 60 --------------------------
 21 files changed, 93 insertions(+), 95 deletions(-)
 create mode 100644 include/linux/mtd/platnand.h

diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 1dad83a0bc5b..cf0cb58b3454 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -23,8 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/fb.h>
 
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/rawnand.h>
+#include <linux/mtd/platnand.h>
 
 #include <mach/hardware.h>
 #include <linux/platform_data/video-ep93xx.h>
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 188bf02595c5..c6a533699b00 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -16,8 +16,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/mmc_spi.h>
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 48972944bb95..5c5df8ca38dd 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -18,7 +18,7 @@
 #include <linux/memory.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/rawnand.h>
+#include <linux/mtd/platnand.h>
 #include <linux/gpio.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index e9f512a0602e..4a0a66815ca0 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -16,8 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/smc91x.h>
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d5dd2acd6f78..9d9a6ca15df0 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -24,8 +24,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/mfd/tps65010.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index a75856fe4259..cd6e02c5c01a 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -23,7 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/i2c.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
+#include <linux/mtd/platnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index c61c7c7520ca..06a584fef5b8 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -16,8 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/smc91x.h>
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index aac2c6eb35e2..fda9b75c3a33 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -16,8 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/timeriomem-rng.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 256e60c38a6d..c52c081eb6d9 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -25,11 +25,10 @@
 #include <linux/ioport.h>
 #include <linux/ucb1400.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
 #include <linux/types.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/i2c-pxa.h>
-#include <linux/mtd/rawnand.h>
+#include <linux/mtd/platnand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/regulator/max1586.h>
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 3acb945a2628..c30d20e1fb7a 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -15,8 +15,7 @@
 
 #include <linux/dm9000.h>
 #include <linux/platform_data/rtc-v3020.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 36ea32c1bbcc..1d06a8e91d8f 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -28,8 +28,7 @@
 #include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/physmap.h>
 
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 97dc74f7f41a..4bf02f96ab7f 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -29,8 +29,7 @@
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/spi/spi.h>
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index b813dc1c1682..ad7dd8e89598 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -19,8 +19,7 @@
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 #include <linux/wm97xx.h>
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 65f6b7184fbe..7700ad0b93b4 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -13,8 +13,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
diff --git a/arch/mips/netlogic/xlr/platform-flash.c b/arch/mips/netlogic/xlr/platform-flash.c
index 4f76b85b44c9..cf9162284b07 100644
--- a/arch/mips/netlogic/xlr/platform-flash.c
+++ b/arch/mips/netlogic/xlr/platform-flash.c
@@ -19,8 +19,7 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlr/iomap.h>
diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
index 33d0f070b33d..dafbf027fad0 100644
--- a/arch/mips/pnx833x/common/platform.c
+++ b/arch/mips/pnx833x/common/platform.c
@@ -30,8 +30,7 @@
 #include <linux/resource.h>
 #include <linux/serial.h>
 #include <linux/serial_pnx8xxx.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 
 #include <irq.h>
 #include <irq-mapping.h>
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 02a9e042fb44..2b23ad640f39 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -20,9 +20,8 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/rawnand.h>
+#include <linux/mtd/platnand.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index ebcc4d5a67ce..f4ad33c6d2aa 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -14,7 +14,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mfd/tmio.h>
-#include <linux/mtd/rawnand.h>
+#include <linux/mtd/platnand.h>
 #include <linux/i2c.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index 156c9150fec4..86c536ddaf24 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -15,8 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 
 struct plat_nand_data {
 	struct nand_chip	chip;
diff --git a/include/linux/mtd/platnand.h b/include/linux/mtd/platnand.h
new file mode 100644
index 000000000000..bc11eb6b593b
--- /dev/null
+++ b/include/linux/mtd/platnand.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright © 2000-2010 David Woodhouse <dwmw2@infradead.org>
+ *			  Steven J. Hill <sjhill@realitydiluted.com>
+ *			  Thomas Gleixner <tglx@linutronix.de>
+ *
+ * Contains all platform NAND related definitions.
+ */
+
+#ifndef __LINUX_MTD_PLATNAND_H
+#define __LINUX_MTD_PLATNAND_H
+
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/platform_device.h>
+
+/**
+ * struct platform_nand_chip - chip level device structure
+ * @nr_chips: max. number of chips to scan for
+ * @chip_offset: chip number offset
+ * @nr_partitions: number of partitions pointed to by partitions (or zero)
+ * @partitions: mtd partition list
+ * @chip_delay: R/B delay value in us
+ * @options: Option flags, e.g. 16bit buswidth
+ * @bbt_options: BBT option flags, e.g. NAND_BBT_USE_FLASH
+ * @part_probe_types: NULL-terminated array of probe types
+ */
+struct platform_nand_chip {
+	int nr_chips;
+	int chip_offset;
+	int nr_partitions;
+	struct mtd_partition *partitions;
+	int chip_delay;
+	unsigned int options;
+	unsigned int bbt_options;
+	const char **part_probe_types;
+};
+
+/**
+ * struct platform_nand_ctrl - controller level device structure
+ * @probe: platform specific function to probe/setup hardware
+ * @remove: platform specific function to remove/teardown hardware
+ * @dev_ready: platform specific function to read ready/busy pin
+ * @select_chip: platform specific chip select function
+ * @cmd_ctrl: platform specific function for controlling
+ *	      ALE/CLE/nCE. Also used to write command and address
+ * @write_buf: platform specific function for write buffer
+ * @read_buf: platform specific function for read buffer
+ * @priv: private data to transport driver specific settings
+ *
+ * All fields are optional and depend on the hardware driver requirements
+ */
+struct platform_nand_ctrl {
+	int (*probe)(struct platform_device *pdev);
+	void (*remove)(struct platform_device *pdev);
+	int (*dev_ready)(struct nand_chip *chip);
+	void (*select_chip)(struct nand_chip *chip, int cs);
+	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
+	void (*write_buf)(struct nand_chip *chip, const uint8_t *buf, int len);
+	void (*read_buf)(struct nand_chip *chip, uint8_t *buf, int len);
+	void *priv;
+};
+
+/**
+ * struct platform_nand_data - container structure for platform-specific data
+ * @chip: chip level chip structure
+ * @ctrl: controller level device structure
+ */
+struct platform_nand_data {
+	struct platform_nand_chip chip;
+	struct platform_nand_ctrl ctrl;
+};
+
+#endif /* __LINUX_MTD_PLATNAND_H */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 8aa8b57ca4b1..04e11a314e9c 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1540,66 +1540,6 @@ int nand_isbad_bbt(struct nand_chip *chip, loff_t offs, int allowbbt);
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt);
 
-/**
- * struct platform_nand_chip - chip level device structure
- * @nr_chips:		max. number of chips to scan for
- * @chip_offset:	chip number offset
- * @nr_partitions:	number of partitions pointed to by partitions (or zero)
- * @partitions:		mtd partition list
- * @chip_delay:		R/B delay value in us
- * @options:		Option flags, e.g. 16bit buswidth
- * @bbt_options:	BBT option flags, e.g. NAND_BBT_USE_FLASH
- * @part_probe_types:	NULL-terminated array of probe types
- */
-struct platform_nand_chip {
-	int nr_chips;
-	int chip_offset;
-	int nr_partitions;
-	struct mtd_partition *partitions;
-	int chip_delay;
-	unsigned int options;
-	unsigned int bbt_options;
-	const char **part_probe_types;
-};
-
-/* Keep gcc happy */
-struct platform_device;
-
-/**
- * struct platform_nand_ctrl - controller level device structure
- * @probe:		platform specific function to probe/setup hardware
- * @remove:		platform specific function to remove/teardown hardware
- * @dev_ready:		platform specific function to read ready/busy pin
- * @select_chip:	platform specific chip select function
- * @cmd_ctrl:		platform specific function for controlling
- *			ALE/CLE/nCE. Also used to write command and address
- * @write_buf:		platform specific function for write buffer
- * @read_buf:		platform specific function for read buffer
- * @priv:		private data to transport driver specific settings
- *
- * All fields are optional and depend on the hardware driver requirements
- */
-struct platform_nand_ctrl {
-	int (*probe)(struct platform_device *pdev);
-	void (*remove)(struct platform_device *pdev);
-	int (*dev_ready)(struct nand_chip *chip);
-	void (*select_chip)(struct nand_chip *chip, int cs);
-	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
-	void (*write_buf)(struct nand_chip *chip, const uint8_t *buf, int len);
-	void (*read_buf)(struct nand_chip *chip, uint8_t *buf, int len);
-	void *priv;
-};
-
-/**
- * struct platform_nand_data - container structure for platform-specific data
- * @chip:		chip level chip structure
- * @ctrl:		controller level device structure
- */
-struct platform_nand_data {
-	struct platform_nand_chip chip;
-	struct platform_nand_ctrl ctrl;
-};
-
 /* return the supported asynchronous timing mode. */
 static inline int onfi_get_async_timing_mode(struct nand_chip *chip)
 {
-- 
2.14.1
