Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 19:05:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:32935 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023738AbXIRSFX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Sep 2007 19:05:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8II5Mg4019329;
	Tue, 18 Sep 2007 19:05:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8II5M7m019328;
	Tue, 18 Sep 2007 19:05:22 +0100
Date:	Tue, 18 Sep 2007 19:05:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] kernel/process.c: R3000 setup for kernel_thread()
Message-ID: <20070918180521.GA16191@linux-mips.org>
References: <Pine.LNX.4.64N.0709181834420.18665@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0709181834420.18665@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 18, 2007 at 06:49:08PM +0100, Maciej W. Rozycki wrote:

>  Match the R4000 semantics for the initial state of interrupt/kernel
> status register flags for the R3000 in kernel_thread().
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  The R4000 variation preserves the interrupt/kernel status flags; the 
> R3000 assumes a certain state.  It may not matter, at least at the current 
> state of the code, but for consistency I think the R3000 variation should 
> do the same as the R4000 one, first for purity and second because there is 
> less maintenance force available for the R3000 and any discrepancy between 
> the two variations means a greater chance for subtle bugs.  The 
> performance hit is negligible.

Since it doesn't seem to bite I queued this for 2.6.24.  Thanks,

  Ralf
