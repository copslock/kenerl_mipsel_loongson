Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 10:06:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13854 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815921AbaGDIGuqrvx4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 10:06:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A31FDEE8CC9D9;
        Fri,  4 Jul 2014 09:06:41 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.10.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 4 Jul
 2014 09:06:43 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.10.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 09:06:43 +0100
Received: from localhost (192.168.79.111) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 4 Jul
 2014 09:06:42 +0100
Date:   Fri, 4 Jul 2014 09:06:41 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ed Swierk <eswierk@skyportsystems.com>
CC:     <linux-mips@linux-mips.org>, <ddaney.cavm@gmail.com>,
        <ralf@linux-mips.org>
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay
 slots
Message-ID: <20140704080641.GY804@pburton-laptop>
References: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.79.111]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Thu, Jul 03, 2014 at 03:31:48PM -0700, Ed Swierk wrote:
> On Thu, Jul 3, 2014 at 1:12 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> > On Thu, Jul 03, 2014 at 10:56:10AM -0700, Ed Swierk wrote:
> >> Now that Linux makes user stacks
> >> non-executable by default, the current FP emulation approach is simply
> >> broken.
> >
> > Really? I wasn't aware of any change to the default attributes of the
> > stack. Do you know what changed? From a quick look at fs/binfmt_elf.c &
> > arch/mips/include/asm/elf.h I can't see anything relevant having
> > changed - the stack should be executable unless a non-executable
> > PT_GNU_STACK header is present in the ELF. I don't suppose the issue
> > is simply that such a PT_GNU_STACK header is present in your binaries?
> 
> Actually that was a completely unsupported assertion on my part. I
> have no reason to believe there was a change in behavior in the kernel
> or the toolchain (gcc 4.9.0, x86_64 host, mips target; binutils
> 2.24.51.20140425).
> 
> What I do notice is that mips-linux-gnu-gcc generates no
> .note.GNU-stack section, while x86_64-linux-gnu-gcc does. In turn, ld
> produces no GNU_STACK program header on the mips executable, while for
> x86_64 it produces GNU_STACK with RW (no E) flags.
> 
> The toolchain behavior is the same for gccgo as for gcc. But I get a
> segv on the Octeon2 target only when running a gccgo-generated
> executable. A C program compiled with gcc works fine performing the
> same FP operations.
> 
> And when I add the following hack to mips/include/asm/elf.h in the
> kernel, the segv goes away:
> 
>    #define elf_read_implies_exec(ex, have_pt_gnu_stack) 1
> 
> So I assume gccgo or libgo is doing some extra magic that makes the
> stack non-executable on mips at least.

Ah, interesting :)

I haven't tried running any go executables before but that and rust are
2 languages I've been curious about for a while.

> >> I'm wondering if instead of trying to free the page
> >> for the FP branch delay emuframe immediately, it would be simpler to
> >> leave it around until the thread is destroyed.
> >
> > It's not really an issue of freeing a page - my patch mapped one page
> > per-mm (per-process) and that page was left intact for the life of that
> > mm (process).
> 
> Ah, I see. What if we allocate a page per thread rather than per
> process? Then the bookkeeping becomes a lot simpler, as there can be
> only a single emuframe in the page at one time. And we can defer
> freeing the page until the thread exits.
> 
> Assuming we could tolerate the overhead of an entire page for a puny
> little emuframe, do you think the approach would work?

Yes, I think it would. The reason I went with the per-mm approach though
was to try to avoid so much overhead. I suppose we could possibly
allocate the page on demand so that threads which don't use FP don't pay
for it, and maybe use the shrinker interface to free the page if we run
low on memory and aren't currently executing from it. Though it would
mean that the FP branch delay "emulation" could fail if memory is tight,
but I suppose that's no worse than now where it could blow the (user)
stack.

I'll try to get a v3 out at some point soon.

Paul
