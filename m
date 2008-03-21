Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 23:04:54 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:37791 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28578781AbYCUXEw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2008 23:04:52 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JcqI7-0002en-00; Sat, 22 Mar 2008 00:04:51 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 64B93C2DFD; Sat, 22 Mar 2008 00:04:24 +0100 (CET)
Date:	Sat, 22 Mar 2008 00:04:24 +0100
To:	peter fuerst <post@pfrst.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] WD33C93: let platform stub override no_sync/fast/dma_mode
Message-ID: <20080321230424.GA31455@alpha.franken.de>
References: <20080321212543.6F769C2DF8@solo.franken.de> <Pine.LNX.4.58.0803212302190.564@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0803212302190.564@Indigo2.Peter>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Mar 21, 2008 at 11:20:07PM +0100, peter fuerst wrote:
> 
> the code-sequence
> 
> 	wd33c93_init(...
> 	if (hdata->wh.no_sync == 0xff)
> 		hdata->wh.no_sync = 0;
> 
> was put/kept there intentionally - in this very order - to enable
> "nosync" from the command-line!

this hack is IMHO no longer needed. If the user wants to override no_sync
via kernel command line, it works as before. If the user doesn't no_sync
will be 0 (now set in sgiwd93.c before calling wd33c93_init()) and the
driver will try to do sync transfers for all devices. It works like before.
Or did I miss something ?

Thomas

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
