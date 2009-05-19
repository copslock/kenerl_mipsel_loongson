Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 14:25:46 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:51852 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021610AbZESNZj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 14:25:39 +0100
Received: by vs166246.vserver.de with esmtpa (Exim 4.63)
	id 1M6PK5-0004cO-E9; Tue, 19 May 2009 13:25:37 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	"John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
Date:	Tue, 19 May 2009 15:24:20 +0200
User-Agent: KMail/1.9.9
Cc:	matthieu castet <castet.matthieu@free.fr>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
References: <4A11DCBF.9000700@free.fr> <20090518224128.GA11912@tuxdriver.com>
In-Reply-To: <20090518224128.GA11912@tuxdriver.com>
X-Move-Along: Nothing to see here. No, really... Nothing.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905191524.20421.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Tuesday 19 May 2009 00:41:28 John W. Linville wrote:
> On Tue, May 19, 2009 at 12:10:07AM +0200, matthieu castet wrote:
> > Hi,
> >
> > this patch export ssb_watchdog_timer_set to allow to use it in a Linux  
> > watchdog driver.
> >
> >
> > Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> 
> What is the merge path for ssb nowadays?  I used to take these patches
> (and I'm still happy to do so), but maybe Ralf is (or should be)
> taking them now?

That depends on his speed. Last time I submitted a patch through his path,
it bitrotted for several months before it finally hit mainline.

-- 
Greetings, Michael.
