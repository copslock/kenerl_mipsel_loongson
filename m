Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 14:21:04 +0100 (CET)
Received: from smtpbg202.qq.com ([184.105.206.29]:42913 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011595AbcAZNVBf8SSX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2016 14:21:01 +0100
X-QQ-mid: bizesmtp9t1453814435t819t050
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 26 Jan 2016 21:20:27 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: IM63Dp3h0gSScrG4MmOqTFeJNSm/DsRVoYLM8Gh0n4r+SKH3YsNgfqIUJza8i
        btEDMn6bLUtEePkFNLQsn9vZkx1uTXi9HwAK6+Bc+Kd8idaKziUx9cZei2rIyDFtvaIDo7A
        a9qmLNn0qWLqbe21O8PJuGRmZSBBDdUD41++fBMqrQ4EZb3ZWcUEJsYmTIRvGZ2fXyDJ4Rf
        VYQc+hF8uHEpYF/zmVGsrHF+wZOIyDN4TMQ14jD5d2Lju9qdCloNcpwgxGrFCFFe3qBZudF
        QbMSGOyPu2pClZzsIHe8lP7hk=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 0/6] MIPS: Loongson: Add Loongson-3A R2 support
Date:   Tue, 26 Jan 2016 21:26:18 +0800
Message-Id: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51403
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

This patchset is is prepared for the next 4.6 release for Linux/MIPS.
It adds Loongson-3A R2 (Loongson-3A2000) support and fixes a potential
bug related to FTLB.

Loongson-3 CPU family:

Code-name       Brand-name       PRId
Loongson-3A R1  Loongson-3A1000  0x6305
Loongson-3A R2  Loongson-3A2000  0x6308
Loongson-3B R1  Loongson-3B1000  0x6306
Loongson-3B R2  Loongson-3B1500  0x6307

Features of R2 revision of Loongson-3A:
1, Primary cache includes I-Cache, D-Cache and V-Cache (Victim Cache).
2, I-Cache, D-Cache and V-Cache are 16-way set-associative, linesize is 64 Bytes.
3, 64 entries of VTLB (classic TLB), 1024 entries of FTLB (8-way set-associative).
4, Support DSP/DSPv2 instructions, UserLocal register and Read-Inhibit/Execute-Inhibit.

Huacai Chen(6):
 MIPS: Loongson: Add Loongson-3A R2 basic support.
 MIPS: Loongson: Invalidate special TLBs when needed.
 MIPS: Loongson-3: Fast TLB refill handler.
 MIPS: tlbex: Fix bugs in tlbchange handler.
 MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
 MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig                                  |  19 +++
 arch/mips/include/asm/cacheops.h                   |   6 +
 arch/mips/include/asm/cpu-features.h               |   6 +
 arch/mips/include/asm/cpu-info.h                   |   1 +
 arch/mips/include/asm/cpu.h                        |   6 +-
 arch/mips/include/asm/hazards.h                    |   7 +-
 arch/mips/include/asm/io.h                         |  10 +-
 arch/mips/include/asm/irqflags.h                   |   5 +
 .../asm/mach-loongson64/cpu-feature-overrides.h    |  13 +-
 .../asm/mach-loongson64/kernel-entry-init.h        |  18 ++-
 arch/mips/include/asm/mipsregs.h                   |   8 ++
 arch/mips/include/asm/pgtable-bits.h               |   8 +-
 arch/mips/include/asm/pgtable.h                    |   4 +-
 arch/mips/include/asm/uasm.h                       |   3 +-
 arch/mips/include/uapi/asm/inst.h                  |  10 ++
 arch/mips/kernel/cpu-probe.c                       |  40 +++++-
 arch/mips/kernel/idle.c                            |   5 +
 arch/mips/kernel/traps.c                           |   3 +-
 arch/mips/loongson64/common/env.c                  |   7 +-
 arch/mips/loongson64/loongson-3/smp.c              | 106 ++++++++++++--
 arch/mips/mm/c-r4k.c                               |  51 +++++++
 arch/mips/mm/page.c                                |   9 ++
 arch/mips/mm/tlb-r4k.c                             |  27 ++--
 arch/mips/mm/tlbex.c                               | 157 ++++++++++++++++++++-
 arch/mips/mm/uasm-mips.c                           |   2 +
 arch/mips/mm/uasm.c                                |   3 +
 drivers/platform/mips/cpu_hwmon.c                  |   4 +-
 27 files changed, 478 insertions(+), 60 deletions(-)
--
2.4.6
