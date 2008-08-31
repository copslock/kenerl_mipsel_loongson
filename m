Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2008 17:43:11 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:45236 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20033539AbYHaQnH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 Aug 2008 17:43:07 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KZq14-0001X5-00; Sun, 31 Aug 2008 18:43:06 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 3D53BDE3B2; Sun, 31 Aug 2008 18:42:44 +0200 (CEST)
Date:	Sun, 31 Aug 2008 18:42:44 +0200
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] IP22: Fix handling of memory for I2 with more than 256MB
Message-ID: <20080831164244.GA15427@alpha.franken.de>
References: <20080831160954.183A2DE3B2@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080831160954.183A2DE3B2@solo.franken.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Aug 31, 2008 at 06:09:54PM +0200, Thomas Bogendoerfer wrote:
> Indigo2 machines support up to 384MB of memory, but the memory layout
> for IP22 didn't support that and caused a lockup during kernel
> startup. IP22 uses now the default 64bit space setup like most of
> the other machines.

forget that patch. It looks like not all machines are happy with this.
I suspect a problem with some PROMs, but need to investigate further.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
