Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 19:44:33 +0100 (BST)
Received: from p508B6C80.dip.t-dialin.net ([IPv6:::ffff:80.139.108.128]:55174
	"EHLO p508B6C80.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225211AbUJNSoZ>; Thu, 14 Oct 2004 19:44:25 +0100
Received: from web81002.mail.yahoo.com ([IPv6:::ffff:206.190.37.147]:25768
	"HELO web81002.mail.yahoo.com") by linux-mips.net with SMTP
	id <S869519AbUJNSi2>; Thu, 14 Oct 2004 20:38:28 +0200
Message-ID: <20041014183712.33250.qmail@web81002.mail.yahoo.com>
Received: from [216.98.102.225] by web81002.mail.yahoo.com via HTTP; Thu, 14 Oct 2004 11:37:12 PDT
X-RocketYMMF: pvpopov@pacbell.net
Date: Thu, 14 Oct 2004 11:37:12 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: Building 2.6 cvs head on db1550
To: Christian Hecimovic <checimovic@sutus.com>,
	linux-mips@linux-mips.org
In-Reply-To: <200410141028.41750.checimovic@sutus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


--- Christian Hecimovic <checimovic@sutus.com> wrote:

> Hi Pete,
> 
> Thanks for the advice. Indeed, with the help of your
> patches, we are up and running. 

Good to hear. BTW, I'm pushing the patches but I'm not
the only developer that's contributing to those
patches.

> As for your hpt driver problems, perhaps this patch
> will help you. It works for us, anyway ;) 

:) That's the 2.4 patch I have in my linux-mips
directory. For some reason it doesn't work for me in
2.6. Unfortunately it appears to be a timing issue of
some sort because when I put some debug prints, the
problem goes away. I'll debug it later ...

Pete

> 
> Index: drivers/ide/pci/hpt366.c
>
===================================================================
> RCS file: /home/cvs/linux/drivers/ide/pci/hpt366.c,v
> retrieving revision 1.26
> diff -u -p -r1.26 hpt366.c
> --- drivers/ide/pci/hpt366.c    19 Sep 2004 12:30:10
> -0000      1.26
> +++ drivers/ide/pci/hpt366.c    14 Oct 2004 10:14:37
> -0000
> @@ -880,7 +880,7 @@ static int __devinit
> init_hpt37x(struct
>                 did = inb(dmabase + 0x22);
>                 rid = inb(dmabase + 0x28);
>  
> -               if((did == 4 && rid == 6) || (did ==
> 5 && rid > 1))
> +               if((did == 4 && rid == 6) || (did ==
> 5 && rid > 1) || (did == 
> 7 && rid == 2))
>                         is_372n = 1;
>         }
>  
> 
> Thanks,
> 
> Christian
> 
> On Tuesday 12 October 2004 02:24 am, Pete Popov
> wrote:
> > Christian,
> >
> > Pull the latest bits from linux-mips and try
> again. Make sure you apply
> > the patches in my ftp.linux-mips.org directory.
> Unfortunately there
> > appears to be a bug in the hpt driver because
> other ide drivers work
> > fine.  I need to revisit this later. Also, the
> pcmcia driver for the
> > db1550 isn't ready but I'll complete that shortly.
> >
> > Pete
> >
> > Christian Hecimovic wrote:
> > > I'm having problems building 2.6 head from the
> linux-mips cvs. There were
> > > a number of build errors with the
> /arch/mips/config/db1550-defconfig
> > > file. Eventually, it built with a number of
> fixes. Here's the diff:
> > >
> > > Index: arch/mips/Kconfig
> > >
>
===================================================================
> > > RCS file: /home/cvs/linux/arch/mips/Kconfig,v
> > > retrieving revision 1.96
> > > diff -r1.96 Kconfig
> > > 583a584
> > >
> > >>	select DMA_NONCOHERENT
> > >
> > > Index: arch/mips/Makefile
> > >
>
===================================================================
> > > RCS file: /home/cvs/linux/arch/mips/Makefile,v
> > > retrieving revision 1.176
> > > diff -r1.176 Makefile
> > > 19c19
> > > < 32bit-tool-prefix	= mipsel-linux-
> > > ---
> > >
> > >>32bit-tool-prefix	= mipsel-unknown-linux-gnu-
> > >
> > > Index: arch/mips/mm/ioremap.c
> > >
>
===================================================================
> > > RCS file:
> /home/cvs/linux/arch/mips/mm/ioremap.c,v
> > > retrieving revision 1.19
> > > diff -r1.19 ioremap.c
> > > 99a100,110
> > >
> > >> *  * Allow physical addresses to be fixed up to
> help 36 bit
> > >> *   * peripherals.
> > >> *    */
> > >>static phys_t def_fixup_bigphys_addr(phys_t
> phys_addr, phys_t size)
> > >>{
> > >>	        return phys_addr;
> > >>}
> > >>
> > >>phys_t (*fixup_bigphys_addr)(phys_t phys_addr,
> phys_t size) =
> > >
> > > def_fixup_bigphys_addr;
> > >
> > >>/*
> > >
> > > 121a133,134
> > >
> > >>	phys_addr = fixup_bigphys_addr(phys_addr,
> size);
> > >
> > > Index: drivers/mtd/maps/db1550-flash.c
> > >
>
===================================================================
> > > RCS file:
> /home/cvs/linux/drivers/mtd/maps/db1550-flash.c,v
> > > retrieving revision 1.1
> > > diff -r1.1 db1550-flash.c
> > > 22c22
> > > < #include <asm/au1000.h>
> > > ---
> > >
> > >>#include <asm/mach-au1x00/au1000.h>
> > >
> > > Index: drivers/pcmcia/Makefile
> > >
>
===================================================================
> > > RCS file:
> /home/cvs/linux/drivers/pcmcia/Makefile,v
> > > retrieving revision 1.34
> > > diff -r1.34 Makefile
> > > 46a47
> > >
> > >>au1x00_ss-$(CONFIG_MIPS_DB1550)			+=
> au1000_db1x00.o
> > >
> > > Index: drivers/pcmcia/au1000_generic.c
> > >
>
===================================================================
> > > RCS file:
> /home/cvs/linux/drivers/pcmcia/au1000_generic.c,v
> > > retrieving revision 1.14
> > > diff -r1.14 au1000_generic.c
> > > 80c80
> > > < #elif defined(CONFIG_MIPS_DB1000) ||
> defined(CONFIG_MIPS_DB1100) ||
> > > defined(CONFIG_MIPS_DB1500)
> > > ---
> > >
> > >>#elif defined(CONFIG_MIPS_DB1000) ||
> defined(CONFIG_MIPS_DB1100) ||
> > >
> > > defined(CONFIG_MIPS_DB1500) ||
> defined(CONFIG_MIPS_DB1550)
> > > 152,153d151
> > > < 	printk(KERN_DEBUG, "%s initializing socket
> %u\n", __FUNCTION__,
> > > skt->nr); <
> > > 315,316d312
> > > < 		printk(KERN_ERR, "%smap (%d) out of
> range\n",
> > > < 				__FUNCTION__, map->map);
> > > 339,340d334
> > > < 		printk(KERN_ERR, "%s map (%d) out of
> range\n",
> > > < 				__FUNCTION__, map->map);
> > > 353c347
> > > < 		map->sys_start = skt->phys_attr +
> map->card_start;
> > > ---
> > >
> > >>		map->static_start = skt->phys_attr +
> map->card_start;
> > >
> > > 356c350
> > > < 		map->sys_start = skt->phys_mem +
> map->card_start;
> > > ---
> > >
> > >>		map->static_start = skt->phys_mem +
> map->card_start;
> > >
> > > 359,361c353,354
> > > < 	map->sys_stop=map->sys_start+MAP_SIZE;
> > > < 	debug(4, "set_mem_map %d start %Lx stop %Lx
> card_start %x\n",
> > > < 			map->map, map->sys_start, map->sys_stop,
> > > ---
> > >
> > >>	debug(4, "set_mem_map %d start %Lx card_start
> %x\n",
> > >>			map->map, map->sys_static,
> > >
> > > Index: drivers/pcmcia/au1000_generic.h
> > >
>
===================================================================
> > > RCS file:
> /home/cvs/linux/drivers/pcmcia/au1000_generic.h,v
> 
=== message truncated ===
