Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DFOIP09776
	for linux-mips-outgoing; Wed, 13 Jun 2001 08:24:18 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DFOHP09767
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 08:24:17 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 47275125BA; Wed, 13 Jun 2001 08:24:17 -0700 (PDT)
Date: Wed, 13 Jun 2001 08:24:17 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
Message-ID: <20010613082417.C9739@lucon.org>
References: <20010613080829.A9739@lucon.org> <Pine.GSO.3.96.1010613171535.9854L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010613171535.9854L-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 13, 2001 at 05:22:49PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 05:22:49PM +0200, Maciej W. Rozycki wrote:
> On Wed, 13 Jun 2001, H . J . Lu wrote:
> 
> > >  What's the problem with the kernel?  It works fine for my R3400A
> > > DECstation.  Glibc is 2.2.3 as released.  If there is something wrong, I
> > > definitely want to know. 
> > 
> > It has something to do with the atomic emulation in kernel for mips I.
> 
>  Hmm, I thought Florian's sysmips() fixes went in.  Here is a patch I use
> successfully for some time.  It doesn't work for small negative integers,
> but glibc doesn't use them, AFAIK.
> 
>  Another possibility is to use the set of two patches for
> sys__test_and_set() I've sent here recently.  This would break portability
> for now, though, if you wanted to distribute glibc or kernel binaries.
> This is also the reason I didn't put my current patched version of glibc
> on my FTP site.
> 
>  The patch is not against a current version of the kernel -- you might
> need to apply it manually.
> 
>   Maciej
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> patch-mips-2.4.0-test11-20001211-sysmips-0

I don't have problem with 2.4.0-test11. It is the change in 2.4.3
which breaks glibc.


H.J.
