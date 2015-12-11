Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 01:05:56 +0100 (CET)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35866 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008420AbbLKAFyE1gRz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Dec 2015 01:05:54 +0100
Received: by pfbu66 with SMTP id u66so12111186pfb.3;
        Thu, 10 Dec 2015 16:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pFP7RfWsw/5dNFKzHpCuDB/AOb1TxP03yZK2oL20AJo=;
        b=bMK7YGaB40kFNZIBDUVti+D+Rk1uGOPoJf0NMG0+9Q/3o3kKJ8jdvqRz/W4BCDrd7j
         HxoYZFu7/eWeU8LoB8Nbb/prbQ/Q9LTIav0ssZLFLzmsEb1P4kIPOulU0sInH1zMJ2cH
         Vyk+qs9tcmeFSptn/OYFPYFjGCGD0kBLIPb+C1pFD+QlP9lS4dNSrbHdt56J9rz5mA/3
         CpIJpomlZG+bviSgiLvZodJNaGM1/RAJQ4pGDewv9J/XwCCuVzcB7+LRO1gOhkggh1se
         jF5jWeGUCnXcwzz/ujllzb+slaAGrZbvd7gKGqTYevzepGh9WdsYpJibT4AJ1yyJ4UBU
         45wg==
X-Received: by 10.98.66.80 with SMTP id p77mr11004295pfa.100.1449792348050;
        Thu, 10 Dec 2015 16:05:48 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:f98c:4263:2b78:8c60])
        by smtp.gmail.com with ESMTPSA id hw7sm21201250pac.12.2015.12.10.16.05.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Dec 2015 16:05:47 -0800 (PST)
Date:   Thu, 10 Dec 2015 16:05:44 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Jonas Gorski <jogo@openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH linux-next (v2) 3/3] mtd: part: Add BCM962368 CFE
 partitioning support
Message-ID: <20151211000544.GO144338@google.com>
References: <566A04FB.7000104@simon.arlott.org.uk>
 <566A0655.5080606@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566A0655.5080606@simon.arlott.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Thu, Dec 10, 2015 at 11:10:13PM +0000, Simon Arlott wrote:
> Add partitioning support for BCM963268 boards with CFE bootloaders.
> The following partitions are defined:
>   "boot":           CFE and nvram data
>   "rootfs":         Currently selected rootfs
>   "data":           Configuration data
>   "rootfs1_update": Container for the whole flash area used
>                     for the first rootfs to allow it to be
>                     updated.
>   "rootfs2_update": Container for the whole flash area used
>                     for the second rootfs to allow it to be
>                     updated.
>   "rootfs_other":   The other (not currently selected) rootfs
> 
> Example:
> [    1.904302] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> [    1.911000] nand: Macronix NAND 128MiB 3,3V 8-bit
> [    1.915855] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> [    1.923797] bcm6368_nand 10000200.nand: detected 128MiB total, 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, Hamming ECC
> [    1.936994] Bad block table found at page 65472, version 0x01
> [    1.944121] Bad block table found at page 65408, version 0x01
> [    1.951166] nand_read_bbt: bad block at 0x000007480000
> [    1.990043] bcm963268part: rootfs1: CFE boot tag found at 0x20000 with version 6, board type 963168VX and sequence number 2
> [    2.003060] bcm963268part: rootfs2: CFE boot tag found at 0x4000000 with version 6, board type 963168VX and sequence number 1
> [    2.015159] bcm963268part: CFE bootline selected latest image rootfs1
> [    2.022080] 6 bcm963268part partitions found on MTD device brcmnand.0
> [    2.042659] Creating 6 MTD partitions on "brcmnand.0":
> [    2.048025] 0x000000000000-0x000000020000 : "boot"
> [    2.062134] 0x000000040000-0x000001120000 : "rootfs"
> [    2.077632] 0x000007b00000-0x000007f00000 : "data"
> [    2.091363] 0x000000020000-0x000003ac0000 : "rootfs1_update"
> [    2.106228] 0x000004000000-0x000007ac0000 : "rootfs2_update"
> [    2.121093] 0x000004020000-0x000005060000 : "rootfs_other"
> 
> The nvram contains the offset and size of the boot, rootfs1, rootfs2
> and data partitions. The presence of CFE and nvram is verified by
> reading from the boot partition which is assumed to be at offset 0
> and the process aborts if the nvram read indicates that this is not
> the case.
> 
> There is bcm_tag information at the start of each rootfs that is used
> to determine which rootfs is newer and what its real offset/size is.
> 
> The CFE bootline is used to select a rootfs.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
> v2: Use external struct bcm963xx_nvram definition for bcm963268part.
> 
>     Removed support for the nand partition number field, it's not a
>     standard Broadcom field (was added by MitraStar Technology Corp.).
> 
>  drivers/mtd/Kconfig         |  21 +++
>  drivers/mtd/Makefile        |   1 +
>  drivers/mtd/bcm963268part.c | 326 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 348 insertions(+)
>  create mode 100644 drivers/mtd/bcm963268part.c
> 
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 42cc953..63cb2db 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -148,6 +148,27 @@ config MTD_BCM63XX_PARTS
>  	  This provides partions parsing for BCM63xx devices with CFE
>  	  bootloaders.
>  
> +config MTD_BCM963268_PARTS
> +	tristate "BCM963268 CFE partitioning support"
> +	depends on BMIPS_GENERIC

It'd be nice if this didn't hard-depend on MIPS. Can we do COMPILE_TEST?

> +	select CRC32
> +	help
> +	  This provides partitions parsing for BCM963268 boards with CFE
> +	  bootloaders. The following partitions are defined:
> +	    "boot":           CFE and nvram data
> +	    "rootfs":         Currently selected rootfs
> +	    "data":           Configuration data
> +	    "rootfs1_update": Container for the whole flash area used
> +	                      for the first rootfs to allow it to be
> +	                      updated.
> +	    "rootfs2_update": Container for the whole flash area used
> +	                      for the second rootfs to allow it to be
> +	                      updated.
> +	    "rootfs_other":   The other (not currently selected) rootfs
> +
> +	  A decision is made regarding which of the two rootfs is to be
> +	  used based on the nvram data.
> +
>  config MTD_BCM47XX_PARTS
>  	tristate "BCM47XX partitioning support"
>  	depends on BCM47XX || ARCH_BCM_5301X
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index 99bb9a1..f0f4140 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_MTD_CMDLINE_PARTS) += cmdlinepart.o
>  obj-$(CONFIG_MTD_AFS_PARTS)	+= afs.o
>  obj-$(CONFIG_MTD_AR7_PARTS)	+= ar7part.o
>  obj-$(CONFIG_MTD_BCM63XX_PARTS)	+= bcm63xxpart.o
> +obj-$(CONFIG_MTD_BCM963268_PARTS) += bcm963268part.o
>  obj-$(CONFIG_MTD_BCM47XX_PARTS)	+= bcm47xxpart.o
>  
>  # 'Users' - code which presents functionality to userspace.
> diff --git a/drivers/mtd/bcm963268part.c b/drivers/mtd/bcm963268part.c
> new file mode 100644
> index 0000000..a519499
> --- /dev/null
> +++ b/drivers/mtd/bcm963268part.c
> @@ -0,0 +1,326 @@

...

> +static bool bcm963268_parse_rootfs_tag(struct mtd_info *master,
> +	const char *name, loff_t rootfs_part, u64 *rootfs_offset,
> +	u64 *rootfs_size, unsigned int *rootfs_sequence)
> +{
> +	struct bcm_tag *buf;
> +	int ret;
> +	size_t retlen;
> +	u32 computed_crc;
> +	bool rootfs_ok = false;
> +
> +	*rootfs_offset = 0;
> +	*rootfs_size = 0;
> +	*rootfs_sequence = 0;
> +
> +	buf = vmalloc(sizeof(struct bcm_tag));
> +	if (!buf)
> +		goto out;
> +
> +	ret = mtd_read(master, rootfs_part, sizeof(*buf), &retlen, (void *)buf);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (retlen != sizeof(*buf))
> +		goto out;
> +
> +	computed_crc = crc32_le(IMAGETAG_CRC_START, (u8 *)buf,
> +				offsetof(struct bcm_tag, header_crc));
> +	if (computed_crc == buf->header_crc) {
> +		char *board_id = &buf->board_id[0];
> +		char *tag_version = &buf->tag_version[0];
> +
> +		/* Get rootfs offset and size from tag data */
> +		kstrtou64(buf->flash_image_start, 10, rootfs_offset);
> +		kstrtou64(buf->root_length, 10, rootfs_size);
> +		kstrtouint(buf->dual_image, 10, rootfs_sequence);

drivers/mtd/bcm963268part.c: In function 'bcm963268_parse_rootfs_tag':
drivers/mtd/bcm963268part.c:186:12: warning: ignoring return value of 'kstrtou64', declared with attribute warn_unused_result [-Wunused-result]
drivers/mtd/bcm963268part.c:187:12: warning: ignoring return value of 'kstrtou64', declared with attribute warn_unused_result [-Wunused-result]
drivers/mtd/bcm963268part.c:188:13: warning: ignoring return value of 'kstrtouint', declared with attribute warn_unused_result [-Wunused-result]

Fixing these warnings should improve your robustness against malformed
input.

> +
> +		pr_info("%s: CFE boot tag found at 0x%llx with version %s, board type %s and sequence number %u\n",
> +			name, rootfs_part, tag_version, board_id,
> +			*rootfs_sequence);
> +
> +		/* Adjust for flash offset */
> +		*rootfs_offset -= BCM63XX_EXTENDED_SIZE;
> +
> +		/* Remove bcm_tag data from length */
> +		*rootfs_size -= *rootfs_offset - rootfs_part;
> +
> +		rootfs_ok = true;
> +	} else {
> +		pr_warn("%s: CFE boot tag at 0x%llx CRC invalid (expected %08x, actual %08x)\n",
> +			name, rootfs_part, buf->header_crc, computed_crc);
> +		goto out;
> +	}
> +
> +out:
> +	vfree(buf);
> +	return rootfs_ok;
> +}

Brian
