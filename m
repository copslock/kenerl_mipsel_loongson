Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 20:09:49 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:39201 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903667Ab2EDSJp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2012 20:09:45 +0200
Received: by pbbrq13 with SMTP id rq13so4459751pbb.36
        for <multiple recipients>; Fri, 04 May 2012 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SIYEbHq1F/sEi2Nk2Jp2TVmFgUqxcSDRKy+0QiGeaHY=;
        b=i3p1NbKYLaeOV7YuBPU3OodrPCcXhB7VEpXCKh1V6xo45ntysopb6L9uUBxBuhYvXg
         N2rjdGo/I6HuKZdtsqxrnOfh2Nc1K/OJMimsiXKbRtR6Kpe2LR1lp5jsDufZcIcRRn0W
         m83GKGdhm8rEdza0Ez9KlQfiAviEPJ8OptdBkYAS3da/eaij0l9DdlLZxJ9FeJTV6kxb
         Y7bYhK+b2mnwXWecrCDZI5dNgpCvfopkekUVmLq8MyqGvJPOPvykKrFkq+DxSIx3nUQO
         bQRap+UJrLEiIm2WhhRrg53COup/8oDJ9jFIEkgJOVpKsIZ5rqKxDSJArVDEp7DVDMyy
         Uo9w==
Received: by 10.68.217.40 with SMTP id ov8mr2919528pbc.35.1336154979251;
        Fri, 04 May 2012 11:09:39 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pd3sm3473450pbc.53.2012.05.04.11.09.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 11:09:38 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q44I9bel022182;
        Fri, 4 May 2012 11:09:37 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q44I9awh022180;
        Fri, 4 May 2012 11:09:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Handle huge pages with 64KB base page size.
Date:   Fri,  4 May 2012 11:09:35 -0700
Message-Id: <1336154975-22149-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

When using sparsemem, we need to adjust some constants as the
resulting huge pages are 512MB in size.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                 |   10 ++++++----
 arch/mips/include/asm/sparsemem.h |    6 +++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3134457..e588610 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1789,10 +1789,12 @@ endchoice
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
-	range 13 64 if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_32KB
-	default "13" if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_32KB
-	range 12 64 if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_16KB
-	default "12" if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_16KB
+	range 14 64 if HUGETLB_PAGE && PAGE_SIZE_64KB
+	default "14" if HUGETLB_PAGE && PAGE_SIZE_64KB
+	range 13 64 if HUGETLB_PAGE && PAGE_SIZE_32KB
+	default "13" if HUGETLB_PAGE && PAGE_SIZE_32KB
+	range 12 64 if HUGETLB_PAGE && PAGE_SIZE_16KB
+	default "12" if HUGETLB_PAGE && PAGE_SIZE_16KB
 	range 11 64
 	default "11"
 	help
diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
index 7165333..4461198 100644
--- a/arch/mips/include/asm/sparsemem.h
+++ b/arch/mips/include/asm/sparsemem.h
@@ -6,7 +6,11 @@
  * SECTION_SIZE_BITS		2^N: how big each section will be
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
-#define SECTION_SIZE_BITS       28
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_PAGE_SIZE_64KB)
+# define SECTION_SIZE_BITS	29
+#else
+# define SECTION_SIZE_BITS	28
+#endif
 #define MAX_PHYSMEM_BITS        35
 
 #endif /* CONFIG_SPARSEMEM */
-- 
1.7.2.3
