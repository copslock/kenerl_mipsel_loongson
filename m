Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PLdqK29878
	for linux-mips-outgoing; Mon, 25 Feb 2002 13:39:52 -0800
Received: from dea.linux-mips.net (a1as07-p84.stg.tli.de [195.252.188.84])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PLdl929874
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 13:39:48 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1PKdcQ06718;
	Mon, 25 Feb 2002 21:39:38 +0100
Date: Mon, 25 Feb 2002 21:39:38 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Johannes Stezenbach <js@convergence.de>, Hartvig Ekner <hartvige@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Message-ID: <20020225213938.D4935@dea.linux-mips.net>
References: <200202251516.QAA22570@copsun18.mips.com> <20020225173433.B3680@dea.linux-mips.net> <20020225183141.GA3560@convergence.de> <20020225193928.A4385@dea.linux-mips.net> <20020225193250.GA3789@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020225193250.GA3789@convergence.de>; from js@convergence.de on Mon, Feb 25, 2002 at 08:32:50PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 08:32:50PM +0100, Johannes Stezenbach wrote:

> > It's an ECOFF specific optimization that just has been forward ported into
> > the ELF world.  And what does this have to do with SGI anyway?
> 
> I was wondering who you speak for when you say "we don't
> support foobar", and your email is @oss.sgi.com.

You seem to be unaware that half of oss users are ex-sgi employees :-)

> I was just trying to decode the meaning of what you said.
> Like, did you mean "I don't care about it" or "The tools are
> totally broken and you have to go along way to use it"?
> 
> The global data optimization would fit dietlibc's goal
> of as-small-as-possible, statically linked binaries. But
> from what you said I gather I would have to fix gcc and
> binutils first.

See also my other email about the status of -G.

  Ralf
