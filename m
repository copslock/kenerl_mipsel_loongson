Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:10:52 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:57979 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022626AbZFDNJv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:09:51 +0100
Received: by pzk40 with SMTP id 40so740737pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:09:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gGSh9LDafchytdv9NMG0RYqDWBA5Oc5UcKHtkQgfVu0=;
        b=sbGo8Ha9nzkwbQ9ybRAtTii1dfpoXV/PVVSg7B3CN+efz+mX1KZSYiBxhhb0HvhbDq
         89nC9rnKCbg7g5k+wV/2srbaxzfabyurcWReI14iWLljFHIE+TZ3Fhhlf63RqNiQITUW
         VLdTQe6wrvUxahZ2DZFlMPpoywnrV0WuLtEpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GcDUChZdpaXWJPHhovw1T/z6NudJkO8ChbnsDOr3nAPp4zGWie5aKA8OKFHGBYBTsA
         Bz3mGSWLRBgfu4cTCG3e03d7iu4UzgXPsBoCu/e4Fr9q3T0ogREZjn8FFf5etEGkO+6M
         oXi/h+AK4by5Mcy81JDiu4m+l+TgNX8zPTvC8=
Received: by 10.115.75.6 with SMTP id c6mr3420890wal.118.1244120984396;
        Thu, 04 Jun 2009 06:09:44 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c26sm11120695waa.15.2009.06.04.06.09.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:09:43 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 19/25] define Loongson2F arch specific phys prot access
Date:	Thu,  4 Jun 2009 21:09:30 +0800
Message-Id: <01643150cca698e6f405753b78eb435c7034d361.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

The main purpose is to uncache accelerate for video memory access

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Yan Hua <yanh@lemote.com>
---
 arch/mips/include/asm/pgtable.h |   13 ++++++++
 arch/mips/loongson/Kconfig      |   12 +++++++
 arch/mips/loongson/common/mem.c |   63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 6a0edf7..fdb32a5 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -370,6 +370,19 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 #include <asm-generic/pgtable.h>
 
 /*
+ * uncache accelerate for video memory access
+ */
+#ifdef CONFIG_LOONGSON2F
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
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 9cc817f..3d582cb 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -114,3 +114,15 @@ config CS5536_UDC
 
 config SYS_HAS_MACH_PROM_INIT_CMDLINE
 	bool
+
+config UCA_SIZE
+	hex "Uncache Accelerated Region size"
+	depends on CPU_LOONGSON2F
+	default 0x400000 if LEMOTE_YEELOONG2F
+	default 0x2000000 if LEMOTE_FULOONG2F
+	help
+	  Uncached Acceleration(UCA) can greatly improve video performance.
+	  Normally the Video memory can be accessed in Uncached Accelerated mode,
+	  other peripheral spaces not.
+
+	  Specify a zeroed size to disable this feature.
diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
index 9e0b6e0..7223d82 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -51,3 +51,66 @@ int __uncached_access(struct file *file, unsigned long addr)
 		((addr >= LOONGSON_MMIO_MEM_START) && \
 			(addr < LOONGSON_MMIO_MEM_END));
 }
+
+#if defined(CONFIG_CPU_LOONGSON2F)
+
+#include <linux/pci.h>
+#include <linux/sched.h>
+#include <asm/current.h>
+
+static unsigned long uca_start;
+static unsigned long uca_size = CONFIG_UCA_SIZE;
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+				     unsigned long size, pgprot_t vma_prot)
+{
+	unsigned long offset = pfn << PAGE_SHIFT;
+	unsigned long end = offset + size;
+
+	if (__uncached_access(file, offset)) {
+		if (((uca_start && offset) >= uca_start) && \
+				(end <= (uca_start + uca_size)))
+			return __pgprot((pgprot_val(vma_prot) & \
+						~_CACHE_MASK) | \
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
+
+					printk(KERN_INFO
+					"find the frame buffer:start=%lx\n",
+					uca_start);
+
+					return 0;
+				}
+			}
+
+		}
+	}
+	return 0;
+}
+
+late_initcall(find_vga_mem_init);
+#endif /* !CONFIG_CPU_LOONGSON2F */
-- 
1.6.0.4
