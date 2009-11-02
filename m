Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 08:16:03 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34616 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492732AbZKBHQA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 08:16:00 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA27HPkU014921;
	Mon, 2 Nov 2009 08:17:25 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA27HOeZ014919;
	Mon, 2 Nov 2009 08:17:24 +0100
Date:	Mon, 2 Nov 2009 08:17:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	loody <miloody@gmail.com>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: why we use multu to implement udelay
Message-ID: <20091102071724.GB13360@linux-mips.org>
References: <3a665c760911010618u7216cd68wfbd02610d2029862@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a665c760911010618u7216cd68wfbd02610d2029862@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 01, 2009 at 10:18:14PM +0800, loody wrote:

> If I search the right place in mip kernel, I find the kernel implement
> udelay by multu and bnez looping, in 32-bits mode.
> 	if (sizeof(long) == 4)
> 		__asm__("multu\t%2, %3"
> 		: "=h" (usecs), "=l" (lo)
> 		: "r" (usecs), "r" (lpj)
> 		: GCC_REG_ACCUM);
> 	else if (sizeof(long) == 8)
> 		__asm__("dmultu\t%2, %3"
> 		: "=h" (usecs), "=l" (lo)
> 		: "r" (usecs), "r" (lpj)
> 		: GCC_REG_ACCUM);
> 
> 	__delay(usecs);
> why we doing so instead of using kernel timer function and the
> precision will be incorrect if the cpu runs faster or slower, right?

This is an old-fashioned implementation which will work even on systems
where no CPU timer is available or its frequency is unknown or variable.

A while ago patches were posted to use the cp0 counter instead but do
to other necessary rewrites those patches went stale, so need to be
reworked before they can be applied.  Either way, for above restrictions
the delay by looping implementation will still be needed as the fallback
implementation.

  Ralf
