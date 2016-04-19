Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 03:48:51 +0200 (CEST)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:44859 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006933AbcDSBspcOyEL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Apr 2016 03:48:45 +0200
X-QQ-mid: bizesmtp2t1461030483t764t094
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 19 Apr 2016 09:47:55 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK60B00A0000000
X-QQ-FEAT: j16GwkBt1Efjj9V41nNIWXBhe8CJTYXmbn67TS4v30jd9nC7Q+FRw0oaHXgAP
        zmvQOosCvhPgDKZWITMN/oLiVCru/aEV/m13525KPFQzUEE8UoT4RUFmMYYn6Iin2JZ0BR+
        9XkBuJ6wIWFqIYB9/9JiUM0s/mZ0Rcp2MDR5a2Qqqn+MF5oQ5QlW/E7a9R60tOhBhAwH1BI
        tI+BiDViJ9GxNziq4Cdl8sX7Yx0DTxmYO2v0Y66r/VMiIYG40b6EUKRbiKZlzp0op/VzA/4
        7+A3IT/ZYAFALR
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 0/6] MIPS: Loongson: feature and performance improvements
Date:   Tue, 19 Apr 2016 09:48:44 +0800
Message-Id: <1461030530-1236-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53072
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

This patchset is is prepared for the next 4.7 release for Linux/MIPS.
It adds Loongson's NMI handler support, adds a "model name" knob in
/proc/cpuinfo which is needed by some userspace tools, improves I/O
performance by IRQ balancing and IRQ affinity setting, and introduces
LOONGSON_LLSC_WAR to improve stability.

Huacai Chen(6):
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
 arch/mips/include/asm/mach-sead3/war.h             |   1 +
 arch/mips/include/asm/mach-sibyte/war.h            |   1 +
 arch/mips/include/asm/mach-tx49xx/war.h            |   1 +
 arch/mips/include/asm/pgtable.h                    |  19 ++
 arch/mips/include/asm/spinlock.h                   | 142 +++++++++++
 arch/mips/include/asm/war.h                        |   8 +
 arch/mips/kernel/cpu-probe.c                       |  12 +
 arch/mips/kernel/proc.c                            |   4 +
 arch/mips/kernel/syscall.c                         |  34 +++
 arch/mips/loongson64/common/env.c                  |  11 +-
 arch/mips/loongson64/common/init.c                 |  13 +
 arch/mips/loongson64/loongson-3/irq.c              |  53 +++-
 arch/mips/loongson64/loongson-3/smp.c              |  18 +-
 arch/mips/mm/tlbex.c                               |  17 ++
 drivers/irqchip/irq-i8259.c                        |   3 +
 35 files changed, 885 insertions(+), 78 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson64/war.h
--
2.7.0
