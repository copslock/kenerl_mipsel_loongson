Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 08:43:53 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:1288 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225073AbTDAHnu>;
	Tue, 1 Apr 2003 08:43:50 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP
	id 18536B5D6; Tue,  1 Apr 2003 09:43:48 +0200 (CEST)
Message-ID: <3E8944EA.6E7AE06C@ekner.info>
Date: Tue, 01 Apr 2003 09:51:06 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete@ekner.info, Popov@ekner.info
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Au1500 hardware cache coherency
References: <3E882FB8.BBFDACE2@ekner.info> <3E8853B3.9080902@amd.com>
		 <3E885B68.6927451E@ekner.info> <3E8883B8.1000000@amd.com>
		 <3E889602.62B7AB6B@ekner.info> <1049142818.26677.68.camel@zeus.mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

Hi Pete,

Pete Popov wrote:

> On Mon, 2003-03-31 at 11:24, Hartvig Ekner wrote:
> > Hi Eric,
> >
> > I did a quick check of a complete kernel disassembly, and there are
> > tons of direct or indirect RMW's to config, which do not explicitly
> > insure that Config[0D] is set.
> > Pete - are you aware of this?
>
> Config[OD] is set in setup.c and should not be cleared afterward.
>

Due to errata #4, it is cleared whenever macroes like set_c0_config or change_c0_config is
called. This happens in several places:

    au1000_restart (probably doesn't matter?)
    cache parity error exception (doesn't matter, we're probably dying anyway)
    ld_mmu_mips32 (in c-mips32.c)

I'm not quite sure whether ld_mmu_mips32 is called after au1x00 setup, but if it is,
the bit is cleared, never to be set again. Maybe the c0_config macroes should be changed
due to errata #4?


> > So, to summarize: The first set of problems in my email below seem to
> > be fully explained by errata #14. Note that any kernel compiled from
> > the current CVS exhibits this problem:
> > Because although NONCOHEHENT_IO is set, the NC bit in PCI_CFG is not
> > set.
>
> Hmm, ok, I'll check that out.

>
>
> > I have verified that the problem occurs when NC is cleared, regardless
> > of the .config option. So some code needs to be changed in
> > au1000/xxx/setup.c... (set NC if NONCOHERENT_IO
> > is enabled).
>
> > But - much wore worrisome: I did this modification, and with the NC
> > bit set, and NONCOHERENT_IO set, I get the second set of errors,
> > although it takes much longer time. The wback_inv calls are made
> > through the generic code  in the subroutine
> > pci_alloc_consistent() (in arch/mips/kernel/pci-dma.c).
>
> > So something is wrong.... Anybody at AMD who would care to continue
> > the debug?
>
> Can you send me your test and exact instructions on how you're
> duplicating the error? I won't have time to look at it until after 4/20
> though.
>

Sure. However, I will first try to make sure that the kernel does not have the same problem on another
non AU1500 platform.

BTW, are you using the HPT onboard IDE controller? Last time I tried, it wasn't functional, the kernel crashed
during boot when kudzu was doing some HW probing on the IDE stuff. I'm using a plug-in promise card
(20268 based).

/Hartvig
