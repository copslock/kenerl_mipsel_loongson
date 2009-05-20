Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:09:02 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:45637 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025214AbZETWIy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:08:54 +0100
Received: by pzk40 with SMTP id 40so631075pzk.22
        for <multiple recipients>; Wed, 20 May 2009 15:08:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QL0h9hiBV6M233qZJHADzwdok1VP7qXN6orCeluObVo=;
        b=DPcNoZQIPBL7UGiHO07449yV0PDZfrp2ohY5nJoVSNSNNlINaadUrHChdE+2iLmb9d
         vaGNllofDu+kt/0Hz660/+lHmE/+lUGztxHPxr42DgNh0EuxBuN39y+obFmqtiGjbxFx
         3t8P+B72V2nzFJ2Gv6TlLJgul1/Tb7wF8SS/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JRDTn7Nhh7uPCqx8n/US08FEI/u56ncCBm0Ea4AfAKzYUbgEBmfH5GPNIC0vU6jFgd
         x6KC4CA9YBSjiJmLBARb07ZH1m3oFSlcSmlu70HNF9ZGRvf/PCtAmK+PFN+GzBBna//T
         4yUDJr2ItZz14xf3zkEwr/cdAAZKobbzy11K4=
Received: by 10.142.81.7 with SMTP id e7mr718642wfb.106.1242857327623;
        Wed, 20 May 2009 15:08:47 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 27sm4269136wfa.2.2009.05.20.15.08.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 15:08:46 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 17/27] define Loongson2F arch specific phys prot access
Date:	Thu, 21 May 2009 06:08:36 +0800
Message-Id: <f3dd2dbee3ddc701a3ca20ee7c8d4a7dda2f0467.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

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
1.6.2.1
