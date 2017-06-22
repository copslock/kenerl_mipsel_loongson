Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 17:06:51 +0200 (CEST)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:39512 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991172AbdFVPGoVG0iI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jun 2017 17:06:44 +0200
X-QQ-mid: bizesmtp7t1498143977t7esn1y0m
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 22 Jun 2017 23:06:13 +0800 (CST)
X-QQ-SSF: 01100000002000F0FLF2000A0000000
X-QQ-FEAT: 7NEolFwWs8WtF4UHXPvMnnDXpVdb+S75vT0e8KRY+FU9GrTxhoJI9EADzm5yI
        PEC6h2IX5p2mDnty4GysD2abRA5W7iVx4+5APOPxDgHbwAkgxv2+VNgEMMf2JB0u3VoFwdn
        jry+etpK97Wi2XB5XMt6qzvojL6BM0Gd4hoi8mMAxb9vhZsxVHknH7gPr+TpjjCnKYuDtGv
        exagjOhxU/zp2z5Ia7E9Y/Bjko33eDVONY4aVdyDivQRWTBw5VeyacOnM4R1rdsiOVbPgQ8
        A9BwfbqwYJT4ujR9/YXGAYSeIobZ6f+5+02w==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V7 0/9] MIPS: Loongson: feature and performance improvements
Date:   Thu, 22 Jun 2017 23:06:47 +0800
Message-Id: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58745
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

This patchset is is prepared for the next 4.13 release for Linux/MIPS.
It adds Loongson-3A R3 and Loongson's NMI handler support, adds a
"model name" knob in /proc/cpuinfo which is needed by some userspace
tools, improves I/O performance by IRQ balancing and IRQ affinity
setting, fixes indexed scache flushing for Loongson-3, and introduces
LOONGSON_LLSC_WAR to improve stability.

V1 -> V2:
1, Add Loongson-3A R3 basic support.
2, Sync the code to upstream.

V2 -> V3:
1, Add r4k_blast_scache_node for Loongson-3.
2, Update the last patch to avoid miscompilation.
3, Sync the code to upstream.

V3 -> V4:
1, Support 4 packages in CPU Hwmon driver.
2, ICT is dropped in cpu name, and cpu name can be overwritten by BIOS.
3, Sync the code to upstream.

V4 -> V5:
1, Drop some #ifdefs in the 2nd patch.
2, Improve maintainability of the 4th patch.
3, Sync the code to upstream.

V5 -> V6:
1, Update commit message in the 2nd patch.
2, Drop #ifdefs and set irq_set_affinity() at runtime in the 6th patch.
3, Sync the code to upstream.

V6 -> V7:
1, Fix bnez/beqz mistake in the last patch.
2, Sync the code to upstream.

Huacai Chen(9):
 MIPS: Loongson: Add Loongson-3A R3 basic support.
 MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3.
 MIPS: Loongson: Add NMI handler support.
 MIPS: Loongson-3: Support 4 packages in CPU Hwmon driver.
 MIPS: Loongson-3: IRQ balancing for PCI devices.
 MIPS: Loongson-3: support irq_set_affinity() in i8259 chip.
 MIPS: Loogson: Make enum loongson_cpu_type more clear.
 MIPS: Add __cpu_full_name[] to make CPU names more human-readable.
 MIPS: Loongson: Introduce and use LOONGSON_LLSC_WAR.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/atomic.h                     | 107 ++++++++
 arch/mips/include/asm/bitops.h                     | 273 ++++++++++++++++-----
 arch/mips/include/asm/cmpxchg.h                    |  54 ++++
 arch/mips/include/asm/cpu-info.h                   |   2 +
 arch/mips/include/asm/cpu.h                        |   1 +
 arch/mips/include/asm/edac.h                       |  33 ++-
 arch/mips/include/asm/futex.h                      |  62 +++++
 arch/mips/include/asm/irq.h                        |   3 +
 arch/mips/include/asm/local.h                      |  34 +++
 arch/mips/include/asm/mach-cavium-octeon/war.h     |   1 +
 arch/mips/include/asm/mach-generic/war.h           |   1 +
 arch/mips/include/asm/mach-ip22/war.h              |   1 +
 arch/mips/include/asm/mach-ip27/war.h              |   1 +
 arch/mips/include/asm/mach-ip28/war.h              |   1 +
 arch/mips/include/asm/mach-ip32/war.h              |   1 +
 arch/mips/include/asm/mach-loongson64/boot_param.h |  23 +-
 arch/mips/include/asm/mach-loongson64/war.h        |  26 ++
 arch/mips/include/asm/mach-malta/war.h             |   1 +
 arch/mips/include/asm/mach-pmcs-msp71xx/war.h      |   1 +
 arch/mips/include/asm/mach-rc32434/war.h           |   1 +
 arch/mips/include/asm/mach-rm/war.h                |   1 +
 arch/mips/include/asm/mach-sibyte/war.h            |   1 +
 arch/mips/include/asm/mach-tx49xx/war.h            |   1 +
 arch/mips/include/asm/pgtable.h                    |  19 ++
 arch/mips/include/asm/r4kcache.h                   |  30 +++
 arch/mips/include/asm/spinlock.h                   | 142 +++++++++++
 arch/mips/include/asm/war.h                        |   8 +
 arch/mips/kernel/cpu-probe.c                       |  29 ++-
 arch/mips/kernel/proc.c                            |   4 +
 arch/mips/kernel/syscall.c                         |  34 +++
 arch/mips/loongson64/Platform                      |   3 +
 arch/mips/loongson64/common/env.c                  |  30 ++-
 arch/mips/loongson64/common/init.c                 |  13 +
 arch/mips/loongson64/loongson-3/irq.c              |  53 +++-
 arch/mips/loongson64/loongson-3/smp.c              |  23 +-
 arch/mips/mm/c-r4k.c                               |  42 +++-
 arch/mips/mm/tlbex.c                               |  17 ++
 drivers/irqchip/irq-i8259.c                        |   3 +
 drivers/platform/mips/cpu_hwmon.c                  | 136 +++++-----
 39 files changed, 1059 insertions(+), 157 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson64/war.h
--
2.7.0
