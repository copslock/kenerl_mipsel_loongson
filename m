Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2008 23:13:08 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:50078 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28591973AbYGGWNG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2008 23:13:06 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KFyxF-00060g-00; Tue, 08 Jul 2008 00:13:05 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id AE672DE6F3; Tue,  8 Jul 2008 00:13:03 +0200 (CEST)
Date:	Tue, 8 Jul 2008 00:13:03 +0200
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, ths@networkno.de
Subject: Re: Current git broken for R4400 IP22
Message-ID: <20080707221303.GA25880@alpha.franken.de>
References: <20080707214900.GA16143@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080707214900.GA16143@alpha.franken.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Jul 07, 2008 at 11:49:00PM +0200, Thomas Bogendoerfer wrote:
> and the bisect winner is:
> 
> fb2a27e743cd565c25cd896911e494482a8b7251 is first bad commit
> commit fb2a27e743cd565c25cd896911e494482a8b7251
> Author: Thiemo Seufer <ths@networkno.de>
> Date:   Mon Feb 18 19:32:49 2008 +0000
> 
>     [MIPS] Reimplement clear_page/copy_page

reverting this patch brings current git head back to life on that machine.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
