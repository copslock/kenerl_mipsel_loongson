Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:14:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13697 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991759AbcKGLOjq3-Od (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:14:39 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 46A634F125256;
        Mon,  7 Nov 2016 11:14:31 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:14:33 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/10] MIPS: Cleanup EXPORT_SYMBOL usage
Date:   Mon, 7 Nov 2016 11:14:06 +0000
Message-ID: <20161107111417.11486-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55683
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

This series takes advantage of the recent support for using
EXPORT_SYMBOL from assembly source to move symbols exports for functions
written in assembly to be performed close to the definition of the
function itself. The result is that mips_ksyms.c can be removed
entirely.

Along the way we make the handling of functions written (or at least
stubbed) in assembly a little more consistent for microMIPS kernels.

Applies atop v4.9-rc4.


Paul Burton (10):
  MIPS: Use generic asm/export.h
  MIPS: tlbex: Clear ISA bit when writing to handle_tlb{l,m,s}
  MIPS: End asm function prologue macros with .insn
  MIPS: Export _save_fp & _save_msa alongside their definitions
  MIPS: Export _mcount alongside its definition
  MIPS: Export invalid_pte_table alongside its definition
  MIPS: Export csum functions alongside their definitions
  MIPS: Export string functions alongside their definitions
  MIPS: Export memcpy & memset functions alongside their definitions
  MIPS: Export {copy,clear}_page functions alongside their definitions

 arch/mips/cavium-octeon/octeon-memcpy.S |  5 ++
 arch/mips/include/asm/Kbuild            |  1 +
 arch/mips/include/asm/asm.h             | 10 ++--
 arch/mips/kernel/Makefile               |  2 +-
 arch/mips/kernel/mcount.S               |  2 +
 arch/mips/kernel/mips_ksyms.c           | 94 ---------------------------------
 arch/mips/kernel/r2300_switch.S         |  2 +
 arch/mips/kernel/r4k_switch.S           |  3 ++
 arch/mips/lib/csum_partial.S            |  6 +++
 arch/mips/lib/memcpy.S                  |  9 ++++
 arch/mips/lib/memset.S                  |  5 ++
 arch/mips/lib/strlen_user.S             |  2 +
 arch/mips/lib/strncpy_user.S            |  5 ++
 arch/mips/lib/strnlen_user.S            |  3 ++
 arch/mips/mm/init.c                     |  2 +
 arch/mips/mm/page-funcs.S               |  3 ++
 arch/mips/mm/page.c                     |  2 +
 arch/mips/mm/tlbex.c                    |  6 +--
 18 files changed, 60 insertions(+), 102 deletions(-)
 delete mode 100644 arch/mips/kernel/mips_ksyms.c

-- 
2.10.2
