Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2LF9k929394
	for linux-mips-outgoing; Wed, 21 Mar 2001 07:09:46 -0800
Received: from mta5.snfc21.pbi.net ([206.13.28.241])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2LF9jM29391
	for <linux-mips@oss.sgi.com>; Wed, 21 Mar 2001 07:09:45 -0800
Received: from shaft ([209.233.126.43])
 by mta5.snfc21.pbi.net (Sun Internet Mail Server sims.3.5.2000.01.05.12.18.p9)
 with SMTP id <0GAJ005WTZBZ1J@mta5.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Wed, 21 Mar 2001 07:07:11 -0800 (PST)
Date: Wed, 21 Mar 2001 07:11:46 -0500
From: Erik Mullinix <Hesp@rainworks.org>
Subject: Re: Recommended toolchain
To: Phil Thompson <Phil.Thompson@pace.co.uk>, linux-mips@oss.sgi.com
Message-id: <001a01c0b200$1c13d5e0$0500a8c0@shaft>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
References: <1402C4C025C4D311B50D00508B8B74E281B14D@exchange1>
X-Priority: 3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

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
