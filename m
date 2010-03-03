Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 09:44:48 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:47822 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491863Ab0CCInk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 09:43:40 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o238hMYD014446;
        Wed, 3 Mar 2010 00:43:31 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ddaney@caviumnetworks.com, ralf@linux-mips.org,
        f.fainelli@gmail.com
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 3/3] MIPS: Octeon: Add add_wired_entry decralation in header file
Date:   Wed,  3 Mar 2010 16:43:21 +0800
Message-Id: <004eb64c73b3bcec90612663598ada4cf678f236.1267604875.git.yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <50e36e8549769a26986f99a23772d23fd039c230.1267604875.git.yang.shi@windriver.com>
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com>
 <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
 <50e36e8549769a26986f99a23772d23fd039c230.1267604875.git.yang.shi@windriver.com>
In-Reply-To: <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
References: <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Octeon's setup.c uses add_wired_entry, but it is not declared
anywhere. Copy add_wired_entry decralation from pgtable-32.h to
pgtable-64.h and include asm/pgtable.h into Octeon's setup.c.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/cavium-octeon/setup.c    |    1 +
 arch/mips/include/asm/pgtable-64.h |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 8309d68..d63b8e6 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -30,6 +30,7 @@
 #include <asm/bootinfo.h>
 #include <asm/sections.h>
 #include <asm/time.h>
+#include <asm/pgtable.h>
 
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
