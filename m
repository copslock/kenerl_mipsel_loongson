Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 22:23:29 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13960 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492340Ab0A0VXZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2010 22:23:25 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b60aed20000>; Wed, 27 Jan 2010 13:23:30 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 27 Jan 2010 13:23:00 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 27 Jan 2010 13:23:00 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o0RLMuNa031806;
        Wed, 27 Jan 2010 13:22:56 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o0RLMrOR031804;
        Wed, 27 Jan 2010 13:22:53 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] Staging: Octeon Ethernet: Fix memory allocation.
Date:   Wed, 27 Jan 2010 13:22:53 -0800
Message-Id: <1264627373-31780-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 27 Jan 2010 21:23:00.0198 (UTC) FILETIME=[E6F18860:01CA9F96]
X-archive-position: 25702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17831

After aligning the blocks returned by kmalloc, we need to save the
original pointer so they can be correctly freed.

There are no guarantees about the alignment of SKB data, so we need to
handle worst case alignment.

Since right shifts over subtraction have no distributive property, we
need to fix the back pointer calculation.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

The original in the linux-queue tree is broken as it assumes the
kmalloc returns aligned blocks.  This is not the case when slab
debugging is enabled.

 drivers/staging/octeon/ethernet-mem.c |   45 ++++++++++++++++++++------------
 drivers/staging/octeon/ethernet-tx.c  |    6 ++--
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mem.c b/drivers/staging/octeon/ethernet-mem.c
index 7090521..53ed2f7 100644
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
@@ -91,10 +91,7 @@ static void cvm_oct_free_hw_skbuff(int pool, int size, int elements)
 }
 
 /**
- * This function fills a hardware pool with memory. Depending
- * on the config defines, this memory might come from the
- * kernel or global 32bit memory allocated with
- * cvmx_bootmem_alloc.
+ * This function fills a hardware pool with memory.
  *
  * @pool:     Pool to populate
  * @size:     Size of each buffer in the pool
@@ -103,18 +100,29 @@ static void cvm_oct_free_hw_skbuff(int pool, int size, int elements)
 static int cvm_oct_fill_hw_memory(int pool, int size, int elements)
 {
 	char *memory;
+	char *fpa;
 	int freed = elements;
 
 	while (freed) {
-		/* We need to force alignment to 128 bytes here */
-		memory = kmalloc(size + 127, GFP_ATOMIC);
+		/*
+		 * FPA memory must be 128 byte aligned.  Since we are
+		 * aligning we need to save the original pointer so we
+		 * can feed it to kfree when the memory is returned to
+		 * the kernel.
+		 *
+		 * We allocate an extra 256 bytes to allow for
+		 * alignment and space for the original pointer saved
+		 * just before the block.
+		 */
+		memory = kmalloc(size + 256, GFP_ATOMIC);
 		if (unlikely(memory == NULL)) {
 			pr_warning("Unable to allocate %u bytes for FPA pool %d\n",
 				   elements * size, pool);
 			break;
 		}
-		memory = (char *)(((unsigned long)memory + 127) & -128);
-		cvmx_fpa_free(memory, pool, 0);
+		fpa = (char *)(((unsigned long)memory + 256) & ~0x7fUL);
+		*((char **)fpa - 1) = memory;
+		cvmx_fpa_free(fpa, pool, 0);
 		freed--;
 	}
 	return elements - freed;
@@ -130,13 +138,16 @@ static int cvm_oct_fill_hw_memory(int pool, int size, int elements)
 static void cvm_oct_free_hw_memory(int pool, int size, int elements)
 {
 	char *memory;
+	char *fpa;
 	do {
-		memory = cvmx_fpa_alloc(pool);
-		if (memory) {
+		fpa = cvmx_fpa_alloc(pool);
+		if (fpa) {
 			elements--;
-			kfree(phys_to_virt(cvmx_ptr_to_phys(memory)));
+			fpa = (char *)phys_to_virt(cvmx_ptr_to_phys(fpa));
+			memory = *((char **)fpa - 1);
+			kfree(memory);
 		}
-	} while (memory);
+	} while (fpa);
 
 	if (elements < 0)
 		pr_warning("Freeing of pool %u had too many buffers (%d)\n",
@@ -149,7 +160,7 @@ static void cvm_oct_free_hw_memory(int pool, int size, int elements)
 int cvm_oct_mem_fill_fpa(int pool, int size, int elements)
 {
 	int freed;
-	if (USE_SKBUFFS_IN_HW)
+	if (USE_SKBUFFS_IN_HW && pool == CVMX_FPA_PACKET_POOL)
 		freed = cvm_oct_fill_hw_skbuff(pool, size, elements);
 	else
 		freed = cvm_oct_fill_hw_memory(pool, size, elements);
@@ -158,7 +169,7 @@ int cvm_oct_mem_fill_fpa(int pool, int size, int elements)
 
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
