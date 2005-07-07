Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 14:00:58 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:57868 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226161AbVGGNAg>; Thu, 7 Jul 2005 14:00:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E4D09E1C89; Thu,  7 Jul 2005 15:01:01 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20841-10; Thu,  7 Jul 2005 15:01:01 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9F03CE1C88; Thu,  7 Jul 2005 15:01:01 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j67D14B4002646;
	Thu, 7 Jul 2005 15:01:04 +0200
Date:	Thu, 7 Jul 2005 14:01:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050707122226.GW1645@hattusa.textio>
Message-ID: <Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl>
References: <20050707091937Z8226163-3678+1737@linux-mips.org>
 <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl> <20050707121235.GV1645@hattusa.textio>
 <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl> <20050707122226.GW1645@hattusa.textio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/970/Wed Jul  6 18:00:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jul 2005, Thiemo Seufer wrote:

> > They are not in the info pages, but that should probably be considered an 
> > accidental omission.  Is using something that's documented but doesn't 
> > work, to the contrary, any better?
> 
> Probably not. It's just that I've never seen actual use of -mel/-meb yet.

 Good -- it means you haven't been watching over my shoulder. ;-)  I've 
used them several times for big-endian builds with my toolchain, which, as 
you may be aware, has been exclusively little-endian so far.

 And they are actually used to implement these "-EL" and "-EB" options.  
Frankly I find "-mel" and "-meb" more consistent with the others as "-m*" 
generally imply target-specific options.

  Maciej
