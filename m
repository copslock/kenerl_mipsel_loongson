Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 10:26:58 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:22478
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225232AbTE0J04>; Tue, 27 May 2003 10:26:56 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4R9QobY023587;
	Tue, 27 May 2003 02:26:50 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4R9QnxQ023586;
	Tue, 27 May 2003 11:26:49 +0200
Date: Tue, 27 May 2003 11:26:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ashish anand <ashish.anand@inspiretech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Any complications of using CONFIG_MIPS_UNCACHED..?
Message-ID: <20030527092649.GB23296@linux-mips.org>
References: <200305210618.h4L6HqI9006634@smtp.inspirtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305210618.h4L6HqI9006634@smtp.inspirtek.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 21, 2003 at 11:16:49AM +0530, Ashish anand wrote:

> I saw a good bit of discussion about CONFIG_MIPS_UNCACHED but
> still i am yet to know...
> 
> If I want to use CONFIG_MIPS_UNCACHED (ignoring performance)
> what all the side-effects and any restrictions that linux should
> take care in software ?
> 
> I observed something surprising on my R4k mips system(virtually indexed
> caches), after i use this option my driver never got status updation by
> device in transmit and receive decriptors in system memory , Irrespective
> of I (flushed+invalidate) caches or not...

Descriptors sounds like networking.  Network descriptors should usually
be stored in uncached or otherwise coherent space that is allocated
through pci_alloc_consistent anyway.  If you do that CONFIG_MIPS_UNCACHED
should not make any difference anymore.

> if i don't use CONFIG_MIPS_UNCACHED then before checking status I need to 
> (flush+invalidate) cache and whole thing works great...

That's a funny bug.  Normally the opposite behaviour would be expected for
a bug ...

  Ralf
