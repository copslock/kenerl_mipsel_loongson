Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 23:45:31 +0100 (BST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:54954 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024444AbZERWpY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 23:45:24 +0100
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
	(envelope-from <linville@tuxdriver.com>)
	id 1M6Ba6-0000gX-HF; Mon, 18 May 2009 18:45:14 -0400
Received: from linville-t400.local (linville-t400.local [127.0.0.1])
	by linville-t400.local (8.14.3/8.14.3) with ESMTP id n4IMfSMJ019999;
	Mon, 18 May 2009 18:41:28 -0400
Received: (from linville@localhost)
	by linville-t400.local (8.14.3/8.14.3/Submit) id n4IMfSEt019997;
	Mon, 18 May 2009 18:41:28 -0400
Date:	Mon, 18 May 2009 18:41:28 -0400
From:	"John W. Linville" <linville@tuxdriver.com>
To:	matthieu castet <castet.matthieu@free.fr>
Cc:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
Message-ID: <20090518224128.GA11912@tuxdriver.com>
References: <4A11DCBF.9000700@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A11DCBF.9000700@free.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips

On Tue, May 19, 2009 at 12:10:07AM +0200, matthieu castet wrote:
> Hi,
>
> this patch export ssb_watchdog_timer_set to allow to use it in a Linux  
> watchdog driver.
>
>
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

What is the merge path for ssb nowadays?  I used to take these patches
(and I'm still happy to do so), but maybe Ralf is (or should be)
taking them now?

John
-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
