Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 11:15:29 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:32266 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133449AbVJCKKl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 11:10:41 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j93AA4MY001842;
	Mon, 3 Oct 2005 11:10:08 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8UMJ9dV014514;
	Fri, 30 Sep 2005 23:19:09 +0100
Date:	Fri, 30 Sep 2005 23:19:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	kbaidarov <kbaidarov@dev.rtsoft.ru>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] db1550: useless memset() call
Message-ID: <20050930221909.GA14463@linux-mips.org>
References: <43329632.8070400@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43329632.8070400@dev.rtsoft.ru>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 22, 2005 at 03:32:02PM +0400, kbaidarov wrote:

> I've try kernel without memset() on the board - is ok, board boot.
> All drivers works fine. Than I grep the kernel sources:
> 
> [root@windmill linux]# grep -nri "memset(irq_desc" arch/
> arch/mips/au1000/common/irq.c:449:      memset(irq_desc, 0, 
> sizeof(irq_desc));
> arch/mips/ite-boards/generic/irq.c:184:        memset(irq_desc, 0, 
> sizeof(irq_desc));
> [root@windmill linux]#
> 
> Only 2 matches! Does we needs memset() at all?
> And if some one try to initialize irq_desc from start_kernel() before 
> arch_init_irq() call, then following arch_init_irq() call discard all that 
> initialization.

Exactly, so the initialization is wrong, so I'm removing both calls.

Thanks,

  Ralf
