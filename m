Received:  by oss.sgi.com id <S553757AbQLOPXn>;
	Fri, 15 Dec 2000 07:23:43 -0800
Received: from wn42-146.sdc.org ([209.155.42.146]:5364 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S553736AbQLOPXU>;
	Fri, 15 Dec 2000 07:23:20 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S870690AbQLOPUX>;
	Fri, 15 Dec 2000 08:20:23 -0700
Date:	Fri, 15 Dec 2000 16:20:23 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Carsten Langgaard <carstenl@mips.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: 64 bit build fails
Message-ID: <20001215162023.B28594@bacchus.dhis.org>
References: <3A379CBC.ED1D9F@mips.com> <20001214215933.C28871@bacchus.dhis.org> <3A39CC1F.8FE7B2FE@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A39CC1F.8FE7B2FE@mips.com>; from carstenl@mips.com on Fri, Dec 15, 2000 at 08:45:35AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Dec 15, 2000 at 08:45:35AM +0100, Carsten Langgaard wrote:

> > > mips64-linux-gcc -D__KERNEL__
> > > -I/home/soc/proj/work/carstenl/sw/linux-2.4.0/include -Wall
> > > -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> > > -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r8000 -mips4
> > > -Wa,-32   -c head.S -o head.o
> > > head.S: Assembler messages:
> > > head.S:69: Error: Missing ')' assumed
> >
> > Looks like an attempt to build a 64-bit Indy kernel.  Various people working
> > on the Origin support have completly broken the support for anything else in
> > their battle tank-style approach ...
> 
> Ok, that explains why a lot of things are broken.
> So who will be responsible for fixing all the broken pieces ?

This is the question you'd ask a company.  This is Free Software, not some
company's product ...

  Ralf
