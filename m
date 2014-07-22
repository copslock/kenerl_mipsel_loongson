Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 03:49:38 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35278 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821198AbaGVBtf6xkWj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 03:49:35 +0200
Received: by mail-pa0-f41.google.com with SMTP id rd3so10421285pab.28
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 18:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z7860utv7bjUa2ZqRxX1NyDJ7KntR9UH+w+Qj9t2VXs=;
        b=gtEz31EDnL1/67NfWYQpMHKUW7nGbo5AONjAAPiBGtiW+Hzb/Q+YabEESnb4pzY+cm
         BUqtI7FbHO+qbYgvVwBj79oQfWZQApaKP/3eK3pYcVwGM0ymY0xGO6Gv4Y3k23vZsHLD
         Am8UtaYKv0DUa+QqvFnzMcgd3AgwbOv1No+GYRhHJKZFZTL+K0ZHDWfI34jk5wjHkmh5
         oKxxXOyWWl0sxn7dK6wja5wnsDpsuicC2AZsRKBPZzzGNwtYHe/DbsnrHGy5USAbO7Wd
         YaT3SWfu9w+f/XV2Sz2ujulMAga/n6nhyEIeJMnkYaT5/F8bwm6MepWkEB1Pd3vL8QXj
         K/UA==
X-Gm-Message-State: ALoCoQm88WT5X0b4wAUgnfUai6w3dbmsrnkyRfrg8+f4Dmy78taxsx4Ma/0gtMMPysh7LnG2j/ay
X-Received: by 10.69.12.33 with SMTP id en1mr18697957pbd.66.1405993769591;
        Mon, 21 Jul 2014 18:49:29 -0700 (PDT)
Received: from localhost ([2600:1010:b01b:59a8:9138:8dc8:286b:79c0])
        by mx.google.com with ESMTPSA id n2sm16878306pdo.32.2014.07.21.18.49.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jul 2014 18:49:28 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
Date:   Mon, 21 Jul 2014 18:49:13 -0700
Message-Id: <cover.1405992946.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41411
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

[applies on jmorris's security-next tree]

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
1-4?  I think that the rest should go into tip/x86 once everyone's happy
with it.

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

Andy Lutomirski (8):
  seccomp,x86,arm,mips,s390: Remove nr parameter from secure_computing
  seccomp: Refactor the filter callback and the API
  seccomp: Allow arch code to provide seccomp_data
  seccomp: Document two-phase seccomp and arch-provided seccomp_data
  x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
  x86: Split syscall_trace_enter into two phases
  x86_64,entry: Treat regs->ax the same in fastpath and slowpath
    syscalls
  x86_64,entry: Use split-phase syscall_trace_enter for 64-bit syscalls

 arch/Kconfig                   |  11 ++
 arch/arm/kernel/ptrace.c       |   7 +-
 arch/mips/kernel/ptrace.c      |   2 +-
 arch/s390/kernel/ptrace.c      |   2 +-
 arch/x86/include/asm/calling.h |   6 +-
 arch/x86/include/asm/ptrace.h  |   5 +
 arch/x86/kernel/entry_64.S     |  51 ++++-----
 arch/x86/kernel/ptrace.c       | 150 +++++++++++++++++++-----
 arch/x86/kernel/vsyscall_64.c  |   2 +-
 include/linux/seccomp.h        |  25 ++--
 kernel/seccomp.c               | 252 ++++++++++++++++++++++++++++-------------
 11 files changed, 360 insertions(+), 153 deletions(-)

-- 
1.9.3
