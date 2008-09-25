Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 22:34:03 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:13255 "EHLO vs166246.vserver.de")
	by ftp.linux-mips.org with ESMTP id S32729703AbYIYVdX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 22:33:23 +0100
Received: from p5b09e9af.dip.t-dialin.net ([91.9.233.175] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1KixxP-0006A3-Ks; Thu, 25 Sep 2008 21:01:03 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	"John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
Date:	Thu, 25 Sep 2008 23:00:42 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Aurelien Jarno <aurelien@aurel32.net>
References: <48DABBBE.7060201@ru.mvista.com> <48DB6258.8010506@ru.mvista.com> <20080925172429.GB3277@tuxdriver.com>
In-Reply-To: <20080925172429.GB3277@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809252300.42944.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Thursday 25 September 2008 19:24:30 John W. Linville wrote:
> On Thu, Sep 25, 2008 at 02:05:12PM +0400, Sergei Shtylyov wrote:
> > Hello.
> >
> > John W. Linville wrote:
> >
> >> From: Aurelien Jarno <aurelien@aurel32.net>
> >>
> >> This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
> >> pcibios_plat_dev_init() for the BCM47xx platform.
> >>
> >> It fixes the regression introduced by commit
> >> aab547ce0d1493d400b6468c521a0137cd8c1edf ("ssb: Add Gigabit Ethernet
> >> driver").
> >>
> >> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> >> Reviewed-by: Michael Buesch <mb@bu3sch.de>
> >> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> >>   
> >
> >   Thanks for addessing my nitpicking (which you could have ignored :-).
> >   I'm only seeing this patch posted on April 21st before yesterday (and  
> > receiving no comments) -- probably Aurilen hasn't been persevering  
> > enough for Ralf to merge it. I've been a victim of Ralf's  
> > "forgetfullness" as well, so I can sympathise. :-)
> 
> Sergei, I'm sorry if I was rude to you.
> 
> Ralf, given the OpenWRT and SSB connection, I could probably merge
> this series through my tree if you don't want to take it in yours
> for some reason.

Yeah, the regression also made it through your tree, so it's probably
OK to merge the fix through it, too. Let's give 'em another week
and merge it through your tree if it's still not in the mips tree.

-- 
Greetings Michael.
