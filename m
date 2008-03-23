Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Mar 2008 11:16:28 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:27588 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20024773AbYCWLQZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Mar 2008 11:16:25 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JdOBc-0004SP-01; Sun, 23 Mar 2008 12:16:24 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id CBF39C2DFF; Sun, 23 Mar 2008 12:16:10 +0100 (CET)
Date:	Sun, 23 Mar 2008 12:16:10 +0100
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Compiler error? [was: Re: new kernel oops in recent kernels]
Message-ID: <20080323111610.GA8660@alpha.franken.de>
References: <1205664563.3050.4.camel@localhost> <1205699257.4159.14.camel@casa> <20080316233619.GA29511@alpha.franken.de> <1205741142.3515.2.camel@localhost> <20080317141828.GA25798@linux-mips.org> <20080317143215.GA11497@alpha.franken.de> <20080321230010.GA31135@alpha.franken.de> <1206229198.4075.12.camel@casa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1206229198.4075.12.camel@casa>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Mar 23, 2008 at 12:39:58AM +0100, Giuseppe Sacco wrote:
> > Giuseppe, could you please check if this fixes your problem, and
> > doesn't cause new regressions ? 
> 
> I rebuilt a kernel (pulling latest code from git) with your patch. Now I
> do not get anymore the Oops at boot time, moreover I may mount a CDROM
> and copying data from that CDROM to local SCSI disk.

great, thank you for testing. I'll submit the patch to the maintainer.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
