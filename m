Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:25:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48592 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993973AbdF1PZiSnBG8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:25:38 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5SFPZeO005678;
        Wed, 28 Jun 2017 17:25:35 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5SFPZdE005677;
        Wed, 28 Jun 2017 17:25:35 +0200
Date:   Wed, 28 Jun 2017 17:25:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/6] MIPS: tlbex: Use ErrorEPC as scratch when KScratch
 isn't available
Message-ID: <20170628152535.GA2698@linux-mips.org>
References: <20170602223806.5078-1-paul.burton@imgtec.com>
 <20170602223806.5078-6-paul.burton@imgtec.com>
 <alpine.DEB.2.00.1706151806310.23046@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1706151806310.23046@tp.orcam.me.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Jun 15, 2017 at 06:27:34PM +0100, Maciej W. Rozycki wrote:

> > This patch changes this such that when KScratch registers aren't
> > implemented we use the coprocessor 0 ErrorEPC register as scratch
> > instead. The only downside to this is that we will need to ensure that
> > TLB exceptions don't occur whilst handling error exceptions, or at least
> > before the handlers for such exceptions have read the ErrorEPC register.
> > As the kernel always runs unmapped, or using a wired TLB entry for
> > certain SGI ip27 configurations, this constraint is currently always
> > satisfied. In the future should the kernel become mapped we will need to
> > cover exception handling code with a wired entry anyway such that TLB
> > exception handlers don't themselves trigger TLB exceptions, so the
> > constraint should be satisfied there too.
> 
>  All error exception handlers run from (C)KSEG1 and with (X)KUSEG forcibly 
> unmapped, so a TLB exception could only ever happen with an access to the 
> kernel stack or static data located in (C)KSEG2 or XKSEG.  I think this 
> can be easily avoided, and actually should, to avoid cascading errors.
> 
>  Isn't the reverse a problem though, i.e. getting an error exception while 
> running a TLB exception handler and consequently getting the value stashed 
> in CP0.ErrorEPC clobbered?  Or do we assume all error exceptions are fatal 
> and the kernel shall panic without ever getting back?

Think of cache error exceptions for example.  Not all systems are as
bad as Pass 1 BCM1250 parts which were spewing like a few a day.  Without
going into hardware implementation details - memory parity or ECC errors
are on many systems are signaled as cache errors, thus clobering c0_errorepc.

So I think while it's a nice hack I think this patch should be reserved
for system that don't support parity or ECC or where generally a tiny bit
of performance is more important that reliability.

  Ralf
