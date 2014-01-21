Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 12:24:10 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:31201 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870549AbaAULYIDwg5Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jan 2014 12:24:08 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH] MIPS: Fix possible unbuildable configuration with transparent hugepages enabled
Date:   Tue, 21 Jan 2014 11:22:35 +0000
Message-ID: <1390303355-44542-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.62]
X-SEF-Processed: 7_3_0_01192__2014_01_21_11_24_01
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

If CONFIG_TRANSPARENT_HUGEPAGE is enabled, but CONFIG_HUGETLB_PAGE is not,
it is possible to end up with a configuration that fails to build with the
following error:

include/linux/huge_mm.h:125:2: error: #error "hugepages can't be allocated by the buddy allocator"

This is due to CONFIG_FORCE_MAX_ZONEORDER defaulting to 11. It already has
ranges that change the valid values when HUGETLB_PAGE is enabled, but this
is not done for TRANSPARENT_HUGEPAGE. Fix by changing the HUGETLB_PAGE
dependencies to MIPS_HUGE_TLB_SUPPORT, which includes both
TRANSPARENT_HUGEPAGE and HUGETLB_PAGE.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f4c78c9..28a313d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1777,12 +1777,12 @@ endchoice
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
-	range 14 64 if HUGETLB_PAGE && PAGE_SIZE_64KB
-	default "14" if HUGETLB_PAGE && PAGE_SIZE_64KB
-	range 13 64 if HUGETLB_PAGE && PAGE_SIZE_32KB
-	default "13" if HUGETLB_PAGE && PAGE_SIZE_32KB
-	range 12 64 if HUGETLB_PAGE && PAGE_SIZE_16KB
-	default "12" if HUGETLB_PAGE && PAGE_SIZE_16KB
+	range 14 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
+	default "14" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
+	range 13 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
+	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
+	range 12 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
+	default "12" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
 	range 11 64
 	default "11"
 	help
-- 
1.8.5.3
