Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 22:58:17 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:49860 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904061Ab1KQV5o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 22:57:44 +0100
Received: by ggnb1 with SMTP id b1so2051544ggn.36
        for <multiple recipients>; Thu, 17 Nov 2011 13:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=g2a7UfVNsxyKYNpY/vXm++bgGWrAnAplfeNavxnL5yk=;
        b=oNo82Ud4i1tNiHPyKIKvl3y0DFlKX3DAABRux/5XM9+yIofAt/eC4+dLBtjzixVhB1
         o8Exn3jZrWW51trw891NQxJylrIV1U7KbsRkfxuOK9PBvOHbUx57fnMKEIXgdE3xu5Zf
         5vCGJim4mzj5XG6Hl5aH5eo+xmj/oaFTbxYMc=
Received: by 10.236.9.36 with SMTP id 24mr655161yhs.62.1321567058960;
        Thu, 17 Nov 2011 13:57:38 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 33sm84054304ano.1.2011.11.17.13.57.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 13:57:37 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAHLvY1a013244;
        Thu, 17 Nov 2011 13:57:34 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAHLvYS5013243;
        Thu, 17 Nov 2011 13:57:34 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH v2 1/2] hugetlb: Provide a default HPAGE_SHIFT if !CONFIG_HUGETLB_PAGE
Date:   Thu, 17 Nov 2011 13:57:29 -0800
Message-Id: <1321567050-13197-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14862

From: David Daney <david.daney@cavium.com>

When linux-next 10111117 is build for MIPS with
cavium-octeon_defconfig, we get:

  arch/mips/mm/tlb-r4k.c: In function 'local_flush_tlb_range':
  arch/mips/mm/tlb-r4k.c:129:28: error: 'HPAGE_SHIFT' undeclared (first use in this function)

The fix is to supply a dummy HPAGE_SHIFT in the !CONFIG_HUGETLB_PAGE
case.  Instead of supplying the non-huge value, as was done for
HPAGE_MASK and HPAGE_SIZE, we do BUG() instead.  This satisfies the
compiler, but give us runtime safety if someone were to use HPAGE_SIZE
incorrectly.

Cc: David Rientjes <rientjes@google.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 include/linux/hugetlb.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 19644e0..380451c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -113,6 +113,7 @@ static inline void copy_huge_page(struct page *dst, struct page *src)
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
 #define HPAGE_SIZE	PAGE_SIZE
+#define HPAGE_SHIFT	({BUG(); 0; })
 #endif
 
 #endif /* !CONFIG_HUGETLB_PAGE */
-- 
1.7.2.3
