Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2SDPFl09673
	for linux-mips-outgoing; Thu, 28 Mar 2002 05:25:15 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2SDOSq09669
	for <linux-mips@oss.sgi.com>; Thu, 28 Mar 2002 05:24:28 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA12347;
	Thu, 28 Mar 2002 14:26:56 +0100 (MET)
Date: Thu, 28 Mar 2002 14:26:55 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Woodhouse <dwmw2@redhat.com>, Ralf Baechle <ralf@uni-koblenz.de>,
   Harald Koerfgen <hkoerfg@web.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4: DEC MS02-NV NVRAM module support
Message-ID: <Pine.GSO.3.96.1020328140909.11187D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 The patch adds support for the DEC MS02-type lithium battery backed-up
NVRAM board.  The board provides 1MB (architecturally up to 4MB) of fast
SRAM originally meant as a PrestoServe NFS accelerator for the MIPS-based
DECstations.

 The code works fine for me since its creation back in August.  It was not
tested by anyone else -- after announcing the code at the "linux-mips" 
list last year I've read from two volunteers but they did not come back
with results ever. 

 I believe it's suitable for inclusion in the official kernel.  The patch
applies both to 2.4.19-pre4 and to the current CVS tree at oss.sgi.com. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.18-20020327-ms02-nv-69
diff -up --recursive --new-file linux-mips-2.4.18-20020327.macro/Documentation/Configure.help linux-mips-2.4.18-20020327/Documentation/Configure.help
--- linux-mips-2.4.18-20020327.macro/Documentation/Configure.help	2002-02-27 05:27:43.000000000 +0000
+++ linux-mips-2.4.18-20020327/Documentation/Configure.help	2002-03-28 09:30:03.000000000 +0000
@@ -12495,6 +12495,18 @@ CONFIG_MTD_SLRAM
   you can still use it for storage or swap by using this driver to
   present it to the system as a Memory Technology Device.
 
+DEC MS02-NV NVRAM module support
+CONFIG_MTD_MS02NV
+  This is a MTD driver for the DEC's MS02-type battery backed-up NVRAM
+  module.  The module was originally meant as an NFS accelerator.  Say Y
+  here if you have a DECstation 5000/2x0 or a DECsystem 5900 equipped
+  with such a module.
+
+  If you want to compile this driver as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read Documentation/modules.txt.  The module will be
+  called ms02-nv.o.
+
 Debugging RAM test driver
 CONFIG_MTD_MTDRAM
   This enables a test MTD device driver which uses vmalloc() to
diff -up --recursive --new-file linux-mips-2.4.18-20020327.macro/drivers/mtd/devices/Config.in linux-mips-2.4.18-20020327/drivers/mtd/devices/Config.in
--- linux-mips-2.4.18-20020327.macro/drivers/mtd/devices/Config.in	2001-11-06 05:27:13.000000000 +0000
+++ linux-mips-2.4.18-20020327/drivers/mtd/devices/Config.in	2002-03-28 09:29:07.000000000 +0000
@@ -10,6 +10,7 @@ if [ "$CONFIG_MTD_PMC551" = "y" -o  "$CO
    bool '    PMC551 256M DRAM Bugfix' CONFIG_MTD_PMC551_BUGFIX
    bool '    PMC551 Debugging' CONFIG_MTD_PMC551_DEBUG
 fi
+dep_tristate '  DEC MS02-NV NVRAM module support' CONFIG_MTD_MS02NV $CONFIG_MTD $CONFIG_DECSTATION
 dep_tristate '  Uncached system RAM' CONFIG_MTD_SLRAM $CONFIG_MTD
 if [ "$CONFIG_SA1100_LART" = "y" ]; then
   dep_tristate '  28F160xx flash driver for LART' CONFIG_MTD_LART $CONFIG_MTD
diff -up --recursive --new-file linux-mips-2.4.18-20020327.macro/drivers/mtd/devices/Makefile linux-mips-2.4.18-20020327/drivers/mtd/devices/Makefile
--- linux-mips-2.4.18-20020327.macro/drivers/mtd/devices/Makefile	2001-11-06 05:27:13.000000000 +0000
+++ linux-mips-2.4.18-20020327/drivers/mtd/devices/Makefile	2002-03-28 09:29:07.000000000 +0000
@@ -18,6 +18,7 @@ obj-$(CONFIG_MTD_DOC2001)	+= doc2001.o
 obj-$(CONFIG_MTD_DOCPROBE)	+= docprobe.o docecc.o
 obj-$(CONFIG_MTD_SLRAM)		+= slram.o
 obj-$(CONFIG_MTD_PMC551)	+= pmc551.o
+obj-$(CONFIG_MTD_MS02NV)	+= ms02-nv.o
 obj-$(CONFIG_MTD_MTDRAM)	+= mtdram.o
 obj-$(CONFIG_MTD_LART)		+= lart.o
 obj-$(CONFIG_MTD_BLKMTD)	+= blkmtd.o
diff -up --recursive --new-file linux-mips-2.4.18-20020327.macro/drivers/mtd/devices/ms02-nv.c linux-mips-2.4.18-20020327/drivers/mtd/devices/ms02-nv.c
--- linux-mips-2.4.18-20020327.macro/drivers/mtd/devices/ms02-nv.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.18-20020327/drivers/mtd/devices/ms02-nv.c	2002-03-28 09:35:33.000000000 +0000
@@ -0,0 +1,323 @@
+/*
+ *      Copyright (c) 2001 Maciej W. Rozycki
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/dec/ioasic_addrs.h>
+#include <asm/dec/kn02.h>
+#include <asm/dec/kn03.h>
+#include <asm/io.h>
+#include <asm/paccess.h>
+
+#include "ms02-nv.h"
+
+
+static char version[] __initdata =
+        "ms02-nv.c: v.1.0.0  13 Aug 2001  Maciej W. Rozycki.\n";
+
+MODULE_AUTHOR("Maciej W. Rozycki <macro@ds2.pg.gda.pl>");
+MODULE_DESCRIPTION("DEC MS02-NV NVRAM module driver");
+MODULE_LICENSE("GPL");
+
+
+/*
+ * Addresses we probe for an MS02-NV at.  Modules may be located
+ * at any 8MB boundary within a 0MB up to 112MB range or at any 32MB
+ * boundary within a 0MB up to 448MB range.  We don't support a module
+ * at 0MB, though.
+ */
+static ulong ms02nv_addrs[] __initdata = {
+	0x07000000, 0x06800000, 0x06000000, 0x05800000, 0x05000000,
+	0x04800000, 0x04000000, 0x03800000, 0x03000000, 0x02800000,
+	0x02000000, 0x01800000, 0x01000000, 0x00800000
+};
+
+static const char ms02nv_name[] = "DEC MS02-NV NVRAM";
+static const char ms02nv_res_diag_ram[] = "Diagnostic RAM";
+static const char ms02nv_res_user_ram[] = "General-purpose RAM";
+static const char ms02nv_res_csr[] = "Control and status register";
+
+static struct mtd_info *root_ms02nv_mtd;
+
+
+static int ms02nv_read(struct mtd_info *mtd, loff_t from,
+			size_t len, size_t *retlen, u_char *buf)
+{
+	struct ms02nv_private *mp = (struct ms02nv_private *)mtd->priv;
+
+	if (from + len > mtd->size)
+		return -EINVAL;
+
+	memcpy(buf, mp->uaddr + from, len);
+	*retlen = len;
+
+	return 0;
+}
+
+static int ms02nv_write(struct mtd_info *mtd, loff_t to,
+			size_t len, size_t *retlen, const u_char *buf)
+{
+	struct ms02nv_private *mp = (struct ms02nv_private *)mtd->priv;
+
+	if (to + len > mtd->size)
+		return -EINVAL;
+
+	memcpy(mp->uaddr + to, buf, len);
+	*retlen = len;
+
+	return 0;
+}
+
+
+static inline uint ms02nv_probe_one(ulong addr)
+{
+	ms02nv_uint *ms02nv_diagp;
+	ms02nv_uint *ms02nv_magicp;
+	uint ms02nv_diag;
+	uint ms02nv_magic;
+	size_t size;
+
+	int err;
+
+	/*
+	 * The firmware writes MS02NV_ID at MS02NV_MAGIC and also
+	 * a diagnostic status at MS02NV_DIAG.
+	 */
+	ms02nv_diagp = (ms02nv_uint *)(KSEG1ADDR(addr + MS02NV_DIAG));
+	ms02nv_magicp = (ms02nv_uint *)(KSEG1ADDR(addr + MS02NV_MAGIC));
+	err = get_dbe(ms02nv_magic, ms02nv_magicp);
+	if (err)
+		return 0;
+	if (ms02nv_magic != MS02NV_ID)
+		return 0;
+
+	ms02nv_diag = *ms02nv_diagp;
+	size = (ms02nv_diag & MS02NV_DIAG_SIZE_MASK) << MS02NV_DIAG_SIZE_SHIFT;
+	if (size > MS02NV_CSR)
+		size = MS02NV_CSR;
+
+	return size;
+}
+
+static int __init ms02nv_init_one(ulong addr)
+{
+	struct mtd_info *mtd;
+	struct ms02nv_private *mp;
+	struct resource *mod_res;
+	struct resource *diag_res;
+	struct resource *user_res;
+	struct resource *csr_res;
+	ulong fixaddr;
+	size_t size, fixsize;
+
+	static int version_printed;
+
+	int ret = -ENODEV;
+
+	/* The module decodes 8MB of address space. */
+	mod_res = kmalloc(sizeof(*mod_res), GFP_KERNEL);
+	if (!mod_res)
+		return -ENOMEM;
+
+	memset(mod_res, 0, sizeof(*mod_res));
+	mod_res->name = ms02nv_name;
+	mod_res->start = addr;
+	mod_res->end = addr + MS02NV_SLOT_SIZE - 1;
+	mod_res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	if (request_resource(&iomem_resource, mod_res) < 0)
+		goto err_out_mod_res;
+
+	size = ms02nv_probe_one(addr);
+	if (!size)
+		goto err_out_mod_res_rel;
+
+	if (!version_printed) {
+		printk(KERN_INFO "%s", version);
+		version_printed = 1;
+	}
+
+	ret = -ENOMEM;
+	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
+	if (!mtd)
+		goto err_out_mod_res_rel;
+	memset(mtd, 0, sizeof(*mtd));
+	mp = kmalloc(sizeof(*mp), GFP_KERNEL);
+	if (!mp)
+		goto err_out_mtd;
+	memset(mp, 0, sizeof(*mp));
+
+	mtd->priv = mp;
+	mp->resource.module = mod_res;
+
+	/* Firmware's diagnostic NVRAM area. */
+	diag_res = kmalloc(sizeof(*diag_res), GFP_KERNEL);
+	if (!diag_res)
+		goto err_out_mp;
+
+	memset(diag_res, 0, sizeof(*diag_res));
+	diag_res->name = ms02nv_res_diag_ram;
+	diag_res->start = addr;
+	diag_res->end = addr + MS02NV_RAM - 1;
+	diag_res->flags = IORESOURCE_BUSY;
+	request_resource(mod_res, diag_res);
+
+	mp->resource.diag_ram = diag_res;
+
+	/* User-available general-purpose NVRAM area. */
+	user_res = kmalloc(sizeof(*user_res), GFP_KERNEL);
+	if (!user_res)
+		goto err_out_diag_res;
+
+	memset(user_res, 0, sizeof(*user_res));
+	user_res->name = ms02nv_res_user_ram;
+	user_res->start = addr + MS02NV_RAM;
+	user_res->end = addr + size - 1;
+	user_res->flags = IORESOURCE_BUSY;
+	request_resource(mod_res, user_res);
+
+	mp->resource.user_ram = user_res;
+
+	/* Control and status register. */
+	csr_res = kmalloc(sizeof(*csr_res), GFP_KERNEL);
+	if (!csr_res)
+		goto err_out_user_res;
+
+	memset(csr_res, 0, sizeof(*csr_res));
+	csr_res->name = ms02nv_res_csr;
+	csr_res->start = addr + MS02NV_CSR;
+	csr_res->end = addr + MS02NV_CSR + 3;
+	csr_res->flags = IORESOURCE_BUSY;
+	request_resource(mod_res, csr_res);
+
+	mp->resource.csr = csr_res;
+
+	mp->addr = phys_to_virt(addr);
+	mp->size = size;
+
+	/*
+	 * Hide the firmware's diagnostic area.  It may get destroyed
+	 * upon a reboot.  Take paging into account for mapping support.
+	 */
+	fixaddr = (addr + MS02NV_RAM + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1);
+	fixsize = (size - (fixaddr - addr)) & ~(PAGE_SIZE - 1);
+	mp->uaddr = phys_to_virt(fixaddr);
+
+	mtd->type = MTD_RAM;
+	mtd->flags = MTD_CAP_RAM | MTD_XIP;
+	mtd->size = fixsize;
+	mtd->name = (char *)ms02nv_name;
+	mtd->module = THIS_MODULE;
+	mtd->read = ms02nv_read;
+	mtd->write = ms02nv_write;
+
+	ret = -EIO;
+	if (add_mtd_device(mtd)) {
+		printk(KERN_ERR
+			"ms02-nv: Unable to register MTD device, aborting!\n");
+		goto err_out_csr_res;
+	}
+
+	printk(KERN_INFO "mtd%d: %s at 0x%08lx, size %uMB.\n",
+		mtd->index, ms02nv_name, addr, size >> 20);
+
+	mp->next = root_ms02nv_mtd;
+	root_ms02nv_mtd = mtd;
+
+	return 0;
+
+
+err_out_csr_res:
+	release_resource(csr_res);
+	kfree(csr_res);
+err_out_user_res:
+	release_resource(user_res);
+	kfree(user_res);
+err_out_diag_res:
+	release_resource(diag_res);
+	kfree(diag_res);
+err_out_mp:
+	kfree(mp);
+err_out_mtd:
+	kfree(mtd);
+err_out_mod_res_rel:
+	release_resource(mod_res);
+err_out_mod_res:
+	kfree(mod_res);
+	return ret;
+}
+
+static void __exit ms02nv_remove_one(void)
+{
+	struct mtd_info *mtd = root_ms02nv_mtd;
+	struct ms02nv_private *mp = (struct ms02nv_private *)mtd->priv;
+
+	root_ms02nv_mtd = mp->next;
+
+	del_mtd_device(mtd);
+
+	release_resource(mp->resource.csr);
+	kfree(mp->resource.csr);
+	release_resource(mp->resource.user_ram);
+	kfree(mp->resource.user_ram);
+	release_resource(mp->resource.diag_ram);
+	kfree(mp->resource.diag_ram);
+	release_resource(mp->resource.module);
+	kfree(mp->resource.module);
+	kfree(mp);
+	kfree(mtd);
+}
+
+
+static int __init ms02nv_init(void)
+{
+	volatile u32 *csr;
+	uint stride = 0;
+	int count = 0;
+	int i;
+
+	switch (mips_machtype) {
+	case MACH_DS5000_200:
+		csr = (volatile u32 *)KN02_CSR_ADDR;
+		if (*csr & KN02_CSR_BNK32M)
+			stride = 2;
+		break;
+	case MACH_DS5000_2X0:
+		csr = (volatile u32 *)KN03_MCR_BASE;
+		if (*csr & KN03_MCR_BNK32M)
+			stride = 2;
+		break;
+	default:
+		return -ENODEV;
+		break;
+	}
+
+	for (i = 0; i < (sizeof(ms02nv_addrs) / sizeof(*ms02nv_addrs)); i++)
+		if (!ms02nv_init_one(ms02nv_addrs[i] << stride))
+			count++;
+
+	return (count > 0) ? 0 : -ENODEV;
+}
+
+static void __exit ms02nv_cleanup(void)
+{
+	while (root_ms02nv_mtd)
+		ms02nv_remove_one();
+}
+
+
+module_init(ms02nv_init);
+module_exit(ms02nv_cleanup);
diff -up --recursive --new-file linux-mips-2.4.18-20020327.macro/drivers/mtd/devices/ms02-nv.h linux-mips-2.4.18-20020327/drivers/mtd/devices/ms02-nv.h
--- linux-mips-2.4.18-20020327.macro/drivers/mtd/devices/ms02-nv.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.18-20020327/drivers/mtd/devices/ms02-nv.h	2001-08-12 20:10:10.000000000 +0000
@@ -0,0 +1,43 @@
+/*
+ *      Copyright (c) 2001 Maciej W. Rozycki
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/ioport.h>
+#include <linux/mtd/mtd.h>
+
+/* MS02-NV iomem register offsets. */
+#define MS02NV_CSR		0x400000	/* control & status register */
+
+/* MS02-NV memory offsets. */
+#define MS02NV_DIAG		0x0003f8	/* diagnostic status */
+#define MS02NV_MAGIC		0x0003fc	/* MS02-NV magic ID */
+#define MS02NV_RAM		0x000400	/* general-purpose RAM start */
+
+/* MS02-NV diagnostic status constants. */
+#define MS02NV_DIAG_SIZE_MASK	0xf0		/* RAM size mask */
+#define MS02NV_DIAG_SIZE_SHIFT	0x10		/* RAM size shift (left) */
+
+/* MS02-NV general constants. */
+#define MS02NV_ID		0x03021966	/* MS02-NV magic ID value */
+#define MS02NV_SLOT_SIZE	0x800000	/* size of the address space
+						   decoded by the module */
+
+typedef volatile u32 ms02nv_uint;
+
+struct ms02nv_private {
+	struct mtd_info *next;
+	struct {
+		struct resource *module;
+		struct resource *diag_ram;
+		struct resource *user_ram;
+		struct resource *csr;
+	} resource;
+	u_char *addr;
+	size_t size;
+	u_char *uaddr;
+};
