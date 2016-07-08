Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 21:53:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26063 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992617AbcGHTxtipiUU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 21:53:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 814FC2602D074;
        Fri,  8 Jul 2016 20:53:39 +0100 (IST)
Received: from [10.20.78.32] (10.20.78.32) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 8 Jul 2016
 20:53:42 +0100
Date:   Fri, 8 Jul 2016 20:53:29 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Faraz Shahbazker <faraz.shahbazker@imgtec.com>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>
Subject: Re: [PATCH v5 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
In-Reply-To: <577FF4A1.5000200@imgtec.com>
Message-ID: <alpine.DEB.2.00.1607082025140.4076@tp.orcam.me.uk>
References: <20160708100620.4754-1-paul.burton@imgtec.com> <20160708100620.4754-3-paul.burton@imgtec.com> <alpine.DEB.2.00.1607081655580.4076@tp.orcam.me.uk> <577FF4A1.5000200@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.32]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54274
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

On Fri, 8 Jul 2016, Faraz Shahbazker wrote:

> On 07/08/2016 09:36 AM, Maciej W. Rozycki wrote:
> > implementation previously present, and the MIPS port specifically has been 
> > updated to actually report this at the EI_ABIVERSION offset of the 
> > `e_ident' array of the ELF header with commit 17733f5be961 ("Increment the 
> > ABIVERSION to 5 for MIPS objects with non-executable stacks."), earlier 
> > this year (it's not clear to me offhand why we need to do this rather than 
> > relying on the lone presence of PT_GNU_STACK, but I'm sure someone will 
> > enlighten me).
> 
> This was simply to be able to check whether the tools support a safe non-exec
> stack scheme, before enabling it as a default in the compiler. Refer to the
> attached e-mail from Matthew. Neither linker nor compiler patch is upstream.

 Hmm, now I am really confused: what problem are we trying to solve on the 
toolchain side?

 As I understand the current state of affairs, we have now have a 
situation where the toolchain may be asked (although it is not on by 
default) to produce a MIPS PT_GNU_STACK binary, which will be happily 
executed by the kernel with the execution permission disabled for the 
stack memory (where supported by hardware, i.e. RIXI), however then it 
will itself happily try to execute from that stack memory in the FPU 
emulator.

 So first of all we need to address the problem in the kernel by making 
the FPU emulator avoid stack execution.  That will fix PT_GNU_STACK 
support on our target.

 Second we want to enforce the non-executable-stack policy in the userland 
by adding a check early on in glibc startup for a flag, such as in the 
FLAGS entry of the auxiliary vector, set by a fixed kernel only, telling 
glibc that the presence of PT_GNU_STACK has been respected by the kernel, 
and make the startup bail out right away if the flag is not there.

 So where does the static linker EI_ABIVERSION update fit here?  What is 
it needed for?  What have I missed?

  Maciej
