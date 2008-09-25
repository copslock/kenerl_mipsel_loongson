Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 22:34:56 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:7623 "EHLO vs166246.vserver.de")
	by ftp.linux-mips.org with ESMTP id S32729692AbYIYVdV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 22:33:21 +0100
Received: from p5b09e9af.dip.t-dialin.net ([91.9.233.175] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1Kixvw-00044L-F7; Thu, 25 Sep 2008 20:59:32 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
Date:	Thu, 25 Sep 2008 22:59:10 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Aurelien Jarno <aurelien@aurel32.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <48DABBBE.7060201@ru.mvista.com> <48DB84F8.7050806@aurel32.net> <48DBA2AE.8020304@ru.mvista.com>
In-Reply-To: <48DBA2AE.8020304@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809252259.10817.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Thursday 25 September 2008 16:39:42 Sergei Shtylyov wrote:
> Hello.
> 
> Aurelien Jarno wrote:
> 
> >>>This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
> >>>pcibios_plat_dev_init() for the BCM47xx platform.
> 
> >>>It fixes the regression introduced by commit
> >>>aab547ce0d1493d400b6468c521a0137cd8c1edf ("ssb: Add Gigabit Ethernet
> >>>driver").
> 
> >>>Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> >>>Reviewed-by: Michael Buesch <mb@bu3sch.de>
> >>>Signed-off-by: John W. Linville <linville@tuxdriver.com>
> 
> >>   Thanks for addessing my nitpicking (which you could have ignored :-).
> >>   I'm only seeing this patch posted on April 21st before yesterday (and 
> >>receiving no comments) -- probably Aurilen hasn't been persevering 
> >>enough for Ralf to merge it. I've been a victim of Ralf's 
> >>"forgetfullness" as well, so I can sympathise. :-)
> 
> > You probably forget messages like:
> > http://www.linux-mips.org/archives/linux-mips/2008-05/msg00300.html
> > http://www.linux-mips.org/archives/linux-mips/2008-06/msg00128.html
> 
>     Yes, I have overlooked these since they had different subject.
> 
> > and the numerous IRC pings.
> 
>     I've been thru that before. :-)

And one private discussion and the bugzilla entry. ;)

That's why I'm going to submit it to akpm or John, is it's not applied
to the mips tree until October the 5th.

-- 
Greetings Michael.
