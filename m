Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 01:47:22 +0000 (GMT)
Received: from p549F5309.dip.t-dialin.net ([84.159.83.9]:40786 "EHLO
	mail.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S3466994AbVLVBrG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Dec 2005 01:47:06 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.4/8.13.1) with ESMTP id jBM1mG9g026011;
	Thu, 22 Dec 2005 02:48:16 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.4/8.13.4/Submit) id jBM1mAZS026009;
	Thu, 22 Dec 2005 02:48:10 +0100
Date:	Thu, 22 Dec 2005 02:48:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix local_irq_save()/local_irq_restore() when CONFIG_CPU_MIPSR2 & CONFIG_IRQ_CPU
Message-ID: <20051222014810.GC1918@linux-mips.org>
References: <1135056739.9874.95.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135056739.9874.95.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 20, 2005 at 06:32:19AM +0100, Maxime Bizon wrote:

> 
> I was unable to get my R4KECr2 board working with CONFIG_CPU_MIPSR2 &
> CONFIG_IRQ_CPU, irq delivery is not working.
> 
> local_irq_restore() logic is to check that "flags" is non zero, and
> enable irq accordingly.
> 
> But "flags" comes directly from di, which according to mips instruction
> set, saves whole status content, not just IE bit.

There are less local_irq_save than local_irq_restore calls, so is the
preferable place for the fix.  Applied,

  Ralf
