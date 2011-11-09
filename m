Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 23:00:51 +0100 (CET)
Received: from merlin.infradead.org ([205.233.59.134]:34824 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903665Ab1KIWAn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 23:00:43 +0100
Received: from canuck.infradead.org ([2001:4978:20e::1])
        by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
        id 1ROGCC-0004lI-5C; Wed, 09 Nov 2011 22:00:36 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
        by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
        id 1ROGCB-0001Ru-4R; Wed, 09 Nov 2011 22:00:35 +0000
Received: by twins (Postfix, from userid 1000)
        id 9AC419B6CFC3; Wed,  9 Nov 2011 23:00:28 +0100 (CET)
Subject: Re: [PATCH 1/4] MIPS/Perf-events: update the map of unsupported
 events for 74K
From:   Peter Zijlstra <a.p.zijlstra@chello.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Deng-Cheng Zhu <dczhu@mips.com>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Date:   Wed, 09 Nov 2011 23:00:28 +0100
In-Reply-To: <20111109204020.GB13280@linux-mips.org>
References: <1319453762-12962-1-git-send-email-dczhu@mips.com>
         <1319453762-12962-2-git-send-email-dczhu@mips.com>
         <20111109204020.GB13280@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.0.3- 
Message-ID: <1320876028.19727.24.camel@twins>
Mime-Version: 1.0
X-archive-position: 31485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.p.zijlstra@chello.nl
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8244

On Wed, 2011-11-09 at 20:40 +0000, Ralf Baechle wrote:
> On Mon, Oct 24, 2011 at 06:55:59PM +0800, Deng-Cheng Zhu wrote:
> 
> > Update the raw event info for 74K according to the latest document.
> 
> > +/*
> > + * MIPS document MD00519 (MIPS32(r) 74K(tm) Processor Core Family Software
> > + * User's Manual, Revision 01.05)
> > + */
> >  #define IS_UNSUPPORTED_74K_EVENT(r, b)					\
> > -	((r) == 5 || ((r) >= 135 && (r) <= 137) ||			\
> > -	 ((b) >= 10 && (b) <= 12) || (b) == 22 || (b) == 27 ||		\
> > -	 (b) == 33 || (b) == 34 || ((b) >= 47 && (b) <= 49) ||		\
> > -	 (r) == 178 || (b) == 55 || (b) == 57 || (b) == 60 ||		\
> > -	 (b) == 61 || (r) == 62 || (r) == 191 ||			\
> > -	 ((b) >= 64 && (b) <= 127))
> > +	((r) == 5 || (r) == 135 || ((b) >= 10 && (b) <= 12) ||		\
> > +	 (b) == 27 || (b) == 33 || (b) == 34 || (b) == 47 ||		\
> > +	 (b) == 48 || (r) == 178 || (r) == 187 || (b) == 60 ||		\
> > +	 (b) == 61 || (r) == 191 || (r) == 71 || (r) == 72 ||		\
> > +	 (b) == 73 || ((b) >= 77 && (b) <= 127))
> 
> I wonder if such detailed checking of the performance counter
> event numbers is really needed?  As long as feeding an bad number only
> results in undefined counts of the performance counters I think we may
> be better of by not checking the event numbers in detail.  Afair there
> are MIPS licensee who have modified the counters to count extra events
> so I sense some madness in that direction.

Right, we don't do much sanity checking on x86 either, all we do check
are privilege bits, the rest we directly feed to the hardware. This all
works as long as the hardware doesn't in fact fall over or worse of
course. 

On x86 it means you can program events that are outside those specified
in the SDM, some actually count, although outside of specific hardware
team for that chip I doubt there's anybody on the planet who can tell
you what ;-)

Not counting or counter utter crap is fine, that's what you get for
passing in random numbers.
