Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 01:11:48 +0000 (GMT)
Received: from mail02.hansenet.de ([213.191.73.62]:55478 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20039565AbXBHBLn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 01:11:43 +0000
Received: from [213.39.208.75] (213.39.208.75) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 45BEA1BF003D1686; Thu, 8 Feb 2007 02:07:53 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id A787D479FC;
	Thu,  8 Feb 2007 02:07:51 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Thu, 8 Feb 2007 01:57:25 +0100
Subject: [PATCH] eXcite nand flash driver
X-Length: 10171
X-UID:	5
To:	linux-mtd@lists.infradead.org
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200702080157.25432.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

This is a nand flash driver for the eXcite series of intelligent
cameras manufactured by Basler Vision Technologies AG.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
=2D--
 drivers/mtd/nand/Kconfig            |   18 +++-
 drivers/mtd/nand/Makefile           |    1 +
 drivers/mtd/nand/excite_nandflash.c |  259=20
+++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 358f55a..5b50396 100644
=2D-- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -216,10 +216,26 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
 	  Even if you leave this disabled, you can enable BBT writes at module
 	  load time (assuming you build diskonchip as a module) with the module
 	  parameter "inftl_bbt_write=3D1".
=2D
+	 =20
 config MTD_NAND_SHARPSL
 	tristate "Support for NAND Flash on Sharp SL Series (C7xx + others)"
 	depends on MTD_NAND && ARCH_PXA
+=20
+config MTD_NAND_BASLER_EXCITE
+	tristate  "Support for NAND Flash on Basler eXcite"
+	depends on MTD_NAND && BASLER_EXCITE
+	help
+          This enables the driver for the NAND flash device found on the
+          Basler eXcite Smart Camera. If built as a module, the driver
+	  will be named "excite_nandflash.ko".
+
+config MTD_NAND_BASLER_EXCITE
+	tristate  "Support for NAND Flash on Basler eXcite"
+	depends on MTD_NAND && BASLER_EXCITE
+	help
+          This enables the driver for the NAND flash device found on the
+          Basler eXcite Smart Camera. If built as a module, the driver
+	  will be named "excite_nandflash.ko".
=20
 config MTD_NAND_CAFE
        tristate "NAND support for OLPC CAF=C9 chip"
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index f7a53f0..80f1dfc 100644
=2D-- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_MTD_NAND_NANDSIM)		+=3D nands
 obj-$(CONFIG_MTD_NAND_CS553X)		+=3D cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+=3D ndfc.o
 obj-$(CONFIG_MTD_NAND_AT91)		+=3D at91_nand.o
+obj-$(CONFIG_MTD_NAND_BASLER_EXCITE)	+=3D excite_nandflash.o
=20
 nand-objs :=3D nand_base.o nand_bbt.o
 cafe_nand-objs :=3D cafe.o cafe_ecc.o
diff --git a/drivers/mtd/nand/excite_nandflash.c=20
b/drivers/mtd/nand/excite_nandflash.c
new file mode 100644
index 0000000..d683659
=2D-- /dev/null
+++ b/drivers/mtd/nand/excite_nandflash.c
@@ -0,0 +1,259 @@
+/*
+*  Copyright (C) 2005 - 2007 by Basler Vision Technologies AG
+*  Author: Thomas Koeller <thomas.koeller.qbaslerweb.com>
+*  Original code by Thies Moeller <thies.moeller@baslerweb.com>
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; either version 2 of the License, or
+*  (at your option) any later version.
+*
+*  This program is distributed in the hope that it will be useful,
+*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+*  GNU General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License
+*  along with this program; if not, write to the Free Software
+*  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
+*/
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+#include <asm/rm9k-ocd.h>
+
+#include <excite_nandflash.h>
+
+#define EXCITE_NANDFLASH_VERSION "0.1"
+
+/* I/O register offsets */
+#define EXCITE_NANDFLASH_DATA_BYTE   0x00
+#define EXCITE_NANDFLASH_STATUS_BYTE 0x0c
+#define EXCITE_NANDFLASH_ADDR_BYTE   0x10
+#define EXCITE_NANDFLASH_CMD_BYTE    0x14
+
+#define io_readb(__a__)		__raw_readb((__a__))
+#define io_writeb(__v__, __a__)	__raw_writeb((__v__), (__a__))
+
+typedef void __iomem *io_reg_t;
+
+/* prefix for debug output */
+static const char module_id[] =3D "excite_nandflash";
+
+/*
+ * partition definition
+ */
+static const struct mtd_partition partition_info[] =3D {
+	{
+		.name =3D "eXcite RootFS",
+		.offset =3D 0,
+		.size =3D MTDPART_SIZ_FULL
+	}
+};
+
+static inline const struct resource *excite_nand_get_resource
+    (struct platform_device *d, unsigned long flags, const char *basename)=
 {
+	const char fmt[] =3D "%s_%u";
+	char buf[80];
+
+	if (unlikely
+	    (snprintf(buf, sizeof buf, fmt, basename, d->id) >=3D sizeof buf))
+		return NULL;
+	return platform_get_resource_byname(d, flags, buf);
+}
+
+static inline io_reg_t
+excite_nand_map_regs(struct platform_device *d, const char *basename)
+{
+	void *result =3D NULL;
+	const struct resource *const r =3D
+	    excite_nand_get_resource(d, IORESOURCE_MEM, basename);
+	if (likely(r))
+		result =3D ioremap_nocache(r->start, r->end + 1 - r->start);
+	return result;
+}
+
+/* controller and mtd information */
+struct excite_nand_drvdata {
+	struct mtd_info board_mtd;
+	struct nand_chip board_chip;
+	io_reg_t regs;
+};
+
+/* command and control functions */
+static void excite_nand_control(struct mtd_info *mtd, int cmd,
+				       unsigned int ctrl)
+{
+	io_reg_t regs =3D
+	    container_of(mtd, struct excite_nand_drvdata, board_mtd)->regs;
+	static void __iomem *tgt =3D NULL;
+
+	switch (ctrl) {
+	case NAND_CTRL_CHANGE | NAND_CTRL_CLE:
+		tgt =3D regs + EXCITE_NANDFLASH_CMD_BYTE;
+		break;
+	case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
+		tgt =3D regs + EXCITE_NANDFLASH_ADDR_BYTE;
+		break;
+	case NAND_CTRL_CHANGE | NAND_NCE:
+		tgt =3D regs + EXCITE_NANDFLASH_DATA_BYTE;
+		break;
+	}
+
+	if (cmd !=3D NAND_CMD_NONE)
+		io_writeb(cmd, tgt);
+}
+
+/* excite_nand_devready()
+ *
+ * returns 0 if the nand is busy, 1 if it is ready
+ */
+static int excite_nand_devready(struct mtd_info *mtd)
+{
+	struct excite_nand_drvdata * const drvdata =3D
+	    container_of(mtd, struct excite_nand_drvdata, board_mtd);
+	return io_readb(drvdata->regs + EXCITE_NANDFLASH_STATUS_BYTE);
+}
+
+/* excite_nand_remove
+ *
+ * called by device layer to remove the driver
+ * the binding to the mtd and all allocated
+ * resources are released
+ */
+static int __exit excite_nand_remove(struct device *dev)
+{
+	struct excite_nand_drvdata * const this =3D dev_get_drvdata(dev);
+
+	dev_set_drvdata(dev, NULL);
+
+	if (unlikely(!this)) {
+		printk(KERN_ERR "%s: called %s without private data!!",
+		       module_id, __func__);
+		return -EINVAL;
+	}
+
+	/* first thing we need to do is release our mtd
+	 * then go through freeing the resource used
+	 */
+	nand_release(&this->board_mtd);
+
+	/* free the common resources */
+	if (likely(this->regs)) {
+		iounmap(this->regs);
+		this->regs =3D NULL;
+	}
+
+	kfree(this);
+
+	DEBUG(MTD_DEBUG_LEVEL1, "%s: removed\n", module_id);
+	return 0;
+}
+
+/* excite_nand_probe
+ *
+ * called by device layer when it finds a device matching
+ * one our driver can handled. This code checks to see if
+ * it can allocate all necessary resources then calls the
+ * nand layer to look for devices
+*/
+static int __init excite_nand_probe(struct device *dev)
+{
+	struct platform_device * const pdev =3D to_platform_device(dev);
+
+	struct excite_nand_drvdata *drvdata;	/* private driver data     */
+	struct nand_chip *board_chip;	/* private flash chip data */
+	struct mtd_info *board_mtd;	/* mtd info for this board */
+	int scan_res;
+
+	drvdata =3D kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (unlikely(!drvdata)) {
+		printk(KERN_ERR "%s: no memory for drvdata\n",
+		       module_id);
+		return -ENOMEM;
+	}
+
+	/* bind private data into driver */
+	dev_set_drvdata(dev, drvdata);
+
+	/* allocate and map the resource */
+	drvdata->regs =3D
+		excite_nand_map_regs(pdev, EXCITE_NANDFLASH_RESOURCE_REGS);
+
+	if (unlikely(!drvdata->regs)) {
+		printk(KERN_ERR "%s: cannot reserve register region\n",
+		       module_id);
+		kfree(drvdata);
+		return -ENXIO;
+	}
+
+	/* initialise our chip */
+	board_chip =3D &drvdata->board_chip;
+	board_chip->IO_ADDR_R =3D board_chip->IO_ADDR_W =3D
+		drvdata->regs + EXCITE_NANDFLASH_DATA_BYTE;
+	board_chip->cmd_ctrl =3D excite_nand_control;
+	board_chip->dev_ready =3D excite_nand_devready;
+	board_chip->chip_delay =3D 25;
+	board_chip->ecc.mode =3D NAND_ECC_SOFT;
+
+	/* link chip to mtd */
+	board_mtd =3D &drvdata->board_mtd;
+	board_mtd->priv =3D board_chip;
+
+	DEBUG(MTD_DEBUG_LEVEL2, "%s: device scan\n", module_id);
+	scan_res =3D nand_scan(&drvdata->board_mtd, 1);
+
+	if (likely(!scan_res)) {
+		DEBUG(MTD_DEBUG_LEVEL2, "%s: register partitions\n", module_id);
+		add_mtd_partitions(&drvdata->board_mtd, partition_info,
+				   sizeof partition_info / sizeof partition_info[0]);
+	} else {
+		iounmap(drvdata->regs);
+		kfree(drvdata);
+		printk(KERN_ERR "%s: device scan failed\n", module_id);
+		return -EIO;
+	}
+	return 0;
+}
+
+static struct device_driver excite_nand_driver =3D {
+	.name =3D "excite_nand",
+	.bus =3D &platform_bus_type,
+	.probe =3D excite_nand_probe,
+	.remove =3D __exit_p(excite_nand_remove)
+};
+
+static int __init excite_nand_init(void)
+{
+	pr_info("Basler eXcite nand flash driver Version "
+		EXCITE_NANDFLASH_VERSION "\n");
+	return driver_register(&excite_nand_driver);
+}
+
+static void __exit excite_nand_exit(void)
+{
+	driver_unregister(&excite_nand_driver);
+}
+
+module_init(excite_nand_init);
+module_exit(excite_nand_exit);
+
+MODULE_AUTHOR("Thomas Koeller <thomas.koeller@baslerweb.com>");
+MODULE_DESCRIPTION("Basler eXcite NAND-Flash driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(EXCITE_NANDFLASH_VERSION)
=2D-=20
1.4.3
