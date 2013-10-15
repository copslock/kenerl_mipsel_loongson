Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2013 12:20:02 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1272 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823067Ab3JOKTuh2V7P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Oct 2013 12:19:50 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 15 Oct 2013 03:19:29 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 15 Oct 2013 03:19:40 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 15 Oct 2013 03:19:40 -0700
Received: from xl-blr-01.broadcom.com (xl-blr-01.ban.broadcom.com
 [10.132.130.166]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 D5916246A3; Tue, 15 Oct 2013 03:19:39 -0700 (PDT)
Received: by xl-blr-01.broadcom.com (Postfix, from userid 31394) id
 CB154146A4DC; Tue, 15 Oct 2013 15:49:38 +0530 (IST)
Date:   Tue, 15 Oct 2013 15:49:38 +0530
From:   "Ashok Kumar" <ashoks@broadcom.com>
To:     "Jonas Gorski" <jogo@openwrt.org>
cc:     "MIPS Mailing List" <linux-mips@linux-mips.org>, gerg@uclinux.org,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix mapstart when using initrd
Message-ID: <20131015101932.GA3198@ashoks@broadcom.com>
References: <1379945426-32205-1-git-send-email-ashoks@broadcom.com>
 <CAOiHx==DTt5U_yjS8vNyZyrm3KRJfjLMGFxr7oRdYPa-uoSTEA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOiHx==DTt5U_yjS8vNyZyrm3KRJfjLMGFxr7oRdYPa-uoSTEA@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-WSS-ID: 7E43C93B2E41685936-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <ashoks@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashoks@broadcom.com
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

On Mon, Oct 14, 2013 at 02:05:44PM +0200, Jonas Gorski wrote:
> On Mon, Sep 23, 2013 at 4:10 PM, Ashok Kumar <ashoks@broadcom.com> wrote:
> > When initrd is present in the PFN right after the _end, bootmem
> > bitmap(mapstart) overwrites it. So check for initrd_end in
> > mapstart calculation.
> >
> > Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> > ---
> > This is seen after the commit
> > "mips: fix start of free memory when using initrd"
> > in git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git branch
> >
> > Tested the image on MIPS platform creating the above
> > said scenario and initrd was corrupted.
> 
> Unfortunately this commit breaks booting ramdisk images on bcm63xx, at
> least git bisect claims it to be responsible for:
> 
> Closing DMA Channels.
> Starting program at 0x80284b60
> [    0.000000] Linux version 3.12.0-rc4+ (jonas@ixxyvirt) (gcc version
> 4.8.) #254 SMP Mon Oct 14 13:12:35 CEST 2013
> [    0.000000] Detected Broadcom 0x6328 CPU revision b0
> [    0.000000] CPU frequency is 320 MHz
> [    0.000000] 128MB of RAM installed
> [    0.000000] registering 32 GPIOs
> [    0.000000] board_bcm963xx: CFE version: 1.0.37-106.17
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU revision is: 0002a075 (Broadcom BMIPS4350)
> [    0.000000] board_bcm963xx: board name: 96328avng
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 08000000 @ 00000000 (usable)
> **Exception 8: EPC=00000000, Cause=00000000 (Interrupt)
>                 RA=00000000, VAddr=00000000
> 
>         0  ($00) = 8016E5F4     AT ($01) = 00000000
>         v0 ($02) = 00000000     v1 ($03) = 0000000A
>         a0 ($04) = FFFFFFFF     a1 ($05) = 0006FFFF
>         a2 ($06) = 00000000     a3 ($07) = 803D6730
>         t0 ($08) = 0000002A     t1 ($09) = 00000000
>         t2 ($10) = 802D5203     t3 ($11) = 8029D2F8
>         t4 ($12) = 803D6737     t5 ($13) = 802D5203
>         t6 ($14) = 00000000     t7 ($15) = 8030BD68
>         s0 ($16) = 8016E5F4     s1 ($17) = 803D6737
>         s2 ($18) = 802D5203     s3 ($19) = 8029D2F8
>         s4 ($20) = 8030BD90     s5 ($21) = 8016E5F4
>         s6 ($22) = 00000001     s7 ($23) = 803D6730
>         t8 ($24) = 0000000A     t9 ($25) = FFFFFFFF
>         k0 ($26) = 0006FFFF     k1 ($27) = 8016EF08
>         gp ($28) = 803F0000     sp ($29) = 8001DAC0
>         fp ($30) = 0000001D     ra ($31) = 00000000
> 
> 
> Probably relevant config parts are:
> 
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE="/home/jonas/openwrt/trunk/build_dir/target-mips_mips32_uClibc-0.9.33.2/root-brcm63xx
> /home/jonas/openwrt/trunk/target/linux/generic/image/initramfs-base-files.txt"
> CONFIG_INITRAMFS_ROOT_UID=1000
> CONFIG_INITRAMFS_ROOT_GID=1000
> # CONFIG_RD_GZIP is not set
> # CONFIG_RD_BZIP2 is not set
> # CONFIG_RD_LZMA is not set
> CONFIG_RD_XZ=y
> # CONFIG_RD_LZO is not set
> # CONFIG_RD_LZ4 is not set
> # CONFIG_INITRAMFS_COMPRESSION_NONE is not set
> CONFIG_INITRAMFS_COMPRESSION_XZ=y
> 
> >  arch/mips/kernel/setup.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > index 5342385..dfb8585 100644
> > --- a/arch/mips/kernel/setup.c
> > +++ b/arch/mips/kernel/setup.c
> > @@ -364,6 +364,11 @@ static void __init bootmem_init(void)
> >         }
> >
> >         /*
> > +        * mapstart should be after initrd_end
> > +        */
> > +       mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
> 
> I wonder if this still holds if the initrd is compressed like in my
> config, but that's just random guessing. I can't test it since I need
> a compressed initrd, else the elf gets too big for CFE.

when initramfs(compressed/uncompressed) is used and initrd is not used, 
initrd_end should be zero. In 32-bit kernel __pa(0) becomes 0x80000000
and mapstart points to wrong address. Added check for non zero initrd_end
before finding max.

I have tested the below patch on XLP 32-bit BE/LE, 64-bit BE/LE and 
it works fine. could you please test this on your bcm63xx board.

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9d5d31d..a842154 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -367,7 +367,8 @@ static void __init bootmem_init(void)
    /*
     * mapstart should be after initrd_end
     */
-   mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
+   if (initrd_end)
+       mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
 #endif

- Ashok

> 
> > +
> > +       /*
> >          * Initialize the boot-time allocator with low memory only.
> >          */
> >         bootmap_size = init_bootmem_node(NODE_DATA(0), mapstart,
> 
> 
> Regards
> Jonas
> 
