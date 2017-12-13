Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 11:58:22 +0100 (CET)
Received: from mga12.intel.com ([192.55.52.136]:52433 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992396AbdLMK6PbbRCh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Dec 2017 11:58:15 +0100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2017 02:58:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.45,397,1508828400"; 
   d="scan'208";a="11936141"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2017 02:58:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2DB8948A; Wed, 13 Dec 2017 12:58:05 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: [PATCHv4 05/12] mips: Use generic_pmdp_establish as pmdp_establish
Date:   Wed, 13 Dec 2017 13:57:49 +0300
Message-Id: <20171213105756.69879-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Return-Path: <kirill.shutemov@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61465
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
index 1a508a74d48d..129e0328367f 100644
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
2.15.0
