Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2005 03:25:09 +0000 (GMT)
Received: from wmail06.netvigator.com ([218.102.48.220]:5927 "EHLO
	wmail05dat.netvigator.com") by ftp.linux-mips.org with ESMTP
	id S8134462AbVKWDYv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Nov 2005 03:24:51 +0000
Received: from cohut.net ([203.218.199.245]) by wmail05dat.netvigator.com
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123032723.LTVY722.wmail05dat.netvigator.com@cohut.net>
          for <linux-mips@linux-mips.org>; Wed, 23 Nov 2005 11:27:23 +0800
Received: from cohut.net (localhost.localdomain [127.0.0.1])
	by cohut.net (8.13.4/8.13.4) with ESMTP id jAN3RI3G031734
	for <linux-mips@linux-mips.org>; Wed, 23 Nov 2005 11:27:18 +0800
Received: (from fung@localhost)
	by cohut.net (8.13.4/8.13.1/Submit) id jAN3RIIO031731
	for linux-mips@linux-mips.org; Wed, 23 Nov 2005 11:27:18 +0800
Date:	Wed, 23 Nov 2005 11:27:13 +0800
From:	Co Ngai Fung <fung@cohut.net>
To:	linux-mips@linux-mips.org
Subject: Timer interrupt handler problem
Message-ID: <20051123032713.GA31683@pig.cohut.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <fung@cohut.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fung@cohut.net
Precedence: bulk
X-list: linux-mips

Hi,

I want to use the timer16, I can control the timer with the
timer16_ctl(), but the prolem is that when the timer countdown
to zero, I can't use the interrupt handler to get this event,
i have the following code for setup the interrupt handler.

	request_irq(SYS_TIMER_0_IRQ, timer_timeout_intr,
        SA_INTERRUPT, "AC49X timer", NULL);

where the AC49X_SYS_TIMER_0_IRQ is 5, and timer_timeout_intr()
is just a function to printk a line out.
I want to know is just that simple to call request_irq() to
have the interrupt handler be called when the interrupt is issued?

Thanks!
Co Ngai Fung

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
living is easy with eyes closed,
misunderstanding all you see.
- strawberry fields forever
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
