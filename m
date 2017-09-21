Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2017 21:49:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44761 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994763AbdIUTtA0Ef6M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2017 21:49:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTP id E3EA6F7FECB53;
        Thu, 21 Sep 2017 20:48:49 +0100 (IST)
Received: from [10.20.78.62] (10.20.78.62) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Thu, 21 Sep 2017
 20:48:53 +0100
Date:   Thu, 21 Sep 2017 20:48:42 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Fredrik Noring <noring@nocrew.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <6075527.JN7xhOrQ8g@np-p-burton>
Message-ID: <alpine.DEB.2.00.1709212037100.16752@tp.orcam.me.uk>
References: <20170911151737.GA2265@localhost.localdomain> <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <6075527.JN7xhOrQ8g@np-p-burton>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60103
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

Hi Paul,

> >  Virtually all 64-bit MIPS processors have the CP0.Status.UX bit, which
> > the Linux kernel keeps clear for o32 processes (CP0.Status.PX is currently
> > unsupported and is kept clear as well), which means that an attempt to use
> > any instruction that affects register bits beyond bit #31 will cause a
> > Reserved Instruction exception, and in turn SIGILL being sent to the
> > program.
> 
> This isn't actually true - we currently set ST0_UX unconditionally if the 
> kernel is built with CONFIG_64BIT=y. It doesn't matter whether a user program 
> is MIPS32 or MIPS64 code, it always runs with UX=1. We also always save all 64 
> bits of each GPR - not just the least significant 32 bits when running an o32 
> program.

 I referred to plain 32-bit kernels (which I do acknowledge that I failed 
to communicate clearly, sorry), which is what we currently have under 
consideration (given the inability to support the generic case of an n64 
binary with the address space limitation of the R5900 processor), and 
these do keep CP0.Status.UX clear and thus the rest of your observation is 
irrelevant (though it will be once we get to 64-bit support).

 One aspect of the limitation is the R5900 does not support the XTLB 
refill handler or the CP0 XContext register, so once we get to supporting 
64-bit operation we'll have to maintain the TLB with the TLB refill 
handler and the CP0 Context register, which we currently don't with 64-bit 
kernels.

  Maciej
