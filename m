Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2008 12:31:32 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:2467 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28575504AbYBHMbY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Feb 2008 12:31:24 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JNSO2-00055w-00; Fri, 08 Feb 2008 13:31:22 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 14FABC2359; Fri,  8 Feb 2008 13:28:59 +0100 (CET)
Date:	Fri, 8 Feb 2008 13:28:59 +0100
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: early_ioremap for MIPS
Message-ID: <20080208122858.GA8267@alpha.franken.de>
References: <200802071932.23965.florian.fainelli@telecomint.eu> <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Feb 08, 2008 at 11:05:12AM +0000, Maciej W. Rozycki wrote:
> On Thu, 7 Feb 2008, Florian Fainelli wrote:
> 
> > Is there any need for early_ioremap on MIPS ? Seems like only x86_64 is 
> > implementing it for now.
> 
> physical address space could potentially benefit though.  I recall some 
> Alchemy systems may fall into this category.

Jazz has the same problem. Right now it's solved by using wired tlb
entries. Which is sort of an early_ioremap.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
