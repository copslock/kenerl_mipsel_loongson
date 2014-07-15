Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 21:32:50 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51318 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861040AbaGOTcsvmPex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 21:32:48 +0200
Received: by mail-pa0-f42.google.com with SMTP id lf10so3932169pab.29
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 12:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mathVVEwKJ2V2QBES2PmIwWJoVjWKTqXrGI/p0ceU/k=;
        b=eu5IOpANLBxSXV7VdfC9SmaGZHqvkG2hHS3bJ78GMNwYDOxnzsGhTYBn42dAY+Qc0U
         Z5v9i5X6A5t2IXUNFLLf/K/3xs52+VmUbWtluswRavxQey3JE2h753bbnWX4TB8Jatuh
         GNTMufk/xwGADkOgOF81R43QVWUd8qHZ0X7dOBNkyI0x3Kca13/jD1wq4Zjb4bv2PYD8
         0zJu4+nn4YopVJFBb8sbErJWWJyUp5eWMZ7cIqpFkiafJ2xMJUj/CX3fLK1axivdLRCX
         8DQspzavqOmMgdehhhHpbbdQ7vIqn4fQMnyub+1ERKFCNy0QcxNtZu/CKfbsHzbUUmZE
         PTaw==
X-Gm-Message-State: ALoCoQm4D7FaAryo29RjlzcvFH7tv4lz9RotP5LNw/Wl/SKbO2Uq58n7WbNV+zsOfSk+6plQ+q3v
X-Received: by 10.68.95.225 with SMTP id dn1mr10928893pbb.126.1405452762168;
        Tue, 15 Jul 2014 12:32:42 -0700 (PDT)
Received: from localhost ([2001:5a8:4:83c0:b456:e6bb:934a:3ab7])
        by mx.google.com with ESMTPSA id uj2sm61323633pab.14.2014.07.15.12.32.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jul 2014 12:32:41 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 0/7] Two-phase seccomp and x86 tracing changes
Date:   Tue, 15 Jul 2014 12:32:29 -0700
Message-Id: <cover.1405452484.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41198
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

This passes all seccomp tests that I know of, except for the ones
that don't work on current kernels.

Presumably, once everyone gets a chance to poke at this, it should
go in to some combination of James' and hpa's trees.

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
 include/linux/seccomp.h        |  25 +++--
 kernel/seccomp.c               | 246 +++++++++++++++++++++++++++--------------
 10 files changed, 339 insertions(+), 153 deletions(-)

-- 
1.9.3
