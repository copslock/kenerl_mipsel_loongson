Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 14:32:29 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:64468 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28600504AbYCQOc1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2008 14:32:27 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JbGO0-0004QJ-00; Mon, 17 Mar 2008 15:32:24 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id E4361C2360; Mon, 17 Mar 2008 15:32:15 +0100 (CET)
Date:	Mon, 17 Mar 2008 15:32:15 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: Compiler error? [was: Re: new kernel oops in recent kernels]
Message-ID: <20080317143215.GA11497@alpha.franken.de>
References: <1205664563.3050.4.camel@localhost> <1205699257.4159.14.camel@casa> <20080316233619.GA29511@alpha.franken.de> <1205741142.3515.2.camel@localhost> <20080317141828.GA25798@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080317141828.GA25798@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Mar 17, 2008 at 02:18:28PM +0000, Ralf Baechle wrote:
> On Mon, Mar 17, 2008 at 09:05:42AM +0100, Giuseppe Sacco wrote:
> 
> > The patch you proposed, that use a larger buffer, does not seems to
> > trigger the bug.
> 
> It may help but doesn't have a chance to be accepted upstream.  So
> this is no more than an useful litmus test.

sure, that's why I called it a hack. It was just to make sure, that I'm
on the right track.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
