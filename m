Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 14:24:05 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:51660 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021610AbZESNX6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 14:23:58 +0100
Received: by vs166246.vserver.de with esmtpa (Exim 4.63)
	id 1M6PIT-0002zK-Jk; Tue, 19 May 2009 13:23:57 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
Date:	Tue, 19 May 2009 15:22:40 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
References: <4A11DCBF.9000700@free.fr>
In-Reply-To: <4A11DCBF.9000700@free.fr>
X-Move-Along: Nothing to see here. No, really... Nothing.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905191522.40519.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Tuesday 19 May 2009 00:10:07 matthieu castet wrote:
> Hi,
> 
> this patch export ssb_watchdog_timer_set to allow to use it in a Linux 
> watchdog driver.
> 
> 
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

Well, you need to be careful. The watchdog is also used for system reboot.
Make sure to disable the watchdog driver when the bcm47xx system code wants
to use it.

Otherwise, ack. You can submit this to linville@tuxdriver.com.

-- 
Greetings, Michael.
