Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 08:27:21 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:33746 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491194Ab0CCH0b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 08:26:31 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o237QD6x002456;
        Tue, 2 Mar 2010 23:26:23 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ddaney@caviumnetworks.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 3/3] MIPS: Octeon: Add add_wired_entry decralation in header file
Date:   Wed,  3 Mar 2010 15:26:12 +0800
Message-Id: <9e4e80f8edd43f8a164fe618c978c1dc8cd48a69.1267600234.git.yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <3118b3d0f3ed042df1ee2771325c3824e6fc7ba9.1267600234.git.yang.shi@windriver.com>
References: <1267601172-17919-1-git-send-email-yang.shi@windriver.com>
 <6310b9cb3048ec0c2873d932778165370e5e7c7e.1267600234.git.yang.shi@windriver.com>
 <3118b3d0f3ed042df1ee2771325c3824e6fc7ba9.1267600234.git.yang.shi@windriver.com>
In-Reply-To: <6310b9cb3048ec0c2873d932778165370e5e7c7e.1267600234.git.yang.shi@windriver.com>
References: <6310b9cb3048ec0c2873d932778165370e5e7c7e.1267600234.git.yang.shi@windriver.com>
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Octeon's setup.c uses add_wired_entry, but it is not declared
anywhere. Copy add_wired_entry decralation fomr pgtable-32.h to
pgtable-64.h and include asm/pgtable.h into Octeon's setup.c.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/cavium-octeon/setup.c    |    1 +
 arch/mips/include/asm/pgtable-64.h |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 8309d68..f35ba16 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -30,6 +30,7 @@
 #include <asm/bootinfo.h>
 #include <asm/sections.h>
 #include <asm/time.h>
+#include <asm/pagtable.h>
 
 #include <asm/octeon/octeon.h>
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 26dc69d..85ee34d 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -23,6 +23,12 @@
 #endif
 
 /*
+ * - add_wired_entry() add a fixed TLB entry, and move wired register
+ */
+extern void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
+			       unsigned long entryhi, unsigned long pagemask);
+
+/*
  * Each address space has 2 4K pages as its page directory, giving 1024
  * (== PTRS_PER_PGD) 8 byte pointers to pmd tables. Each pmd table is a
  * single 4K page, giving 512 (== PTRS_PER_PMD) 8 byte pointers to page
-- 
1.6.3.3
