Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2009 20:29:50 +0000 (GMT)
Received: from kroah.org ([198.145.64.141]:39557 "EHLO coco.kroah.org")
	by ftp.linux-mips.org with ESMTP id S20808008AbZB1U3r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Feb 2009 20:29:47 +0000
Received: from localhost (c-76-105-230-205.hsd1.or.comcast.net [76.105.230.205])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id 5B28E4901E;
	Sat, 28 Feb 2009 12:29:45 -0800 (PST)
Date:	Sat, 28 Feb 2009 12:27:17 -0800
From:	Greg KH <greg@kroah.com>
To:	Arjan van de Ven <arjan@infradead.org>
Cc:	linux-mips@linux-mips.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stable@kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: [stable] [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-ID: <20090228202717.GA29139@kroah.com>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com> <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain> <20090228072554.CFEA6FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain> <20090228174601.GB27607@kroah.com> <20090228095433.6af07a89@infradead.org> <20090228182313.GA28421@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090228182313.GA28421@kroah.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Sat, Feb 28, 2009 at 10:23:13AM -0800, Greg KH wrote:
> On Sat, Feb 28, 2009 at 09:54:33AM -0800, Arjan van de Ven wrote:
> > On Sat, 28 Feb 2009 09:46:01 -0800
> > Greg KH <greg@kroah.com> wrote:
> > 
> > > On Sat, Feb 28, 2009 at 09:23:36AM -0800, Linus Torvalds wrote:
> > > > On Fri, 27 Feb 2009, Roland McGrath wrote:
> > > > > But here is the patch you asked for.
> > > > 
> > > > Yes, this looks much more straightforward. 
> > > > 
> > > > And I guess the seccomp interaction means that this is potentially
> > > > a 2.6.29 thing. Not that I know whether anybody actually _uses_
> > > > seccomp. It does seem to be enabled in at least Fedora kernels, but
> > > > it might not be used anywhere.
> > > 
> > > It's enabled in SuSE kernels.
> > > 
> > 
> > but are there users of it?
> > I thought Andrea stopped the cpushare thing that was the only user of
> > this....
> 
> I do not really know, but as it is enabled, we need to at least fix it.

Sorry, I ment "we" as in SuSE, not as the "community".  As the patch can
easily be backported to the SuSE kernels and resolved there, I don't
think it's something that probably needs to be backported for the
-stable tree either.

thanks,

greg k-h
