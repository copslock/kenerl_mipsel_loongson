Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7FTF810789
	for linux-mips-outgoing; Fri, 7 Dec 2001 07:29:15 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB7FT6o10785
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 07:29:07 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB72lSd01402;
	Fri, 7 Dec 2001 00:47:28 -0200
Date: Fri, 7 Dec 2001 00:47:28 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: brad@ltc.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: spurious_count cleanup
Message-ID: <20011207004727.F1202@dea.linux-mips.net>
References: <20011201004526.A22248@dev1.ltc.com> <20011204.161928.28780490.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204.161928.28780490.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Tue, Dec 04, 2001 at 04:19:28PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 04, 2001 at 04:19:28PM +0900, Atsushi Nemoto wrote:

> > --- arch/mips/kernel/entry.S	2001/11/27 01:26:46	1.32
> > +++ arch/mips/kernel/entry.S	2001/11/30 18:42:07
> > @@ -95,12 +95,12 @@
> >  		 * Someone tried to fool us by sending an interrupt but we
> >  		 * couldn't find a cause for it.
> >  		 */
> > -		lui     t1,%hi(spurious_count)
> > +		lui     t1,%hi(irq_err_count)
> >  		.set	reorder
> > -		lw      t0,%lo(spurious_count)(t1)
> > +		lw      t0,%lo(irq_err_count)(t1)
> >  		.set	noreorder
> >  		addiu   t0,1
> > -		sw      t0,%lo(spurious_count)(t1)
> > +		sw      t0,%lo(irq_err_count)(t1)
> >  		j	ret_from_irq
> >  		END(spurious_interrupt)

The spurious_count vs. irq_err_count is already fixed in the meantime.
For the rest of the function using noreorder was entirely pointless, so
just removed those directives.

  Ralf
