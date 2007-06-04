Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:42:37 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.175]:43016 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022456AbXFDPlW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:41:22 +0100
Received: by ug-out-1314.google.com with SMTP id m3so851218ugc
        for <linux-mips@linux-mips.org>; Mon, 04 Jun 2007 08:41:18 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=BU6IQqOuNpzSlmX6eHWwkWgaU5iaV6bL7U5D6vsQAQgqiv5lYJHUaV6lX4EvApuMAbPSDZerhUCcOcMdNVOKHNRZN+2Tba2bVw2wP8YRc30KRn50O7ua0h7Qiob+QKllDtkFWkLA/li4rA/tHD/A7m4DWQHGAnFulvdcWF0kHcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=T0Gn/1PBCW1jx91tcTIxjr2Pbs/cLNiJeFG2B0vRC4gV9li5vCKHMHubqPWBgX4hg5pa0PLpAL33u2OZewO3Ljb8E3brqLqbGdZd5bgQUo17AuIbkvyr3sBhynAVAv9Ab6g/r9ytOUk8QO3ndkxTX0OFlBTMoBET5jMP8s2ZOwQ=
Received: by 10.66.243.2 with SMTP id q2mr3204030ugh.1180971678846;
        Mon, 04 Jun 2007 08:41:18 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id b33sm1072116ika.2007.06.04.08.41.16;
        Mon, 04 Jun 2007 08:41:17 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 6A5AF23F76F; Mon,  4 Jun 2007 17:46:36 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 4/5] Move PHY_OFFSET definition in spaces.h
Date:	Mon,  4 Jun 2007 17:46:34 +0200
Message-Id: <11809719961788-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1180971995757-git-send-email-fbuihuu@gmail.com>
References: <1180971995757-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/mach-generic/spaces.h |    7 +++++++
 include/asm-mips/page.h                |   11 ++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-mips/mach-generic/spaces.h b/include/asm-mips/mach-generic/spaces.h
index 96c8971..8ca3d70 100644
--- a/include/asm-mips/mach-generic/spaces.h
+++ b/include/asm-mips/mach-generic/spaces.h
@@ -12,6 +12,13 @@
 
 #include <linux/const.h>
 
+/*
+ * This gives the physical RAM offset.
+ */
+#ifndef PHYS_OFFSET
+#define PHYS_OFFSET		_AC(0,UL)
+#endif
+
 #ifdef CONFIG_32BIT
 
 #define CAC_BASE		_AC(0x80000000,UL)
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 5c3239d..09c60d5 100644
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
1.5.1.4
