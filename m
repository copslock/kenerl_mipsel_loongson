Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2LE1UC26497
	for linux-mips-outgoing; Wed, 21 Mar 2001 06:01:30 -0800
Received: from exchange1.cam.pace.co.uk (host-131-80.pace.co.uk [136.170.131.80])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2LE1SM26494
	for <linux-mips@oss.sgi.com>; Wed, 21 Mar 2001 06:01:29 -0800
Received: by exchange1 with Internet Mail Service (5.5.2448.0)
	id <GNGHZTNM>; Wed, 21 Mar 2001 14:00:24 -0000
Message-ID: <1402C4C025C4D311B50D00508B8B74E281B14D@exchange1>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: Recommended toolchain
Date: Wed, 21 Mar 2001 14:00:22 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

So, going back to the original question, what are the recommended versions -
particularly if you are building 2.4.x kernels?

Are the recomendations in the HOWTO out of date? I had to patch va-mips.h
from the egcs RPM and more fixes seem to be needed before I get a kernel
that compiles.

Thanks,
Phil

-----Original Message-----
From: Ralf Baechle [mailto:ralf@oss.sgi.com]
Sent: 20 March 2001 20:37
To: Karel van Houten
Cc: simong@oz.agile.tv; linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain


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
