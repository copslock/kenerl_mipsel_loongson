Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 18:21:31 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:62684 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009553AbcAVRVaEoE4A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2016 18:21:30 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 22 Jan 2016 09:21:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,332,1449561600"; 
   d="scan'208";a="639653980"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.136])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2016 09:21:02 -0800
Subject: [PATCH] Revert "MIPS: Fix PAGE_MASK definition"
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, stable@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 22 Jan 2016 09:20:37 -0800
Message-ID: <20160122172037.23041.29693.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <dan.j.williams@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51312
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

This reverts commit 22b14523994588279ae9c5ccfe64073c1e5b3c00.

It was originally sent in an earlier revision of the pfn_t patchset.
Besides being broken, the warning is also fixed by PFN_FLAGS_MASK
casting the PAGE_MASK to an unsigned long.

Cc: <stable@vger.kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/mips/include/asm/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 2046c0230224..21ed7150fec3 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -33,7 +33,7 @@
 #define PAGE_SHIFT	16
 #endif
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
 
 /*
  * This is used for calculating the real page sizes
