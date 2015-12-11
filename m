Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 23:03:34 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:39140 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008262AbbLKWDcXQQ2c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 23:03:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id CD7C5283FE9;
        Fri, 11 Dec 2015 23:03:19 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com [209.85.215.45])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 52BFB281237;
        Fri, 11 Dec 2015 23:03:04 +0100 (CET)
Received: by lfdl133 with SMTP id l133so87033239lfd.2;
        Fri, 11 Dec 2015 14:03:15 -0800 (PST)
X-Received: by 10.25.159.130 with SMTP id i124mr8668367lfe.144.1449871395445;
 Fri, 11 Dec 2015 14:03:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.162.78 with HTTP; Fri, 11 Dec 2015 14:02:56 -0800 (PST)
In-Reply-To: <566B460F.1040603@simon.arlott.org.uk>
References: <566B460F.1040603@simon.arlott.org.uk>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 11 Dec 2015 23:02:56 +0100
X-Gmail-Original-Message-ID: <CAOiHx=m3cXTePDjH04Yoz3wQO9Ta9jSn=JrkfNgphoPcQVaGXg@mail.gmail.com>
Message-ID: <CAOiHx=m3cXTePDjH04Yoz3wQO9Ta9jSn=JrkfNgphoPcQVaGXg@mail.gmail.com>
Subject: Re: [PATCH linux-next (v3) 1/3] MIPS: bcm963xx: Add Broadcom BCM963xx
 board nvram data structure
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
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50556
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

On Fri, Dec 11, 2015 at 10:54 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
> Broadcom BCM963xx boards have multiple nvram variants across different
> SoCs with additional checksum fields added whenever the size of the
> nvram was extended.
>
> Add this structure as a header file so that multiple drivers and userspace
> can use it.
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
> v3: Fix includes/type names, add comments explaining the nvram struct.
>
> v2: Use external struct bcm963xx_nvram definition for bcm963268part.
>
>  MAINTAINERS                         |  1 +
>  include/uapi/linux/bcm963xx_nvram.h | 53 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 include/uapi/linux/bcm963xx_nvram.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b6d4e2e..abf18b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2393,6 +2393,7 @@ F:        drivers/irqchip/irq-bcm63*
>  F:     drivers/irqchip/irq-bcm7*
>  F:     drivers/irqchip/irq-brcmstb*
>  F:     include/linux/bcm63xx_wdt.h
> +F:     include/uapi/linux/bcm963xx_nvram.h
>
>  BROADCOM TG3 GIGABIT ETHERNET DRIVER
>  M:     Prashant Sreedharan <prashant@broadcom.com>
> diff --git a/include/uapi/linux/bcm963xx_nvram.h b/include/uapi/linux/bcm963xx_nvram.h
> new file mode 100644
> index 0000000..2dcb307
> --- /dev/null
> +++ b/include/uapi/linux/bcm963xx_nvram.h

Why uapi? The nvram layout isn't really enforced to be that way, and
at least Huawei uses a modified one on some devices (in case you
wondered why bcm63xx doesn't fail a crc32-"broken" one), so IMHO it
should be kept for in-kernel use only.

> @@ -0,0 +1,53 @@
> +#ifndef _UAPI__LINUX_BCM963XX_NVRAM_H__
> +#define _UAPI__LINUX_BCM963XX_NVRAM_H__
> +
> +#include <linux/types.h>
> +#include <linux/if_ether.h>
> +
> +/*
> + * Broadcom BCM963xx SoC board nvram data structure.
> + *
> + * The nvram structure varies in size depending on the SoC board version. Use
> + * the appropriate minimum BCM963XX_NVRAM_*_SIZE define for the information
> + * you need instead of sizeof(struct bcm963xx_nvram) as this may change.
> + *
> + * The "version" field value maps directly to the size and checksum names, e.g.
> + * version 4 uses "checksum_v4" and the data is BCM963XX_NVRAM_V4_SIZE bytes.
> + *
> + * Do not use the __reserved fields, especially not as an offset for CRC
> + * calculations (use BCM963XX_NVRAM_*_SIZE instead). These may be removed or
> + * repositioned.
> + */
> +
> +#define BCM963XX_NVRAM_V4_SIZE         300
> +#define BCM963XX_NVRAM_V5_SIZE         1024
> +#define BCM963XX_NVRAM_V6_SIZE         BCM963XX_NVRAM_V5_SIZE
> +#define BCM963XX_NVRAM_V7_SIZE         3072
> +
> +#define BCM963XX_NVRAM_NR_PARTS                5
> +
> +struct bcm963xx_nvram {
> +       __u32   version;
> +       char    bootline[256];
> +       char    name[16];
> +       __u32   main_tp_number;
> +       __u32   psi_size;
> +       __u32   mac_addr_count;
> +       __u8    mac_addr_base[ETH_ALEN];
> +       __u8    __reserved1[2];
> +       __u32   checksum_v4;
> +
> +       __u8    __reserved2[292];
> +       __u32   nand_part_offset[BCM963XX_NVRAM_NR_PARTS];
> +       __u32   nand_part_size[BCM963XX_NVRAM_NR_PARTS];
> +       __u8    __reserved3[388];
> +       union {
> +               __u32   checksum_v5;
> +               __u32   checksum_v6;
> +       };

what's the point of this union? Both are the same size and have the
same function.

> +
> +       __u8    __reserved4[2044];
> +       __u32   checksum_v7;
> +} __packed;

Why is it __packed? there are no unaligned members, so it should work
fine without this (and it did for bcm63xx).


Jonas
