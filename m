Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 17:17:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5304 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026298AbXKARRE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 17:17:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA1HGfuH023024;
	Thu, 1 Nov 2007 17:16:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA1HGeYo023023;
	Thu, 1 Nov 2007 17:16:40 GMT
Date:	Thu, 1 Nov 2007 17:16:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Put cast inside macro instead of all the callers
Message-ID: <20071101171640.GA21545@linux-mips.org>
References: <20071031141124.185599da@ripper.onstor.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071031141124.185599da@ripper.onstor.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 31, 2007 at 02:11:24PM -0700, Andrew Sharp wrote:

> Resend: I tried sending this a couple of days ago but haven't seen it.
> Wondering if it got stuck in a spam filter or our lovely exchange
> server or something.

It seems the list's spam filter has developed some appetite for patches,
I'm afraid.  Generally please cc me on patches.

> Since all the callers of the PHYS_TO_XKPHYS macro call with a constant,
> put the cast to LL inside the macro where it really should be rather
> than in all the callers.  This makes macros like PHYS_TO_XKSEG_UNCACHED
> work without gcc whining.
> 
> Hopefully this will apply ok.

I'm afraid, no, the definition of PHYS_TO_XKPHYS did change 3 weeks ago ...

Anyway, I fixed that up and queued it for 2.6.25.

Thanks,

  Ralf
