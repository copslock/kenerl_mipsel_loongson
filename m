Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 12:07:42 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:10506 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022397AbXFOLHj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 12:07:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7B8FEE1D0E;
	Fri, 15 Jun 2007 13:07:00 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ev+SbG3LwcNZ; Fri, 15 Jun 2007 13:07:00 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 04DF1E1C6B;
	Fri, 15 Jun 2007 13:06:59 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5FB78Gf008313;
	Fri, 15 Jun 2007 13:07:08 +0200
Date:	Fri, 15 Jun 2007 12:07:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
In-Reply-To: <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> 
 <11818164023940-git-send-email-fbuihuu@gmail.com>  <20070614111748.GA8223@alpha.franken.de>
  <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> 
 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl> 
 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com> 
 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
 <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3424/Fri Jun 15 03:30:29 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 15 Jun 2007, Franck Bui-Huu wrote:

> > Well, many platforms have some sort of external timer interrupt sources
> > (like an 8254 or an DS1287 or even a more sophisticated timer; sometimes
> > integrated in the south bridge and collecting dust there), but people tend
> > to follow the path of least resistance and use the CP0 timer, even though
> > it is is a valuable resource that may be used for some other purposes.  I
> 
> Which other purposes ? CP0 hpt gives generally the highest precision for
> a given platform, and it seems to be your case too. I don't see which other
> better purpose it can deserve other than hrtimer, tick interrupt...

 One better purpose could be using it as a backend timer for setitimer().  
Or just a general timer device ("/dev/counter") with some operations to 
make use of it.  I think there were some ideas quoted on this list.

 For real time you do not need a precision of one or two CPU clocks -- it 
will be lost in the overhead of the gettimeofday() syscall, any cache 
activity will flush the precision down the drain, any branch 
unpredictability will ruin it, etc.  An actual resolution of 1us will be 
excellent already.  Try running `ntpd' on your platform of choice using a 
reasonable time reference source and see how it behaves.

 And last but not least for real time you do want to select the source 
that has the best frequency stability and not necessarily the highest 
frequency.  For DEC the IOASIC timer has reportedly the best stability and 
was actually used by David L. Mills for his work on `ntpd'.  Perhaps the 
temperature around the oscillator used for it changes the least.  
Similarly the Dallas Semiconductor real time clocks have very good 
frequency characteristics (quite unsurprisingly in my opinion).

 The issues around timekeeping have been beaten to death on many 
discussion forums -- I guess many of them may be quite easily reached with 
the right keywords and your favourite search engine.

> > think the issue has been raised here many times already.  The CP0 timer
> > has its problems too as it is one-shot only and needs complicated recovery
> > if an interrupt is missed -- see c0_timer_ack().
> 
> Well I would say that because it's one-shot, it's a good timer to choose.

 I fail to get your point, sorry -- could you please elaborate?

> I don't see how you can have hrtimer support if you choose a periodic
> timer...

 Well, periodic timers do seem to work somehow for everybody else with no 
hassle whatsoever, starting from the DEC code I referred to and including 
other platforms, like the i386, which uses the 8254 for the timer 
interrupt and as a HPT, by default, the very same counter or the TSC in 
the CPU if available or, I think, some chipset timer, because some 
brilliant soul decided to break the TSC at one point.

 Note that the 8254 can be reprogrammed into a one-shot mode, but somehow 
nobody does it. ;-)  Similarly for the local APIC timer that is used for 
scheduling on i386 systems (if available).

> And missed interrupts doens't seem a big deal, and the new kernel time
> subsystem handle them for us already.

 Well, creating problems, because they can be solved seems not the way to 
go for me.  Just my opinion, though.

> > mips_timer_state appropriately, i.e. to flip at the HZ rate (it may be
> > based on one of the south bridge choices mentioned above or some
> > free-running counter for example), but people seem to prefer to write
> > their own code for some reason. ;-)
> 
> Do you have any examples in mind which rewrite their own calibration
> code ? I'm too lazy to search into all board code.

 See arch/mips/mips-boards/generic/time.c for example.  Or any platform 
that uses the CP0 timer interrupt and has a configurable CPU frequency -- 
you can find them easily by looking for ones that calculate 
mips_hpt_frequency rather than set it to a fixed value.

> >  And FYI for DEC CP0 is meant to be the last resort (current code does not
> 
> Again IMHO it should be the first choice if possible.

 Please search the list archive for the discussion about why it is not the 
best idea.  I think there were at least two discussions actually -- one 
around the time the current code was created.

  Maciej
