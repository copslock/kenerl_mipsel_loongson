Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:41:48 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:40713 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022482AbXFDPlW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:41:22 +0100
Received: by ug-out-1314.google.com with SMTP id m3so851223ugc
        for <linux-mips@linux-mips.org>; Mon, 04 Jun 2007 08:41:19 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=QMGkxkHMUIpZHAiWDKGFh20V8GNkxvoKr0C3EAivookPQjm6A7DiE1lrRhU5ss0bEGyIS/D60NVj5v9GkRbVIK9mFQcGUPD0D1Ihu/Kmrie60IH3wpMl7He+Wjr5hoKRkA0LDSrjIcswh5/a/0q6pGNnzO2O4EEa7jFKPxqcP8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=eDL0ZqpmP8Q+jeH75k6YY95ZKr1UdVtpAtVD2I//Nop1ChUQGp95LQt9+5p3MpLyuxudHjuOJjCN3lpro70VOCEjSW6F35IyI8Xinowj750Uk9ileE/3TiuiSA7NnuQmzGSCsAQ1zq+fh9b0Y3eT6wJcn5pkzIrubuSKEZGuthw=
Received: by 10.67.100.17 with SMTP id c17mr3214079ugm.1180971679374;
        Mon, 04 Jun 2007 08:41:19 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id y37sm1095907iky.2007.06.04.08.41.16;
        Mon, 04 Jun 2007 08:41:17 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 4063E23F770; Mon,  4 Jun 2007 17:46:35 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 1/5] Allow generic spaces.h to be included by platform specific ones
Date:	Mon,  4 Jun 2007 17:46:31 +0200
Message-Id: <11809719951783-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1180971995757-git-send-email-fbuihuu@gmail.com>
References: <1180971995757-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15238
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
 include/asm-mips/mach-generic/spaces.h |   18 ++++++++++++++++
 include/asm-mips/mach-ip22/spaces.h    |   33 ++--------------------------
 include/asm-mips/mach-ip27/spaces.h    |    9 +------
 include/asm-mips/mach-ip32/spaces.h    |   36 --------------------------------
 4 files changed, 23 insertions(+), 73 deletions(-)
 delete mode 100644 include/asm-mips/mach-ip32/spaces.h

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
diff --git a/include/asm-mips/mach-ip22/spaces.h b/include/asm-mips/mach-ip22/spaces.h
index ab20c02..7f9fa6f 100644
--- a/include/asm-mips/mach-ip22/spaces.h
+++ b/include/asm-mips/mach-ip22/spaces.h
@@ -11,44 +11,17 @@
 #define _ASM_MACH_IP22_SPACES_H
 
 
-#ifdef CONFIG_32BIT
-
-#define CAC_BASE		0x80000000
-#define IO_BASE			0xa0000000
-#define UNCAC_BASE		0xa0000000
-#define MAP_BASE		0xc0000000
-
-/*
- * This handles the memory map.
- * We handle pages at KSEG0 for kernels with 32 bit address space.
- */
-#define PAGE_OFFSET		0x80000000UL
-
-/*
- * Memory above this physical address will be considered highmem.
- */
-#ifndef HIGHMEM_START
-#define HIGHMEM_START		0x20000000UL
-#endif
-
-#endif /* CONFIG_32BIT */
-
 #ifdef CONFIG_64BIT
-#define PAGE_OFFSET		0xffffffff80000000UL
 
-#ifndef HIGHMEM_START
-#define HIGHMEM_START		(1UL << 59UL)
-#endif
+#define PAGE_OFFSET		0xffffffff80000000UL
 
 #define CAC_BASE		0xffffffff80000000
 #define IO_BASE			0xffffffffa0000000
 #define UNCAC_BASE		0xffffffffa0000000
 #define MAP_BASE		0xc000000000000000
 
-#define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
-#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
-#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
-
 #endif /* CONFIG_64BIT */
 
+#include <asm/mach-generic/spaces.h>
+
 #endif /* __ASM_MACH_IP22_SPACES_H */
diff --git a/include/asm-mips/mach-ip27/spaces.h b/include/asm-mips/mach-ip27/spaces.h
index 45e6178..b18802a 100644
--- a/include/asm-mips/mach-ip27/spaces.h
+++ b/include/asm-mips/mach-ip27/spaces.h
@@ -14,22 +14,17 @@
  * IP27 uses the R10000's uncached attribute feature.  Attribute 3 selects
  * uncached memory addressing.
  */
-#define CAC_BASE		0xa800000000000000
 
 #define HSPEC_BASE		0x9000000000000000
 #define IO_BASE			0x9200000000000000
 #define MSPEC_BASE		0x9400000000000000
 #define UNCAC_BASE		0x9600000000000000
-#define MAP_BASE		0xc000000000000000
 
-#define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
-#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
-#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
 #define TO_MSPEC(x)		(MSPEC_BASE | ((x) & TO_PHYS_MASK))
 #define TO_HSPEC(x)		(HSPEC_BASE | ((x) & TO_PHYS_MASK))
 
-#define PAGE_OFFSET		CAC_BASE
-
 #define HIGHMEM_START		(~0UL)
 
+#include <asm/mach-generic/spaces.h>
+
 #endif /* _ASM_MACH_IP27_SPACES_H */
diff --git a/include/asm-mips/mach-ip32/spaces.h b/include/asm-mips/mach-ip32/spaces.h
deleted file mode 100644
index 44abe5c..0000000
--- a/include/asm-mips/mach-ip32/spaces.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1994 - 1999, 2000, 03, 04, 05 Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2000, 2002  Maciej W. Rozycki
- * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
- */
-#ifndef _ASM_MACH_IP32_SPACES_H
-#define _ASM_MACH_IP32_SPACES_H
-
-/*
- * Memory above this physical address will be considered highmem.
- * Fixme: 59 bits is a fictive number and makes assumptions about processors
- * in the distant future.  Nobody will care for a few years :-)
- */
-#ifndef HIGHMEM_START
-#define HIGHMEM_START		(1UL << 59UL)
-#endif
-
-#define CAC_BASE		0x9800000000000000UL
-#define IO_BASE			0x9000000000000000UL
-#define UNCAC_BASE		0x9000000000000000UL
-#define MAP_BASE		0xc000000000000000UL
-
-#define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
-#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
-#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
-
-/*
- * This handles the memory map.
- */
-#define PAGE_OFFSET		CAC_BASE
-
-#endif /* __ASM_MACH_IP32_SPACES_H */
-- 
1.5.1.4
