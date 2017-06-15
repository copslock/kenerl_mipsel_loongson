Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 19:27:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42448 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993887AbdFOR1v1D6li (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2017 19:27:51 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E4C4EFCE3C069;
        Thu, 15 Jun 2017 18:27:40 +0100 (IST)
Received: from [10.20.78.209] (10.20.78.209) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 15 Jun 2017
 18:27:43 +0100
Date:   Thu, 15 Jun 2017 18:27:34 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 5/6] MIPS: tlbex: Use ErrorEPC as scratch when KScratch
 isn't available
In-Reply-To: <20170602223806.5078-6-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1706151806310.23046@tp.orcam.me.uk>
References: <20170602223806.5078-1-paul.burton@imgtec.com> <20170602223806.5078-6-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.209]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 2 Jun 2017, Paul Burton wrote:

> This patch changes this such that when KScratch registers aren't
> implemented we use the coprocessor 0 ErrorEPC register as scratch
> instead. The only downside to this is that we will need to ensure that
> TLB exceptions don't occur whilst handling error exceptions, or at least
> before the handlers for such exceptions have read the ErrorEPC register.
> As the kernel always runs unmapped, or using a wired TLB entry for
> certain SGI ip27 configurations, this constraint is currently always
> satisfied. In the future should the kernel become mapped we will need to
> cover exception handling code with a wired entry anyway such that TLB
> exception handlers don't themselves trigger TLB exceptions, so the
> constraint should be satisfied there too.

 All error exception handlers run from (C)KSEG1 and with (X)KUSEG forcibly 
unmapped, so a TLB exception could only ever happen with an access to the 
kernel stack or static data located in (C)KSEG2 or XKSEG.  I think this 
can be easily avoided, and actually should, to avoid cascading errors.

 Isn't the reverse a problem though, i.e. getting an error exception while 
running a TLB exception handler and consequently getting the value stashed 
in CP0.ErrorEPC clobbered?  Or do we assume all error exceptions are fatal 
and the kernel shall panic without ever getting back?

  Maciej
