Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2009 08:17:10 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:38299 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21365915AbZBLIRI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Feb 2009 08:17:08 +0000
Received: (qmail 3688 invoked by uid 1000); 12 Feb 2009 09:17:07 +0100
Date:	Thu, 12 Feb 2009 09:17:07 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Frank Neuber <linux-mips@kernelport.de>
Cc:	borasah@gmail.com, linux-mips@linux-mips.org
Subject: Re: Au1200 and NAND Flash - K9F1G08U0A -
Message-ID: <20090212081707.GA3656@roarinelk.homelinux.net>
References: <200705192213.12019.borasah@gmail.com> <1234425337.12847.124.camel@t60p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1234425337.12847.124.camel@t60p>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Thu, Feb 12, 2009 at 08:55:37AM +0100, Frank Neuber wrote:
> Hi Bora,
> I have the same problem here.
> Did you find a solution for this nand large page device.
> I tried to copy nand_command_lp from nand_base.c and added the -CE stuff
> including disabling interrupts during read.
> The result is that I found just one bad block during scan :-). Also
> erasing nand seems to be possible (usinf eraseall /dev/mtdX).
> But if I write and read back the data (using dd) I get io errors :-(
> 
> I found your posting on this list wihout an answer so I hope you was
> able to manage the nand stuff.

Here's the NAND portion of a DB1200 board support rewrite I did a while
ago.  It uses gen_nand instead of the au1550nd.c driver (which seems to
only work on the Db1550 and small page devices).  It shouls also work on
any Au1550 since the Au1200 has identical NAND hardware.

---------- 8< --------------------------- 8< ---------------------


#include <linux/mtd/mtd.h>
#include <linux/mtd/nand.h>
#include <linux/mtd/partitions.h>

[...]

static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
				 unsigned int ctrl)
{
	struct nand_chip *this = mtd->priv;
	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;

	ioaddr &= 0xffffff00;

	if (ctrl & NAND_CLE) {
		ioaddr += MEM_STNAND_CMD;
	} else if (ctrl & NAND_ALE) {
		ioaddr += MEM_STNAND_ADDR;
	} else {
		/* assume we want to r/w real data  by default */
		ioaddr += MEM_STNAND_DATA;
	}
	this->IO_ADDR_R = this->IO_ADDR_W = (void __iomem *)ioaddr;
	if (cmd != NAND_CMD_NONE) {
		au_writeb(cmd, ioaddr);
		au_sync();
	}
}

static int au1200_nand_device_ready(struct mtd_info *mtd)
{
	return au_readl(MEM_STSTAT) & 1;
}

static const char *db1200_part_probes[] = { "cmdlinepart", NULL };

static struct mtd_partition db1200_nand_parts[] = {
	{
		.name	= "NAND FS 0",
		.offset	= 0,
		.size	= 8 * 1024 * 1024,
	},
	{
		.name	= "NAND FS 1",
		.offset	= MTDPART_OFS_APPEND,
		.size	= MTDPART_SIZ_FULL
	},
};

struct platform_nand_data db1200_nand_platdata = {
	.chip = {
		.nr_chips	= 1,
		.chip_offset	= 0,
		.nr_partitions	= ARRAY_SIZE(db1200_nand_parts),
		.partitions	= db1200_nand_parts,
		.chip_delay	= 20,
		.part_probe_types = db1200_part_probes,
	},
	.ctrl = {
		.hwcontrol	= 0,
		.dev_ready	= au1200_nand_device_ready,
		.select_chip	= 0,
		.cmd_ctrl	= au1200_nand_cmd_ctrl,
	},
};

static struct resource db1200_nand_res[] = {
	[0] = {
		.start	= 0x20000000,
		.end	= 0x200000ff,
		.flags	= IORESOURCE_MEM,
	},
};

static struct platform_device nand_dev = {
	.name		= "gen_nand",
	.num_resources	= ARRAY_SIZE(db1200_nand_res),
	.resource	= db1200_nand_res,
	.id		= -1,
	.dev		= {
		.platform_data = &db1200_nand_platdata,
	}
};

[...]

static struct platform_device *db1200_devs[] __initdata = {
  [...]
	&nand_dev,
  [...]
};

-------------------- 8< ------------------------ 8< -------------------


Best regards,
	Manuel Lauss
