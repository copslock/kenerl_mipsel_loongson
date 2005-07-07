Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 17:29:54 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:16656 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226309AbVGGQ3f>; Thu, 7 Jul 2005 17:29:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j67GU0NJ021402;
	Thu, 7 Jul 2005 17:30:00 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j67GTx2C021401;
	Thu, 7 Jul 2005 17:29:59 +0100
Date:	Thu, 7 Jul 2005 17:29:59 +0100
From:	Ralf Baechle DL5RB <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050707162959.GQ2822@linux-mips.org>
References: <20050707091937Z8226163-3678+1737@linux-mips.org> <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl> <20050707121235.GV1645@hattusa.textio> <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl> <20050707122226.GW1645@hattusa.textio> <Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 07, 2005 at 02:01:11PM +0100, Maciej W. Rozycki wrote:
> Date:	Thu, 7 Jul 2005 14:01:11 +0100 (BST)
> From:	"Maciej W. Rozycki" <macro@linux-mips.org>
> To:	Thiemo Seufer <ths@networkno.de>
> Cc:	linux-mips@linux-mips.org
> Subject: Re: CVS Update@linux-mips.org: linux
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
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

-EB / -EL are traditionally the options that all MIPS compilers including
non-gcc compilers, seem to support.

  Ralf
