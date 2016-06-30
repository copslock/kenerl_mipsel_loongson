Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 12:49:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39563 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992011AbcF3KtFeWhpj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 12:49:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CE0A29C38D928;
        Thu, 30 Jun 2016 11:48:53 +0100 (IST)
Received: from localhost (10.100.200.138) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Jun
 2016 11:48:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Maciej Rozycki <maciej.rozycki@imgtec.com>,
        Faraz Shahbazker <faraz.shahbazker@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v4 0/2] MIPS non-executable stack support
Date:   Thu, 30 Jun 2016 11:48:40 +0100
Message-ID: <20160630104842.14361-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.138]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54186
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

This series allows us to support non-executable stacks on systems with
RIXI by moving delay slot instruction emulation off of the user stack &
into a dedicated page.

This is a revision of patches 6114/6125 & 6115 from a few years back:

    https://patchwork.linux-mips.org/patch/6114
    https://patchwork.linux-mips.org/patch/6125
    https://patchwork.linux-mips.org/patch/6115

The series applies atop v4.7-rc5, and is marked RFC as it could use a
little more testing before I'd be happy with it being merged.

Paul Burton (2):
  MIPS: use per-mm page to execute branch delay slot instructions
  MIPS: non-exec stack & heap when non-exec PT_GNU_STACK is present

 arch/mips/Kconfig                     |   1 +
 arch/mips/include/asm/dsemul.h        |  90 +++++++++
 arch/mips/include/asm/elf.h           |   5 +
 arch/mips/include/asm/fpu_emulator.h  |  17 +-
 arch/mips/include/asm/mmu.h           |  11 ++
 arch/mips/include/asm/mmu_context.h   |   7 +
 arch/mips/include/asm/page.h          |   6 +-
 arch/mips/include/asm/processor.h     |  18 +-
 arch/mips/kernel/elf.c                |  19 ++
 arch/mips/kernel/mips-r2-to-r6-emul.c |   8 +-
 arch/mips/kernel/process.c            |   6 +
 arch/mips/kernel/signal.c             |   8 +
 arch/mips/math-emu/cp1emu.c           |   8 +-
 arch/mips/math-emu/dsemul.c           | 342 +++++++++++++++++++++++-----------
 14 files changed, 411 insertions(+), 135 deletions(-)
 create mode 100644 arch/mips/include/asm/dsemul.h

-- 
2.9.0
