Received:  by oss.sgi.com id <S305157AbQAPMqP>;
	Sun, 16 Jan 2000 04:46:15 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59147 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQAPMpq>; Sun, 16 Jan 2000 04:45:46 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA02331; Sun, 16 Jan 2000 04:49:45 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA70547
	for linux-list;
	Sun, 16 Jan 2000 04:33:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA30540
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 16 Jan 2000 04:32:57 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from hood.tvd.be (hood.tvd.be [195.162.196.21]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00871
	for <linux@cthulhu.engr.sgi.com>; Sun, 16 Jan 2000 04:32:52 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from callisto.of.borg (cable-195-162-216-83.customer.chello.be [195.162.216.83])
	by hood.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id NAA18597;
	Sun, 16 Jan 2000 13:32:46 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian/GNU) with ESMTP id NAA20342;
	Sun, 16 Jan 2000 13:32:46 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Sun, 16 Jan 2000 13:32:46 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>,
        Linux/MIPS <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel sources?
In-Reply-To: <005e01bf5f7d$fc1cf490$0ceca8c0@satanas.mips.com>
Message-ID: <Pine.LNX.4.05.10001161329250.744-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, 15 Jan 2000, Kevin D. Kissell wrote:
> >On Thu, Jan 13, 2000 at 05:03:39PM +0100, Geert Uytterhoeven wrote:
> >
> >> I used the R5000 CP0_COUNTER/CP0_COMPARE registers for the timer interrupt. I
> >> know it's not accurate, but it's better than nothing. I still have to figure
> >> out how more complex interrupts work in the MIPS source tree.
> >
> >It is accurate as driven by the CPU's clock.  It is just somewhat tricky to
> >handle and even more tricky on some broken CPUs.  From an old email written
> >by Bill Earl:
> >
> >[...]
> >As far as I know, all R4000 processors, and possibly some R4400 processors,
> >are affected.  The bug is that, if you read $count exactly when it equals
> >$compare, the count/compare interrupt for that count/compare crossing is
> >discarded.  The workaround from IRIX is appended.  The variable
> >r4000_clock_war is set to 1 if the system is an Indy with an R4000 processor.
> >The r4k_compare_shadow is set to the same value as $compare whenever $compare
> >is updated (with interrupts masked while the variable and $compare are
> >updated together).
> >[...]
> 
> There is also a race condition inherent in many implementations of
> the timer interrupt handler, and the main stream of the current
> MIPS/Linux distributions is no exception.   The SGI code looks
> a bit like this:

    [...]

> The inherent race is in the fact that the count is sampled
> once at the beginnning of the routine and used throughout.
> It is possible (with bad luck and sloppy drivers) to be very
> late into the handler, so much so that the new time-out time
> can be reached between the sample and the programming
> of the compare register.  If that happens, one gets no timer
> interrupt for a full wrap of the count register.   I first observed
> this in OpenBSD, where the problem was worse, but Linux
> has the same conceptual hole.  A more robust handler
> looks a bit like this:

I noticed this as well, especially if I put serial debug code in the interrupt
handler. Then it's safer to always reset count to 0 in the interrupt handler.
Of course it's very inaccurate then, but at least you keep on getting
interrupts in a reasonable time frame.

Now I'm using one of the timers in the host bridge to generate the actual timer
interrupt, which seems to work fine. I could also use the normal PC RTC, but
then I have to get the i8259 interrupts working first. Fortunately PCI
interrupts are handled by the host bridge as well, so I see no hurry in getting
the i8259 interrupts working too soon :-)

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
