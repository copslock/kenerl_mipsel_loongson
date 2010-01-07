Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 20:07:51 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17186 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492533Ab0AGTGG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 20:06:06 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b46307e0000>; Thu, 07 Jan 2010 11:05:39 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:05:11 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:05:10 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o07J587l032180;
        Thu, 7 Jan 2010 11:05:08 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o07J58sk032179;
        Thu, 7 Jan 2010 11:05:08 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/7] Staging: Octeon Ethernet: Fix memory allocation.
Date:   Thu,  7 Jan 2010 11:05:02 -0800
Message-Id: <1262891106-32146-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B463005.8060505@caviumnetworks.com>
References: <4B463005.8060505@caviumnetworks.com>
X-OriginalArrivalTime: 07 Jan 2010 19:05:10.0843 (UTC) FILETIME=[55C318B0:01CA8FCC]
X-archive-position: 25533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5133

kmalloc already returns aligned blocks.  No need to try to realign
them.

There are no guarantees about the alignment of SKB data, so we need to
handle worst case alignment.

Since right shifts over subtraction have no distributive property, we
need to fix the back pointer calculation.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/staging/octeon/ethernet-mem.c |   14 ++++++--------
 drivers/staging/octeon/ethernet-tx.c  |    6 +++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mem.c b/drivers/staging/octeon/ethernet-mem.c
index 7090521..7f1372f 100644
--- a/drivers/staging/octeon/ethernet-mem.c
+++ b/drivers/staging/octeon/ethernet-mem.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2007 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -45,7 +45,7 @@ static int cvm_oct_fill_hw_skbuff(int pool, int size, int elements)
 	int freed = elements;
 	while (freed) {
 
-		struct sk_buff *skb = dev_alloc_skb(size + 128);
+		struct sk_buff *skb = dev_alloc_skb(size + 256);
 		if (unlikely(skb == NULL)) {
 			pr_warning
 			    ("Failed to allocate skb for hardware pool %d\n",
@@ -53,7 +53,7 @@ static int cvm_oct_fill_hw_skbuff(int pool, int size, int elements)
 			break;
 		}
 
-		skb_reserve(skb, 128 - (((unsigned long)skb->data) & 0x7f));
+		skb_reserve(skb, 256 - (((unsigned long)skb->data) & 0x7f));
 		*(struct sk_buff **)(skb->data - sizeof(void *)) = skb;
 		cvmx_fpa_free(skb->data, pool, DONT_WRITEBACK(size / 128));
 		freed--;
@@ -106,14 +106,12 @@ static int cvm_oct_fill_hw_memory(int pool, int size, int elements)
 	int freed = elements;
 
 	while (freed) {
-		/* We need to force alignment to 128 bytes here */
-		memory = kmalloc(size + 127, GFP_ATOMIC);
+		memory = kmalloc(size, GFP_ATOMIC);
 		if (unlikely(memory == NULL)) {
 			pr_warning("Unable to allocate %u bytes for FPA pool %d\n",
 				   elements * size, pool);
 			break;
 		}
-		memory = (char *)(((unsigned long)memory + 127) & -128);
 		cvmx_fpa_free(memory, pool, 0);
 		freed--;
 	}
@@ -149,7 +147,7 @@ static void cvm_oct_free_hw_memory(int pool, int size, int elements)
 int cvm_oct_mem_fill_fpa(int pool, int size, int elements)
 {
 	int freed;
-	if (USE_SKBUFFS_IN_HW)
+	if (USE_SKBUFFS_IN_HW && pool == CVMX_FPA_PACKET_POOL)
 		freed = cvm_oct_fill_hw_skbuff(pool, size, elements);
 	else
 		freed = cvm_oct_fill_hw_memory(pool, size, elements);
@@ -158,7 +156,7 @@ int cvm_oct_mem_fill_fpa(int pool, int size, int elements)
 
 void cvm_oct_mem_empty_fpa(int pool, int size, int elements)
 {
-	if (USE_SKBUFFS_IN_HW)
+	if (USE_SKBUFFS_IN_HW && pool == CVMX_FPA_PACKET_POOL)
 		cvm_oct_free_hw_skbuff(pool, size, elements);
 	else
 		cvm_oct_free_hw_memory(pool, size, elements);
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index a3594bb..e5695d9 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2007 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -186,7 +186,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * shown a 25% increase in performance under some loads.
 	 */
 #if REUSE_SKBUFFS_WITHOUT_FREE
-	fpa_head = skb->head + 128 - ((unsigned long)skb->head & 0x7f);
+	fpa_head = skb->head + 256 - ((unsigned long)skb->head & 0x7f);
 	if (unlikely(skb->data < fpa_head)) {
 		/*
 		 * printk("TX buffer beginning can't meet FPA
@@ -247,7 +247,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	pko_command.s.reg0 = 0;
 	pko_command.s.dontfree = 0;
 
-	hw_buffer.s.back = (skb->data - fpa_head) >> 7;
+	hw_buffer.s.back = ((unsigned long)skb->data >> 7) - ((unsigned long)fpa_head >> 7);
 	*(struct sk_buff **)(fpa_head - sizeof(void *)) = skb;
 
 	/*
-- 
1.6.0.6
