Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4ULOxnC003255
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 14:24:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4ULOxW8003254
	for linux-mips-outgoing; Thu, 30 May 2002 14:24:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from coplin09.mips.com ([80.63.7.130])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4ULOrnC003251
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 14:24:53 -0700
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id g4ULPgq05186;
	Thu, 30 May 2002 23:25:42 +0200
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200205302125.g4ULPgq05186@coplin09.mips.com>
Subject: Re: cross-compiler for MIPS_RedHat7.1_Release-01.00 on Atlas/4Kc
To: muthu5@sbcglobal.net (Muthukumar Ratty)
Date: Thu, 30 May 2002 23:25:42 +0200 (CEST)
Cc: dpchrist@holgerdanske.com (David Christensen), linux-mips@oss.sgi.com,
   hartvige@mips.com (Hartvig Ekner)
In-Reply-To: <Pine.LNX.4.33.0205301346530.4760-100000@Muruga.localdomain> from "Muthukumar Ratty" at May 30, 2002 02:05:17 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

Muthukumar Ratty writes:
> 
> On Thu, 30 May 2002, David Christensen wrote:
> 
> > linux-mips@oss.sgi.com & Hartvig:
> >
> > Hartvig Ekner wrote:
> > > from H.J.) as well on an Atlas, you'll just have to use the 2.4.3
> > > install kernel from the 01.00 CD image you downloaded, and everything
> > > else from the new release.
> 
> Is there any latest kernel (2.5.xx) available for MIPS/Atlas?

No. Not from us anyway. Internally, we use the Linux systems heavily for
processor testing, so we tend to stay away from the bleeding edge (==
too  many problems and SW bugs). That is also why we haven't switched
to 2.4.18 until now.

That being said, there are probably many others who compile & use 2.5
kernels for MIPS.

> I played around with some cross-compilers and what I understood is
> 
> 1. Algorithmics sde4 is not matured enough to compile 2.4.xx kernels (As
> Dominic Sweetman mentioned in his reply to my help mail). He said sde5
> will do but I dint get a chance to try this. Any update from anyone used it?

We're using a beta of it - and there are known issues being worked on,
both compiling userland natively and kernel cross compiles.
You'll have to ask Dom when he expects final 5.0 to go out the door.

/Hartvig
