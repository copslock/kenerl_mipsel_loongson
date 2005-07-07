Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 14:50:56 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:18880 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8226309AbVGGNul>;
	Thu, 7 Jul 2005 14:50:41 +0100
Received: from port-195-158-170-192.dynamic.qsc.de ([195.158.170.192] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DqWmQ-0003Uy-00; Thu, 07 Jul 2005 15:51:06 +0200
Received: from ths by hattusa.textio with local (Exim 4.51)
	id 1DqWmQ-0007we-4J; Thu, 07 Jul 2005 15:51:06 +0200
Date:	Thu, 7 Jul 2005 15:51:06 +0200
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050707135105.GX1645@hattusa.textio>
References: <20050707091937Z8226163-3678+1737@linux-mips.org> <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl> <20050707121235.GV1645@hattusa.textio> <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl> <20050707122226.GW1645@hattusa.textio> <Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 7 Jul 2005, Thiemo Seufer wrote:
> 
> > > They are not in the info pages, but that should probably be considered an 
> > > accidental omission.  Is using something that's documented but doesn't 
> > > work, to the contrary, any better?
> > 
> > Probably not. It's just that I've never seen actual use of -mel/-meb yet.
> 
>  Good -- it means you haven't been watching over my shoulder. ;-)  I've 
> used them several times for big-endian builds with my toolchain, which, as 
> you may be aware, has been exclusively little-endian so far.
> 
>  And they are actually used to implement these "-EL" and "-EB" options.  
> Frankly I find "-mel" and "-meb" more consistent with the others as "-m*" 
> generally imply target-specific options.

Other gcc targets use IIRC -BE and -LE. It might be worthwile to document
-mel/-meb better, use them generally in gcc, and then mark the uppercase
options as deprecated.


Thiemo
