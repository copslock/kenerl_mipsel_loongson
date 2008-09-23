Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 16:11:03 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:34992 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28641160AbYIWOuy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2008 15:50:54 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m8NEoho3021829;
	Tue, 23 Sep 2008 07:50:43 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 23 Sep 2008 07:50:43 -0700
Received: from localhost.localdomain ([128.224.162.72]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 23 Sep 2008 07:50:42 -0700
From:	jack.tan@windriver.com
To:	ralf@linux-mips.com
Cc:	linux-mips@linux-mips.org, jack.tan@windriver.com,
	Dajie Tan <jiankemeng@gmail.com>
Subject: [PATCH] Fixed the definition of PTRS_PER_PGD
Date:	Tue, 23 Sep 2008 22:52:34 +0800
Message-Id: <1222181554-4318-1-git-send-email-jack.tan@windriver.com>
X-Mailer: git-send-email 1.5.6.5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Sep 2008 14:50:42.0974 (UTC) FILETIME=[C0D6EBE0:01C91D8B]
Return-Path: <Jack.Tan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jack.tan@windriver.com
Precedence: bulk
X-list: linux-mips

From: Jack Tan <jack.tan@windriver.com>

When we use > 4KB's page size the original definition is not consistent
with PGDIR_SIZE. For exeample, if we use 16KB page size the PGDIR_SHIFT is
(14-2) + 14 = 26, PGDIR_SIZE is 2^26，so the PTRS_PER_PGD should be:

	2^32/2^26 = 2^6

but the original definition of PTRS_PER_PGD is 4096 (PGDIR_ORDER = 0).

So, this definition needs to be consistent with the PGDIR_SIZE.

And the new definition is consistent with the PGD init in pagetable_init().

Signed-off-by: Dajie Tan <jiankemeng@gmail.com>
---
 include/asm-mips/pgtable-32.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 4396e9f..55813d6 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -57,7 +57,7 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 #define PMD_ORDER	1
 #define PTE_ORDER	0
 
-#define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+#define PTRS_PER_PGD	(USER_PTRS_PER_PGD * 2)
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
-- 
1.5.5.4
