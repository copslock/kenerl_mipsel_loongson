Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 11:21:34 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:30590 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021720AbXC0KUs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 11:20:48 +0100
Received: by ug-out-1314.google.com with SMTP id 40so2049676uga
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2007 03:19:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=qe2raoOHPemPixBS+CSzorv1ipmGlMF5+tEAJzFMBfX4kEj+1SP1ZsE04603WY2nd4vNbIv83UJXx8eMSxp95eRlzm+fbVDYNoVNfm/D2Xy4QMh3fN4xzddGWexCK05L/++9os9OEiGjBOMpfNwmgtLI1FG+NscTL3ZUZv7jIUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=QstGFtCrjW0zxCCuGbtyVxQtjASPcfjpWFyT2baiOOOGJ3YKXUE16qq/lcdPpCbmchh3BRz4Cg8sBCBOQL6YLIny7uhM1A6rKz6KQomwOFGhsT3BnyaTvKarC83et1R0ZPi42WE3zLgKL0KUTZT3WGr93skbABmAIB8V4tJqUxs=
Received: by 10.67.22.2 with SMTP id z2mr718317ugi.1174990787827;
        Tue, 27 Mar 2007 03:19:47 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id k28sm9098968ugd.2007.03.27.03.19.45;
        Tue, 27 Mar 2007 03:19:46 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 8817E23F772; Tue, 27 Mar 2007 11:19:41 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 3/4] Move PHY_OFFSET definition in spaces.h
Date:	Tue, 27 Mar 2007 11:19:39 +0200
Message-Id: <11749871811284-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.rc1.27.g1d848
In-Reply-To: <11749871802730-git-send-email-fbuihuu@gmail.com>
References: <11749871802730-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/mach-generic/spaces.h |    6 ++++++
 include/asm-mips/page.h                |   11 ++---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/asm-mips/mach-generic/spaces.h b/include/asm-mips/mach-generic/spaces.h
index 512bca5..8b5e432 100644
--- a/include/asm-mips/mach-generic/spaces.h
+++ b/include/asm-mips/mach-generic/spaces.h
@@ -10,6 +10,12 @@
 #ifndef _ASM_MACH_GENERIC_SPACES_H
 #define _ASM_MACH_GENERIC_SPACES_H
 
+/*
+ * This gives the physical RAM offset.
+ */
+#ifndef PHYS_OFFSET
+#define PHYS_OFFSET		0UL
+#endif
 
 #ifdef CONFIG_32BIT
 
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index d3fbd83..cc28a4f 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -34,12 +34,8 @@
 
 #ifndef __ASSEMBLY__
 
-/*
- * This gives the physical RAM offset.
- */
-#ifndef PHYS_OFFSET
-#define PHYS_OFFSET		0UL
-#endif
+#include <linux/pfn.h>
+#include <asm/io.h>
 
 /*
  * It's normally defined only for FLATMEM config but it's
@@ -48,9 +44,6 @@
  */
 #define ARCH_PFN_OFFSET		PFN_UP(PHYS_OFFSET)
 
-#include <linux/pfn.h>
-#include <asm/io.h>
-
 extern void clear_page(void * page);
 extern void copy_page(void * to, void * from);
 
-- 
1.5.1.rc1.27.g1d848
