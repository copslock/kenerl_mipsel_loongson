Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2014 02:24:57 +0200 (CEST)
Received: from mail-qa0-f41.google.com ([209.85.216.41]:51793 "EHLO
        mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822100AbaDSAYwiQu2B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Apr 2014 02:24:52 +0200
Received: by mail-qa0-f41.google.com with SMTP id j5so2074368qaq.14
        for <multiple recipients>; Fri, 18 Apr 2014 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QJwddEbtQpa9goGfk1kAJVNwDlpM6+oCesEvQIkdVG8=;
        b=wU8ULVCoR4kxJHgv2ZsEoqPVb3JgCyIK3apuVKqMHMEVOqZEbmfznDfP9vI9UHWy2o
         ANLsvDkUJhWiZvKl3jAyJEf47Dl4grCKhzu1HzzG5f0oiAdyhLu/an5MS8rq/IRubF6l
         KbS282pr9Tcc+hHp1TFjk0b3AkPOiUebYPwEXs8nTtKgwxny0pYBVtIWw0BxDgI6l3Hs
         7qKUXzLDLHde7LDUkOXRL86neYrkOSqJDCX/kSK7+CzTYoNvuHlrUAEJmDojhXfodksj
         iPgKnDkgmE3vtY9vDeTUCkbSm2jQwbcEflKJ1EwgBw/U4a/O+4cpTlmThtUOu8Qr5NMU
         3dYQ==
X-Received: by 10.224.14.77 with SMTP id f13mr24369327qaa.31.1397867086380;
 Fri, 18 Apr 2014 17:24:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.96.147.163 with HTTP; Fri, 18 Apr 2014 17:24:06 -0700 (PDT)
In-Reply-To: <1397719309-2022-4-git-send-email-computersforpeace@gmail.com>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com> <1397719309-2022-4-git-send-email-computersforpeace@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Fri, 18 Apr 2014 17:24:06 -0700
Message-ID: <CAGVrzcZLUgpZZKAHjPSWaBs6w1XoegLaoWUAaMYUD9zW9yzq0w@mail.gmail.com>
Subject: Re: [PATCH 3/5] mips: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014-04-17 0:21 GMT-07:00 Brian Norris <computersforpeace@gmail.com>:
> These defconfigs contain the CONFIG_M25P80 symbol, which is now
> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to the
> relevant defconfigs.

so CONFIG_M25P80 should select CONFIG_MTD_SPI_NOR, right? in that
case, I do not think this is needed at all, as it would be
automatically picked up during the build and if someone refreshes the
defconfigs, although it cannot hurt.

>
> At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
> This change is based on l2-mtd.git/spinor, which is based on 3.15-rc1:
>
>   git://git.infradead.org/l2-mtd.git +spinor
>
>  arch/mips/configs/ath79_defconfig  | 3 +--
>  arch/mips/configs/db1xxx_defconfig | 1 +
>  arch/mips/configs/rt305x_defconfig | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
> index e3a3836508ec..134879c1310a 100644
> --- a/arch/mips/configs/ath79_defconfig
> +++ b/arch/mips/configs/ath79_defconfig
> @@ -46,7 +46,6 @@ CONFIG_MTD=y
>  CONFIG_MTD_REDBOOT_PARTS=y
>  CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-2
>  CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_CHAR=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_JEDECPROBE=y
> @@ -54,7 +53,7 @@ CONFIG_MTD_CFI_AMDSTD=y
>  CONFIG_MTD_COMPLEX_MAPPINGS=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_M25P80=y
> -# CONFIG_M25PXX_USE_FAST_READ is not set
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_PACKET_ENGINE is not set
>  CONFIG_ATH_COMMON=m
> diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
> index c99b6eeda90b..a64b30b96a0d 100644
> --- a/arch/mips/configs/db1xxx_defconfig
> +++ b/arch/mips/configs/db1xxx_defconfig
> @@ -113,6 +113,7 @@ CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ECC_BCH=y
>  CONFIG_MTD_NAND_AU1550=y
>  CONFIG_MTD_NAND_PLATFORM=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_EEPROM_AT24=y
>  CONFIG_EEPROM_AT25=y
>  CONFIG_SCSI_TGT=y
> diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
> index d1741bcf8949..d14ae2fa7d13 100644
> --- a/arch/mips/configs/rt305x_defconfig
> +++ b/arch/mips/configs/rt305x_defconfig
> @@ -81,7 +81,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  # CONFIG_FIRMWARE_IN_KERNEL is not set
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_CHAR=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_AMDSTD=y
> @@ -89,6 +88,7 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_PHYSMAP_OF=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_EEPROM_93CX6=m
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
> --
> 1.8.3.2
>
>



-- 
Florian
