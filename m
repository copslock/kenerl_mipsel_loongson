Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 22:14:18 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:15253 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20031696AbYELVOQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 22:14:16 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JvfLW-00023Z-00; Mon, 12 May 2008 23:14:10 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4E750DE534; Mon, 12 May 2008 23:12:09 +0200 (CEST)
Date:	Mon, 12 May 2008 23:12:09 +0200
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: sb1-bcm91250a build error
Message-ID: <20080512211209.GA30922@alpha.franken.de>
References: <20080512173907.GA20477@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080512173907.GA20477@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2008 at 07:39:07PM +0200, Martin Michlmayr wrote:
> I get the following build error on sb1-bcm91250a with 2.6.26-rc1 (did
> I mention that -Werror by default is a really bad idea?):
> 
> cc1: warnings being treated as errors
> arch/mips/kernel/traps.c: In function ???show_raw_backtrace???:
> arch/mips/kernel/traps.c:92: warning: cast from pointer to integer of different size
> make[5]: *** [arch/mips/kernel/traps.o] Error 1

known issues for any 64bit kernel. I've posted a patch and updated patch
to fix that.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
