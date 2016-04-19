Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 10:25:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5527 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027002AbcDSIZe68DcY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 10:25:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 32B0615E5580A;
        Tue, 19 Apr 2016 09:25:26 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 19 Apr 2016 09:25:28 +0100
Received: from localhost (10.100.200.185) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 19 Apr
 2016 09:25:28 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, Paul Burton
        <paul.burton@imgtec.com>, "Maciej W. Rozycki" <macro@imgtec.com>, "Joshua
 Kinard" <kumba@gentoo.org>, Huacai Chen <chenhc@lemote.com>, "Maciej W.
 Rozycki" <macro@linux-mips.org>, Paul Gortmaker
        <paul.gortmaker@windriver.com>, Aneesh Kumar K.V
        <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, David Hildenbrand
        <dahi@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "David
 Daney" <david.daney@cavium.com>, Jonas Gorski <jogo@openwrt.org>, "Markos
 Chandras" <markos.chandras@imgtec.com>, Ingo Molnar <mingo@kernel.org>,
        "Jerome Marchand" <jmarchan@redhat.com>, Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 00/13] TLB/XPA fixes & cleanups
Date:   Tue, 19 Apr 2016 09:24:58 +0100
Message-ID: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.185]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53080
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

This series fixes up a number of issues introduced by commit
c5b367835cfc ("MIPS: Add support for XPA."), including breakage of the
MIPS32 with 36 bit physical addressing case & clobbering of $1 upon TLB
refill exceptions. Along the way a number of cleanups are made, which
leaves pgtable-bits.h in particular much more readable than before.

The series applies atop v4.6-rc4.

James Hogan (4):
  MIPS: Separate XPA CPU feature into LPA and MVH
  MIPS: Fix HTW config on XPA kernel without LPA enabled
  MIPS: mm: Don't clobber $1 on XPA TLB refill
  MIPS: mm: Don't do MTHC0 if XPA not present

Paul Burton (9):
  MIPS: Remove redundant asm/pgtable-bits.h inclusions
  MIPS: Use enums to make asm/pgtable-bits.h readable
  MIPS: mm: Standardise on _PAGE_NO_READ, drop _PAGE_READ
  MIPS: mm: Unify pte_page definition
  MIPS: mm: Fix MIPS32 36b physical addressing (alchemy, netlogic)
  MIPS: mm: Pass scratch register through to iPTE_SW
  MIPS: mm: Be more explicit about PTE mode bit handling
  MIPS: mm: Simplify build_update_entries
  MIPS: mm: Panic if an XPA kernel is run without RIXI

 arch/mips/include/asm/cpu-features.h |   8 +-
 arch/mips/include/asm/cpu.h          |   3 +-
 arch/mips/include/asm/pgtable-32.h   |  33 +++++-
 arch/mips/include/asm/pgtable-bits.h | 211 ++++++++++++++++-------------------
 arch/mips/include/asm/pgtable.h      |  78 +++++++++----
 arch/mips/kernel/cpu-probe.c         |   6 +-
 arch/mips/kernel/head.S              |   1 -
 arch/mips/kernel/r4k_switch.S        |   1 -
 arch/mips/mm/init.c                  |  12 +-
 arch/mips/mm/tlb-r4k.c               |   6 +-
 arch/mips/mm/tlbex.c                 | 116 +++++++++----------
 11 files changed, 263 insertions(+), 212 deletions(-)

-- 
2.8.0
