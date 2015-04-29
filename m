Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 05:41:30 +0200 (CEST)
Received: from smtpbgbr1.qq.com ([54.207.19.206]:55644 "EHLO smtpbgbr1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012194AbbD2Dkgr8WKj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Apr 2015 05:40:36 +0200
X-QQ-mid: bizesmtp2t1430278769t826t154
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Apr 2015 11:39:14 +0800 (CST)
X-QQ-SSF: 01100000002000F0F212B00A0000000
X-QQ-FEAT: lyWtu7kgzwvkLm1NbjFVYGpp/6pU2cTSxs/3zrec6k0phkccisTGICGzAeSGM
        gZ63cyEnj9hIn25qcIr+v3bhuD5zI0MD9DA1+uR2xotMFimxdQXRArCvpmm851x+hNYEy8C
        Pm5QXwih74GpdzbKQfP8Aer/pd+KhlWsozf52ZB+J5vLHD9zkwiZjkzXfmZIVpCFChOzyxH
        bMU3Q3J+OP4zWg+uiPw2zb3V8ahYjzWyHTthaS0flRQ==
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 0/8] MIPS: Loongson: Add basic Loongson-1A CPU support
Date:   Wed, 29 Apr 2015 11:57:19 +0800
Message-Id: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47155
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
 arch/mips/Kconfig                                |  11 +++++
 arch/mips/configs/ls1a_defconfig                 | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/cpu-type.h                 |   3 +-
 arch/mips/include/asm/cpu.h                      |   2 +-
 arch/mips/include/asm/mach-loongson1/irq.h       |   1 +
 arch/mips/include/asm/mach-loongson1/loongson1.h | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 arch/mips/include/asm/mach-loongson1/platform.h  |  11 +++++
 arch/mips/include/asm/sparsemem.h                |   6 ++-
 arch/mips/kernel/cpu-probe.c                     |   6 ++-
 arch/mips/loongson1/Kconfig                      |  21 ++++++++++
 arch/mips/loongson1/Makefile                     |   1 +
 arch/mips/loongson1/Platform                     |   1 +
 arch/mips/loongson1/common/irq.c                 |  46 ++++++++++++++++++++
 arch/mips/loongson1/common/platform.c            | 298 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 arch/mips/loongson1/common/reset.c               |   6 +++
 arch/mips/loongson1/common/setup.c               |  45 +++++++++++++++++++-
 arch/mips/loongson1/common/time.c                |  11 +++++
 arch/mips/loongson1/ls1a/Makefile                |   5 +++
 arch/mips/loongson1/ls1a/board.c                 | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/c-r4k.c                             |   7 ++++
 drivers/clk/clk-ls1x.c                           |  19 +++++++--
 21 files changed, 881 insertions(+), 39 deletions(-)
 create mode 100644 arch/mips/configs/ls1a_defconfig
 create mode 100644 arch/mips/loongson1/ls1a/Makefile
 create mode 100644 arch/mips/loongson1/ls1a/board.c
--
1.9.0
