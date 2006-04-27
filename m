Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2006 17:13:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26323 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133753AbWD0QNL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Apr 2006 17:13:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3RGD9eY002432;
	Thu, 27 Apr 2006 17:13:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3RGD9gv002431;
	Thu, 27 Apr 2006 17:13:09 +0100
Date:	Thu, 27 Apr 2006 17:13:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Herbert Valerio Riedel <hvr@hvrlab.org>
Cc:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
Subject: Re: [PATCH] AU1xxxx mips_timer_interrupt() fixes
Message-ID: <20060427161309.GA32029@linux-mips.org>
References: <200604100901.k3A91sXm029832@phobos.hvrlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604100901.k3A91sXm029832@phobos.hvrlab.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@denk.linux-mips.net.mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 12, 2006 at 09:03:08AM +0200, Herbert Valerio Riedel wrote:

> common/au1000/irq.c was missing a mips_timer_interrupt() prototype, whereas
> in common/au1000/time.c the actual mips_timer_interrupt() implementation
> was missing an irq_exit() invocation, causing a preempt_count() leak

mips_timer_interrupt is essentially duplicated code, so this kind of
breakage is entirely avoidable but fixing and all the other time code
braindamage it will be a large project, so I applied this patch to
2.6.16-stable and master.

Thanks,

  Ralf
