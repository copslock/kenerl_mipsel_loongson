Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2017 22:57:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27944 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994814AbdHKU5gHpruw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2017 22:57:36 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTP id 348EE8BFC41DB;
        Fri, 11 Aug 2017 21:57:25 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 11 Aug 2017 21:57:29 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lars Persson <lars.persson@axis.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/4] MIPS: syscall tracing fixes
Date:   Fri, 11 Aug 2017 21:56:49 +0100
Message-ID: <20170811205653.21873-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

These patches fix some system call tracing issues around seccomp and
ptrace on MIPS.

Patch 1 fixes an issue introduced in v4.13-rc1, where o32 indirect
syscall arguments aren't shifted when filling out seccomp_data struct.
Arguably the samples/bpf/tracex5 case that was being fixed in -rc1 is
flawed, or else other arches are broken too. thoughts welcome on that,
but either way this fix should be okay. It'd be good to get this fix
in particular into v4.13.

Patches 2 and 3 fix changing of system calls by ptrace and
SECCOMP_RET_TRACE so that seccomp & syscall trace don't use the stale
system call number, which appears to have been conceptually broken since
v3.19 when thread_info::syscall was introduced, but also prevented the
change in v4.8 to re-run the seccomp filter against a changed syscall
from being effective on MIPS.
First (patch 2) syscall_trace_enter() is fixed to re-read the syscall
number from thread_info:syscall, then (patch 3) ptrace is fixed to
update thread_info::syscall when the relevant registers are altered.

Finally patch 4 fixes an API gap for MIPS which prevents a
SECCOMP_RET_TRACE tracer from being able to cancel a system call, since
you can't set both the system call number (v0) to -1 and the return
value (v0) to the chosen error code. A PTRACE_SET_SYSCALL is added which
allows thread_info::syscall to be set to -1 after the return value has
already been set in the v0 register to some other value.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Lars Persson <lars.persson@axis.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org

James Hogan (4):
  MIPS/seccomp: Fix indirect syscall args
  MIPS/ptrace: Pick up ptrace/seccomp changed syscalls
  MIPS/ptrace: Update syscall nr on register changes
  MIPS/ptrace: Add PTRACE_SET_SYSCALL operation

 arch/mips/include/asm/syscall.h     | 29 ++++++++++++++++++++----
 arch/mips/include/uapi/asm/ptrace.h |  1 +
 arch/mips/kernel/ptrace.c           | 45 +++++++++++++++++++++++++++++--------
 arch/mips/kernel/ptrace32.c         | 18 +++++++++++++++
 4 files changed, 80 insertions(+), 13 deletions(-)

-- 
2.13.2
