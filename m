Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 17:03:33 +0200 (CEST)
Received: from mga14.intel.com ([143.182.124.37]:22179 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903478Ab2HIPD2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2012 17:03:28 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga102.ch.intel.com with ESMTP; 09 Aug 2012 08:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,740,1336374000"; 
   d="scan'208";a="131994017"
Received: from blue.fi.intel.com ([10.237.72.50])
  by AZSMGA002.ch.intel.com with ESMTP; 09 Aug 2012 08:03:09 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 47EF6E0073; Thu,  9 Aug 2012 18:03:13 +0300 (EEST)
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
Subject: [PATCH v2 0/6] Avoid cache trashing on clearing huge/gigantic page
Date:   Thu,  9 Aug 2012 18:02:57 +0300
Message-Id: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34075
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

v2:
  - No code change. Only commit messages are updated.
  - RFC mark is dropped.

Andi Kleen (6):
  THP: Use real address for NUMA policy
  mm: make clear_huge_page tolerate non aligned address
  THP: Pass real, not rounded, address to clear_huge_page
  x86: Add clear_page_nocache
  mm: make clear_huge_page cache clear only around the fault address
  x86: switch the 64bit uncached page clear to SSE/AVX v2

 arch/x86/include/asm/page.h          |    2 +
 arch/x86/include/asm/string_32.h     |    5 ++
 arch/x86/include/asm/string_64.h     |    5 ++
 arch/x86/lib/Makefile                |    1 +
 arch/x86/lib/clear_page_nocache_32.S |   30 +++++++++++
 arch/x86/lib/clear_page_nocache_64.S |   92 ++++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c                  |    7 +++
 mm/huge_memory.c                     |   17 +++---
 mm/memory.c                          |   29 ++++++++++-
 9 files changed, 178 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/lib/clear_page_nocache_32.S
 create mode 100644 arch/x86/lib/clear_page_nocache_64.S

-- 
1.7.7.6
