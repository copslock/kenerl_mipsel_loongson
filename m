Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 14:06:13 +0200 (CEST)
Received: from 0.mx.nanl.de ([217.115.11.12]:49565 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816285Ab3JNMGK7d90n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 14:06:10 +0200
Received: from mail-vb0-x233.google.com (mail-vb0-x233.google.com [IPv6:2607:f8b0:400c:c02::233])
        by mail.nanl.de (Postfix) with ESMTPSA id 3C7954609C;
        Mon, 14 Oct 2013 12:05:41 +0000 (UTC)
Received: by mail-vb0-f51.google.com with SMTP id x16so4373842vbf.38
        for <multiple recipients>; Mon, 14 Oct 2013 05:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ibcFmQq0SSNfy2EeUWjeRZhSvItvS/dVavpI71a9sDY=;
        b=BDXI7K06YXImc7nM7oxLJ6qEM8urOD38cp/3u8q/q6COuKBf/zqWpPBjtAwCn+6x60
         K04E+3vO3YYKIdcNnYHK5TQdH4bSs8+hWSIPMBg9y5+5bNE0VnGSFFqoeEwQyv4PRqG9
         HjcyEr0+M65q4kZId0rzq35QKE99GPsl8D4tulw3IzOJqHxL+w6zWrXCrwmrWOt9iXws
         qFP6LAZIf/up730iaHes7NQXXksyf4JbEi7ntXXkNB6ucqibLaUZzAQgBPWMXi6P0BpV
         XpWpIsaglWtAn9zWycg0K0iDIWt9Cdx3XeuhfArdaeNk43xgs22BvFMsx6VNf5PIuUp+
         PTgA==
X-Received: by 10.58.156.106 with SMTP id wd10mr6665836veb.7.1381752364193;
 Mon, 14 Oct 2013 05:06:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.221.42.10 with HTTP; Mon, 14 Oct 2013 05:05:44 -0700 (PDT)
In-Reply-To: <1379945426-32205-1-git-send-email-ashoks@broadcom.com>
References: <1379945426-32205-1-git-send-email-ashoks@broadcom.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 14 Oct 2013 14:05:44 +0200
Message-ID: <CAOiHx==DTt5U_yjS8vNyZyrm3KRJfjLMGFxr7oRdYPa-uoSTEA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix mapstart when using initrd
To:     Ashok Kumar <ashoks@broadcom.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>, gerg@uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38321
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

On Mon, Sep 23, 2013 at 4:10 PM, Ashok Kumar <ashoks@broadcom.com> wrote:
> When initrd is present in the PFN right after the _end, bootmem
> bitmap(mapstart) overwrites it. So check for initrd_end in
> mapstart calculation.
>
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> ---
> This is seen after the commit
> "mips: fix start of free memory when using initrd"
> in git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git branch
>
> Tested the image on MIPS platform creating the above
> said scenario and initrd was corrupted.

Unfortunately this commit breaks booting ramdisk images on bcm63xx, at
least git bisect claims it to be responsible for:

Closing DMA Channels.
Starting program at 0x80284b60
[    0.000000] Linux version 3.12.0-rc4+ (jonas@ixxyvirt) (gcc version
4.8.) #254 SMP Mon Oct 14 13:12:35 CEST 2013
[    0.000000] Detected Broadcom 0x6328 CPU revision b0
[    0.000000] CPU frequency is 320 MHz
[    0.000000] 128MB of RAM installed
[    0.000000] registering 32 GPIOs
[    0.000000] board_bcm963xx: CFE version: 1.0.37-106.17
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU revision is: 0002a075 (Broadcom BMIPS4350)
[    0.000000] board_bcm963xx: board name: 96328avng
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 08000000 @ 00000000 (usable)
**Exception 8: EPC=00000000, Cause=00000000 (Interrupt)
                RA=00000000, VAddr=00000000

        0  ($00) = 8016E5F4     AT ($01) = 00000000
        v0 ($02) = 00000000     v1 ($03) = 0000000A
        a0 ($04) = FFFFFFFF     a1 ($05) = 0006FFFF
        a2 ($06) = 00000000     a3 ($07) = 803D6730
        t0 ($08) = 0000002A     t1 ($09) = 00000000
        t2 ($10) = 802D5203     t3 ($11) = 8029D2F8
        t4 ($12) = 803D6737     t5 ($13) = 802D5203
        t6 ($14) = 00000000     t7 ($15) = 8030BD68
        s0 ($16) = 8016E5F4     s1 ($17) = 803D6737
        s2 ($18) = 802D5203     s3 ($19) = 8029D2F8
        s4 ($20) = 8030BD90     s5 ($21) = 8016E5F4
        s6 ($22) = 00000001     s7 ($23) = 803D6730
        t8 ($24) = 0000000A     t9 ($25) = FFFFFFFF
        k0 ($26) = 0006FFFF     k1 ($27) = 8016EF08
        gp ($28) = 803F0000     sp ($29) = 8001DAC0
        fp ($30) = 0000001D     ra ($31) = 00000000


Probably relevant config parts are:

CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE="/home/jonas/openwrt/trunk/build_dir/target-mips_mips32_uClibc-0.9.33.2/root-brcm63xx
/home/jonas/openwrt/trunk/target/linux/generic/image/initramfs-base-files.txt"
CONFIG_INITRAMFS_ROOT_UID=1000
CONFIG_INITRAMFS_ROOT_GID=1000
# CONFIG_RD_GZIP is not set
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_INITRAMFS_COMPRESSION_NONE is not set
CONFIG_INITRAMFS_COMPRESSION_XZ=y

>  arch/mips/kernel/setup.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 5342385..dfb8585 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -364,6 +364,11 @@ static void __init bootmem_init(void)
>         }
>
>         /*
> +        * mapstart should be after initrd_end
> +        */
> +       mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));

I wonder if this still holds if the initrd is compressed like in my
config, but that's just random guessing. I can't test it since I need
a compressed initrd, else the elf gets too big for CFE.

> +
> +       /*
>          * Initialize the boot-time allocator with low memory only.
>          */
>         bootmap_size = init_bootmem_node(NODE_DATA(0), mapstart,


Regards
Jonas
