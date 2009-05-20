Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 14:50:03 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:57774 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022522AbZETNt5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 14:49:57 +0100
Received: by vs166246.vserver.de with esmtpa (Exim 4.69)
	id 1M6mB8-0008G4-Q7; Wed, 20 May 2009 13:49:54 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
Date:	Wed, 20 May 2009 15:49:15 +0200
User-Agent: KMail/1.9.9
Cc:	"John W. Linville" <linville@tuxdriver.com>,
	matthieu castet <castet.matthieu@free.fr>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
References: <4A11DCBF.9000700@free.fr> <20090519173503.GD2691@tuxdriver.com> <20090520071513.GB24231@linux-mips.org>
In-Reply-To: <20090520071513.GB24231@linux-mips.org>
X-Move-Along: Nothing to see here. No, really... Nothing.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905201549.16154.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Wednesday 20 May 2009 09:15:13 Ralf Baechle wrote:
> On Tue, May 19, 2009 at 01:35:03PM -0400, John W. Linville wrote:
> > From: "John W. Linville" <linville@tuxdriver.com>
> > Date: Tue, 19 May 2009 13:35:03 -0400
> > To: Michael Buesch <mb@bu3sch.de>
> > Cc: Ralf Baechle <ralf@linux-mips.org>,
> > 	matthieu castet <castet.matthieu@free.fr>,
> > 	linux-mips@linux-mips.org, netdev@vger.kernel.org
> > Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
> > Content-Type: text/plain; charset=us-ascii
> > 
> > On Tue, May 19, 2009 at 07:29:20PM +0200, Michael Buesch wrote:
> > > On Tuesday 19 May 2009 19:09:57 Ralf Baechle wrote:
> > > > Maybe because I felt drivers/ssb/ was outside my jurisdiction - and unlike
> > > > what alot of people may seem to think I'm not a full time MIPS kernel
> > > > hacker.
> > > 
> > > Ok nice.
> > > 
> > > > I can deal with SSB patch if you so desire - but I have no experience with
> > > > SSB, so I'd have somebody to rubberstamp non-trivial SSB patches before I
> > > > queue them up.
> > > 
> > >  **Fwoo..
> > > [stamp here]
> > >       ..mppp**
> > > 
> > > 
> > > Done. :)
> > > 
> > > > I can keep them either in the usual MIPS trees on 
> > > > linux-mips.org or I could create a separate linux-ssb tree, depending on
> > > > what seems to be sensible.  Also, reading the entry in the maintainers
> > > > file I wonder if netdev is really the list of a choice?
> > > 
> > > Yes it is, because the bus is only used on networking devices.
> > > (Ethernet cards, wireless cards, and network routers)
> > > I don't think you need to create a separate tree. ssb is pretty mature. There
> > > won't be that many patches.
> > 
> > OK, now I'm confused again -- should I take SSB patches, or is Ralf
> > going to do it? :-)
> 
> My decoder ring says, I'll do it from now on :)


Ok, nice. :)
Matthieu, can you resend them to Ralf? He doesn't have them, yet.

-- 
Greetings, Michael.
