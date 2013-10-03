Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 09:47:42 +0200 (CEST)
Received: from mail-pb0-f54.google.com ([209.85.160.54]:54542 "EHLO
        mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819540Ab3JCHrVnr5P0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 09:47:21 +0200
Received: by mail-pb0-f54.google.com with SMTP id ro12so2079793pbb.13
        for <linux-mips@linux-mips.org>; Thu, 03 Oct 2013 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tdkwb3uIVq6013x36h1nyrylJsxIre3ZRcGlJSGI7y8=;
        b=Sllstv6x+fYImSqzIGCYQbKnlLbypkIrb4qE87K06jGhK8v+Ko152s9E5puX7EUN74
         WXGH1NWsTjvvqFCIXPZS03sdZTO6GBAZpHdyxYkj3jnjmO1gzdtfsRQoWHtPHef4VrT9
         nAs5MhYBQULrNvRZ2+jCnoAWYw4HySw+u3M3yRDhhnUhr12e19cwHHArut8lmlMKWyd2
         J6IoforhmnHS7oFlUhpmlHljahf/rLV4D4xmFOBIy1ikBiXnfdKC7NXQk3G8T1kBpZOZ
         l/S/bBFp4EqyvCnj/vusNAPmCOJX8hac8L+yc+Sr79ZvzibpMzx9eXA5W/sc2l0NqUvJ
         DGsg==
X-Received: by 10.66.26.112 with SMTP id k16mr7598838pag.65.1380786435616;
        Thu, 03 Oct 2013 00:47:15 -0700 (PDT)
Received: from localhost ([115.115.74.130])
        by mx.google.com with ESMTPSA id go4sm6465468pbb.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 00:47:14 -0700 (PDT)
From:   Prem Mallappa <prem.mallappa@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Cc:     Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: [PATCH] MIPS: KDUMP: Fix to access non-sectioned memory
Date:   Thu,  3 Oct 2013 13:16:55 +0530
Message-Id: <1380786415-24956-2-git-send-email-pmallappa@caviumnetworks.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1380786415-24956-1-git-send-email-pmallappa@caviumnetworks.com>
References: <1380786415-24956-1-git-send-email-pmallappa@caviumnetworks.com>
Return-Path: <prem.mallappa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prem.mallappa@gmail.com
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

When booted with initramfs, percpu crash_notes ends up in memory that is not accessible by crashkernel

Signed-off-by: Prem Mallappa <pmallappa@caviumnetworks.com>
---
 arch/mips/kernel/crash_dump.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/crash_dump.c b/arch/mips/kernel/crash_dump.c
index 3be9e7b..f9886437 100644
--- a/arch/mips/kernel/crash_dump.c
+++ b/arch/mips/kernel/crash_dump.c
@@ -3,6 +3,8 @@
 #include <linux/crash_dump.h>
 #include <asm/uaccess.h>
 #include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/io.h>
 
 static int __init parse_savemaxmem(char *p)
 {
@@ -13,7 +15,6 @@ static int __init parse_savemaxmem(char *p)
 }
 __setup("savemaxmem=", parse_savemaxmem);
 
-
 static void *kdump_buf_page;
 
 /**
@@ -41,19 +42,20 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!csize)
 		return 0;
 
-	vaddr = kmap_atomic_pfn(pfn);
+	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
 
 	if (!userbuf) {
 		memcpy(buf, (vaddr + offset), csize);
-		kunmap_atomic(vaddr);
+		iounmap(vaddr);
 	} else {
 		if (!kdump_buf_page) {
 			pr_warning("Kdump: Kdump buffer page not allocated\n");
 
 			return -EFAULT;
 		}
+
 		copy_page(kdump_buf_page, vaddr);
-		kunmap_atomic(vaddr);
+		iounmap(vaddr);
 		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
 			return -EFAULT;
 	}
-- 
1.8.4
