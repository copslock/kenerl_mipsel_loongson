Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OHbpx19369
	for linux-mips-outgoing; Thu, 24 Jan 2002 09:37:51 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OHbkP19363
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 09:37:47 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id IAA62727;
	Thu, 24 Jan 2002 08:37:23 -0800 (PST)
Date: Thu, 24 Jan 2002 08:37:23 -0800
From: Geoffrey Espin <espin@idiom.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Does anyone know how HHL boots?
Message-ID: <20020124083723.A47711@idiom.com>
References: <20020124015042.B29933@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020124015042.B29933@momenco.com>; from Matthew Dharm on Thu, Jan 24, 2002 at 01:50:42AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Matt,

> MontaVista has HHL support for several MIPS boards... including one that my
>... 
> I mean, our boards have an elementary boot loader that can load a kernel
> from the network, and disk-booting is something we're trying to figure out.
> But how does HHL accomplish this?  And is it a general solution for
> multiple platforms?

I went thru the same pain and confusion myself 9 months ago.  My
understanding is MontaVista uses whatever the manufacturer supplies
with the hardware.  And/or they have an internal version of PMON.
There are probably a dozen differernt MIPS loaders... some of
which you might be able to find source for, but probably won't
be even close to working on your board without weeks+ of effort.

If you have some assembly startup code that turns off interrupts,
sets up the memory controller then you maybe able to use my "LinuxMon"
solution which only works on the Korva(Markham) NEC Vr41xx chip
but is very generic.  Sheese, every monitor says it's generic.
After turning off interrupts and setting up the memory controller
it copies (optionally gunzips) the remainder of flash then jumps
to your linux kernel.  A 1-stage boot.  It can then be used
to load a second linux kernel if it has been linked elsewhere.

I wasn't successful in getting it submitted/accepted unfortunately.

You can get a copy of my 2.4.16 release containing it, at:

    http://www.idiom.com/~espin/nec

The important files are arch/mips/korva/{Boot.make,vrboot.S,misc.c}
If you have an already working linux kernel then these few files
should turn it into a boot monitor.  These were posted to
linux-mips-kernel@lists.sourceforge.net so you can find them in
the mail archive in Nov/Dec.  Or I can post.

Geoff
-- 
Geoffrey Espin
espin@idiom.com
