Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 15:14:34 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:2268 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225344AbTJ0POW>;
	Mon, 27 Oct 2003 15:14:22 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1AE94X-00076w-4N; Mon, 27 Oct 2003 10:14:21 -0500
Date: Mon, 27 Oct 2003 10:14:21 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Relocation errors
Message-ID: <20031027151421.GA27279@nevyn.them.org>
References: <20031027145803.GA26911@nevyn.them.org> <Pine.GSO.4.44.0310271002480.19642-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310271002480.19642-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Take a look at /usr/include/elf.h:
#define R_MIPS_LITERAL          8       /* 16 bit literal entry */

In this case it's not very informative.  But the problem is probably
mismatched CFLAGS.  Take another look at the options the kernel is
built with - you lost -G 0.  See if that does it.


On Mon, Oct 27, 2003 at 10:06:53AM -0500, David Kesselring wrote:
> It is type 8. Any ideas? This is from an intel driver that I've cross
> compiled for mips. I used these options;
> -mcpu=r4600 -mips2 -mno-abicalls -fno-pic -mlong-calls -Wa,--trap -DMODULE
> -pipe -O3 -fomit-frame-pointer -fno-strict-aliasing
> 
> Thanks, David
> 
> On Mon, 27 Oct 2003, Daniel Jacobowitz wrote:
> 
> > On Mon, Oct 27, 2003 at 08:55:19AM -0500, David Kesselring wrote:
> > > I'm getting the error "Unhandled relocation of type xx" on insmod. Are the
> > > "types" documented somewhere? I am I correct that these "types" are
> > > architecture specific?
> >
> > Yes.  Try an ELF specification - there's a MIPS processor supplement
> > (psABI) floating around.  What's the "xx"?
> >
> > --
> > Daniel Jacobowitz
> > MontaVista Software                         Debian GNU/Linux Developer
> >
> >
> 
> David Kesselring
> Atmel MMC
> dkesselr@mmc.atmel.com
> 919-462-6587
> 
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
