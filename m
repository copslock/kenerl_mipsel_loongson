Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 06:59:48 +0200 (CEST)
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34439 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993003AbeGEE7kbi6O0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2018 06:59:40 +0200
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D83741BF208;
        Thu,  5 Jul 2018 04:59:10 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 00/11] hugetlb: Factorize architecture hugetlb primitives  
Date:   Thu,  5 Jul 2018 04:58:36 +0000
Message-Id: <20180705045847.32575-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@ghiti.fr
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

In order to reduce copy/paste of functions across architectures and then
make riscv hugetlb port (and future ports) simpler and smaller, this patchset
intends to factorize the numerous hugetlb primitives that are defined across all
the architectures.

Except for prepare_hugepage_range, this patchset moves the versions that
are just pass-through to standard pte primitives into
asm-generic/hugetlb.h by using the same #ifdef semantic that can be
found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.

s390 architecture has not been tackled in this serie since it does not
use asm-generic/hugetlb.h at all.
powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).

This patchset has been compiled on x86 only.

Alexandre Ghiti (11):
  hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
  hugetlb: Introduce generic version of hugetlb_free_pgd_range
  hugetlb: Introduce generic version of set_huge_pte_at
  hugetlb: Introduce generic version of huge_ptep_get_and_clear
  hugetlb: Introduce generic version of huge_ptep_clear_flush
  hugetlb: Introduce generic version of huge_pte_none
  hugetlb: Introduce generic version of huge_pte_wrprotect
  hugetlb: Introduce generic version of prepare_hugepage_range
  hugetlb: Introduce generic version of huge_ptep_set_wrprotect
  hugetlb: Introduce generic version of huge_ptep_set_access_flags
  hugetlb: Introduce generic version of huge_ptep_get

 arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
 arch/arm/include/asm/hugetlb.h               | 33 +----------
 arch/arm64/include/asm/hugetlb.h             | 39 +++---------
 arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
 arch/mips/include/asm/hugetlb.h              | 40 +++----------
 arch/parisc/include/asm/hugetlb.h            | 33 +++--------
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
 arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
 arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
 arch/sh/include/asm/hugetlb.h                | 54 ++---------------
 arch/sparc/include/asm/hugetlb.h             | 40 +++----------
 arch/x86/include/asm/hugetlb.h               | 72 +----------------------
 include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
 15 files changed, 143 insertions(+), 384 deletions(-)

-- 
2.16.2
