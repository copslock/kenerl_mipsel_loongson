Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FM8fnC002729
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 15:08:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FM8fEr002728
	for linux-mips-outgoing; Wed, 15 May 2002 15:08:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from host099.momenco.com (IDENT:root@jeeves.momenco.com [64.169.228.99])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FM8RnC002725
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 15:08:32 -0700
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g4FM85326028;
	Wed, 15 May 2002 15:08:25 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: <kwalker@broadcom.com>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: MIPS 64?
Date: Wed, 15 May 2002 15:08:05 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIAEABCHAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <3CE2D95B.E1E43662@broadcom.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I don't suppose anyone has a primer or white paper on the High Memory
stuff?  i.e. Applications, requirements, or a quick HOWTO?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: kwalker@broadcom.com [mailto:kwalker@broadcom.com]
> Sent: Wednesday, May 15, 2002 2:56 PM
> To: Matthew Dharm
> Cc: Linux-MIPS
> Subject: Re: MIPS 64?
>
>
>
> Since traditionally the mips kernel could only manage RAM
> reachable by
> Kseg you were limited to 512MB, right?  But now the High
> Memory stuff is
> stable enough that you can reach any RAM that's physically
> addressable
> in 32-bits.  And after that, there's the 64bit-physical-address
> extension which allows you to reach physical pages that
> need > 32-bits
> to address.
>
> Kip
>
> Daniel Jacobowitz wrote:
> >
> > On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
> > > So... I'm looking at porting Linux to a system with
> 1.5GiB of RAM.
> > > That kinda blows the 32-bit MIPS port option right out
> of the water...
> >
> > Not unless you count bits differently than I do... 32-bit
> is 4 GiB.  Is
> > there any reason MIPS has special problems in this area?
> >
> > >
> > > What does it take to do a 64-bit port?  The first
> problem I see is the
> > > boot loader -- do I have to be in 64-bit mode when the
> kernel starts,
> > > or can I start in 32-bit mode and then transfer to 64-bit mode?
> > >
> > > I looked in the arch/mips64/ directory, but I don't see much for
> > > specific boards there, but there are references to the Malta
> > > boards....
> > >
> > > Matt
> > >
> > > --
> > > Matthew D. Dharm                            Senior
> Software Designer
> > > Momentum Computer Inc.                      1815 Aston
> Ave.  Suite 107
> > > (760) 431-8663 X-115                        Carlsbad,
> CA 92008-7310
> > > Momentum Works For You                      www.momenco.com
> > >
> > >
> >
> > --
> > Daniel Jacobowitz                           Carnegie
> Mellon University
> > MontaVista Software                         Debian
> GNU/Linux Developer
>
