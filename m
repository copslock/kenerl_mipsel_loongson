Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 11:24:08 +0100 (BST)
Received: from p508B66F0.dip.t-dialin.net ([IPv6:::ffff:80.139.102.240]:42292
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224953AbUHWKYD>; Mon, 23 Aug 2004 11:24:03 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7NAO25F019122;
	Mon, 23 Aug 2004 12:24:02 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7NAO2VJ019121;
	Mon, 23 Aug 2004 12:24:02 +0200
Date: Mon, 23 Aug 2004 12:24:02 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040823102402.GC17067@linux-mips.org>
References: <20040820120223Z8225206-1530+8785@linux-mips.org> <Pine.LNX.4.58L.0408231124040.19572@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0408231124040.19572@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2004 at 11:29:46AM +0200, Maciej W. Rozycki wrote:

> > Log message:
> > 	Undo change from rev 1.37; some userspace software is expecting
> > 	PAGE_SIZE, PAGE_SHIFT and PAGE_MASK to be accessible through
> > 	<asm/page.h>.  Sigh ...
> 
>  Fix that software then, instead of breaking good one (hint -- what is the
> "right" value of PAGE_SHIFT and why it doesn't work for that system over
> there?).  With these macros exported it's hard to guess whether the page
> size can be hardcoded or it should get determined at the run time.  And 
> with glibc you get a compilation error due to PAGE_SHIFT being undefined.  
> Please revert the braindamage.

Due to PAGE_SHIFT being undefined?  You meant the opposite?

>  What software is the offender, BTW?

Procps but I have dark memories of other packages doing the same thing, so
I gave up and kludged the thing the same way other architectures do.
Even IA-64 which is suffering the same pains with variable page size.

  Ralf
