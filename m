Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 21:40:54 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56567 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225193AbTDAUkx>;
	Tue, 1 Apr 2003 21:40:53 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA05070;
	Tue, 1 Apr 2003 12:39:41 -0800
Subject: Re: Patch to disable PCI coherency on AU1500 platforms
From: Pete Popov <ppopov@mvista.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <3E89F17B.5EFA2E37@ekner.info>
References: <3E898652.2717AEF2@ekner.info>
	 <1049221843.26884.256.camel@zeus.mvista.com> <3E89F17B.5EFA2E37@ekner.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1049229637.5038.173.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 12:40:44 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-04-01 at 12:07, Hartvig Ekner wrote:
> Sure, no problem waiting - I don't have the problem  any more :-)
> However, if you don't have this
> fix in your kernel, you should see massive PCI transfer errors (as I
> did), which can explain why your "cp -a" fails.
> OTOH, I can't explain why you don't see the same problem on the older
> 2.4.18 kernel you mentioned was working just fine.

I don't see the errors you describe.  Even if the IDE problem I'm seeing
is caused by this bug, I still don't see 'massive' pci transfer errors.

I'll check the errata again the silicon version I have.

> HPT371 also works here (== it boots without crashing midstream during
> boot) after updating to the latest CVS with the new IDE code. I will
> run some stress tests to see if the residual errors (even
> with PCI_CFG[NC] set) also occur on this controller, or only on the
> Promise.

Pete

> /Hartvig
> 
> Pete Popov wrote:
> 
> > I have a Pb1500 but like I said, I won't be able to get to it until
> end
> > of the month. I would really like to run some stress tests before
> > applying such core patches.  Can you wait until I get back?
> >
> > Pete
> >
> > On Tue, 2003-04-01 at 04:30, Hartvig Ekner wrote:
> > > The patch below sets the NC bit in the PCI_CFG register to disable HW coherency when
> > > running non-coherent. Until now, this bit was cleared which means corruption when using PCI
> > > DMA masters, even if the kernel was correctly compiled with CONFIG_NONCOHERENT_IO.
> > >
> > > Pb1500 specific notes: I don't have a PB1500, so I cannot test if it works there. Note: I also
> > > removed what I think was an extraneous write to the PCI_CMEM register, so if somebody
> > > could test this on a PB1500 it would be great.
> > >
> > > /Hartvig
> > >
> > >
> > >
> > > ______________________________________________________________________
> > >
> > > Index: db1x00/setup.c
> > > ===================================================================
> > > RCS file: /home/cvs/linux/arch/mips/au1000/db1x00/Attic/setup.c,v
> > > retrieving revision 1.1.2.4
> > > diff -u -r1.1.2.4 setup.c
> > > --- db1x00/setup.c    21 Mar 2003 19:00:46 -0000      1.1.2.4
> > > +++ db1x00/setup.c    1 Apr 2003 12:14:54 -0000
> > > @@ -78,9 +78,8 @@
> > >  void __init au1x00_setup(void)
> > >  {
> > >       char *argptr;
> > > -     u32 pin_func, static_cfg0;
> > > -     u32 sys_freqctrl, sys_clksrc;
> > > -     u32 prid = read_c0_prid();
> > > +     u32 pin_func;
> > > +//   u32 prid = read_c0_prid();
> > >
> > >       argptr = prom_getcmdline();
> > >
> > > @@ -187,6 +186,19 @@
> > >
> > >  #ifdef CONFIG_BLK_DEV_IDE
> > >       ide_ops = &std_ide_ops;
> > > +#endif
> > > +
> > > +#ifdef CONFIG_PCI
> > > +     /* Although YAMON has setup the PCI controller, some things
> > > +        may need to change. Eventually, all the PCI initialization
> > > +        should be done here (as in eg. ../pb1500/setup.c)
> > > +     */
> > > +
> > > +#ifdef CONFIG_NONCOHERENT_IO
> > > +     /* Must disable PCI coherency if running non-coherent */
> > > +
> > > +     au_writel(au_readl(Au1500_PCI_CFG) | (1<<16), Au1500_PCI_CFG);
> > > +#endif
> > >  #endif
> > >
> > >  #if 0
> > > Index: pb1500/setup.c
> > > ===================================================================
> > > RCS file: /home/cvs/linux/arch/mips/au1000/pb1500/setup.c,v
> > > retrieving revision 1.1.2.12
> > > diff -u -r1.1.2.12 setup.c
> > > --- pb1500/setup.c    21 Mar 2003 19:00:47 -0000      1.1.2.12
> > > +++ pb1500/setup.c    1 Apr 2003 12:14:54 -0000
> > > @@ -35,6 +35,7 @@
> > >  #include <linux/console.h>
> > >  #include <linux/mc146818rtc.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/proc_fs.h>
> > >
> > >  #include <asm/cpu.h>
> > >  #include <asm/bootinfo.h>
> > > @@ -90,6 +91,7 @@
> > >       char *argptr;
> > >       u32 pin_func, static_cfg0;
> > >       u32 sys_freqctrl, sys_clksrc;
> > > +     u32 pcicfg;
> > >
> > >       argptr = prom_getcmdline();
> > >
> > > @@ -232,15 +234,25 @@
> > >
> > >  #ifdef CONFIG_PCI
> > >       // Setup PCI bus controller
> > > -     au_writel(0, Au1500_PCI_CMEM);
> > > -     au_writel(0x00003fff, Au1500_CFG_BASE);
> > > +
> > > +     au_writel(0x00003fff, Au1500_PCI_CMEM);
> > > +
> > >  #if defined(__MIPSEB__)
> > > -     au_writel(0xf | (2<<6) | (1<<4), Au1500_PCI_CFG);
> > > +     pcicfg = 0xf | (2<<6) | (1<<4);
> > >  #else
> > > -     au_writel(0xf, Au1500_PCI_CFG);
> > > +     pcicfg = 0xf;
> > >  #endif
> > > +
> > > +#ifdef CONFIG_NONCOHERENT_IO
> > > +     /* Must disable PCI coherency if running non-coherent */
> > > +
> > > +     pcicfg |= (1<<16);
> > > +#endif
> > > +
> > > +     au_writel(pcicfg,     Au1500_PCI_CFG);
> > > +
> > >       au_writel(0xf0000000, Au1500_PCI_MWMASK_DEV);
> > > -     au_writel(0, Au1500_PCI_MWBASE_REV_CCL);
> > > +     au_writel(0,          Au1500_PCI_MWBASE_REV_CCL);
> > >       au_writel(0x02a00356, Au1500_PCI_STATCMD);
> > >       au_writel(0x00003c04, Au1500_PCI_HDRTYPE);
> > >       au_writel(0x00000008, Au1500_PCI_MBAR);
> 
> 
