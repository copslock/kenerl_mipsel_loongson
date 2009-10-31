Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Oct 2009 17:13:19 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:49730 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493684AbZJaQNM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 31 Oct 2009 17:13:12 +0100
Received: by bwz21 with SMTP id 21so4582317bwz.24
        for <multiple recipients>; Sat, 31 Oct 2009 09:13:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=NHyXIF/oqpb4PeHGURbDwR1U4pmqwctIa02L/02BBR8=;
        b=DhxdFw7zaGVxl5HlcIdr0B9rSp6HkI6yGQVdcmW7dCZBBP+vLpy3otmr2LMgcUfvTg
         iO9bbngVPCi669IqtYt1gR7hx54XOSwNniuqyDixeZExr2ODGrZyRm9H/Tm6lolZtHdv
         r3YYPCbpbpnLIzIffUjiCwTgNitWbNy51v5so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lyrv44Ck0VCkkKjWUQURMv6wEcZuBktzpIqpkvMu+RpA/nDSp+wZYkV8/cxEACUWWb
         jkMKygAiwFVTNp0ihg9ohA8+LzVdrZBe8cWL/VMtHu/NbL4O/5GVAroyXre/CMpzTcFw
         GzATwq5VRqx9cNsPE8z5OtP2T85MwXelCGuE4=
MIME-Version: 1.0
Received: by 10.223.110.39 with SMTP id l39mr429889fap.3.1257005585507; Sat, 
	31 Oct 2009 09:13:05 -0700 (PDT)
In-Reply-To: <1255949617-22943-1-git-send-email-manuel.lauss@gmail.com>
References: <1255949617-22943-1-git-send-email-manuel.lauss@gmail.com>
Date:	Sat, 31 Oct 2009 17:13:05 +0100
Message-ID: <f861ec6f0910310913q4945d666tbdaafed3ce7b2125@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: physmap-flash for all devboards
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: multipart/alternative; boundary=001636c5990167a7f604773d6b85
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

--001636c5990167a7f604773d6b85
Content-Type: text/plain; charset=ISO-8859-1

Ping? Any comments? Flames?

On Mon, Oct 19, 2009 at 11:53 AM, Manuel Lauss
<manuel.lauss@googlemail.com>wrote:

> Replace the devboard NOR MTD mapping driver with physmap-flash support.
> Also honor the "swapboot" switch settings wrt. to the layout of the
> NOR partitions.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> on top of mips-queue, run-tested on db1200.
>
>  arch/mips/alchemy/devboards/db1x00/platform.c    |   20 +++
>  arch/mips/alchemy/devboards/pb1000/board_setup.c |    7 +
>  arch/mips/alchemy/devboards/pb1100/platform.c    |    7 +
>  arch/mips/alchemy/devboards/pb1200/platform.c    |    9 ++
>  arch/mips/alchemy/devboards/pb1500/platform.c    |    7 +
>  arch/mips/alchemy/devboards/pb1550/platform.c    |    6 +
>  arch/mips/alchemy/devboards/platform.c           |  104 ++++++++++++++
>  arch/mips/alchemy/devboards/platform.h           |    3 +
>  drivers/mtd/maps/Kconfig                         |    6 -
>  drivers/mtd/maps/Makefile                        |    1 -
>  drivers/mtd/maps/alchemy-flash.c                 |  166
> ----------------------
>  11 files changed, 163 insertions(+), 173 deletions(-)
>  delete mode 100644 drivers/mtd/maps/alchemy-flash.c
>
> diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c
> b/arch/mips/alchemy/devboards/db1x00/platform.c
> index 0ac5dd0..62e2a96 100644
> --- a/arch/mips/alchemy/devboards/db1x00/platform.c
> +++ b/arch/mips/alchemy/devboards/db1x00/platform.c
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
>
>  #include <asm/mach-au1x00/au1xxx.h>
> +#include <asm/mach-db1x00/bcsr.h>
>  #include "../platform.h"
>
>  /* DB1xxx PCMCIA interrupt sources:
> @@ -32,6 +33,7 @@
>  */
>
>  #define DB1XXX_HAS_PCMCIA
> +#define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
>
>  #if defined(CONFIG_MIPS_DB1000)
>  #define DB1XXX_PCMCIA_CD0      AU1000_GPIO0_INT
> @@ -40,6 +42,8 @@
>  #define DB1XXX_PCMCIA_CD1      AU1000_GPIO3_INT
>  #define DB1XXX_PCMCIA_STSCHG1  AU1000_GPIO4_INT
>  #define DB1XXX_PCMCIA_CARD1    AU1000_GPIO5_INT
> +#define BOARD_FLASH_SIZE       0x02000000 /* 32MB */
> +#define BOARD_FLASH_WIDTH      4 /* 32-bits */
>  #elif defined(CONFIG_MIPS_DB1100)
>  #define DB1XXX_PCMCIA_CD0      AU1100_GPIO0_INT
>  #define DB1XXX_PCMCIA_STSCHG0  AU1100_GPIO1_INT
> @@ -47,6 +51,8 @@
>  #define DB1XXX_PCMCIA_CD1      AU1100_GPIO3_INT
>  #define DB1XXX_PCMCIA_STSCHG1  AU1100_GPIO4_INT
>  #define DB1XXX_PCMCIA_CARD1    AU1100_GPIO5_INT
> +#define BOARD_FLASH_SIZE       0x02000000 /* 32MB */
> +#define BOARD_FLASH_WIDTH      4 /* 32-bits */
>  #elif defined(CONFIG_MIPS_DB1500)
>  #define DB1XXX_PCMCIA_CD0      AU1500_GPIO0_INT
>  #define DB1XXX_PCMCIA_STSCHG0  AU1500_GPIO1_INT
> @@ -54,6 +60,8 @@
>  #define DB1XXX_PCMCIA_CD1      AU1500_GPIO3_INT
>  #define DB1XXX_PCMCIA_STSCHG1  AU1500_GPIO4_INT
>  #define DB1XXX_PCMCIA_CARD1    AU1500_GPIO5_INT
> +#define BOARD_FLASH_SIZE       0x02000000 /* 32MB */
> +#define BOARD_FLASH_WIDTH      4 /* 32-bits */
>  #elif defined(CONFIG_MIPS_DB1550)
>  #define DB1XXX_PCMCIA_CD0      AU1550_GPIO0_INT
>  #define DB1XXX_PCMCIA_STSCHG0  AU1550_GPIO21_INT
> @@ -61,9 +69,20 @@
>  #define DB1XXX_PCMCIA_CD1      AU1550_GPIO1_INT
>  #define DB1XXX_PCMCIA_STSCHG1  AU1550_GPIO22_INT
>  #define DB1XXX_PCMCIA_CARD1    AU1550_GPIO5_INT
> +#define BOARD_FLASH_SIZE       0x08000000 /* 128MB */
> +#define BOARD_FLASH_WIDTH      4 /* 32-bits */
>  #else
>  /* other board: no PCMCIA */
>  #undef DB1XXX_HAS_PCMCIA
> +#undef F_SWAPPED
> +#define F_SWAPPED 0
> +#if defined(CONFIG_MIPS_BOSPORUS)
> +#define BOARD_FLASH_SIZE       0x01000000 /* 16MB */
> +#define BOARD_FLASH_WIDTH      2 /* 16-bits */
> +#elif defined(CONFIG_MIPS_MIRAGE)
> +#define BOARD_FLASH_SIZE       0x04000000 /* 64MB */
> +#define BOARD_FLASH_WIDTH      4 /* 32-bits */
> +#endif
>  #endif
>
>  static int __init db1xxx_dev_init(void)
> @@ -93,6 +112,7 @@ static int __init db1xxx_dev_init(void)
>                                    0,
>                                    1);
>  #endif
> +       db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH,
> F_SWAPPED);
>        return 0;
>  }
>  device_initcall(db1xxx_dev_init);
> diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c
> b/arch/mips/alchemy/devboards/pb1000/board_setup.c
> index 287d661..c8d3789 100644
> --- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
> +++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
> @@ -31,6 +31,7 @@
>  #include <asm/mach-pb1x00/pb1000.h>
>  #include <prom.h>
>
> +#include "../platform.h"
>
>  const char *get_system_type(void)
>  {
> @@ -190,3 +191,9 @@ static int __init pb1000_init_irq(void)
>        return 0;
>  }
>  arch_initcall(pb1000_init_irq);
> +
> +static int __init pb1000_device_init(void)
> +{
> +       return db1x_register_norflash(8 * 1024 * 1024, 4, 0);
> +}
> +device_initcall(pb1000_device_init);
> diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c
> b/arch/mips/alchemy/devboards/pb1100/platform.c
> index ec932e7..bfc5ab6 100644
> --- a/arch/mips/alchemy/devboards/pb1100/platform.c
> +++ b/arch/mips/alchemy/devboards/pb1100/platform.c
> @@ -21,11 +21,14 @@
>  #include <linux/init.h>
>
>  #include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-db1x00/bcsr.h>
>
>  #include "../platform.h"
>
>  static int __init pb1100_dev_init(void)
>  {
> +       int swapped;
> +
>        /* PCMCIA. single socket, identical to Pb1500 */
>        db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
>                                    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 -
> 1,
> @@ -38,6 +41,10 @@ static int __init pb1100_dev_init(void)
>                                    /*AU1100_GPIO10_INT*/0, /* stschg */
>                                    0,                   /* eject */
>                                    0);                  /* id */
> +
> +       swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
> +       db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
> +
>        return 0;
>  }
>  device_initcall(pb1100_dev_init);
> diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c
> b/arch/mips/alchemy/devboards/pb1200/platform.c
> index c8b7ae3..736d647 100644
> --- a/arch/mips/alchemy/devboards/pb1200/platform.c
> +++ b/arch/mips/alchemy/devboards/pb1200/platform.c
> @@ -172,6 +172,8 @@ static struct platform_device *board_platform_devices[]
> __initdata = {
>
>  static int __init board_register_devices(void)
>  {
> +       int swapped;
> +
>  #ifdef CONFIG_MIPS_PB1200
>        db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
>                                    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 -
> 1,
> @@ -222,6 +224,13 @@ static int __init board_register_devices(void)
>                                    1);
>  #endif
>
> +       swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1200_SWAPBOOT;
> +#ifdef CONFIG_MIPS_PB1200
> +       db1x_register_norflash(128 * 1024 * 1024, 2, swapped);
> +#else
> +       db1x_register_norflash(64 * 1024 * 1024, 2, swapped);
> +#endif
> +
>        return platform_add_devices(board_platform_devices,
>                                    ARRAY_SIZE(board_platform_devices));
>  }
> diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c
> b/arch/mips/alchemy/devboards/pb1500/platform.c
> index cdce775..529acb7 100644
> --- a/arch/mips/alchemy/devboards/pb1500/platform.c
> +++ b/arch/mips/alchemy/devboards/pb1500/platform.c
> @@ -20,11 +20,14 @@
>
>  #include <linux/init.h>
>  #include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-db1x00/bcsr.h>
>
>  #include "../platform.h"
>
>  static int __init pb1500_dev_init(void)
>  {
> +       int swapped;
> +
>        /* PCMCIA. single socket, identical to Pb1500 */
>        db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
>                                    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 -
> 1,
> @@ -37,6 +40,10 @@ static int __init pb1500_dev_init(void)
>                                    /*AU1500_GPIO10_INT*/0, /* stschg */
>                                    0,                   /* eject */
>                                    0);                  /* id */
> +
> +       swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
> +       db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
> +
>        return 0;
>  }
>  device_initcall(pb1500_dev_init);
> diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c
> b/arch/mips/alchemy/devboards/pb1550/platform.c
> index b496fb6..4613391 100644
> --- a/arch/mips/alchemy/devboards/pb1550/platform.c
> +++ b/arch/mips/alchemy/devboards/pb1550/platform.c
> @@ -22,11 +22,14 @@
>
>  #include <asm/mach-au1x00/au1000.h>
>  #include <asm/mach-pb1x00/pb1550.h>
> +#include <asm/mach-db1x00/bcsr.h>
>
>  #include "../platform.h"
>
>  static int __init pb1550_dev_init(void)
>  {
> +       int swapped;
> +
>        /* Pb1550, like all others, also has statuschange irqs; however
> they're
>        * wired up on one of the Au1550's shared GPIO201_205 line, which
> also
>        * services the PCMCIA card interrupts.  So we ignore statuschange
> and
> @@ -58,6 +61,9 @@ static int __init pb1550_dev_init(void)
>                                    0,
>                                    1);
>
> +       swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
> +       db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
> +
>        return 0;
>  }
>  device_initcall(pb1550_dev_init);
> diff --git a/arch/mips/alchemy/devboards/platform.c
> b/arch/mips/alchemy/devboards/platform.c
> index 48c537c..7f2bcee 100644
> --- a/arch/mips/alchemy/devboards/platform.c
> +++ b/arch/mips/alchemy/devboards/platform.c
> @@ -3,6 +3,9 @@
>  */
>
>  #include <linux/init.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/map.h>
> +#include <linux/mtd/physmap.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>
> @@ -87,3 +90,104 @@ out:
>        kfree(sr);
>        return ret;
>  }
> +
> +#define YAMON_SIZE     0x00100000
> +#define YAMON_ENV_SIZE 0x00040000
> +
> +int __init db1x_register_norflash(unsigned long size, int width,
> +                                 int swapped)
> +{
> +       struct physmap_flash_data *pfd;
> +       struct platform_device *pd;
> +       struct mtd_partition *parts;
> +       struct resource *res;
> +       int ret, i;
> +
> +       if (size < (8 * 1024 * 1024))
> +               return -EINVAL;
> +
> +       ret = -ENOMEM;
> +       parts = kzalloc(sizeof(struct mtd_partition) * 5, GFP_KERNEL);
> +       if (!parts)
> +               goto out;
> +
> +       res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +       if (!res)
> +               goto out1;
> +
> +       pfd = kzalloc(sizeof(struct physmap_flash_data), GFP_KERNEL);
> +       if (!pfd)
> +               goto out2;
> +
> +       pd = platform_device_alloc("physmap-flash", 0);
> +       if (!pd)
> +               goto out3;
> +
> +       /* NOR flash ends at 0x20000000, regardless of size */
> +       res->start = 0x20000000 - size;
> +       res->end = 0x20000000 - 1;
> +       res->flags = IORESOURCE_MEM;
> +
> +       /* partition setup.  Most Develboards have a switch which allows
> +        * to swap the physical locations of the 2 NOR flash banks.
> +        */
> +       i = 0;
> +       if (!swapped) {
> +               /* first NOR chip */
> +               parts[i].offset = 0;
> +               parts[i].name = "User FS";
> +               parts[i].size = size / 2;
> +               i++;
> +       }
> +
> +       parts[i].offset = MTDPART_OFS_APPEND;
> +       parts[i].name = "User FS 2";
> +       parts[i].size = (size / 2) - (0x20000000 - 0x1fc00000);
> +       i++;
> +
> +       parts[i].offset = MTDPART_OFS_APPEND;
> +       parts[i].name = "YAMON";
> +       parts[i].size = YAMON_SIZE;
> +       parts[i].mask_flags = MTD_WRITEABLE;
> +       i++;
> +
> +       parts[i].offset = MTDPART_OFS_APPEND;
> +       parts[i].name = "raw kernel";
> +       parts[i].size = 0x00400000 - YAMON_SIZE - YAMON_ENV_SIZE;
> +       i++;
> +
> +       parts[i].offset = MTDPART_OFS_APPEND;
> +       parts[i].name = "YAMON Env";
> +       parts[i].size = YAMON_ENV_SIZE;
> +       parts[i].mask_flags = MTD_WRITEABLE;
> +       i++;
> +
> +       if (swapped) {
> +               parts[i].offset = MTDPART_OFS_APPEND;
> +               parts[i].name = "User FS";
> +               parts[i].size = size / 2;
> +               i++;
> +       }
> +
> +       pfd->width = width;
> +       pfd->parts = parts;
> +       pfd->nr_parts = 5;
> +
> +       pd->dev.platform_data = pfd;
> +       pd->resource = res;
> +       pd->num_resources = 1;
> +
> +       ret = platform_device_add(pd);
> +       if (!ret)
> +               return ret;
> +
> +       platform_device_put(pd);
> +out3:
> +       kfree(pfd);
> +out2:
> +       kfree(res);
> +out1:
> +       kfree(parts);
> +out:
> +       return ret;
> +}
> diff --git a/arch/mips/alchemy/devboards/platform.h
> b/arch/mips/alchemy/devboards/platform.h
> index 55ecf7e..828c54e 100644
> --- a/arch/mips/alchemy/devboards/platform.h
> +++ b/arch/mips/alchemy/devboards/platform.h
> @@ -15,4 +15,7 @@ int __init db1x_register_pcmcia_socket(unsigned long
> pseudo_attr_start,
>                                       int eject_irq,
>                                       int id);
>
> +int __init db1x_register_norflash(unsigned long size, int width,
> +                                 int swapped);
> +
>  #endif
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index 841e085..af0e6ef 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -253,12 +253,6 @@ config MTD_NETtel
>        help
>          Support for flash chips on NETtel/SecureEdge/SnapGear boards.
>
> -config MTD_ALCHEMY
> -       tristate "AMD Alchemy Pb1xxx/Db1xxx/RDK MTD support"
> -       depends on SOC_AU1X00 && MTD_PARTITIONS && MTD_CFI
> -       help
> -         Flash memory access on AMD Alchemy Pb/Db/RDK Reference Boards
> -
>  config MTD_DILNETPC
>        tristate "CFI Flash device mapped on DIL/Net PC"
>        depends on X86 && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT
> && BROKEN
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> index 1d5cf86..0256933 100644
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -40,7 +40,6 @@ obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
>  obj-$(CONFIG_MTD_DBOX2)                += dbox2-flash.o
>  obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
>  obj-$(CONFIG_MTD_PCI)          += pci.o
> -obj-$(CONFIG_MTD_ALCHEMY)       += alchemy-flash.o
>  obj-$(CONFIG_MTD_AUTCPU12)     += autcpu12-nvram.o
>  obj-$(CONFIG_MTD_EDB7312)      += edb7312.o
>  obj-$(CONFIG_MTD_IMPA7)                += impa7.o
> diff --git a/drivers/mtd/maps/alchemy-flash.c
> b/drivers/mtd/maps/alchemy-flash.c
> deleted file mode 100644
> index 845ad4f..0000000
> --- a/drivers/mtd/maps/alchemy-flash.c
> +++ /dev/null
> @@ -1,166 +0,0 @@
> -/*
> - * Flash memory access on AMD Alchemy evaluation boards
> - *
> - * (C) 2003, 2004 Pete Popov <ppopov@embeddedalley.com>
> - */
> -
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/kernel.h>
> -
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/map.h>
> -#include <linux/mtd/partitions.h>
> -
> -#include <asm/io.h>
> -
> -#ifdef CONFIG_MIPS_PB1000
> -#define BOARD_MAP_NAME "Pb1000 Flash"
> -#define BOARD_FLASH_SIZE 0x00800000 /* 8MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_PB1500
> -#define BOARD_MAP_NAME "Pb1500 Flash"
> -#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_PB1100
> -#define BOARD_MAP_NAME "Pb1100 Flash"
> -#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_PB1550
> -#define BOARD_MAP_NAME "Pb1550 Flash"
> -#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_PB1200
> -#define BOARD_MAP_NAME "Pb1200 Flash"
> -#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
> -#define BOARD_FLASH_WIDTH 2 /* 16-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_DB1000
> -#define BOARD_MAP_NAME "Db1000 Flash"
> -#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_DB1500
> -#define BOARD_MAP_NAME "Db1500 Flash"
> -#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_DB1100
> -#define BOARD_MAP_NAME "Db1100 Flash"
> -#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_DB1550
> -#define BOARD_MAP_NAME "Db1550 Flash"
> -#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_DB1200
> -#define BOARD_MAP_NAME "Db1200 Flash"
> -#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
> -#define BOARD_FLASH_WIDTH 2 /* 16-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_BOSPORUS
> -#define BOARD_MAP_NAME "Bosporus Flash"
> -#define BOARD_FLASH_SIZE 0x01000000 /* 16MB */
> -#define BOARD_FLASH_WIDTH 2 /* 16-bits */
> -#endif
> -
> -#ifdef CONFIG_MIPS_MIRAGE
> -#define BOARD_MAP_NAME "Mirage Flash"
> -#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
> -#define BOARD_FLASH_WIDTH 4 /* 32-bits */
> -#define USE_LOCAL_ACCESSORS /* why? */
> -#endif
> -
> -static struct map_info alchemy_map = {
> -       .name = BOARD_MAP_NAME,
> -};
> -
> -static struct mtd_partition alchemy_partitions[] = {
> -        {
> -                .name = "User FS",
> -                .size = BOARD_FLASH_SIZE - 0x00400000,
> -                .offset = 0x0000000
> -        },{
> -                .name = "YAMON",
> -                .size = 0x0100000,
> -               .offset = MTDPART_OFS_APPEND,
> -                .mask_flags = MTD_WRITEABLE
> -        },{
> -                .name = "raw kernel",
> -               .size = (0x300000 - 0x40000), /* last 256KB is yamon env */
> -               .offset = MTDPART_OFS_APPEND,
> -        }
> -};
> -
> -static struct mtd_info *mymtd;
> -
> -static int __init alchemy_mtd_init(void)
> -{
> -       struct mtd_partition *parts;
> -       int nb_parts = 0;
> -       unsigned long window_addr;
> -       unsigned long window_size;
> -
> -       /* Default flash buswidth */
> -       alchemy_map.bankwidth = BOARD_FLASH_WIDTH;
> -
> -       window_addr = 0x20000000 - BOARD_FLASH_SIZE;
> -       window_size = BOARD_FLASH_SIZE;
> -
> -       /*
> -        * Static partition definition selection
> -        */
> -       parts = alchemy_partitions;
> -       nb_parts = ARRAY_SIZE(alchemy_partitions);
> -       alchemy_map.size = window_size;
> -
> -       /*
> -        * Now let's probe for the actual flash.  Do it here since
> -        * specific machine settings might have been set above.
> -        */
> -       printk(KERN_NOTICE BOARD_MAP_NAME ": probing %d-bit flash bus\n",
> -                       alchemy_map.bankwidth*8);
> -       alchemy_map.virt = ioremap(window_addr, window_size);
> -       mymtd = do_map_probe("cfi_probe", &alchemy_map);
> -       if (!mymtd) {
> -               iounmap(alchemy_map.virt);
> -               return -ENXIO;
> -       }
> -       mymtd->owner = THIS_MODULE;
> -
> -       add_mtd_partitions(mymtd, parts, nb_parts);
> -       return 0;
> -}
> -
> -static void __exit alchemy_mtd_cleanup(void)
> -{
> -       if (mymtd) {
> -               del_mtd_partitions(mymtd);
> -               map_destroy(mymtd);
> -               iounmap(alchemy_map.virt);
> -       }
> -}
> -
> -module_init(alchemy_mtd_init);
> -module_exit(alchemy_mtd_cleanup);
> -
> -MODULE_AUTHOR("Embedded Alley Solutions, Inc");
> -MODULE_DESCRIPTION(BOARD_MAP_NAME " MTD driver");
> -MODULE_LICENSE("GPL");
> --
> 1.6.5
>
>

--001636c5990167a7f604773d6b85
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ping? Any comments? Flames?<br><br><div class=3D"gmail_quote">On Mon, Oct 1=
9, 2009 at 11:53 AM, Manuel Lauss <span dir=3D"ltr">&lt;<a href=3D"mailto:m=
anuel.lauss@googlemail.com">manuel.lauss@googlemail.com</a>&gt;</span> wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Replace the devbo=
ard NOR MTD mapping driver with physmap-flash support.<br>
Also honor the &quot;swapboot&quot; switch settings wrt. to the layout of t=
he<br>
NOR partitions.<br>
<br>
Signed-off-by: Manuel Lauss &lt;<a href=3D"mailto:manuel.lauss@gmail.com">m=
anuel.lauss@gmail.com</a>&gt;<br>
---<br>
on top of mips-queue, run-tested on db1200.<br>
<br>
=A0arch/mips/alchemy/devboards/db1x00/platform.c =A0 =A0| =A0 20 +++<br>
=A0arch/mips/alchemy/devboards/pb1000/board_setup.c | =A0 =A07 +<br>
=A0arch/mips/alchemy/devboards/pb1100/platform.c =A0 =A0| =A0 =A07 +<br>
=A0arch/mips/alchemy/devboards/pb1200/platform.c =A0 =A0| =A0 =A09 ++<br>
=A0arch/mips/alchemy/devboards/pb1500/platform.c =A0 =A0| =A0 =A07 +<br>
=A0arch/mips/alchemy/devboards/pb1550/platform.c =A0 =A0| =A0 =A06 +<br>
=A0arch/mips/alchemy/devboards/platform.c =A0 =A0 =A0 =A0 =A0 | =A0104 ++++=
++++++++++<br>
=A0arch/mips/alchemy/devboards/platform.h =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +<=
br>
=A0drivers/mtd/maps/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A06 -<br>
=A0drivers/mtd/maps/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A01 -<br>
=A0drivers/mtd/maps/alchemy-flash.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A016=
6 ----------------------<br>
=A011 files changed, 163 insertions(+), 173 deletions(-)<br>
=A0delete mode 100644 drivers/mtd/maps/alchemy-flash.c<br>
<br>
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alch=
emy/devboards/db1x00/platform.c<br>
index 0ac5dd0..62e2a96 100644<br>
--- a/arch/mips/alchemy/devboards/db1x00/platform.c<br>
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c<br>
@@ -22,6 +22,7 @@<br>
=A0#include &lt;linux/platform_device.h&gt;<br>
<br>
=A0#include &lt;asm/mach-au1x00/au1xxx.h&gt;<br>
+#include &lt;asm/mach-db1x00/bcsr.h&gt;<br>
=A0#include &quot;../platform.h&quot;<br>
<br>
=A0/* DB1xxx PCMCIA interrupt sources:<br>
@@ -32,6 +33,7 @@<br>
 =A0*/<br>
<br>
=A0#define DB1XXX_HAS_PCMCIA<br>
+#define F_SWAPPED (bcsr_read(BCSR_STATUS) &amp; BCSR_STATUS_DB1000_SWAPBOO=
T)<br>
<br>
=A0#if defined(CONFIG_MIPS_DB1000)<br>
=A0#define DB1XXX_PCMCIA_CD0 =A0 =A0 =A0AU1000_GPIO0_INT<br>
@@ -40,6 +42,8 @@<br>
=A0#define DB1XXX_PCMCIA_CD1 =A0 =A0 =A0AU1000_GPIO3_INT<br>
=A0#define DB1XXX_PCMCIA_STSCHG1 =A0AU1000_GPIO4_INT<br>
=A0#define DB1XXX_PCMCIA_CARD1 =A0 =A0AU1000_GPIO5_INT<br>
+#define BOARD_FLASH_SIZE =A0 =A0 =A0 0x02000000 /* 32MB */<br>
+#define BOARD_FLASH_WIDTH =A0 =A0 =A04 /* 32-bits */<br>
=A0#elif defined(CONFIG_MIPS_DB1100)<br>
=A0#define DB1XXX_PCMCIA_CD0 =A0 =A0 =A0AU1100_GPIO0_INT<br>
=A0#define DB1XXX_PCMCIA_STSCHG0 =A0AU1100_GPIO1_INT<br>
@@ -47,6 +51,8 @@<br>
=A0#define DB1XXX_PCMCIA_CD1 =A0 =A0 =A0AU1100_GPIO3_INT<br>
=A0#define DB1XXX_PCMCIA_STSCHG1 =A0AU1100_GPIO4_INT<br>
=A0#define DB1XXX_PCMCIA_CARD1 =A0 =A0AU1100_GPIO5_INT<br>
+#define BOARD_FLASH_SIZE =A0 =A0 =A0 0x02000000 /* 32MB */<br>
+#define BOARD_FLASH_WIDTH =A0 =A0 =A04 /* 32-bits */<br>
=A0#elif defined(CONFIG_MIPS_DB1500)<br>
=A0#define DB1XXX_PCMCIA_CD0 =A0 =A0 =A0AU1500_GPIO0_INT<br>
=A0#define DB1XXX_PCMCIA_STSCHG0 =A0AU1500_GPIO1_INT<br>
@@ -54,6 +60,8 @@<br>
=A0#define DB1XXX_PCMCIA_CD1 =A0 =A0 =A0AU1500_GPIO3_INT<br>
=A0#define DB1XXX_PCMCIA_STSCHG1 =A0AU1500_GPIO4_INT<br>
=A0#define DB1XXX_PCMCIA_CARD1 =A0 =A0AU1500_GPIO5_INT<br>
+#define BOARD_FLASH_SIZE =A0 =A0 =A0 0x02000000 /* 32MB */<br>
+#define BOARD_FLASH_WIDTH =A0 =A0 =A04 /* 32-bits */<br>
=A0#elif defined(CONFIG_MIPS_DB1550)<br>
=A0#define DB1XXX_PCMCIA_CD0 =A0 =A0 =A0AU1550_GPIO0_INT<br>
=A0#define DB1XXX_PCMCIA_STSCHG0 =A0AU1550_GPIO21_INT<br>
@@ -61,9 +69,20 @@<br>
=A0#define DB1XXX_PCMCIA_CD1 =A0 =A0 =A0AU1550_GPIO1_INT<br>
=A0#define DB1XXX_PCMCIA_STSCHG1 =A0AU1550_GPIO22_INT<br>
=A0#define DB1XXX_PCMCIA_CARD1 =A0 =A0AU1550_GPIO5_INT<br>
+#define BOARD_FLASH_SIZE =A0 =A0 =A0 0x08000000 /* 128MB */<br>
+#define BOARD_FLASH_WIDTH =A0 =A0 =A04 /* 32-bits */<br>
=A0#else<br>
=A0/* other board: no PCMCIA */<br>
=A0#undef DB1XXX_HAS_PCMCIA<br>
+#undef F_SWAPPED<br>
+#define F_SWAPPED 0<br>
+#if defined(CONFIG_MIPS_BOSPORUS)<br>
+#define BOARD_FLASH_SIZE =A0 =A0 =A0 0x01000000 /* 16MB */<br>
+#define BOARD_FLASH_WIDTH =A0 =A0 =A02 /* 16-bits */<br>
+#elif defined(CONFIG_MIPS_MIRAGE)<br>
+#define BOARD_FLASH_SIZE =A0 =A0 =A0 0x04000000 /* 64MB */<br>
+#define BOARD_FLASH_WIDTH =A0 =A0 =A04 /* 32-bits */<br>
+#endif<br>
=A0#endif<br>
<br>
=A0static int __init db1xxx_dev_init(void)<br>
@@ -93,6 +112,7 @@ static int __init db1xxx_dev_init(void)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00,<=
br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01);=
<br>
=A0#endif<br>
+ =A0 =A0 =A0 db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH, F=
_SWAPPED);<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
=A0device_initcall(db1xxx_dev_init);<br>
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/a=
lchemy/devboards/pb1000/board_setup.c<br>
index 287d661..c8d3789 100644<br>
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c<br>
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c<br>
@@ -31,6 +31,7 @@<br>
=A0#include &lt;asm/mach-pb1x00/pb1000.h&gt;<br>
=A0#include &lt;prom.h&gt;<br>
<br>
+#include &quot;../platform.h&quot;<br>
<br>
=A0const char *get_system_type(void)<br>
=A0{<br>
@@ -190,3 +191,9 @@ static int __init pb1000_init_irq(void)<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
=A0arch_initcall(pb1000_init_irq);<br>
+<br>
+static int __init pb1000_device_init(void)<br>
+{<br>
+ =A0 =A0 =A0 return db1x_register_norflash(8 * 1024 * 1024, 4, 0);<br>
+}<br>
+device_initcall(pb1000_device_init);<br>
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alch=
emy/devboards/pb1100/platform.c<br>
index ec932e7..bfc5ab6 100644<br>
--- a/arch/mips/alchemy/devboards/pb1100/platform.c<br>
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c<br>
@@ -21,11 +21,14 @@<br>
=A0#include &lt;linux/init.h&gt;<br>
<br>
=A0#include &lt;asm/mach-au1x00/au1000.h&gt;<br>
+#include &lt;asm/mach-db1x00/bcsr.h&gt;<br>
<br>
=A0#include &quot;../platform.h&quot;<br>
<br>
=A0static int __init pb1100_dev_init(void)<br>
=A0{<br>
+ =A0 =A0 =A0 int swapped;<br>
+<br>
 =A0 =A0 =A0 =A0/* PCMCIA. single socket, identical to Pb1500 */<br>
 =A0 =A0 =A0 =A0db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PCM=
CIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,<br>
@@ -38,6 +41,10 @@ static int __init pb1100_dev_init(void)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*A=
U1100_GPIO10_INT*/0, /* stschg */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* eject */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00);=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* id */<br>
+<br>
+ =A0 =A0 =A0 swapped =3D bcsr_read(BCSR_STATUS) &amp; =A0BCSR_STATUS_DB100=
0_SWAPBOOT;<br>
+ =A0 =A0 =A0 db1x_register_norflash(64 * 1024 * 1024, 4, swapped);<br>
+<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
=A0device_initcall(pb1100_dev_init);<br>
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alch=
emy/devboards/pb1200/platform.c<br>
index c8b7ae3..736d647 100644<br>
--- a/arch/mips/alchemy/devboards/pb1200/platform.c<br>
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c<br>
@@ -172,6 +172,8 @@ static struct platform_device *board_platform_devices[]=
 __initdata =3D {<br>
<br>
=A0static int __init board_register_devices(void)<br>
=A0{<br>
+ =A0 =A0 =A0 int swapped;<br>
+<br>
=A0#ifdef CONFIG_MIPS_PB1200<br>
 =A0 =A0 =A0 =A0db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PCM=
CIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,<br>
@@ -222,6 +224,13 @@ static int __init board_register_devices(void)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01);=
<br>
=A0#endif<br>
<br>
+ =A0 =A0 =A0 swapped =3D bcsr_read(BCSR_STATUS) &amp; =A0BCSR_STATUS_DB120=
0_SWAPBOOT;<br>
+#ifdef CONFIG_MIPS_PB1200<br>
+ =A0 =A0 =A0 db1x_register_norflash(128 * 1024 * 1024, 2, swapped);<br>
+#else<br>
+ =A0 =A0 =A0 db1x_register_norflash(64 * 1024 * 1024, 2, swapped);<br>
+#endif<br>
+<br>
 =A0 =A0 =A0 =A0return platform_add_devices(board_platform_devices,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARR=
AY_SIZE(board_platform_devices));<br>
=A0}<br>
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alch=
emy/devboards/pb1500/platform.c<br>
index cdce775..529acb7 100644<br>
--- a/arch/mips/alchemy/devboards/pb1500/platform.c<br>
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c<br>
@@ -20,11 +20,14 @@<br>
<br>
=A0#include &lt;linux/init.h&gt;<br>
=A0#include &lt;asm/mach-au1x00/au1000.h&gt;<br>
+#include &lt;asm/mach-db1x00/bcsr.h&gt;<br>
<br>
=A0#include &quot;../platform.h&quot;<br>
<br>
=A0static int __init pb1500_dev_init(void)<br>
=A0{<br>
+ =A0 =A0 =A0 int swapped;<br>
+<br>
 =A0 =A0 =A0 =A0/* PCMCIA. single socket, identical to Pb1500 */<br>
 =A0 =A0 =A0 =A0db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PCM=
CIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,<br>
@@ -37,6 +40,10 @@ static int __init pb1500_dev_init(void)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*A=
U1500_GPIO10_INT*/0, /* stschg */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* eject */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00);=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* id */<br>
+<br>
+ =A0 =A0 =A0 swapped =3D bcsr_read(BCSR_STATUS) &amp; =A0BCSR_STATUS_DB100=
0_SWAPBOOT;<br>
+ =A0 =A0 =A0 db1x_register_norflash(64 * 1024 * 1024, 4, swapped);<br>
+<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
=A0device_initcall(pb1500_dev_init);<br>
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alch=
emy/devboards/pb1550/platform.c<br>
index b496fb6..4613391 100644<br>
--- a/arch/mips/alchemy/devboards/pb1550/platform.c<br>
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c<br>
@@ -22,11 +22,14 @@<br>
<br>
=A0#include &lt;asm/mach-au1x00/au1000.h&gt;<br>
=A0#include &lt;asm/mach-pb1x00/pb1550.h&gt;<br>
+#include &lt;asm/mach-db1x00/bcsr.h&gt;<br>
<br>
=A0#include &quot;../platform.h&quot;<br>
<br>
=A0static int __init pb1550_dev_init(void)<br>
=A0{<br>
+ =A0 =A0 =A0 int swapped;<br>
+<br>
 =A0 =A0 =A0 =A0/* Pb1550, like all others, also has statuschange irqs; how=
ever they&#39;re<br>
 =A0 =A0 =A0 =A0* wired up on one of the Au1550&#39;s shared GPIO201_205 li=
ne, which also<br>
 =A0 =A0 =A0 =A0* services the PCMCIA card interrupts. =A0So we ignore stat=
uschange and<br>
@@ -58,6 +61,9 @@ static int __init pb1550_dev_init(void)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00,<=
br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01);=
<br>
<br>
+ =A0 =A0 =A0 swapped =3D bcsr_read(BCSR_STATUS) &amp; BCSR_STATUS_PB1550_S=
WAPBOOT;<br>
+ =A0 =A0 =A0 db1x_register_norflash(128 * 1024 * 1024, 4, swapped);<br>
+<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
=A0device_initcall(pb1550_dev_init);<br>
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/dev=
boards/platform.c<br>
index 48c537c..7f2bcee 100644<br>
--- a/arch/mips/alchemy/devboards/platform.c<br>
+++ b/arch/mips/alchemy/devboards/platform.c<br>
@@ -3,6 +3,9 @@<br>
 =A0*/<br>
<br>
=A0#include &lt;linux/init.h&gt;<br>
+#include &lt;linux/mtd/mtd.h&gt;<br>
+#include &lt;linux/mtd/map.h&gt;<br>
+#include &lt;linux/mtd/physmap.h&gt;<br>
=A0#include &lt;linux/slab.h&gt;<br>
=A0#include &lt;linux/platform_device.h&gt;<br>
<br>
@@ -87,3 +90,104 @@ out:<br>
 =A0 =A0 =A0 =A0kfree(sr);<br>
 =A0 =A0 =A0 =A0return ret;<br>
=A0}<br>
+<br>
+#define YAMON_SIZE =A0 =A0 0x00100000<br>
+#define YAMON_ENV_SIZE 0x00040000<br>
+<br>
+int __init db1x_register_norflash(unsigned long size, int width,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int swapp=
ed)<br>
+{<br>
+ =A0 =A0 =A0 struct physmap_flash_data *pfd;<br>
+ =A0 =A0 =A0 struct platform_device *pd;<br>
+ =A0 =A0 =A0 struct mtd_partition *parts;<br>
+ =A0 =A0 =A0 struct resource *res;<br>
+ =A0 =A0 =A0 int ret, i;<br>
+<br>
+ =A0 =A0 =A0 if (size &lt; (8 * 1024 * 1024))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+<br>
+ =A0 =A0 =A0 ret =3D -ENOMEM;<br>
+ =A0 =A0 =A0 parts =3D kzalloc(sizeof(struct mtd_partition) * 5, GFP_KERNE=
L);<br>
+ =A0 =A0 =A0 if (!parts)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+<br>
+ =A0 =A0 =A0 res =3D kzalloc(sizeof(struct resource), GFP_KERNEL);<br>
+ =A0 =A0 =A0 if (!res)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out1;<br>
+<br>
+ =A0 =A0 =A0 pfd =3D kzalloc(sizeof(struct physmap_flash_data), GFP_KERNEL=
);<br>
+ =A0 =A0 =A0 if (!pfd)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out2;<br>
+<br>
+ =A0 =A0 =A0 pd =3D platform_device_alloc(&quot;physmap-flash&quot;, 0);<b=
r>
+ =A0 =A0 =A0 if (!pd)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out3;<br>
+<br>
+ =A0 =A0 =A0 /* NOR flash ends at 0x20000000, regardless of size */<br>
+ =A0 =A0 =A0 res-&gt;start =3D 0x20000000 - size;<br>
+ =A0 =A0 =A0 res-&gt;end =3D 0x20000000 - 1;<br>
+ =A0 =A0 =A0 res-&gt;flags =3D IORESOURCE_MEM;<br>
+<br>
+ =A0 =A0 =A0 /* partition setup. =A0Most Develboards have a switch which a=
llows<br>
+ =A0 =A0 =A0 =A0* to swap the physical locations of the 2 NOR flash banks.=
<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 i =3D 0;<br>
+ =A0 =A0 =A0 if (!swapped) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* first NOR chip */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts[i].offset =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts[i].name =3D &quot;User FS&quot;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts[i].size =3D size / 2;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 parts[i].offset =3D MTDPART_OFS_APPEND;<br>
+ =A0 =A0 =A0 parts[i].name =3D &quot;User FS 2&quot;;<br>
+ =A0 =A0 =A0 parts[i].size =3D (size / 2) - (0x20000000 - 0x1fc00000);<br>
+ =A0 =A0 =A0 i++;<br>
+<br>
+ =A0 =A0 =A0 parts[i].offset =3D MTDPART_OFS_APPEND;<br>
+ =A0 =A0 =A0 parts[i].name =3D &quot;YAMON&quot;;<br>
+ =A0 =A0 =A0 parts[i].size =3D YAMON_SIZE;<br>
+ =A0 =A0 =A0 parts[i].mask_flags =3D MTD_WRITEABLE;<br>
+ =A0 =A0 =A0 i++;<br>
+<br>
+ =A0 =A0 =A0 parts[i].offset =3D MTDPART_OFS_APPEND;<br>
+ =A0 =A0 =A0 parts[i].name =3D &quot;raw kernel&quot;;<br>
+ =A0 =A0 =A0 parts[i].size =3D 0x00400000 - YAMON_SIZE - YAMON_ENV_SIZE;<b=
r>
+ =A0 =A0 =A0 i++;<br>
+<br>
+ =A0 =A0 =A0 parts[i].offset =3D MTDPART_OFS_APPEND;<br>
+ =A0 =A0 =A0 parts[i].name =3D &quot;YAMON Env&quot;;<br>
+ =A0 =A0 =A0 parts[i].size =3D YAMON_ENV_SIZE;<br>
+ =A0 =A0 =A0 parts[i].mask_flags =3D MTD_WRITEABLE;<br>
+ =A0 =A0 =A0 i++;<br>
+<br>
+ =A0 =A0 =A0 if (swapped) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts[i].offset =3D MTDPART_OFS_APPEND;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts[i].name =3D &quot;User FS&quot;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts[i].size =3D size / 2;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 pfd-&gt;width =3D width;<br>
+ =A0 =A0 =A0 pfd-&gt;parts =3D parts;<br>
+ =A0 =A0 =A0 pfd-&gt;nr_parts =3D 5;<br>
+<br>
+ =A0 =A0 =A0 pd-&gt;dev.platform_data =3D pfd;<br>
+ =A0 =A0 =A0 pd-&gt;resource =3D res;<br>
+ =A0 =A0 =A0 pd-&gt;num_resources =3D 1;<br>
+<br>
+ =A0 =A0 =A0 ret =3D platform_device_add(pd);<br>
+ =A0 =A0 =A0 if (!ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+<br>
+ =A0 =A0 =A0 platform_device_put(pd);<br>
+out3:<br>
+ =A0 =A0 =A0 kfree(pfd);<br>
+out2:<br>
+ =A0 =A0 =A0 kfree(res);<br>
+out1:<br>
+ =A0 =A0 =A0 kfree(parts);<br>
+out:<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
diff --git a/arch/mips/alchemy/devboards/platform.h b/arch/mips/alchemy/dev=
boards/platform.h<br>
index 55ecf7e..828c54e 100644<br>
--- a/arch/mips/alchemy/devboards/platform.h<br>
+++ b/arch/mips/alchemy/devboards/platform.h<br>
@@ -15,4 +15,7 @@ int __init db1x_register_pcmcia_socket(unsigned long pseu=
do_attr_start,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 int eject_irq,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 int id);<br>
<br>
+int __init db1x_register_norflash(unsigned long size, int width,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int swapp=
ed);<br>
+<br>
=A0#endif<br>
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig<br>
index 841e085..af0e6ef 100644<br>
--- a/drivers/mtd/maps/Kconfig<br>
+++ b/drivers/mtd/maps/Kconfig<br>
@@ -253,12 +253,6 @@ config MTD_NETtel<br>
 =A0 =A0 =A0 =A0help<br>
 =A0 =A0 =A0 =A0 =A0Support for flash chips on NETtel/SecureEdge/SnapGear b=
oards.<br>
<br>
-config MTD_ALCHEMY<br>
- =A0 =A0 =A0 tristate &quot;AMD Alchemy Pb1xxx/Db1xxx/RDK MTD support&quot=
;<br>
- =A0 =A0 =A0 depends on SOC_AU1X00 &amp;&amp; MTD_PARTITIONS &amp;&amp; MT=
D_CFI<br>
- =A0 =A0 =A0 help<br>
- =A0 =A0 =A0 =A0 Flash memory access on AMD Alchemy Pb/Db/RDK Reference Bo=
ards<br>
-<br>
=A0config MTD_DILNETPC<br>
 =A0 =A0 =A0 =A0tristate &quot;CFI Flash device mapped on DIL/Net PC&quot;<=
br>
 =A0 =A0 =A0 =A0depends on X86 &amp;&amp; MTD_CONCAT &amp;&amp; MTD_PARTITI=
ONS &amp;&amp; MTD_CFI_INTELEXT &amp;&amp; BROKEN<br>
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile<br>
index 1d5cf86..0256933 100644<br>
--- a/drivers/mtd/maps/Makefile<br>
+++ b/drivers/mtd/maps/Makefile<br>
@@ -40,7 +40,6 @@ obj-$(CONFIG_MTD_SCx200_DOCFLASH)+=3D scx200_docflash.o<b=
r>
=A0obj-$(CONFIG_MTD_DBOX2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dbox2-flash.=
o<br>
=A0obj-$(CONFIG_MTD_SOLUTIONENGINE)+=3D solutionengine.o<br>
=A0obj-$(CONFIG_MTD_PCI) =A0 =A0 =A0 =A0 =A0+=3D pci.o<br>
-obj-$(CONFIG_MTD_ALCHEMY) =A0 =A0 =A0 +=3D alchemy-flash.o<br>
=A0obj-$(CONFIG_MTD_AUTCPU12) =A0 =A0 +=3D autcpu12-nvram.o<br>
=A0obj-$(CONFIG_MTD_EDB7312) =A0 =A0 =A0+=3D edb7312.o<br>
=A0obj-$(CONFIG_MTD_IMPA7) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D impa7.o<br>
diff --git a/drivers/mtd/maps/alchemy-flash.c b/drivers/mtd/maps/alchemy-fl=
ash.c<br>
deleted file mode 100644<br>
index 845ad4f..0000000<br>
--- a/drivers/mtd/maps/alchemy-flash.c<br>
+++ /dev/null<br>
@@ -1,166 +0,0 @@<br>
-/*<br>
- * Flash memory access on AMD Alchemy evaluation boards<br>
- *<br>
- * (C) 2003, 2004 Pete Popov &lt;<a href=3D"mailto:ppopov@embeddedalley.co=
m">ppopov@embeddedalley.com</a>&gt;<br>
- */<br>
-<br>
-#include &lt;linux/init.h&gt;<br>
-#include &lt;linux/module.h&gt;<br>
-#include &lt;linux/types.h&gt;<br>
-#include &lt;linux/kernel.h&gt;<br>
-<br>
-#include &lt;linux/mtd/mtd.h&gt;<br>
-#include &lt;linux/mtd/map.h&gt;<br>
-#include &lt;linux/mtd/partitions.h&gt;<br>
-<br>
-#include &lt;asm/io.h&gt;<br>
-<br>
-#ifdef CONFIG_MIPS_PB1000<br>
-#define BOARD_MAP_NAME &quot;Pb1000 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x00800000 /* 8MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_PB1500<br>
-#define BOARD_MAP_NAME &quot;Pb1500 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_PB1100<br>
-#define BOARD_MAP_NAME &quot;Pb1100 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_PB1550<br>
-#define BOARD_MAP_NAME &quot;Pb1550 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_PB1200<br>
-#define BOARD_MAP_NAME &quot;Pb1200 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */<br>
-#define BOARD_FLASH_WIDTH 2 /* 16-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_DB1000<br>
-#define BOARD_MAP_NAME &quot;Db1000 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_DB1500<br>
-#define BOARD_MAP_NAME &quot;Db1500 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_DB1100<br>
-#define BOARD_MAP_NAME &quot;Db1100 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_DB1550<br>
-#define BOARD_MAP_NAME &quot;Db1550 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_DB1200<br>
-#define BOARD_MAP_NAME &quot;Db1200 Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */<br>
-#define BOARD_FLASH_WIDTH 2 /* 16-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_BOSPORUS<br>
-#define BOARD_MAP_NAME &quot;Bosporus Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x01000000 /* 16MB */<br>
-#define BOARD_FLASH_WIDTH 2 /* 16-bits */<br>
-#endif<br>
-<br>
-#ifdef CONFIG_MIPS_MIRAGE<br>
-#define BOARD_MAP_NAME &quot;Mirage Flash&quot;<br>
-#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */<br>
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */<br>
-#define USE_LOCAL_ACCESSORS /* why? */<br>
-#endif<br>
-<br>
-static struct map_info alchemy_map =3D {<br>
- =A0 =A0 =A0 .name =3D BOARD_MAP_NAME,<br>
-};<br>
-<br>
-static struct mtd_partition alchemy_partitions[] =3D {<br>
- =A0 =A0 =A0 =A0{<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D &quot;User FS&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =3D BOARD_FLASH_SIZE - 0x00400000,<b=
r>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.offset =3D 0x0000000<br>
- =A0 =A0 =A0 =A0},{<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D &quot;YAMON&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =3D 0x0100000,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =3D MTDPART_OFS_APPEND,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mask_flags =3D MTD_WRITEABLE<br>
- =A0 =A0 =A0 =A0},{<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D &quot;raw kernel&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =3D (0x300000 - 0x40000), /* last 256KB=
 is yamon env */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =3D MTDPART_OFS_APPEND,<br>
- =A0 =A0 =A0 =A0}<br>
-};<br>
-<br>
-static struct mtd_info *mymtd;<br>
-<br>
-static int __init alchemy_mtd_init(void)<br>
-{<br>
- =A0 =A0 =A0 struct mtd_partition *parts;<br>
- =A0 =A0 =A0 int nb_parts =3D 0;<br>
- =A0 =A0 =A0 unsigned long window_addr;<br>
- =A0 =A0 =A0 unsigned long window_size;<br>
-<br>
- =A0 =A0 =A0 /* Default flash buswidth */<br>
- =A0 =A0 =A0 alchemy_map.bankwidth =3D BOARD_FLASH_WIDTH;<br>
-<br>
- =A0 =A0 =A0 window_addr =3D 0x20000000 - BOARD_FLASH_SIZE;<br>
- =A0 =A0 =A0 window_size =3D BOARD_FLASH_SIZE;<br>
-<br>
- =A0 =A0 =A0 /*<br>
- =A0 =A0 =A0 =A0* Static partition definition selection<br>
- =A0 =A0 =A0 =A0*/<br>
- =A0 =A0 =A0 parts =3D alchemy_partitions;<br>
- =A0 =A0 =A0 nb_parts =3D ARRAY_SIZE(alchemy_partitions);<br>
- =A0 =A0 =A0 alchemy_map.size =3D window_size;<br>
-<br>
- =A0 =A0 =A0 /*<br>
- =A0 =A0 =A0 =A0* Now let&#39;s probe for the actual flash. =A0Do it here =
since<br>
- =A0 =A0 =A0 =A0* specific machine settings might have been set above.<br>
- =A0 =A0 =A0 =A0*/<br>
- =A0 =A0 =A0 printk(KERN_NOTICE BOARD_MAP_NAME &quot;: probing %d-bit flas=
h bus\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alchemy_map.bankwidth*8);<br>
- =A0 =A0 =A0 alchemy_map.virt =3D ioremap(window_addr, window_size);<br>
- =A0 =A0 =A0 mymtd =3D do_map_probe(&quot;cfi_probe&quot;, &amp;alchemy_ma=
p);<br>
- =A0 =A0 =A0 if (!mymtd) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(alchemy_map.virt);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;<br>
- =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 mymtd-&gt;owner =3D THIS_MODULE;<br>
-<br>
- =A0 =A0 =A0 add_mtd_partitions(mymtd, parts, nb_parts);<br>
- =A0 =A0 =A0 return 0;<br>
-}<br>
-<br>
-static void __exit alchemy_mtd_cleanup(void)<br>
-{<br>
- =A0 =A0 =A0 if (mymtd) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_partitions(mymtd);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_destroy(mymtd);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(alchemy_map.virt);<br>
- =A0 =A0 =A0 }<br>
-}<br>
-<br>
-module_init(alchemy_mtd_init);<br>
-module_exit(alchemy_mtd_cleanup);<br>
-<br>
-MODULE_AUTHOR(&quot;Embedded Alley Solutions, Inc&quot;);<br>
-MODULE_DESCRIPTION(BOARD_MAP_NAME &quot; MTD driver&quot;);<br>
-MODULE_LICENSE(&quot;GPL&quot;);<br>
<font color=3D"#888888">--<br>
1.6.5<br>
<br>
</font></blockquote></div><br>

--001636c5990167a7f604773d6b85--
