Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 04:13:24 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:39748 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990522AbcKNDNKHQTwm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Nov 2016 04:13:10 +0100
X-QQ-mid: bizesmtp1t1479093143tni8vs838
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 14 Nov 2016 11:12:14 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72000A0000000
X-QQ-FEAT: HBedtZhyRsoYgnM8LUjD3WsywHFIyt+uhGjSbKiKP4JJK4EOszZkm+lCILQZH
        QTpiM92Fu62stBGi8WTH1UTkn88el+Qc9XXTUfVW7lZgb+xiAfMUO0hcxOO/kW8u8QQk0GI
        eq3bhSMu0OylEKWa6WG4eSCF0ThToFXiAp5Wx9OrjUy31yh1lIaZejVCrBGJinu9EF+d7eL
        SEZwL8seHVd18M9zXIqW0TGGkbM4zZxg4RFTTbU3a1sNafesOItvQCQDWg6ktpul8KSX1/F
        /MGGni33mvy/Ki2PaedBlSXS8=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 0/7] MIPS: Loongson: feature and performance improvements
Date:   Mon, 14 Nov 2016 11:12:38 +0800
Message-Id: <1479093165-625-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55809
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

This patchset is is prepared for the next 4.10 release for Linux/MIPS.
It adds Loongson-3A R3 and Loongson's NMI handler support, adds a
"model name" knob in /proc/cpuinfo which is needed by some userspace
tools, improves I/O performance by IRQ balancing and IRQ affinity
setting, and introduces LOONGSON_LLSC_WAR to improve stability.

V1 -> V2:
1, Add Loongson-3A R3 basic support.
2, Sync the code to upstream.

Huacai Chen(7):
 MIPS: Loongson: Add Loongson-3A R3 basic support.
 MIPS: Loongson: Add NMI handler support.
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
 arch/mips/include/asm/mach-loongson64/boot_param.h |  22 +-
 arch/mips/include/asm/mach-loongson64/war.h        |  26 ++
 arch/mips/include/asm/mach-malta/war.h             |   1 +
 arch/mips/include/asm/mach-pmcs-msp71xx/war.h      |   1 +
 arch/mips/include/asm/mach-rc32434/war.h           |   1 +
 arch/mips/include/asm/mach-rm/war.h                |   1 +
 arch/mips/include/asm/mach-sibyte/war.h            |   1 +
 arch/mips/include/asm/mach-tx49xx/war.h            |   1 +
 arch/mips/include/asm/pgtable.h                    |  19 ++
 arch/mips/include/asm/spinlock.h                   | 142 +++++++++++
 arch/mips/include/asm/war.h                        |   8 +
 arch/mips/kernel/cpu-probe.c                       |  19 ++
 arch/mips/kernel/proc.c                            |   4 +
 arch/mips/kernel/syscall.c                         |  34 +++
 arch/mips/loongson64/common/env.c                  |  12 +-
 arch/mips/loongson64/common/init.c                 |  13 +
 arch/mips/loongson64/loongson-3/irq.c              |  53 +++-
 arch/mips/loongson64/loongson-3/smp.c              |  23 +-
 arch/mips/mm/tlbex.c                               |  17 ++
 drivers/irqchip/irq-i8259.c                        |   3 +
 drivers/platform/mips/cpu_hwmon.c                  |  17 +-
 36 files changed, 909 insertions(+), 84 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson64/war.h
--
2.7.0
