Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FMHGnC002915
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 15:17:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FMHGBh002914
	for linux-mips-outgoing; Wed, 15 May 2002 15:17:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from host099.momenco.com (IDENT:root@jeeves.momenco.com [64.169.228.99])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FMH2nC002911
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 15:17:07 -0700
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g4FMGT326080;
	Wed, 15 May 2002 15:16:39 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Jun Sun" <jsun@mvista.com>, "Daniel Jacobowitz" <dan@debian.org>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: MIPS 64?
Date: Wed, 15 May 2002 15:16:29 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIKEABCHAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <3CE2DA46.3070402@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I personally think it's long overdue that we really invest some
time/effort in the 64-bit version.  I mean, anything past 0.5 GiB is
really a hack on 32-bit....

I, for one, am willing to lend a pair of hands to this... but I need
to know what needs doing, first.

Could someone give me an overview of how you're supposed to do a
handoff between a 32-bit loader and a 64-bit app?  I'm guessing there
has to be a way to do it, but what I do know about the 64-bit stuff
doesn't show me how this is accomplished (I have visions of UX bits
floating in my head...)

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Jun Sun
> Sent: Wednesday, May 15, 2002 3:00 PM
> To: Daniel Jacobowitz
> Cc: Matthew Dharm; Linux-MIPS
> Subject: Re: MIPS 64?
>
>
> Daniel Jacobowitz wrote:
>
> > On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
> >
> >>So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
> >>That kinda blows the 32-bit MIPS port option right out of
> the water...
> >>
> >
> > Not unless you count bits differently than I do... 32-bit
> is 4 GiB.  Is
> > there any reason MIPS has special problems in this area?
> >
>
>
> MIPS has lower 2GB fixed for user space.  Then you have
> kseg0, .5GB for cached
> physical address 0-0.5GB, and kseg1, 0.5GB uncached mapping
> of the same area.
>   You can map another 1GB of RAM into kseg2/3, but you will
> then have no space
> left for IO.
>
> So you really can't do 1.5GB on 32 bit kernel.
>
> It is interesting that PPC allows one to adjust user space
> size and kernel
> space size.  So on PPC you can get up to 2.5GB system RAM
> with 1GB user space.
>
> Back to 64bit port, it seems to me much of the 32bit work
> we have done in the
> past a year or so needs to be moved over.  Or better yet,
> if we can clean up
> integer/long issues, we might be able to use 32bit kernel
> code straight for
> 64bit kernel.
>
>
> Jun
>
>
