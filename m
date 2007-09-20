Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 17:53:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:32669 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023107AbXITQx1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 17:53:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8KGrPpJ005053;
	Thu, 20 Sep 2007 17:53:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8KGrMXT005052;
	Thu, 20 Sep 2007 17:53:22 +0100
Date:	Thu, 20 Sep 2007 17:53:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
Message-ID: <20070920165322.GH5522@linux-mips.org>
References: <200709201728.10866.technoboy85@gmail.com> <200709201755.06712.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709201755.06712.technoboy85@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 20, 2007 at 05:55:06PM +0200, Matteo Croce wrote:

> Signed-off-by: Matteo Croce <technoboy85@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
> 
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index fbec8cd..c1b2508 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -150,6 +150,12 @@ config MTD_AFS_PARTS
>  	  for your particular device. It won't happen automatically. The
>  	  'armflash' map driver (CONFIG_MTD_ARMFLASH) does this, for example.
>  
> +config MTD_AR7_PARTS
> +	tristate "TI AR7 partitioning support"
> +	depends on MTD_PARTITIONS
> +	---help---
> +	  TI AR7 partitioning support
> +
>  comment "User Modules And Translation Layers"
>  
>  config MTD_CHAR
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index 6d958a4..8451c64 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_MTD_CONCAT)	+= mtdconcat.o
>  obj-$(CONFIG_MTD_REDBOOT_PARTS) += redboot.o
>  obj-$(CONFIG_MTD_CMDLINE_PARTS) += cmdlinepart.o
>  obj-$(CONFIG_MTD_AFS_PARTS)	+= afs.o
> +obj-$(CONFIG_MTD_AR7_PARTS)	+= ar7part.o
>  
>  # 'Users' - code which presents functionality to userspace.
>  obj-$(CONFIG_MTD_CHAR)		+= mtdchar.o
> diff --git a/drivers/mtd/ar7part.c b/drivers/mtd/ar7part.c
> new file mode 100644
> index 0000000..775041d
> --- /dev/null
> +++ b/drivers/mtd/ar7part.c
> @@ -0,0 +1,142 @@
> +/*
> + * Copyright (C) 2007 Eugene Konev <ejka@openwrt.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * TI AR7 flash partition table.
> + * Based on ar7 map by Felix Fietkau <nbd@openwrt.org>
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/bootmem.h>
> +#include <linux/squashfs_fs.h>

There is no such header file so this won't build ...

> +struct ar7_bin_rec {
> +	unsigned int checksum;
> +	unsigned int length;
> +	unsigned int address;
> +};
> +
> +static struct mtd_partition ar7_parts[5];
> +
> +static int create_mtd_partitions(struct mtd_info *master,
> +				 struct mtd_partition **pparts,
> +				 unsigned long origin)
> +{
> +	struct ar7_bin_rec header;
> +	unsigned int offset, len;
> +	unsigned int pre_size = master->erasesize, post_size = 0;
> +	unsigned int root_offset = 0xe0000;
> +
> +	int retries = 10;
> +
> +	printk(KERN_INFO "Parsing AR7 partition map...\n");
> +
> +	ar7_parts[0].name = "loader";
> +	ar7_parts[0].offset = 0;
> +	ar7_parts[0].size = master->erasesize;
> +	ar7_parts[0].mask_flags = MTD_WRITEABLE;
> +
> +	ar7_parts[1].name = "config";
> +	ar7_parts[1].offset = 0;
> +	ar7_parts[1].size = master->erasesize;
> +	ar7_parts[1].mask_flags = 0;
> +
> +	do { /* Try 10 blocks starting from master->erasesize */
> +		offset = pre_size;
> +		master->read(master, offset,
> +			sizeof(header), &len, (u_char *)&header);

The u_char type is deprecated.  Use u8 from <linux/types.h> or unsigned char
instead.

> +		if (!strncmp((char *)&header, "TIENV0.8", 8))
> +			ar7_parts[1].offset = pre_size;
> +		if (header.checksum == 0xfeedfa42)
> +			break;
> +		if (header.checksum == 0xfeed1281)
> +			break;
> +		pre_size += master->erasesize;
> +	} while (retries--);
> +
> +	pre_size = offset;
> +
> +	if (!ar7_parts[1].offset) {
> +		ar7_parts[1].offset = master->size - master->erasesize;
> +		post_size = master->erasesize;
> +	}
> +
> +	switch (header.checksum) {
> +	case 0xfeedfa42:
> +		while (header.length) {
> +			offset += sizeof(header) + header.length;
> +			master->read(master, offset, sizeof(header),
> +				     &len, (u_char *)&header);
> +		}
> +		root_offset = offset + sizeof(header) + 4;
> +		break;
> +	case 0xfeed1281:
> +		while (header.length) {
> +			offset += sizeof(header) + header.length;
> +			master->read(master, offset, sizeof(header),
> +				     &len, (u_char *)&header);
> +		}
> +		root_offset = offset + sizeof(header) + 4 + 0xff;
> +		root_offset &= ~(u32)0xff;
> +		break;
> +	default:
> +		printk(KERN_WARNING "Unknown magic: %08x\n", header.checksum);
> +		break;
> +	}
> +
> +	master->read(master, root_offset,
> +		sizeof(header), &len, (u_char *)&header);
> +	if (header.checksum != SQUASHFS_MAGIC) {
> +		root_offset += master->erasesize - 1;
> +		root_offset &= ~(master->erasesize - 1);
> +	}
> +
> +	ar7_parts[2].name = "linux";
> +	ar7_parts[2].offset = pre_size;
> +	ar7_parts[2].size = master->size - pre_size - post_size;
> +	ar7_parts[2].mask_flags = 0;
> +
> +	ar7_parts[3].name = "rootfs";
> +	ar7_parts[3].offset = root_offset;
> +	ar7_parts[3].size = master->size - root_offset - post_size;
> +	ar7_parts[3].mask_flags = 0;
> +
> +	*pparts = ar7_parts;
> +	return 4;
> +}
> +
> +static struct mtd_part_parser ar7_parser = {
> +	.owner = THIS_MODULE,
> +	.parse_fn = create_mtd_partitions,
> +	.name = "ar7part",
> +};
> +
> +static int __init ar7_parser_init(void)
> +{
> +	return register_mtd_parser(&ar7_parser);
> +}
> +
> +module_init(ar7_parser_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR(	"Felix Fietkau <nbd@openwrt.org>, "
> +		"Eugene Konev <ejka@openwrt.org>");
> +MODULE_DESCRIPTION("MTD partitioning for TI AR7");

  Ralf
