Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 22:57:50 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:59044 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904060Ab1KQV5n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 22:57:43 +0100
Received: by ggnb1 with SMTP id b1so2051493ggn.36
        for <multiple recipients>; Thu, 17 Nov 2011 13:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tAJyELo+gobkkRdyu5c/rvFRQf97UzCn3GjdNBRp850=;
        b=FY09QKDtgT+aoUlTbjFcrH7+3vpHF8mxBH3mS7xE8SmG073LXNPtwBVdIOuU6P7ugm
         /HnVF2zgIC4jF/HYCBItwuFa4RDNb7q+DK7XV+M+sOTNDqq4SRbbdO0yL/WbFJbAgQSG
         cxiOwrbBe7dIylDDb10+d/t9/Armj3+sWE4Hg=
Received: by 10.236.200.131 with SMTP id z3mr524750yhn.129.1321567056809;
        Thu, 17 Nov 2011 13:57:36 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id b9sm99740802anb.7.2011.11.17.13.57.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 13:57:36 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAHLvYZ1013248;
        Thu, 17 Nov 2011 13:57:34 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAHLvYXc013247;
        Thu, 17 Nov 2011 13:57:34 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH v2 2/2] hugetlb: Provide safer dummy values for HPAGE_MASK and HPAGE_SIZE
Date:   Thu, 17 Nov 2011 13:57:30 -0800
Message-Id: <1321567050-13197-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14861

From: David Daney <david.daney@cavium.com>

It was pointed out by David Rientjes that the dummy values for
HPAGE_MASK and HPAGE_SIZE are quite unsafe.  It they are inadvertently
used with !CONFIG_HUGETLB_PAGE, compilation would succeed, but the
resulting code would surly not do anything sensible.

Place BUG() in the these dummy definitions, as we do in similar
circumstances in other places, so any abuse can be easily detected.

Since the only sane place to use these symbols when
!CONFIG_HUGETLB_PAGE is on dead code paths, the BUG() cause any actual
code to be emitted by the compiler.

Cc: David Rientjes <rientjes@google.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 include/linux/hugetlb.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 380451c..3ed6dbd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -111,8 +111,9 @@ static inline void copy_huge_page(struct page *dst, struct page *src)
 #define hugetlb_change_protection(vma, address, end, newprot)
 
 #ifndef HPAGE_MASK
-#define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
-#define HPAGE_SIZE	PAGE_SIZE
+/* Keep the compiler happy with some dummy (but BUGgy) values */
+#define HPAGE_MASK	({BUG(); 0; })
+#define HPAGE_SIZE	({BUG(); 0; })
 #define HPAGE_SHIFT	({BUG(); 0; })
 #endif
 
-- 
1.7.2.3
