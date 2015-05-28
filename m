Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 13:54:23 +0200 (CEST)
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:52319 "EHLO
        e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012988AbbE1LxD1aPB3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 13:53:03 +0200
Received: from /spool/local
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dingel@linux.vnet.ibm.com>;
        Thu, 28 May 2015 12:52:59 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 28 May 2015 12:52:58 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8215917D8067;
        Thu, 28 May 2015 12:53:53 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4SBqvqm24576070;
        Thu, 28 May 2015 11:52:57 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4SBqmY9011016;
        Thu, 28 May 2015 05:52:57 -0600
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t4SBqkfq010962;
        Thu, 28 May 2015 05:52:46 -0600
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 2944)
        id 35E8F1224437; Thu, 28 May 2015 13:52:46 +0200 (CEST)
From:   Dominik Dingel <dingel@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Zhen <zhenzhang.zhang@huawei.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nathan Lynch <nathan_lynch@mentor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Jason J. Herne" <jjherne@linux.vnet.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/5] Remove s390 sw-emulated hugepages and cleanup 
Date:   Thu, 28 May 2015 13:52:32 +0200
Message-Id: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.3.7
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15052811-0021-0000-0000-00000412AE26
Return-Path: <dingel@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dingel@linux.vnet.ibm.com
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

Hi everyone,

there is a potential bug with KVM and hugetlbfs if the hardware does not
support hugepages (EDAT1).
We fix this by making EDAT1 a hard requirement for hugepages and 
therefore removing and simplifying code.

As s390, with the sw-emulated hugepages, was the only user of arch_prepare/release_hugepage
I also removed theses calls from common and other architecture code.

Thanks,
    Dominik

Dominik Dingel (5):
  s390/mm: make hugepages_supported a boot time decision
  mm/hugetlb: remove unused arch hook prepare/release_hugepage
  mm/hugetlb: remove arch_prepare/release_hugepage from arch headers
  s390/hugetlb: remove dead code for sw emulated huge pages
  s390/mm: forward check for huge pmds to pmd_large()

 arch/arm/include/asm/hugetlb.h     |  9 ------
 arch/arm64/include/asm/hugetlb.h   |  9 ------
 arch/ia64/include/asm/hugetlb.h    |  9 ------
 arch/metag/include/asm/hugetlb.h   |  9 ------
 arch/mips/include/asm/hugetlb.h    |  9 ------
 arch/powerpc/include/asm/hugetlb.h |  9 ------
 arch/s390/include/asm/hugetlb.h    |  3 --
 arch/s390/include/asm/page.h       |  8 ++---
 arch/s390/kernel/setup.c           |  2 ++
 arch/s390/mm/hugetlbpage.c         | 65 +++-----------------------------------
 arch/s390/mm/pgtable.c             |  2 ++
 arch/sh/include/asm/hugetlb.h      |  9 ------
 arch/sparc/include/asm/hugetlb.h   |  9 ------
 arch/tile/include/asm/hugetlb.h    |  9 ------
 arch/x86/include/asm/hugetlb.h     |  9 ------
 mm/hugetlb.c                       | 10 ------
 16 files changed, 12 insertions(+), 168 deletions(-)

-- 
2.3.7
