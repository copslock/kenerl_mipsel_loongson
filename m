Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 03:32:49 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33512 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006947AbaH0BcsmIA03 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 03:32:48 +0200
Received: by mail-lb0-f171.google.com with SMTP id w7so2304619lbi.2
        for <linux-mips@linux-mips.org>; Tue, 26 Aug 2014 18:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=e0i6UK+xVH/2b8s/p/lWxayD4Gf3Ps9NZFdNQnDDnVw=;
        b=c1YAwBG3huwyIvM2QMNjym9epZHRs35ZumzaB96mJ49sqmGL2UWTp+uxG83Xt6UXLD
         YqJM1GyZNr6aotywijE40VUFI1ushqLuB4Vv3TEgIFI8xx8nilRzkG2tDYqJvCsM0N7T
         72Mtmko5bT4V6Ekhl3KktwznX9/gQ3xmJCYozBEKAhG07HT1SqpY+FAlILPZISZ0xsub
         N3EsQqHGuhj9whwtu6XgIlflo+O3ji6R2KSGhpZW18pdRv5xgoNGiqeWuCi6zuypr11F
         hifF4ACSqaZh4It4EOViaOSiA0QH07RwbrI0D3htFgHJ6MxD61s3OL5LOCis0agNVM/h
         HtNA==
X-Gm-Message-State: ALoCoQki6Li43E6Mm0UlibgcBAK2YjOaqXDlS83YrXmwFu3cczU0ptlR+98IKuDaSudIArt8EASg
X-Received: by 10.112.35.44 with SMTP id e12mr28743804lbj.13.1409103163198;
 Tue, 26 Aug 2014 18:32:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 26 Aug 2014 18:32:23 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 26 Aug 2014 18:32:23 -0700
Message-ID: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com>
Subject: Post-merge-window ping (Re: [PATCH v4 0/5] x86: two-phase syscall
 tracing and seccomp fastpath)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Mon, Jul 28, 2014 at 8:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> This applies to:
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp-fastpath
>
> Gitweb:
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath

Hi all-

AFAIK the only thing that's changed since I submitted it is that the
3.17 merge window is closed.  Kees rebased the tree this applies to,
but I think the patches all still apply.  What, if anything, do I need
to do to help this along for 3.18?

--Andy

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
>  arch/x86/kernel/ptrace.c       | 159 ++++++++++++++++++++++++++++++++++-------
>  4 files changed, 161 insertions(+), 60 deletions(-)
>
> --
> 1.9.3
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
