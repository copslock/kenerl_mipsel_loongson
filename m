Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 15:27:12 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:2470 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023702AbXKHP1D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Nov 2007 15:27:03 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id CF01D40092;
	Thu,  8 Nov 2007 16:26:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id c3UUcOo4ouni; Thu,  8 Nov 2007 16:26:27 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 310F44007E;
	Thu,  8 Nov 2007 16:26:27 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lA8FQVYL012887;
	Thu, 8 Nov 2007 16:26:31 +0100
Date:	Thu, 8 Nov 2007 15:26:26 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Ulrich Eckhardt <eckhardt@satorlaser.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Put cast inside macro instead of all the callers
In-Reply-To: <20071101174705.GA23917@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0711081506560.23511@blysk.ds.pg.gda.pl>
References: <20071031141124.185599da@ripper.onstor.net>
 <200711011704.01079.eckhardt@satorlaser.com> <20071101174705.GA23917@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4708/Thu Nov  8 07:07:54 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 1 Nov 2007, Ralf Baechle wrote:

> > I'm not sure if this is always a compile-time constant so that you can adorn
> > it with a LL. However, note that this is not a cast, a cast is at runtime.
> 
> No.  The compiler can evaluate the cast of a constant value at compile
> time and that exactly is what the code is exploiting here.

 Except that some versions of GCC "forget" to stop a warning here as 
irrelevant after the cast, hence the need for the stupid "#ifdef", sigh...

> > >  	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
> > >  		usp = CKSEG1ADDR(sp);
> > >  #ifdef CONFIG_64BIT
> > > -	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
> > > -		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
> > > -		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
> > > +	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0, 0) &&
> > > +		 (long long)sp < (long long)PHYS_TO_XKPHYS(8, 0))
> > > +		usp = PHYS_TO_XKPHYS(K_CALG_UNCACHED,
> > >  				     XKPHYS_TO_PHYS((long long)sp));
> > 
> > I'd say this code is broken in way too many aspects:
> > 1. A plethora of casts. PHYS_TO_XKPHYS() should return a physical address 
> > (i.e. 32 or 64 bits unsigned integer) already, so casting its result should 
> > not be necessary.
> 
> No argument about the beauty of the whole thing.

 The casts were an attempt by myself to shut up GCC warning about 
comparisons giving a predictable result because of a limited size of the 
data type used.  Of course this is no longer true with "long long", but 
GCC does not care and warns regardless.

 A possible workaround would be using auxiliary variables of the "long 
long" type, but I recall it making GCC produce worse code for some cases.  
I can check it again, since it has been a while, and if a recent version 
of GCC produces reasonable code, then I can try to recheck this approach.

 Please note this code changes quite wildly depending on the exact 
configuration, so chances are GCC may warn with one, but not another.

  Maciej
