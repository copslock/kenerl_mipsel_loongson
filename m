Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2012 15:52:54 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:43507 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903451Ab2HTNwq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Aug 2012 15:52:46 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 20 Aug 2012 06:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,797,1336374000"; 
   d="scan'208";a="136222980"
Received: from blue.fi.intel.com ([10.237.72.50])
  by AZSMGA002.ch.intel.com with ESMTP; 20 Aug 2012 06:52:32 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 47DB6E0073; Mon, 20 Aug 2012 16:52:43 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alex Shi <alex.shu@intel.com>,
        Jan Beulich <jbeulich@novell.com>,
        Robert Richter <robert.richter@amd.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v4 0/8] Avoid cache trashing on clearing huge/gigantic page
Date:   Mon, 20 Aug 2012 16:52:29 +0300
Message-Id: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill.shutemov@linux.intel.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Clearing a 2MB huge page will typically blow away several levels of CPU
caches.  To avoid this only cache clear the 4K area around the fault
address and use a cache avoiding clears for the rest of the 2MB area.

This patchset implements cache avoiding version of clear_page only for
x86. If an architecture wants to provide cache avoiding version of
clear_page it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
clear_page_nocache() and clear_user_highpage_nocache().

v4:
  - vm.clear_huge_page_nocache sysctl;
  - rework page iteration in clear_{huge,gigantic}_page according to
    Andrea Arcangeli suggestion;
v3:
  - Rebased to current Linus' tree. kmap_atomic() build issue is fixed;
  - Pass fault address to clear_huge_page(). v2 had problem with clearing
    for sizes other than HPAGE_SIZE;
  - x86: fix 32bit variant. Fallback version of clear_page_nocache() has
    been added for non-SSE2 systems;
  - x86: clear_page_nocache() moved to clear_page_{32,64}.S;
  - x86: use pushq_cfi/popq_cfi instead of push/pop;
v2:
  - No code change. Only commit messages are updated;
  - RFC mark is dropped;

Andi Kleen (5):
  THP: Use real address for NUMA policy
  THP: Pass fault address to __do_huge_pmd_anonymous_page()
  x86: Add clear_page_nocache
  mm: make clear_huge_page cache clear only around the fault address
  x86: switch the 64bit uncached page clear to SSE/AVX v2

Kirill A. Shutemov (3):
  hugetlb: pass fault address to hugetlb_no_page()
  mm: pass fault address to clear_huge_page()
  mm: implement vm.clear_huge_page_nocache sysctl

 Documentation/sysctl/vm.txt      |   13 ++++++
 arch/x86/include/asm/page.h      |    2 +
 arch/x86/include/asm/string_32.h |    5 ++
 arch/x86/include/asm/string_64.h |    5 ++
 arch/x86/lib/Makefile            |    3 +-
 arch/x86/lib/clear_page_32.S     |   72 +++++++++++++++++++++++++++++++++++
 arch/x86/lib/clear_page_64.S     |   78 ++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c              |    7 +++
 include/linux/mm.h               |    7 +++-
 kernel/sysctl.c                  |   12 ++++++
 mm/huge_memory.c                 |   17 ++++----
 mm/hugetlb.c                     |   39 ++++++++++---------
 mm/memory.c                      |   72 ++++++++++++++++++++++++++++++----
 13 files changed, 294 insertions(+), 38 deletions(-)
 create mode 100644 arch/x86/lib/clear_page_32.S

-- 
1.7.7.6
