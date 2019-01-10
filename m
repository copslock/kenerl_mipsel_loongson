Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A097EC43612
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7EE2173B
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfAJQ06 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:26:58 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:47417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbfAJQ0z (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 11:26:55 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8yoa-1gbZP519vi-0063I1; Thu, 10 Jan 2019 17:25:05 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        firoz.khan@linaro.org, ebiederm@xmission.com,
        deepa.kernel@gmail.com, linux@dominikbrodowski.net,
        akpm@linux-foundation.org, dave@stgolabs.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 00/15] arch: synchronize syscall tables in preparation for y2038
Date:   Thu, 10 Jan 2019 17:24:20 +0100
Message-Id: <20190110162435.309262-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jhoE6/odjdfdBd6yrYoTQRylO8KTHs0vFajSRSOy3XKF9bGfqko
 KtSukK0N0eaTZv6m1MEw3rEB/9fW1GAIssAzz4uJd1F6vdHonvwYJKMyB1s1aApsfbiJEC9
 5okxLH6hKdq1eSKydX2+7l6cR7QwTqF7aGCx8EhvPkPF3W7xFOzG77OECp6a+2EDAchEiTB
 wNs3RaKtpG4cOPTeZ6RSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5xO5hqiOarE=:c+iZ9kLMNq1WpvagfFixUK
 KblxgxXKOzW/ayE0xHmHoXJnWMfNLm+d1W4SA6omPPTDDVuCF8E6MnCsIP7s262/5hLKjuZwO
 qw/U5gYgrED/GkEzYSGdZaw/AA4vdYj6X0aLPj0izwKjFa6jsx/59jseIoJa1W8bngmyt7353
 jD8gBiL6F0FE+MbZgrHlVRclpEjuRNgEF9lUI3uL01eWryW+YtgueG06/Am2G2e1NsCx3Z/XD
 VBRGKKTfNtFdrsc28Df5rzFIRmhvuPU57AHF9Cvcr7QoQ/Wl4L8OY/Qo2R8D5VvCf6SRKNkcS
 JGefvNLcFQn+69gKWR7va/qMvAJbZPDrMOzIJyo9O7zQG956eZKK1JIQd0htZBjBO514W1Kxc
 WAEAFcOmZfO50u8+Wr7cWmJtpCwN7HJ9zJqAXw8Yfjzb6NoZG8JHzaTkkTvfhc+Clrfgro1dp
 1O2r7nREhlppbmsMUz79/ZwxtZVsv1oMIL0sr8ZQFE0Tf0fKAunIpUxm6BLLNhszcpYtg8UfU
 Yd/1M20ISzeIz/yiMCJ+2ithBwz84ZnftBpTFUeaqlQVJWLjVOcdH0+szWRuJ23O38qxwshFL
 baJqqC1kB7kYZEwYHGYQprS4087AY4Exfl0pO+wSKjdPuAMQg0guC1OS9j7DGBCqkN+wQXQEV
 z4ytAVckRafv+zejAZlDq+sZdRZ0w1XQCh24HQXujupgvCQKysD6SsYVl0QrM7VGNMM85xyI5
 LBr4cgrZBGMkoOS2wYlsAoXV3QRR/h5DzYM9Dw==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The system call tables have diverged a bit over the years, and a number
of the recent additions never made it into all architectures, for one
reason or another.

This is an attempt to clean it up as far as we can without breaking
compatibility, doing a number of steps:

- Add system calls that have not yet been integrated into all
  architectures but that we definitely want there.

- Add the separate ipc syscalls on all architectures that
  traditionally only had sys_ipc(). This version is done without
  support for IPC_OLD that is we have in sys_ipc. The
  new semtimedop_time64 syscall will only be added here, not
  in sys_ipc

- Add syscall numbers for a couple of syscalls that we probably
  don't need everywhere, in particular pkey_* and rseq,
  for the purpose of symmetry: if it's in asm-generic/unistd.h,
  it makes sense to have it everywhere.

- Prepare for having the same system call numbers for any future
  calls. In combination with the generated tables, this hopefully
  makes it easier to add new calls across all architectures
  together.

Most of the contents of this series are unrelated to the actual
y2038 work, but for the moment, that second series is based on
this one. If there are any concerns about changes here, I
can drop or rewrite any individual patch in this series.

My plan is to merge any patches in this series that are found
to be good together with the y2038 patches for linux-5.1, so
please review and provide Acks for merging through my tree,
or pick them up for 5.0 if they seem urgent enough.

      Arnd

Arnd Bergmann (15):
  ia64: add __NR_umount2 definition
  ia64: add statx and io_pgetevents syscalls
  ia64: assign syscall numbers for perf and seccomp
  alpha: wire up io_pgetevents system call
  alpha: update syscall macro definitions
  ARM: add migrate_pages() system call
  ARM: add kexec_file_load system call number
  m68k: assign syscall number for seccomp
  sh: remove duplicate unistd_32.h file
  sh: add statx system call
  mips: fix n32 compat_ipc_parse_version
  sparc64: fix sparc_ipc type conversion
  ipc: rename old-style shmctl/semctl/msgctl syscalls
  arch: add split IPC system calls where needed
  arch: add pkey and rseq syscall numbers everywhere

 arch/alpha/include/asm/unistd.h             |  10 -
 arch/alpha/include/uapi/asm/unistd.h        |   5 +
 arch/alpha/kernel/syscalls/syscall.tbl      |  15 +-
 arch/arm/include/asm/unistd.h               |   1 -
 arch/arm/tools/syscall.tbl                  |   8 +-
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |  10 +-
 arch/ia64/include/asm/unistd.h              |  14 -
 arch/ia64/include/uapi/asm/unistd.h         |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  10 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  16 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   6 +-
 arch/mips/Kconfig                           |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   6 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   6 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  11 +
 arch/parisc/include/asm/unistd.h            |   3 -
 arch/parisc/kernel/syscalls/syscall.tbl     |   4 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  12 +
 arch/s390/include/asm/unistd.h              |   3 -
 arch/s390/kernel/syscalls/syscall.tbl       |  15 +
 arch/sh/include/uapi/asm/unistd_32.h        | 403 --------------------
 arch/sh/kernel/syscalls/syscall.tbl         |  16 +
 arch/sparc/include/asm/unistd.h             |   5 -
 arch/sparc/kernel/sys_sparc_64.c            |   2 +-
 arch/sparc/kernel/syscalls/syscall.tbl      |  16 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  11 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   7 +-
 include/linux/syscalls.h                    |   3 +
 ipc/msg.c                                   |  39 +-
 ipc/sem.c                                   |  39 +-
 ipc/shm.c                                   |  40 +-
 ipc/syscall.c                               |  12 +-
 ipc/util.h                                  |  21 +-
 kernel/sys_ni.c                             |   3 +
 35 files changed, 271 insertions(+), 506 deletions(-)
 delete mode 100644 arch/sh/include/uapi/asm/unistd_32.h

-- 
2.20.0
Cc: ink@jurassic.park.msu.ru
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
Cc: firoz.khan@linaro.org
Cc: ebiederm@xmission.com
Cc: deepa.kernel@gmail.com
Cc: linux@dominikbrodowski.net
Cc: akpm@linux-foundation.org
Cc: dave@stgolabs.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-api@vger.kernel.org
CC: y2038@lists.linaro.org
