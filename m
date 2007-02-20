Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 14:01:09 +0000 (GMT)
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2823 "EHLO spitz.ucw.cz")
	by ftp.linux-mips.org with ESMTP id S20038832AbXBTOBF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2007 14:01:05 +0000
Received: by spitz.ucw.cz (Postfix, from userid 0)
	id 788182799B; Tue, 20 Feb 2007 13:50:46 +0000 (UTC)
Date:	Tue, 20 Feb 2007 13:50:46 +0000
From:	Pavel Machek <pavel@ucw.cz>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned implementations.
Message-ID: <20070220135046.GE3945@ucw.cz>
References: <20060306.203218.69025300.nemoto@toshiba-tops.co.jp> <20060306170552.0aab29c5.akpm@osdl.org> <20070214214226.GA17899@linux-mips.org> <20070214203903.8d013170.akpm@linux-foundation.org> <20070215143441.GA18155@linux-mips.org> <20070215135358.020781dd.akpm@linux-foundation.org> <20070215221839.GA14103@linux-mips.org> <20070215153823.239fd616.akpm@linux-foundation.org> <20070216004317.GA18987@linux-mips.org> <20070215172720.3e9ce464.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070215172720.3e9ce464.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.9i
Return-Path: <root@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

Hi!

> > > hm.  So if I have
> > > 
> > > 	struct bar {
> > > 		unsigned long b;
> > > 	} __attribute__((packed));
> > > 
> > > 	struct foo {
> > > 		unsigned long u;
> > > 		struct bar b;
> > > 	};
> > > 
> > > then the compiler can see that foo.b.b is well-aligned, regardless of the
> > > packedness.
> > > 
> > > Plus some crazy people compile the kernel with icc (or at least they used
> > > to).  What happens there?
> > 
> > A quick grep for __attribute__((packed)) and __packed find around 900 hits,
> > I'd probably find more if I'd look for syntactical variations.  Some hits
> > are in arch/{i386,x86_64,ia64}.  At a glance it seems hard to configure a
> > useful x86 kernel that doesn't involve any packed attribute.  I take that
> > as statistical proof that icc either has doesn't really work for building
> > the kernel or groks packing.  Any compiler not implementing gcc extensions
> > is lost at building the kernel but that's old news.
> > 
> 
> No, icc surely supports attribute(packed).  My point is that we shouldn't
> rely upon the gcc info file for this, because other compilers can (or
> could) be used to build the kernel.

Well, icc should be gcc compatible. If it is not, it is icc bug.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
