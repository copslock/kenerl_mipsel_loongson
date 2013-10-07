Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 18:07:51 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:54714 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868731Ab3JGQHo7WDxj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 18:07:44 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Hide initrd code behind the CONFIG_BLK_DEV_INITRD macro
Date:   Mon, 7 Oct 2013 17:07:49 +0100
Message-ID: <1381162069-12001-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_07_17_07_38
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Commit 5395d97b675986e7e8f3140f9e0819d20b1d22cd
"MIPS: Fix start of free memory when using initrd"

uses the 'initrd_end' symbol even if CONFIG_BLK_DEV_INITRD is
not enabled. This causes linking problems like this:

arch/mips/built-in.o: In function `setup_arch':
(.init.text+0x1b8c): undefined reference to `initrd_end'
arch/mips/built-in.o: In function `setup_arch':
(.init.text+0x1b90): undefined reference to `initrd_end'

We fix this problem by adding the missing CONFIG_BLK_DEV_INITRD
macro

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
The build problem is currently reproducible on linux-next and
upstream-sfr/mips-for-linux-next so this patch needs to be
applied to that tree.
---
 arch/mips/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index dfb8585..9d5d31d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -363,10 +363,12 @@ static void __init bootmem_init(void)
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
 
+#ifdef CONFIG_BLK_DEV_INITRD
 	/*
 	 * mapstart should be after initrd_end
 	 */
 	mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
+#endif
 
 	/*
 	 * Initialize the boot-time allocator with low memory only.
-- 
1.8.3.2
