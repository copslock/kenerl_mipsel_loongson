Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 20:42:19 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:36178 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903812Ab1KVTmP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 20:42:15 +0100
Received: by yenr8 with SMTP id r8so700309yen.36
        for <multiple recipients>; Tue, 22 Nov 2011 11:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Hx6/JesxcEkm07XuzOcEze8TzyKfU5np2Svz/5xZNYs=;
        b=gTwT0WexT34mdLoUd2LQtYiFsl4lhvInn5Yo1rXhBmvuQeV8xfNWXxtl97S9317pbs
         V5hFudbPgPqBNFMlUZqinAcnO5jGt03RUfUWd/IlpWkAD/1diH62+4L3D170h7uWWz7l
         GBGInwhCpXsJOrJOnRGf/rFWBpJhdr4rRIzpc=
Received: by 10.236.192.135 with SMTP id i7mr30224698yhn.13.1321990928891;
        Tue, 22 Nov 2011 11:42:08 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id y58sm20930488yhi.17.2011.11.22.11.42.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 11:42:08 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAMJg6xn014221;
        Tue, 22 Nov 2011 11:42:06 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAMJg50U014220;
        Tue, 22 Nov 2011 11:42:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Hillf Danton <dhillf@gmail.com>
Subject: [PATCH] MIPS: Add dummy definitions of HPAGE_SHIFT et al.
Date:   Tue, 22 Nov 2011 11:42:04 -0800
Message-Id: <1321990924-14189-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18941

From: David Daney <david.daney@cavium.com>

In the case of !CONFIG_HUGETLB_PAGE we need dummy definitions of
HPAGE_SHIFT, HPAGE_SIZE and HPAGE_MASK to be able to compile tlb-r4k.c

Add these with a BUILD_BUG() to properly flag situations where they
are improperly used.

Also conditionally define BUILD_BUG(), as the definition for this may
not have been merged by the time this patch is merged.  Once a
BUILD_BUG() is defined in kernel.h, we can remove this one.

Cc: Hillf Danton <dhillf@gmail.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/page.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index e59cd1a..d417909 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -38,6 +38,14 @@
 #define HPAGE_SIZE	(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#else /* !CONFIG_HUGETLB_PAGE */
+# ifndef BUILD_BUG
+#  define BUILD_BUG() do { extern void __build_bug(void); __build_bug(); } while (0)
+# endif
+#define HPAGE_SHIFT	({BUILD_BUG(); 0; })
+#define HPAGE_SIZE	({BUILD_BUG(); 0; })
+#define HPAGE_MASK	({BUILD_BUG(); 0; })
+#define HUGETLB_PAGE_ORDER	({BUILD_BUG(); 0; })
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifndef __ASSEMBLY__
-- 
1.7.2.3
