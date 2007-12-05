Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 09:43:08 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:43672 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022728AbXLEJm7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2007 09:42:59 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IzqjN-0006Gx-00; Wed, 05 Dec 2007 10:39:49 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 7EEC9C2EB1; Wed,  5 Dec 2007 10:39:38 +0100 (CET)
Date:	Wed, 5 Dec 2007 10:39:38 +0100
To:	Kumba <kumba@gentoo.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
Message-ID: <20071205093938.GA6848@alpha.franken.de>
References: <20071129095442.C6679C2B39@solo.franken.de> <20071129130130.GA14655@linux-mips.org> <4756422D.6070305@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4756422D.6070305@gentoo.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Dec 05, 2007 at 01:16:13AM -0500, Kumba wrote:
> I've been out of it lately -- did the gcc side of things ever make it in, 
> or do we need to go push on that some more?

We need push on that. Looking at 

http://gcc.gnu.org/ml/gcc-patches/2006-04/msg00291.html

there seems to be a missing understanding, why the cache
barriers are needed. I guess the patch could be improved
by pointing directly to the errata section of the R10k
user manual. Or even better copy the text out of the user
manual. That should make clear why this patch is needed.

Peter did you do the copyright assigment ? That's probably
the second part, which needs to be done.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
