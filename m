Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2008 09:17:05 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:56544 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S23947480AbYK0JQy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2008 09:16:54 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1L5czJ-0007ui-00; Thu, 27 Nov 2008 10:16:41 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id D621EC30F1; Thu, 27 Nov 2008 10:16:19 +0100 (CET)
Date:	Thu, 27 Nov 2008 10:16:19 +0100
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Remove unused header file gio.h
Message-ID: <20081127091619.GA6255@alpha.franken.de>
References: <1227706472-16219-1-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1227706472-16219-1-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Nov 26, 2008 at 03:34:32PM +0200, Dmitri Vorobiev wrote:
> Grepping reveals that arch/mips/include/asm/sgi/gio.h is
> not used by anyone, so let's delete the orphan header.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> ---

NAK, I have work in progress, which adds GIO devices and uses this
file.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
