Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 18:50:54 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:53509 "EHLO
	hell") by linux-mips.org with ESMTP id <S1122978AbSJOQux>;
	Tue, 15 Oct 2002 18:50:53 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 181Utz-0005XY-00; Tue, 15 Oct 2002 18:50:39 +0200
Date: Tue, 15 Oct 2002 18:50:39 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021015165039.GC21220@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <01fd01c26e1d$add77240$10eca8c0@grendel> <Pine.GSO.3.96.1021015171049.16503A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021015171049.16503A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Tue, Oct 15, 2002 at 05:17:24PM +0200, Maciej W. Rozycki wrote:
> On Mon, 7 Oct 2002, Kevin D. Kissell wrote:
> 
> > That's probably going to be a more reliable design,
> > though I would still consider leaving the TLB refill handler
> > untouched and counting on the fact that k1 must contain
> > a non-lethal EntryLo value on return from the exception.
> 
>  Well, there is a "nop" just before the "eret" in all R4k-style TLB
> exception handlers.  I see no problem to use the slot for explicit
> clobbering of k0 or k1 with a single instruction like "li" or "lui". 

Now that you say it it's pretty obvious...

Thanks,
Johannes
