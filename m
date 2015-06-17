Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2015 12:14:08 +0200 (CEST)
Received: from smtpbg298.qq.com ([184.105.67.102]:35523 "EHLO smtpbg298.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007688AbbFQKODD7xXp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Jun 2015 12:14:03 +0200
X-QQ-mid: bizesmtp4t1434536026t783t141
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 17 Jun 2015 18:13:37 +0800 (CST)
X-QQ-SSF: 01100000000000F0F632
X-QQ-FEAT: 9NFkmNiL4hcjoa71a/cEtH7uSW8RDAIRiiTMJaFB/UtUSokOb3tlLr7OXSVMh
        2MeONtuzxvajbaoxQj0gtdKAokks3a4G2jNXAUvnNGx8Wk+hjO4m3NLpbQYxTT2KS65rU75
        SLGEwn4Cng4ibpkfPjs/SV3M7QJbuofWSopHki9C3etT3G/BADqsbODpP08U6wkq17mXugF
        kQ4PBWIDsARf58E8VC7SsGo5X+2iHzjcUM//J60EjZROMEGjxc1oB
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v2 0/8] MIPS: Loongson: Add the Loongson-1A processor support
Date:   Wed, 17 Jun 2015 18:32:38 +0800
Message-Id: <1434537166-5385-1-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
X-QQ-SENDSIZE: 520
X-QQ-FName: 1E5127FA464641E1AC9A6D5131DC015C
X-QQ-LocalIP: 163.177.66.155
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47950
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

However, Loongson 1A has a bug that the pll register can't be read,
so we set the cpu clk in the inline command line.

The command line format is cpu_clk=osc_clk,cpu_mul, the osc_clk standby cpu clock
and the cpu_mul repect the clock multiplier.

For example, we use the command is cpu_clk=33333333,8

Changes since v1
----------------

According commit c908656a7531771ae7642990a7c5f3c7307bd612 
(MIPS: Loongson: Naming style cleanup and rework) to fix the naming style.

Binbin Zhou(8):
 MIPS: Loongson: Add basic Loongson-1A CPU support
 MIPS: Loongson: Add Loongson-1A Kconfig options
 MIPS: Loongson: Add platform devices for Loongson-1A/1B
 MIPS: Loongson: Add loongson-1A board support
 MIPS: Loongson-1A: Workaround for pll register can't be read
 MIPS: Loongson-1A: Add IRQ type setting support
 MIPS: Loongson-1A: Enable SPARSEMEN and HIGHMEM
 MIPS: Loongson: Add a Loongson-1A default config file

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
-- 
 arch/mips/Kconfig                                 |  11 +++++
 arch/mips/configs/ls1a_defconfig                  | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/cpu-type.h                  |   3 +-
 arch/mips/include/asm/cpu.h                       |   2 +-
 arch/mips/include/asm/mach-loongson32/irq.h       |   1 +
 arch/mips/include/asm/mach-loongson32/loongson1.h | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 arch/mips/include/asm/mach-loongson32/platform.h  |  11 +++++
 arch/mips/include/asm/sparsemem.h                 |   6 ++-
 arch/mips/kernel/cpu-probe.c                      |   6 ++-
 arch/mips/loongson32/Kconfig                      |  21 ++++++++++
 arch/mips/loongson32/Makefile                     |   6 +++
 arch/mips/loongson32/Platform                     |   1 +
 arch/mips/loongson32/common/irq.c                 |  46 +++++++++++++++++++++
 arch/mips/loongson32/common/platform.c            | 298 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 arch/mips/loongson32/common/reset.c               |   6 +++
 arch/mips/loongson32/common/setup.c               |  45 ++++++++++++++++++++-
 arch/mips/loongson32/common/time.c                |  11 +++++
 arch/mips/loongson32/ls1a/Makefile                |   5 +++
 arch/mips/loongson32/ls1a/board.c                 | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/c-r4k.c                              |   7 ++++
 drivers/clk/clk-ls1x.c                            |  19 +++++++--
 21 files changed, 886 insertions(+), 39 deletions(-)
 create mode 100644 arch/mips/configs/ls1a_defconfig
 create mode 100644 arch/mips/loongson32/ls1a/Makefile
 create mode 100644 arch/mips/loongson32/ls1a/board.c
--
1.9.0
