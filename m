Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PKX2F28416
	for linux-mips-outgoing; Mon, 25 Feb 2002 12:33:02 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PKWu928413;
	Mon, 25 Feb 2002 12:32:56 -0800
Received: from js by hell with local (Exim 3.33 #1 (Debian))
	id 16fQri-0000zp-00; Mon, 25 Feb 2002 20:32:50 +0100
Date: Mon, 25 Feb 2002 20:32:50 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Hartvig Ekner <hartvige@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Message-ID: <20020225193250.GA3789@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Ralf Baechle <ralf@oss.sgi.com>, Hartvig Ekner <hartvige@mips.com>,
	linux-mips@oss.sgi.com
References: <200202251516.QAA22570@copsun18.mips.com> <20020225173433.B3680@dea.linux-mips.net> <20020225183141.GA3560@convergence.de> <20020225193928.A4385@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225193928.A4385@dea.linux-mips.net>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 07:39:28PM +0100, Ralf Baechle wrote:
> On Mon, Feb 25, 2002 at 07:31:41PM +0100, Johannes Stezenbach wrote:
> > BTW: Who is "we"? Do you mean global data optimization is broken
> > in gcc/binutils or just that no one at SGI is using it?
> 
> It's an ECOFF specific optimization that just has been forward ported into
> the ELF world.  And what does this have to do with SGI anyway?

I was wondering who you speak for when you say "we don't
support foobar", and your email is @oss.sgi.com.

I was just trying to decode the meaning of what you said.
Like, did you mean "I don't care about it" or "The tools are
totally broken and you have to go along way to use it"?

The global data optimization would fit dietlibc's goal
of as-small-as-possible, statically linked binaries. But
from what you said I gather I would have to fix gcc and
binutils first.


Johannes
