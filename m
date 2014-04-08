Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 12:59:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:52149 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816019AbaDHK7H44N1b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 12:59:07 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DDC1F3371D56D
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 11:58:58 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 8 Apr
 2014 11:59:00 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 11:59:00 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 11:58:59 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/2] Remove SMTC Support
Date:   Tue, 8 Apr 2014 11:59:08 +0100
Message-ID: <1396954750-24762-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

This patchset removes the MIPS SMTC support.

It's for the upstream-sfr/mips-for-linux-next tree

Markos Chandras (2):
  MIPS: Remove SMTC Support
  MIPS: Kconfig: Make MIPS_MT_SMP a regular Kconfig symbol

 arch/mips/Kconfig                                  |   64 +-
 arch/mips/Kconfig.debug                            |    9 -
 arch/mips/configs/maltasmtc_defconfig              |  196 ---
 arch/mips/include/asm/asmmacro.h                   |   22 +-
 arch/mips/include/asm/cpu-info.h                   |   11 +-
 arch/mips/include/asm/fixmap.h                     |    4 -
 arch/mips/include/asm/irq.h                        |   96 --
 arch/mips/include/asm/irqflags.h                   |   31 +-
 .../include/asm/mach-malta/kernel-entry-init.h     |   30 -
 .../include/asm/mach-sead3/kernel-entry-init.h     |   31 -
 arch/mips/include/asm/mips_mt.h                    |    2 +-
 arch/mips/include/asm/mipsregs.h                   |  132 --
 arch/mips/include/asm/mmu_context.h                |  108 +-
 arch/mips/include/asm/module.h                     |    8 +-
 arch/mips/include/asm/ptrace.h                     |    3 -
 arch/mips/include/asm/r4kcache.h                   |    2 +-
 arch/mips/include/asm/smtc.h                       |   78 -
 arch/mips/include/asm/smtc_ipi.h                   |  129 --
 arch/mips/include/asm/smtc_proc.h                  |   23 -
 arch/mips/include/asm/stackframe.h                 |  196 +--
 arch/mips/include/asm/thread_info.h                |   11 +-
 arch/mips/include/asm/time.h                       |    5 +-
 arch/mips/kernel/Makefile                          |    2 -
 arch/mips/kernel/asm-offsets.c                     |    3 -
 arch/mips/kernel/cevt-r4k.c                        |   15 -
 arch/mips/kernel/cevt-smtc.c                       |  324 -----
 arch/mips/kernel/cpu-probe.c                       |    2 +-
 arch/mips/kernel/entry.S                           |   38 -
 arch/mips/kernel/genex.S                           |   55 +-
 arch/mips/kernel/head.S                            |   58 +-
 arch/mips/kernel/i8259.c                           |    4 -
 arch/mips/kernel/idle.c                            |   10 -
 arch/mips/kernel/irq-msc01.c                       |    5 -
 arch/mips/kernel/irq.c                             |   18 -
 arch/mips/kernel/mips-mt-fpaff.c                   |    2 +-
 arch/mips/kernel/mips-mt.c                         |   18 +-
 arch/mips/kernel/proc.c                            |    1 -
 arch/mips/kernel/process.c                         |    7 -
 arch/mips/kernel/r4k_switch.S                      |   33 -
 arch/mips/kernel/rtlx-mt.c                         |    1 -
 arch/mips/kernel/smp-cmp.c                         |    9 +-
 arch/mips/kernel/smp.c                             |   13 -
 arch/mips/kernel/smtc-asm.S                        |  133 --
 arch/mips/kernel/smtc-proc.c                       |  102 --
 arch/mips/kernel/smtc.c                            | 1528 --------------------
 arch/mips/kernel/sync-r4k.c                        |   17 -
 arch/mips/kernel/time.c                            |    1 -
 arch/mips/kernel/traps.c                           |   72 +-
 arch/mips/kernel/vpe-mt.c                          |   14 +-
 arch/mips/lantiq/irq.c                             |    4 +-
 arch/mips/lib/mips-atomic.c                        |   46 +-
 arch/mips/mm/c-r4k.c                               |    4 +-
 arch/mips/mm/init.c                                |   54 +-
 arch/mips/mm/tlb-r4k.c                             |   19 -
 arch/mips/mti-malta/Makefile                       |    3 -
 arch/mips/mti-malta/malta-init.c                   |    5 -
 arch/mips/mti-malta/malta-int.c                    |   19 -
 arch/mips/mti-malta/malta-setup.c                  |    4 -
 arch/mips/mti-malta/malta-smtc.c                   |  162 ---
 arch/mips/pmcs-msp71xx/Makefile                    |    1 -
 arch/mips/pmcs-msp71xx/msp_irq.c                   |   12 +-
 arch/mips/pmcs-msp71xx/msp_irq_cic.c               |   10 +-
 arch/mips/pmcs-msp71xx/msp_irq_per.c               |    6 +-
 arch/mips/pmcs-msp71xx/msp_setup.c                 |    8 -
 arch/mips/pmcs-msp71xx/msp_smtc.c                  |  104 --
 65 files changed, 53 insertions(+), 4084 deletions(-)
 delete mode 100644 arch/mips/configs/maltasmtc_defconfig
 delete mode 100644 arch/mips/include/asm/smtc.h
 delete mode 100644 arch/mips/include/asm/smtc_ipi.h
 delete mode 100644 arch/mips/include/asm/smtc_proc.h
 delete mode 100644 arch/mips/kernel/cevt-smtc.c
 delete mode 100644 arch/mips/kernel/smtc-asm.S
 delete mode 100644 arch/mips/kernel/smtc-proc.c
 delete mode 100644 arch/mips/kernel/smtc.c
 delete mode 100644 arch/mips/mti-malta/malta-smtc.c
 delete mode 100644 arch/mips/pmcs-msp71xx/msp_smtc.c

-- 
1.9.1
