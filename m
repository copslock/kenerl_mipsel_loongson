Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 15:53:20 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:26246 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S868881AbSKZMsr>; Tue, 26 Nov 2002 13:48:47 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAQCsQb19320;
	Tue, 26 Nov 2002 13:54:26 +0100
Date: Tue, 26 Nov 2002 13:54:25 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Zyngier <mzyngier@freesurf.fr>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: cli/sti removal from wd33c93.c
Message-ID: <20021126135425.A19238@linux-mips.org>
References: <20021125123750.A11523@linux-mips.org> <Pine.GSO.4.21.0211261340040.18990-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0211261340040.18990-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Nov 26, 2002 at 01:47:04PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 26, 2002 at 01:47:04PM +0100, Geert Uytterhoeven wrote:

> On Mon, 25 Nov 2002, Ralf Baechle wrote:
> > Below are patches to replace cli/sti and accomplices from the WD33c93
> > driver.  Who is currently the maintainer of this driver?  Ok to send to
> > Linus?
> 
> Feel free to send it to Linus. Meanwhile I'll check it in in the m68k tree.
> 
> > 2.5 doesn't boot on MIPS yet so this patch is untested.  This patch gets
> > it to build; it was written by Marc Zygnier and reviewed by me and we
> > think it does the right thing.
> 
> To me it looks OK as well. Unfortunately I don't have wd33c93 hardware (except
> in the old A500/A590, which doesn't run uClinux well/yet :-).
> 
> BTW, am I correct in assuming that the driver is broken on 2.4.x as well?
> It looks like there are lots of paths in wd33c93_intr() where interrupts
> aren't properly restored.

I don't have any recent bug reports about the driver on SGI hardware.  All
I can say it feels a little slow but I'm not sure how much I can expect
from my good ol' Indy.  And I think it would gain from being fed through
Lindent ...

  Ralf
