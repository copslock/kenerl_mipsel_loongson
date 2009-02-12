Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2009 08:40:53 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:38785 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366776AbZBLIkv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Feb 2009 08:40:51 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 23C988F849D;
	Thu, 12 Feb 2009 09:40:46 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yApfMzelmQ6s; Thu, 12 Feb 2009 09:40:46 +0100 (CET)
Received: from [10.1.1.26] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id A311D8F849C;
	Thu, 12 Feb 2009 09:40:44 +0100 (CET)
Subject: Re: Au1200 and NAND Flash - K9F1G08U0A -
From:	Frank Neuber <linux-mips@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	borasah@gmail.com, linux-mips@linux-mips.org
In-Reply-To: <20090212081707.GA3656@roarinelk.homelinux.net>
References: <200705192213.12019.borasah@gmail.com>
	 <1234425337.12847.124.camel@t60p>
	 <20090212081707.GA3656@roarinelk.homelinux.net>
Content-Type: text/plain
Date:	Thu, 12 Feb 2009 09:40:43 +0100
Message-Id: <1234428043.12847.138.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Thank you for this very quick answer ...

Am Donnerstag, den 12.02.2009, 09:17 +0100 schrieb Manuel Lauss:
> Here's the NAND portion of a DB1200 board support rewrite I did a while
> ago.  It uses gen_nand instead of the au1550nd.c driver (which seems to
I saw this gen_nand (plat_nand.c) never before (because it is not
configurable in the Makefile)

> only work on the Db1550 and small page devices).  It shouls also work on
> any Au1550 since the Au1200 has identical NAND hardware.
Do I understand right, this is not a handmade patch aginst
plat_nand.c ? 

I try to mix this code now with the plat_nand.c, rigth?

Kind regards,
 Frank

> 
> ---------- 8< --------------------------- 8< ---------------------
> 
> 
> #include <linux/mtd/mtd.h>
> #include <linux/mtd/nand.h>
> #include <linux/mtd/partitions.h>
> 
> [...]
> 
> static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> 				 unsigned int ctrl)
> {
> 	struct nand_chip *this = mtd->priv;
> 	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
> 
> 	ioaddr &= 0xffffff00;
> 
> 	if (ctrl & NAND_CLE) {
> 		ioaddr += MEM_STNAND_CMD;
> 	} else if (ctrl & NAND_ALE) {
> 		ioaddr += MEM_STNAND_ADDR;
> 	} else {
> 		/* assume we want to r/w real data  by default */
> 		ioaddr += MEM_STNAND_DATA;
> 	}
> 	this->IO_ADDR_R = this->IO_ADDR_W = (void __iomem *)ioaddr;
> 	if (cmd != NAND_CMD_NONE) {
> 		au_writeb(cmd, ioaddr);
> 		au_sync();
> 	}
> }
> 
> static int au1200_nand_device_ready(struct mtd_info *mtd)
> {
> 	return au_readl(MEM_STSTAT) & 1;
> }
> 
> static const char *db1200_part_probes[] = { "cmdlinepart", NULL };
> 
> static struct mtd_partition db1200_nand_parts[] = {
> 	{
> 		.name	= "NAND FS 0",
> 		.offset	= 0,
> 		.size	= 8 * 1024 * 1024,
> 	},
> 	{
> 		.name	= "NAND FS 1",
> 		.offset	= MTDPART_OFS_APPEND,
> 		.size	= MTDPART_SIZ_FULL
> 	},
> };
> 
> struct platform_nand_data db1200_nand_platdata = {
> 	.chip = {
> 		.nr_chips	= 1,
> 		.chip_offset	= 0,
> 		.nr_partitions	= ARRAY_SIZE(db1200_nand_parts),
> 		.partitions	= db1200_nand_parts,
> 		.chip_delay	= 20,
> 		.part_probe_types = db1200_part_probes,
> 	},
> 	.ctrl = {
> 		.hwcontrol	= 0,
> 		.dev_ready	= au1200_nand_device_ready,
> 		.select_chip	= 0,
> 		.cmd_ctrl	= au1200_nand_cmd_ctrl,
> 	},
> };
> 
> static struct resource db1200_nand_res[] = {
> 	[0] = {
> 		.start	= 0x20000000,
> 		.end	= 0x200000ff,
> 		.flags	= IORESOURCE_MEM,
> 	},
> };
> 
> static struct platform_device nand_dev = {
> 	.name		= "gen_nand",
> 	.num_resources	= ARRAY_SIZE(db1200_nand_res),
> 	.resource	= db1200_nand_res,
> 	.id		= -1,
> 	.dev		= {
> 		.platform_data = &db1200_nand_platdata,
> 	}
> };
> 
> [...]
> 
> static struct platform_device *db1200_devs[] __initdata = {
>   [...]
> 	&nand_dev,
>   [...]
> };
> 
> -------------------- 8< ------------------------ 8< -------------------
> 
> 
> Best regards,
> 	Manuel Lauss
> 
