Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 19:33:26 +0100 (BST)
Received: from pirx.hexapodia.org ([IPv6:::ffff:199.199.212.25]:39994 "EHLO
	pirx.hexapodia.org") by linux-mips.org with ESMTP
	id <S8226312AbVDSSdJ>; Tue, 19 Apr 2005 19:33:09 +0100
Received: by pirx.hexapodia.org (Postfix, from userid 22448)
	id 14989402; Tue, 19 Apr 2005 11:33:00 -0700 (PDT)
Date:	Tue, 19 Apr 2005 11:32:59 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	Henk <Henk.Vergonet@gmail.com>
Cc:	Waldemar Brodkorb <wbx@openbsd-geek.de>, linux-mips@linux-mips.org
Subject: Re: Porting mips based routers
Message-ID: <20050419183259.GA623@hexapodia.org>
References: <20050414210645.GB30585@god.dyndns.org> <20050415065558.GD25962@openbsd-geek.de> <20050418124809.GA27967@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418124809.GA27967@god.dyndns.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2005 at 02:48:09PM +0200, Henk wrote:
> On Fri, Apr 15, 2005 at 08:55:58AM +0200, Waldemar Brodkorb wrote:
> > > I will try to see if I can get a list of 2.4 source files that need to
> > > be contributed back to linux-mips.org, with a quick initial proposal on
> > > how to migrate this to the 2.6 kernel tree.
> 
> See section 1.3 on the wiki page:
> http://openwrt.org/Kernel26Firmware
> Feel free to comment here on the list.

One comment:

# - Migrate: Should we cluster this with the sibyte stuf? Probably
# there's some shared code....

SiByte and the 47xx don't share anything significant beyond both being
MIPS, and both running CFE.  And people (including Ralf) actually have
SiByte hardware that they test on.  So not breaking SiByte would be a
good thing.

Because there's no technical connection between SiByte and 47xx I'd lean
towards leaving the SiByte stuff alone, and clean up the 47xx code on
its own.

> General comments on the WRT code:

The code is full of "Broadcom Proprietary" and "All Rights Reserved"
notices.  Does anyone have a clear written statement from Broadcom that
it's redistributable?  (If you're depending on the GPL release
requirements to justify relicensing, clear documentation of the chain of
release would be helpful.)

>  - We should probably make some abstraction/API of the so called Silicon
>   Backplane bus that broadcom defined. I see allot of drivers, even in
>   the mainline kernel (b44 ethernet driver) that use this.

The Silicon Backplane bus actually came from another company, it wasn't
defined by Broadcom; google knows all:
http://www.ocpip.org/socket/adoption/sonics

I think there are other OCP busses supported in the kernel; ISTR seeing
some PPC SoC from IBM that uses OCP... so perhaps this should be brought
up on l-k for general discussion.

But it's challenging to come up with a useful abstraction that covers
both the b44 scenario and the SoC scenario.

 - for b44, OCP is on the far side of the PCI bus, and is used only to
   access a single core (ethernet MAC).

 - for bcm947xx (and ppc SoC, I guess), OCP is the system bus, and is
   used to access everything from PCI to DRAM.

grep grep grep... Take a look at include/asm-ppc/ocp.h and
arch/ppc/platforms/*.c, it looks like the PowerPC people have already
done a bunch of work here.

-andy
