Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2008 08:16:49 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:29353 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022857AbYFFHQr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jun 2008 08:16:47 +0100
Received: (qmail 16539 invoked by uid 1000); 6 Jun 2008 09:16:46 +0200
Date:	Fri, 6 Jun 2008 09:16:46 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	ralf@linux-mips.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] Alchemy: export get_au1x00_speed for modules
Message-ID: <20080606071646.GA16498@roarinelk.homelinux.net>
References: <20080519080339.GA21985@roarinelk.homelinux.net> <20080519080416.GB21985@roarinelk.homelinux.net> <483149E0.6010009@ru.mvista.com> <20080519094953.GA22445@roarinelk.homelinux.net> <20080605230311.7f98cd1a@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080605230311.7f98cd1a@mjolnir.drzeus.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Folks,

On Thu, Jun 05, 2008 at 11:03:11PM +0200, Pierre Ossman wrote:
> On Mon, 19 May 2008 11:49:53 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
> > Hi Sergei,
> > 
> > >> From 8492076e98c7fd47c9dee53984dbd9568ace357d Mon Sep 17 00:00:00 2001
> > >> From: Manuel Lauss <mlau@msc-ge.com>
> > >> Date: Wed, 7 May 2008 13:42:55 +0200
> > >> Subject: [PATCH] Alchemy: export get_au1x00_speed for modules
> > >>
> > >> au1xmmc.c driver depends on it, so export it for modules.
> > >>
> > >> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> > >>   
> > >
> > >   I thought that has been merged.
> > 
> > Yes, Ralf merged it into linux-mips repo, but it is not yet in
> > mainline and the rest of the patches are against linus' git.
> > 
> 
> So who should push this to Linus? If this set is the only patches
> depending on it, it would be easiest if I carry it in my tree.

I'd prefer if you (Pierre) carried them all since they all depend on
each other (kind of, anyway).  And it seems Ralf has gone silent anyway :)

Thank you!
	Manuel Lauss
