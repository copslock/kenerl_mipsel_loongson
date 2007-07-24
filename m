Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 01:59:09 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:16580 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022473AbXGXA7H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 01:59:07 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1ID8jy-0006yH-00; Tue, 24 Jul 2007 02:59:06 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 5266011A3D0; Tue, 24 Jul 2007 02:54:52 +0200 (CEST)
Date:	Tue, 24 Jul 2007 02:54:52 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove unneeded reset function for jazz
Message-ID: <20070724005452.GA10195@alpha.franken.de>
References: <20070722130649.439bf4c2.yoichi_yuasa@tripeaks.co.jp> <20070723131944.GC31040@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070723131944.GC31040@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Jul 23, 2007 at 02:19:44PM +0100, Ralf Baechle wrote:
> On Sun, Jul 22, 2007 at 01:06:49PM +0900, Yoichi Yuasa wrote:
> 
> > remove unneeded reset function for jazz
> 
> Thanks, ok?  Or do you instead want to put something into these functions?

yes. Looks like jazz doesn't support software controlled power down.

Thomas.


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
