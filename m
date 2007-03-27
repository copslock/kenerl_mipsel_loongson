Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 11:22:19 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:55678 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021736AbXC0KUs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 11:20:48 +0100
Received: by ug-out-1314.google.com with SMTP id 40so2049680uga
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2007 03:19:48 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=q0u1E47tNvWZejIwR8i/IqJ2K8pSqV/3/YKxse0VYTnmOI1qj/thMlVIKIfXt0/BZD6/7PHyeW0len3M7QNe6unwBxZvyz3OOPHOi8RJYKjziZl104qIEK8mDaHsegezbNRg6KY9PvdKICwAadtIVxlVyo9eNy53K2YSX77mzOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=n0Bk0mlZpYIB7PeSWPTbIqZa94b5v8+ZxneiP8rh3D/13FkxFtr+sSeJprTz+ZP/P4GCRr/+cEyhJ5iby0DsnFyJ+u0i7ApdNSxeNrMJxP403v7Sa/jcwZ0Fu3P4xIXmavjOoi59i7sp2lxoql9Xp56rHMK/yZ524L439i+nzbA=
Received: by 10.67.106.3 with SMTP id i3mr709242ugm.1174990788178;
        Tue, 27 Mar 2007 03:19:48 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m1sm9092975uge.2007.03.27.03.19.45;
        Tue, 27 Mar 2007 03:19:46 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 2EB6223F76E; Tue, 27 Mar 2007 11:19:41 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 1/4] Allow generic spaces.h to be included by platform specific ones
Date:	Tue, 27 Mar 2007 11:19:37 +0200
Message-Id: <11749871813447-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.rc1.27.g1d848
In-Reply-To: <11749871802730-git-send-email-fbuihuu@gmail.com>
References: <11749871802730-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Before this patch, when a platform needed to customize one constant in
spaces.h, they need to redefine all of them.

Now they can just redefine one constant and include the generic file
header at the end:

	#include <asm/mach-generic/spaces.h>

This patch doesn't allow to redefine CAC_BASE, IO_BASE and UNCAC_BASE
for 32 bits platforms because there's no need to do so.

This will avoid some macro duplications. It's important specially if
we'll add complex macros.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/mach-generic/spaces.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/mach-generic/spaces.h b/include/asm-mips/mach-generic/spaces.h
index 0ae9997..9a3c521 100644
--- a/include/asm-mips/mach-generic/spaces.h
+++ b/include/asm-mips/mach-generic/spaces.h
@@ -16,13 +16,18 @@
 #define CAC_BASE		0x80000000
 #define IO_BASE			0xa0000000
 #define UNCAC_BASE		0xa0000000
+
+#ifndef MAP_BASE
 #define MAP_BASE		0xc0000000
+#endif
 
 /*
  * This handles the memory map.
  * We handle pages at KSEG0 for kernels with 32 bit address space.
  */
+#ifndef PAGE_OFFSET
 #define PAGE_OFFSET		0x80000000UL
+#endif
 
 /*
  * Memory above this physical address will be considered highmem.
@@ -38,11 +43,13 @@
 /*
  * This handles the memory map.
  */
+#ifndef PAGE_OFFSET
 #ifdef CONFIG_DMA_NONCOHERENT
 #define PAGE_OFFSET	0x9800000000000000UL
 #else
 #define PAGE_OFFSET	0xa800000000000000UL
 #endif
+#endif
 
 /*
  * Memory above this physical address will be considered highmem.
@@ -53,14 +60,25 @@
 #define HIGHMEM_START		(1UL << 59UL)
 #endif
 
+#ifndef CAC_BASE
 #ifdef CONFIG_DMA_NONCOHERENT
 #define CAC_BASE		0x9800000000000000UL
 #else
 #define CAC_BASE		0xa800000000000000UL
 #endif
+#endif
+
+#ifndef IO_BASE
 #define IO_BASE			0x9000000000000000UL
+#endif
+
+#ifndef UNCAC_BASE
 #define UNCAC_BASE		0x9000000000000000UL
+#endif
+
+#ifndef MAP_BASE
 #define MAP_BASE		0xc000000000000000UL
+#endif
 
 #define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
 #define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
-- 
1.5.1.rc1.27.g1d848
