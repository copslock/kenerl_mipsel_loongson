Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2017 17:40:06 +0200 (CEST)
Received: from mga07.intel.com ([134.134.136.100]:31222 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995047AbdILPj7y0u7y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Sep 2017 17:39:59 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP; 12 Sep 2017 08:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,383,1500966000"; 
   d="scan'208";a="134511291"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2017 08:39:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 71745569; Tue, 12 Sep 2017 18:39:47 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: [PATCHv3 05/11] mips: Use generic_pmdp_establish as pmdp_establish
Date:   Tue, 12 Sep 2017 18:39:35 +0300
Message-Id: <20170912153941.47012-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170912153941.47012-1-kirill.shutemov@linux.intel.com>
References: <20170912153941.47012-1-kirill.shutemov@linux.intel.com>
Return-Path: <kirill.shutemov@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59989
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

MIPS doesn't support hardware dirty/accessed bits.
generic_pmdp_establish() is suitable in this case.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 9e9e94415d08..7b3a3139e82d 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -534,6 +534,9 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
+/* We don't have hardware dirty/accessed bits, generic_pmdp_establish is fine.*/
+#define pmdp_establish generic_pmdp_establish
+
 #define has_transparent_hugepage has_transparent_hugepage
 extern int has_transparent_hugepage(void);
 
-- 
2.14.1
