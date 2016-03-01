Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 01:48:14 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33524 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007995AbcCAAsLtEF98 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 01:48:11 +0100
Received: by mail-pa0-f68.google.com with SMTP id y7so9464981paa.0;
        Mon, 29 Feb 2016 16:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RjemBZ/V83qllIEBSCmzohWvehPImWk+PBBdIoUypKY=;
        b=Pj/ZC0kk1RoU7xUlaMvZM/kVi/qtKN1xMyn/q4XtRQOSxwjNB1GvDoJFbhIqRMVvH5
         FH9lwYz9eEGJYRRR2K8SM1zbFDieEFtkanUavfBwDyAjb0iJDbG95JtpdnLCHlOyeIEP
         ztNQ3RsJCDXKUhaATyWUUUvLy8sfya+XQNplHf2Wd8n7xF33tzmoVpmyA2b91CJMVIuX
         bj3I3yy6cklFX7HN+P69kg8516A7D+RjE2B944e3x0Bcd1e4ksjyLDiQ9/6zeMAuIgEt
         NHGZ/j0edwN0RgnfBvNvVQebqcDDVuSsmvkV6HhnOD6f9YNAe4EbL4K9UmsvYxxyIKDL
         PuPA==
X-Gm-Message-State: AD7BkJJBjiVHfGg04vWJYwsSj00/ZEsS3suJFcImOogvr7hlVDqygkTNiPWpmWciyQ7m9Q==
X-Received: by 10.66.221.10 with SMTP id qa10mr25838501pac.4.1456793285959;
        Mon, 29 Feb 2016 16:48:05 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id s197sm40683975pfs.62.2016.02.29.16.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 16:48:05 -0800 (PST)
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v3 0/8] MIPS: Loongson: Add the Loongson-1A processor support
Date:   Tue,  1 Mar 2016 08:48:08 +0800
Message-Id: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <zhoubb.aaron@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52363
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

Changes since v1:

1. According commit c908656a7531771ae7642990a7c5f3c7307bd612
   (MIPS: Loongson: Naming style cleanup and rework) to fix the naming style.

Changes since v2:

1. Remove __irq_set_handler_locked()
2. Rebases on top of v4.5-rc5.

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
 arch/mips/configs/ls1a_defconfig                  | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
