Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 10:01:51 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:31157 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20027009AbXK2KBV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2007 10:01:21 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IxgCs-00038t-02; Thu, 29 Nov 2007 11:01:18 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 00313C2B3D; Thu, 29 Nov 2007 11:01:01 +0100 (CET)
Date:	Thu, 29 Nov 2007 11:01:01 +0100
To:	peter fuerst <post@pfrst.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28 support
Message-ID: <20071129100101.GB9106@alpha.franken.de>
References: <20071126224004.D885AC2B26@solo.franken.de> <Pine.LNX.4.58.0711280206450.407@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0711280206450.407@Indigo2.Peter>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Nov 28, 2007 at 02:33:37AM +0100, peter fuerst wrote:
> unfortunately a little change to ip28_be_interrupt is needed (sorry, that
> it was not yet applied):

no problem, I've integrated it in the updated IP28 patch. I also
killed the second check for gio_err_stat a few line below, because
isn't usefull any longer.

Thoms.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
