Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 08:15:55 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59354 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024847AbZETHPt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 08:15:49 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4K7FExT017358;
	Wed, 20 May 2009 08:15:14 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4K7FD24017356;
	Wed, 20 May 2009 08:15:13 +0100
Date:	Wed, 20 May 2009 08:15:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"John W. Linville" <linville@tuxdriver.com>
Cc:	Michael Buesch <mb@bu3sch.de>,
	matthieu castet <castet.matthieu@free.fr>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
Message-ID: <20090520071513.GB24231@linux-mips.org>
References: <4A11DCBF.9000700@free.fr> <200905191524.20421.mb@bu3sch.de> <20090519170957.GA23711@linux-mips.org> <200905191929.21082.mb@bu3sch.de> <20090519173503.GD2691@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090519173503.GD2691@tuxdriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 19, 2009 at 01:35:03PM -0400, John W. Linville wrote:
> From: "John W. Linville" <linville@tuxdriver.com>
> Date: Tue, 19 May 2009 13:35:03 -0400
> To: Michael Buesch <mb@bu3sch.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>,
> 	matthieu castet <castet.matthieu@free.fr>,
> 	linux-mips@linux-mips.org, netdev@vger.kernel.org
> Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
> Content-Type: text/plain; charset=us-ascii
> 
> On Tue, May 19, 2009 at 07:29:20PM +0200, Michael Buesch wrote:
> > On Tuesday 19 May 2009 19:09:57 Ralf Baechle wrote:
> > > Maybe because I felt drivers/ssb/ was outside my jurisdiction - and unlike
> > > what alot of people may seem to think I'm not a full time MIPS kernel
> > > hacker.
> > 
> > Ok nice.
> > 
> > > I can deal with SSB patch if you so desire - but I have no experience with
> > > SSB, so I'd have somebody to rubberstamp non-trivial SSB patches before I
> > > queue them up.
> > 
> >  **Fwoo..
> > [stamp here]
> >       ..mppp**
> > 
> > 
> > Done. :)
> > 
> > > I can keep them either in the usual MIPS trees on 
> > > linux-mips.org or I could create a separate linux-ssb tree, depending on
> > > what seems to be sensible.  Also, reading the entry in the maintainers
> > > file I wonder if netdev is really the list of a choice?
> > 
> > Yes it is, because the bus is only used on networking devices.
> > (Ethernet cards, wireless cards, and network routers)
> > I don't think you need to create a separate tree. ssb is pretty mature. There
> > won't be that many patches.
> 
> OK, now I'm confused again -- should I take SSB patches, or is Ralf
> going to do it? :-)

My decoder ring says, I'll do it from now on :)

Cheers,

  Ralf
