Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q2IHk03995
	for linux-mips-outgoing; Mon, 25 Feb 2002 18:18:17 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q2IB903991
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 18:18:11 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1Q1I9R22356;
	Mon, 25 Feb 2002 17:18:09 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: "Kevin Paul Herbert" <kph@ayrnetworks.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: Is this a toolchain bug?
Date: Mon, 25 Feb 2002 17:18:09 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIEEMDCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020225201327.A2427@nevyn.them.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Got the -G 0....

Honestly, I'm pretty sure it was compiled with the right flags.  They
match the flags I'm using to build the kernel, at least as far as I
can see.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Daniel Jacobowitz [mailto:dan@debian.org]
> Sent: Monday, February 25, 2002 5:13 PM
> To: Matthew Dharm
> Cc: Kevin Paul Herbert; Linux-MIPS
> Subject: Re: Is this a toolchain bug?
>
>
> On Mon, Feb 25, 2002 at 12:30:38PM -0800, Matthew Dharm wrote:
> > Well, that fixes it.  The driver works out-of-the-box
> with just some
> > minor makefile modifications.
> >
> > So, we've got a problem somewhere in the module handling.
>  Either the
> > symbol wasn't being relocated properly, or it wasn't
> being allocated
> > properly, or something.  I'm not an expert in this region of the
> > kernel, but my guess is that we're going to see this more and more
> > often, so someone with a clue should take a look at this.
> >
> > I'm more than willing to help, as I seem to be the only
> person with a
> > 100% reproducable situation.  But I really have no idea
> even where to
> > begin looking... my expertise ends right about at
> objdump, and even
> > then I'm not certain how some of that data should look
> for loadable
> > modules.
>
> Silly question... was the module built with the correct
> flags?  Look at
> a command line; does it have all the same options as when
> you build a
> module in the kernel source?
>
> I bet something's missing.  Probably -G 0...
>
> --
> Daniel Jacobowitz                           Carnegie Mellon
> University
> MontaVista Software                         Debian
> GNU/Linux Developer
>
