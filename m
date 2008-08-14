Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2008 07:51:25 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:30404 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20031493AbYHNGvR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2008 07:51:17 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KTWfz-0000Rj-00; Thu, 14 Aug 2008 08:51:15 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 706FCC316C; Thu, 14 Aug 2008 08:37:51 +0200 (CEST)
Date:	Thu, 14 Aug 2008 08:37:51 +0200
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: "indy_volume_button" [sound/oss/hal2.ko] undefined
Message-ID: <20080814063751.GA5572@alpha.franken.de>
References: <20080813125954.GA3203@deprecation.cyrius.com> <20080813205836.GA10796@alpha.franken.de> <20080814054153.GA2546@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080814054153.GA2546@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Aug 14, 2008 at 08:41:53AM +0300, Martin Michlmayr wrote:
> Well, it got broken by your ALSA related changes.

I consider it semantically broken before I even touched it.

> Anyway, I'm all for removing it, but it should happen before 2.6.27 is
> out so there's no regression.

I'll send a remove path later. The second option would be to just
remove the indy_volume_button code from the OSS driver.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
