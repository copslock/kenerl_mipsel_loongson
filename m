Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 12:55:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16993 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992111AbcILKzLMuHC1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2016 12:55:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 59133187EB484;
        Mon, 12 Sep 2016 11:54:51 +0100 (IST)
Received: from [10.20.78.177] (10.20.78.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 12 Sep 2016
 11:54:52 +0100
Date:   Mon, 12 Sep 2016 11:54:37 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
CC:     Faraz Shahbazker <Faraz.Shahbazker@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: RE: [PATCH v5 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
In-Reply-To: <6D39441BF12EF246A7ABCE6654B023537E47FB7A@HHMAIL01.hh.imgtec.org>
Message-ID: <alpine.DEB.2.00.1607261405330.4076@tp.orcam.me.uk>
References: <20160708100620.4754-1-paul.burton@imgtec.com> <20160708100620.4754-3-paul.burton@imgtec.com> <alpine.DEB.2.00.1607081655580.4076@tp.orcam.me.uk> <577FF4A1.5000200@imgtec.com> <alpine.DEB.2.00.1607082025140.4076@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B023537E47FB7A@HHMAIL01.hh.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.177]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55102
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

Matthew,

 I meant to reply sooner, but somehow lost this from my radar.  Given the 
recent failure report from what Debian distribution developers observed: 
<https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=834096> I think the 
design of this feature needs to be reevaluated.

On Mon, 18 Jul 2016, Matthew Fortune wrote:

> Maciej Rozycki <Maciej.Rozycki@imgtec.com> writes:
> > On Fri, 8 Jul 2016, Faraz Shahbazker wrote:
> > 
> > > On 07/08/2016 09:36 AM, Maciej W. Rozycki wrote:
> > > > implementation previously present, and the MIPS port specifically
> > > > has been updated to actually report this at the EI_ABIVERSION offset
> > > > of the `e_ident' array of the ELF header with commit 17733f5be961
> > > > ("Increment the ABIVERSION to 5 for MIPS objects with non-executable
> > > > stacks."), earlier this year (it's not clear to me offhand why we
> > > > need to do this rather than relying on the lone presence of
> > > > PT_GNU_STACK, but I'm sure someone will enlighten me).
> > >
> > > This was simply to be able to check whether the tools support a safe
> > > non-exec stack scheme, before enabling it as a default in the
> > > compiler. Refer to the attached e-mail from Matthew. Neither linker
> > nor compiler patch is upstream.
> > 
> >  Hmm, now I am really confused: what problem are we trying to solve on
> > the toolchain side?
> 
> The problem was that if we just turn on no-exec-stack support in GCC then
> when someone combines that with an older binutils and/or build glibc
> from source (using those tools) then they would get an executable that
> asked for a non-executable stack and the kernel would willingly do so.
> 
> However, this would then crash. So we need a way to prevent the generic
> logic in glibc's build system from creating a no-exec-stack library until
> we have the kernel checks in place in glibc to undo no-exec-stack. This
> then leads to the convoluted system of increased EI_ABIVERSION (or some
> other equally complex plan) to ensure mix-and-match of new and old tools
> glibc and kernel all behave nicely.

 How exactly is this supposed to work?

> >  As I understand the current state of affairs, we have now have a
> > situation where the toolchain may be asked (although it is not on by
> > default) to produce a MIPS PT_GNU_STACK binary, which will be happily
> > executed by the kernel with the execution permission disabled for the
> > stack memory (where supported by hardware, i.e. RIXI), however then it
> > will itself happily try to execute from that stack memory in the FPU
> > emulator.
> > 
> >  So first of all we need to address the problem in the kernel by making
> > the FPU emulator avoid stack execution.  That will fix PT_GNU_STACK
> > support on our target.
> 
> Yes.
> 
> >  Second we want to enforce the non-executable-stack policy in the
> > userland by adding a check early on in glibc startup for a flag, such as
> > in the FLAGS entry of the auxiliary vector, set by a fixed kernel only,
> > telling glibc that the presence of PT_GNU_STACK has been respected by
> > the kernel, and make the startup bail out right away if the flag is not
> > there.
> 
> Yes.
> 
> >  So where does the static linker EI_ABIVERSION update fit here?  What is
> > it needed for?  What have I missed?
> 
> Making sure new GCC + new binutils + old glibc (from source) does not create
> executables that crash. My proposal was to also make sure that a MIPS GCC
> with no-exec-stack support would fail the generic glibc build system test
> for no-exec-stack and instead need a new MIPS specific test so that old
> glibc built from source never ended up with no-exec-stack support for MIPS.

 Please elaborate on what "crash" means here -- what is the reason causing 
a `noexecstack' binary built with new GCC/binutils and old glibc sources 
to crash?  We need to be precise with specifying failure conditions so 
that someone who (for whatever reason) cannot immediately reproduce the 
failure concerned is able to understand what is going on.

> I'd love to simplify all this if for some reason this isn't actually a
> problem. I was trying to stick to the principle of all combinations of old
> and new tools/libraries should just work.

 From my understanding so far the version of binutils does not matter as 
PT_GNU_STACK support has been correct in binutils for the MIPS target 
since the introduction of the feature sometime in the past.  It's only the 
interaction between the kernel and glibc that matters here (the 
interaction with GCC WRT nested function trampolines has been sorted with 
the use of the `.note.GNU-stack' special section, ultimately interpreted 
by the static linker, so it can be moved out of the picture).

 So AFAICT we don't need any change to binutils, and all MIPS binaries 
already in existence which carry a PT_GNU_STACK segment will execute 
correctly with the stack protected on new versions of the Linux kernel 
that have an updated FPU emulator implemented.  So we have no backwards 
compatibility problem.

 What we only want to have is a run-time check in new glibc (`ld.so' and 
static startup), which will ensure a PT_GNU_STACK binary terminates right 
away on old versions of the Linux kernel that require an executable stack 
for the FPU emulator.

 So it looks to me we ought to ditch any EI_ABIVERSION checks related to 
this feature and merely include a piece of code in glibc to verify that 
PT_GNU_STACK has been respected by the kernel.  This might be either 
passive, such as by peeking at a bit in the FLAGS entry of the auxiliary 
vector (which won't have been set by old kernels), or active, by invoking 
a syscall such as prctl(2) (which will return ENOSYS on old kernels), and 
then acting accordingly.

 Have I missed anything?

  Maciej
