Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 20:25:20 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:44931 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225248AbTBUUZT>;
	Fri, 21 Feb 2003 20:25:19 +0000
Received: (qmail 26316 invoked by uid 6180); 21 Feb 2003 20:25:16 -0000
Date: Fri, 21 Feb 2003 12:25:16 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: ppopov@mvista.com
Cc: linux-mips@linux-mips.org
Subject: fixup_bigphys_addr and DBAu1500 dev board
Message-ID: <20030221122515.E20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <200302201135.09154.krishnakumar@naturesoft.net> <20030221.112456.41627052.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030221.112456.41627052.nemoto@toshiba-tops.co.jp>; from anemo@mba.sphere.ne.jp on Fri, Feb 21, 2003 at 11:24:56AM +0900
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Gentlemen:

I've just received a DBAu1500 development board, along with a Texas Instruments
PCI1510 CardBus bridge PCI card.  As such, I believe that I'm interested in
addressing the full 36 bit physical address space on the board.

I've installed the cross-compiling toolchain from
{ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3}. mipsel-linux-gcc reports
version 2.96, mipsel-linux-ld reports 2.13.90.0.16. I have successfully built
other kernels with this toolchain for my board.

I checked out the latest linux_2_4 as of yesterday, copied the default
config for my board (cp arch/mips/defconfig-db1500), did 'make oldconfig',
and then 'make dep && make vmlinux'.

At the final linking of the kernel, here's what happened:

    mipsel-linux-ld -G 0 -static  -T arch/mips/ld.script arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
            --start-group \
            arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o \
             drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/wireless/wireless_net.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
            net/network.o \
            arch/mips/lib/lib.a /home/baitisj/au_dev/mips_linux/linux/lib/lib.a arch/mips/au1000/db1x00/db1x00.o arch/mips/au1000/common/au1000.o \
            --end-group \
            -o vmlinux
    arch/mips/au1000/db1x00/db1x00.o(.text.init+0x160): In function `au1x00_setup':
    : undefined reference to `fixup_bigphys_addr'
    arch/mips/au1000/db1x00/db1x00.o(.text.init+0x164): In function `au1x00_setup':
    : undefined reference to `fixup_bigphys_addr'
    make: *** [vmlinux] Error 1


I took a look at arch/mips/au1000/db1x00/setup.c, and it appears that I'm
running into issues with:

    #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_AU1500)
      extern phys_t (*fixup_bigphys_addr)(phys_t phys_addr, phys_t size);
    #endif

I recursively grepped through my kernel source and could find no other
references to 'fixup_bigphys_addr'.

I browsed the CVS log for setup.c, resulting in the following:

    Revision 1.1.2.2 / Mon Dec 16 18:00:48 2002 UTC (2 months ago) by ppopov
    Branch: linux_2_4
    Changes since 1.1.2.1: +30 -0 lines
    Diff to previous 1.1.2.1 to branchpoint 1.1

    - cleaned up dead code
    - updated the Db1x pci code to patch the Pb1500
    - renamed __ioremap_fixup to fixup_bigphys_addr to match a new
    36 bit address patch.


    Revision 1.1.2.1 / Wed Dec 11 06:12:29 2002 UTC (2 months, 1 week ago) by
                       ppopov
    Branch: linux_2_4
    Changes since 1.1: +212 -0 lines
    Diff to previous 1.1

    Alchemy Au1x updates:
    - better config options to separate CPU and boards specific options
    - Added support for the Db1x boards
    - fixed usbdev compile problems
    - update to Pb1500 pci code

My next move was to cvs up -D "one month ago" my kernel_2_4 source. I cleaned,
and repeated the compiling procedure above, with the same result.

I'd love to know where this mystery fixup_bigphys_addr comes from!?

Thank you all for your hard work! I look forward to contributing in any
way that I can.


Best regards,

Jeff



-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
