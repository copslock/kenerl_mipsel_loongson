Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 01:03:01 +0200 (CEST)
Received: from fanny.its.uu.se ([130.238.4.241]:59536 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493614AbZJTXCy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Oct 2009 01:02:54 +0200
Received: by fanny.its.uu.se (Postfix, from userid 212)
	id D793764C2; Wed, 21 Oct 2009 01:02:41 +0200 (MSZ)
Received: from pilspetsen.it.uu.se (pilspetsen.it.uu.se [130.238.18.39])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fanny.its.uu.se (Postfix) with ESMTP id B30AE62CA;
	Wed, 21 Oct 2009 01:02:32 +0200 (MSZ)
Received: (from mikpe@localhost)
	by pilspetsen.it.uu.se (8.13.8+Sun/8.13.8) id n9KN2VRi017122;
	Wed, 21 Oct 2009 01:02:31 +0200 (MEST)
X-Authentication-Warning: pilspetsen.it.uu.se: mikpe set sender to mikpe@it.uu.se using -f
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <19166.16775.583244.140972@pilspetsen.it.uu.se>
Date:	Wed, 21 Oct 2009 01:02:31 +0200
From:	Mikael Pettersson <mikpe@it.uu.se>
To:	Linus Walleij <linus.walleij@stericsson.com>
Cc:	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
	Mikael Pettersson <mikpe@it.uu.se>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code generic v2
In-Reply-To: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
References: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Return-Path: <mikpe@it.uu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24398
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
 > Tested-by: Mikael Pettersson <mikpe@it.uu.se>
 > Reviewed-by: Ralf Baechle <ralf@linux-mips.org>
 > ---
 > Changes v1->v2:
 > - Fixed Mikaels comments: spelling, terminology.
 > - Kept the functions inline: all uses and foreseen uses
 >   are once per kernel and all are in __init or __cpuinit sections.
 > - Unable to break out common code - the code is not common and
 >   implementing two execution paths will be more awkward.
 > - Hoping the tglx likes it anyway.

Very minor spelling nits below.

 > --- a/include/linux/clockchips.h
 > +++ b/include/linux/clockchips.h
 > @@ -115,6 +115,28 @@ static inline unsigned long div_sc(unsigned long ticks, unsigned long nsec,
 >  	return (unsigned long) tmp;
 >  }
 >  
 > +/**
 > + * clockevent_set_clock - calculates an appropriate shift
 > + *			  and mult values for a clockevent given a

can't have 'an' and a plural form, so s/an //

 > --- a/include/linux/clocksource.h
 > +++ b/include/linux/clocksource.h
 > @@ -257,6 +257,28 @@ static inline u32 clocksource_hz2mult(u32 hz, u32 shift_constant)
 >  }
 >  
 >  /**
 > + * clocksource_set_clock - calculates an appropriate shift
 > + *			   and mult values for a clocksource given a

ditto
