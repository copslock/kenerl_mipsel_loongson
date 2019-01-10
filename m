Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9AFC43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90CE20675
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 17:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfAJR27 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:28:59 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:52545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfAJR26 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 12:28:58 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8XHb-1hKz3U1jPt-014Q0M; Thu, 10 Jan 2019 18:22:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 00/11] y2038: add time64 syscalls
Date:   Thu, 10 Jan 2019 18:22:05 +0100
Message-Id: <20190110172216.313063-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vW0Dtz92Na8JvFtbJmdrKh+Wt6C4wl+ANEtiHTyStG1oSJxvfH2
 K9sHwGh5KPndF/MySTlf8GNZ6uZN4Q6cZ+LtnuLRLzGMbJedI2g87MyDucReT6MVo6SLLpw
 TuOM3qHe1ytgZ1t/Jri3mKwNr3y9kLV5Hh4pq1RC8iRupXThgHBi24MmMG4TY9XG/OEt8so
 3ZEJ/rgV99vZ95v5E8NdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FLOeMd4IsYY=:wjmGiFrHNe582W/8TvMbrZ
 BTy71tzGcGr4BEAsOx4HtTiNnuPoNmXfJHuYPGkcnQWfgbLQDLLP3kNILyltnsG/5UG7n2b3t
 7lL0rkEvk1Sfre+MGr1faxey2eFmMU1tWHcgIRMejducRkWGnTVRVIYR0WWMAPE6AnQ/nBPqp
 apAjtfeQVYyStSFw12j2hEeC8cpzOl27LGFLByoxNr076lfVfyFuKZe+L03CSeKQX68X9n0EM
 JXv52qUBTEhONk8ol+2EmtIZeOtfhwxzXlbdTmf1nXz2uPzV93NJ8CDcMY/DhKT3FJCmtYXQJ
 y4EL2T8GKQihE1ht5FEovgdELPhx+x9D6umTQ7VvcEIKo8yo/lSRHSQtdx1ymIwwQVHUzK5yc
 +nOpf47UwebfvIF+l70PD5EGaQw3Hzqvzr5ZFF+35+R0CuWTVC5hepujdK2vh8HExaIiSTeVN
 f/IGUYp0y3zRCNJAMLVZo6ag4ltWlgQQcurKYmnCZDNq3SFWZZQ+1q5WZK8WNuXBtgNrQnZVO
 gX+RqODXtoK9q+2aYJM1HchrkwfBIy2uuHupSlpQ7whfY583avdOewcQLayLqeBcU3POL4Vcc
 GGfx3Hmkcn2vNYjLxt7mahHfjEDdZa3oGAXGgoiw+YbHUsJf+i0EP5l3jCUrwXULt+zp7Dpto
 SDBG/+s3XxYapxF/ya3DAeMZC4WmUzDhmHiHE4XegrfvHICFTgylYbQsyxNb40HaplIXCuzLA
 h3TmROU2XfTNK/Xs0rUaKh+MbBwQU1fQShHtOg==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This series finally gets us to the point of having system calls with
64-bit time_t on all architectures, after a long time of incremental
preparation patches.

There was actually one conversion that I missed during the summer,
i.e. Deepa's timex series, which I now updated based the 5.0-rc1 changes
and review comments.

I hope that the actual conversion should be uncontroversial by now,
even if some of the patches are rather large.

The one area that may need a little discussion is for the system call
numbers assigned in the final patch: Can we get consensus on whether
the idea of using the same numbers on all architectures, as well as my
choice of numbers makes sense here?

So far, I have done a lot of build testing across most architectures,
which has found a number of bugs. I have also done an LTP run on arm32
with existing user space, but not on the other architectures. I did LTP
tests with a modified musl libc[2] last summer on an older version of
this series to make sure that the new 64-bit time_t interfaces work.
The version there will need updates for testing with this new kernel
patch series; I plan to do that next.

For testing, the series plus the preparatory patches is available at
[3].  Once there is a general agreement on this series and I have done
more tests for the new system calls, I plan to add this to linux-next
through my asm-generic tree or Thomas' timers tree.

Please review and test!

      Arnd

[1] https://lore.kernel.org/lkml/20190110162435.309262-1-arnd@arndb.de/T/
[2] https://git.linaro.org/people/arnd/musl-y2038.git/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-5.0-rc1

Arnd Bergmann (8):
  time: make adjtime compat handling available for 32 bit
  time: fix sys_timer_settime prototype
  sparc64: add custom adjtimex/clock_adjtime functions
  y2038: syscalls: rename y2038 compat syscalls
  y2038: use time32 syscall names on 32-bit
  y2038: remove struct definition redirects
  y2038: rename old time and utime syscalls
  y2038: add 64-bit time_t syscalls to all 32-bit architectures

Deepa Dinamani (3):
  time: Add struct __kernel_timex
  timex: use __kernel_timex internally
  timex: change syscalls to use struct __kernel_timex

 arch/Kconfig                                |   2 +-
 arch/alpha/kernel/osf_sys.c                 |   5 +-
 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/include/asm/unistd.h               |   4 +-
 arch/arm/kernel/sys_oabi-compat.c           |   8 +-
 arch/arm/tools/syscall.tbl                  |  77 ++++++++-----
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |  89 ++++++++++----
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/include/asm/unistd.h              |   4 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  72 +++++++-----
 arch/microblaze/include/asm/unistd.h        |   4 +-
 arch/microblaze/kernel/syscalls/syscall.tbl |  77 ++++++++-----
 arch/mips/include/asm/unistd.h              |   4 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  71 ++++++++----
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  74 +++++++-----
 arch/parisc/include/asm/unistd.h            |   9 +-
 arch/parisc/kernel/syscalls/syscall.tbl     | 105 ++++++++++++-----
 arch/powerpc/include/asm/unistd.h           |   8 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    | 121 +++++++++++++++-----
 arch/s390/include/asm/unistd.h              |   2 +-
 arch/s390/kernel/syscalls/syscall.tbl       |  72 +++++++-----
 arch/sh/include/asm/unistd.h                |   4 +-
 arch/sh/kernel/syscalls/syscall.tbl         |  72 +++++++-----
 arch/sparc/include/asm/unistd.h             |   8 +-
 arch/sparc/kernel/sys_sparc_64.c            |  59 +++++++++-
 arch/sparc/kernel/syscalls/syscall.tbl      | 100 +++++++++++-----
 arch/x86/entry/syscalls/syscall_32.tbl      |  74 +++++++-----
 arch/x86/entry/syscalls/syscall_64.tbl      |   4 +-
 arch/x86/include/asm/unistd.h               |   8 +-
 arch/xtensa/include/asm/unistd.h            |   2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     |  71 ++++++++----
 drivers/ptp/ptp_clock.c                     |   2 +-
 fs/aio.c                                    |  10 +-
 fs/select.c                                 |   4 +-
 fs/timerfd.c                                |   4 +-
 fs/utimes.c                                 |  10 +-
 include/linux/compat.h                      | 104 +----------------
 include/linux/posix-clock.h                 |   2 +-
 include/linux/syscalls.h                    |  65 ++++++++++-
 include/linux/time32.h                      |  32 +++++-
 include/linux/time64.h                      |   8 --
 include/linux/timex.h                       |   4 +-
 include/uapi/asm-generic/unistd.h           | 103 ++++++++++++-----
 include/uapi/linux/time.h                   |   4 -
 include/uapi/linux/timex.h                  |  39 +++++++
 ipc/mqueue.c                                |  16 +--
 ipc/sem.c                                   |   2 +-
 kernel/compat.c                             |  64 -----------
 kernel/futex.c                              |   2 +-
 kernel/sched/core.c                         |   5 +-
 kernel/signal.c                             |   2 +-
 kernel/sys_ni.c                             |  18 +--
 kernel/time/hrtimer.c                       |   2 +-
 kernel/time/ntp.c                           |  18 +--
 kernel/time/ntp_internal.h                  |   2 +-
 kernel/time/posix-clock.c                   |   2 +-
 kernel/time/posix-stubs.c                   |  25 ++--
 kernel/time/posix-timers.c                  |  72 ++++++------
 kernel/time/posix-timers.h                  |   2 +-
 kernel/time/time.c                          |  92 ++++++++++++---
 kernel/time/timekeeping.c                   |   4 +-
 net/compat.c                                |   2 +-
 scripts/checksyscalls.sh                    |  40 +++++++
 65 files changed, 1264 insertions(+), 713 deletions(-)

-- 
2.20.0

Cc: mattst88@gmail.com
Cc: linux@armlinux.org.uk
Cc: catalin.marinas@arm.com
Cc: will.deacon@arm.com
Cc: tony.luck@intel.com
Cc: fenghua.yu@intel.com
Cc: geert@linux-m68k.org
Cc: monstr@monstr.eu
Cc: paul.burton@mips.com
Cc: deller@gmx.de
Cc: benh@kernel.crashing.org
Cc: mpe@ellerman.id.au
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: dalias@libc.org
Cc: davem@davemloft.net
Cc: luto@kernel.org
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: jcmvbkbc@gmail.com
Cc: arnd@arndb.de
Cc: akpm@linux-foundation.org
Cc: deepa.kernel@gmail.com
Cc: ebiederm@xmission.com
Cc: firoz.khan@linaro.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org

