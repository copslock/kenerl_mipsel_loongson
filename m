Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 13:32:55 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:48854 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492655AbZJHLcs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 13:32:48 +0200
Received: by pzk35 with SMTP id 35so753893pzk.22
        for <multiple recipients>; Thu, 08 Oct 2009 04:32:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rzpFQ6A6+fdZUhF1ZNPocCfuThNuvy22850AX4f3nFY=;
        b=UTzOfuhqDFgg3To3F3pUz7GiaRkEcAhQL4DseCzXbEcZoLeVQ0mHkNhOfo3DS6Xh2o
         Fc/AOy6m0LP76UZQ8TWe/dBiUsZO1JUNjPEsvriiy9Xu8hhqiRNDQGcJqSTYOHWdCLI9
         WFHjBge9bj5rEFqO8+g1dQYLXysjpZDGOXzu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=f/bM7Zhn+VCpijaKkEu0Fz0bG4q3dUH3eceD5dwWnReE1hC2gxa6LiepG/8f65KtSN
         rdWcb5pJWwHgPicfNkLuSeQ7zF9933axxDxur19sH81yt9ybA64rhE3LFOa3hYlElO1F
         AffKzWRQJ/lRA/Tny+b+3PY4PKCVkrRZ81NI8=
Received: by 10.115.67.24 with SMTP id u24mr2003835wak.59.1255001560078;
        Thu, 08 Oct 2009 04:32:40 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm219646pzk.10.2009.10.08.04.32.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 04:32:39 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
Date:	Thu,  8 Oct 2009 19:32:28 +0800
Message-Id: <1255001548-30567-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

When CONFIG_FLATMEM enabled, STD/Hiberation will fail on YeeLoong
laptop, This patch fixes it:

if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
return TRUE, but in reality, if the memory is not continuous, it should
be false. for example:

$ cat /proc/iomem | grep "System RAM"
00000000-0fffffff : System RAM
90000000-bfffffff : System RAM

as we can see, it is not continuous, so, some of the memory is not valid
but regarded as valid by pfn_valid(), and at last make STD/Hibernate
fail when shrinking a too large number of invalid memory.

Here, we fix it via checking pfn is in the "System RAM" or not. and
Seems pfn_valid() is not called in assembly code, we move it to
"!__ASSEMBLY__" to ensure we can simply declare it via "extern int
pfn_valid(unsigned long)" without Compiling Error.

(This -v1 version incorporates feedback from Pavel Machek <pavel@ucw.cz>
 and Sergei Shtylyov <sshtylyov@ru.mvista.com>)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/page.h |   50 ++++++++++++++++++-----------------------
 arch/mips/mm/page.c          |   17 ++++++++++++++
 2 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 4320239..ef43905 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -145,36 +145,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  */
 #define ptep_buddy(x)	((pte_t *)((unsigned long)(x) ^ sizeof(pte_t)))
 
-#endif /* !__ASSEMBLY__ */
-
-/*
- * __pa()/__va() should be used only during mem init.
- */
-#ifdef CONFIG_64BIT
-#define __pa(x)								\
-({									\
-    unsigned long __x = (unsigned long)(x);				\
-    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
-})
-#else
-#define __pa(x)								\
-    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
-#endif
-#define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
-#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
-
-#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-
 #ifdef CONFIG_FLATMEM
 
-#define pfn_valid(pfn)							\
-({									\
-	unsigned long __pfn = (pfn);					\
-	/* avoid <linux/bootmem.h> include hell */			\
-	extern unsigned long min_low_pfn;				\
-									\
-	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
-})
+extern int pfn_valid(unsigned long);
 
 #elif defined(CONFIG_SPARSEMEM)
 
@@ -193,6 +166,27 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 #endif
 
+
+#endif /* !__ASSEMBLY__ */
+
+/*
+ * __pa()/__va() should be used only during mem init.
+ */
+#ifdef CONFIG_64BIT
+#define __pa(x)								\
+({									\
+    unsigned long __x = (unsigned long)(x);				\
+    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
+})
+#else
+#define __pa(x)								\
+    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
+#endif
+#define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
+#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
+
+#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+
 #define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
 #define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
 
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index f5c7375..e0a3f72 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -689,3 +689,20 @@ void copy_page(void *to, void *from)
 }
 
 #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
+
+#ifdef CONFIG_FLATMEM
+int pfn_valid(unsigned long pfn)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type == BOOT_MEM_RAM) {
+			if ((pfn >= PFN_DOWN(boot_mem_map.map[i].addr)) &&
+				(pfn < PFN_UP(boot_mem_map.map[i].addr +
+					boot_mem_map.map[i].size)))
+				return 1;
+		}
+	}
+	return 0;
+}
+#endif
-- 
1.6.2.1
