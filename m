Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 07:47:02 +0000 (GMT)
Received: from ftp.mips.com ([206.31.31.227]:21501 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225218AbSLLHrB>;
	Thu, 12 Dec 2002 07:47:01 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gBC7koNf005546;
	Wed, 11 Dec 2002 23:46:50 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA19082;
	Wed, 11 Dec 2002 23:46:52 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gBC7kqb22811;
	Thu, 12 Dec 2002 08:46:52 +0100 (MET)
Message-ID: <3DF83EEC.23C991D4@mips.com>
Date: Thu, 12 Dec 2002 08:46:52 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Malta board patch
References: <3DF6F54C.64858797@mips.com> <20021211090405.B6755@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

> A couple of nit-picking points ...
>
> On Wed, Dec 11, 2002 at 09:20:28AM +0100, Carsten Langgaard wrote:
> > Index: arch/mips/mips-boards/generic/pci.c
> > ===================================================================
> > RCS file: /home/cvs/linux/arch/mips/mips-boards/generic/pci.c,v
> > retrieving revision 1.5.2.4
> > diff -u -r1.5.2.4 pci.c
> > --- arch/mips/mips-boards/generic/pci.c       28 Sep 2002 18:28:44 -0000      1.5.2.4
> > +++ arch/mips/mips-boards/generic/pci.c       11 Dec 2002 08:11:56 -0000
> > @@ -405,6 +405,12 @@
> >                       ".set\treorder");
> >
> >               irq = *(volatile u32 *)(KSEG1ADDR(BONITO_PCICFG_BASE));
> > +             __asm__ __volatile__(
> > +                     ".set\tnoreorder\n\t"
> > +                     ".set\tnoat\n\t"
> > +                     "sync\n\t"
> > +                     ".set\tat\n\t"
> > +                     ".set\treorder");
> >               irq &= 0xff;
> >               BONITO_PCIMAP_CFG = 0;
> >               break;
>
> Would a higher level macro such as __sync or fast_mb be better here?

I have already send a new patch to Ralf, because he argued for the same thing.
These macros was just not around, when I made this fix.


>
> > Index: arch/mips/mips-boards/malta/malta_int.c
> > ===================================================================
> > RCS file: /home/cvs/linux/arch/mips/mips-boards/malta/malta_int.c,v
> > retrieving revision 1.8.2.6
> > diff -u -r1.8.2.6 malta_int.c
> > --- arch/mips/mips-boards/malta/malta_int.c   5 Aug 2002 23:53:34 -0000       1.8.2.6
> > +++ arch/mips/mips-boards/malta/malta_int.c   11 Dec 2002 08:11:57 -0000
> > @@ -91,6 +91,9 @@
> >  {
> >          unsigned int data,datahi;
> >
> > +     /* Mask out corehi interrupt. */
> > +     clear_c0_status(IE_IRQ3);
> > +
> >          printk("CoreHI interrupt, shouldn't happen, so we die here!!!\n");
> >          printk("epc   : %08lx\nStatus: %08lx\nCause : %08lx\nbadVaddr : %08lx\n"
> >  , regs->cp0_epc, regs->cp0_status, regs->cp0_cause, regs->cp0_badvaddr);
> > @@ -125,7 +128,6 @@
> >
> >          /* We die here*/
> >          die("CoreHi interrupt", regs);
> > -        while (1) ;
> >  }
> >
> >  void __init init_IRQ(void)
>
> I think corehi interrupt should be blocked from the beginning.  I seem to
> remember a board errata itme that recommands not using it.
>

I have found quite a lot of bugs, with the corehi interrupt enabled. It should never
happen, so it indicates a fatal error, if it does.
It's true that on an early revision of some PLD code, there was a bug around the corehi
interrupt. If you got such a board, I suggest you update your PLD code.


>
> Jun

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
