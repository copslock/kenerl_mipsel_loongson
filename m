Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 14:34:06 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:16292 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022975AbXIRNd5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2007 14:33:57 +0100
Received: (qmail 25463 invoked by uid 511); 18 Sep 2007 13:45:52 -0000
Received: from unknown (HELO ?172.16.2.41?) (222.92.8.142)
  by lemote.com with SMTP; 18 Sep 2007 13:45:52 -0000
Message-ID: <46EFD3A5.8080102@lemote.com>
Date:	Tue, 18 Sep 2007 21:33:25 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Calculate exactly how many pointers in PGD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

In 32-bit kernel, we treat BadAddr as a 32-bit address,
so using a page for pgd will be a waste when page size > 4k,
calculating exactly how many pointers in PGD will save memory
quite a bit.

Signed-off-by: Songmao Tian <tiansm@lemote.com>
---
 include/asm-mips/pgtable-32.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 59c865d..dc8ec21 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -57,7 +57,12 @@ extern int add_temporary_entry(unsigned long 
entrylo0, unsigned long entrylo1,
 #define PMD_ORDER    1
 #define PTE_ORDER    0
 
-#define PTRS_PER_PGD    ((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+/*
+ * Using a page for pgd will be a waste when page size > 4k,
+ * so we calculate exactly how many pointers in PGD under
+ * 32-bit address space configuration.
+ */
+#define PTRS_PER_PGD    (1 << (32 - PGDIR_SHIFT))
 #define PTRS_PER_PTE    ((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD    (0x80000000UL/PGDIR_SIZE)
