Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 22:35:49 +0100 (BST)
Received: from god.demon.nl ([IPv6:::ffff:83.160.164.11]:17097 "EHLO
	god.dyndns.org") by linux-mips.org with ESMTP id <S8226333AbVDSVfd>;
	Tue, 19 Apr 2005 22:35:33 +0100
Received: by god.dyndns.org (Postfix, from userid 1005)
	id 029664EBE8; Tue, 19 Apr 2005 23:35:29 +0200 (CEST)
Date:	Tue, 19 Apr 2005 23:35:29 +0200
From:	Henk <Henk.Vergonet@gmail.com>
To:	Andy Isaacson <adi@hexapodia.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Porting mips based routers
Message-ID: <20050419213529.GA6447@god.dyndns.org>
References: <20050414210645.GB30585@god.dyndns.org> <20050415065558.GD25962@openbsd-geek.de> <20050418124809.GA27967@god.dyndns.org> <20050419183259.GA623@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419183259.GA623@hexapodia.org>
User-Agent: Mutt/1.5.6i
Return-Path: <spam@god.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Henk.Vergonet@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 19, 2005 at 11:32:59AM -0700, Andy Isaacson wrote:
> On Mon, Apr 18, 2005 at 02:48:09PM +0200, Henk wrote:
> > 
> > See section 1.3 on the wiki page:
> > http://openwrt.org/Kernel26Firmware
> > Feel free to comment here on the list.
> 
> One comment:
> 
> # - Migrate: Should we cluster this with the sibyte stuf? Probably
> # there's some shared code....
> 
> SiByte and the 47xx don't share anything significant beyond both being
> MIPS, and both running CFE.  And people (including Ralf) actually have
> SiByte hardware that they test on.  So not breaking SiByte would be a
> good thing.
> 
> Because there's no technical connection between SiByte and 47xx I'd lean
> towards leaving the SiByte stuff alone, and clean up the 47xx code on
> its own.
> 
Point taken, we should have a seperate broadcom branch.
I will update this on the wiki.

> > General comments on the WRT code:
> 
> The code is full of "Broadcom Proprietary" and "All Rights Reserved"
> notices.  Does anyone have a clear written statement from Broadcom that
> it's redistributable?  (If you're depending on the GPL release
> requirements to justify relicensing, clear documentation of the chain of
> release would be helpful.)

Maybe we should create patch sets that will transform the original wrt
branch into 2.6 code.

Anyway I don't think broadcom is a criminal company, I think it is obliged
by law to comply with the requirements of the GPL ;)

> >  - We should probably make some abstraction/API of the so called Silicon
> >   Backplane bus that broadcom defined. I see allot of drivers, even in
> >   the mainline kernel (b44 ethernet driver) that use this.
> 
> The Silicon Backplane bus actually came from another company, it wasn't
> defined by Broadcom; google knows all:
> http://www.ocpip.org/socket/adoption/sonics
> 
> I think there are other OCP busses supported in the kernel; ISTR seeing
> some PPC SoC from IBM that uses OCP... so perhaps this should be brought
> up on l-k for general discussion.
> 
> But it's challenging to come up with a useful abstraction that covers
> both the b44 scenario and the SoC scenario.
> 
>  - for b44, OCP is on the far side of the PCI bus, and is used only to
>    access a single core (ethernet MAC).
> 
>  - for bcm947xx (and ppc SoC, I guess), OCP is the system bus, and is
>    used to access everything from PCI to DRAM.
> 
> grep grep grep... Take a look at include/asm-ppc/ocp.h and
> arch/ppc/platforms/*.c, it looks like the PowerPC people have already
> done a bunch of work here.
>
Also of interest may be the new SOC abstraction on the hh.org branch, see
http://handhelds.org/cgi-bin/cvsweb.cgi/linux/kernel26/Documentation/soc.txt

Thanks for your comments, greatly appreciated, I will update the OCP stuff
on the wiki.

The task seems a little more challenging than a week ago, anyway I will
focus on the boot code for a while so I can boot test kernels without
the need for reflashing...

regards,

Henk
