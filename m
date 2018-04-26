Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 16:29:14 +0200 (CEST)
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49541 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990502AbeDZO2v4sca0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2018 16:28:51 +0200
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BE320218C7;
        Thu, 26 Apr 2018 10:28:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Apr 2018 10:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=E3PNGaPY3F0M0e8EkFenEXv92XVCiiZdXpeNhL1n9
        G0=; b=G3elfgiAVIAQADB3Holant1pjyQ0HgJAuXhfbp3RGMNt3jMbTLj74Gp5h
        SAY0YFHwxlHKX4lX33f/V1gwDZmjoI3QaowuG5sxvxJFXfpvmcpWe7l631GilvD9
        0Pdo8SQx0zdUYHn+udcBAjfu9e2Bvo+jKIDtliQlZe63W8iy88nEpwbib9DftQ9d
        tKMNABXcwcJvLjnO8U6Vb/xMlkOB2T+9XaEnX7Gpg9IBLfthfT1lKwTSnmwnIkJR
        LJxGiq8yYtrb+poUNKulgOFAz28/lyIADdBMNpa7nsfamIE4lutSXqU3Z35Li/1x
        htuV2yvgCJDKkCS/9YCzzmDZrG5xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=E3PNGaPY3F0M0e8Ek
        FenEXv92XVCiiZdXpeNhL1n9G0=; b=OytRFPk8rOxxkB++nXDW3NokaFEl8FUP6
        jiyQLwhpB8ilytZ7tQURo10iTrDSB+ZjU+Cgz6u2St3QWCHyZLaq0Bk9jfPJl6If
        il1JmId59kLXWBoSnWpjDCo2EieFzSGPOpSUQmtnPEdE/FwVQH/vsibNLJ30Hoh9
        jVH82CCMhQROxZdW+B2GQI6ytiLauGGs7ebBbolmgTxN/QKkZV8nPB9ursnlslYe
        iqpWtakGarexifNBQO/PexJ5cRS1PyVycBxp+xxsK/Xp6QOOgbr/PYvFLrzCDjEu
        4bUSwja1/4FvNvSNMhUZ4AsZiIQPvpUa9VWT3tl1O6/diAahF6i2g==
X-ME-Sender: <xms:IuLhWrPShpjiFfcdkekIxBtJULBqWa2UjgStwi1WtFhi0B8ib_qajA>
Received: from tenansix.rutgers.edu (pool-165-230-225-59.nat.rutgers.edu [165.230.225.59])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9CB7E47A0;
        Thu, 26 Apr 2018 10:28:49 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zi Yan <zi.yan@cs.rutgers.edu>, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
Subject: [RFC PATCH 0/9] Enable THP migration for all possible architectures
Date:   Thu, 26 Apr 2018 10:27:55 -0400
Message-Id: <20180426142804.180152-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.17.0
Return-Path: <zi.yan@sent.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zi.yan@sent.com
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

From: Zi Yan <zi.yan@cs.rutgers.edu>

Hi all,

THP migration is only enabled on x86_64 with a special
ARCH_ENABLE_THP_MIGRATION macro. This patchset enables THP migration for
all architectures that uses transparent hugepage, so that special macro can
be dropped. Instead, THP migration is enabled/disabled via
/sys/kernel/mm/transparent_hugepage/enable_thp_migration.

I grepped for TRANSPARENT_HUGEPAGE in arch folder and got 9 architectures that
are supporting transparent hugepage. I mechanically add __pmd_to_swp_entry() and
__swp_entry_to_pmd() based on existing __pte_to_swp_entry() and
__swp_entry_to_pte() for all these architectures, except tile which is going to
be dropped.

I have successfully compiled all these architectures, but have NOT tested them
due to lack of real hardware. I appreciate your help, if the maintainers of
these architectures can do a quick test with the code from
https://github.com/x-y-z/thp-migration-bench . Please apply patch 9 as well
to enable THP migration.

By enabling THP migration, migrating a 2MB THP on x86_64 machines takes only 1/3
time of migrating equivalent 512 4KB pages.

Hi Naoya, I also add soft dirty support for powerpc and s390. It would be great
if you can take a look at patch 6 & 7.

Feel free to give comments. Thanks.

Cc: linux-mm@kvack.org
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mips@linux-mips.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>


Zi Yan (9):
  arc: mm: migrate: add pmd swap entry to support thp migration.
  arm: mm: migrate: add pmd swap entry to support thp migration.
  arm64: mm: migrate: add pmd swap entry to support thp migration.
  i386: mm: migrate: add pmd swap entry to support thp migration.
  mips: mm: migrate: add pmd swap entry to support thp migration.
  powerpc: mm: migrate: add pmd swap entry to support thp migration.
  s390: mm: migrate: add pmd swap entry to support thp migration.
  sparc: mm: migrate: add pmd swap entry to support thp migration.
  mm: migrate: enable thp migration for all possible architectures.

 arch/arc/include/asm/pgtable.h               |  2 ++
 arch/arm/include/asm/pgtable.h               |  2 ++
 arch/arm64/include/asm/pgtable.h             |  2 ++
 arch/mips/include/asm/pgtable-64.h           |  2 ++
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 ++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 17 ++++++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 ++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 ++
 arch/s390/include/asm/pgtable.h              |  5 ++++
 arch/sparc/include/asm/pgtable_32.h          |  2 ++
 arch/sparc/include/asm/pgtable_64.h          |  2 ++
 arch/x86/Kconfig                             |  4 ---
 arch/x86/include/asm/pgtable-2level.h        |  2 ++
 arch/x86/include/asm/pgtable-3level.h        |  2 ++
 arch/x86/include/asm/pgtable.h               |  2 --
 fs/proc/task_mmu.c                           |  2 --
 include/asm-generic/pgtable.h                | 21 ++-------------
 include/linux/huge_mm.h                      |  9 +++----
 include/linux/swapops.h                      |  4 +--
 mm/Kconfig                                   |  3 ---
 mm/huge_memory.c                             | 27 +++++++++++++-------
 mm/migrate.c                                 |  6 ++---
 mm/rmap.c                                    |  5 ++--
 23 files changed, 73 insertions(+), 54 deletions(-)

-- 
2.17.0
