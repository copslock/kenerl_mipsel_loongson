Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 20:45:18 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:56621 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903864Ab1KPTpL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 20:45:11 +0100
Received: by ggnb1 with SMTP id b1so87596ggn.36
        for <multiple recipients>; Wed, 16 Nov 2011 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=1dUh3L9fpvLEtXnYf8iCofytBwYqryA3scnvmshozZ0=;
        b=aJyNs9AHbLPQYt456I0siW5SJX9ERG2jDHEd06ZBwtEBo4xrVzcG3nBLkQTUGtN8nw
         aOR6If7wMvjIb4XFzPK2zNKeqkXfKRCCPXObhkcCGHD9C0CO/8x2hpVX9MxsFNYnoLSS
         8I03FLgun+y327zqMizAbtA3mM3dJB2ubBW8E=
Received: by 10.236.174.3 with SMTP id w3mr4169161yhl.117.1321472704981;
        Wed, 16 Nov 2011 11:45:04 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id l27sm88731867ani.21.2011.11.16.11.45.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 11:45:04 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAGJiKWc013328;
        Wed, 16 Nov 2011 11:44:20 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAGJhZ3B013323;
        Wed, 16 Nov 2011 11:43:35 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        William Irwin <wli@holomorphy.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] hugetlb: Provide a default HPAGE_SHIFT if !CONFIG_HUGETLB_PAGE
Date:   Wed, 16 Nov 2011 11:43:31 -0800
Message-Id: <1321472611-13283-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13785

From: David Daney <david.daney@cavium.com>

This is required now to get MIPS kernels to compile with
!CONFIG_HUGETLB_PAGE.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 include/linux/hugetlb.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 19644e0..746d543 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -113,6 +113,7 @@ static inline void copy_huge_page(struct page *dst, struct page *src)
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
 #define HPAGE_SIZE	PAGE_SIZE
+#define HPAGE_SHIFT	PAGE_SHIFT
 #endif
 
 #endif /* !CONFIG_HUGETLB_PAGE */
-- 
1.7.2.3
