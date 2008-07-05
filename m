Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2008 09:32:03 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:62957 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28589888AbYGEIb5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2008 09:31:57 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KF3BT-0004Uh-00; Sat, 05 Jul 2008 10:31:55 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 6822AC2E7E; Sat,  5 Jul 2008 10:04:14 +0200 (CEST)
Date:	Sat, 5 Jul 2008 10:04:14 +0200
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SGI O2 sound driver v6
Message-ID: <20080705080414.GA4989@alpha.franken.de>
References: <20080628000916.GA22049@alpha.franken.de> <20080628141336.GA17727@alpha.franken.de> <20080628224553.GA2064@alpha.franken.de> <20080629223537.GA697@alpha.franken.de> <20080702232118.GB18226@alpha.franken.de> <20080704225106.GA7408@alpha.franken.de> <20080705070410.GA7384@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080705070410.GA7384@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sat, Jul 05, 2008 at 10:04:10AM +0300, Martin Michlmayr wrote:
> * Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-07-05 00:51]:
> > --- /dev/null
> > +++ b/drivers/input/misc/sgio2_btns.c
> > @@ -0,0 +1,154 @@
> > +/*
> > + *  Cobalt button interface driver.
> 
> You should update that text.

of course. I noticed it, while preparing the patch for maintainer submission
and fixed it. Thanks for noticing.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
