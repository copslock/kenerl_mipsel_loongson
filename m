Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 23:28:15 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:35718 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20030847AbYDPW2L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2008 23:28:11 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JmG6o-00084V-00; Thu, 17 Apr 2008 00:28:06 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 13667C3E3F; Thu, 17 Apr 2008 00:27:56 +0200 (CEST)
Date:	Thu, 17 Apr 2008 00:27:56 +0200
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6 v2] MIPS: ip27-timer: unsigned irq to evaluate allocate_irqno()
Message-ID: <20080416222755.GA18832@alpha.franken.de>
References: <480559DC.2060807@tiscali.nl> <20080416091554.GA6026@alpha.franken.de> <480616C6.3080203@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480616C6.3080203@tiscali.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 05:09:58PM +0200, Roel Kluin wrote:
> Thomas Bogendoerfer wrote:
> > On Wed, Apr 16, 2008 at 03:43:56AM +0200, Roel Kluin wrote:
> >> irq is unsigned, cast to signed to evaluate the allocate_irqno() return value,
>  
> >> +		if ((int) irq < 0)
> > 
> > Why don't you just make irq and rt_timer_irq an int ?
> 
> Ok, thanks, It should be right, but I cannot test this (no hardware).

I've tested it on real hardware.

Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
