Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:10:20 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903700Ab1KATEy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:54 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=acMoe8Kkjq8LJjw50ybB1iOwK/lGgs2o4wUNp+ST1Ew=;
        b=BXbXGRoFX66urg+ohuXSr1SFSXV0AbqohmWDRcCWBOSe3s4tlaVVYX76tA+MvzTY2+
         9ocAlY6zDSB90SdVoHJ8J0eeWRRKUaLHoyfXg9HTTZnvfW1lBkEmO37wfCtueS6AwyHh
         xW3N6ui7Nb4iPE1VEqdyq9k0nLz6b+fJk6p0c=
Received: by 10.223.61.138 with SMTP id t10mr2505295fah.20.1320174293992;
        Tue, 01 Nov 2011 12:04:53 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:53 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 14/18] MTD: nand: make au1550nd.c a platform_driver
Date:   Tue,  1 Nov 2011 20:03:40 +0100
Message-Id: <1320174224-27305-15-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 663

Transform the au1550nd.c driver into a platform_driver and hook it
up in the PB1550 board (gen_nand works fine on the DB1550, but since
I don't have a PB1550 to test this driver stays for now).

Cc: linux-mtd@lists.infradead.org
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Tested on the DB1550 as well.
I'd like for this to go in via the MIPS tree if at all possible.

 arch/mips/alchemy/devboards/pb1550.c         |   66 ++++++
 arch/mips/include/asm/mach-au1x00/au1550nd.h |   16 ++
 drivers/mtd/nand/au1550nd.c                  |  308 +++++++++++---------------
 3 files changed, 215 insertions(+), 175 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-au1x00/au1550nd.h

diff --git a/arch/mips/alchemy/devboards/pb1550.c b/arch/mips/alchemy/devboards/pb1550.c
index e4a00a5..b37e7de 100644
--- a/arch/mips/alchemy/devboards/pb1550.c
+++ b/arch/mips/alchemy/devboards/pb1550.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1550nd.h>
 #include <asm/mach-au1x00/gpio.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include "platform.h"
@@ -131,6 +132,67 @@ static struct platform_device pb1550_i2c_dev = {
 	.resource	= au1550_psc2_res,
 };
 
+static struct mtd_partition pb1550_nand_parts[] = {
+	[0] = {
+		.name	= "NAND FS 0",
+		.offset	= 0,
+		.size	= 8 * 1024 * 1024,
+	},
+	[1] = {
+		.name	= "NAND FS 1",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct au1550nd_platdata pb1550_nand_pd = {
+	.parts		= pb1550_nand_parts,
+	.num_parts	= ARRAY_SIZE(pb1550_nand_parts),
+	.devwidth	= 0,	/* x8 NAND default, needs fixing up */
+};
+
+static struct resource pb1550_nand_res[] = {
+	[0] = {
+		.start	= 0x20000000,
+		.end	= 0x20000fff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pb1550_nand_dev = {
+	.name		= "au1550-nand",
+	.id		= -1,
+	.resource	= pb1550_nand_res,
+	.num_resources	= ARRAY_SIZE(pb1550_nand_res),
+	.dev		= {
+		.platform_data	= &pb1550_nand_pd,
+	},
+};
+
+static void __init pb1550_nand_setup(void)
+{
+	int boot_swapboot = (au_readl(MEM_STSTAT) & (0x7 << 1)) |
+			    ((bcsr_read(BCSR_STATUS) >> 6) & 0x1);
+
+	switch (boot_swapboot) {
+	case 0:
+	case 2:
+	case 8:
+	case 0xC:
+	case 0xD:
+		/* x16 NAND Flash */
+		pb1550_nand_pd.devwidth = 1;
+		/* fallthrough */
+	case 1:
+	case 9:
+	case 3:
+	case 0xE:
+	case 0xF:
+		/* x8 NAND, already set up */
+		platform_device_register(&pb1550_nand_dev);
+	}
+}
+
 static int __init pb1550_dev_init(void)
 {
 	int swapped;
@@ -168,6 +230,10 @@ static int __init pb1550_dev_init(void)
 		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
 		AU1550_GPIO201_205_INT, AU1550_GPIO1_INT, 0, 0, 1);
 
+	/* NAND setup */
+	gpio_direction_input(206);	/* GPIO206 high */
+	pb1550_nand_setup();
+
 	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
 	db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
 	platform_device_register(&pb1550_pci_host);
diff --git a/arch/mips/include/asm/mach-au1x00/au1550nd.h b/arch/mips/include/asm/mach-au1x00/au1550nd.h
new file mode 100644
index 0000000..ad4c0a0
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/au1550nd.h
@@ -0,0 +1,16 @@
+/*
+ * platform data for the Au1550 NAND driver
+ */
+
+#ifndef _AU1550ND_H_
+#define _AU1550ND_H_
+
+#include <linux/mtd/partitions.h>
+
+struct au1550nd_platdata {
+	struct mtd_partition *parts;
+	int num_parts;
+	int devwidth;	/* 0 = 8bit device, 1 = 16bit device */
+};
+
+#endif
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index fa5736b..bdebd5c 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -17,35 +17,19 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1550nd.h>
 
-#ifdef CONFIG_MIPS_PB1550
-#include <asm/mach-pb1x00/pb1550.h>
-#elif defined(CONFIG_MIPS_DB1550)
-#include <asm/mach-db1x00/db1x00.h>
-#endif
-#include <asm/mach-db1x00/bcsr.h>
 
-/*
- * MTD structure for NAND controller
- */
-static struct mtd_info *au1550_mtd = NULL;
-static void __iomem *p_nand;
-static int nand_width = 1;	/* default x8 */
-static void (*au1550_write_byte)(struct mtd_info *, u_char);
+struct au1550nd_ctx {
+	struct mtd_info info;
+	struct nand_chip chip;
 
-/*
- * Define partitions for flash device
- */
-static const struct mtd_partition partition_info[] = {
-	{
-	 .name = "NAND FS 0",
-	 .offset = 0,
-	 .size = 8 * 1024 * 1024},
-	{
-	 .name = "NAND FS 1",
-	 .offset = MTDPART_OFS_APPEND,
-	 .size = MTDPART_SIZ_FULL}
+	int cs;
+	void __iomem *base;
+	void (*write_byte)(struct mtd_info *, u_char);
 };
 
 /**
@@ -262,24 +246,25 @@ static int au_verify_buf16(struct mtd_info *mtd, const u_char *buf, int len)
 
 static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 {
-	register struct nand_chip *this = mtd->priv;
+	struct au1550nd_ctx *ctx = container_of(mtd, struct au1550nd_ctx, info);
+	struct nand_chip *this = mtd->priv;
 
 	switch (cmd) {
 
 	case NAND_CTL_SETCLE:
-		this->IO_ADDR_W = p_nand + MEM_STNAND_CMD;
+		this->IO_ADDR_W = ctx->base + MEM_STNAND_CMD;
 		break;
 
 	case NAND_CTL_CLRCLE:
-		this->IO_ADDR_W = p_nand + MEM_STNAND_DATA;
+		this->IO_ADDR_W = ctx->base + MEM_STNAND_DATA;
 		break;
 
 	case NAND_CTL_SETALE:
-		this->IO_ADDR_W = p_nand + MEM_STNAND_ADDR;
+		this->IO_ADDR_W = ctx->base + MEM_STNAND_ADDR;
 		break;
 
 	case NAND_CTL_CLRALE:
-		this->IO_ADDR_W = p_nand + MEM_STNAND_DATA;
+		this->IO_ADDR_W = ctx->base + MEM_STNAND_DATA;
 		/* FIXME: Nobody knows why this is necessary,
 		 * but it works only that way */
 		udelay(1);
@@ -287,7 +272,7 @@ static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 
 	case NAND_CTL_SETNCE:
 		/* assert (force assert) chip enable */
-		au_writel((1 << (4 + NAND_CS)), MEM_STNDCTL);
+		au_writel((1 << (4 + ctx->cs)), MEM_STNDCTL);
 		break;
 
 	case NAND_CTL_CLRNCE:
@@ -334,9 +319,10 @@ static void au1550_select_chip(struct mtd_info *mtd, int chip)
  */
 static void au1550_command(struct mtd_info *mtd, unsigned command, int column, int page_addr)
 {
-	register struct nand_chip *this = mtd->priv;
+	struct au1550nd_ctx *ctx = container_of(mtd, struct au1550nd_ctx, info);
+	struct nand_chip *this = mtd->priv;
 	int ce_override = 0, i;
-	ulong flags;
+	unsigned long flags = 0;
 
 	/* Begin command latch cycle */
 	au1550_hwcontrol(mtd, NAND_CTL_SETCLE);
@@ -357,9 +343,9 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 			column -= 256;
 			readcmd = NAND_CMD_READ1;
 		}
-		au1550_write_byte(mtd, readcmd);
+		ctx->write_byte(mtd, readcmd);
 	}
-	au1550_write_byte(mtd, command);
+	ctx->write_byte(mtd, command);
 
 	/* Set ALE and clear CLE to start address cycle */
 	au1550_hwcontrol(mtd, NAND_CTL_CLRCLE);
@@ -372,10 +358,10 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 			/* Adjust columns for 16 bit buswidth */
 			if (this->options & NAND_BUSWIDTH_16)
 				column >>= 1;
-			au1550_write_byte(mtd, column);
+			ctx->write_byte(mtd, column);
 		}
 		if (page_addr != -1) {
-			au1550_write_byte(mtd, (u8)(page_addr & 0xff));
+			ctx->write_byte(mtd, (u8)(page_addr & 0xff));
 
 			if (command == NAND_CMD_READ0 ||
 			    command == NAND_CMD_READ1 ||
@@ -393,11 +379,12 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 				au1550_hwcontrol(mtd, NAND_CTL_SETNCE);
 			}
 
-			au1550_write_byte(mtd, (u8)(page_addr >> 8));
+			ctx->write_byte(mtd, (u8)(page_addr >> 8));
 
 			/* One more address cycle for devices > 32MiB */
 			if (this->chipsize > (32 << 20))
-				au1550_write_byte(mtd, (u8)((page_addr >> 16) & 0x0f));
+				ctx->write_byte(mtd,
+						((page_addr >> 16) & 0x0f));
 		}
 		/* Latch in address */
 		au1550_hwcontrol(mtd, NAND_CTL_CLRALE);
@@ -443,121 +430,79 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 	while(!this->dev_ready(mtd));
 }
 
-
-/*
- * Main initialization routine
- */
-static int __init au1xxx_nand_init(void)
+static int __devinit find_nand_cs(unsigned long nand_base)
 {
-	struct nand_chip *this;
-	u16 boot_swapboot = 0;	/* default value */
-	int retval;
-	u32 mem_staddr;
-	u32 nand_phys;
-
-	/* Allocate memory for MTD device structure and private data */
-	au1550_mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
-	if (!au1550_mtd) {
-		printk("Unable to allocate NAND MTD dev structure.\n");
-		return -ENOMEM;
-	}
-
-	/* Get pointer to private data */
-	this = (struct nand_chip *)(&au1550_mtd[1]);
-
-	/* Link the private data with the MTD structure */
-	au1550_mtd->priv = this;
-	au1550_mtd->owner = THIS_MODULE;
-
+	void __iomem *base =
+			(void __iomem *)KSEG1ADDR(AU1000_STATIC_MEM_PHYS_ADDR);
+	unsigned long addr, staddr, start, mask, end;
+	int i;
 
-	/* MEM_STNDCTL: disable ints, disable nand boot */
-	au_writel(0, MEM_STNDCTL);
+	for (i = 0; i < 4; i++) {
+		addr = 0x1000 + (i * 0x10);			/* CSx */
+		staddr = __raw_readl(base + addr + 0x08);	/* STADDRx */
+		/* figure out the decoded range of this CS */
+		start = (staddr << 4) & 0xfffc0000;
+		mask = (staddr << 18) & 0xfffc0000;
+		end = (start | (start - 1)) & ~(start ^ mask);
+		if ((nand_base >= start) && (nand_base < end))
+			return i;
+	}
 
-#ifdef CONFIG_MIPS_PB1550
-	/* set gpio206 high */
-	gpio_direction_input(206);
+	return -ENODEV;
+}
 
-	boot_swapboot = (au_readl(MEM_STSTAT) & (0x7 << 1)) | ((bcsr_read(BCSR_STATUS) >> 6) & 0x1);
+static int __devinit au1550nd_probe(struct platform_device *pdev)
+{
+	struct au1550nd_platdata *pd;
+	struct au1550nd_ctx *ctx;
+	struct nand_chip *this;
+	struct resource *r;
+	int ret, cs;
 
-	switch (boot_swapboot) {
-	case 0:
-	case 2:
-	case 8:
-	case 0xC:
-	case 0xD:
-		/* x16 NAND Flash */
-		nand_width = 0;
-		break;
-	case 1:
-	case 9:
-	case 3:
-	case 0xE:
-	case 0xF:
-		/* x8 NAND Flash */
-		nand_width = 1;
-		break;
-	default:
-		printk("Pb1550 NAND: bad boot:swap\n");
-		retval = -EINVAL;
-		goto outmem;
-	}
-#endif
-
-	/* Configure chip-select; normally done by boot code, e.g. YAMON */
-#ifdef NAND_STCFG
-	if (NAND_CS == 0) {
-		au_writel(NAND_STCFG,  MEM_STCFG0);
-		au_writel(NAND_STTIME, MEM_STTIME0);
-		au_writel(NAND_STADDR, MEM_STADDR0);
+	pd = pdev->dev.platform_data;
+	if (!pd) {
+		dev_err(&pdev->dev, "missing platform data\n");
+		return -ENODEV;
 	}
-	if (NAND_CS == 1) {
-		au_writel(NAND_STCFG,  MEM_STCFG1);
-		au_writel(NAND_STTIME, MEM_STTIME1);
-		au_writel(NAND_STADDR, MEM_STADDR1);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		dev_err(&pdev->dev, "no memory for NAND context\n");
+		return -ENOMEM;
 	}
-	if (NAND_CS == 2) {
-		au_writel(NAND_STCFG,  MEM_STCFG2);
-		au_writel(NAND_STTIME, MEM_STTIME2);
-		au_writel(NAND_STADDR, MEM_STADDR2);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "no NAND memory resource\n");
+		ret = -ENODEV;
+		goto out1;
 	}
-	if (NAND_CS == 3) {
-		au_writel(NAND_STCFG,  MEM_STCFG3);
-		au_writel(NAND_STTIME, MEM_STTIME3);
-		au_writel(NAND_STADDR, MEM_STADDR3);
+	if (request_mem_region(r->start, resource_size(r), "au1550-nand")) {
+		dev_err(&pdev->dev, "cannot claim NAND memory area\n");
+		ret = -ENOMEM;
+		goto out1;
 	}
-#endif
-
-	/* Locate NAND chip-select in order to determine NAND phys address */
-	mem_staddr = 0x00000000;
-	if (((au_readl(MEM_STCFG0) & 0x7) == 0x5) && (NAND_CS == 0))
-		mem_staddr = au_readl(MEM_STADDR0);
-	else if (((au_readl(MEM_STCFG1) & 0x7) == 0x5) && (NAND_CS == 1))
-		mem_staddr = au_readl(MEM_STADDR1);
-	else if (((au_readl(MEM_STCFG2) & 0x7) == 0x5) && (NAND_CS == 2))
-		mem_staddr = au_readl(MEM_STADDR2);
-	else if (((au_readl(MEM_STCFG3) & 0x7) == 0x5) && (NAND_CS == 3))
-		mem_staddr = au_readl(MEM_STADDR3);
-
-	if (mem_staddr == 0x00000000) {
-		printk("Au1xxx NAND: ERROR WITH NAND CHIP-SELECT\n");
-		kfree(au1550_mtd);
-		return 1;
+
+	ctx->base = ioremap_nocache(r->start, 0x1000);
+	if (!ctx->base) {
+		dev_err(&pdev->dev, "cannot remap NAND memory area\n");
+		ret = -ENODEV;
+		goto out2;
 	}
-	nand_phys = (mem_staddr << 4) & 0xFFFC0000;
 
-	p_nand = ioremap(nand_phys, 0x1000);
+	this = &ctx->chip;
+	ctx->info.priv = this;
+	ctx->info.owner = THIS_MODULE;
 
-	/* make controller and MTD agree */
-	if (NAND_CS == 0)
-		nand_width = au_readl(MEM_STCFG0) & (1 << 22);
-	if (NAND_CS == 1)
-		nand_width = au_readl(MEM_STCFG1) & (1 << 22);
-	if (NAND_CS == 2)
-		nand_width = au_readl(MEM_STCFG2) & (1 << 22);
-	if (NAND_CS == 3)
-		nand_width = au_readl(MEM_STCFG3) & (1 << 22);
+	/* figure out which CS# r->start belongs to */
+	cs = find_nand_cs(r->start);
+	if (cs < 0) {
+		dev_err(&pdev->dev, "cannot detect NAND chipselect\n");
+		ret = -ENODEV;
+		goto out3;
+	}
+	ctx->cs = cs;
 
-	/* Set address of hardware control function */
 	this->dev_ready = au1550_device_ready;
 	this->select_chip = au1550_select_chip;
 	this->cmdfunc = au1550_command;
@@ -568,54 +513,67 @@ static int __init au1xxx_nand_init(void)
 
 	this->options = NAND_NO_AUTOINCR;
 
-	if (!nand_width)
+	if (pd->devwidth)
 		this->options |= NAND_BUSWIDTH_16;
 
-	this->read_byte = (!nand_width) ? au_read_byte16 : au_read_byte;
-	au1550_write_byte = (!nand_width) ? au_write_byte16 : au_write_byte;
+	this->read_byte = (pd->devwidth) ? au_read_byte16 : au_read_byte;
+	ctx->write_byte = (pd->devwidth) ? au_write_byte16 : au_write_byte;
 	this->read_word = au_read_word;
-	this->write_buf = (!nand_width) ? au_write_buf16 : au_write_buf;
-	this->read_buf = (!nand_width) ? au_read_buf16 : au_read_buf;
-	this->verify_buf = (!nand_width) ? au_verify_buf16 : au_verify_buf;
-
-	/* Scan to find existence of the device */
-	if (nand_scan(au1550_mtd, 1)) {
-		retval = -ENXIO;
-		goto outio;
+	this->write_buf = (pd->devwidth) ? au_write_buf16 : au_write_buf;
+	this->read_buf = (pd->devwidth) ? au_read_buf16 : au_read_buf;
+	this->verify_buf = (pd->devwidth) ? au_verify_buf16 : au_verify_buf;
+
+	ret = nand_scan(&ctx->info, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "NAND scan failed with %d\n", ret);
+		goto out3;
 	}
 
-	/* Register the partitions */
-	mtd_device_register(au1550_mtd, partition_info,
-			    ARRAY_SIZE(partition_info));
+	mtd_device_register(&ctx->info, pd->parts, pd->num_parts);
 
 	return 0;
 
- outio:
-	iounmap(p_nand);
-
- outmem:
-	kfree(au1550_mtd);
-	return retval;
+out3:
+	iounmap(ctx->base);
+out2:
+	release_mem_region(r->start, resource_size(r));
+out1:
+	kfree(ctx);
+	return ret;
 }
 
-module_init(au1xxx_nand_init);
-
-/*
- * Clean up routine
- */
-static void __exit au1550_cleanup(void)
+static int __devexit au1550nd_remove(struct platform_device *pdev)
 {
-	/* Release resources, unregister device */
-	nand_release(au1550_mtd);
-
-	/* Free the MTD device structure */
-	kfree(au1550_mtd);
+	struct au1550nd_ctx *ctx = platform_get_drvdata(pdev);
+	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	/* Unmap */
-	iounmap(p_nand);
+	nand_release(&ctx->info);
+	iounmap(ctx->base);
+	release_mem_region(r->start, 0x1000);
+	kfree(ctx);
+	return 0;
 }
 
-module_exit(au1550_cleanup);
+static struct platform_driver au1550nd_driver = {
+	.driver = {
+		.name	= "au1550-nand",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= au1550nd_probe,
+	.remove		= __devexit_p(au1550nd_remove),
+};
+
+static int __init au1550nd_load(void)
+{
+	return platform_driver_register(&au1550nd_driver);
+};
+
+static void __exit au1550nd_exit(void)
+{
+	platform_driver_unregister(&au1550nd_driver);
+};
+module_init(au1550nd_load);
+module_exit(au1550nd_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Embedded Edge, LLC");
-- 
1.7.7.1
