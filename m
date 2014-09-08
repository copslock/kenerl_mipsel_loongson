Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2014 21:29:53 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:46702 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008367AbaIHT3wIyJct (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Sep 2014 21:29:52 +0200
Received: by mail-ob0-f178.google.com with SMTP id uy5so11048175obc.37
        for <linux-mips@linux-mips.org>; Mon, 08 Sep 2014 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dnl+04SnJWJy2bF7FdrsKG/BsFoZ/9sGUuyQ9sTx3JQ=;
        b=fK5LIYl/UAOiOUVNJqSujWUAqHW0m6X4ZkBXcCqRreDfFpspBsou3AJXNsC6xMBQRM
         qb8QDQIHH9JTLgYWodeF2vYGfQkSRPAGsigqo8BIjdqv0O0R/EP9ukrz8TI6bTRElRCi
         ZC4TC9Z3z5M7htcyrYYOFdh33NzEj4K5f9gzBiLML8w1t8BZa85nq64XMnKp9BmyFqNl
         kclR3ZEm1/yLsjl5ptgxBh5P4hnPazmXpv+MQTI4b6FRNnZjy3hT2pcOTmlIMSDsAAeu
         rKqOb1+1+VmgP+zlJKxBPbFyr/OTPUEvMkyEhq6riIlEURmMDLOb6DohwaMOTDeFIQvc
         CmoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dnl+04SnJWJy2bF7FdrsKG/BsFoZ/9sGUuyQ9sTx3JQ=;
        b=SPr37pPF6Y3/4gWv56yliykDMhVMJRJZ0g4eK23gsyv+Fp/5qTSxpgRB7NygBAjpQ3
         Rf2w0voJ2reefnut1ckZ80qjX8Dqcsaq/DmDywst6Jy3CoA+L+6voOEJ9WYnV5Mpe9V0
         mFSpKNy8jcuo1nOKpy8h9FFE0+kEkq+MePUvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dnl+04SnJWJy2bF7FdrsKG/BsFoZ/9sGUuyQ9sTx3JQ=;
        b=DAbx5gO31eWTg7vhM3GFv8fMG15W3+SMEOq+KvmOYzRH7H2NkPby/8f3npuDvn35oU
         eUy15DLcun8XjGPKWzLhZw2uilsGfL8Lz402NW36LjPIfDDFA8E6ZGxNeVQOF42BtBA5
         iJ9K4ZGnNKOgzYtlBf1qVd16zsR6chFQpAXpQQ9lPiaz/8bh0m33C1yrZy4u4qaaVTxD
         6x3sdAUgetyVazzDnWo6cf32W6mL9yyfjZ/gVD6h6uAnJlNxbFOsitXYQU1vu4nw2ijk
         58pY1vDQQ8GePKo9Q1NGj0bg6XaznNdpkLQQNPAwf5a4o0NW2jVdsHfLdSB5AGlaMepN
         BvWg==
X-Gm-Message-State: ALoCoQk6dLnRxr+sxBsg2lBXLGKmRuNkngZukxa01GRZaCNfZPfFNsKsMRgiKVauPNGwsCjyXkF/
MIME-Version: 1.0
X-Received: by 10.182.142.40 with SMTP id rt8mr5389658obb.80.1410204585770;
 Mon, 08 Sep 2014 12:29:45 -0700 (PDT)
Received: by 10.182.78.136 with HTTP; Mon, 8 Sep 2014 12:29:45 -0700 (PDT)
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
Date:   Mon, 8 Sep 2014 12:29:45 -0700
X-Google-Sender-Auth: Kqk5mwpmgshdfqL3tE6qvZA3fMM
Message-ID: <CAGXu5jJpxzbpZfxXoBvDm6W-ogq3d5njRa2ir0text3evJT+QQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] x86: two-phase syscall tracing and seccomp fastpath
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42479
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

On Fri, Sep 5, 2014 at 3:13 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> This applies to:
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp-fastpath
>
> Gitweb:
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>
> This is both a cleanup and a speedup.  It reduces overhead due to
> installing a trivial seccomp filter by 87%.  The speedup comes from
> avoiding the full syscall tracing mechanism for filters that don't
> return SECCOMP_RET_TRACE.
>
> This series depends on splitting the seccomp hooks into two phases.
> The first phase evaluates the filter; it can skip syscalls, allow
> them, kill the calling task, or pass a u32 to the second phase.  The
> second phase requires a full tracing context, and it sends ptrace
> events if necessary.  The seccomp core part is in Kees' seccomp/fastpath
> tree.
>
> These patches implement a similar split for the x86 syscall
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
> This passes all seccomp tests that I know of.
>
> Changes from v4:
>  - Rebased (which seems to have been a no-op)
>  - Fixed embarrassing bug that broke allnoconfig
>    (patch 3 was missing an ifdef).
>
> Changes from v3:
>  - Dropped the core seccomp changes from the email -- Kees has applied them.
>  - Add patch 2 (the TIF_NOHZ change).
>  - Fix TIF_NOHZ in the two-phase entry code (thanks, Oleg).
>
> Changes from v2:
>  - Fixed 32-bit x86 build (and the tests pass).
>  - Put the doc patch where it belongs.
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
> Andy Lutomirski (5):
>   x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
>   x86,entry: Only call user_exit if TIF_NOHZ
>   x86: Split syscall_trace_enter into two phases
>   x86_64,entry: Treat regs->ax the same in fastpath and slowpath
>     syscalls
>   x86_64,entry: Use split-phase syscall_trace_enter for 64-bit syscalls
>
>  arch/x86/include/asm/calling.h |   6 +-
>  arch/x86/include/asm/ptrace.h  |   5 ++
>  arch/x86/kernel/entry_64.S     |  51 +++++--------
>  arch/x86/kernel/ptrace.c       | 165 +++++++++++++++++++++++++++++++++--------
>  4 files changed, 164 insertions(+), 63 deletions(-)

Consider the series:

Acked-by: Kees Cook <keescook@chromium.org>

As far as doing pulls, Peter, can you take the seccomp change from my
tree as well? It makes sense to land all of this together.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
