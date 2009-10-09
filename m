Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 18:15:55 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.159]:15619 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493053AbZJIQPs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 18:15:48 +0200
Received: by fg-out-1718.google.com with SMTP id d23so2008836fga.6
        for <multiple recipients>; Fri, 09 Oct 2009 09:15:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=uma1lgOgyv2lNiIbTljCoI2VEDHzaCnBKkQ9crsqYj8=;
        b=RkmpjDsRSBz1MRKDynvrbnKQSqg70EtEYbhmomHqCC1l282HuXS9A7mNPcgZRJ7YF7
         UiJjyCfXimjsG+rU0EZTrDa9t+x5e5X+Kr0jFZJg3AmFggPJaE8Hlbo7gQVqb+L5nATF
         s3wuaOWbg0g7M+K/T4Mfd4dpAs0vpPO+sG2G4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qEBPKaqVncswhqjwdw7uX5/dVPV51WQgU46/0JtHvpS/+3lX/u8x4gmQ9RKuzVzAoM
         VBucpA3joIifKqW8jPO1lIPuOqdWuYu82TDfBJ/xUMPF/bFetGRHj9ccNZErpLXxHIIr
         dHZucojIfMadbkCoHsRcV/LhEPui0XXgPCriI=
Received: by 10.86.231.13 with SMTP id d13mr2557302fgh.41.1255104947877;
        Fri, 09 Oct 2009 09:15:47 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id l12sm209550fgb.16.2009.10.09.09.15.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 09:15:47 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	rjw@sisk.pl, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
Date:	Sat, 10 Oct 2009 00:15:36 +0800
Message-Id: <1255104936-14921-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

When CONFIG_FLATMEM enabled, STD/Hiberation will fail on YeeLoong
laptop, This patch fixes it:

if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
return TRUE, but if the memory is not continuous, for example:

$ cat /proc/iomem | grep "System RAM"
00000000-0fffffff : System RAM
90000000-bfffffff : System RAM

as we can see, it is not continuous, so, some of the memory is not
valid, and at last make STD/Hibernate fail when shrinking a too large
number of invalid memory.

the "invalid" memory here include the memory space we never used.

10000000-3fffffff
80000000-8fffffff

and also include the meory space we have mapped into pci space.

40000000-7fffffff : pci memory space

Here, we fix it via checking pfn is in the "System RAM" or not. and
Seems pfn_valid() is not called in assembly code, we move it to
"!__ASSEMBLY__" to ensure we can simply declare it via "extern int
pfn_valid(unsigned long)" without Compiling Error.

(This -v1 version incorporates feedback from Pavel Machek <pavel@ucw.cz>
 and Sergei Shtylyov <sshtylyov@ru.mvista.com> and Ralf)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/page.h |   50 ++++++++++++++++++-----------------------
 arch/mips/mm/page.c          |   18 +++++++++++++++
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index f266295..dc28d0a 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -146,36 +146,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
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
 
@@ -194,6 +167,27 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
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
index f5c7375..203d805 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -689,3 +689,21 @@ void copy_page(void *to, void *from)
 }
 
 #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
+
+#ifdef CONFIG_FLATMEM
+int pfn_valid(unsigned long pfn)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if ((boot_mem_map.map[i].type == BOOT_MEM_RAM) ||
+			(boot_mem_map.map[i].type == BOOT_MEM_ROM_DATA)) {
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
