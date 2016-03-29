Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 10:36:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8508 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27024936AbcC2Ifxqs1ak (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 10:35:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 74F08C7BEA855;
        Tue, 29 Mar 2016 09:35:45 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:47 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:46 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        "Kees Cook" <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Eric B Munson <emunson@akamai.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH v2 0/6] MIPS seccomp_bpf self test and fixups
Date:   Tue, 29 Mar 2016 09:35:28 +0100
Message-ID: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

These patches imporve seccomp support on MIPS.

Firstly support is added for building the seccomp_bpf self test for
MIPS. The
initial results of these tests were:

32bit kernel O32 userspace before: 48 / 48 pass
64bit kernel O32 userspace before: 47 / 48 pass
 Failures: TRAP.Handler
64bit kernel N32 userspace before: 44 / 48 pass
 Failures: global.mode_strict_support, TRAP.handler,
TRACE_syscall.syscall_redirected, TRACE_syscall.syscall_dropped
64bit kernel N64 userspace before: 46 / 48 pass
 Failures: TRACE_syscall.syscall_redirected,
TRACE_syscall.syscall_dropped

The subsequent patches fix issues that were causing the above tests to
fail. With
these fixes, the results are:
32bit kernel O32 userspace after: 48 / 48
64bit kernel O32 userspace after: 48 / 48
64bit kernel N32 userspace after: 48 / 48
64bit kernel N64 userspace after: 48 / 48

Thanks,
Matt

Changes in v2:
- Tested on additional platforms
- Replace __NR_syscall which isn't defined for N32 / N64 ABIs

Matt Redfearn (6):
  selftests/seccomp: add MIPS self-test support
  MIPS: Support sending SIG_SYS to 32bit userspace from 64bit kernel
  MIPS: scall: Handle seccomp filters which redirect syscalls
  seccomp: Get compat syscalls from asm-generic header
  MIPS: seccomp: Support compat with both O32 and N32
  secomp: Constify mode1 syscall whitelist

 arch/mips/include/asm/seccomp.h               | 47 +++++++++++++++------------
 arch/mips/kernel/scall32-o32.S                | 11 +++----
 arch/mips/kernel/scall64-64.S                 |  3 +-
 arch/mips/kernel/scall64-n32.S                | 14 +++++---
 arch/mips/kernel/scall64-o32.S                | 14 +++++---
 arch/mips/kernel/signal32.c                   |  6 ++++
 include/asm-generic/seccomp.h                 | 14 ++++++++
 kernel/seccomp.c                              | 13 ++------
 tools/testing/selftests/seccomp/seccomp_bpf.c | 30 +++++++++++++++--
 9 files changed, 101 insertions(+), 51 deletions(-)

-- 
2.5.0
