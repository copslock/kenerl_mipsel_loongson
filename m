Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Apr 2010 20:43:55 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12817 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492152Ab0DSSns (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Apr 2010 20:43:48 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bcca46a0000>; Mon, 19 Apr 2010 11:43:54 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 19 Apr 2010 11:43:15 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 19 Apr 2010 11:43:15 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3JIhCUj017834;
        Mon, 19 Apr 2010 11:43:12 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3JIhBeB017833;
        Mon, 19 Apr 2010 11:43:11 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Don't vmap things at address zero.
Date:   Mon, 19 Apr 2010 11:43:10 -0700
Message-Id: <1271702590-17799-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 19 Apr 2010 18:43:15.0180 (UTC) FILETIME=[2BB35AC0:01CADFF0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In the 64-bit kernel we use swapper_pg_dir for three different things.

1) xuseg mappings for kernel threads.

2) vmap mappings for all kernel-space accesses in xkseg.

3) vmap mappings for kernel modules in ksseg (kseg2).

Due to how the TLB refill handlers work, any mapping established in
xkseg or ksseg will also establish a xuseg mapping that should never
be used by the kernel.

In order to be able to use exceptions to trap NULL pointer
dereferences, we need to ensure that nothing is mapped at address
zero.  Since vmap mappings in xkseg are reflected in xuseg, this means
we need to ensure that there are no vmap mappings established at the
start of xkseg.  So we move back VMALLOC_START to avoid establishing
vmap mappings at the start of xkseg.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/pgtable-64.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index adc2093..91db014 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -120,9 +120,14 @@
 #endif
 #define FIRST_USER_ADDRESS	0UL
 
-#define VMALLOC_START		MAP_BASE
+/*
+ * TLB refill handlers also map the vmalloc area into xuseg.  Avoid
+ * the first couple of pages so NULL pointer dereferences will still
+ * reliably trap.
+ */
+#define VMALLOC_START		(MAP_BASE + (2 * PAGE_SIZE))
 #define VMALLOC_END	\
-	(VMALLOC_START + \
+	(MAP_BASE + \
 	 min(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
 	     (1UL << cpu_vmbits)) - (1UL << 32))
 
-- 
1.6.6.1
