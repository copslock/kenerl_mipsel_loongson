Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 17:42:17 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:777 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226315AbVGGQmB>; Thu, 7 Jul 2005 17:42:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3E02DE1C99; Thu,  7 Jul 2005 18:42:26 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26624-04; Thu,  7 Jul 2005 18:42:26 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 0D77BE1C91; Thu,  7 Jul 2005 18:42:26 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j67GgUSm012951;
	Thu, 7 Jul 2005 18:42:30 +0200
Date:	Thu, 7 Jul 2005 17:42:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle DL5RB <ralf@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050707162959.GQ2822@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507071741320.3205@blysk.ds.pg.gda.pl>
References: <20050707091937Z8226163-3678+1737@linux-mips.org>
 <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl> <20050707121235.GV1645@hattusa.textio>
 <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl> <20050707122226.GW1645@hattusa.textio>
 <Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl> <20050707162959.GQ2822@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/971/Thu Jul  7 12:08:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jul 2005, Ralf Baechle DL5RB wrote:

> >  And they are actually used to implement these "-EL" and "-EB" options.  
> > Frankly I find "-mel" and "-meb" more consistent with the others as "-m*" 
> > generally imply target-specific options.
> 
> -EB / -EL are traditionally the options that all MIPS compilers including
> non-gcc compilers, seem to support.

 That's probably why they are there in GCC at all, but they are rather 
inconsistent with the rest of GCC options and we rely on GCC for builds 
anyway, so who cares?

  Maciej
