Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 19:11:06 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:29905 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027233AbXFGSLD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 19:11:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57I44vN005341;
	Thu, 7 Jun 2007 19:04:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57I44eA005340;
	Thu, 7 Jun 2007 19:04:04 +0100
Date:	Thu, 7 Jun 2007 19:04:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] DECstation: Optimised early printk()
Message-ID: <20070607180404.GA3285@linux-mips.org>
References: <Pine.LNX.4.64N.0706051128210.15653@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0706051128210.15653@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 05, 2007 at 11:45:07AM +0100, Maciej W. Rozycki wrote:

>  This is an optimised implementation of early printk() for the DECstation.  
> After the recent conversion to a MIPS-specific generic routine using a 
> character-by-character output the performance dropped significantly.  
> This change reverts to the previous speed -- even at 9600 bps of the 
> serial console the difference is visible with a naked eye; I presume for a 
> framebuffer it is even worse (it may depend on exactly which one is used 
> though).
> 
>  Additionally the change includes a fix for a problem that the old 
> implementation had -- the format used would not actually limit the length 
> of the string output.  This new implementation uses a local buffer to deal 
> with it -- even with this additional copying it is much faster than the 
> generic function.
> 
>  Plus this driver is registered much earlier than the generic one, 
> allowing one to see critical messages, such as one about an incorrect CPU 
> setting used, that are produced beforehand. :-)

Queued up for 2.6.23, too.

>  As a side note, the SYS_HAS_EARLY_PRINTK option could probably be called 
> SYS_HAS_GENERIC_EARLY_PRINTK or something...

I take a patch to rename this :-)

  Ralf
