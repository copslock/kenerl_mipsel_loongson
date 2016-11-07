Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:28:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38792 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991964AbcKGL2gOKcis (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:28:36 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 165FD96AA3303
        for <linux-mips@linux-mips.org>; Mon,  7 Nov 2016 11:28:28 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:28:29 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Remove unused HIGHMEM_DEBUG macro
Date:   Mon, 7 Nov 2016 11:28:12 +0000
Message-ID: <20161107112812.14328-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

We have a HIGHMEM_DEBUG macro defined in asm/highmem.h with a comment
stating that it should be removed for production, and no users... Kill
it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/highmem.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index 64f2500..d34536e 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -25,9 +25,6 @@
 #include <asm/cpu-features.h>
 #include <asm/kmap_types.h>
 
-/* undef for production */
-#define HIGHMEM_DEBUG 1
-
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
 
-- 
2.10.2
