Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2015 03:02:16 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:28312 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010466AbbJJBCOW986S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Oct 2015 03:02:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP; 09 Oct 2015 18:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,660,1437462000"; 
   d="scan'208";a="823379021"
Received: from dwillia2-desk3.jf.intel.com ([10.54.39.39])
  by orsmga002.jf.intel.com with ESMTP; 09 Oct 2015 18:02:10 -0700
Subject: [PATCH v2 12/20] mips: fix PAGE_MASK definition
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mm@kvack.org,
        ross.zwisler@linux.intel.com, hch@lst.de
Date:   Fri, 09 Oct 2015 20:56:28 -0400
Message-ID: <20151010005628.17221.44732.stgit@dwillia2-desk3.jf.intel.com>
In-Reply-To: <20151010005522.17221.87557.stgit@dwillia2-desk3.jf.intel.com>
References: <20151010005522.17221.87557.stgit@dwillia2-desk3.jf.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <dan.j.williams@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
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

Make PAGE_MASK an unsigned long, like it is on x86, to avoid:

In file included from arch/mips/kernel/asm-offsets.c:14:0:
include/linux/mm.h: In function '__pfn_to_pfn_t':
include/linux/mm.h:1050:2: warning: left shift count >= width of type
  pfn_t pfn_t = { .val = pfn | (flags & PFN_FLAGS_MASK), };

...where PFN_FLAGS_MASK is:

#define PFN_FLAGS_MASK (~PAGE_MASK << (BITS_PER_LONG - PAGE_SHIFT))

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/mips/include/asm/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 89dd7fed1a57..ad1fccdb8d13 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -33,7 +33,7 @@
 #define PAGE_SHIFT	16
 #endif
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
 
 /*
  * This is used for calculating the real page sizes
