Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Dec 2015 00:13:01 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:40606 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008262AbbLKXM63DZSa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Dec 2015 00:12:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id CDC9628A5E2;
        Sat, 12 Dec 2015 00:12:34 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com [209.85.215.53])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 800C128741D;
        Sat, 12 Dec 2015 00:12:19 +0100 (CET)
Received: by lfap203 with SMTP id p203so20594827lfa.0;
        Fri, 11 Dec 2015 15:12:30 -0800 (PST)
X-Received: by 10.25.209.148 with SMTP id i142mr9053677lfg.163.1449875550679;
 Fri, 11 Dec 2015 15:12:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.162.78 with HTTP; Fri, 11 Dec 2015 15:12:11 -0800 (PST)
In-Reply-To: <566B47D9.8020105@simon.arlott.org.uk>
References: <566B460F.1040603@simon.arlott.org.uk> <566B47D9.8020105@simon.arlott.org.uk>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 12 Dec 2015 00:12:11 +0100
X-Gmail-Original-Message-ID: <CAOiHx==GSwCxWmaQfmHHumGu_ye6waf-DA_5+m8_Ukc1hVeBYg@mail.gmail.com>
Message-ID: <CAOiHx==GSwCxWmaQfmHHumGu_ye6waf-DA_5+m8_Ukc1hVeBYg@mail.gmail.com>
Subject: Re: [PATCH linux-next (v3) 3/3] mtd: part: Add BCM962368 CFE
 partitioning support
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,

On Fri, Dec 11, 2015 at 11:02 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
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

This isn't BCM963268 specific, this is BCM63XX NAND specific and used
since the first SoC with a NAND controller (BCM6368).

>
> Example:
> [    1.904302] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> [    1.911000] nand: Macronix NAND 128MiB 3,3V 8-bit
> [    1.915855] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> [    1.923797] bcm6368_nand 10000200.nand: detected 128MiB total, 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, Hamming ECC
> [    1.936994] Bad block table found at page 65472, version 0x01
> [    1.944121] Bad block table found at page 65408, version 0x01
> [    1.951166] nand_read_bbt: bad block at 0x000007480000
> [    1.969377] bcm963268part: rootfs1: CFE boot tag found at 0x20000 with version 6, board type 963168VX
> [    1.980690] bcm963268part: rootfs2: CFE boot tag found at 0x4000000 with version 6, board type 963168VX
> [    1.990801] bcm963268part: CFE bootline selected latest image rootfs1 (rootfs1_seq=2, rootfs2_seq=1)
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
> v3: Use COMPILE_TEST.
>
>     Ensure that strings read from flash are null terminated and validate
>     bcm_tag integer values (this also moves reporting of rootfs sequence
>     numbers to later on).
>
> v2: Use external struct bcm963xx_nvram definition for bcm963268part.
>
>     Removed support for the nand partition number field, it's not a
>     standard Broadcom field (was added by MitraStar Technology Corp.).
>
>  drivers/mtd/Kconfig         |  21 +++
>  drivers/mtd/Makefile        |   1 +
>  drivers/mtd/bcm963268part.c | 350 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 372 insertions(+)
>  create mode 100644 drivers/mtd/bcm963268part.c
>
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 42cc953..8209730 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -148,6 +148,27 @@ config MTD_BCM63XX_PARTS
>           This provides partions parsing for BCM63xx devices with CFE
>           bootloaders.
>
> +config MTD_BCM963268_PARTS
> +       tristate "BCM963268 CFE partitioning support"
> +       depends on BMIPS_GENERIC || COMPILE_TEST

Since you include from arch/mips/include, this will fail to compile on
everything != MIPS

> +       select CRC32
> +       help
> +         This provides partitions parsing for BCM963268 boards with CFE
> +         bootloaders. The following partitions are defined:
> +           "boot":           CFE and nvram data
> +           "rootfs":         Currently selected rootfs
> +           "data":           Configuration data
> +           "rootfs1_update": Container for the whole flash area used
> +                             for the first rootfs to allow it to be
> +                             updated.
> +           "rootfs2_update": Container for the whole flash area used
> +                             for the second rootfs to allow it to be
> +                             updated.
> +           "rootfs_other":   The other (not currently selected) rootfs
> +
> +         A decision is made regarding which of the two rootfs is to be
> +         used based on the nvram data.
> +
>  config MTD_BCM47XX_PARTS
>         tristate "BCM47XX partitioning support"
>         depends on BCM47XX || ARCH_BCM_5301X
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index 99bb9a1..f0f4140 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_MTD_CMDLINE_PARTS) += cmdlinepart.o
>  obj-$(CONFIG_MTD_AFS_PARTS)    += afs.o
>  obj-$(CONFIG_MTD_AR7_PARTS)    += ar7part.o
>  obj-$(CONFIG_MTD_BCM63XX_PARTS)        += bcm63xxpart.o
> +obj-$(CONFIG_MTD_BCM963268_PARTS) += bcm963268part.o
>  obj-$(CONFIG_MTD_BCM47XX_PARTS)        += bcm47xxpart.o
>
>  # 'Users' - code which presents functionality to userspace.
> diff --git a/drivers/mtd/bcm963268part.c b/drivers/mtd/bcm963268part.c
> new file mode 100644
> index 0000000..2740a48
> --- /dev/null
> +++ b/drivers/mtd/bcm963268part.c
> @@ -0,0 +1,350 @@
> +/*
> + * BCM963268 CFE image tag parser
> + * Copyright 2015 Simon Arlott
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
> + * Derived from drivers/mtd/bcm63xxpart.c:
> + * Copyright © 2006-2008  Florian Fainelli <florian@openwrt.org>
> + *                       Mike Albon <malbon@openwrt.org>
> + * Copyright © 2009-2010  Daniel Dickinson <openwrt@cshore.neomailbox.net>
> + * Copyright © 2011-2013  Jonas Gorski <jonas.gorski@gmail.com>
> + *
> + * Derived from bcm963xx_4.12L.06B_consumer/bcmdrivers/opensource/char/board/bcm963xx/impl1/board.c,
> + *     bcm963xx_4.12L.06B_consumer/shared/opensource/include/bcm963xx/bcm_hwdefs.h:
> + * Copyright (c) 2002 Broadcom Corporation
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/crc32.h>
> +#include <linux/if_ether.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +
> +#include <asm/mach-bcm63xx/bcm963xx_tag.h>

Why not move that one as well? Then you don't need to depend on MIPS
for COMPILE_TEST.

> +#include <uapi/linux/bcm963xx_nvram.h>
> +
> +/* Extended flash address, needs to be subtracted from bcm_tag flash offsets */
> +#define BCM63XX_EXTENDED_SIZE          0xBFC00000

This should be in bcm963xx_tag.h.
> +
> +#define BCM63XX_CFE_MAGIC_OFFSET       0x4e0
> +#define BCM963XX_CFE_VERSION_OFFSET    0x570
> +#define BCM963XX_NVRAM_OFFSET          0x580

You should decide whether you want to call it BCM63XX (the SoC) or
BCM963XX (the Board using the SoC). Also probably better served in
bcm963xx_nvram.h


> +
> +enum bcm963268_nvram_part {
> +       PART_BOOT = 0,
> +       PART_ROOTFS_1,
> +       PART_ROOTFS_2,
> +       PART_DATA,
> +       PART_BBT,
> +};

This should be in bcm963xx_nvram.h.

> +
> +/* Ensure strings read from flash structs are null terminated */
> +#define STR_NULL_TERMINATE(x) \
> +       do { char *_str = (x); _str[sizeof(x) - 1] = 0; } while (0)
> +
> +static int bcm963268_detect_cfe(struct mtd_info *master)
> +{
> +       char buf[9];
> +       int ret;
> +       size_t retlen;
> +
> +       ret = mtd_read(master, BCM963XX_CFE_VERSION_OFFSET, 5, &retlen,
> +                      (void *)buf);
> +       buf[retlen] = 0;
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       if (strncmp("cfe-v", buf, 5) == 0)
> +               return 0;
> +
> +       return -EINVAL;
> +}
> +
> +static int bcm963268_read_nvram(struct mtd_info *master,
> +       struct bcm963xx_nvram *nvram)
> +{
> +       u32 crc, expected_crc;
> +       size_t retlen;
> +       int ret;
> +
> +       /* extract nvram data */
> +       ret = mtd_read(master, BCM963XX_NVRAM_OFFSET, BCM963XX_NVRAM_V6_SIZE,
> +                       &retlen, (void *)nvram);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       if (nvram->version < 6) {
> +               pr_warn("nvram version %d not supported\n", nvram->version);
> +               return -EINVAL;
> +       }
> +
> +       /* check checksum before using data */
> +       expected_crc = nvram->checksum_v6;
> +       nvram->checksum_v6 = 0;
> +
> +       crc = crc32_le(~0, (u8 *)nvram, BCM963XX_NVRAM_V6_SIZE);
> +
> +       if (crc != expected_crc)
> +               pr_warn("nvram checksum failed, contents may be invalid (expected %08x, got %08x)\n",
> +                       expected_crc, crc);
> +
> +       return 0;
> +}
> +
> +static bool bcm963268_boot_latest(struct bcm963xx_nvram *nvram)
> +{
> +       char *p;
> +
> +       STR_NULL_TERMINATE(nvram->bootline);
> +
> +       /* Find previous image parameter "p" */
> +       if (!strncmp(nvram->bootline, "p=", 2))
> +               p = nvram->bootline;
> +       else
> +               p = strstr(nvram->bootline, " p=");
> +
> +       if (p == NULL)
> +               return true;
> +
> +       p += 2;
> +       if (*p == '\0')
> +               return true;

 '\0' is also != '0', so this check is also covered by the following comparison.

> +
> +       return *p != '0';
> +}
> +
> +static bool bcm963268_parse_rootfs_tag(struct mtd_info *master,
> +       const char *name, loff_t rootfs_part, u64 *rootfs_offset,
> +       u64 *rootfs_size, unsigned int *rootfs_sequence)
> +{
> +       struct bcm_tag *buf;
> +       int ret;
> +       size_t retlen;
> +       u32 computed_crc;
> +       bool rootfs_ok = false;
> +
> +       *rootfs_offset = 0;
> +       *rootfs_size = 0;
> +       *rootfs_sequence = 0;
> +
> +       buf = vmalloc(sizeof(struct bcm_tag));
> +       if (!buf)
> +               goto out;
> +
> +       ret = mtd_read(master, rootfs_part, sizeof(*buf), &retlen, (void *)buf);
> +       if (ret < 0)
> +               goto out;
> +
> +       if (retlen != sizeof(*buf))
> +               goto out;
> +
> +       computed_crc = crc32_le(IMAGETAG_CRC_START, (u8 *)buf,
> +                               offsetof(struct bcm_tag, header_crc));
> +       if (computed_crc == buf->header_crc) {
> +               STR_NULL_TERMINATE(buf->board_id);
> +               STR_NULL_TERMINATE(buf->tag_version);
> +
> +               pr_info("%s: CFE boot tag found at 0x%llx with version %s, board type %s\n",
> +                       name, rootfs_part, buf->tag_version, buf->board_id);
> +
> +               /* Get rootfs offset and size from tag data */
> +               STR_NULL_TERMINATE(buf->flash_image_start);
> +               if (kstrtou64(buf->flash_image_start, 10, rootfs_offset) ||
> +                               *rootfs_offset < BCM63XX_EXTENDED_SIZE) {
> +                       pr_err("%s: invalid rootfs offset: %*ph\n", name,
> +                               sizeof(buf->flash_image_start),
> +                               buf->flash_image_start);
> +                       goto out;
> +               }

what are the values for kernel(len)? if these are zero, it might make
sense to merge the two parsers, or at least have them in a single
compile unit to have them share the tag parsing code.

> +
> +               STR_NULL_TERMINATE(buf->root_length);
> +               if (kstrtou64(buf->root_length, 10, rootfs_size) ||
> +                               rootfs_size == 0) {
> +                       pr_err("%s: invalid rootfs size: %*ph\n", name,
> +                               sizeof(buf->root_length), buf->root_length);
> +                       goto out;
> +               }
> +
> +               /* Adjust for flash offset */
> +               *rootfs_offset -= BCM63XX_EXTENDED_SIZE;
> +
> +               /* Remove bcm_tag data from length */
> +               *rootfs_size -= *rootfs_offset - rootfs_part;
> +
> +               /* Get image sequence number to determine which one is newer */
> +               STR_NULL_TERMINATE(buf->dual_image);
> +               if (kstrtouint(buf->dual_image, 10, rootfs_sequence)) {

You should probably just rename and fixup the dual_image part to
image_sequence, length 4.

> +                       pr_err("%s: invalid rootfs sequence: %*ph\n", name,
> +                               sizeof(buf->dual_image), buf->dual_image);
> +                       goto out;
> +               }
> +
> +               rootfs_ok = true;
> +       } else {
> +               pr_warn("%s: CFE boot tag at 0x%llx CRC invalid (expected %08x, actual %08x)\n",
> +                       name, rootfs_part, buf->header_crc, computed_crc);
> +               goto out;
> +       }
> +
> +out:
> +       vfree(buf);
> +       return rootfs_ok;
> +}
> +
> +static int bcm963268_parse_cfe_partitions(struct mtd_info *master,
> +       const struct mtd_partition **pparts, struct mtd_part_parser_data *data)
> +{
> +       int nrparts, curpart;
> +       struct bcm963xx_nvram *nvram = NULL;
> +       struct mtd_partition *parts;
> +       u64 rootfs1_off, rootfs1_size;
> +       unsigned int rootfs1_seq;
> +       u64 rootfs2_off, rootfs2_size;
> +       unsigned int rootfs2_seq;
> +       bool rootfs1, rootfs2;
> +       bool use_first;
> +       int ret;
> +
> +       if (bcm963268_detect_cfe(master)) {
> +               ret = -EINVAL;
> +               goto out;

You haven't allocated nvram yet, just directly return -EINVAL.

> +       }
> +
> +       nvram = vzalloc(sizeof(*nvram));
> +       if (!nvram) {
> +               ret = -ENOMEM;
> +               goto out;

Similar here.

> +       }
> +
> +       if (bcm963268_read_nvram(master, nvram)) {
> +               ret = -EINVAL;

Why not pass on the return value of _read_nvram?

> +               goto out;
> +       }
> +
> +       /* We've just read the nvram from offset 0,
> +        * so it must be located there.
> +        */
> +       if (nvram->nand_part_offset[PART_BOOT] != 0) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       /* Get the rootfs partition locations */
> +       rootfs1 = bcm963268_parse_rootfs_tag(master, "rootfs1",
> +               nvram->nand_part_offset[PART_ROOTFS_1] * SZ_1K,
> +               &rootfs1_off, &rootfs1_size, &rootfs1_seq);
> +       rootfs2 = bcm963268_parse_rootfs_tag(master, "rootfs2",
> +               nvram->nand_part_offset[PART_ROOTFS_2] * SZ_1K,
> +               &rootfs2_off, &rootfs2_size, &rootfs2_seq);
> +       if (!rootfs1 && !rootfs2) {
> +               ret = -EINVAL;

While it might be nice in theory to still have the _update partitions
for flashing on an "uninitialized" flash, in practice this case is
unreachable, as CFE *needs* a working rootfs to function, and the
device is basically bricked if both are invalid.

> (snip rest)


Jonas
