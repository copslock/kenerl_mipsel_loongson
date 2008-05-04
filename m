Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 May 2008 23:08:16 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:1713 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28585233AbYEDWIN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 May 2008 23:08:13 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JsmNO-0002ZB-00; Mon, 05 May 2008 00:08:10 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2F928C2BE5; Mon,  5 May 2008 00:08:04 +0200 (CEST)
Date:	Mon, 5 May 2008 00:08:04 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
Message-ID: <20080504220804.GA13442@alpha.franken.de>
References: <20080502101113.GA24408@linux-mips.org> <20080504.011647.93019265.anemo@mba.ocn.ne.jp> <20080503224849.GA2314@alpha.franken.de> <20080504.223944.41198532.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080504.223944.41198532.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, May 04, 2008 at 10:39:44PM +0900, Atsushi Nemoto wrote:
> > +	unsigned long __user *sp = (unsigned long __user *)(reg29 & ~3);
> ...
> > +	while (!kstack_end(sp)) {
> > +		if (__get_user(addr, sp++)) {
> 
> This will leads a sparse warning since an argument for kstack_end is 'void *'.
> 
> 	while (!kstack_end((void *)(unsigned long)sp)) {
> 
> will make this part sparse-free, though it seems a bit ugly.

hmm, would leaving sp as unsigned long * and casting it for __get_user()
make sparse happy ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
