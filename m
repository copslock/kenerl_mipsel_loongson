Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KAvZH08631
	for linux-mips-outgoing; Wed, 20 Feb 2002 02:57:35 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KAvU908626
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 02:57:31 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA13863;
	Wed, 20 Feb 2002 10:56:50 +0100 (MET)
Date: Wed, 20 Feb 2002 10:56:50 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Lindahl <lindahl@conservativecomputer.com>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: FPU emulator unsafe for SMP?
In-Reply-To: <20020219222835.A4195@wumpus.skymv.com>
Message-ID: <Pine.GSO.4.21.0202201055260.29685-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 19 Feb 2002, Greg Lindahl wrote:
> On Tue, Feb 19, 2002 at 05:12:38PM -0800, Jun Sun wrote:
> > As I looked into FPU/SMP issue, I realized this problem.  I agree 
> > that locking fpu owner to the current cpu is the best solution.
> > I bet this won't really hurt performance because any alternative would
> > incur transferring FPU registers across cpus, which is not a small 
> > overhead.

  [...]

> What you propose, locking the fpu owner to the current cpu, will not
> result in a fair solution. Imagine a 2 cpu machine with 2 processes
> using integer math and 1 using floating point... how much cpu time
> will each process get? Imagine all the funky effects. Now add in a
> MIPS design in which interrupts are not delivered uniformly to all the
> cpus... I don't know if there are any or will ever be any, but...

What if you have 2 processes who are running at the same CPU when they start
using the FPU? Won't they be locked to that CPU, while all other's stay idle
(if no other processes are to be run)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
