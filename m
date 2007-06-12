Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2007 13:33:15 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:39905 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022070AbXFLMdN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Jun 2007 13:33:13 +0100
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l5CCX5cj022140
	for <linux-mips@linux-mips.org>; Tue, 12 Jun 2007 08:33:05 -0400
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [127.0.0.1])
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11) with ESMTP id l5CCX5FO017938
	for <linux-mips@linux-mips.org>; Tue, 12 Jun 2007 08:33:05 -0400
Received: (from apache@localhost)
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l5CCX5Be017936;
	Tue, 12 Jun 2007 08:33:05 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 12 Jun 2007 08:33:05 -0400 (EDT)
Message-ID: <39830.129.133.92.31.1181651585.squirrel@webmail.wesleyan.edu>
In-Reply-To: <cda58cb80706120255w5ef28123tc27a8152d18e3039@mail.gmail.com>
References:  <cda58cb80706120255w5ef28123tc27a8152d18e3039@mail.gmail.com>
Date:	Tue, 12 Jun 2007 08:33:05 -0400 (EDT)
Subject: Legacy Address IO on MIPS PCI
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.193
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

I finally got a prelimenary patch together. It works in the sense it:

a) Compiles (native on the O2 and cross, based on 2.6.21.3).
b) Boots on the O2 and gives no apparent problems with any supported PCI
devices (ethernet, SCSI, etc.).
c) Gives legacy_io and legacy_mem in /sys/class/pci_bus/0000:xx/
d) Reduces the errors X.org gives from 16 to 4 when I try to use a PCI
video card on my O2.

However, PCI video still does not work. My best guess is that when I
copied the ia64 Legacy code, I left in incorrect offsets for the O2. I'm a
bit stuck as I don't really know how to test PCI Legacy (X.org could be
failing for other reasons) or figure out the proper offsets myself. Sadly,
I only half know what I doing here, so some input here would be much
appreciated. I've more or less exhausted any ideas that I had and thus am
stuck.

Also, since the offsets would be different for different supported
platforms, this should be written in the proper extensible way (i.e. not
hardcoded) though being new to kernel work, I'm not sure the right way to
do this so some pointers so I could make this more than a hack for my O2
and something everyone could benefit from would be helpful.

Here is the patch:

diff -uprN -X linux-2.6.21.3/Documentation/dontdiff
linux-2.6.21.3/arch/mips/pci/pci.c
linux-2.6.21.3_patch/arch/mips/pci/pci.c
--- linux-2.6.21.3/arch/mips/pci/pci.c  2007-05-29 09:15:01.000000000 -0400
+++ linux-2.6.21.3_patch/arch/mips/pci/pci.c    2007-06-08
03:18:05.000000000 -0400
@@ -13,6 +13,9 @@
 #include <linux/types.h>
 #include <linux/pci.h>

+#include <asm/pgtable.h>
+#include <asm/io.h>
+
 /*
  * Indicate whether we respect the PCI setup left by the firmware.
  *
@@ -338,3 +341,148 @@ char *pcibios_setup(char *str)
 {
        return str;
 }
+
+ int
+ pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
+                    enum pci_mmap_state mmap_state, int write_combine)
+ {
+       /*
+        * I/O space cannot be accessed via normal processor loads and
+        * stores on this platform.
+        */
+       if (mmap_state == pci_mmap_io)
+               /*
+                * XXX we could relax this for I/O spaces for which ACPI
+                * indicates that the space is 1-to-1 mapped.  But at the
+                * moment, we don't support multiple PCI address spaces and
+                * the legacy I/O space is not 1-to-1 mapped, so this is
moot.
+                */
+               return -EINVAL;
+
+       /*
+        * Leave vm_pgoff as-is, the PCI space address is the physical
+        * address on this platform.
+        */
+       if (write_combine)
+               vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+       else
+               vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+       if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+                            vma->vm_end - vma->vm_start, vma->vm_page_prot))
+               return -EAGAIN;
+
+       return 0;
+ }
+
+ /**
+  * mips_pci_get_legacy_mem - generic legacy mem routine
+  * @bus: bus to get legacy memory base address for
+  *
+  * Find the base of legacy memory for @bus.  This is typically the first
+  * megabyte of bus address space for @bus or is simply 0 on platforms whose
+  * chipsets support legacy I/O and memory routing.  Returns the base
address
+  * or an error pointer if an error occurred.
+  *
+  * This is the ia64 generic version of this routine.  Other platforms
+  * are free to override it with a machine vector.
+  */
+ char *mips_pci_get_legacy_mem(struct pci_bus *bus)
+ {
+       return (char *) 0;
+ }
+
+ /**
+  * pci_mmap_legacy_page_range - map legacy memory space to userland
+  * @bus: bus whose legacy space we're mapping
+  * @vma: vma passed in by mmap
+  *
+  * Map legacy memory space for this device back to userspace using a
machine
+  * vector to get the base address.
+  */
+ int
+ pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma)
+ {
+       unsigned long size = vma->vm_end - vma->vm_start;
+       pgprot_t prot;
+       char *addr;
+
+       addr = pci_get_legacy_mem(bus);
+       if (IS_ERR(addr))
+               return PTR_ERR(addr);
+
+       vma->vm_pgoff += (unsigned long)addr >> PAGE_SHIFT;
+
+       if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+                           size, vma->vm_page_prot))
+               return -EAGAIN;
+
+       return 0;
+ }
+
+ /**
+  * mips_pci_legacy_read - read from legacy I/O space
+  * @bus: bus to read
+  * @port: legacy port value
+  * @val: caller allocated storage for returned value
+  * @size: number of bytes to read
+  *
+  * Simply reads @size bytes from @port and puts the result in @val.
+  *
+  * Again, this (and the write routine) are generic versions that can be
+  * overridden by the platform.  This is necessary on platforms that don't
+  * support legacy I/O routing or that hard fail on legacy I/O timeouts.
+  */
+ int mips_pci_legacy_read(struct pci_bus *bus, u16 port, u32 *val, u8 size)
+ {
+       int ret = size;
+
+       switch (size) {
+       case 1:
+               *val = inb(port);
+               break;
+       case 2:
+               *val = inw(port);
+               break;
+       case 4:
+               *val = inl(port);
+               break;
+       default:
+               ret = -EINVAL;
+               break;
+       }
+
+       return ret;
+ }
+
+ /**
+  * mips_pci_legacy_write - perform a legacy I/O write
+  * @bus: bus pointer
+  * @port: port to write
+  * @val: value to write
+  * @size: number of bytes to write from @val
+  *
+  * Simply writes @size bytes of @val to @port.
+  */
+ int mips_pci_legacy_write(struct pci_bus *bus, u16 port, u32 val, u8 size)
+ {
+       int ret = size;
+
+       switch (size) {
+       case 1:
+               outb(val, port);
+               break;
+       case 2:
+               outw(val, port);
+               break;
+       case 4:
+               outl(val, port);
+               break;
+       default:
+               ret = -EINVAL;
+               break;
+       }
+
+       return ret;
+}
+
diff -uprN -X linux-2.6.21.3/Documentation/dontdiff
linux-2.6.21.3/include/asm-mips/pci.h
linux-2.6.21.3_patch/include/asm-mips/pci.h
--- linux-2.6.21.3/include/asm-mips/pci.h       2007-05-29
09:15:01.000000000 -0400
+++ linux-2.6.21.3_patch/include/asm-mips/pci.h 2007-06-05
23:34:13.000000000 -0400
@@ -195,3 +195,22 @@ static inline int pci_get_legacy_ide_irq
 }

 #endif /* _ASM_PCI_H */
+
+#define HAVE_PCI_MMAP
+extern int pci_mmap_page_range (struct pci_dev *dev, struct
vm_area_struct *vma,
+                                enum pci_mmap_state mmap_state, int
write_combine);
+#define HAVE_PCI_LEGACY
+extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
+                                      struct vm_area_struct *vma);
+extern ssize_t pci_read_legacy_io(struct kobject *kobj, char *buf, loff_t
off,
+                                  size_t count);
+extern ssize_t pci_write_legacy_io(struct kobject *kobj, char *buf,
loff_t off,
+                                   size_t count);
+extern int pci_mmap_legacy_mem(struct kobject *kobj,
+                               struct bin_attribute *attr,
+                               struct vm_area_struct *vma);
+
+#define pci_get_legacy_mem mips_pci_get_legacy_mem
+#define pci_legacy_read mips_pci_legacy_read
+#define pci_legacy_write mips_pci_legacy_write
+
diff -uprN -X linux-2.6.21.3/Documentation/dontdiff
linux-2.6.21.3/include/asm-mips/pgtable.h
linux-2.6.21.3_patch/include/asm-mips/pgtable.h
--- linux-2.6.21.3/include/asm-mips/pgtable.h   2007-05-29
09:15:01.000000000 -0400
+++ linux-2.6.21.3_patch/include/asm-mips/pgtable.h     2007-06-06
00:09:59.000000000 -0400
@@ -58,6 +58,10 @@ struct vm_area_struct;
 #define __S110 PAGE_SHARED
 #define __S111 PAGE_SHARED

+#define _PAGE_MA_WC             (0x6 <<  2)     /* write coalescing
memory attribute */
+#define _PAGE_MA_MASK           (0x7 <<  2)
+
+
 /*
  * ZERO_PAGE is a global shared page that is always zero; used
  * for zero-mapped memory areas etc..
@@ -323,6 +327,7 @@ static inline pte_t pte_mkyoung(pte_t pt
  * bits as well.
  */
 #define pgprot_noncached pgprot_noncached
+#define pgprot_writecombine(prot)       __pgprot((pgprot_val(prot) &
~_PAGE_MA_MASK) | _PAGE_MA_WC)

 static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 {
Binary files linux-2.6.21.3/vmlinux.32 and linux-2.6.21.3_patch/vmlinux.32
differ
