Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 18:37:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49533 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992938AbcGHQgyDx0-f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 18:36:54 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8D38CD546A016;
        Fri,  8 Jul 2016 17:36:34 +0100 (IST)
Received: from [10.20.78.32] (10.20.78.32) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 8 Jul 2016
 17:36:36 +0100
Date:   Fri, 8 Jul 2016 17:36:26 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Faraz Shahbazker <faraz.shahbazker@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>
Subject: Re: [PATCH v5 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
In-Reply-To: <20160708100620.4754-3-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1607081655580.4076@tp.orcam.me.uk>
References: <20160708100620.4754-1-paul.burton@imgtec.com> <20160708100620.4754-3-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.32]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54273
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

Paul,

 You wrote:

> Current MIPS toolchains do not produce the PT_GNU_STACK header, which
> means that we can rely upon this patch not changing the behaviour of
> existing binaries. The new default will only take effect for newly
> compiled binaries once toolchains are updated to support PT_GNU_STACK,
> and since those binaries are newly compiled they can be compiled
> expecting the change in default behaviour. Again this matches the way in
> which the ARM & x86 architectures handled their implementations of
> non-executable memory.

however IIUC this is inaccurate to say the least I'm afraid, as generic 
PT_GNU_STACK support went in to binutils with:

commit 04c3a75556c018feb1f609404c627414a7ef672e
Author: Nathan Sidwell <nathan@codesourcery.com>
Date:   Tue Oct 23 09:33:56 2012 +0000

<https://sourceware.org/ml/binutils/2012-10/msg00317.html>, ("cleanup 
PT_GNU_STACK size handling"), replacing an earlier target-specific 
implementation previously present, and the MIPS port specifically has been 
updated to actually report this at the EI_ABIVERSION offset of the 
`e_ident' array of the ELF header with commit 17733f5be961 ("Increment the 
ABIVERSION to 5 for MIPS objects with non-executable stacks."), earlier 
this year (it's not clear to me offhand why we need to do this rather than 
relying on the lone presence of PT_GNU_STACK, but I'm sure someone will 
enlighten me).  By the time this kernel update hits the street I expect 
we'll have this feature present in a proper binutils release even as 2.27 
is currently being rolled out already.

 Have I missed anything?

  Maciej
