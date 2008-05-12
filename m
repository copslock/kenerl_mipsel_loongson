Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 16:59:03 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:6359 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20031638AbYELP7A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 16:59:00 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JvaQO-0004fL-00; Mon, 12 May 2008 17:58:52 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2B1EBDE534; Mon, 12 May 2008 17:56:35 +0200 (CEST)
Date:	Mon, 12 May 2008 17:56:35 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix check for valid stack pointer during backtrace
Message-ID: <20080512155635.GA27431@alpha.franken.de>
References: <20080512125923.0C641DE534@solo.franken.de> <20080512.232421.108306312.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080512.232421.108306312.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2008 at 11:24:21PM +0900, Atsushi Nemoto wrote:
> > -	unsigned long *sp = (unsigned long *)(reg29 & ~3);
> > +	unsigned long __user *sp = (unsigned long __user *)(reg29 & ~3);
> 
> Please drop this change, while kstack_end expect non __user pointer.

arg, of course. Thanks.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
