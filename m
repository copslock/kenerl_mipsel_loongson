Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DF8Uh08117
	for linux-mips-outgoing; Wed, 13 Jun 2001 08:08:30 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DF8TP08114
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 08:08:30 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 54FE3125BA; Wed, 13 Jun 2001 08:08:29 -0700 (PDT)
Date: Wed, 13 Jun 2001 08:08:29 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
Message-ID: <20010613080829.A9739@lucon.org>
References: <20010611210311.A8768@lucon.org> <Pine.GSO.3.96.1010613094949.9854A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010613094949.9854A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 13, 2001 at 09:57:52AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 09:57:52AM +0200, Maciej W. Rozycki wrote:
> On Mon, 11 Jun 2001, H . J . Lu wrote:
> 
> > don't know abour the IRIX ABI DSOs. Also my glibc is compiled with
> > -mmips2 since kernel cannot handle mips I glibc.
> 
>  What's the problem with the kernel?  It works fine for my R3400A
> DECstation.  Glibc is 2.2.3 as released.  If there is something wrong, I
> definitely want to know. 
> 

It has something to do with the atomic emulation in kernel for mips I.


H.J.
