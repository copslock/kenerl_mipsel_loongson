Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 04:00:51 +0200 (CEST)
Received: from smtpbgau2.qq.com ([54.206.34.216]:44293 "EHLO smtpbgau2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993893AbdHJCAo0YLHC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Aug 2017 04:00:44 +0200
X-QQ-mid: bizesmtp9t1502330418tx6fma9dd
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 10 Aug 2017 09:59:51 +0800 (CST)
X-QQ-SSF: 01100000004000F0FMF0B00A0000000
X-QQ-FEAT: YSSoAXAEBlE6uEm34q/Mr8x+TkKnZysnyT40jVZfsY9affhpw0EsYsYMIvu+a
        e5Fft+f5PblOD6R0Y0sQUDL6Cfe89UdjUSCQVE5MtuCGiKtiixpBJ07Ty2OHFZFqgNx9+sk
        WrKKlxJTqxLzo9DwacxQnEisYmmWKS9dI0jDFPN/r7ifvFcOoNWYT8WrgM0EQ9uAAmDBPln
        Kc5nZKS+CeQxJUaBFOELfLgoCC4+BF7yOKuCQGyFpyjolEM94bdTFvRzFePHV03gDI/FlTH
        ArQtYOPwuJ1k4SHhXxfG7/ki0=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 0/8] MIPS: Loongson: new features and improvements
Date:   Thu, 10 Aug 2017 10:00:25 +0800
Message-Id: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This patchset is is prepared for the next 4.14 release for Linux/MIPS.
It enable Loongson-3's SFB at runtime, adds "model name" and "CPU MHz"
knobs in /proc/cpuinfo which is needed by some userspace tools, adds
Loongson-3 kexec/kdump and CPUFreq support, fixes pmd_present() and
indexed scache flushing for Loongson-3, and introduces WAR_LLSC_MB to
improve stability.

Huacai Chen(8):
 MIPS: Loongson-3: Enable Store Fill Buffer at runtime.
 MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3.
 MIPS: Ensure pmd_present() returns false after pmd_mknotpresent().
 MIPS: Add __cpu_full_name[] to make CPU names more human-readable.
 MIPS: Align kernel load address to 64KB.
 MIPS: Loongson: Add kexec/kdump support.
 MIPS: Loongson: Make CPUFreq usable for Loongson-3.
 MIPS: Loongson: Introduce and use WAR_LLSC_MB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   5 +-
 arch/mips/include/asm/atomic.h                     |  18 +-
 arch/mips/include/asm/barrier.h                    |   6 +
 arch/mips/include/asm/bitops.h                     |  15 ++
 arch/mips/include/asm/cmpxchg.h                    |   9 +-
 arch/mips/include/asm/cpu-info.h                   |   2 +
 arch/mips/include/asm/edac.h                       |   5 +-
 arch/mips/include/asm/futex.h                      |  18 +-
 arch/mips/include/asm/io.h                         |   2 +-
 arch/mips/include/asm/local.h                      |  10 +-
 arch/mips/include/asm/mach-loongson64/boot_param.h |   1 +
 .../asm/mach-loongson64/kernel-entry-init.h        |  38 ++--
 arch/mips/include/asm/mach-loongson64/loongson.h   |   1 +
 arch/mips/include/asm/mipsregs.h                   |   2 +
 arch/mips/include/asm/pgtable-64.h                 |   5 +
 arch/mips/include/asm/pgtable.h                    |   5 +-
 arch/mips/include/asm/r4kcache.h                   |  34 +++
 arch/mips/include/asm/time.h                       |   2 +
 arch/mips/kernel/cpu-probe.c                       |  25 ++-
 arch/mips/kernel/proc.c                            |   6 +
 arch/mips/kernel/relocate_kernel.S                 |  30 +++
 arch/mips/kernel/smp.c                             |   3 +-
 arch/mips/kernel/syscall.c                         |   2 +
 arch/mips/kernel/time.c                            |   2 +
 arch/mips/loongson64/Kconfig                       |   1 +
 arch/mips/loongson64/Platform                      |   3 +
 arch/mips/loongson64/common/env.c                  |  21 ++
 arch/mips/loongson64/common/platform.c             |  13 +-
 arch/mips/loongson64/common/reset.c                | 119 +++++++++++
 arch/mips/loongson64/loongson-3/Makefile           |   2 +-
 arch/mips/loongson64/loongson-3/clock.c            | 191 +++++++++++++++++
 arch/mips/loongson64/loongson-3/smp.c              |   5 +
 arch/mips/loongson64/loongson-3/smp.h              |   1 +
 arch/mips/mm/c-r4k.c                               |  42 +++-
 arch/mips/mm/tlbex.c                               |  11 +
 drivers/cpufreq/Kconfig                            |  15 ++
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/loongson3_cpufreq.c                | 236 +++++++++++++++++++++
 38 files changed, 855 insertions(+), 52 deletions(-)
 create mode 100644 arch/mips/loongson64/loongson-3/clock.c
 create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
--
2.7.0
