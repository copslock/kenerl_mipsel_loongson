Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 22:04:49 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:31898 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20032348AbXKGWEl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2007 22:04:41 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Ipt0q-000136-00; Wed, 07 Nov 2007 23:04:40 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 3E6E3C2256; Wed,  7 Nov 2007 22:54:23 +0100 (CET)
Date:	Wed, 7 Nov 2007 22:54:23 +0100
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] IP22: Disable EARLY PRINTK, because it breaks serial console
Message-ID: <20071107215423.GA11915@alpha.franken.de>
References: <20070911104459.GB7624@alpha.franken.de> <20071030073349.GA15984@deprecation.cyrius.com> <Pine.LNX.4.64N.0711071648040.14970@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0711071648040.14970@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Nov 07, 2007 at 04:55:10PM +0000, Maciej W. Rozycki wrote:
> On Tue, 30 Oct 2007, Martin Michlmayr wrote:
> 
> > * Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2007-09-11 12:44]:
> > > Disable EARLY PRINTK, because it breaks serial console
> > 
> > Ralf, at the moment IP22 output stops after "Serial: IP22 Zilog driver
> > (1 chips).".  Can you put this patch in until there's a real fix?
> 
>  Is it by any chance the same problem that I noticed with the DECstation 
> and reported in the thread starting at: 

it's the same problem

> "http://marc.info/?l=linux-kernel&m=119030963931879&w=2"?  If so, there is 
> a fix for the DECstation provided somewhere down the discussion which you 
> may consider porting to IP22.  I think the change to the serial core by 
> RMK mentioned there has already been applied upstream.

I ported your fix, but it didn't work for me. Maybe because the
IP22 zilog driver is still a little bit different than the DEC one.

>  Ideally, of course, all the SCC drivers should get merged eventually, but 
> due to subtle (and sometimes broken, as it is the case with the 
> DECstation) differences in wiring for various systems it may never really 
> happen, sigh...

having a more generic zilog driver with platform backends is quite high on
my todo list. But I won't make promisses when this happens...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
