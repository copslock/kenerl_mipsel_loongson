Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 21:39:37 +0200 (CEST)
Received: from mail-oa0-f50.google.com ([209.85.219.50]:53140 "EHLO
        mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6863553AbaGVThvZLyEF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 21:37:51 +0200
Received: by mail-oa0-f50.google.com with SMTP id g18so199745oah.37
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zttFYamboyWjkzs6NskMqMAxv0Oc1n0Kc4wKQ/YGWo4=;
        b=JKY1A4cLwDsGRwBMhUeJm5g83INfpy6xhpveLPyCrgw83RzKgpw2dChs7UeYNRcQww
         JOToM6gJJnMFhMFifBOf1U5rgxweNsOJD7JV/A9ZiPLNQH4kzZUMkeBSibeacy2vgZa+
         0o4ruwWWqUQXCoFBMRbGDXFzQvXZEnMPC8r1Dx7br/csNcNA/QQMaVDANnrp4+SUk++I
         6O2v+xZnRvRCXgy0Crrax/xGAWfmug/6aPvZSWJQv8mQO5UhXraCD8BAc8BODbj7oReb
         T9GVaNy1j4gPY08DOIf3GsuyXjpvg6uEanPFoNMwoeDCPkgwuCDW368wRqGQvlDVZx8q
         jrPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zttFYamboyWjkzs6NskMqMAxv0Oc1n0Kc4wKQ/YGWo4=;
        b=MBWZIarQeaAMegbp1w0L95VM+hi8VAZ40Zs1+HxrrhyvExgW0q7GlwBBuBEZXWMtMJ
         j4yBp55ZmmAkvu7cARMppyedoZsDduKenJ1sFOHjDzDdEl9dYLc7kL65odwFaqkgrBc8
         qdmhouu+JWYI9jSSk5862562X7IQWPb3hv03U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zttFYamboyWjkzs6NskMqMAxv0Oc1n0Kc4wKQ/YGWo4=;
        b=ggHyu3ub4mrr2bHdtLOFSp2Uvlol9OUREeQz2WBNicEL4OC1wiOwGAjgYpPvp40yeg
         XyEF2mfAE4Is/mB7lYHDgpoy6ILjs01LA78dmdB0BLAfuXJ6ppulEavT+TtDKNVipi6s
         3x4Tnuo8bjFqo4LW2mzE7Ddz79RHogexN7Zz3KJNPEgNKr0fS/t7PJPHwlZytrm2LXI3
         RB2aUJnGplmlKtGRLWLTR5tQdWK2AtnPU4IuqKm5HDMYHOU72Ba0wc//VXPrVCHVUlM1
         f1svvtWlNO8C07gJi6iOrmKzswR3aWpufQa3Y49K+eZlDo9abjgf2ESQC1wYvc+n915r
         yVUA==
X-Gm-Message-State: ALoCoQmStyRdfvUmdM7y1uiR1BjWGdW+iWKoMojd3iP0gtt+DdmjrgF5eLkkXPSUTUfjrbhPjjsd
MIME-Version: 1.0
X-Received: by 10.60.80.229 with SMTP id u5mr51761151oex.62.1406057865203;
 Tue, 22 Jul 2014 12:37:45 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Tue, 22 Jul 2014 12:37:45 -0700 (PDT)
In-Reply-To: <cover.1405992946.git.luto@amacapital.net>
References: <cover.1405992946.git.luto@amacapital.net>
Date:   Tue, 22 Jul 2014 12:37:45 -0700
X-Google-Sender-Auth: fNCVl91x2h1xy1SJ8D7LTfe-r70
Message-ID: <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Mon, Jul 21, 2014 at 6:49 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> [applies on jmorris's security-next tree]
>
> This is both a cleanup and a speedup.  It reduces overhead due to
> installing a trivial seccomp filter by 87%.  The speedup comes from
> avoiding the full syscall tracing mechanism for filters that don't
> return SECCOMP_RET_TRACE.
>
> This series works by splitting the seccomp hooks into two phases.
> The first phase evaluates the filter; it can skip syscalls, allow
> them, kill the calling task, or pass a u32 to the second phase.  The
> second phase requires a full tracing context, and it sends ptrace
> events if necessary.
>
> Once this is done, I implemented a similar split for the x86 syscall
> entry work.  The C callback is invoked in two phases: the first has
> only a partial frame, and it can request phase 2 processing with a
> full frame.
>
> Finally, I switch the 64-bit system_call code to use the new split
> entry work.  This is a net deletion of assembly code: it replaces
> all of the audit entry muck.
>
> In the process, I fixed some bugs.
>
> If this is acceptable, someone can do the same tweak for the
> ia32entry and entry_32 code.
>
> This passes all seccomp tests that I know of.  Now that it's properly
> rebased, even the previously expected failures are gone.
>
> Kees, if you like this version, can you create a branch with patches
> 1-4?  I think that the rest should go into tip/x86 once everyone's happy
> with it.
>
> Changes from v2:
>  - Fixed 32-bit x86 build (and the tests pass).
>  - Put the doc patch where it belongs.

Thanks! This looks good to me. I'll add it to my tree.

Peter, how do you feel about this series? Do the x86 changes look good to you?

-Kees

>
> Changes from v1:
>  - Rebased on top of Kees' shiny new seccomp tree (no effect on the x86
>    part).
>  - Improved patch 6 vs patch 7 split (thanks Alexei!)
>  - Fixed bogus -ENOSYS in patch 5 (thanks Kees!)
>  - Improved changelog message in patch 6.
>
> Changes from RFC version:
>  - The first three patches are more or less the same
>  - The rest is more or less a rewrite
>
> Andy Lutomirski (8):
>   seccomp,x86,arm,mips,s390: Remove nr parameter from secure_computing
>   seccomp: Refactor the filter callback and the API
>   seccomp: Allow arch code to provide seccomp_data
>   seccomp: Document two-phase seccomp and arch-provided seccomp_data
>   x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
>   x86: Split syscall_trace_enter into two phases
>   x86_64,entry: Treat regs->ax the same in fastpath and slowpath
>     syscalls
>   x86_64,entry: Use split-phase syscall_trace_enter for 64-bit syscalls
>
>  arch/Kconfig                   |  11 ++
>  arch/arm/kernel/ptrace.c       |   7 +-
>  arch/mips/kernel/ptrace.c      |   2 +-
>  arch/s390/kernel/ptrace.c      |   2 +-
>  arch/x86/include/asm/calling.h |   6 +-
>  arch/x86/include/asm/ptrace.h  |   5 +
>  arch/x86/kernel/entry_64.S     |  51 ++++-----
>  arch/x86/kernel/ptrace.c       | 150 +++++++++++++++++++-----
>  arch/x86/kernel/vsyscall_64.c  |   2 +-
>  include/linux/seccomp.h        |  25 ++--
>  kernel/seccomp.c               | 252 ++++++++++++++++++++++++++++-------------
>  11 files changed, 360 insertions(+), 153 deletions(-)
>
> --
> 1.9.3
>



-- 
Kees Cook
Chrome OS Security
