Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 13:36:18 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44219 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493061AbZKWMgL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 13:36:11 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANCaKai028189;
	Mon, 23 Nov 2009 12:36:20 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANCaFHG028186;
	Mon, 23 Nov 2009 12:36:15 GMT
Date:	Mon, 23 Nov 2009 12:36:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Takashi Iwai <tiwai@suse.de>
Cc:	wuzhangjin@gmail.com,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fixups of ALSA memory maps
Message-ID: <20091123123615.GB32675@linux-mips.org>
References: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com> <s5hd43iiebt.wl%tiwai@suse.de> <20091116174324.GA17748@linux-mips.org> <s5hhbst4hzt.wl%tiwai@suse.de> <20091118142056.GB6615@linux-mips.org> <s5hskcbbu80.wl%tiwai@suse.de> <1258806701.5752.8.camel@falcon.domain.org> <s5h3a45aabc.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h3a45aabc.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 09:56:39AM +0100, Takashi Iwai wrote:

> > On Wed, 2009-11-18 at 18:47 +0100, Takashi Iwai wrote:
> > [...]
> > > 
> > > Well, we haven't reached the consensus.  The discussion faded away
> > > somehow mainly because I had too little time to update and ping people
> > > again.
> > > 
> > > In Tokyo, I talked with some guys regarding this.  Ben agreed to take
> > > this approach for ppc, and David said that he doesn't mind for sparc
> > > part.   Fujita-san mentioned it's no big problem to add one op from
> > > the generic dma_ops.
> > > 
> > > So, maybe somehow need to convince James in the end (and ask Paul to
> > > check SH part, too), then it'll be all up... theoretically :)
> > > 
> > > Anyway, I'm going to raise the discussion again on linux-arch.
> > > I'm afraid it's a bit too late game for 2.6.33, but starting now is
> > > better than too late again.
> > 
> > Hi, Takashi Iwai
> > 
> > Before the API stuff going into the mainline(2.6.33), can we apply this
> > "[PATCH] MIPS: Fixups of ALSA memory maps"(This is the minimal
> > necessares) as a current fixup. and then we will not get a broken sound
> > support for MIPS, and also the support to the latest Loongson2F family
> > machines will benefit from it.
> > 
> > and Ralf, what about your suggestion?
> 
> The question is whether this hack can be safely added for all MIPS
> platforms just by checking kconfig.  I had an impression that rather
> many things have to be checked in the runtime.
> 
> As I have really little clue about MIPS architecture, I'd like let
> MIPS guys decide about it...

Okay, I'll cook up a nice kludge.  It can't cover all cases but it will
be an improvment for most platforms.

  Ralf
