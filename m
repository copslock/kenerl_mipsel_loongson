Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Oct 2005 14:29:40 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:38919 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465602AbVJVN3V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Oct 2005 14:29:21 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9MDTCof005509;
	Sat, 22 Oct 2005 14:29:12 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9MDT9wO005494;
	Sat, 22 Oct 2005 14:29:09 +0100
Date:	Sat, 22 Oct 2005 14:29:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Steven J. Hill" <sjhill@realitydiluted.com>
Cc:	Aaditya Rai <arai@atheros.com>, linux-mips@linux-mips.org
Subject: Re: mips 2.4 vs 2.6 stability.
Message-ID: <20051022132909.GA2610@linux-mips.org>
References: <43598DFE.8040100@atheros.com> <4359AEAD.8010604@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4359AEAD.8010604@realitydiluted.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 21, 2005 at 10:14:53PM -0500, Steven J. Hill wrote:

> Aaditya Rai wrote:
> >Hi everyone, I've searched the list for an answer and gotten, "there's 
> >no stable release; check out from cvs" ;-)
> >I'm trying to figure out if there are stability issues with mips port of 
> >2.6? Specifically for 24K? Is mips-2.4 generally considered to be more 
> >stable?
> >
> Use 2.6 if you are working with 24K. Yes, it is stable that's why we are
> using 2.6 and not 2.5 because the even numbers are stable releases. *sigh*
> Geesh, kids these days.

That's the theory.  In practice 2.4 does hardly receive any attention
anymore; these days the 2.4 branch is mostly following Marcelo's updates
but that's about it.  That's equivalent to saying bitrot is creeping into
2.4's direction and whatever issues there are with 2.6 will be resolved
much more aggressivly than in 2.4.

  Ralf
