Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2LIlA704335
	for linux-mips-outgoing; Wed, 21 Mar 2001 10:47:10 -0800
Received: from exchange1.cam.pace.co.uk (host-131-80.pace.co.uk [136.170.131.80])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2LIl8M04332
	for <linux-mips@oss.sgi.com>; Wed, 21 Mar 2001 10:47:08 -0800
Received: by exchange1 with Internet Mail Service (5.5.2448.0)
	id <GNGHZ4MF>; Wed, 21 Mar 2001 18:46:08 -0000
Message-ID: <1402C4C025C4D311B50D00508B8B74E281B151@exchange1>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'Erik Mullinix'" <Hesp@rainworks.org>, linux-mips@oss.sgi.com
Subject: RE: Recommended toolchain
Date: Wed, 21 Mar 2001 18:46:07 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I had to patch va-mips.h to #include <asm/sgidefs.h> rather than
<sgidefs.h>.

The current errors are:

- warnings about struct flock64 not being declared (it's defined in
asm-mips64/fcntl.h but not asm-mips/fcntl.h)

- compilation stops because loops_per_sec is undeclared as far as
asm-mips/delay.h is concerned (although it seems fine in
asm-mips64/delay.h).

This seems to imply that the mips architecture (as opposed to mips64) isn't
being maintained. Is this the case? Should I be using mips64 - but what
would be the point on an embedded CPU?

Thanks,
Phil

-----Original Message-----
From: Erik Mullinix [mailto:Hesp@rainworks.org]
Sent: 21 March 2001 12:12
To: Phil Thompson; linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain


What Error's are you getting?
Hesp
----- Original Message -----
From: "Phil Thompson" <Phil.Thompson@pace.co.uk>
To: <linux-mips@oss.sgi.com>
Sent: Wednesday, March 21, 2001 9:00 AM
Subject: RE: Recommended toolchain


> So, going back to the original question, what are the recommended
versions -
> particularly if you are building 2.4.x kernels?
>
> Are the recomendations in the HOWTO out of date? I had to patch va-mips.h
> from the egcs RPM and more fixes seem to be needed before I get a kernel
> that compiles.
>
> Thanks,
> Phil
>
> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@oss.sgi.com]
> Sent: 20 March 2001 20:37
> To: Karel van Houten
> Cc: simong@oz.agile.tv; linux-mips@oss.sgi.com
> Subject: Re: Recommended toolchain
>
>
> On Tue, Mar 20, 2001 at 09:12:02PM +0100, Karel van Houten wrote:
>
> > You wrote:
> > > Recently I've been working with various version mixes of the gnu tool
> > > chain for a mipsel-linux target and settled on a patchy binutils
> > > 2.8.1/egcs 1.1.2/glibc 2.0.6 setup. However this lacks the
functionality
> > > that I would get from a newer toolchain for use with the linux 2.4
> > > kernel. As a result, I was wondering if someone could recommend the
> > > latest "stable"/recommended toolchain for a mipsel-linux target.
> >
> > Well, I'm currently using:
> > binutils 2.10.1
> > gcc 2.95.3 (with Maciej's patches)
> > glibc 2.2.2 (compiled with above toolchain).
> >
> > This toolchain works for native compiles on my mipsel box.
> > One drawback: I can't compile any kernels with this setup,
> > For kernel compiles I use 2.8.1/egcs-2.90.27/glibc-2.0.6.
>
> You MUST use minimum egcs-2.91.66 (1.1.2); older compilers WILL
misscompile
> kernels.
>
>   Ralf
>
