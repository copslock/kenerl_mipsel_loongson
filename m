Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 16:39:20 +0100 (BST)
Received: from admin.voldemort.codesourcery.com ([IPv6:::ffff:65.74.133.9]:3016
	"EHLO mail.codesourcery.com") by linux-mips.org with ESMTP
	id <S8226365AbVGHPjG>; Fri, 8 Jul 2005 16:39:06 +0100
Received: (qmail 22200 invoked by uid 1010); 8 Jul 2005 15:39:40 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,Ralf Baechle DL5RB <ralf@linux-mips.org>,  Thiemo Seufer <ths@networkno.de>,  linux-mips@linux-mips.org, richard@codesourcery.com
Cc:	Ralf Baechle DL5RB <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
References: <20050707091937Z8226163-3678+1737@linux-mips.org>
	<Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl>
	<20050707121235.GV1645@hattusa.textio>
	<Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl>
	<20050707122226.GW1645@hattusa.textio>
	<Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl>
	<20050707162959.GQ2822@linux-mips.org> <87zmsx4do1.fsf@talisman.home>
	<Pine.LNX.4.61L.0507081553040.25104@blysk.ds.pg.gda.pl>
Date:	Fri, 08 Jul 2005 16:39:38 +0100
In-Reply-To: <Pine.LNX.4.61L.0507081553040.25104@blysk.ds.pg.gda.pl> (Maciej
	W. Rozycki's message of "Fri, 8 Jul 2005 16:05:05 +0100 (BST)")
Message-ID: <87pstt4891.fsf@talisman.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> On Fri, 8 Jul 2005, Richard Sandiford wrote:
>> Right.  I've always thought of them as the canonical options for gcc
>> as well.  I think the only reason internal compilers like cc1 have
>> -mel and -meb is because gcc's target options system has traditionally
>> required every target option to begin with "-m".  (That's no longer
>> a restriction in 4.1 FWIW.)
>
>  I'm not sure relaxing this restriction is actually a good idea -- there 
> may be tools external to GCC that make this assumption for additional
> handling of options passed to GCC.

Oh, I agree that targets shouldn't gratuitously add non -m options.
All I meant was that, if a target does decide to support compatibility
options like -EB or -EL (or -BE or -LE), the new intrastructure allows
you to do it directly, rather than introduce internal forwarding options
like -meb or -mel.  Forwarding options can cause the sort of confusion
we've seen here.

If we have a clean slate, and no compatibility worries, I agree that
it's better to use -m options across the board.

>  FWIW, I prepared the following patch for GCC 3.4.x the other day -- would 
> you care to verify whether it's still needed for 4.x?  It may be worth
> applying to 3.4, too -- I think the branch hasn't got closed yet, has it?

A quick look at the code suggests that it is still needed for 4.x, yes.

> 2005-07-08  Maciej W. Rozycki  <macro@mips.com>
>
> 	* config/mips/linux.h (CC1_SPEC): Override defaults from
> 	config/linux.h.

Looks reasonable, but I think you should just set SUBTARGET_CC1_SPEC
to the normal linux.h definition of CC1_SPEC.  There shouldn't be
any need to redefine CC1_SPEC itself (with all the mips.h duplication
that that implies).  It'll be easier to keep things in sync that way.

>  Unfortunately it won't let us remove the newly introduced hackery from 
> Linux as (unlike you) we need to support versions back to 2.95.x.

Understood.

Richard
