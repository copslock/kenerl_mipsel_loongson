Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 07:00:17 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:54670 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492299AbZKKF7u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 06:59:50 +0100
Received: by gxk2 with SMTP id 2so712293gxk.4
        for <multiple recipients>; Tue, 10 Nov 2009 21:59:44 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=H3j1xOjD6/CccPgS94bTHeAP9QlmC8Qgv4j7gkHvobY=;
        b=hVKrliXXf0l4HtBDY/rypLcPE/GMn4oQ82M7zcySrxag4jpElcpyyBrFXHdgEFV3xG
         j7r5SYK1FlwDGzFWArCKp/UQXyKfKTGACMQJRPo+kF++G2K/HZezNRs8igj1K+Qs+ayP
         PAQ91h04eI5KKorp/NCopFpQg/3z7GoFCMXPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vp0tvt+pMXC/SEknHGpn77XOB5LPhkx1VhdYlNDB40jk11MyVvYvW5oI7kJ3sH3gC1
         Y9xXJ9oageuNGYW3LtrpeOuRDGJHTkZu8F2qyVMLno6OrK4lBleJw7jKxu5g4X1rY6Ak
         EmpR1MXSItRLKdEleG3jdpLjtVcpdm09zDCrI=
Received: by 10.90.10.9 with SMTP id 9mr1705021agj.69.1257919183964;
        Tue, 10 Nov 2009 21:59:43 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 34sm703043yxf.11.2009.11.10.21.59.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 21:59:43 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/2] [loongson] 2f: Improve video performance via uncached accelerated TLB map
Date:	Wed, 11 Nov 2009 13:59:24 +0800
Message-Id: <b741a25cbbc91dd9ea1f9649b8ae7a1e3cf6322d.1257918796.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <ff4228281d1e0fcadf2f34b922c2324d095fd938.1257918796.git.wuzhangjin@gmail.com>
References: <cover.1257918796.git.wuzhangjin@gmail.com>
 <ff4228281d1e0fcadf2f34b922c2324d095fd938.1257918796.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257918796.git.wuzhangjin@gmail.com>
References: <cover.1257918796.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Loongson2F support video acceleration, and need to enable Uncached
Accelerated TLB map.

Uncached Accelerated TLB map can greatly improve video performance.
Normally the Video memory can be accessed in Uncached Accelerated mode,
other peripheral spaces not.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/pgtable.h |   13 +++++++++
 arch/mips/loongson/common/mem.c |   58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index d6eb613..56b8621 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -390,6 +390,19 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 #include <asm-generic/pgtable.h>
 
 /*
+ * uncached accelerated TLB map for video memory access
+ */
+#ifdef CONFIG_CPU_SUPPORT_VIDEO_ACC
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+
+struct file;
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+		unsigned long size, pgprot_t vma_prot);
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+		unsigned long size, pgprot_t *vma_prot);
+#endif
+
+/*
  * We provide our own get_unmapped area to cope with the virtual aliasing
  * constraints placed on us by the cache architecture.
  */
diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
index 467a91e..cf19393 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -59,3 +59,61 @@ int __uncached_access(struct file *file, unsigned long addr)
 	    ((addr >= LOONGSON_MMIO_MEM_START) &&
 	     (addr < LOONGSON_MMIO_MEM_END));
 }
+
+#ifdef CONFIG_CPU_SUPPORT_VIDEO_ACC
+
+#include <linux/pci.h>
+#include <linux/sched.h>
+#include <asm/current.h>
+
+static unsigned long uca_start, uca_end;
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+			      unsigned long size, pgprot_t vma_prot)
+{
+	unsigned long offset = pfn << PAGE_SHIFT;
+	unsigned long end = offset + size;
+
+	if (__uncached_access(file, offset)) {
+		if (((uca_start && offset) >= uca_start) &&
+		    (end <= uca_end))
+			return __pgprot((pgprot_val(vma_prot) &
+					 ~_CACHE_MASK) |
+					_CACHE_UNCACHED_ACCELERATED);
+		else
+			return pgprot_noncached(vma_prot);
+	}
+	return vma_prot;
+}
+
+static int __init find_vga_mem_init(void)
+{
+	struct pci_dev *dev = 0;
+	struct resource *r;
+	int idx;
+
+	if (uca_start)
+		return 0;
+
+	for_each_pci_dev(dev) {
+		if ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
+			for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
+				r = &dev->resource[idx];
+				if (!r->start && r->end)
+					continue;
+				if (r->flags & IORESOURCE_IO)
+					continue;
+				if (r->flags & IORESOURCE_MEM) {
+					uca_start = r->start;
+					uca_end = r->end;
+					return 0;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+late_initcall(find_vga_mem_init);
+#endif				/* !CONFIG_CPU_SUPPORT_VIDEO_ACC */
-- 
1.6.2.1
