Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 10:30:27 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:14740 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28578256AbXLRKaS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Dec 2007 10:30:18 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1J4ZiI-00075G-00; Tue, 18 Dec 2007 11:30:14 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id E9764E3030; Tue, 18 Dec 2007 11:30:06 +0100 (CET)
Date:	Tue, 18 Dec 2007 11:30:06 +0100
To:	Jeff Garzik <jgarzik@pobox.com>
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [UPDATED PATCH] SGISEEQ: use cached memory access to make driver work on IP28
Message-ID: <20071218103006.GA18598@alpha.franken.de>
References: <20071202103312.75E51C2EB5@solo.franken.de> <47671FEE.90103@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47671FEE.90103@pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Dec 17, 2007 at 08:18:38PM -0500, Jeff Garzik wrote:
> >Changes to last version:
> >- Use inline functions for dma_sync_* instead of macros (suggested by Ralf)
> >- added Kconfig change to make selection for similair SGI boxes easier
> 
> hrm, could you rediff?  it doesn't seem to apply

sure, against which tree ? I tried netdev-2.6 and it applies without fuzz...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
