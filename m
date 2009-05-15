Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:20:33 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.173]:6315 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023149AbZEOWU1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:20:27 +0100
Received: by wf-out-1314.google.com with SMTP id 28so1227882wfa.21
        for <multiple recipients>; Fri, 15 May 2009 15:20:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=29JBbJh94XzcKkITs2lwIUOIkKzIBPZZovNGizjPa5Y=;
        b=FD/34HOZaL3kjan2tIKPQV7WyPNCvRVpWUqNDmOYyWubjEjAUeQT65OddUB4dgWqmP
         qq9NvONgoOYJ1mLb0dRlk0EU6+f1i4FCj0xKRIo5l70t7ogZOqurSagJMI4YRSNwcT3E
         loyRXI0vlYS+gT/gGKp148pBSoRNDj35oTXvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=bb1nY0v6Lw7hugsHipWhj+lqXCs6vG2Z8dGUTuaihsBf3k9AvkJSWxKebX4umYQPxN
         tlYPXj84Fkx6gpgH11x8+zau50uYgK2AA6X5+DZkFelWRv3pohTHJPGn0n9o7vernBzg
         g3+FD1ZkCWeLftprw/LVGNGQ1cU2QUGwNYy3Q=
Received: by 10.142.223.4 with SMTP id v4mr1330545wfg.11.1242426025013;
        Fri, 15 May 2009 15:20:25 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 27sm165873wff.26.2009.05.15.15.20.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:20:24 -0700 (PDT)
Subject: [PATCH 21/30] loongson: define Loongson2F arch specific phys prot
 access
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:20:18 +0800
Message-Id: <1242426018.10164.164.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 6eba97d7176eace554caddcc40c7e9719354fc62 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:34:23 +0800
Subject: [PATCH 21/30] loongson: define Loongson2F arch specific phys
prot access

The main purpose is to uncache accelerate for video memory access
---
 arch/mips/include/asm/pgtable.h |   13 +++++++++
 arch/mips/loongson/Kconfig      |   12 ++++++++
 arch/mips/loongson/common/mem.c |   56
+++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h
b/arch/mips/include/asm/pgtable.h
index 6a0edf7..3954da0 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -370,6 +370,19 @@ static inline int io_remap_pfn_range(struct
vm_area_struct *vma,
 #include <asm-generic/pgtable.h>
 
 /*
+ * uncache accelerate for video memory access
+ */
+#ifdef CONFIG_LOONGSON2F
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+
+struct file;
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+                              unsigned long size, pgprot_t vma_prot);
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+                              unsigned long size, pgprot_t *vma_prot);
+#endif
+
+/*
  * We provide our own get_unmapped area to cope with the virtual
aliasing
  * constraints placed on us by the cache architecture.
  */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 2622017..49cb375 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -99,3 +99,15 @@ config CS5536
 
 config SYS_HAS_MACH_PROM_INIT_CMDLINE
 	bool
+
+config UCA_SIZE
+ 	hex "Uncache Accelerated Region size"
+ 	depends on LOONGSON2F 
+ 	default 0x400000 if LEMOTE_YEELOONG2F
+ 	default 0x2000000 if LEMOTE_FULOONG2F
+ 	help
+ 	  Uncached Acceleration(UCA) can greatly improve video performance.
+ 	  Normally the Video memory can be accessed in Uncached Accelerated
mode,
+ 	  other peripheral spaces not.
+ 	  
+ 	  Specify a zeroed size to disable this feature. 
diff --git a/arch/mips/loongson/common/mem.c
b/arch/mips/loongson/common/mem.c
index 059d43f..4e1bf29 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -53,3 +53,59 @@ int __uncached_access(struct file *file, unsigned
long addr)
 	return addr >= __pa(high_memory) ||
 		((addr >= LOONGSON_MMIO_MEM_START) && (addr <
LOONGSON_MMIO_MEM_END));
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
+		if(uca_start && offset >= uca_start && end <= (uca_start + uca_size))
+			return __pgprot((pgprot_val(vma_prot) & ~_CACHE_MASK)|
_CACHE_UNCACHED_ACCELERATED);
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
+	if(uca_start)
+		return 0;
+	for_each_pci_dev(dev) {
+		if ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA){
+			for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
+				r = &dev->resource[idx];
+				if (!r->start && r->end) {
+					continue;
+				}
+				if (r->flags & IORESOURCE_IO)
+					continue;
+				if (r->flags & IORESOURCE_MEM){
+					uca_start = r->start;
+					printk("find the frame buffer:start=%lx\n", uca_start);
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
1.6.2.1
