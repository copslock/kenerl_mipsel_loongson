Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 12:23:40 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:6875 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20036208AbYBRMXM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 12:23:12 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JR51a-0003Je-01; Mon, 18 Feb 2008 13:23:10 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4511DC2AE2; Mon, 18 Feb 2008 13:23:02 +0100 (CET)
Date:	Mon, 18 Feb 2008 13:23:02 +0100
To:	Adrian Bunk <adrian.bunk@movial.fi>
Cc:	linux-mips@linux-mips.org, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: mips: compile testing of 2.6.25-rc2
Message-ID: <20080218122302.GB13080@alpha.franken.de>
References: <20080218010314.GO1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080218010314.GO1403@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Feb 18, 2008 at 03:03:14AM +0200, Adrian Bunk wrote:
> CONFIG_SGI_IP28
>   CALL    /home/bunk/linux/kernel-2.6/git/linux-2.6/scripts/checksyscalls.sh
> cc1: error: unrecognized command line option "-mr10k-cache-barrier=1"
> 
> I tried with a plain gcc 4.2.3, and grep'ed in the gcc SVN head.
> I don't know which special gcc versions have these options added, but 
> when they are used by the kernel they should also go into upstream gcc.

getting the gcc patches upstream is work in progress. If you only want to
check builds, you could just drop that option. I'll send a ip28 defconfig
later.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
