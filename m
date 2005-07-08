Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 16:59:29 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:27916 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226365AbVGHP7L>; Fri, 8 Jul 2005 16:59:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 0ACA2E1CB2; Fri,  8 Jul 2005 17:59:43 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03664-02; Fri,  8 Jul 2005 17:59:42 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id AFFF6E1CA8; Fri,  8 Jul 2005 17:59:42 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j68Fxln7003130;
	Fri, 8 Jul 2005 17:59:47 +0200
Date:	Fri, 8 Jul 2005 16:59:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Richard Sandiford <richard@codesourcery.com>
Cc:	Ralf Baechle DL5RB <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <87pstt4891.fsf@talisman.home>
Message-ID: <Pine.LNX.4.61L.0507081652370.25104@blysk.ds.pg.gda.pl>
References: <20050707091937Z8226163-3678+1737@linux-mips.org>
 <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl> <20050707121235.GV1645@hattusa.textio>
 <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl> <20050707122226.GW1645@hattusa.textio>
 <Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl> <20050707162959.GQ2822@linux-mips.org>
 <87zmsx4do1.fsf@talisman.home> <Pine.LNX.4.61L.0507081553040.25104@blysk.ds.pg.gda.pl>
 <87pstt4891.fsf@talisman.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/972/Fri Jul  8 15:43:11 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 8 Jul 2005, Richard Sandiford wrote:

> > 2005-07-08  Maciej W. Rozycki  <macro@mips.com>
> >
> > 	* config/mips/linux.h (CC1_SPEC): Override defaults from
> > 	config/linux.h.
> 
> Looks reasonable, but I think you should just set SUBTARGET_CC1_SPEC
> to the normal linux.h definition of CC1_SPEC.  There shouldn't be
> any need to redefine CC1_SPEC itself (with all the mips.h duplication
> that that implies).  It'll be easier to keep things in sync that way.

 The problem is config/linux.h defines CC1_SPEC before config/mips.h is 
included and as a result the latter does not redefine it.  I feared 
changing "#ifdef CC1_SPEC ... #endif" to "#undef CC1_SPEC" would break 
other targets -- there are too many of them and the dependencies are too 
scattered for me to dare fiddling with this macro (proof-reading is futile 
and testing every configuration impossible).  At least this change is 
guaranteed to affect only Linux.  But I would encourage you, as the 
maintainer, to get a more consistent general arrangement and I can do 
testing for configurations I have access to.

  Maciej
