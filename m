Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4HIBNj19644
	for linux-mips-outgoing; Thu, 17 May 2001 11:11:23 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4HIBIF19638;
	Thu, 17 May 2001 11:11:18 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4HIBI008344;
	Thu, 17 May 2001 11:11:18 -0700
Message-ID: <3B0413A4.8060607@mvista.com>
Date: Thu, 17 May 2001 11:08:36 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: full 32bit ioremap
Content-Type: multipart/mixed;
 boundary="------------080905050507070900050801"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------080905050507070900050801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Ralf,

I've attached a patch to add full 32 bit ioremap support for mips. It's 
basically x86 ioremap with a couple of small changes.  I've tested it on 
one board and it works fine, although some driver modifications were 
necessary since the minimum ioremap size is 0x1000.  I realize no other 
boards require ioremap beyond 0x2000 0000 at this time, but others may 
benefit from it in the future. The default is to not use it, so nothing 
needs to be changed in any of the boards supported, except the defconfig 
file.

Pete

--------------080905050507070900050801
Content-Type: text/plain;
 name="ioremap32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioremap32.patch"

diff -Naur --exclude=CVS --exclude=.cvsignore linux/Documentation/Configure.help linux_new/Documentation/Configure.help
--- linux/Documentation/Configure.help	Wed Apr  4 21:56:06 2001
+++ linux_new/Documentation/Configure.help	Thu May 17 10:02:46 2001
@@ -229,6 +229,14 @@
 
   If unsure, say "off".
 
+MIPS 32bit ioremap support
+CONFIG_MIPS_32BIT_IOREMAP
+  If you want to be able to remap I/O devices on any 32 bit physical
+  address, say Y.  Without this feature, I/O devices MUST reside on
+  a physical address less than 0x2000 0000.   Do NOT say Y unless
+  you're absolutely sure you know what this feature is and what
+  are the implications for device drivers.
+
 Normal PC floppy disk support
 CONFIG_BLK_DEV_FD
   If you want to use the floppy disk drive(s) of your PC under Linux,
diff -Naur --exclude=CVS --exclude=.cvsignore linux/arch/mips/config.in linux_new/arch/mips/config.in
--- linux/arch/mips/config.in	Tue May  8 17:32:39 2001
+++ linux_new/arch/mips/config.in	Thu May 17 10:09:16 2001
@@ -232,6 +232,7 @@
 if [ "$CONFIG_CPU_ADVANCED" = "y" ]; then
    bool '  ll/sc Instructions available' CONFIG_CPU_HAS_LLSC
    bool '  Writeback Buffer available' CONFIG_CPU_HAS_WB
+   bool '  Enable full 32 bit ioremap' CONFIG_MIPS_32BIT_IOREMAP
 else
    if [ "$CONFIG_CPU_R3000" = "y" ]; then
       if [ "$CONFIG_DECSTATION" = "y" ]; then
diff -Naur --exclude=CVS --exclude=.cvsignore linux/arch/mips/mm/Makefile linux_new/arch/mips/mm/Makefile
--- linux/arch/mips/mm/Makefile	Sat Mar 31 18:54:22 2001
+++ linux_new/arch/mips/mm/Makefile	Thu May 17 10:57:19 2001
@@ -12,6 +12,7 @@
 export-objs			+= umap.o
 obj-y				+= extable.o init.o fault.o loadmmu.o
 
+obj-$(CONFIG_MIPS_32BIT_IOREMAP) += ioremap.o
 obj-$(CONFIG_CPU_R3000)		+= r2300.o
 obj-$(CONFIG_CPU_R4300)		+= r4xx0.o
 obj-$(CONFIG_CPU_R4X00)		+= r4xx0.o
diff -Naur --exclude=CVS --exclude=.cvsignore linux/arch/mips/mm/ioremap.c linux_new/arch/mips/mm/ioremap.c
--- linux/arch/mips/mm/ioremap.c	Wed Dec 31 16:00:00 1969
+++ linux_new/arch/mips/mm/ioremap.c	Thu May 17 10:08:37 2001
@@ -0,0 +1,180 @@
+
+#include <linux/config.h>
+#include <asm/addrspace.h>
+#include <asm/byteorder.h>
+
+#include <linux/vmalloc.h>
+#include <asm/io.h>
+#include <asm/pgalloc.h>
+
+#undef DEBUG_MIPS_32BIT_IOREMAP
+
+void * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags);
+
+void * ioremap(unsigned long offset, unsigned long size)
+{
+	/*
+	 * MIPS device drivers are used to ioremap returning a kseg1 address,
+	 * so we always call __ioremap with the _CACHE_UNCACHED flag.
+	 */
+	return __ioremap(offset, size, _CACHE_UNCACHED);
+}
+
+/*
+ * This one maps high address device memory and turns off caching for that area.
+ * it's useful if some control registers are in such an area and write combining
+ * or read caching is not desirable:
+ */
+void * ioremap_nocache (unsigned long offset, unsigned long size)
+{
+	return __ioremap(offset, size, _CACHE_UNCACHED);
+}
+
+void iounmap(void *addr)
+{
+	if (addr > high_memory) 
+		return vfree((void *) (PAGE_MASK & (unsigned long) addr));
+}
+
+
+static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
+	unsigned long phys_addr, unsigned long flags)
+{
+	unsigned long end;
+
+	address &= ~PMD_MASK;
+	end = address + size;
+	if (end > PMD_SIZE)
+		end = PMD_SIZE;
+	if (address >= end)
+		BUG();
+	do {
+		if (!pte_none(*pte)) {
+			printk("remap_area_pte: page already exists\n");
+			BUG();
+		}
+		set_pte(pte, mk_pte_phys(phys_addr, __pgprot(_PAGE_PRESENT | __READABLE | 
+					__WRITEABLE | flags)));
+		address += PAGE_SIZE;
+		phys_addr += PAGE_SIZE;
+		pte++;
+	} while (address && (address < end));
+}
+
+static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
+	unsigned long phys_addr, unsigned long flags)
+{
+	unsigned long end;
+
+	address &= ~PGDIR_MASK;
+	end = address + size;
+	if (end > PGDIR_SIZE)
+		end = PGDIR_SIZE;
+	phys_addr -= address;
+	if (address >= end)
+		BUG();
+	do {
+		pte_t * pte = pte_alloc(&init_mm, pmd, address);
+		if (!pte)
+			return -ENOMEM;
+		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
+		address = (address + PMD_SIZE) & PMD_MASK;
+		pmd++;
+	} while (address && (address < end));
+	return 0;
+}
+
+static int remap_area_pages(unsigned long address, unsigned long phys_addr,
+				 unsigned long size, unsigned long flags)
+{
+	int error;
+	pgd_t * dir;
+	unsigned long end = address + size;
+
+	phys_addr -= address;
+	dir = pgd_offset(&init_mm, address);
+	flush_cache_all();
+	if (address >= end)
+		BUG();
+	spin_lock(&init_mm.page_table_lock);
+	do {
+		pmd_t *pmd;
+		pmd = pmd_alloc(&init_mm, dir, address);
+		error = -ENOMEM;
+		if (!pmd)
+			break;
+		if (remap_area_pmd(pmd, address, end - address,
+					 phys_addr + address, flags))
+			break;
+		error = 0;
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		dir++;
+	} while (address && (address < end));
+	spin_unlock(&init_mm.page_table_lock);
+	flush_tlb_all();
+	return error;
+}
+
+/*
+ * Generic mapping function (not visible outside):
+ */
+
+/*
+ * Remap an arbitrary physical address space into the kernel virtual
+ * address space. Needed when the kernel wants to access high addresses
+ * directly.
+ *
+ * NOTE! We need to allow non-page-aligned mappings too: we will obviously
+ * have to convert them into an offset in a page-aligned mapping, but the
+ * caller shouldn't need to know that small detail.
+ */
+void * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+{
+	void * addr;
+	struct vm_struct * area;
+	unsigned long offset, last_addr;
+
+	/* Don't allow wraparound or zero size */
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
+		return NULL;
+
+	/*
+	 * Don't allow anybody to remap normal RAM that we're using..
+	 */
+	if (phys_addr < virt_to_phys(high_memory)) {
+		char *t_addr, *t_end;
+		struct page *page;
+
+		t_addr = __va(phys_addr);
+		t_end = t_addr + (size - 1);
+	   
+		for(page = virt_to_page(t_addr); page <= virt_to_page(t_end); page++)
+			if(!PageReserved(page))
+				return NULL;
+	}
+
+	/*
+	 * Mappings have to be page-aligned
+	 */
+	offset = phys_addr & ~PAGE_MASK;
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(last_addr) - phys_addr;
+
+	/*
+	 * Ok, go for it..
+	 */
+	area = get_vm_area(size, VM_IOREMAP);
+	if (!area)
+		return NULL;
+	addr = area->addr;
+	if (remap_area_pages(VMALLOC_VMADDR(addr), phys_addr, size, flags)) {
+		vfree(addr);
+		return NULL;
+	}
+
+#ifdef DEBUG_MIPS_32BIT_IOREMAP
+	printk("__ioremap %x:  %x\n", phys_addr, offset+(char *)addr); 
+#endif
+	return (void *) (offset + (char *)addr);
+}
diff -Naur --exclude=CVS --exclude=.cvsignore linux/include/asm-mips/io.h linux_new/include/asm-mips/io.h
--- linux/include/asm-mips/io.h	Fri Feb  9 16:43:15 2001
+++ linux_new/include/asm-mips/io.h	Thu May 17 10:39:35 2001
@@ -133,6 +133,7 @@
  */
 extern unsigned long isa_slot_offset;
 
+#ifndef CONFIG_MIPS_32BIT_IOREMAP
 /*
  * readX/writeX() are used to access memory mapped devices. On some
  * architectures the memory mapped IO stuff needs to be accessed
@@ -165,6 +166,7 @@
 extern inline void iounmap(void *addr)
 {
 }
+#endif
 
 /*
  * XXX We need system specific versions of these to handle EISA address bits

--------------080905050507070900050801--
