Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 15:39:12 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:37764 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021678AbXGaOjK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2007 15:39:10 +0100
Received: (qmail 31966 invoked by uid 511); 31 Jul 2007 14:44:10 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 31 Jul 2007 14:44:10 -0000
Message-ID: <46AF4981.1090601@lemote.com>
Date:	Tue, 31 Jul 2007 22:38:57 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [RFC] Calculate exactly how many ptr is needed for pgd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Under 32-bit kernel with 4k page, a page is needed for a pgd,
but when page size > 4k, a page will be too much.

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 2fbd47e..2a16240 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -67,7 +67,8 @@ extern int add_temporary_entry(unsigned long entrylo0, 
unsigned long entrylo1,
 #define PTE_ORDER    0
 #endif
 
-#define PTRS_PER_PGD    ((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+/* Using a page for pgd will be a waste when page size > 4k */
+#define PTRS_PER_PGD    (1 << (32 - PGDIR_SHIFT))
 #define PTRS_PER_PTE    ((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD    (0x80000000UL/PGDIR_SIZE)
