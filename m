Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 10:27:26 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:37693 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038425AbWI2J1W (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2006 10:27:22 +0100
Received: by mo.po.2iij.net (mo31) id k8T9R8t5034395; Fri, 29 Sep 2006 18:27:08 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k8T9R7tU071268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Sep 2006 18:27:07 +0900 (JST)
Date:	Fri, 29 Sep 2006 18:27:07 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	thies.moeller@baslerweb.com
Cc:	yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] removed excite_flash.c
Message-Id: <20060929182707.11cd70d8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

This patch has removed excite_flashtest.c .
It seems to be unused.

Do you have any problem about this patch?

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/basler/excite/excite_flashtest.c mips/arch/mips/basler/excite/excite_flashtest.c
--- mips-orig/arch/mips/basler/excite/excite_flashtest.c	2006-07-26 10:34:31.772178500 +0900
+++ mips/arch/mips/basler/excite/excite_flashtest.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,294 +0,0 @@
-/*
-*  Copyright (C) 2005 by Basler Vision Technologies AG
-*  Author: Thies Moeller <thies.moeller@baslerweb.com>
-*
-*  This program is free software; you can redistribute it and/or modify
-*  it under the terms of the GNU General Public License as published by
-*  the Free Software Foundation; either version 2 of the License, or
-*  (at your option) any later version.
-*
-*  This program is distributed in the hope that it will be useful,
-*  but WITHOUT ANY WARRANTY; without even the implied warranty of
-*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-*  GNU General Public License for more details.
-*
-*  You should have received a copy of the GNU General Public License
-*  along with this program; if not, write to the Free Software
-*  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/ioport.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-
-#include <excite.h>
-
-#include <asm/io.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/nand_ecc.h>
-#include <linux/mtd/partitions.h>
-#include <asm/rm9k-ocd.h> // for ocd_write
-#include <linux/workqueue.h> // for queue
-
-#include "excite_nandflash.h"
-#include "nandflash.h"
-
-#define PFX "excite flashtest: "
-typedef void __iomem *io_reg_t;
-
-#define io_readb(__a__)		__raw_readb((__a__))
-#define io_writeb(__v__, __a__)	__raw_writeb((__v__), (__a__))
-
-
-
-static inline const struct resource *excite_nandflash_get_resource(
-	struct platform_device *d, unsigned long flags, const char *basename)
-{
-	const char fmt[] = "%s_%u";
-	char buf[80];
-
-	if (unlikely(snprintf(buf, sizeof buf, fmt, basename, d->id) >= sizeof buf))
-		return NULL;
-
-	return platform_get_resource_byname(d, flags, buf);
-}
-
-static inline io_reg_t
-excite_nandflash_map_regs(struct platform_device *d, const char *basename)
-{
-	void *result = NULL;
-	const struct resource *const r =
-	    excite_nandflash_get_resource(d, IORESOURCE_MEM, basename);
-	if (r)
-	   result = ioremap_nocache(r->start, r->end + 1 - r->start);
-	return result;
-}
-
-/* controller and mtd information */
-
-struct excite_nandflash_drvdata {
-	struct mtd_info board_mtd;
-	struct nand_chip board_chip;
-	io_reg_t regs;
-};
-
-
-/* command and control functions */
-static void excite_nandflash_hwcontrol(struct mtd_info *mtd, int cmd)
-{
-	struct nand_chip *this = mtd->priv;
-	io_reg_t regs = container_of(mtd,struct excite_nandflash_drvdata,board_mtd)->regs;
-
-	switch (cmd) {
-	/* Select the command latch */
-	case NAND_CTL_SETCLE: this->IO_ADDR_W = regs + EXCITE_NANDFLASH_CMD;
-		break;
-	/* Deselect the command latch */
-	case NAND_CTL_CLRCLE: this->IO_ADDR_W = regs + EXCITE_NANDFLASH_DATA;
-		break;
-	/* Select the address latch */
-	case NAND_CTL_SETALE: this->IO_ADDR_W = regs + EXCITE_NANDFLASH_ADDR;
-		break;
-	/* Deselect the address latch */
-	case NAND_CTL_CLRALE: this->IO_ADDR_W = regs  + EXCITE_NANDFLASH_DATA;
-		break;
-	/* Select the chip  -- not used */
-	case NAND_CTL_SETNCE:
-		break;
-	/* Deselect the chip -- not used */
-	case NAND_CTL_CLRNCE:
-		break;
-	}
-
-	this->IO_ADDR_R = this->IO_ADDR_W;
-}
-
-/* excite_nandflash_devready()
- *
- * returns 0 if the nand is busy, 1 if it is ready
- */
-static int excite_nandflash_devready(struct mtd_info *mtd)
-{
-	struct excite_nandflash_drvdata *drvdata =
-	    container_of(mtd, struct excite_nandflash_drvdata, board_mtd);
-
-	return io_readb(drvdata->regs + EXCITE_NANDFLASH_STATUS);
-}
-
-/* device management functions */
-
-/* excite_nandflash_remove
- *
- * called by device layer to remove the driver
- * the binding to the mtd and all allocated
- * resources are released
- */
-static int excite_nandflash_remove(struct device *dev)
-{
-	struct excite_nandflash_drvdata *this = dev_get_drvdata(dev);
-
-	pr_info(PFX "remove");
-
-	dev_set_drvdata(dev, NULL);
-
-	if (this == NULL) {
-		pr_debug(PFX "call remove without private data!!");
-		return 0;
-	}
-
-
-	/* free the common resources */
-	if (this->regs != NULL) {
-		iounmap(this->regs);
-		this->regs = NULL;
-	}
-
-	kfree(this);
-
-	return 0;
-}
-
-static int elapsed;
-
-void my_workqueue_handler(void *arg)
-{
-	elapsed = 1;
-}
-
-DECLARE_WORK(sigElapsed, my_workqueue_handler, 0);
-
-
-/* excite_nandflash_probe
- *
- * called by device layer when it finds a device matching
- * one our driver can handled. This code checks to see if
- * it can allocate all necessary resources then calls the
- * nand layer to look for devices
-*/
-static int excite_nandflash_probe(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	struct excite_nandflash_drvdata *drvdata;	    /* private driver data     */
-	struct nand_chip              *board_chip;  /* private flash chip data */
-	struct mtd_info               *board_mtd;   /* mtd info for this board */
-
-	int err      = 0;
-	int count    = 0;
-	struct timeval tv,endtv;
-	unsigned int dt;
-
-	pr_info(PFX "probe dev: (%p)\n", dev);
-
-	pr_info(PFX "adjust LB timing\n");
-	ocd_writel(0x00000330, LDP2);
-
-	drvdata = kmalloc(sizeof(*drvdata), GFP_KERNEL);
-	if (unlikely(!drvdata)) {
-		printk(KERN_ERR PFX "no memory for drvdata\n");
-		err = -ENOMEM;
-		goto mem_error;
-	}
-
-	/* Initialize structures */
-	memset(drvdata, 0, sizeof(*drvdata));
-
-	/* bind private data into driver */
-	dev_set_drvdata(dev, drvdata);
-
-	/* allocate and map the resource */
-	drvdata->regs =
-	    excite_nandflash_map_regs(pdev, EXCITE_NANDFLASH_RESOURCE_REGS);
-
-	if (unlikely(!drvdata->regs)) {
-		printk(KERN_ERR PFX "cannot reserve register region\n");
-		err = -ENXIO;
-		goto io_error;
-	}
-
-	/* initialise our chip */
-	board_chip = &drvdata->board_chip;
-
-	board_chip->IO_ADDR_R = drvdata->regs + EXCITE_NANDFLASH_DATA;
-	board_chip->IO_ADDR_W = drvdata->regs + EXCITE_NANDFLASH_DATA;
-
-	board_chip->hwcontrol = excite_nandflash_hwcontrol;
-	board_chip->dev_ready = excite_nandflash_devready;
-
-	board_chip->chip_delay = 25;
-	#if 0
-	/* TODO: speedup the initial scan */
-	board_chip->options = NAND_USE_FLASH_BBT;
-	#endif
-	board_chip->eccmode = NAND_ECC_SOFT;
-
-	/* link chip to mtd */
-	board_mtd = &drvdata->board_mtd;
-	board_mtd->priv = board_chip;
-
-
-	pr_info(PFX "FlashTest\n");
-	elapsed = 0;
-/*	schedule_delayed_work(&sigElapsed, 1*HZ);
-	while (!elapsed) {
-		io_readb(drvdata->regs + EXCITE_NANDFLASH_STATUS);
-		count++;
-	}
-	pr_info(PFX "reads in 1 sec --> %d\n",count);
-*/
-	do_gettimeofday(&tv);
-	for (count = 0 ; count < 1000000; count ++) {
-		io_readb(drvdata->regs + EXCITE_NANDFLASH_STATUS);
-	}
-	do_gettimeofday(&endtv);
-	dt = (endtv.tv_sec - tv.tv_sec) * 1000000 + endtv.tv_usec  - tv.tv_usec;
-	pr_info(PFX "%8d us timeval\n",dt);
-	pr_info(PFX "EndFlashTest\n");
-
-/*      return with error to unload everything
-*/
-io_error:
-	iounmap(drvdata->regs);
-
-mem_error:
-	kfree(drvdata);
-
-	if (err == 0)
-		err = -EINVAL;
-	return err;
-}
-
-static struct device_driver excite_nandflash_driver = {
-	.name = "excite_nand",
-	.bus = &platform_bus_type,
-	.probe = excite_nandflash_probe,
-	.remove = excite_nandflash_remove,
-};
-
-static int __init excite_nandflash_init(void)
-{
-	pr_info(PFX "register Driver (Rev: $Revision:$)\n");
-	return driver_register(&excite_nandflash_driver);
-}
-
-static void __exit excite_nandflash_exit(void)
-{
-	driver_unregister(&excite_nandflash_driver);
-	pr_info(PFX "Driver unregistered");
-}
-
-module_init(excite_nandflash_init);
-module_exit(excite_nandflash_exit);
-
-MODULE_AUTHOR("Thies Moeller <thies.moeller@baslerweb.com>");
-MODULE_DESCRIPTION("Basler eXcite NAND-Flash driver");
-MODULE_LICENSE("GPL");
