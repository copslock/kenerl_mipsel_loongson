Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2013 20:16:54 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:41549 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824811Ab3ARTQxZhuMs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jan 2013 20:16:53 +0100
Received: by mail-da0-f49.google.com with SMTP id v40so1749296dad.8
        for <multiple recipients>; Fri, 18 Jan 2013 11:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=T6YwWIa1kCDtE4E8jmcdXmY47NZ+S6gieRO3GBNO+NE=;
        b=ra+IZlnTeZuGor3QALwTrXCGHu3XRhuKQehe8SiVUGoLVMVNnQHzGsA7nijKZMVTpt
         aRF2ivZaWq8kfUvyYjEmVEMMPmw8YbY/QsafHUPVxjIUrO1yMWqbxfR8054syDEX9/Nv
         jRRmMVrouXNZ8yR1SRTD10LXI82Z5daHzOCyEcVLwqr3xNTGQXA8EYr1ozoexkwG7F0X
         pTRiQpWIbVsv+rs5OW0zJNOc7Rr4BM9dO8xcHetvWFrQ7/u9oxD8SSOUFCYuYVIXaxEe
         Sbh4HUwpvVNnAEbTmWS9wIFI274sgXyS+Ftaour/y8MIypsyNxghWU88KODgCUyGJLpV
         fcEw==
X-Received: by 10.69.1.73 with SMTP id be9mr8243156pbd.116.1358536606537;
        Fri, 18 Jan 2013 11:16:46 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id oj5sm3554574pbb.47.2013.01.18.11.16.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jan 2013 11:16:45 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r0IJGgLH013618;
        Fri, 18 Jan 2013 11:16:42 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r0IJGgLg013617;
        Fri, 18 Jan 2013 11:16:42 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Fix build failure by adding definition of pfn_pmd().
Date:   Fri, 18 Jan 2013 11:16:40 -0800
Message-Id: <1358536600-13584-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

With CONFIG_TRANSPARENT_HUGEPAGE=y and CONFIG_HUGETLBFS=y we get the
following build failure:
.
.
.
  CC      mm/huge_memory.o
mm/huge_memory.c: In function 'set_huge_zero_page':
mm/huge_memory.c:780:2: error: implicit declaration of function 'pfn_pmd' [-Werror=implicit-function-declaration]
mm/huge_memory.c:780:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
.
.
.

Add a definition of pfn_pmd() for 64-bit kernels (the only place huge
pages are currently supported).

Signed-off-by: David Daney <david.daney@cavium.com>
---

Failing v3.8-rc1 and later.  Ralf, please consider for 3.8.

 arch/mips/include/asm/pgtable-64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index c631910..013d5f7 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -230,6 +230,7 @@ static inline void pud_clear(pud_t *pudp)
 #else
 #define pte_pfn(x)		((unsigned long)((x).pte >> _PFN_SHIFT))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
+#define pfn_pmd(pfn, prot)	__pmd(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
 #endif
 
 #define __pgd_offset(address)	pgd_index(address)
-- 
1.7.11.7
