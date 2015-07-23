Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 11:51:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35789 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010405AbbGWJvu1IZLl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jul 2015 11:51:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6N9pl0x009320;
        Thu, 23 Jul 2015 11:51:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6N9pl2A009319;
        Thu, 23 Jul 2015 11:51:47 +0200
Message-Id: <6066e46d74d2314ecc19e6562afe33e369fe9557.1437644062.git.ralf@linux-mips.org>
In-Reply-To: <cover.1437644062.git.ralf@linux-mips.org>
References: <cover.1437644062.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
Date:   Thu, 23 Jul 2015 11:10:59 +0200
Subject: [PATCH 2/2] MIPS: Partially disable RIXI support.
To:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Execution of break instruction, trap instructions, emulation of unaligned
loads or floating point instructions - anything that tries to read the
instruction's opcode from userspace - needs read access to a page.

RIXI (Read Inhibit / Execute Inhibit) support however allows the creation of
pags that are executable but not readable.  On such a mapping the attempted
load of the opcode by the kernel is going to cause an endless loop of
page faults.

The quick workaround for this is to disable the combinations that the kernel
currently isn't able to handle which are executable mappings.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/mm/cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 77d96db..aab218c 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -160,18 +160,18 @@ static inline void setup_protection_map(void)
 		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
 		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
 		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
-		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_READ);
+		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
 		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_READ);
+		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
 		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
 
 		protection_map[8]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
 		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
 		protection_map[10] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
 		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
-		protection_map[12] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_READ);
+		protection_map[12] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
 		protection_map[13] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[14] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE  | _PAGE_NO_READ);
+		protection_map[14] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
 		protection_map[15] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
 
 	} else {
-- 
2.4.3
