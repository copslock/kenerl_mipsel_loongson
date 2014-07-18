Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 23:18:44 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41677 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861361AbaGRVSloGart (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 23:18:41 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so6090489pad.22
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 14:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nt2jbbr/Yl+CZCsUmZ/eH6uZ2ef8wNvKffIuctiPM6A=;
        b=iopvotVRKYUkVW+6dbYdYzw6o1sD8nY52L1d8CWKCfkzHjq7I1hQ7UD0kW6YW4O111
         jrD7gcXZ7RndU+xEJcK0Kt422feOAZtL8BscUrJUNRg9MYV0YPxKa59fWCZr2UOg9HZt
         WaCNVqqwAcdm3SQ7eFamgDllRxfxifONNHpOfFoZrRjhX4FjGrrlltDOawU2EtZ2UZes
         6kXHbz9QYyc7iqr8Mz7Y4qmG6Kv+Aa202VP9LuO+ZR+prncMpmZeWEjbTiFykBwRiGx6
         hW7a9KIA1HyRPNw37ItcSj0P1P3C23R8H1QlNJ+9F+hihXyr3rD0y25U4IrAGL1ttm4K
         HAUQ==
X-Gm-Message-State: ALoCoQmUeHgGM9u9XuJtWj4r2vYIml6d5b+m0pZXREjBp8YTvI0neco7rXQLy5fFfgkoJS5S74fR
X-Received: by 10.68.167.133 with SMTP id zo5mr8214748pbb.21.1405718315197;
        Fri, 18 Jul 2014 14:18:35 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id gu4sm6514403pbb.54.2014.07.18.14.18.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2014 14:18:33 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 0/7] Two-phase seccomp and x86 tracing changes
Date:   Fri, 18 Jul 2014 14:18:08 -0700
Message-Id: <cover.1405717901.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41333
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

This is both a cleanup and a speedup.  It reduces overhead due to
installing a trivial seccomp filter by 87%.  The speedup comes from
avoiding the full syscall tracing mechanism for filters that don't
return SECCOMP_RET_TRACE.

This series works by splitting the seccomp hooks into two phases.
The first phase evaluates the filter; it can skip syscalls, allow
them, kill the calling task, or pass a u32 to the second phase.  The
second phase requires a full tracing context, and it sends ptrace
events if necessary.

Once this is done, I implemented a similar split for the x86 syscall
entry work.  The C callback is invoked in two phases: the first has
only a partial frame, and it can request phase 2 processing with a
full frame.

Finally, I switch the 64-bit system_call code to use the new split
entry work.  This is a net deletion of assembly code: it replaces
all of the audit entry muck.

In the process, I fixed some bugs.

If this is acceptable, someone can do the same tweak for the
ia32entry and entry_32 code.

This passes all seccomp tests that I know of.  Now that it's properly
rebased, even the previously expected failures are gone.

Kees, if you like this version, can you create a branch with patches
1-3?  I think that the rest should go into tip/x86 once everyone's happy
with it.

Changes from v1:
 - Rebased on top of Kees' shiny new seccomp tree (no effect on the x86
   part).
 - Improved patch 6 vs patch 7 split (thanks Alexei!)
 - Fixed bogus -ENOSYS in patch 5 (thanks Kees!)
 - Improved changelog message in patch 6.

Changes from RFC version:
 - The first three patches are more or less the same
 - The rest is more or less a rewrite

Andy Lutomirski (7):
  seccomp,x86,arm,mips,s390: Remove nr parameter from secure_computing
  seccomp: Refactor the filter callback and the API
  seccomp: Allow arch code to provide seccomp_data
  x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
  x86: Split syscall_trace_enter into two phases
  x86_64,entry: Treat regs->ax the same in fastpath and slowpath
    syscalls
  x86_64,entry: Use split-phase syscall_trace_enter for 64-bit syscalls

 arch/arm/kernel/ptrace.c       |   7 +-
 arch/mips/kernel/ptrace.c      |   2 +-
 arch/s390/kernel/ptrace.c      |   2 +-
 arch/x86/include/asm/calling.h |   6 +-
 arch/x86/include/asm/ptrace.h  |   5 +
 arch/x86/kernel/entry_64.S     |  51 ++++-----
 arch/x86/kernel/ptrace.c       | 146 +++++++++++++++++++-----
 arch/x86/kernel/vsyscall_64.c  |   2 +-
 include/linux/seccomp.h        |  25 ++--
 kernel/seccomp.c               | 252 ++++++++++++++++++++++++++++-------------
 10 files changed, 344 insertions(+), 154 deletions(-)

-- 
1.9.3
