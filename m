Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:09:15 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:57793 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024677AbZEZTIM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:08:12 +0100
Received: by pxi17 with SMTP id 17so3790363pxi.22
        for <multiple recipients>; Tue, 26 May 2009 12:08:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=09mmsmw3jxlew/7UOJhsLVwklpBeyjzfQuWOUfh4bF0=;
        b=G/n8OkZYa7Asxt1ndb+F1sTb96Yk+JsZHsIiiTrxRRTTxOMMHffwpBjJ1jQwe5FFMj
         Irrjr+85ESJcAF8SeNG97ItWpsTQ4J+sJDZ2gV46ALIAkjAX2zwK5rlYLqqHeYXVK1fy
         hs0K8NX6rs4KaV18ccG7tFFjz8fIhPDrTDrYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CPtBtL73iP4twpkbwWVWtmXFL94kaoFt6rPP/1+jWU7IVlDGTb1JCokjvLz+SFYLwK
         2NrIZ2xFhMOnpk3B1L95IWy5QEZW7MuW8SCz1sdZ9tEkb6NQLdnY88liVhKDlrP4K5bt
         wyvde0Pw9O5NN2U2nk7TEz5p6sKPYhZbX11IM=
Received: by 10.114.79.18 with SMTP id c18mr17895978wab.215.1243364884318;
        Tue, 26 May 2009 12:08:04 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id n9sm11866318wag.32.2009.05.26.12.07.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:08:03 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v2 15/23] define Loongson2F arch specific phys prot access
Date:	Wed, 27 May 2009 03:07:54 +0800
Message-Id: <76d5842ec60f355b27c2f7cf8456afec5a0b076b.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

The main purpose is to uncache accelerate for video memory access

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
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
