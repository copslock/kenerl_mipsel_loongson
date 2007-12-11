Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 12:12:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:22410 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026954AbXLKMMv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 12:12:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBBCCLVo010998;
	Tue, 11 Dec 2007 12:12:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBBCCKSm010997;
	Tue, 11 Dec 2007 12:12:20 GMT
Date:	Tue, 11 Dec 2007 12:12:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Cobalt fixes
Message-ID: <20071211121220.GA10870@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Some may have been following the beginning of this thread on linux-kernel,
see for example

  http://www.opensubscriber.com/message/linux-kernel@vger.kernel.org/8161812.html

for non-subscribers.  Linus has reverted the offending patch
fd6e732186ab522c812ab19c2c5e5befb8ec8115 in question so now the PCI and
I/O port code needs to be fixed up to be able to handle such a setup.

A test report of this patch which is meant to be applied on top of
today's lmo git kernel on a Cobalt would be appreciated.

  Ralf

[MIPS] Cobalt: Sort out legacy I/O port addressing.

Thanks to the brainfucked GT-64111 which passes CPU addresses in the PCI I/O
window to the PCI bus without any translation a Cobalt cannot generate
a low I/O port address that is below < 0x10000000 in the GT-64111 default
configuration.  Fortunately the VIA VT82C586 southbridge used in Cobalts
only decodes the low 16 bits of the I/O port address for its legacy devices.
This can be exploited to generate equivalent addresses but need to use
an address different from mips_io_port_base as the base to work.  In
addition PCI fixups need to be prevented from tinkering with legacy
addresses.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/cobalt/pci.c b/arch/mips/cobalt/pci.c
index cfce7af..b1fc6bd 100644
--- a/arch/mips/cobalt/pci.c
+++ b/arch/mips/cobalt/pci.c
@@ -24,8 +24,8 @@ static struct resource cobalt_mem_resource = {
 };
 
 static struct resource cobalt_io_resource = {
-	.start	= 0x1000,
-	.end	= GT_DEF_PCI0_IO_SIZE - 1,
+	.start	= GT_DEF_PCI0_IO_BASE + 0x1000,
+	.end	= GT_DEF_PCI0_IO_BASE + GT_DEF_PCI0_IO_SIZE - 1,
 	.name	= "PCI I/O",
 	.flags	= IORESOURCE_IO,
 };
@@ -34,7 +34,7 @@ static struct pci_controller cobalt_pci_controller = {
 	.pci_ops	= &gt64xxx_pci0_ops,
 	.mem_resource	= &cobalt_mem_resource,
 	.io_resource	= &cobalt_io_resource,
-	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
+	.io_offset	= 0,
 	.io_map_base	= CKSEG1ADDR(GT_DEF_PCI0_IO_BASE),
 };
 
diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index dd23beb..f99eaa9 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -79,10 +79,11 @@ void __init plat_mem_setup(void)
 	_machine_halt = cobalt_machine_halt;
 	pm_power_off = cobalt_machine_halt;
 
-	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
+	set_io_port_base(IO_BASE);
+	set_legacy_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
 	/* I/O port resource must include LCD/buttons */
-	ioport_resource.end = 0x0fffffff;
+	ioport_resource.end =  GT_DEF_PCI0_IO_BASE + GT_DEF_PCI0_IO_SIZE - 1;
 
 	/* These resources have been reserved by VIA SuperI/O chip. */
 	for (i = 0; i < ARRAY_SIZE(cobalt_reserved_resources); i++)
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 7f6ddcb..f8b3f5a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -60,11 +60,14 @@ static char command_line[CL_SIZE];
        char arcs_cmdline[CL_SIZE]=CONFIG_CMDLINE;
 
 /*
- * mips_io_port_base is the begin of the address space to which x86 style
- * I/O ports are mapped.
+ * mips_io_port_base is the base of the address range into which the I/O ports
+ * are mapped.  mips_legacy_io_port_base is the same but used only for legacy
+ * addresses below legacy_io_port_top.
  */
 const unsigned long mips_io_port_base __read_mostly = -1;
 EXPORT_SYMBOL(mips_io_port_base);
+const unsigned long mips_legacy_io_port_base __read_mostly = -1;
+EXPORT_SYMBOL(mips_legacy_io_port_base);
 
 /*
  * isa_slot_offset is the address where E(ISA) busaddress 0 is mapped
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index f7df114..7da133b 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -51,6 +51,18 @@ static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
 	 qube_raq_galileo_early_fixup);
 
+static void __devinit cobalt_via_ide_native_mode_fixup(struct pci_dev *dev)
+{
+	unsigned char pif;
+
+	pci_read_config_byte(dev, PCI_CLASS_PROG, &pif);
+	pif |= 4;
+	pci_write_config_byte(dev, PCI_CLASS_PROG, pif);
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
+	 cobalt_via_ide_native_mode_fixup);
+
 static void qube_raq_via_bmIDE_fixup(struct pci_dev *dev)
 {
 	unsigned short cfgword;
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 589b745..6e6981f 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -242,6 +242,8 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!dev->resource[i].start)
 			continue;
+		if (dev->resource[i].flags & IORESOURCE_PCI_FIXED)
+			continue;
 		if (dev->resource[i].flags & IORESOURCE_IO)
 			offset = hose->io_offset;
 		else if (dev->resource[i].flags & IORESOURCE_MEM)
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index e62058b..953be3b 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -53,11 +53,16 @@
 /*
  * On MIPS I/O ports are memory mapped, so we access them using normal
  * load/store instructions. mips_io_port_base is the virtual address to
- * which all ports are being mapped.  For sake of efficiency some code
- * assumes that this is an address that can be loaded with a single lui
- * instruction, so the lower 16 bits must be zero.  Should be true on
- * on any sane architecture; generic code does not use this assumption.
+ * which all ports are being mapped.  mips_legacy_io_port_base the same
+ * but used for ports below legacy_io_port_top.  This special treatment
+ * of legacy addresses is used for example on Cobalt systems where the
+ * GT-64111 system controller doesn't allow access to low ports but aliasing
+ * can be exploited to access them anyway.  So on a GT-64111 system
+ * mips_legacy_io_port_base would point to the base of the address range
+ * to which I/O ports are aliased.  Having the legacy_io_port_top default of
+ * zero leaves this special treatment disabled by default.
  */
+extern const unsigned long mips_legacy_io_port_base;
 extern const unsigned long mips_io_port_base;
 
 /*
@@ -75,6 +80,12 @@ static inline void set_io_port_base(unsigned long base)
 	barrier();
 }
 
+static inline void set_legacy_io_port_base(unsigned long base)
+{
+	* (unsigned long *) &mips_legacy_io_port_base = base;
+	barrier();
+}
+
 /*
  * Thanks to James van Artsdalen for a better timing-fix than
  * the two short jumps: using outb's to a nonexistent port seems
@@ -375,9 +386,14 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 {									\
 	volatile type *__addr;						\
+	unsigned long __vaddr;						\
 	type __val;							\
 									\
-	__addr = (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
+	if (port < legacy_io_port_top)					\
+		__vaddr = mips_legacy_io_port_base + port;		\
+	else								\
+		__vaddr = mips_io_port_base + port;			\
+	__addr = (void *)__swizzle_addr_##bwlq(__vaddr);		\
 									\
 	__val = pfx##ioswab##bwlq(__addr, val);				\
 									\
@@ -391,9 +407,14 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 static inline type pfx##in##bwlq##p(unsigned long port)			\
 {									\
 	volatile type *__addr;						\
+	unsigned long __vaddr;						\
 	type __val;							\
 									\
-	__addr = (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
+	if (port < legacy_io_port_top)					\
+		__vaddr = mips_legacy_io_port_base + port;		\
+	else								\
+		__vaddr = mips_io_port_base + port;			\
+	__addr = (void *)__swizzle_addr_##bwlq(__vaddr);		\
 									\
 	BUILD_BUG_ON(sizeof(type) > sizeof(unsigned long));		\
 									\
diff --git a/include/asm-mips/mach-cobalt/mangle-port.h b/include/asm-mips/mach-cobalt/mangle-port.h
new file mode 100644
index 0000000..bdf5450
--- /dev/null
+++ b/include/asm-mips/mach-cobalt/mangle-port.h
@@ -0,0 +1,27 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004, 2007 Ralf Baechle (ralf@linux-mips.org)
+ */
+#ifndef __ASM_MACH_COBALT_MANGLE_PORT_H
+#define __ASM_MACH_COBALT_MANGLE_PORT_H
+
+#define __swizzle_addr_b(port)	(port)
+#define __swizzle_addr_w(port)	(port)
+#define __swizzle_addr_l(port)	(port)
+#define __swizzle_addr_q(port)	(port)
+
+# define ioswabb(a, x)		(x)
+# define __mem_ioswabb(a, x)	(x)
+# define ioswabw(a, x)		(x)
+# define __mem_ioswabw(a, x)	cpu_to_le16(x)
+# define ioswabl(a, x)		(x)
+# define __mem_ioswabl(a, x)	cpu_to_le32(x)
+# define ioswabq(a, x)		(x)
+# define __mem_ioswabq(a, x)	cpu_to_le32(x)
+
+#define legacy_io_port_top	0
+
+#endif /* __ASM_MACH_COBALT_MANGLE_PORT_H */
diff --git a/include/asm-mips/mach-generic/mangle-port.h b/include/asm-mips/mach-generic/mangle-port.h
index f49dc99..7f59bff 100644
--- a/include/asm-mips/mach-generic/mangle-port.h
+++ b/include/asm-mips/mach-generic/mangle-port.h
@@ -49,4 +49,6 @@
 
 #endif
 
+#define legacy_io_port_top	0
+
 #endif /* __ASM_MACH_GENERIC_MANGLE_PORT_H */
