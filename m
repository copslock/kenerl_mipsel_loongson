Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2004 06:02:54 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:38107 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225200AbUBFGCw>;
	Fri, 6 Feb 2004 06:02:52 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id PAA08606;
	Fri, 6 Feb 2004 15:02:48 +0900 (JST)
Received: 4UMDO01 id i1662lj27350; Fri, 6 Feb 2004 15:02:47 +0900 (JST)
Received: 4UMRO01 id i1662ls07069; Fri, 6 Feb 2004 15:02:47 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Fri, 6 Feb 2004 15:02:47 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Removed no-used files for vr41xx
Message-Id: <20040206150247.0beda507.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I found some files which were not used.
This patch removes them.

Please apply this patch.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/ide-e55.c linux/arch/mips/vr41xx/casio-e55/ide-e55.c
--- linux-orig/arch/mips/vr41xx/casio-e55/ide-e55.c	2002-10-04 01:58:02.000000000 +0900
+++ linux/arch/mips/vr41xx/casio-e55/ide-e55.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,99 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations
- * for the CASIO CASSIOPEIA E-55/65.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Sun, 24 Feb 2002
- *  - Added CASIO CASSIOPEIA E-55/65 support.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int e55_ide_default_irq(ide_ioreg_t base)
-{
-	return 40;
-}
-
-static ide_ioreg_t e55_ide_default_io_base(int index)
-{
-	switch (index) {
-		case 0: return 0xc1f0;
-		case 1: return 0xc170;
-		case 2: return 0xc1e8;
-		case 3: return 0xc168;
-		case 4: return 0xc1e0;
-		case 5: return 0xc160;
-	}
-	return 0;
-}
-
-static void e55_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                    ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int e55_ide_request_irq(unsigned int irq,
-                               void (*handler)(int,void *, struct pt_regs *),
-                               unsigned long flags, const char *device,
-                               void *dev_id)
-{
-	return request_irq(irq, handler, flags, device, dev_id);
-}			
-
-static void e55_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int e55_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void e55_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                   const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void e55_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops e55_ide_ops = {
-	&e55_ide_default_irq,
-	&e55_ide_default_io_base,
-	&e55_ide_init_hwif_ports,
-	&e55_ide_request_irq,
-	&e55_ide_free_irq,
-	&e55_ide_check_region,
-	&e55_ide_request_region,
-	&e55_ide_release_region
-};
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/ide-workpad.c linux/arch/mips/vr41xx/ibm-workpad/ide-workpad.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/ide-workpad.c	2002-10-04 01:58:02.000000000 +0900
+++ linux/arch/mips/vr41xx/ibm-workpad/ide-workpad.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,98 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations for the IBM WorkPad z50.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Sun, 24 Feb 2002
- *  - Added IBM WorkPad z50 support.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int workpad_ide_default_irq(ide_ioreg_t base)
-{
-	return 49;
-}
-
-static ide_ioreg_t workpad_ide_default_io_base(int index)
-{
-	switch (index) {
-		case 0: return 0x1f0;
-		case 1: return 0x170;
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		case 4: return 0x1e0;
-		case 5: return 0x160;
-	}
-	return 0;
-}
-
-static void workpad_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                        ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int workpad_ide_request_irq(unsigned int irq,
-                                   void (*handler)(int,void *, struct pt_regs *),
-                                   unsigned long flags, const char *device,
-                                   void *dev_id)
-{
-	return request_irq(irq, handler, SA_SHIRQ, device, dev_id);
-}			
-
-static void workpad_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int workpad_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void workpad_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                       const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void workpad_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops workpad_ide_ops = {
-	&workpad_ide_default_irq,
-	&workpad_ide_default_io_base,
-	&workpad_ide_init_hwif_ports,
-	&workpad_ide_request_irq,
-	&workpad_ide_free_irq,
-	&workpad_ide_check_region,
-	&workpad_ide_request_region,
-	&workpad_ide_release_region
-};
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/ide-eagle.c linux/arch/mips/vr41xx/nec-eagle/ide-eagle.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/ide-eagle.c	2002-08-06 08:53:36.000000000 +0900
+++ linux/arch/mips/vr41xx/nec-eagle/ide-eagle.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,96 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations
- * for the NEC Eagle/Hawk board.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  Fri,  5 Apr 2002
- *  - Added support for NEC Hawk.
- *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  Fri,  1 Mar 2002
- *  - Added support for NEC Eagle.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int eagle_ide_default_irq(ide_ioreg_t base)
-{
-	return 0;
-}
-
-static ide_ioreg_t eagle_ide_default_io_base(int index)
-{
-	return 0;
-}
-
-static void eagle_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                      ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int eagle_ide_request_irq(unsigned int irq,
-                                 void (*handler)(int,void *, struct pt_regs *),
-                                 unsigned long flags, const char *device,
-                                 void *dev_id)
-{
-	return request_irq(irq, handler, SA_SHIRQ, device, dev_id);
-}
-
-static void eagle_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int eagle_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void eagle_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                     const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void eagle_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops eagle_ide_ops = {
-	&eagle_ide_default_irq,
-	&eagle_ide_default_io_base,
-	&eagle_ide_init_hwif_ports,
-	&eagle_ide_request_irq,
-	&eagle_ide_free_irq,
-	&eagle_ide_check_region,
-	&eagle_ide_request_region,
-	&eagle_ide_release_region
-};
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/ide-mpc30x.c linux/arch/mips/vr41xx/victor-mpc30x/ide-mpc30x.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/ide-mpc30x.c	2002-10-04 01:58:02.000000000 +0900
+++ linux/arch/mips/vr41xx/victor-mpc30x/ide-mpc30x.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,91 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations
- * for the ZAO Networks Capcella.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Fri, 23 Aug 2002
- *  - Added Victor MP-C303/304 support.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int mpc30x_ide_default_irq(ide_ioreg_t base)
-{
-	return 0;
-}
-
-static ide_ioreg_t mpc30x_ide_default_io_base(int index)
-{
-	return 0;
-}
-
-static void mpc30x_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                       ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int mpc30x_ide_request_irq(unsigned int irq,
-                                  void (*handler)(int,void *, struct pt_regs *),
-                                  unsigned long flags, const char *device,
-                                  void *dev_id)
-{
-	return request_irq(irq, handler, flags, device, dev_id);
-}
-
-static void mpc30x_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int mpc30x_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void mpc30x_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                      const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void mpc30x_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops mpc30x_ide_ops = {
-	&mpc30x_ide_default_irq,
-	&mpc30x_ide_default_io_base,
-	&mpc30x_ide_init_hwif_ports,
-	&mpc30x_ide_request_irq,
-	&mpc30x_ide_free_irq,
-	&mpc30x_ide_check_region,
-	&mpc30x_ide_request_region,
-	&mpc30x_ide_release_region
-};
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/ide-capcella.c linux/arch/mips/vr41xx/zao-capcella/ide-capcella.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/ide-capcella.c	2002-08-06 08:53:36.000000000 +0900
+++ linux/arch/mips/vr41xx/zao-capcella/ide-capcella.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,99 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations
- * for the ZAO Networks Capcella.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Sun, 24 Feb 2002
- *  - Added ZAO Networks Capcella support.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int capcella_ide_default_irq(ide_ioreg_t base)
-{
-	switch (base) {
-	case 0x8300: return 42;
-	}
-
-	return 0;
-}
-
-static ide_ioreg_t capcella_ide_default_io_base(int index)
-{
-	switch (index) {
-	case 0: return 0x8300;
-	}
-
-	return 0;
-}
-
-static void capcella_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                         ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int capcella_ide_request_irq(unsigned int irq,
-                                    void (*handler)(int,void *, struct pt_regs *),
-                                    unsigned long flags, const char *device,
-                                    void *dev_id)
-{
-	return request_irq(irq, handler, flags, device, dev_id);
-}
-
-static void capcella_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int capcella_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void capcella_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                        const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void capcella_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops capcella_ide_ops = {
-	&capcella_ide_default_irq,
-	&capcella_ide_default_io_base,
-	&capcella_ide_init_hwif_ports,
-	&capcella_ide_request_irq,
-	&capcella_ide_free_irq,
-	&capcella_ide_check_region,
-	&capcella_ide_request_region,
-	&capcella_ide_release_region
-};
