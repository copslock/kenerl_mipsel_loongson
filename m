Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:22:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19320 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991512AbdFESVzxa-wR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 20:21:55 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5EB2A6F3742D4;
        Mon,  5 Jun 2017 19:21:45 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 19:21:49
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/5] MIPS: FP cleanup & no-FP support
Date:   Mon, 5 Jun 2017 11:21:26 -0700
Message-ID: <20170605182131.16853-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series tidies up support for floating point a little, then
introduces support for disabling it via Kconfig. The end result is that
it becomes possible to compile a kernel which does not include any
support for userland which makes use of floating point instructions -
meaning that it never enables an FPU & does not include the FPU
emulator. The benefit of this is that if you know your userland code
will not use FP instructions then you can shrink the kernel by around
65KiB.

Applies atop v4.12-rc4.

Paul Burton (5):
  MIPS: Remove unused R6000 support
  MIPS: Move r4k FP code from r4k_switch.S to r4k_fpu.S
  MIPS: Move r2300 FP code from r2300_switch.S to r2300_fpu.S
  MIPS: Remove unused ST_OFF from r2300_switch.S
  MIPS: Allow floating point support to be disabled

 arch/mips/Kconfig                    |  41 ++++---
 arch/mips/Makefile                   |   3 +-
 arch/mips/include/asm/cpu-features.h |  11 +-
 arch/mips/include/asm/cpu-type.h     |   5 -
 arch/mips/include/asm/cpu.h          |   5 -
 arch/mips/include/asm/dsemul.h       |  34 ++++++
 arch/mips/include/asm/fpu.h          |   3 +
 arch/mips/include/asm/fpu_emulator.h |  16 +++
 arch/mips/include/asm/module.h       |   2 -
 arch/mips/kernel/Makefile            |  13 ++-
 arch/mips/kernel/cpu-probe.c         |  18 ----
 arch/mips/kernel/octeon_switch.S     |   5 -
 arch/mips/kernel/process.c           |   8 ++
 arch/mips/kernel/r2300_fpu.S         |  78 +++++++++++++-
 arch/mips/kernel/r2300_switch.S      |  81 --------------
 arch/mips/kernel/r4k_fpu.S           | 196 +++++++++++++++++++++++++++++++++
 arch/mips/kernel/r4k_switch.S        | 203 -----------------------------------
 arch/mips/kernel/r6000_fpu.S         |  99 -----------------
 arch/mips/kernel/traps.c             |  15 ---
 arch/mips/mm/tlbex.c                 |   5 -
 20 files changed, 376 insertions(+), 465 deletions(-)
 delete mode 100644 arch/mips/kernel/r6000_fpu.S

-- 
2.13.0
