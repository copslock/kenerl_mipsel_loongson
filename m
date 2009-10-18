Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2009 00:10:58 +0200 (CEST)
Received: from fanny.its.uu.se ([130.238.4.241]:2256 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493141AbZJRWKv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Oct 2009 00:10:51 +0200
Received: by fanny.its.uu.se (Postfix, from userid 212)
	id 4E4D06271; Mon, 19 Oct 2009 00:10:51 +0200 (MSZ)
Received: from pilspetsen.it.uu.se (pilspetsen.it.uu.se [130.238.18.39])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fanny.its.uu.se (Postfix) with ESMTP id 846B7623B;
	Mon, 19 Oct 2009 00:10:42 +0200 (MSZ)
Received: (from mikpe@localhost)
	by pilspetsen.it.uu.se (8.13.8+Sun/8.13.8) id n9IMAfM8004872;
	Mon, 19 Oct 2009 00:10:41 +0200 (MEST)
X-Authentication-Warning: pilspetsen.it.uu.se: mikpe set sender to mikpe@it.uu.se using -f
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <19163.37473.182585.322550@pilspetsen.it.uu.se>
Date:	Mon, 19 Oct 2009 00:10:41 +0200
From:	Mikael Pettersson <mikpe@it.uu.se>
To:	Linus Walleij <linus.walleij@stericsson.com>
Cc:	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Mikael Pettersson <mikpe@it.uu.se>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code generic
In-Reply-To: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Return-Path: <mikpe@it.uu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikpe@it.uu.se
Precedence: bulk
X-list: linux-mips

Linus Walleij writes:
 > This moves the clocksource_set_clock() and clockevent_set_clock()
 > from the MIPS timer code into clockchips and clocksource where
 > it belongs. The patch was triggered by code posted by Mikael
 > Pettersson duplicating this code for the IOP ARM system. The
 > function signatures where altered slightly to fit into their
 > destination header files, unsigned int changed to u32 and inlined.
 > 
 > Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
 > Cc: Thomas Gleixner <tglx@linutronix.de>
 > Cc: Mikael Pettersson <mikpe@it.uu.se>
 > Cc: Ralf Baechle <ralf@linux-mips.org>
 > ---
 > Ralf has stated in earlier conversation that this should be moved,
 > now we risk duplicating code so let's move it.
 > 
 > I don't have access to a MIPS cross-compiler so please can the
 > MIPS people test this?
 > 
 > Can you test it on the IOP too, Mikael?

Changing my ARM IOP clock code to use these now shared functions
was easy, and I get the same shift/mult values as I got before. So:

Tested-by: Mikael Pettersson <mikpe@it.uu.se>

A few tiny comments about the patch follow below.

 > --- a/include/linux/clockchips.h
 > +++ b/include/linux/clockchips.h
 > @@ -115,6 +115,30 @@ static inline unsigned long div_sc(unsigned long ticks, unsigned long nsec,
 >  	return (unsigned long) tmp;
 >  }
 >  
 > +/**
 > + * clockevent_set_clock - dynamically calculates an appropriate shift
 > + *			  and mult value for a clocksource given a

drop "dynamically"
"calculates appropriate shift and mult values" ?

s/clocksource/clockevent/

 > + *			  known clock frequency
 > + * @dev:	Clockevent device to initialize
 > + * @hz:		Clockevent clock frequency in Hz
 > + */
 > +static inline void clockevent_set_clock(struct clock_event_device *dev, u32 hz)
 > +{
 > +	u64 temp;
 > +	u32 shift;
 > +
 > +	/* Find a shift value */

This comment is inaccurate. It should say "Find shift and mult values",
or you could remove it and rely on the comment above the function
definition to document the intended behaviour.

 > +	for (shift = 32; shift > 0; shift--) {
 > +		temp = (u64) hz << shift;
 > +		do_div(temp, NSEC_PER_SEC);
 > +		if ((temp >> 32) == 0)
 > +			break;
 > +	}
 > +	dev->shift = shift;
 > +	dev->mult = (u32) temp;
 > +}
 > +
 > +

Two empty lines?

 >  /* Clock event layer functions */
 >  extern unsigned long clockevent_delta2ns(unsigned long latch,
 >  					 struct clock_event_device *evt);
 > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
 > index 9ea40ff..807fb37 100644
 > --- a/include/linux/clocksource.h
 > +++ b/include/linux/clocksource.h
 > @@ -257,6 +257,29 @@ static inline u32 clocksource_hz2mult(u32 hz, u32 shift_constant)
 >  }
 >  
 >  /**
 > + * clocksource_set_clock - dynamically calculates an appropriate shift
 > + *			   and mult value for a clocksource given a

drop "dynamically"
"calculates appropriate shift and mult values" ?

 > + *			   known clock frequency
 > + * @cs:		Clocksource to initialize
 > + * @hz:		Clocksource frequency in Hz
 > + */
 > +static inline void clocksource_set_clock(struct clocksource *cs, u32 hz)
 > +{
 > +	u64 temp;
 > +	u32 shift;
 > +
 > +	/* Find a shift value */

Same issue as with the comment in clockevent_set_clock().
