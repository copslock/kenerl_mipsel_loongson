Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 10:39:03 +0200 (CEST)
Received: from smtpbg339.qq.com ([14.17.44.34]:41674 "EHLO smtpbg339.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994908AbdH2IihA0EPD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 10:38:37 +0200
X-QQ-mid: bizesmtp5t1503995863t0ldsalln
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 29 Aug 2017 16:37:30 +0800 (CST)
X-QQ-SSF: 01100000008000F0FJF1B00A0000000
X-QQ-FEAT: vvh+TVF7+rWiynUkEQpLq685n+QKNPjX+q0q8uwOwSSVe2ZgNCBGVm+4dHLu/
        pPv4t/6N1z8NgikBYhWOOcc72PV/2wpBEishvhIjcz8BD/n+dZrCexq44WwnVDvfKRknzik
        pzy0S5pmpxCuXiJMNk5qov8knvgxbiB8vrXnfuvJhJyDjlkLF3hy2W9PlrGF16KYGvVJg02
        Wn7/fskWnH8z4NgwGEuHqJFgPKQ1aIG7CtaArfNBVoCDsPWm8JviaIIDy1iwicp/reOHSxM
        2+HBEkaXTT8juK8isXcizcVSSMf21QWui59aLB8A9CYBSy9zfvhFzHi4Q=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6?= <Yeking@Red54.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Binbin Zhou <zhoubb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH RESEND v8 0/9] MIPS: Loongson: Add the Loongson-1A processor support
Date:   Tue, 29 Aug 2017 16:38:37 +0800
Message-Id: <1503995926-17125-1-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgweb:qybgweb3
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59844
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

The Loongson-1A CPU is similar with Loongson-1B/1C, which is a 32-bit SoC.

It is a cost-effective single chip system based on LS232 processor core,
and is applicable to fields such as industrial control, and security applications.
It implements the MIPS32 release 2 instruction set.

They share the same PRID, so we rewrite them into PRID_REV_LOONGSON1ABC,
and use their CPU macros to distinguish.

Due to historic reasons, devicetree is not supported on Loongson1 platform now.
Maybe it will have change in the future.

Changes since v1:

1. According commit c908656a7531771ae7642990a7c5f3c7307bd612
   (MIPS: Loongson: Naming style cleanup and rework) to fix the naming style.

Changes since v2:

1. Remove __irq_set_handler_locked().
2. Rebases on top of v4.5-rc5.

Changes since v3:

1. Rename the Loongson-1 series's PRID name.
2. Rewite Loongson-1A's clk driver.
3. Rebases on top of v4.10-rc2.

Changes since v4:

1. Fix comment's spelling error.

Changes since v5:

1. Rebases on top of v4.11-rc3.

Changes since v6:

1. Improve comment readability.
2. Rebases on top of v4.12-rc4.

Changes since v7:
1. Rename Loongson1 clk driver's spinlock name.

Binbin Zhou(9):
 MIPS: Loongson: Merge PRID macro for Loongson-1A/1B/1C
 MIPS: Loongson: Expand Loongson-1's register definition
 MIPS: Loongson: Add basic Loongson-1A CPU support
 MIPS: Loongson: Add Loongson-1A Kconfig options
 MIPS: Loongson: Add platform devices for Loongson-1A
 MIPS: Loongson: Add Loongson-1A board support
 clk: Loongson: A descriptive spinlock name for Loongson1's clk driver
 clk: Loongson: Add Loongson-1A clock support
 MIPS: Loongson: Add Loongson-1A default config file

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
-- 
 arch/mips/Kconfig                                 |  12 +++++++++
 arch/mips/configs/loongson1a_defconfig            | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/cpu-type.h                  |   3 ++-
 arch/mips/include/asm/cpu.h                       |   3 +--
 arch/mips/include/asm/mach-loongson32/irq.h       |  16 ++++++++----
 arch/mips/include/asm/mach-loongson32/loongson1.h | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 arch/mips/include/asm/mach-loongson32/platform.h  |   2 ++
 arch/mips/include/asm/mach-loongson32/regs-clk.h  |  30 ++++++++++++++++++++-
 arch/mips/include/asm/mach-loongson32/regs-mux.h  |  36 ++++++++++++++++++++++++-
 arch/mips/kernel/cpu-probe.c                      |   6 ++++-
 arch/mips/loongson32/Kconfig                      |  20 ++++++++++++++
 arch/mips/loongson32/Makefile                     |   6 +++++
 arch/mips/loongson32/Platform                     |   1 +
 arch/mips/loongson32/common/irq.c                 |   2 +-
 arch/mips/loongson32/common/platform.c            |  83 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 arch/mips/loongson32/common/setup.c               |   6 +++--
 arch/mips/loongson32/ls1a/Makefile                |   5 ++++
 arch/mips/loongson32/ls1a/board.c                 |  31 ++++++++++++++++++++++
 arch/mips/mm/c-r4k.c                              |  10 +++++++
 drivers/clk/loongson1/Makefile                    |   1 +
 drivers/clk/loongson1/clk-loongson1a.c            |  73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/loongson1/clk-loongson1b.c            |  14 +++++-----
 drivers/clk/loongson1/clk-loongson1c.c            |   8 +++---
 23 files changed, 601 insertions(+), 69 deletions(-)
 create mode 100644 arch/mips/configs/loongson1a_defconfig
 create mode 100644 arch/mips/loongson32/ls1a/Makefile
 create mode 100644 arch/mips/loongson32/ls1a/board.c
 create mode 100644 drivers/clk/loongson1/clk-loongson1a.c
--
1.9.0
