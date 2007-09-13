Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 12:29:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50368 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021738AbXIML30 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 12:29:26 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DBTPlT032083;
	Thu, 13 Sep 2007 12:29:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DBTNb1032082;
	Thu, 13 Sep 2007 12:29:23 +0100
Date:	Thu, 13 Sep 2007 12:29:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add #include <linux/profile.h> to
	arch/mips/kernel/time.c
Message-ID: <20070913112923.GA31940@linux-mips.org>
References: <20070912232333.22c4f7bb.yoichi_yuasa@tripeaks.co.jp> <20070913.003319.41011558.anemo@mba.ocn.ne.jp> <200709130204.l8D244XV029841@po-mbox300.hop.2iij.net> <20070913.112917.76463355.nemoto@toshiba-tops.co.jp> <200709130413.l8D4DS73011392@po-mbox301.hop.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709130413.l8D4DS73011392@po-mbox301.hop.2iij.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 01:13:28PM +0900, Yoichi Yuasa wrote:

> > linux/arch/mips/kernel/time.c:142: error: implicit declaration of function 'profile_tick'
> > 
> > Proper fix would be including profile.h from time.c, but this is
> > irrelevant to i8259, so should be a separate patch.
> 
> I found a patch for it in my patch queue.
>  
> > Other parts looks good to me.  Thanks.
> 
> Add #include <linux/profile.h> to arch/mips/kernel/time.c
> It refer to CPU_PROFILING.
> 
> arch/mips/kernel/time.c: In function 'local_timer_interrupt':
> arch/mips/kernel/time.c:142: error: implicit declaration of function 'profile_tick'
> arch/mips/kernel/time.c:142: error: 'CPU_PROFILING' undeclared (first use in this function)
> arch/mips/kernel/time.c:142: error: (Each undeclared identifier is reported only once
> arch/mips/kernel/time.c:142: error: for each function it appears in.)
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Thanks, applied.

  Ralf
