Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 14:07:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26553 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024588AbXHXNHW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 14:07:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7OD7Lb9027867;
	Fri, 24 Aug 2007 14:07:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7OD7L0u027866;
	Fri, 24 Aug 2007 14:07:21 +0100
Date:	Fri, 24 Aug 2007 14:07:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6.23-rc3 build error
Message-ID: <20070824130721.GA27604@linux-mips.org>
References: <46CB0876.5030508@gmail.com> <20070824110729.GA4321@linux-mips.org> <46CEC23D.1090706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46CEC23D.1090706@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 24, 2007 at 01:34:21PM +0200, Sunil Amitkumar Janki wrote:

> >>>ERROR: "__cmpdi2" [drivers/md/dm-snapshot.ko] undefined!
> >>>      
> >
> >The __cmpdi2 one is the interesting one.  Which version of gcc are you
> >using?  And if you still have it, could you send me your .config file?

I've just pushed a fix for the __cmpdi2 problem.  It's a generic MIPS issue
and I didn't invest the time into figuring out what circumstances exactly
are required to trigger it.

The references to request_dma and free_dma are a separate Fulong-specific
issue.  They are the result of platform neither defining GENERIC_ISA_DMA
nor GENERIC_ISA_DMA_SUPPORT_BROKEN.  I'm not sure if the Fulong contains
ISA-ish peripherals in its south bridge which are actually being used.
Maybe else knows?

  Ralf
