Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 21:17:18 +0100 (BST)
Received: from p508B6081.dip.t-dialin.net ([IPv6:::ffff:80.139.96.129]:39570
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225229AbTGaURQ>; Thu, 31 Jul 2003 21:17:16 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6VKHEx6017581;
	Thu, 31 Jul 2003 22:17:14 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6VKHD0v017580;
	Thu, 31 Jul 2003 22:17:13 +0200
Date: Thu, 31 Jul 2003 22:17:13 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mips64/setup.c
Message-ID: <20030731201713.GA13263@linux-mips.org>
References: <20030731165225.GA9566@linux-mips.org> <Pine.GSO.4.44.0307311421110.6891-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0307311421110.6891-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 31, 2003 at 02:22:45PM -0400, David Kesselring wrote:

> > On Thu, Jul 31, 2003 at 11:54:15AM -0400, David Kesselring wrote:
> >
> > > Is the file mips64/setup.c used? I believe that I see two problems in it;
> > > 1) The Ocelot options in setup_arch have case statements without a switch.
> >
> > Ocelot 64-bit kernel is currently work in progress.  A first cut of
> > the patch was posted to this mailing list a few days ago.
> >
> > > 2) There is no option for Sead but the mips64 build for sead compiles
> > >    fine.
> >
> > The fun of when two almost identical files go out of sync.
> Then do you know what is happening when 64bit sead is configured? Why
> doesn't the compile fail?

This is easy, there is a function call missing which won't cause an
error message unlike a missing function.  Don't ask me why - it just seems
the 64-bit SEAD port was never completly sent to me or so.  Anyway, I
just fixed this in the linux_2_4 CVS branch; as the result of merging
mips with mips64 this bug was magically dealt with in 2.6.

  Ralf
