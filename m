Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:41:24 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.173]:48393 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022447AbXFDPlW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:41:22 +0100
Received: by ug-out-1314.google.com with SMTP id m3so851211ugc
        for <linux-mips@linux-mips.org>; Mon, 04 Jun 2007 08:41:17 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=SvUDyLdb3bhb+ejrdlm7VUkQw4on458otsWyAIZgJEnhUeQRUOl7PLY4QCBD+KEexe/RLOLDMAkzs8ZxSVCS9/2FTz7gGsPVUkmBOmBAcyB2H7UpqBFEe034FDBxLddBHxnRy/k7cu/ifPZeZI3CFpjMOseDX3GbZaDZ2Mcj39A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=A5WlfWj8Vj2phvZ77KRXFOnkay29PGaxdxxKSl2gLLcfrUd4uHqRBEcbUFDIQu5jU8WBvTqDKNLJDKsAS+18xizAxYJcIP1GpvMFVzhMnWh1ud/dNN6Snc9SHwFLEAa05Xx8uN57sB46rw/7wjeMdyfmOaKfyCOg6NORnjWGbGI=
Received: by 10.67.28.2 with SMTP id f2mr3171595ugj.1180971677922;
        Mon, 04 Jun 2007 08:41:17 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z33sm1053080ikz.2007.06.04.08.41.16;
        Mon, 04 Jun 2007 08:41:17 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 1540D23F76A; Mon,  4 Jun 2007 17:46:36 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 2/5] Clean up asm-mips/mach-generic/spaces.h
Date:	Mon,  4 Jun 2007 17:46:32 +0200
Message-Id: <118097199516-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1180971995757-git-send-email-fbuihuu@gmail.com>
References: <1180971995757-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

PAGE_OFFSET definition is now using CAC_BASE by default.

This patch also reorder some macros to make them appear
in the same order for both 32 and 64 bits configs.

It also makes use of const.h generic header file to
annotate constants.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/mach-generic/spaces.h |   66 +++++++++++++------------------
 1 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/include/asm-mips/mach-generic/spaces.h b/include/asm-mips/mach-generic/spaces.h
index 9a3c521..c90900b 100644
--- a/include/asm-mips/mach-generic/spaces.h
+++ b/include/asm-mips/mach-generic/spaces.h
@@ -10,74 +10,56 @@
 #ifndef _ASM_MACH_GENERIC_SPACES_H
 #define _ASM_MACH_GENERIC_SPACES_H
 
+#include <linux/const.h>
 
 #ifdef CONFIG_32BIT
 
-#define CAC_BASE		0x80000000
-#define IO_BASE			0xa0000000
-#define UNCAC_BASE		0xa0000000
+#define CAC_BASE		_AC(0x80000000,UL)
+#define IO_BASE			_AC(0xa0000000,UL)
+#define UNCAC_BASE		_AC(0xa0000000,UL)
 
 #ifndef MAP_BASE
-#define MAP_BASE		0xc0000000
-#endif
-
-/*
- * This handles the memory map.
- * We handle pages at KSEG0 for kernels with 32 bit address space.
- */
-#ifndef PAGE_OFFSET
-#define PAGE_OFFSET		0x80000000UL
+#define MAP_BASE		_AC(0xc0000000,UL)
 #endif
 
 /*
  * Memory above this physical address will be considered highmem.
  */
 #ifndef HIGHMEM_START
-#define HIGHMEM_START		0x20000000UL
+#define HIGHMEM_START		_AC(0x20000000,UL)
 #endif
 
 #endif /* CONFIG_32BIT */
 
 #ifdef CONFIG_64BIT
 
-/*
- * This handles the memory map.
- */
-#ifndef PAGE_OFFSET
-#ifdef CONFIG_DMA_NONCOHERENT
-#define PAGE_OFFSET	0x9800000000000000UL
-#else
-#define PAGE_OFFSET	0xa800000000000000UL
-#endif
-#endif
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
 #ifndef CAC_BASE
 #ifdef CONFIG_DMA_NONCOHERENT
-#define CAC_BASE		0x9800000000000000UL
+#define CAC_BASE		_AC(0x9800000000000000,UL)
 #else
-#define CAC_BASE		0xa800000000000000UL
+#define CAC_BASE		_AC(0xa800000000000000,UL)
 #endif
 #endif
 
 #ifndef IO_BASE
-#define IO_BASE			0x9000000000000000UL
+#define IO_BASE			_AC(0x9000000000000000,UL)
 #endif
 
 #ifndef UNCAC_BASE
-#define UNCAC_BASE		0x9000000000000000UL
+#define UNCAC_BASE		_AC(0x9000000000000000,UL)
 #endif
 
 #ifndef MAP_BASE
-#define MAP_BASE		0xc000000000000000UL
+#define MAP_BASE		_AC(0xc000000000000000,UL)
+#endif
+
+/*
+ * Memory above this physical address will be considered highmem.
+ * Fixme: 59 bits is a fictive number and makes assumptions about processors
+ * in the distant future.  Nobody will care for a few years :-)
+ */
+#ifndef HIGHMEM_START
+#define HIGHMEM_START		(_AC(1,UL) << _AC(59,UL))
 #endif
 
 #define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
@@ -86,4 +68,12 @@
 
 #endif /* CONFIG_64BIT */
 
+/*
+ * This handles the memory map.
+ */
+#ifndef PAGE_OFFSET
+#define PAGE_OFFSET		CAC_BASE
+#endif
+
+
 #endif /* __ASM_MACH_GENERIC_SPACES_H */
-- 
1.5.1.4
