Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0T1A9F32492
	for linux-mips-outgoing; Mon, 28 Jan 2002 17:10:09 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0T1A1P32467
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 17:10:01 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0T09oX23620;
	Mon, 28 Jan 2002 16:09:50 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Pete Popov" <ppopov@pacbell.net>
Cc: "linux-mips" <linux-mips@oss.sgi.com>
Subject: RE: Help with OOPSes, anyone?
Date: Mon, 28 Jan 2002 16:09:50 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAICEBKCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1012262087.8518.174.camel@zeus>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Frankly, I'm not entirely certain which version the Montavista kernel
is.  We were supposed to be doing the software validation for
PMC-Sierra (who contracted to Montavista for the work), so this is one
of the later kernels from that process.  But I really don't know
exactly which one...

As for the 'wait' thing... forgot to try that one.  How does one go
about disabling the wait instruction, anyway?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Pete Popov [mailto:ppopov@pacbell.net]
> Sent: Monday, January 28, 2002 3:55 PM
> To: Matthew Dharm
> Cc: linux-mips
> Subject: RE: Help with OOPSes, anyone?
>
>
> On Mon, 2002-01-28 at 15:31, Matthew Dharm wrote:
> > Well, here's the latest test results...
> >
> > The 2.4.0 kernel from MontaVista seems to work just fine.
>  Of course,
> > it doesn't have support for the full range of interrupts,
> but that's a
> > separate matter.  But it doesn't crash under big compiles.
>
> 2.4.0 from MontaVista? Do you mean the very first release, which was
> 2.4.0-test9?
>
> > 2.4.17 with CONFIG_MIPS_UNCACHED crashes.  It takes
> longer, but that
> > may just be a function of it running so much slower.  The BogoMIPS
> > drops by a factor of 100.  Ouch.
> >
> > So it doesn't look like a cache problem after all.  And it does
> > suggest that something introduced between 2.4.0 and .17
> is what broke
> > things.  But what that is, I have no idea.
> >
> > I'm going to try Jason's modified cache code just in
> case, but I doubt
> > that will change anything.  We'll have to see, tho.
> >
> > Does anyone have any other suggestions to try?  I'm
> starting to wonder
> > if perhaps the PROM isn't setting up the SDRAM properly, but that
> > conflicts with the working 2.4.0 kernel -- the PROM is the same in
> > both cases, so I would expect a PROM error to affect both
> versions.
> >
> > I'm running out of ideas here... anyone?
>
> If you're absolutely sure 2.4.0-test9 doesn't crash (you
> ran the test
> "enough" times), perhaps you can start testing kernels
> between 2.4.0 and
> 2.4.17.   And, you did get rid of the 'wait' instruction in 2.4.17,
> right ;-)?
>
> Pete
>
