Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2007 15:37:55 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:26175 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024444AbXHDOhc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 4 Aug 2007 15:37:32 +0100
Received: by mo.po.2iij.net (mo32) id l74EbUjD047551; Sat, 4 Aug 2007 23:37:30 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox303) id l74EbOVb021805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 4 Aug 2007 23:37:24 +0900
Date:	Sat, 4 Aug 2007 23:35:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][MIPS][2/2] remove unused marvell.h
Message-Id: <20070804233547.1c51bbf0.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070804233417.732d6d77.yoichi_yuasa@tripeaks.co.jp>
References: <20070804233417.732d6d77.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused marvell.h

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/marvell.h mips/include/asm-mips/marvell.h
--- mips-orig/include/asm-mips/marvell.h	2007-08-04 16:19:08.520727000 +0900
+++ mips/include/asm-mips/marvell.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,59 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004 by Ralf Baechle
- */
-#ifndef __ASM_MIPS_MARVELL_H
-#define __ASM_MIPS_MARVELL_H
-
-#include <linux/pci.h>
-
-#include <asm/byteorder.h>
-
-extern unsigned long marvell_base;
-
-/*
- * Because of an error/peculiarity in the Galileo chip, we need to swap the
- * bytes when running bigendian.
- */
-#define __MV_READ(ofs)							\
-	(*(volatile u32 *)(marvell_base+(ofs)))
-#define __MV_WRITE(ofs, data)						\
-	do { *(volatile u32 *)(marvell_base+(ofs)) = (data); } while (0)
-
-#define MV_READ(ofs)		le32_to_cpu(__MV_READ(ofs))
-#define MV_WRITE(ofs, data)	__MV_WRITE(ofs, cpu_to_le32(data))
-
-#define MV_READ_16(ofs)							\
-        le16_to_cpu(*(volatile u16 *)(marvell_base+(ofs)))
-#define MV_WRITE_16(ofs, data)  \
-        *(volatile u16 *)(marvell_base+(ofs)) = cpu_to_le16(data)
-
-#define MV_READ_8(ofs)							\
-	*(volatile u8 *)(marvell_base+(ofs))
-#define MV_WRITE_8(ofs, data)						\
-	*(volatile u8 *)(marvell_base+(ofs)) = data
-
-#define MV_SET_REG_BITS(ofs, bits)					\
-	(*((volatile u32 *)(marvell_base + (ofs)))) |= ((u32)cpu_to_le32(bits))
-#define MV_RESET_REG_BITS(ofs, bits)					\
-	(*((volatile u32 *)(marvell_base + (ofs)))) &= ~((u32)cpu_to_le32(bits))
-
-extern struct pci_ops mv_pci_ops;
-
-struct mv_pci_controller {
-	struct pci_controller   pcic;
-
-	/*
-	 * GT-64240/MV-64340 specific, per host bus information
-	 */
-	unsigned long   config_addr;
-	unsigned long   config_vreg;
-};
-
-extern void ll_mv64340_irq(void);
-extern void mv64340_irq_init(unsigned int base);
-
-#endif	/* __ASM_MIPS_MARVELL_H */
