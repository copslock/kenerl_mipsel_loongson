Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 14:30:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23184 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022441AbXFONaZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 14:30:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5FDQDPZ009138;
	Fri, 15 Jun 2007 14:26:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5FDQDq7009137;
	Fri, 15 Jun 2007 14:26:13 +0100
Date:	Fri, 15 Jun 2007 14:26:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
	code.
Message-ID: <20070615132613.GA16133@linux-mips.org>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164023940-git-send-email-fbuihuu@gmail.com> <20070614111748.GA8223@alpha.franken.de> <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl> <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com> <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl> <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com> <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 15, 2007 at 12:07:05PM +0100, Maciej W. Rozycki wrote:

> > Which other purposes ? CP0 hpt gives generally the highest precision for
> > a given platform, and it seems to be your case too. I don't see which other
> > better purpose it can deserve other than hrtimer, tick interrupt...
> 
>  One better purpose could be using it as a backend timer for setitimer().  
> Or just a general timer device ("/dev/counter") with some operations to 
> make use of it.  I think there were some ideas quoted on this list.
> 
>  For real time you do not need a precision of one or two CPU clocks -- it 
> will be lost in the overhead of the gettimeofday() syscall, any cache 
> activity will flush the precision down the drain, any branch 
> unpredictability will ruin it, etc.  An actual resolution of 1us will be 
> excellent already.  Try running `ntpd' on your platform of choice using a 
> reasonable time reference source and see how it behaves.
> 
>  And last but not least for real time you do want to select the source 
> that has the best frequency stability and not necessarily the highest 
> frequency.  For DEC the IOASIC timer has reportedly the best stability and 
> was actually used by David L. Mills for his work on `ntpd'.  Perhaps the 
> temperature around the oscillator used for it changes the least.  
> Similarly the Dallas Semiconductor real time clocks have very good 
> frequency characteristics (quite unsurprisingly in my opinion).
> 
>  The issues around timekeeping have been beaten to death on many 
> discussion forums -- I guess many of them may be quite easily reached with 
> the right keywords and your favourite search engine.

The cp0 timer may have disadvantages but it certainly is the timer with
the lowest overhead to program, usually the timer with the highest
resolution.  Unless in the rare cases where cp0 cannot be used because
it cannot trigger interrupts or the CPU clock is variable I think it will
always be the clockevent device of choice.

You still need a decent clocksource and for that one it's much more
important to have something that provides good long term stability.  So
if you happen to have a system where the external timer tends to be
superior, by all means go for it.  All it takes is to assign it a higher
rating and the kernel will pick it.

> > I don't see how you can have hrtimer support if you choose a periodic
> > timer...
> 
>  Well, periodic timers do seem to work somehow for everybody else with no 
> hassle whatsoever, starting from the DEC code I referred to and including 
> other platforms, like the i386, which uses the 8254 for the timer 
> interrupt and as a HPT, by default, the very same counter or the TSC in 
> the CPU if available or, I think, some chipset timer, because some 
> brilliant soul decided to break the TSC at one point.

The tickless kernel needs something that can be used as oneshoot timer.

>  Note that the 8254 can be reprogrammed into a one-shot mode, but somehow 
> nobody does it. ;-)  Similarly for the local APIC timer that is used for 
> scheduling on i386 systems (if available).

Actually modern i386 kernels use it in both modes.  But this can't help
over the fact that the i8253/i8254 is a horrible chip with extremly slow
access times so it's only used as the fallback when everything else fails.

>  See arch/mips/mips-boards/generic/time.c for example.  Or any platform 
> that uses the CP0 timer interrupt and has a configurable CPU frequency -- 
> you can find them easily by looking for ones that calculate 
> mips_hpt_frequency rather than set it to a fixed value.

For some reason the calibration turned out to be rather trick on Indys, so
arch/mips/sgi-ip22/ip22-time.c's plat_time_init is a well working example
for calibration of the cp0 timer against a timer of know speed.

  Ralf
