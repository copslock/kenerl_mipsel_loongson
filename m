Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 05:04:36 +0100 (CET)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:46295
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990407AbeCNEE1fITpI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2018 05:04:27 +0100
Received: by mail-pl0-x241.google.com with SMTP id f5-v6so1048962plj.13;
        Tue, 13 Mar 2018 21:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dtu5LbpuEczC2Y5OuUYn4FwjsrA34yv0P2drUJ/TfX0=;
        b=LtS2iTXvC/qdIdYQLGZc9Z9CTDfDCB5hTQ4HmjcJd0cLy+TQGKTqiUTIOHzQkPtfzb
         CWDMEblEtXIgQhAvPiAh2B460G/RRTPk17h451jNKlEN19SYHW4PPhxwZ86GDsL+C7a6
         1v8FIDFBOLGKhj5+lIYfbZ2MzGJbBZjdun/m/Si+6QB37fkody5yW4NJoNg+eQM51DhW
         INQnC0TPirHMLfsFyllTwaPwfXSsy9TMA5v93kv72AExbNU8h2WzL3sCWGzxIeEDhgmf
         feo+4MG8rtjfm+8FYuIwfhTsc7kFnPNKtwnbNKf0ECmj9k/OIjztZDynvpJbST6asXLg
         5PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dtu5LbpuEczC2Y5OuUYn4FwjsrA34yv0P2drUJ/TfX0=;
        b=nWVMTVHO2g4/EAd0VdkXDZmKSlj6OXJ1L1h0Y/xIe3IrWJPZvFtoGzxQ3WLHDYx7N3
         a+NazdrGafz+f6TMJEI6U6gqXjedzE3QEAyDdl1DzaWH95crQ6doOQ3qCMnWhMKOKcF/
         Aa433hhjGmPU7QZ2Wwwr9dPceAf3bJEESLy7lBK/5feqNlfzrvgP//eyD+l8oIlHLIli
         jpv36dy0Xc0mQckfuYhwTqMAthvIeyTbjwsVtdmsktVKpyZaIPRyiln4JQbHlYAaDzsd
         qVku2zyfSiITBeXjVtNjc/PMJJiU2fKRJkq18busDD/v4de2ol4kn/8aQfmBuL7rplQf
         X8vw==
X-Gm-Message-State: AElRT7ElOYL2bX2aVdM0XX5f5gDVDH8Dz9gUt/e5mrukj7NmKOEdF/k0
        Cv4qH3yKBZDyU4FM0gHZYR8=
X-Google-Smtp-Source: AG47ELuem0VGVCJepftvY25NURknsRspPXkGHyJ9/WtxeePgicC4X+lHdnworsbMR+Qa/pSFwSFd7w==
X-Received: by 2002:a17:902:7b90:: with SMTP id w16-v6mr2675424pll.26.1521000260931;
        Tue, 13 Mar 2018 21:04:20 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id c18sm2663773pfd.100.2018.03.13.21.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 21:04:20 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        acme@kernel.org, benh@kernel.crashing.org, borntraeger@de.ibm.com,
        catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com,
        davem@davemloft.net, deller@gmx.de, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org,
        heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com,
        hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com,
        sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
        sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com,
        will.deacon@arm.com, x86@kernel.org
Subject: [PATCH v5 00/10] posix_clocks: Prepare syscalls for 64 bit time_t conversion
Date:   Tue, 13 Mar 2018 21:03:23 -0700
Message-Id: <20180314040333.3291-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

The series is a preparation series for individual architectures
to use 64 bit time_t syscalls in compat and 32 bit emulation modes.

This is a follow up to the series Arnd Bergmann posted:
https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html [1]

Thomas, Arnd, this seems ready to be merged now.
Can you help get this merged?

Big picture is as per the lwn article:
https://lwn.net/Articles/643234/ [2]

The series is directed at converting posix clock syscalls:
clock_gettime, clock_settime, clock_getres and clock_nanosleep
to use a new data structure __kernel_timespec at syscall boundaries.
__kernel_timespec maintains 64 bit time_t across all execution modes.

vdso will be handled as part of each architecture when they enable
support for 64 bit time_t.

The compat syscalls are repurposed to provide backward compatibility
by using them as native syscalls as well for 32 bit architectures.
They will continue to use timespec at syscall boundaries.

CONFIG_64_BIT_TIME controls whether the syscalls use __kernel_timespec
or timespec at syscall boundaries.

The series does the following:
1. Enable compat syscalls on 32 bit architectures.
2. Add a new __kernel_timespec type to be used as the data structure
   for all the new syscalls.
3. Add new config CONFIG_64BIT_TIME(intead of the CONFIG_COMPAT_TIME in
   [1] and [2] to switch to new definition of __kernel_timespec. It is
   the same as struct timespec otherwise.
4. Add new CONFIG_32BIT_TIME to conditionally compile compat syscalls.

* Changes since v4:
 * Fixed up kbuild errors for arm64 and powerpc non compat configs
* Changes since v3:
 * Updated include file ordering
* Changes since v2:
 * Dropped the ARCH_HAS_64BIT_TIME config.
 * Fixed zeroing out of higher order bits of tv_nsec for real.
 * Addressed minor review comments from v1.
* Changes since v1:
 * Introduce CONFIG_32BIT_TIME
 * Fixed zeroing out of higher order bits of tv_nsec
 * Included Arnd's changes to fix up use of compat headers

I decided against using LEGACY_TIME_SYSCALLS to conditionally compile
legacy time syscalls such as sys_nanosleep because this will need to
enclose compat_sys_nanosleep as well. So, defining it as 

config LEGACY_TIME_SYSCALLS
     def_bool 64BIT || !64BIT_TIME

will not include compat_sys_nanosleep. We will instead need a new config to
exclusively mark legacy syscalls.

Deepa Dinamani (10):
  compat: Make compat helpers independent of CONFIG_COMPAT
  include: Move compat_timespec/ timeval to compat_time.h
  compat: enable compat_get/put_timespec64 always
  arch: introduce CONFIG_64BIT_TIME
  arch: Introduce CONFIG_COMPAT_32BIT_TIME
  posix-clocks: Make compat syscalls depend on CONFIG_COMPAT_32BIT_TIME
  include: Add new y2038 safe __kernel_timespec
  fix get_timespec64() for y2038 safe compat interfaces
  change time types to new y2038 safe __kernel_* types
  nanosleep: change time types to safe __kernel_* types

 arch/Kconfig                           | 15 +++++++++
 arch/arm64/include/asm/compat.h        | 11 -------
 arch/arm64/include/asm/stat.h          |  1 +
 arch/arm64/kernel/hw_breakpoint.c      |  1 -
 arch/arm64/kernel/perf_regs.c          |  2 +-
 arch/mips/include/asm/compat.h         | 11 -------
 arch/mips/kernel/signal32.c            |  2 +-
 arch/parisc/include/asm/compat.h       | 11 -------
 arch/powerpc/include/asm/compat.h      | 11 -------
 arch/powerpc/kernel/asm-offsets.c      |  2 +-
 arch/powerpc/oprofile/backtrace.c      |  1 +
 arch/s390/hypfs/hypfs_sprp.c           |  1 -
 arch/s390/include/asm/compat.h         | 11 -------
 arch/s390/include/asm/elf.h            |  4 +--
 arch/s390/kvm/priv.c                   |  1 -
 arch/s390/pci/pci_clp.c                |  1 -
 arch/sparc/include/asm/compat.h        | 11 -------
 arch/tile/include/asm/compat.h         | 11 -------
 arch/x86/events/core.c                 |  2 +-
 arch/x86/include/asm/compat.h          | 11 -------
 arch/x86/include/asm/ftrace.h          |  2 +-
 arch/x86/include/asm/sys_ia32.h        |  2 +-
 arch/x86/kernel/sys_x86_64.c           |  2 +-
 drivers/s390/block/dasd_ioctl.c        |  1 -
 drivers/s390/char/fs3270.c             |  1 -
 drivers/s390/char/sclp_ctl.c           |  1 -
 drivers/s390/char/vmcp.c               |  1 -
 drivers/s390/cio/chsc_sch.c            |  1 -
 drivers/s390/net/qeth_core_main.c      |  2 +-
 include/linux/compat.h                 | 11 ++++---
 include/linux/compat_time.h            | 23 ++++++++++++++
 include/linux/restart_block.h          |  7 ++--
 include/linux/syscalls.h               | 12 +++----
 include/linux/time.h                   |  4 +--
 include/linux/time64.h                 | 10 +++++-
 include/uapi/asm-generic/posix_types.h |  1 +
 include/uapi/linux/time.h              |  7 ++++
 kernel/compat.c                        | 52 +++++-------------------------
 kernel/time/hrtimer.c                  | 10 ++++--
 kernel/time/posix-stubs.c              | 12 ++++---
 kernel/time/posix-timers.c             | 24 ++++++++++----
 kernel/time/time.c                     | 58 +++++++++++++++++++++++++++++++---
 42 files changed, 177 insertions(+), 188 deletions(-)
 create mode 100644 include/linux/compat_time.h


base-commit: 61530b14b059d4838dcc2186e9de9d57e195ce55
-- 
2.14.1

Cc: acme@kernel.org
Cc: benh@kernel.crashing.org
Cc: borntraeger@de.ibm.com
Cc: catalin.marinas@arm.com
Cc: cmetcalf@mellanox.com
Cc: cohuck@redhat.com
Cc: davem@davemloft.net
Cc: deller@gmx.de
Cc: devel@driverdev.osuosl.org
Cc: gerald.schaefer@de.ibm.com
Cc: gregkh@linuxfoundation.org
Cc: heiko.carstens@de.ibm.com
Cc: hoeppner@linux.vnet.ibm.com
Cc: hpa@zytor.com
Cc: jejb@parisc-linux.org
Cc: jwi@linux.vnet.ibm.com
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: mark.rutland@arm.com
Cc: mingo@redhat.com
Cc: mpe@ellerman.id.au
Cc: oberpar@linux.vnet.ibm.com
Cc: oprofile-list@lists.sf.net
Cc: paulus@samba.org
Cc: peterz@infradead.org
Cc: ralf@linux-mips.org
Cc: rostedt@goodmis.org
Cc: rric@kernel.org
Cc: schwidefsky@de.ibm.com
Cc: sebott@linux.vnet.ibm.com
Cc: sparclinux@vger.kernel.org
Cc: sth@linux.vnet.ibm.com
Cc: ubraun@linux.vnet.ibm.com
Cc: will.deacon@arm.com
Cc: x86@kernel.org
