Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0T0p7130422
	for linux-mips-outgoing; Mon, 28 Jan 2002 16:51:07 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0T0p0P30406
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 16:51:00 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0SNowX23517
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 15:50:58 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: <linux-mips@oss.sgi.com>
Subject: RE: Help with OOPSes, anyone?
Date: Mon, 28 Jan 2002 15:50:58 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIGEBJCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIAEBJCFAA.mdharm@momenco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Well, Jason's modified cache code doesn't help either.

I'm still open to suggestions....

Ralf, are you in the same location as your board?  I'm curious to hear
your opinion of this?

Matthew Dharm

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Matthew Dharm
> Sent: Monday, January 28, 2002 3:32 PM
> To: linux-mips@oss.sgi.com
> Subject: RE: Help with OOPSes, anyone?
>
>
> Well, here's the latest test results...
>
> The 2.4.0 kernel from MontaVista seems to work just fine.
> Of course,
> it doesn't have support for the full range of interrupts,
> but that's a
> separate matter.  But it doesn't crash under big compiles.
>
> 2.4.17 with CONFIG_MIPS_UNCACHED crashes.  It takes longer, but that
> may just be a function of it running so much slower.  The BogoMIPS
> drops by a factor of 100.  Ouch.
>
> So it doesn't look like a cache problem after all.  And it does
> suggest that something introduced between 2.4.0 and .17 is
> what broke
> things.  But what that is, I have no idea.
>
> I'm going to try Jason's modified cache code just in case,
> but I doubt
> that will change anything.  We'll have to see, tho.
>
> Does anyone have any other suggestions to try?  I'm
> starting to wonder
> if perhaps the PROM isn't setting up the SDRAM properly, but that
> conflicts with the working 2.4.0 kernel -- the PROM is the same in
> both cases, so I would expect a PROM error to affect both versions.
>
> I'm running out of ideas here... anyone?
>
> Matt
>
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.
>  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
>
