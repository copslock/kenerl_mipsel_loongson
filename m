Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 12:53:52 +0200 (CEST)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:56127 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029931AbcERKwrKF8i1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 May 2016 12:52:47 +0200
X-QQ-mid: bizesmtp3t1463568734t602t094
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 18 May 2016 18:52:03 +0800 (CST)
X-QQ-SSF: 01100000002000F0FF50000A0000000
X-QQ-FEAT: KpQd4QySBZWAwUvNEpc3AgLYvYzG/6H2jOgfR7uM0ICXs8alvRzHpbOzjtIjG
        ijePY5hCHPKmsuRyeIK83HfcQdsPtdO+r5eBD0VgEnDe8uolmy80FFPJRcwopIiSeumM5Ec
        eqnBOQLfN+bHhx5VHh5VBsojFU2tu4ZvU7QRD8z0o0X0s3vwEBZYWKIMnvO97hfiBsuu38b
        LBj4iMHDHXCUiFhwlfFN1zdEcxQu7Uo+MBzbN5DCqidJMBcHvThdCopBJrb90S30qXlQcuj
        eFm/QK+CBNKT0eAADvSYNOP3o=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuichboo@163.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v3 0/8] MIPS: Loongson: Add the Loongson-1A processor support
Date:   Wed, 18 May 2016 18:49:54 +0800
Message-Id: <1463568601-25042-1-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

The Loongson 1A is similar with Loongson 1B, which is a 32-bit SoC.
It implements the MIPS32 release 2 instruction set.

They share the same PRID, so we rewrite the PRID_REV_LOONGSON1B to
PRID_REV_LOONGSON1A_1B, and use their CPU macros to distinguish.

However, the pll register of Loongson-1A is write-only, so the cpu clk 
should be set manually with the command line.

The format of command is cpu_clk=osc_clk,cpu_mul
the osc_clk standby cpu clock and the cpu_mul repect the clock multiplier.

For example, we use the command cpu_clk=33333333,8

Changes since v1:

- According commit c908656a7531771ae7642990a7c5f3c7307bd612
  (MIPS: Loongson: Naming style cleanup and rework) to fix the naming style.

Changes since v2:

- Remove__irq_set_handler_locked()
- Rebases on top of v4.5-rc5.

Changes since v3:
- Move ls1x CPU irq setting to driver/irqchip
- Rebases on top of v4.6-rc7.

Binbin Zhou(9):
 MIPS: Loongson: Add basic Loongson-1A CPU support
 MIPS: Loongson: Add Loongson-1A Kconfig options
 MIPS: Loongson: Add platform devices for Loongson-1A/1B
 MIPS: Loongson: Add loongson-1A board support
 MIPS: Loongson-1A: workaround of pll register's write-only property
 MIPS: irqchip/ls1x-cpu: Move the CPU IRQ driver from arch/mips/loongson32/common/
 MIPS: Loongson-1A: Enable SPARSEMEN and HIGHMEM
 MIPS: Loongson-1B: Update config file
 MIPS: Loongson: Add a Loongson-1A default config file

Signed-off-by: Chunbo Cui <cuichboo@163.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
-- 
 arch/mips/Kconfig                                 |  11 ++++++
 arch/mips/configs/loongson1a_defconfig            | 131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/configs/loongson1b_defconfig            |   3 +-
 arch/mips/include/asm/cpu-type.h                  |   3 +-
 arch/mips/include/asm/cpu.h                       |   2 +-
 arch/mips/include/asm/irq_cpu.h                   |   1 +
 arch/mips/include/asm/mach-loongson32/dma.h       |   1 +
 arch/mips/include/asm/mach-loongson32/irq.h       |   1 +
 arch/mips/include/asm/mach-loongson32/loongson1.h | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 arch/mips/include/asm/mach-loongson32/nand.h      |   1 +
 arch/mips/include/asm/mach-loongson32/platform.h  |  14 ++++++++
 arch/mips/include/asm/mach-loongson32/regs-mux.h  |   2 +-
 arch/mips/include/asm/sparsemem.h                 |   6 +++-
 arch/mips/kernel/cpu-probe.c                      |   6 +++-
 arch/mips/loongson32/Kconfig                      |  17 +++++++++
 arch/mips/loongson32/Makefile                     |   6 ++++
 arch/mips/loongson32/Platform                     |   1 +
 arch/mips/loongson32/common/irq.c                 | 128 +------------------------------------------------------------------
 arch/mips/loongson32/common/platform.c            | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 arch/mips/loongson32/common/prom.c                |   6 ++++
 arch/mips/loongson32/common/reset.c               |   6 ++++
 arch/mips/loongson32/common/setup.c               |  49 +++++++++++++++++++++++++-
 arch/mips/loongson32/ls1a/Makefile                |   5 +++
 arch/mips/loongson32/ls1a/board.c                 | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/c-r4k.c                              |   9 +++++
 drivers/clk/clk-ls1x.c                            |  22 +++++++++---
 drivers/irqchip/Makefile                          |   1 +
 drivers/irqchip/irq-ls1x-cpu.c                    | 241 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 28 files changed, 1053 insertions(+), 181 deletions(-)
 create mode 100644 arch/mips/configs/loongson1a_defconfig
 create mode 100644 arch/mips/loongson32/ls1a/Makefile
 create mode 100644 arch/mips/loongson32/ls1a/board.c
 create mode 100644 drivers/irqchip/irq-ls1x-cpu.c
--
1.9.0
