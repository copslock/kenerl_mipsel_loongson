Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2KKkDQ02522
	for linux-mips-outgoing; Tue, 20 Mar 2001 12:46:13 -0800
Received: from dea.waldorf-gmbh.de (u-194-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.194])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2KKiYM02507
	for <linux-mips@oss.sgi.com>; Tue, 20 Mar 2001 12:44:55 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2KKbFa04011;
	Tue, 20 Mar 2001 21:37:15 +0100
Date: Tue, 20 Mar 2001 21:37:15 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Cc: simong@oz.agile.tv (Simon Gee), linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain
Message-ID: <20010320213715.C3763@bacchus.dhis.org>
References: <3AB6C948.7F8EE4B7@oz.agile.tv> <200103202012.VAA07412@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103202012.VAA07412@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Tue, Mar 20, 2001 at 09:12:02PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Mar 20, 2001 at 09:12:02PM +0100, Karel van Houten wrote:

> You wrote:
> > Recently I've been working with various version mixes of the gnu tool
> > chain for a mipsel-linux target and settled on a patchy binutils
> > 2.8.1/egcs 1.1.2/glibc 2.0.6 setup. However this lacks the functionality
> > that I would get from a newer toolchain for use with the linux 2.4
> > kernel. As a result, I was wondering if someone could recommend the
> > latest "stable"/recommended toolchain for a mipsel-linux target.
> 
> Well, I'm currently using:
> binutils 2.10.1
> gcc 2.95.3 (with Maciej's patches)
> glibc 2.2.2 (compiled with above toolchain).
> 
> This toolchain works for native compiles on my mipsel box.
> One drawback: I can't compile any kernels with this setup,
> For kernel compiles I use 2.8.1/egcs-2.90.27/glibc-2.0.6.

You MUST use minimum egcs-2.91.66 (1.1.2); older compilers WILL misscompile
kernels.

  Ralf
