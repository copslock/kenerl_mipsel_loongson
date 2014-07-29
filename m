Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 05:48:48 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:60278 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861986AbaG2DirpLs2o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 05:38:47 +0200
Received: by mail-pd0-f174.google.com with SMTP id fp1so10972395pdb.33
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2014 20:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5J9A6FJKjFT9aXl0hJIBk9UovVbjZQHmaSo+pCiPJmg=;
        b=BshkjoTELSXB18nsaVX6W1JtJLiDT8rG1KuVwv0/pjQdK64dOwbqN6keFFtQOennc0
         zOBPqjaUDWTP/1EdXEaIa9wqG0R57u8yp6FehWEuxHMi5H72F80jeAcXpaCJho9xu28Y
         zkQgN7CaBSN+JXY6PWHMqnuBV5zjSu3gtgij2/cnI/wAfvl9laCpx+PS/a99gIU2b60g
         MI7JmSy/zUjpZlUnjahfGKMXirrhDLzFJt9vtFuOpmOQdrG/gQGWi0Wvt0VxQVEfLDVv
         8WuCbCb8EPC4K9fEWRbbxOXSaHSPQ4bvDp7r4OwZy+1nhvAdbkXR3y+qJlYRaE7V+Ur0
         fQbw==
X-Gm-Message-State: ALoCoQnwCxJ1ahAJUqkvoPcbvrhvN6X9zIkXDV8yXI+DpOGNgQRbVxHn+Yy4tJYsF55QtTAHCH0B
X-Received: by 10.68.131.33 with SMTP id oj1mr43310786pbb.71.1406605120823;
        Mon, 28 Jul 2014 20:38:40 -0700 (PDT)
Received: from localhost ([2001:5a8:4:83c0:fd15:6cb4:fa7d:1e89])
        by mx.google.com with ESMTPSA id pv2sm19226283pbb.13.2014.07.28.20.38.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 20:38:39 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp fastpath
Date:   Mon, 28 Jul 2014 20:38:27 -0700
Message-Id: <cover.1406604806.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41751
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

This applies to:
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp-fastpath

Gitweb:
https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath

This is both a cleanup and a speedup.  It reduces overhead due to
installing a trivial seccomp filter by 87%.  The speedup comes from
avoiding the full syscall tracing mechanism for filters that don't
return SECCOMP_RET_TRACE.

This series depends on splitting the seccomp hooks into two phases.
The first phase evaluates the filter; it can skip syscalls, allow
them, kill the calling task, or pass a u32 to the second phase.  The
second phase requires a full tracing context, and it sends ptrace
events if necessary.  The seccomp core part is in Kees' seccomp/fastpath
tree.

These patches implement a similar split for the x86 syscall
entry work.  The C callback is invoked in two phases: the first has
only a partial frame, and it can request phase 2 processing with a
full frame.

Finally, I switch the 64-bit system_call code to use the new split
entry work.  This is a net deletion of assembly code: it replaces
all of the audit entry muck.

In the process, I fixed some bugs.

If this is acceptable, someone can do the same tweak for the
ia32entry and entry_32 code.

This passes all seccomp tests that I know of.

Changes from v3:
 - Dropped the core seccomp changes from the email -- Kees has applied them.
 - Add patch 2 (the TIF_NOHZ change).
 - Fix TIF_NOHZ in the two-phase entry code (thanks, Oleg).

Changes from v2:
 - Fixed 32-bit x86 build (and the tests pass).
 - Put the doc patch where it belongs.

Changes from v1:
 - Rebased on top of Kees' shiny new seccomp tree (no effect on the x86
   part).
 - Improved patch 6 vs patch 7 split (thanks Alexei!)
 - Fixed bogus -ENOSYS in patch 5 (thanks Kees!)
 - Improved changelog message in patch 6.

Changes from RFC version:
 - The first three patches are more or less the same
 - The rest is more or less a rewrite


Andy Lutomirski (5):
  x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
  x86,entry: Only call user_exit if TIF_NOHZ
  x86: Split syscall_trace_enter into two phases
  x86_64,entry: Treat regs->ax the same in fastpath and slowpath
    syscalls
  x86_64,entry: Use split-phase syscall_trace_enter for 64-bit syscalls

 arch/x86/include/asm/calling.h |   6 +-
 arch/x86/include/asm/ptrace.h  |   5 ++
 arch/x86/kernel/entry_64.S     |  51 +++++--------
 arch/x86/kernel/ptrace.c       | 159 ++++++++++++++++++++++++++++++++++-------
 4 files changed, 161 insertions(+), 60 deletions(-)

-- 
1.9.3
