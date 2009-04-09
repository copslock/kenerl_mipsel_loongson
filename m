Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 06:04:55 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:47068 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20022124AbZDIFEt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 06:04:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 89E3834129;
	Thu,  9 Apr 2009 13:01:50 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ca3gCYj3orjy; Thu,  9 Apr 2009 13:01:44 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 951F53412F;
	Thu,  9 Apr 2009 13:01:44 +0800 (CST)
Message-ID: <49DD81E5.3020100@lemote.com>
Date:	Thu, 09 Apr 2009 13:04:37 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 9/14] lemote: define Loongson2F arch specific phys prot access
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

The main purpose is to uncache accelerate for video memory access
---
arch/mips/include/asm/pgtable.h | 10 +++++++
arch/mips/lemote/lm2f/Kconfig | 10 +++++++
arch/mips/lemote/lm2f/common/mem.c | 53 ++++++++++++++++++++++++++++++++++++
3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h
b/arch/mips/include/asm/pgtable.h
index 6a0edf7..9880f2e 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -369,6 +369,16 @@ static inline int io_remap_pfn_range(struct
vm_area_struct *vma,

#include <asm-generic/pgtable.h>

+#ifdef CONFIG_MACH_LM2F
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+
+struct file;
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+ unsigned long size, pgprot_t vma_prot);
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+ unsigned long size, pgprot_t *vma_prot);
+#endif
+
/*
* We provide our own get_unmapped area to cope with the virtual aliasing
* constraints placed on us by the cache architecture.
diff --git a/arch/mips/lemote/lm2f/Kconfig b/arch/mips/lemote/lm2f/Kconfig
index bdf34e5..605a6af 100644
--- a/arch/mips/lemote/lm2f/Kconfig
+++ b/arch/mips/lemote/lm2f/Kconfig
@@ -75,3 +75,13 @@ config LEMOTE_NAS
help
Lemote's Loongson-2F based network attached system

+config UCA_SIZE
+ hex "Uncache Accelerated Region size"
+ depends on MACH_LM2F
+ default 0x400000 if LEMOTE_YELOONG2F
+ default 0x2000000 if LEMOTE_FULOONG2F
+ help
+ Uncached Acceleration(UCA) can greatly improve video performance.
+ Normally the Video memory can be accessed in Uncached Accelerated mode,
+ other peripheral spaces not.
+ Specify a zeroed size to disable this feature.
diff --git a/arch/mips/lemote/lm2f/common/mem.c
b/arch/mips/lemote/lm2f/common/mem.c
index aa25ad4..a0cf8fa 100644
--- a/arch/mips/lemote/lm2f/common/mem.c
+++ b/arch/mips/lemote/lm2f/common/mem.c
@@ -8,6 +8,13 @@
#include <linux/fcntl.h>
#include <linux/mm.h>

+#include <linux/pci.h>
+
+#include <linux/sched.h>
+#include <asm/current.h>
+
+static unsigned long uca_start;
+static unsigned long uca_size = CONFIG_UCA_SIZE;
/* override of arch/mips/mm/cache.c: __uncached_access */
int __uncached_access(struct file *file, unsigned long addr)
{
@@ -21,3 +28,49 @@ int __uncached_access(struct file *file, unsigned
long addr)
return addr >= __pa(high_memory) ||
((addr >= 0x10000000) && (addr < 0x80000000));
}
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+ unsigned long size, pgprot_t vma_prot)
+{
+ unsigned long offset = pfn << PAGE_SHIFT;
+ unsigned long end = offset + size;
+
+ if (__uncached_access(file, offset)) {
+ if(uca_start && offset >= uca_start && end <= (uca_start + uca_size))
+ return __pgprot((pgprot_val(vma_prot) &
~_CACHE_MASK)|_CACHE_UNCACHED_ACCELERATED);
+ else
+ return pgprot_noncached(vma_prot);
+ }
+ return vma_prot;
+}
+
+static int __init find_vga_mem_init(void)
+{
+ struct pci_dev *dev = 0;
+ struct resource *r;
+ int idx;
+
+ if(uca_start)
+ return 0;
+ for_each_pci_dev(dev) {
+ if ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA){
+ for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
+ r = &dev->resource[idx];
+ if (!r->start && r->end) {
+ continue;
+ }
+ if (r->flags & IORESOURCE_IO)
+ continue;
+ if (r->flags & IORESOURCE_MEM){
+ uca_start = r->start;
+ printk("find the frame buffer:start=%lx\n", uca_start);
+ return 0;
+ }
+ }
+
+ }
+ }
+ return 0;
+}
+late_initcall(find_vga_mem_init);
+
-- 
1.5.6.5
