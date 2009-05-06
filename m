Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 01:39:15 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17251 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021601AbZEFAhe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 01:37:34 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a00db800005>; Tue, 05 May 2009 20:36:16 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:29 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:28 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n460ZQVG022775;
	Tue, 5 May 2009 17:35:26 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n460ZQM6022774;
	Tue, 5 May 2009 17:35:26 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 6/7] [Staging] Add octeon-ethernet driver files.
Date:	Tue,  5 May 2009 17:35:21 -0700
Message-Id: <1241570122-22728-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A00DA84.5040101@caviumnetworks.com>
References: <4A00DA84.5040101@caviumnetworks.com>
X-OriginalArrivalTime: 06 May 2009 00:35:28.0893 (UTC) FILETIME=[8E354AD0:01C9CDE2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The octeon-ethernet driver supports the sgmii, rgmii, spi, and xaui
ports present on the Cavium OCTEON family of SOCs.  These SOCs are
multi-core mips64 processors with existing support over in arch/mips.

The driver files can be categorized into three basic groups:

1) Register definitions, these are named cvmx-*-defs.h

2) Main driver code, these have names that don't start cvmx-.

3) Interface specific functions and other utility code, names starting
with cvmx-

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/staging/octeon/Kconfig                  |   12 +
 drivers/staging/octeon/Makefile                 |   30 +
 drivers/staging/octeon/cvmx-address.h           |  274 +++
 drivers/staging/octeon/cvmx-asxx-defs.h         |  475 +++++
 drivers/staging/octeon/cvmx-cmd-queue.c         |  306 +++
 drivers/staging/octeon/cvmx-cmd-queue.h         |  617 ++++++
 drivers/staging/octeon/cvmx-config.h            |  169 ++
 drivers/staging/octeon/cvmx-dbg-defs.h          |   72 +
 drivers/staging/octeon/cvmx-fau.h               |  597 ++++++
 drivers/staging/octeon/cvmx-fpa-defs.h          |  403 ++++
 drivers/staging/octeon/cvmx-fpa.c               |  183 ++
 drivers/staging/octeon/cvmx-fpa.h               |  299 +++
 drivers/staging/octeon/cvmx-gmxx-defs.h         | 2529 +++++++++++++++++++++++
 drivers/staging/octeon/cvmx-helper-board.c      |  706 +++++++
 drivers/staging/octeon/cvmx-helper-board.h      |  180 ++
 drivers/staging/octeon/cvmx-helper-fpa.c        |  243 +++
 drivers/staging/octeon/cvmx-helper-fpa.h        |   64 +
 drivers/staging/octeon/cvmx-helper-loop.c       |   85 +
 drivers/staging/octeon/cvmx-helper-loop.h       |   59 +
 drivers/staging/octeon/cvmx-helper-npi.c        |  113 +
 drivers/staging/octeon/cvmx-helper-npi.h        |   60 +
 drivers/staging/octeon/cvmx-helper-rgmii.c      |  525 +++++
 drivers/staging/octeon/cvmx-helper-rgmii.h      |  110 +
 drivers/staging/octeon/cvmx-helper-sgmii.c      |  550 +++++
 drivers/staging/octeon/cvmx-helper-sgmii.h      |  104 +
 drivers/staging/octeon/cvmx-helper-spi.c        |  195 ++
 drivers/staging/octeon/cvmx-helper-spi.h        |   84 +
 drivers/staging/octeon/cvmx-helper-util.c       |  433 ++++
 drivers/staging/octeon/cvmx-helper-util.h       |  215 ++
 drivers/staging/octeon/cvmx-helper-xaui.c       |  348 ++++
 drivers/staging/octeon/cvmx-helper-xaui.h       |  103 +
 drivers/staging/octeon/cvmx-helper.c            | 1058 ++++++++++
 drivers/staging/octeon/cvmx-helper.h            |  227 ++
 drivers/staging/octeon/cvmx-interrupt-decodes.c |  371 ++++
 drivers/staging/octeon/cvmx-interrupt-rsl.c     |  140 ++
 drivers/staging/octeon/cvmx-ipd.h               |  338 +++
 drivers/staging/octeon/cvmx-mdio.h              |  506 +++++
 drivers/staging/octeon/cvmx-packet.h            |   65 +
 drivers/staging/octeon/cvmx-pcsx-defs.h         |  370 ++++
 drivers/staging/octeon/cvmx-pcsxx-defs.h        |  316 +++
 drivers/staging/octeon/cvmx-pip-defs.h          | 1267 ++++++++++++
 drivers/staging/octeon/cvmx-pip.h               |  524 +++++
 drivers/staging/octeon/cvmx-pko-defs.h          | 1133 ++++++++++
 drivers/staging/octeon/cvmx-pko.c               |  506 +++++
 drivers/staging/octeon/cvmx-pko.h               |  610 ++++++
 drivers/staging/octeon/cvmx-pow.h               | 1982 ++++++++++++++++++
 drivers/staging/octeon/cvmx-scratch.h           |  139 ++
 drivers/staging/octeon/cvmx-smix-defs.h         |  178 ++
 drivers/staging/octeon/cvmx-spi.c               |  667 ++++++
 drivers/staging/octeon/cvmx-spi.h               |  269 +++
 drivers/staging/octeon/cvmx-spxx-defs.h         |  347 ++++
 drivers/staging/octeon/cvmx-srxx-defs.h         |  126 ++
 drivers/staging/octeon/cvmx-stxx-defs.h         |  292 +++
 drivers/staging/octeon/cvmx-wqe.h               |  397 ++++
 drivers/staging/octeon/ethernet-common.c        |  328 +++
 drivers/staging/octeon/ethernet-common.h        |   29 +
 drivers/staging/octeon/ethernet-defines.h       |  134 ++
 drivers/staging/octeon/ethernet-mdio.c          |  231 +++
 drivers/staging/octeon/ethernet-mdio.h          |   46 +
 drivers/staging/octeon/ethernet-mem.c           |  198 ++
 drivers/staging/octeon/ethernet-mem.h           |   29 +
 drivers/staging/octeon/ethernet-proc.c          |  256 +++
 drivers/staging/octeon/ethernet-proc.h          |   29 +
 drivers/staging/octeon/ethernet-rgmii.c         |  397 ++++
 drivers/staging/octeon/ethernet-rx.c            |  505 +++++
 drivers/staging/octeon/ethernet-rx.h            |   33 +
 drivers/staging/octeon/ethernet-sgmii.c         |  129 ++
 drivers/staging/octeon/ethernet-spi.c           |  323 +++
 drivers/staging/octeon/ethernet-tx.c            |  634 ++++++
 drivers/staging/octeon/ethernet-tx.h            |   32 +
 drivers/staging/octeon/ethernet-util.h          |   81 +
 drivers/staging/octeon/ethernet-xaui.c          |  127 ++
 drivers/staging/octeon/ethernet.c               |  507 +++++
 drivers/staging/octeon/octeon-ethernet.h        |  127 ++
 74 files changed, 26146 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/octeon/Kconfig
 create mode 100644 drivers/staging/octeon/Makefile
 create mode 100644 drivers/staging/octeon/cvmx-address.h
 create mode 100644 drivers/staging/octeon/cvmx-asxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-cmd-queue.c
 create mode 100644 drivers/staging/octeon/cvmx-cmd-queue.h
 create mode 100644 drivers/staging/octeon/cvmx-config.h
 create mode 100644 drivers/staging/octeon/cvmx-dbg-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-fau.h
 create mode 100644 drivers/staging/octeon/cvmx-fpa-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-fpa.c
 create mode 100644 drivers/staging/octeon/cvmx-fpa.h
 create mode 100644 drivers/staging/octeon/cvmx-gmxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-board.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-board.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-fpa.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-fpa.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-loop.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-loop.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-npi.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-npi.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-rgmii.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-rgmii.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-sgmii.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-sgmii.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-spi.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-spi.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-util.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-util.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-xaui.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-xaui.h
 create mode 100644 drivers/staging/octeon/cvmx-helper.c
 create mode 100644 drivers/staging/octeon/cvmx-helper.h
 create mode 100644 drivers/staging/octeon/cvmx-interrupt-decodes.c
 create mode 100644 drivers/staging/octeon/cvmx-interrupt-rsl.c
 create mode 100644 drivers/staging/octeon/cvmx-ipd.h
 create mode 100644 drivers/staging/octeon/cvmx-mdio.h
 create mode 100644 drivers/staging/octeon/cvmx-packet.h
 create mode 100644 drivers/staging/octeon/cvmx-pcsx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-pcsxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-pip-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-pip.h
 create mode 100644 drivers/staging/octeon/cvmx-pko-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-pko.c
 create mode 100644 drivers/staging/octeon/cvmx-pko.h
 create mode 100644 drivers/staging/octeon/cvmx-pow.h
 create mode 100644 drivers/staging/octeon/cvmx-scratch.h
 create mode 100644 drivers/staging/octeon/cvmx-smix-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-spi.c
 create mode 100644 drivers/staging/octeon/cvmx-spi.h
 create mode 100644 drivers/staging/octeon/cvmx-spxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-srxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-stxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-wqe.h
 create mode 100644 drivers/staging/octeon/ethernet-common.c
 create mode 100644 drivers/staging/octeon/ethernet-common.h
 create mode 100644 drivers/staging/octeon/ethernet-defines.h
 create mode 100644 drivers/staging/octeon/ethernet-mdio.c
 create mode 100644 drivers/staging/octeon/ethernet-mdio.h
 create mode 100644 drivers/staging/octeon/ethernet-mem.c
 create mode 100644 drivers/staging/octeon/ethernet-mem.h
 create mode 100644 drivers/staging/octeon/ethernet-proc.c
 create mode 100644 drivers/staging/octeon/ethernet-proc.h
 create mode 100644 drivers/staging/octeon/ethernet-rgmii.c
 create mode 100644 drivers/staging/octeon/ethernet-rx.c
 create mode 100644 drivers/staging/octeon/ethernet-rx.h
 create mode 100644 drivers/staging/octeon/ethernet-sgmii.c
 create mode 100644 drivers/staging/octeon/ethernet-spi.c
 create mode 100644 drivers/staging/octeon/ethernet-tx.c
 create mode 100644 drivers/staging/octeon/ethernet-tx.h
 create mode 100644 drivers/staging/octeon/ethernet-util.h
 create mode 100644 drivers/staging/octeon/ethernet-xaui.c
 create mode 100644 drivers/staging/octeon/ethernet.c
 create mode 100644 drivers/staging/octeon/octeon-ethernet.h

diff --git a/drivers/staging/octeon/Kconfig b/drivers/staging/octeon/Kconfig
new file mode 100644
index 0000000..536e238
--- /dev/null
+++ b/drivers/staging/octeon/Kconfig
@@ -0,0 +1,12 @@
+config OCTEON_ETHERNET
+	tristate "Cavium Networks Octeon Ethernet support"
+	depends on CPU_CAVIUM_OCTEON
+	select MII
+	help
+	  This driver supports the builtin ethernet ports on Cavium
+	  Networks' products in the Octeon family. This driver supports the
+	  CN3XXX and CN5XXX Octeon processors.
+
+	  To compile this driver as a module, choose M here.  The module
+	  will be called octeon-ethernet.
+
diff --git a/drivers/staging/octeon/Makefile b/drivers/staging/octeon/Makefile
new file mode 100644
index 0000000..3c839e3
--- /dev/null
+++ b/drivers/staging/octeon/Makefile
@@ -0,0 +1,30 @@
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2005-2009 Cavium Networks
+#
+
+#
+# Makefile for Cavium OCTEON on-board ethernet driver
+#
+
+obj-${CONFIG_OCTEON_ETHERNET} :=  octeon-ethernet.o
+
+octeon-ethernet-objs := ethernet.o
+octeon-ethernet-objs += ethernet-common.o
+octeon-ethernet-objs += ethernet-mdio.o
+octeon-ethernet-objs += ethernet-mem.o
+octeon-ethernet-objs += ethernet-proc.o
+octeon-ethernet-objs += ethernet-rgmii.o
+octeon-ethernet-objs += ethernet-rx.o
+octeon-ethernet-objs += ethernet-sgmii.o
+octeon-ethernet-objs += ethernet-spi.o
+octeon-ethernet-objs += ethernet-tx.o
+octeon-ethernet-objs += ethernet-xaui.o
+octeon-ethernet-objs += cvmx-pko.o cvmx-spi.o cvmx-cmd-queue.o \
+	cvmx-helper-board.o cvmx-helper.o cvmx-helper-xaui.o \
+	cvmx-helper-rgmii.o cvmx-helper-sgmii.o cvmx-helper-npi.o \
+	cvmx-helper-loop.o cvmx-helper-spi.o cvmx-helper-util.o \
+	cvmx-interrupt-decodes.o cvmx-interrupt-rsl.o
+
diff --git a/drivers/staging/octeon/cvmx-address.h b/drivers/staging/octeon/cvmx-address.h
new file mode 100644
index 0000000..3c74d82
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-address.h
@@ -0,0 +1,274 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2009 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * Typedefs and defines for working with Octeon physical addresses.
+ *
+ */
+#ifndef __CVMX_ADDRESS_H__
+#define __CVMX_ADDRESS_H__
+
+#if 0
+typedef enum {
+	CVMX_MIPS_SPACE_XKSEG = 3LL,
+	CVMX_MIPS_SPACE_XKPHYS = 2LL,
+	CVMX_MIPS_SPACE_XSSEG = 1LL,
+	CVMX_MIPS_SPACE_XUSEG = 0LL
+} cvmx_mips_space_t;
+#endif
+
+typedef enum {
+	CVMX_MIPS_XKSEG_SPACE_KSEG0 = 0LL,
+	CVMX_MIPS_XKSEG_SPACE_KSEG1 = 1LL,
+	CVMX_MIPS_XKSEG_SPACE_SSEG = 2LL,
+	CVMX_MIPS_XKSEG_SPACE_KSEG3 = 3LL
+} cvmx_mips_xkseg_space_t;
+
+/* decodes <14:13> of a kseg3 window address */
+typedef enum {
+	CVMX_ADD_WIN_SCR = 0L,
+	/* see cvmx_add_win_dma_dec_t for further decode */
+	CVMX_ADD_WIN_DMA = 1L,
+	CVMX_ADD_WIN_UNUSED = 2L,
+	CVMX_ADD_WIN_UNUSED2 = 3L
+} cvmx_add_win_dec_t;
+
+/* decode within DMA space */
+typedef enum {
+	/*
+	 * Add store data to the write buffer entry, allocating it if
+	 * necessary.
+	 */
+	CVMX_ADD_WIN_DMA_ADD = 0L,
+	/* send out the write buffer entry to DRAM */
+	CVMX_ADD_WIN_DMA_SENDMEM = 1L,
+	/* store data must be normal DRAM memory space address in this case */
+	/* send out the write buffer entry as an IOBDMA command */
+	CVMX_ADD_WIN_DMA_SENDDMA = 2L,
+	/* see CVMX_ADD_WIN_DMA_SEND_DEC for data contents */
+	/* send out the write buffer entry as an IO write */
+	CVMX_ADD_WIN_DMA_SENDIO = 3L,
+	/* store data must be normal IO space address in this case */
+	/* send out a single-tick command on the NCB bus */
+	CVMX_ADD_WIN_DMA_SENDSINGLE = 4L,
+	/* no write buffer data needed/used */
+} cvmx_add_win_dma_dec_t;
+
+/*
+ *   Physical Address Decode
+ *
+ * Octeon-I HW never interprets this X (<39:36> reserved
+ * for future expansion), software should set to 0.
+ *
+ *  - 0x0 XXX0 0000 0000 to      DRAM         Cached
+ *  - 0x0 XXX0 0FFF FFFF
+ *
+ *  - 0x0 XXX0 1000 0000 to      Boot Bus     Uncached  (Converted to 0x1 00X0 1000 0000
+ *  - 0x0 XXX0 1FFF FFFF         + EJTAG                           to 0x1 00X0 1FFF FFFF)
+ *
+ *  - 0x0 XXX0 2000 0000 to      DRAM         Cached
+ *  - 0x0 XXXF FFFF FFFF
+ *
+ *  - 0x1 00X0 0000 0000 to      Boot Bus     Uncached
+ *  - 0x1 00XF FFFF FFFF
+ *
+ *  - 0x1 01X0 0000 0000 to      Other NCB    Uncached
+ *  - 0x1 FFXF FFFF FFFF         devices
+ *
+ * Decode of all Octeon addresses
+ */
+typedef union {
+
+	uint64_t u64;
+	/* mapped or unmapped virtual address */
+	struct {
+		uint64_t R:2;
+		uint64_t offset:62;
+	} sva;
+
+	/* mapped USEG virtual addresses (typically) */
+	struct {
+		uint64_t zeroes:33;
+		uint64_t offset:31;
+	} suseg;
+
+	/* mapped or unmapped virtual address */
+	struct {
+		uint64_t ones:33;
+		uint64_t sp:2;
+		uint64_t offset:29;
+	} sxkseg;
+
+	/*
+	 * physical address accessed through xkphys unmapped virtual
+	 * address.
+	 */
+	struct {
+		uint64_t R:2;	/* CVMX_MIPS_SPACE_XKPHYS in this case */
+		uint64_t cca:3;	/* ignored by octeon */
+		uint64_t mbz:10;
+		uint64_t pa:49;	/* physical address */
+	} sxkphys;
+
+	/* physical address */
+	struct {
+		uint64_t mbz:15;
+		/* if set, the address is uncached and resides on MCB bus */
+		uint64_t is_io:1;
+		/*
+		 * the hardware ignores this field when is_io==0, else
+		 * device ID.
+		 */
+		uint64_t did:8;
+		/* the hardware ignores <39:36> in Octeon I */
+		uint64_t unaddr:4;
+		uint64_t offset:36;
+	} sphys;
+
+	/* physical mem address */
+	struct {
+		/* techically, <47:40> are dont-cares */
+		uint64_t zeroes:24;
+		/* the hardware ignores <39:36> in Octeon I */
+		uint64_t unaddr:4;
+		uint64_t offset:36;
+	} smem;
+
+	/* physical IO address */
+	struct {
+		uint64_t mem_region:2;
+		uint64_t mbz:13;
+		/* 1 in this case */
+		uint64_t is_io:1;
+		/*
+		 * The hardware ignores this field when is_io==0, else
+		 * device ID.
+		 */
+		uint64_t did:8;
+		/* the hardware ignores <39:36> in Octeon I */
+		uint64_t unaddr:4;
+		uint64_t offset:36;
+	} sio;
+
+	/*
+	 * Scratchpad virtual address - accessed through a window at
+	 * the end of kseg3
+	 */
+	struct {
+		uint64_t ones:49;
+		/* CVMX_ADD_WIN_SCR (0) in this case */
+		cvmx_add_win_dec_t csrdec:2;
+		uint64_t addr:13;
+	} sscr;
+
+	/* there should only be stores to IOBDMA space, no loads */
+	/*
+	 * IOBDMA virtual address - accessed through a window at the
+	 * end of kseg3
+	 */
+	struct {
+		uint64_t ones:49;
+		uint64_t csrdec:2;	/* CVMX_ADD_WIN_DMA (1) in this case */
+		uint64_t unused2:3;
+		uint64_t type:3;
+		uint64_t addr:7;
+	} sdma;
+
+	struct {
+		uint64_t didspace:24;
+		uint64_t unused:40;
+	} sfilldidspace;
+
+} cvmx_addr_t;
+
+/* These macros for used by 32 bit applications */
+
+#define CVMX_MIPS32_SPACE_KSEG0 1l
+#define CVMX_ADD_SEG32(segment, add) \
+	(((int32_t)segment << 31) | (int32_t)(add))
+
+/*
+ * Currently all IOs are performed using XKPHYS addressing. Linux uses
+ * the CvmMemCtl register to enable XKPHYS addressing to IO space from
+ * user mode.  Future OSes may need to change the upper bits of IO
+ * addresses. The following define controls the upper two bits for all
+ * IO addresses generated by the simple executive library.
+ */
+#define CVMX_IO_SEG CVMX_MIPS_SPACE_XKPHYS
+
+/* These macros simplify the process of creating common IO addresses */
+#define CVMX_ADD_SEG(segment, add) ((((uint64_t)segment) << 62) | (add))
+#ifndef CVMX_ADD_IO_SEG
+#define CVMX_ADD_IO_SEG(add) CVMX_ADD_SEG(CVMX_IO_SEG, (add))
+#endif
+#define CVMX_ADDR_DIDSPACE(did) (((CVMX_IO_SEG) << 22) | ((1ULL) << 8) | (did))
+#define CVMX_ADDR_DID(did) (CVMX_ADDR_DIDSPACE(did) << 40)
+#define CVMX_FULL_DID(did, subdid) (((did) << 3) | (subdid))
+
+  /* from include/ncb_rsl_id.v */
+#define CVMX_OCT_DID_MIS 0ULL	/* misc stuff */
+#define CVMX_OCT_DID_GMX0 1ULL
+#define CVMX_OCT_DID_GMX1 2ULL
+#define CVMX_OCT_DID_PCI 3ULL
+#define CVMX_OCT_DID_KEY 4ULL
+#define CVMX_OCT_DID_FPA 5ULL
+#define CVMX_OCT_DID_DFA 6ULL
+#define CVMX_OCT_DID_ZIP 7ULL
+#define CVMX_OCT_DID_RNG 8ULL
+#define CVMX_OCT_DID_IPD 9ULL
+#define CVMX_OCT_DID_PKT 10ULL
+#define CVMX_OCT_DID_TIM 11ULL
+#define CVMX_OCT_DID_TAG 12ULL
+  /* the rest are not on the IO bus */
+#define CVMX_OCT_DID_L2C 16ULL
+#define CVMX_OCT_DID_LMC 17ULL
+#define CVMX_OCT_DID_SPX0 18ULL
+#define CVMX_OCT_DID_SPX1 19ULL
+#define CVMX_OCT_DID_PIP 20ULL
+#define CVMX_OCT_DID_ASX0 22ULL
+#define CVMX_OCT_DID_ASX1 23ULL
+#define CVMX_OCT_DID_IOB 30ULL
+
+#define CVMX_OCT_DID_PKT_SEND       CVMX_FULL_DID(CVMX_OCT_DID_PKT, 2ULL)
+#define CVMX_OCT_DID_TAG_SWTAG      CVMX_FULL_DID(CVMX_OCT_DID_TAG, 0ULL)
+#define CVMX_OCT_DID_TAG_TAG1       CVMX_FULL_DID(CVMX_OCT_DID_TAG, 1ULL)
+#define CVMX_OCT_DID_TAG_TAG2       CVMX_FULL_DID(CVMX_OCT_DID_TAG, 2ULL)
+#define CVMX_OCT_DID_TAG_TAG3       CVMX_FULL_DID(CVMX_OCT_DID_TAG, 3ULL)
+#define CVMX_OCT_DID_TAG_NULL_RD    CVMX_FULL_DID(CVMX_OCT_DID_TAG, 4ULL)
+#define CVMX_OCT_DID_TAG_CSR        CVMX_FULL_DID(CVMX_OCT_DID_TAG, 7ULL)
+#define CVMX_OCT_DID_FAU_FAI        CVMX_FULL_DID(CVMX_OCT_DID_IOB, 0ULL)
+#define CVMX_OCT_DID_TIM_CSR        CVMX_FULL_DID(CVMX_OCT_DID_TIM, 0ULL)
+#define CVMX_OCT_DID_KEY_RW         CVMX_FULL_DID(CVMX_OCT_DID_KEY, 0ULL)
+#define CVMX_OCT_DID_PCI_6          CVMX_FULL_DID(CVMX_OCT_DID_PCI, 6ULL)
+#define CVMX_OCT_DID_MIS_BOO        CVMX_FULL_DID(CVMX_OCT_DID_MIS, 0ULL)
+#define CVMX_OCT_DID_PCI_RML        CVMX_FULL_DID(CVMX_OCT_DID_PCI, 0ULL)
+#define CVMX_OCT_DID_IPD_CSR        CVMX_FULL_DID(CVMX_OCT_DID_IPD, 7ULL)
+#define CVMX_OCT_DID_DFA_CSR        CVMX_FULL_DID(CVMX_OCT_DID_DFA, 7ULL)
+#define CVMX_OCT_DID_MIS_CSR        CVMX_FULL_DID(CVMX_OCT_DID_MIS, 7ULL)
+#define CVMX_OCT_DID_ZIP_CSR        CVMX_FULL_DID(CVMX_OCT_DID_ZIP, 0ULL)
+
+#endif /* __CVMX_ADDRESS_H__ */
diff --git a/drivers/staging/octeon/cvmx-asxx-defs.h b/drivers/staging/octeon/cvmx-asxx-defs.h
new file mode 100644
index 0000000..91415a8
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-asxx-defs.h
@@ -0,0 +1,475 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_ASXX_DEFS_H__
+#define __CVMX_ASXX_DEFS_H__
+
+#define CVMX_ASXX_GMII_RX_CLK_SET(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000180ull + (((block_id) & 0) * 0x8000000ull))
+#define CVMX_ASXX_GMII_RX_DAT_SET(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000188ull + (((block_id) & 0) * 0x8000000ull))
+#define CVMX_ASXX_INT_EN(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000018ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_INT_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000010ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_MII_RX_DAT_SET(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000190ull + (((block_id) & 0) * 0x8000000ull))
+#define CVMX_ASXX_PRT_LOOP(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000040ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_BYPASS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000248ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_BYPASS_SETTING(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000250ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_COMP(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000220ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_DATA_DRV(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000218ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_FCRAM_MODE(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000210ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_NCTL_STRONG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000230ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_NCTL_WEAK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000240ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_PCTL_STRONG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000228ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_PCTL_WEAK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000238ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RLD_SETTING(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000258ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RX_CLK_SETX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000020ull + (((offset) & 3) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RX_PRT_EN(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000000ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RX_WOL(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000100ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RX_WOL_MSK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000108ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RX_WOL_POWOK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000118ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_RX_WOL_SIG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000110ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_TX_CLK_SETX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000048ull + (((offset) & 3) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_TX_COMP_BYP(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000068ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_TX_HI_WATERX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000080ull + (((offset) & 3) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_ASXX_TX_PRT_EN(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000008ull + (((block_id) & 1) * 0x8000000ull))
+
+union cvmx_asxx_gmii_rx_clk_set {
+	uint64_t u64;
+	struct cvmx_asxx_gmii_rx_clk_set_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_gmii_rx_clk_set_s cn30xx;
+	struct cvmx_asxx_gmii_rx_clk_set_s cn31xx;
+	struct cvmx_asxx_gmii_rx_clk_set_s cn50xx;
+};
+
+union cvmx_asxx_gmii_rx_dat_set {
+	uint64_t u64;
+	struct cvmx_asxx_gmii_rx_dat_set_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_gmii_rx_dat_set_s cn30xx;
+	struct cvmx_asxx_gmii_rx_dat_set_s cn31xx;
+	struct cvmx_asxx_gmii_rx_dat_set_s cn50xx;
+};
+
+union cvmx_asxx_int_en {
+	uint64_t u64;
+	struct cvmx_asxx_int_en_s {
+		uint64_t reserved_12_63:52;
+		uint64_t txpsh:4;
+		uint64_t txpop:4;
+		uint64_t ovrflw:4;
+	} s;
+	struct cvmx_asxx_int_en_cn30xx {
+		uint64_t reserved_11_63:53;
+		uint64_t txpsh:3;
+		uint64_t reserved_7_7:1;
+		uint64_t txpop:3;
+		uint64_t reserved_3_3:1;
+		uint64_t ovrflw:3;
+	} cn30xx;
+	struct cvmx_asxx_int_en_cn30xx cn31xx;
+	struct cvmx_asxx_int_en_s cn38xx;
+	struct cvmx_asxx_int_en_s cn38xxp2;
+	struct cvmx_asxx_int_en_cn30xx cn50xx;
+	struct cvmx_asxx_int_en_s cn58xx;
+	struct cvmx_asxx_int_en_s cn58xxp1;
+};
+
+union cvmx_asxx_int_reg {
+	uint64_t u64;
+	struct cvmx_asxx_int_reg_s {
+		uint64_t reserved_12_63:52;
+		uint64_t txpsh:4;
+		uint64_t txpop:4;
+		uint64_t ovrflw:4;
+	} s;
+	struct cvmx_asxx_int_reg_cn30xx {
+		uint64_t reserved_11_63:53;
+		uint64_t txpsh:3;
+		uint64_t reserved_7_7:1;
+		uint64_t txpop:3;
+		uint64_t reserved_3_3:1;
+		uint64_t ovrflw:3;
+	} cn30xx;
+	struct cvmx_asxx_int_reg_cn30xx cn31xx;
+	struct cvmx_asxx_int_reg_s cn38xx;
+	struct cvmx_asxx_int_reg_s cn38xxp2;
+	struct cvmx_asxx_int_reg_cn30xx cn50xx;
+	struct cvmx_asxx_int_reg_s cn58xx;
+	struct cvmx_asxx_int_reg_s cn58xxp1;
+};
+
+union cvmx_asxx_mii_rx_dat_set {
+	uint64_t u64;
+	struct cvmx_asxx_mii_rx_dat_set_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_mii_rx_dat_set_s cn30xx;
+	struct cvmx_asxx_mii_rx_dat_set_s cn50xx;
+};
+
+union cvmx_asxx_prt_loop {
+	uint64_t u64;
+	struct cvmx_asxx_prt_loop_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ext_loop:4;
+		uint64_t int_loop:4;
+	} s;
+	struct cvmx_asxx_prt_loop_cn30xx {
+		uint64_t reserved_7_63:57;
+		uint64_t ext_loop:3;
+		uint64_t reserved_3_3:1;
+		uint64_t int_loop:3;
+	} cn30xx;
+	struct cvmx_asxx_prt_loop_cn30xx cn31xx;
+	struct cvmx_asxx_prt_loop_s cn38xx;
+	struct cvmx_asxx_prt_loop_s cn38xxp2;
+	struct cvmx_asxx_prt_loop_cn30xx cn50xx;
+	struct cvmx_asxx_prt_loop_s cn58xx;
+	struct cvmx_asxx_prt_loop_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_bypass {
+	uint64_t u64;
+	struct cvmx_asxx_rld_bypass_s {
+		uint64_t reserved_1_63:63;
+		uint64_t bypass:1;
+	} s;
+	struct cvmx_asxx_rld_bypass_s cn38xx;
+	struct cvmx_asxx_rld_bypass_s cn38xxp2;
+	struct cvmx_asxx_rld_bypass_s cn58xx;
+	struct cvmx_asxx_rld_bypass_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_bypass_setting {
+	uint64_t u64;
+	struct cvmx_asxx_rld_bypass_setting_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_rld_bypass_setting_s cn38xx;
+	struct cvmx_asxx_rld_bypass_setting_s cn38xxp2;
+	struct cvmx_asxx_rld_bypass_setting_s cn58xx;
+	struct cvmx_asxx_rld_bypass_setting_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_comp {
+	uint64_t u64;
+	struct cvmx_asxx_rld_comp_s {
+		uint64_t reserved_9_63:55;
+		uint64_t pctl:5;
+		uint64_t nctl:4;
+	} s;
+	struct cvmx_asxx_rld_comp_cn38xx {
+		uint64_t reserved_8_63:56;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} cn38xx;
+	struct cvmx_asxx_rld_comp_cn38xx cn38xxp2;
+	struct cvmx_asxx_rld_comp_s cn58xx;
+	struct cvmx_asxx_rld_comp_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_data_drv {
+	uint64_t u64;
+	struct cvmx_asxx_rld_data_drv_s {
+		uint64_t reserved_8_63:56;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} s;
+	struct cvmx_asxx_rld_data_drv_s cn38xx;
+	struct cvmx_asxx_rld_data_drv_s cn38xxp2;
+	struct cvmx_asxx_rld_data_drv_s cn58xx;
+	struct cvmx_asxx_rld_data_drv_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_fcram_mode {
+	uint64_t u64;
+	struct cvmx_asxx_rld_fcram_mode_s {
+		uint64_t reserved_1_63:63;
+		uint64_t mode:1;
+	} s;
+	struct cvmx_asxx_rld_fcram_mode_s cn38xx;
+	struct cvmx_asxx_rld_fcram_mode_s cn38xxp2;
+};
+
+union cvmx_asxx_rld_nctl_strong {
+	uint64_t u64;
+	struct cvmx_asxx_rld_nctl_strong_s {
+		uint64_t reserved_5_63:59;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_asxx_rld_nctl_strong_s cn38xx;
+	struct cvmx_asxx_rld_nctl_strong_s cn38xxp2;
+	struct cvmx_asxx_rld_nctl_strong_s cn58xx;
+	struct cvmx_asxx_rld_nctl_strong_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_nctl_weak {
+	uint64_t u64;
+	struct cvmx_asxx_rld_nctl_weak_s {
+		uint64_t reserved_5_63:59;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_asxx_rld_nctl_weak_s cn38xx;
+	struct cvmx_asxx_rld_nctl_weak_s cn38xxp2;
+	struct cvmx_asxx_rld_nctl_weak_s cn58xx;
+	struct cvmx_asxx_rld_nctl_weak_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_pctl_strong {
+	uint64_t u64;
+	struct cvmx_asxx_rld_pctl_strong_s {
+		uint64_t reserved_5_63:59;
+		uint64_t pctl:5;
+	} s;
+	struct cvmx_asxx_rld_pctl_strong_s cn38xx;
+	struct cvmx_asxx_rld_pctl_strong_s cn38xxp2;
+	struct cvmx_asxx_rld_pctl_strong_s cn58xx;
+	struct cvmx_asxx_rld_pctl_strong_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_pctl_weak {
+	uint64_t u64;
+	struct cvmx_asxx_rld_pctl_weak_s {
+		uint64_t reserved_5_63:59;
+		uint64_t pctl:5;
+	} s;
+	struct cvmx_asxx_rld_pctl_weak_s cn38xx;
+	struct cvmx_asxx_rld_pctl_weak_s cn38xxp2;
+	struct cvmx_asxx_rld_pctl_weak_s cn58xx;
+	struct cvmx_asxx_rld_pctl_weak_s cn58xxp1;
+};
+
+union cvmx_asxx_rld_setting {
+	uint64_t u64;
+	struct cvmx_asxx_rld_setting_s {
+		uint64_t reserved_13_63:51;
+		uint64_t dfaset:5;
+		uint64_t dfalag:1;
+		uint64_t dfalead:1;
+		uint64_t dfalock:1;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_rld_setting_cn38xx {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} cn38xx;
+	struct cvmx_asxx_rld_setting_cn38xx cn38xxp2;
+	struct cvmx_asxx_rld_setting_s cn58xx;
+	struct cvmx_asxx_rld_setting_s cn58xxp1;
+};
+
+union cvmx_asxx_rx_clk_setx {
+	uint64_t u64;
+	struct cvmx_asxx_rx_clk_setx_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_rx_clk_setx_s cn30xx;
+	struct cvmx_asxx_rx_clk_setx_s cn31xx;
+	struct cvmx_asxx_rx_clk_setx_s cn38xx;
+	struct cvmx_asxx_rx_clk_setx_s cn38xxp2;
+	struct cvmx_asxx_rx_clk_setx_s cn50xx;
+	struct cvmx_asxx_rx_clk_setx_s cn58xx;
+	struct cvmx_asxx_rx_clk_setx_s cn58xxp1;
+};
+
+union cvmx_asxx_rx_prt_en {
+	uint64_t u64;
+	struct cvmx_asxx_rx_prt_en_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prt_en:4;
+	} s;
+	struct cvmx_asxx_rx_prt_en_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t prt_en:3;
+	} cn30xx;
+	struct cvmx_asxx_rx_prt_en_cn30xx cn31xx;
+	struct cvmx_asxx_rx_prt_en_s cn38xx;
+	struct cvmx_asxx_rx_prt_en_s cn38xxp2;
+	struct cvmx_asxx_rx_prt_en_cn30xx cn50xx;
+	struct cvmx_asxx_rx_prt_en_s cn58xx;
+	struct cvmx_asxx_rx_prt_en_s cn58xxp1;
+};
+
+union cvmx_asxx_rx_wol {
+	uint64_t u64;
+	struct cvmx_asxx_rx_wol_s {
+		uint64_t reserved_2_63:62;
+		uint64_t status:1;
+		uint64_t enable:1;
+	} s;
+	struct cvmx_asxx_rx_wol_s cn38xx;
+	struct cvmx_asxx_rx_wol_s cn38xxp2;
+};
+
+union cvmx_asxx_rx_wol_msk {
+	uint64_t u64;
+	struct cvmx_asxx_rx_wol_msk_s {
+		uint64_t msk:64;
+	} s;
+	struct cvmx_asxx_rx_wol_msk_s cn38xx;
+	struct cvmx_asxx_rx_wol_msk_s cn38xxp2;
+};
+
+union cvmx_asxx_rx_wol_powok {
+	uint64_t u64;
+	struct cvmx_asxx_rx_wol_powok_s {
+		uint64_t reserved_1_63:63;
+		uint64_t powerok:1;
+	} s;
+	struct cvmx_asxx_rx_wol_powok_s cn38xx;
+	struct cvmx_asxx_rx_wol_powok_s cn38xxp2;
+};
+
+union cvmx_asxx_rx_wol_sig {
+	uint64_t u64;
+	struct cvmx_asxx_rx_wol_sig_s {
+		uint64_t reserved_32_63:32;
+		uint64_t sig:32;
+	} s;
+	struct cvmx_asxx_rx_wol_sig_s cn38xx;
+	struct cvmx_asxx_rx_wol_sig_s cn38xxp2;
+};
+
+union cvmx_asxx_tx_clk_setx {
+	uint64_t u64;
+	struct cvmx_asxx_tx_clk_setx_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_tx_clk_setx_s cn30xx;
+	struct cvmx_asxx_tx_clk_setx_s cn31xx;
+	struct cvmx_asxx_tx_clk_setx_s cn38xx;
+	struct cvmx_asxx_tx_clk_setx_s cn38xxp2;
+	struct cvmx_asxx_tx_clk_setx_s cn50xx;
+	struct cvmx_asxx_tx_clk_setx_s cn58xx;
+	struct cvmx_asxx_tx_clk_setx_s cn58xxp1;
+};
+
+union cvmx_asxx_tx_comp_byp {
+	uint64_t u64;
+	struct cvmx_asxx_tx_comp_byp_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_asxx_tx_comp_byp_cn30xx {
+		uint64_t reserved_9_63:55;
+		uint64_t bypass:1;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} cn30xx;
+	struct cvmx_asxx_tx_comp_byp_cn30xx cn31xx;
+	struct cvmx_asxx_tx_comp_byp_cn38xx {
+		uint64_t reserved_8_63:56;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} cn38xx;
+	struct cvmx_asxx_tx_comp_byp_cn38xx cn38xxp2;
+	struct cvmx_asxx_tx_comp_byp_cn50xx {
+		uint64_t reserved_17_63:47;
+		uint64_t bypass:1;
+		uint64_t reserved_13_15:3;
+		uint64_t pctl:5;
+		uint64_t reserved_5_7:3;
+		uint64_t nctl:5;
+	} cn50xx;
+	struct cvmx_asxx_tx_comp_byp_cn58xx {
+		uint64_t reserved_13_63:51;
+		uint64_t pctl:5;
+		uint64_t reserved_5_7:3;
+		uint64_t nctl:5;
+	} cn58xx;
+	struct cvmx_asxx_tx_comp_byp_cn58xx cn58xxp1;
+};
+
+union cvmx_asxx_tx_hi_waterx {
+	uint64_t u64;
+	struct cvmx_asxx_tx_hi_waterx_s {
+		uint64_t reserved_4_63:60;
+		uint64_t mark:4;
+	} s;
+	struct cvmx_asxx_tx_hi_waterx_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t mark:3;
+	} cn30xx;
+	struct cvmx_asxx_tx_hi_waterx_cn30xx cn31xx;
+	struct cvmx_asxx_tx_hi_waterx_s cn38xx;
+	struct cvmx_asxx_tx_hi_waterx_s cn38xxp2;
+	struct cvmx_asxx_tx_hi_waterx_cn30xx cn50xx;
+	struct cvmx_asxx_tx_hi_waterx_s cn58xx;
+	struct cvmx_asxx_tx_hi_waterx_s cn58xxp1;
+};
+
+union cvmx_asxx_tx_prt_en {
+	uint64_t u64;
+	struct cvmx_asxx_tx_prt_en_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prt_en:4;
+	} s;
+	struct cvmx_asxx_tx_prt_en_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t prt_en:3;
+	} cn30xx;
+	struct cvmx_asxx_tx_prt_en_cn30xx cn31xx;
+	struct cvmx_asxx_tx_prt_en_s cn38xx;
+	struct cvmx_asxx_tx_prt_en_s cn38xxp2;
+	struct cvmx_asxx_tx_prt_en_cn30xx cn50xx;
+	struct cvmx_asxx_tx_prt_en_s cn58xx;
+	struct cvmx_asxx_tx_prt_en_s cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-cmd-queue.c b/drivers/staging/octeon/cvmx-cmd-queue.c
new file mode 100644
index 0000000..976227b
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-cmd-queue.c
@@ -0,0 +1,306 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Support functions for managing command queues used for
+ * various hardware blocks.
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+#include "cvmx-fpa.h"
+#include "cvmx-cmd-queue.h"
+
+#include <asm/octeon/cvmx-npei-defs.h>
+#include <asm/octeon/cvmx-pexp-defs.h>
+#include "cvmx-pko-defs.h"
+
+/**
+ * This application uses this pointer to access the global queue
+ * state. It points to a bootmem named block.
+ */
+__cvmx_cmd_queue_all_state_t *__cvmx_cmd_queue_state_ptr;
+
+/**
+ * Initialize the Global queue state pointer.
+ *
+ * Returns CVMX_CMD_QUEUE_SUCCESS or a failure code
+ */
+static cvmx_cmd_queue_result_t __cvmx_cmd_queue_init_state_ptr(void)
+{
+	char *alloc_name = "cvmx_cmd_queues";
+#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
+	extern uint64_t octeon_reserve32_memory;
+#endif
+
+	if (likely(__cvmx_cmd_queue_state_ptr))
+		return CVMX_CMD_QUEUE_SUCCESS;
+
+#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
+	if (octeon_reserve32_memory)
+		__cvmx_cmd_queue_state_ptr =
+		    cvmx_bootmem_alloc_named_range(sizeof(*__cvmx_cmd_queue_state_ptr),
+						   octeon_reserve32_memory,
+						   octeon_reserve32_memory +
+						   (CONFIG_CAVIUM_RESERVE32 <<
+						    20) - 1, 128, alloc_name);
+	else
+#endif
+		__cvmx_cmd_queue_state_ptr =
+		    cvmx_bootmem_alloc_named(sizeof(*__cvmx_cmd_queue_state_ptr),
+					    128,
+					    alloc_name);
+	if (__cvmx_cmd_queue_state_ptr)
+		memset(__cvmx_cmd_queue_state_ptr, 0,
+		       sizeof(*__cvmx_cmd_queue_state_ptr));
+	else {
+		struct cvmx_bootmem_named_block_desc *block_desc =
+		    cvmx_bootmem_find_named_block(alloc_name);
+		if (block_desc)
+			__cvmx_cmd_queue_state_ptr =
+			    cvmx_phys_to_ptr(block_desc->base_addr);
+		else {
+			cvmx_dprintf
+			    ("ERROR: cvmx_cmd_queue_initialize: Unable to get named block %s.\n",
+			     alloc_name);
+			return CVMX_CMD_QUEUE_NO_MEMORY;
+		}
+	}
+	return CVMX_CMD_QUEUE_SUCCESS;
+}
+
+/**
+ * Initialize a command queue for use. The initial FPA buffer is
+ * allocated and the hardware unit is configured to point to the
+ * new command queue.
+ *
+ * @queue_id:  Hardware command queue to initialize.
+ * @max_depth: Maximum outstanding commands that can be queued.
+ * @fpa_pool:  FPA pool the command queues should come from.
+ * @pool_size: Size of each buffer in the FPA pool (bytes)
+ *
+ * Returns CVMX_CMD_QUEUE_SUCCESS or a failure code
+ */
+cvmx_cmd_queue_result_t cvmx_cmd_queue_initialize(cvmx_cmd_queue_id_t queue_id,
+						  int max_depth, int fpa_pool,
+						  int pool_size)
+{
+	__cvmx_cmd_queue_state_t *qstate;
+	cvmx_cmd_queue_result_t result = __cvmx_cmd_queue_init_state_ptr();
+	if (result != CVMX_CMD_QUEUE_SUCCESS)
+		return result;
+
+	qstate = __cvmx_cmd_queue_get_state(queue_id);
+	if (qstate == NULL)
+		return CVMX_CMD_QUEUE_INVALID_PARAM;
+
+	/*
+	 * We artificially limit max_depth to 1<<20 words. It is an
+	 * arbitrary limit.
+	 */
+	if (CVMX_CMD_QUEUE_ENABLE_MAX_DEPTH) {
+		if ((max_depth < 0) || (max_depth > 1 << 20))
+			return CVMX_CMD_QUEUE_INVALID_PARAM;
+	} else if (max_depth != 0)
+		return CVMX_CMD_QUEUE_INVALID_PARAM;
+
+	if ((fpa_pool < 0) || (fpa_pool > 7))
+		return CVMX_CMD_QUEUE_INVALID_PARAM;
+	if ((pool_size < 128) || (pool_size > 65536))
+		return CVMX_CMD_QUEUE_INVALID_PARAM;
+
+	/* See if someone else has already initialized the queue */
+	if (qstate->base_ptr_div128) {
+		if (max_depth != (int)qstate->max_depth) {
+			cvmx_dprintf("ERROR: cvmx_cmd_queue_initialize: "
+				"Queue already initalized with different "
+				"max_depth (%d).\n",
+			     (int)qstate->max_depth);
+			return CVMX_CMD_QUEUE_INVALID_PARAM;
+		}
+		if (fpa_pool != qstate->fpa_pool) {
+			cvmx_dprintf("ERROR: cvmx_cmd_queue_initialize: "
+				"Queue already initalized with different "
+				"FPA pool (%u).\n",
+			     qstate->fpa_pool);
+			return CVMX_CMD_QUEUE_INVALID_PARAM;
+		}
+		if ((pool_size >> 3) - 1 != qstate->pool_size_m1) {
+			cvmx_dprintf("ERROR: cvmx_cmd_queue_initialize: "
+				"Queue already initalized with different "
+				"FPA pool size (%u).\n",
+			     (qstate->pool_size_m1 + 1) << 3);
+			return CVMX_CMD_QUEUE_INVALID_PARAM;
+		}
+		CVMX_SYNCWS;
+		return CVMX_CMD_QUEUE_ALREADY_SETUP;
+	} else {
+		union cvmx_fpa_ctl_status status;
+		void *buffer;
+
+		status.u64 = cvmx_read_csr(CVMX_FPA_CTL_STATUS);
+		if (!status.s.enb) {
+			cvmx_dprintf("ERROR: cvmx_cmd_queue_initialize: "
+				     "FPA is not enabled.\n");
+			return CVMX_CMD_QUEUE_NO_MEMORY;
+		}
+		buffer = cvmx_fpa_alloc(fpa_pool);
+		if (buffer == NULL) {
+			cvmx_dprintf("ERROR: cvmx_cmd_queue_initialize: "
+				     "Unable to allocate initial buffer.\n");
+			return CVMX_CMD_QUEUE_NO_MEMORY;
+		}
+
+		memset(qstate, 0, sizeof(*qstate));
+		qstate->max_depth = max_depth;
+		qstate->fpa_pool = fpa_pool;
+		qstate->pool_size_m1 = (pool_size >> 3) - 1;
+		qstate->base_ptr_div128 = cvmx_ptr_to_phys(buffer) / 128;
+		/*
+		 * We zeroed the now serving field so we need to also
+		 * zero the ticket.
+		 */
+		__cvmx_cmd_queue_state_ptr->
+		    ticket[__cvmx_cmd_queue_get_index(queue_id)] = 0;
+		CVMX_SYNCWS;
+		return CVMX_CMD_QUEUE_SUCCESS;
+	}
+}
+
+/**
+ * Shutdown a queue a free it's command buffers to the FPA. The
+ * hardware connected to the queue must be stopped before this
+ * function is called.
+ *
+ * @queue_id: Queue to shutdown
+ *
+ * Returns CVMX_CMD_QUEUE_SUCCESS or a failure code
+ */
+cvmx_cmd_queue_result_t cvmx_cmd_queue_shutdown(cvmx_cmd_queue_id_t queue_id)
+{
+	__cvmx_cmd_queue_state_t *qptr = __cvmx_cmd_queue_get_state(queue_id);
+	if (qptr == NULL) {
+		cvmx_dprintf("ERROR: cvmx_cmd_queue_shutdown: Unable to "
+			     "get queue information.\n");
+		return CVMX_CMD_QUEUE_INVALID_PARAM;
+	}
+
+	if (cvmx_cmd_queue_length(queue_id) > 0) {
+		cvmx_dprintf("ERROR: cvmx_cmd_queue_shutdown: Queue still "
+			     "has data in it.\n");
+		return CVMX_CMD_QUEUE_FULL;
+	}
+
+	__cvmx_cmd_queue_lock(queue_id, qptr);
+	if (qptr->base_ptr_div128) {
+		cvmx_fpa_free(cvmx_phys_to_ptr
+			      ((uint64_t) qptr->base_ptr_div128 << 7),
+			      qptr->fpa_pool, 0);
+		qptr->base_ptr_div128 = 0;
+	}
+	__cvmx_cmd_queue_unlock(qptr);
+
+	return CVMX_CMD_QUEUE_SUCCESS;
+}
+
+/**
+ * Return the number of command words pending in the queue. This
+ * function may be relatively slow for some hardware units.
+ *
+ * @queue_id: Hardware command queue to query
+ *
+ * Returns Number of outstanding commands
+ */
+int cvmx_cmd_queue_length(cvmx_cmd_queue_id_t queue_id)
+{
+	if (CVMX_ENABLE_PARAMETER_CHECKING) {
+		if (__cvmx_cmd_queue_get_state(queue_id) == NULL)
+			return CVMX_CMD_QUEUE_INVALID_PARAM;
+	}
+
+	/*
+	 * The cast is here so gcc with check that all values in the
+	 * cvmx_cmd_queue_id_t enumeration are here.
+	 */
+	switch ((cvmx_cmd_queue_id_t) (queue_id & 0xff0000)) {
+	case CVMX_CMD_QUEUE_PKO_BASE:
+		/*
+		 * FIXME: Need atomic lock on
+		 * CVMX_PKO_REG_READ_IDX. Right now we are normally
+		 * called with the queue lock, so that is a SLIGHT
+		 * amount of protection.
+		 */
+		cvmx_write_csr(CVMX_PKO_REG_READ_IDX, queue_id & 0xffff);
+		if (OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+			union cvmx_pko_mem_debug9 debug9;
+			debug9.u64 = cvmx_read_csr(CVMX_PKO_MEM_DEBUG9);
+			return debug9.cn38xx.doorbell;
+		} else {
+			union cvmx_pko_mem_debug8 debug8;
+			debug8.u64 = cvmx_read_csr(CVMX_PKO_MEM_DEBUG8);
+			return debug8.cn58xx.doorbell;
+		}
+	case CVMX_CMD_QUEUE_ZIP:
+	case CVMX_CMD_QUEUE_DFA:
+	case CVMX_CMD_QUEUE_RAID:
+		/* FIXME: Implement other lengths */
+		return 0;
+	case CVMX_CMD_QUEUE_DMA_BASE:
+		{
+			union cvmx_npei_dmax_counts dmax_counts;
+			dmax_counts.u64 =
+			    cvmx_read_csr(CVMX_PEXP_NPEI_DMAX_COUNTS
+					  (queue_id & 0x7));
+			return dmax_counts.s.dbell;
+		}
+	case CVMX_CMD_QUEUE_END:
+		return CVMX_CMD_QUEUE_INVALID_PARAM;
+	}
+	return CVMX_CMD_QUEUE_INVALID_PARAM;
+}
+
+/**
+ * Return the command buffer to be written to. The purpose of this
+ * function is to allow CVMX routine access t othe low level buffer
+ * for initial hardware setup. User applications should not call this
+ * function directly.
+ *
+ * @queue_id: Command queue to query
+ *
+ * Returns Command buffer or NULL on failure
+ */
+void *cvmx_cmd_queue_buffer(cvmx_cmd_queue_id_t queue_id)
+{
+	__cvmx_cmd_queue_state_t *qptr = __cvmx_cmd_queue_get_state(queue_id);
+	if (qptr && qptr->base_ptr_div128)
+		return cvmx_phys_to_ptr((uint64_t) qptr->base_ptr_div128 << 7);
+	else
+		return NULL;
+}
diff --git a/drivers/staging/octeon/cvmx-cmd-queue.h b/drivers/staging/octeon/cvmx-cmd-queue.h
new file mode 100644
index 0000000..f0cb20f
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-cmd-queue.h
@@ -0,0 +1,617 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * Support functions for managing command queues used for
+ * various hardware blocks.
+ *
+ * The common command queue infrastructure abstracts out the
+ * software necessary for adding to Octeon's chained queue
+ * structures. These structures are used for commands to the
+ * PKO, ZIP, DFA, RAID, and DMA engine blocks. Although each
+ * hardware unit takes commands and CSRs of different types,
+ * they all use basic linked command buffers to store the
+ * pending request. In general, users of the CVMX API don't
+ * call cvmx-cmd-queue functions directly. Instead the hardware
+ * unit specific wrapper should be used. The wrappers perform
+ * unit specific validation and CSR writes to submit the
+ * commands.
+ *
+ * Even though most software will never directly interact with
+ * cvmx-cmd-queue, knowledge of its internal working can help
+ * in diagnosing performance problems and help with debugging.
+ *
+ * Command queue pointers are stored in a global named block
+ * called "cvmx_cmd_queues". Except for the PKO queues, each
+ * hardware queue is stored in its own cache line to reduce SMP
+ * contention on spin locks. The PKO queues are stored such that
+ * every 16th queue is next to each other in memory. This scheme
+ * allows for queues being in separate cache lines when there
+ * are low number of queues per port. With 16 queues per port,
+ * the first queue for each port is in the same cache area. The
+ * second queues for each port are in another area, etc. This
+ * allows software to implement very efficient lockless PKO with
+ * 16 queues per port using a minimum of cache lines per core.
+ * All queues for a given core will be isolated in the same
+ * cache area.
+ *
+ * In addition to the memory pointer layout, cvmx-cmd-queue
+ * provides an optimized fair ll/sc locking mechanism for the
+ * queues. The lock uses a "ticket / now serving" model to
+ * maintain fair order on contended locks. In addition, it uses
+ * predicted locking time to limit cache contention. When a core
+ * know it must wait in line for a lock, it spins on the
+ * internal cycle counter to completely eliminate any causes of
+ * bus traffic.
+ *
+ */
+
+#ifndef __CVMX_CMD_QUEUE_H__
+#define __CVMX_CMD_QUEUE_H__
+
+#include <linux/prefetch.h>
+
+#include "cvmx-fpa.h"
+/**
+ * By default we disable the max depth support. Most programs
+ * don't use it and it slows down the command queue processing
+ * significantly.
+ */
+#ifndef CVMX_CMD_QUEUE_ENABLE_MAX_DEPTH
+#define CVMX_CMD_QUEUE_ENABLE_MAX_DEPTH 0
+#endif
+
+/**
+ * Enumeration representing all hardware blocks that use command
+ * queues. Each hardware block has up to 65536 sub identifiers for
+ * multiple command queues. Not all chips support all hardware
+ * units.
+ */
+typedef enum {
+	CVMX_CMD_QUEUE_PKO_BASE = 0x00000,
+
+#define CVMX_CMD_QUEUE_PKO(queue) \
+	((cvmx_cmd_queue_id_t)(CVMX_CMD_QUEUE_PKO_BASE + (0xffff&(queue))))
+
+	CVMX_CMD_QUEUE_ZIP = 0x10000,
+	CVMX_CMD_QUEUE_DFA = 0x20000,
+	CVMX_CMD_QUEUE_RAID = 0x30000,
+	CVMX_CMD_QUEUE_DMA_BASE = 0x40000,
+
+#define CVMX_CMD_QUEUE_DMA(queue) \
+	((cvmx_cmd_queue_id_t)(CVMX_CMD_QUEUE_DMA_BASE + (0xffff&(queue))))
+
+	CVMX_CMD_QUEUE_END = 0x50000,
+} cvmx_cmd_queue_id_t;
+
+/**
+ * Command write operations can fail if the comamnd queue needs
+ * a new buffer and the associated FPA pool is empty. It can also
+ * fail if the number of queued command words reaches the maximum
+ * set at initialization.
+ */
+typedef enum {
+	CVMX_CMD_QUEUE_SUCCESS = 0,
+	CVMX_CMD_QUEUE_NO_MEMORY = -1,
+	CVMX_CMD_QUEUE_FULL = -2,
+	CVMX_CMD_QUEUE_INVALID_PARAM = -3,
+	CVMX_CMD_QUEUE_ALREADY_SETUP = -4,
+} cvmx_cmd_queue_result_t;
+
+typedef struct {
+	/* You have lock when this is your ticket */
+	uint8_t now_serving;
+	uint64_t unused1:24;
+	/* Maximum outstanding command words */
+	uint32_t max_depth;
+	/* FPA pool buffers come from */
+	uint64_t fpa_pool:3;
+	/* Top of command buffer pointer shifted 7 */
+	uint64_t base_ptr_div128:29;
+	uint64_t unused2:6;
+	/* FPA buffer size in 64bit words minus 1 */
+	uint64_t pool_size_m1:13;
+	/* Number of comamnds already used in buffer */
+	uint64_t index:13;
+} __cvmx_cmd_queue_state_t;
+
+/**
+ * This structure contains the global state of all comamnd queues.
+ * It is stored in a bootmem named block and shared by all
+ * applications running on Octeon. Tickets are stored in a differnet
+ * cahce line that queue information to reduce the contention on the
+ * ll/sc used to get a ticket. If this is not the case, the update
+ * of queue state causes the ll/sc to fail quite often.
+ */
+typedef struct {
+	uint64_t ticket[(CVMX_CMD_QUEUE_END >> 16) * 256];
+	__cvmx_cmd_queue_state_t state[(CVMX_CMD_QUEUE_END >> 16) * 256];
+} __cvmx_cmd_queue_all_state_t;
+
+/**
+ * Initialize a command queue for use. The initial FPA buffer is
+ * allocated and the hardware unit is configured to point to the
+ * new command queue.
+ *
+ * @queue_id:  Hardware command queue to initialize.
+ * @max_depth: Maximum outstanding commands that can be queued.
+ * @fpa_pool:  FPA pool the command queues should come from.
+ * @pool_size: Size of each buffer in the FPA pool (bytes)
+ *
+ * Returns CVMX_CMD_QUEUE_SUCCESS or a failure code
+ */
+cvmx_cmd_queue_result_t cvmx_cmd_queue_initialize(cvmx_cmd_queue_id_t queue_id,
+						  int max_depth, int fpa_pool,
+						  int pool_size);
+
+/**
+ * Shutdown a queue a free it's command buffers to the FPA. The
+ * hardware connected to the queue must be stopped before this
+ * function is called.
+ *
+ * @queue_id: Queue to shutdown
+ *
+ * Returns CVMX_CMD_QUEUE_SUCCESS or a failure code
+ */
+cvmx_cmd_queue_result_t cvmx_cmd_queue_shutdown(cvmx_cmd_queue_id_t queue_id);
+
+/**
+ * Return the number of command words pending in the queue. This
+ * function may be relatively slow for some hardware units.
+ *
+ * @queue_id: Hardware command queue to query
+ *
+ * Returns Number of outstanding commands
+ */
+int cvmx_cmd_queue_length(cvmx_cmd_queue_id_t queue_id);
+
+/**
+ * Return the command buffer to be written to. The purpose of this
+ * function is to allow CVMX routine access t othe low level buffer
+ * for initial hardware setup. User applications should not call this
+ * function directly.
+ *
+ * @queue_id: Command queue to query
+ *
+ * Returns Command buffer or NULL on failure
+ */
+void *cvmx_cmd_queue_buffer(cvmx_cmd_queue_id_t queue_id);
+
+/**
+ * Get the index into the state arrays for the supplied queue id.
+ *
+ * @queue_id: Queue ID to get an index for
+ *
+ * Returns Index into the state arrays
+ */
+static inline int __cvmx_cmd_queue_get_index(cvmx_cmd_queue_id_t queue_id)
+{
+	/*
+	 * Warning: This code currently only works with devices that
+	 * have 256 queues or less. Devices with more than 16 queues
+	 * are layed out in memory to allow cores quick access to
+	 * every 16th queue. This reduces cache thrashing when you are
+	 * running 16 queues per port to support lockless operation.
+	 */
+	int unit = queue_id >> 16;
+	int q = (queue_id >> 4) & 0xf;
+	int core = queue_id & 0xf;
+	return unit * 256 + core * 16 + q;
+}
+
+/**
+ * Lock the supplied queue so nobody else is updating it at the same
+ * time as us.
+ *
+ * @queue_id: Queue ID to lock
+ * @qptr:     Pointer to the queue's global state
+ */
+static inline void __cvmx_cmd_queue_lock(cvmx_cmd_queue_id_t queue_id,
+					 __cvmx_cmd_queue_state_t *qptr)
+{
+	extern __cvmx_cmd_queue_all_state_t
+	    *__cvmx_cmd_queue_state_ptr;
+	int tmp;
+	int my_ticket;
+	prefetch(qptr);
+	asm volatile (
+		".set push\n"
+		".set noreorder\n"
+		"1:\n"
+		/* Atomic add one to ticket_ptr */
+		"ll     %[my_ticket], %[ticket_ptr]\n"
+		/* and store the original value */
+		"li     %[ticket], 1\n"
+		/* in my_ticket */
+		"baddu  %[ticket], %[my_ticket]\n"
+		"sc     %[ticket], %[ticket_ptr]\n"
+		"beqz   %[ticket], 1b\n"
+		" nop\n"
+		/* Load the current now_serving ticket */
+		"lbu    %[ticket], %[now_serving]\n"
+		"2:\n"
+		/* Jump out if now_serving == my_ticket */
+		"beq    %[ticket], %[my_ticket], 4f\n"
+		/* Find out how many tickets are in front of me */
+		" subu   %[ticket], %[my_ticket], %[ticket]\n"
+		/* Use tickets in front of me minus one to delay */
+		"subu  %[ticket], 1\n"
+		/* Delay will be ((tickets in front)-1)*32 loops */
+		"cins   %[ticket], %[ticket], 5, 7\n"
+		"3:\n"
+		/* Loop here until our ticket might be up */
+		"bnez   %[ticket], 3b\n"
+		" subu  %[ticket], 1\n"
+		/* Jump back up to check out ticket again */
+		"b      2b\n"
+		/* Load the current now_serving ticket */
+		" lbu   %[ticket], %[now_serving]\n"
+		"4:\n"
+		".set pop\n" :
+		[ticket_ptr] "=m"(__cvmx_cmd_queue_state_ptr->ticket[__cvmx_cmd_queue_get_index(queue_id)]),
+		[now_serving] "=m"(qptr->now_serving), [ticket] "=r"(tmp),
+		[my_ticket] "=r"(my_ticket)
+	    );
+}
+
+/**
+ * Unlock the queue, flushing all writes.
+ *
+ * @qptr:   Queue to unlock
+ */
+static inline void __cvmx_cmd_queue_unlock(__cvmx_cmd_queue_state_t *qptr)
+{
+	qptr->now_serving++;
+	CVMX_SYNCWS;
+}
+
+/**
+ * Get the queue state structure for the given queue id
+ *
+ * @queue_id: Queue id to get
+ *
+ * Returns Queue structure or NULL on failure
+ */
+static inline __cvmx_cmd_queue_state_t
+    *__cvmx_cmd_queue_get_state(cvmx_cmd_queue_id_t queue_id)
+{
+	extern __cvmx_cmd_queue_all_state_t
+	    *__cvmx_cmd_queue_state_ptr;
+	return &__cvmx_cmd_queue_state_ptr->
+	    state[__cvmx_cmd_queue_get_index(queue_id)];
+}
+
+/**
+ * Write an arbitrary number of command words to a command queue.
+ * This is a generic function; the fixed number of comamnd word
+ * functions yield higher performance.
+ *
+ * @queue_id:  Hardware command queue to write to
+ * @use_locking:
+ *                  Use internal locking to ensure exclusive access for queue
+ *                  updates. If you don't use this locking you must ensure
+ *                  exclusivity some other way. Locking is strongly recommended.
+ * @cmd_count: Number of command words to write
+ * @cmds:      Array of comamnds to write
+ *
+ * Returns CVMX_CMD_QUEUE_SUCCESS or a failure code
+ */
+static inline cvmx_cmd_queue_result_t cvmx_cmd_queue_write(cvmx_cmd_queue_id_t
+							   queue_id,
+							   int use_locking,
+							   int cmd_count,
+							   uint64_t *cmds)
+{
+	__cvmx_cmd_queue_state_t *qptr = __cvmx_cmd_queue_get_state(queue_id);
+
+	/* Make sure nobody else is updating the same queue */
+	if (likely(use_locking))
+		__cvmx_cmd_queue_lock(queue_id, qptr);
+
+	/*
+	 * If a max queue length was specified then make sure we don't
+	 * exceed it. If any part of the command would be below the
+	 * limit we allow it.
+	 */
+	if (CVMX_CMD_QUEUE_ENABLE_MAX_DEPTH && unlikely(qptr->max_depth)) {
+		if (unlikely
+		    (cvmx_cmd_queue_length(queue_id) > (int)qptr->max_depth)) {
+			if (likely(use_locking))
+				__cvmx_cmd_queue_unlock(qptr);
+			return CVMX_CMD_QUEUE_FULL;
+		}
+	}
+
+	/*
+	 * Normally there is plenty of room in the current buffer for
+	 * the command.
+	 */
+	if (likely(qptr->index + cmd_count < qptr->pool_size_m1)) {
+		uint64_t *ptr =
+		    (uint64_t *) cvmx_phys_to_ptr((uint64_t) qptr->
+						  base_ptr_div128 << 7);
+		ptr += qptr->index;
+		qptr->index += cmd_count;
+		while (cmd_count--)
+			*ptr++ = *cmds++;
+	} else {
+		uint64_t *ptr;
+		int count;
+		/*
+		 * We need a new comamnd buffer. Fail if there isn't
+		 * one available.
+		 */
+		uint64_t *new_buffer =
+		    (uint64_t *) cvmx_fpa_alloc(qptr->fpa_pool);
+		if (unlikely(new_buffer == NULL)) {
+			if (likely(use_locking))
+				__cvmx_cmd_queue_unlock(qptr);
+			return CVMX_CMD_QUEUE_NO_MEMORY;
+		}
+		ptr =
+		    (uint64_t *) cvmx_phys_to_ptr((uint64_t) qptr->
+						  base_ptr_div128 << 7);
+		/*
+		 * Figure out how many command words will fit in this
+		 * buffer. One location will be needed for the next
+		 * buffer pointer.
+		 */
+		count = qptr->pool_size_m1 - qptr->index;
+		ptr += qptr->index;
+		cmd_count -= count;
+		while (count--)
+			*ptr++ = *cmds++;
+		*ptr = cvmx_ptr_to_phys(new_buffer);
+		/*
+		 * The current buffer is full and has a link to the
+		 * next buffer. Time to write the rest of the commands
+		 * into the new buffer.
+		 */
+		qptr->base_ptr_div128 = *ptr >> 7;
+		qptr->index = cmd_count;
+		ptr = new_buffer;
+		while (cmd_count--)
+			*ptr++ = *cmds++;
+	}
+
+	/* All updates are complete. Release the lock and return */
+	if (likely(use_locking))
+		__cvmx_cmd_queue_unlock(qptr);
+	return CVMX_CMD_QUEUE_SUCCESS;
+}
+
+/**
+ * Simple function to write two command words to a command
+ * queue.
+ *
+ * @queue_id: Hardware command queue to write to
+ * @use_locking:
+ *                 Use internal locking to ensure exclusive access for queue
+ *                 updates. If you don't use this locking you must ensure
+ *                 exclusivity some other way. Locking is strongly recommended.
+ * @cmd1:     Command
+ * @cmd2:     Command
+ *
+ * Returns CVMX_CMD_QUEUE_SUCCESS or a failure code
+ */
+static inline cvmx_cmd_queue_result_t cvmx_cmd_queue_write2(cvmx_cmd_queue_id_t
+							    queue_id,
+							    int use_locking,
+							    uint64_t cmd1,
+							    uint64_t cmd2)
+{
+	__cvmx_cmd_queue_state_t *qptr = __cvmx_cmd_queue_get_state(queue_id);
+
+	/* Make sure nobody else is updating the same queue */
+	if (likely(use_locking))
+		__cvmx_cmd_queue_lock(queue_id, qptr);
+
+	/*
+	 * If a max queue length was specified then make sure we don't
+	 * exceed it. If any part of the command would be below the
+	 * limit we allow it.
+	 */
+	if (CVMX_CMD_QUEUE_ENABLE_MAX_DEPTH && unlikely(qptr->max_depth)) {
+		if (unlikely
+		    (cvmx_cmd_queue_length(queue_id) > (int)qptr->max_depth)) {
+			if (likely(use_locking))
+				__cvmx_cmd_queue_unlock(qptr);
+			return CVMX_CMD_QUEUE_FULL;
+		}
+	}
+
+	/*
+	 * Normally there is plenty of room in the current buffer for
+	 * the command.
+	 */
+	if (likely(qptr->index + 2 < qptr->pool_size_m1)) {
+		uint64_t *ptr =
+		    (uint64_t *) cvmx_phys_to_ptr((uint64_t) qptr->
+						  base_ptr_div128 << 7);
+		ptr += qptr->index;
+		qptr->index += 2;
+		ptr[0] = cmd1;
+		ptr[1] = cmd2;
+	} else {
+		uint64_t *ptr;
+		/*
+		 * Figure out how many command words will fit in this
+		 * buffer. One location will be needed for the next
+		 * buffer pointer.
+		 */
+		int count = qptr->pool_size_m1 - qptr->index;
+		/*
+		 * We need a new comamnd buffer. Fail if there isn't
+		 * one available.
+		 */
+		uint64_t *new_buffer =
+		    (uint64_t *) cvmx_fpa_alloc(qptr->fpa_pool);
+		if (unlikely(new_buffer == NULL)) {
+			if (likely(use_locking))
+				__cvmx_cmd_queue_unlock(qptr);
+			return CVMX_CMD_QUEUE_NO_MEMORY;
+		}
+		count--;
+		ptr =
+		    (uint64_t *) cvmx_phys_to_ptr((uint64_t) qptr->
+						  base_ptr_div128 << 7);
+		ptr += qptr->index;
+		*ptr++ = cmd1;
+		if (likely(count))
+			*ptr++ = cmd2;
+		*ptr = cvmx_ptr_to_phys(new_buffer);
+		/*
+		 * The current buffer is full and has a link to the
+		 * next buffer. Time to write the rest of the commands
+		 * into the new buffer.
+		 */
+		qptr->base_ptr_div128 = *ptr >> 7;
+		qptr->index = 0;
+		if (unlikely(count == 0)) {
+			qptr->index = 1;
+			new_buffer[0] = cmd2;
+		}
+	}
+
+	/* All updates are complete. Release the lock and return */
+	if (likely(use_locking))
+		__cvmx_cmd_queue_unlock(qptr);
+	return CVMX_CMD_QUEUE_SUCCESS;
+}
+
+/**
+ * Simple function to write three command words to a command
+ * queue.
+ *
+ * @queue_id: Hardware command queue to write to
+ * @use_locking:
+ *                 Use internal locking to ensure exclusive access for queue
+ *                 updates. If you don't use this locking you must ensure
+ *                 exclusivity some other way. Locking is strongly recommended.
+ * @cmd1:     Command
+ * @cmd2:     Command
+ * @cmd3:     Command
+ *
+ * Returns CVMX_CMD_QUEUE_SUCCESS or a failure code
+ */
+static inline cvmx_cmd_queue_result_t cvmx_cmd_queue_write3(cvmx_cmd_queue_id_t
+							    queue_id,
+							    int use_locking,
+							    uint64_t cmd1,
+							    uint64_t cmd2,
+							    uint64_t cmd3)
+{
+	__cvmx_cmd_queue_state_t *qptr = __cvmx_cmd_queue_get_state(queue_id);
+
+	/* Make sure nobody else is updating the same queue */
+	if (likely(use_locking))
+		__cvmx_cmd_queue_lock(queue_id, qptr);
+
+	/*
+	 * If a max queue length was specified then make sure we don't
+	 * exceed it. If any part of the command would be below the
+	 * limit we allow it.
+	 */
+	if (CVMX_CMD_QUEUE_ENABLE_MAX_DEPTH && unlikely(qptr->max_depth)) {
+		if (unlikely
+		    (cvmx_cmd_queue_length(queue_id) > (int)qptr->max_depth)) {
+			if (likely(use_locking))
+				__cvmx_cmd_queue_unlock(qptr);
+			return CVMX_CMD_QUEUE_FULL;
+		}
+	}
+
+	/*
+	 * Normally there is plenty of room in the current buffer for
+	 * the command.
+	 */
+	if (likely(qptr->index + 3 < qptr->pool_size_m1)) {
+		uint64_t *ptr =
+		    (uint64_t *) cvmx_phys_to_ptr((uint64_t) qptr->
+						  base_ptr_div128 << 7);
+		ptr += qptr->index;
+		qptr->index += 3;
+		ptr[0] = cmd1;
+		ptr[1] = cmd2;
+		ptr[2] = cmd3;
+	} else {
+		uint64_t *ptr;
+		/*
+		 * Figure out how many command words will fit in this
+		 * buffer. One location will be needed for the next
+		 * buffer pointer
+		 */
+		int count = qptr->pool_size_m1 - qptr->index;
+		/*
+		 * We need a new comamnd buffer. Fail if there isn't
+		 * one available
+		 */
+		uint64_t *new_buffer =
+		    (uint64_t *) cvmx_fpa_alloc(qptr->fpa_pool);
+		if (unlikely(new_buffer == NULL)) {
+			if (likely(use_locking))
+				__cvmx_cmd_queue_unlock(qptr);
+			return CVMX_CMD_QUEUE_NO_MEMORY;
+		}
+		count--;
+		ptr =
+		    (uint64_t *) cvmx_phys_to_ptr((uint64_t) qptr->
+						  base_ptr_div128 << 7);
+		ptr += qptr->index;
+		*ptr++ = cmd1;
+		if (count) {
+			*ptr++ = cmd2;
+			if (count > 1)
+				*ptr++ = cmd3;
+		}
+		*ptr = cvmx_ptr_to_phys(new_buffer);
+		/*
+		 * The current buffer is full and has a link to the
+		 * next buffer. Time to write the rest of the commands
+		 * into the new buffer.
+		 */
+		qptr->base_ptr_div128 = *ptr >> 7;
+		qptr->index = 0;
+		ptr = new_buffer;
+		if (count == 0) {
+			*ptr++ = cmd2;
+			qptr->index++;
+		}
+		if (count < 2) {
+			*ptr++ = cmd3;
+			qptr->index++;
+		}
+	}
+
+	/* All updates are complete. Release the lock and return */
+	if (likely(use_locking))
+		__cvmx_cmd_queue_unlock(qptr);
+	return CVMX_CMD_QUEUE_SUCCESS;
+}
+
+#endif /* __CVMX_CMD_QUEUE_H__ */
diff --git a/drivers/staging/octeon/cvmx-config.h b/drivers/staging/octeon/cvmx-config.h
new file mode 100644
index 0000000..078a520
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-config.h
@@ -0,0 +1,169 @@
+#ifndef __CVMX_CONFIG_H__
+#define __CVMX_CONFIG_H__
+
+/************************* Config Specific Defines ************************/
+#define CVMX_LLM_NUM_PORTS 1
+#define CVMX_NULL_POINTER_PROTECT 1
+#define CVMX_ENABLE_DEBUG_PRINTS 1
+/* PKO queues per port for interface 0 (ports 0-15) */
+#define CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 1
+/* PKO queues per port for interface 1 (ports 16-31) */
+#define CVMX_PKO_QUEUES_PER_PORT_INTERFACE1 1
+/* Limit on the number of PKO ports enabled for interface 0 */
+#define CVMX_PKO_MAX_PORTS_INTERFACE0 CVMX_HELPER_PKO_MAX_PORTS_INTERFACE0
+/* Limit on the number of PKO ports enabled for interface 1 */
+#define CVMX_PKO_MAX_PORTS_INTERFACE1 CVMX_HELPER_PKO_MAX_PORTS_INTERFACE1
+/* PKO queues per port for PCI (ports 32-35) */
+#define CVMX_PKO_QUEUES_PER_PORT_PCI 1
+/* PKO queues per port for Loop devices (ports 36-39) */
+#define CVMX_PKO_QUEUES_PER_PORT_LOOP 1
+
+/************************* FPA allocation *********************************/
+/* Pool sizes in bytes, must be multiple of a cache line */
+#define CVMX_FPA_POOL_0_SIZE (16 * CVMX_CACHE_LINE_SIZE)
+#define CVMX_FPA_POOL_1_SIZE (1 * CVMX_CACHE_LINE_SIZE)
+#define CVMX_FPA_POOL_2_SIZE (8 * CVMX_CACHE_LINE_SIZE)
+#define CVMX_FPA_POOL_3_SIZE (0 * CVMX_CACHE_LINE_SIZE)
+#define CVMX_FPA_POOL_4_SIZE (0 * CVMX_CACHE_LINE_SIZE)
+#define CVMX_FPA_POOL_5_SIZE (0 * CVMX_CACHE_LINE_SIZE)
+#define CVMX_FPA_POOL_6_SIZE (0 * CVMX_CACHE_LINE_SIZE)
+#define CVMX_FPA_POOL_7_SIZE (0 * CVMX_CACHE_LINE_SIZE)
+
+/* Pools in use */
+/* Packet buffers */
+#define CVMX_FPA_PACKET_POOL                (0)
+#define CVMX_FPA_PACKET_POOL_SIZE           CVMX_FPA_POOL_0_SIZE
+/* Work queue entrys */
+#define CVMX_FPA_WQE_POOL                   (1)
+#define CVMX_FPA_WQE_POOL_SIZE              CVMX_FPA_POOL_1_SIZE
+/* PKO queue command buffers */
+#define CVMX_FPA_OUTPUT_BUFFER_POOL         (2)
+#define CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE    CVMX_FPA_POOL_2_SIZE
+
+/*************************  FAU allocation ********************************/
+/* The fetch and add registers are allocated here.  They are arranged
+ * in order of descending size so that all alignment constraints are
+ * automatically met.  The enums are linked so that the following enum
+ * continues allocating where the previous one left off, so the
+ * numbering within each enum always starts with zero.  The macros
+ * take care of the address increment size, so the values entered
+ * always increase by 1.  FAU registers are accessed with byte
+ * addresses.
+ */
+
+#define CVMX_FAU_REG_64_ADDR(x) ((x << 3) + CVMX_FAU_REG_64_START)
+typedef enum {
+	CVMX_FAU_REG_64_START	= 0,
+	CVMX_FAU_REG_64_END	= CVMX_FAU_REG_64_ADDR(0),
+} cvmx_fau_reg_64_t;
+
+#define CVMX_FAU_REG_32_ADDR(x) ((x << 2) + CVMX_FAU_REG_32_START)
+typedef enum {
+	CVMX_FAU_REG_32_START	= CVMX_FAU_REG_64_END,
+	CVMX_FAU_REG_32_END	= CVMX_FAU_REG_32_ADDR(0),
+} cvmx_fau_reg_32_t;
+
+#define CVMX_FAU_REG_16_ADDR(x) ((x << 1) + CVMX_FAU_REG_16_START)
+typedef enum {
+	CVMX_FAU_REG_16_START	= CVMX_FAU_REG_32_END,
+	CVMX_FAU_REG_16_END	= CVMX_FAU_REG_16_ADDR(0),
+} cvmx_fau_reg_16_t;
+
+#define CVMX_FAU_REG_8_ADDR(x) ((x) + CVMX_FAU_REG_8_START)
+typedef enum {
+	CVMX_FAU_REG_8_START	= CVMX_FAU_REG_16_END,
+	CVMX_FAU_REG_8_END	= CVMX_FAU_REG_8_ADDR(0),
+} cvmx_fau_reg_8_t;
+
+/*
+ * The name CVMX_FAU_REG_AVAIL_BASE is provided to indicate the first
+ * available FAU address that is not allocated in cvmx-config.h. This
+ * is 64 bit aligned.
+ */
+#define CVMX_FAU_REG_AVAIL_BASE ((CVMX_FAU_REG_8_END + 0x7) & (~0x7ULL))
+#define CVMX_FAU_REG_END (2048)
+
+/********************** scratch memory allocation *************************/
+/* Scratchpad memory allocation.  Note that these are byte memory
+ * addresses.  Some uses of scratchpad (IOBDMA for example) require
+ * the use of 8-byte aligned addresses, so proper alignment needs to
+ * be taken into account.
+ */
+/* Generic scratch iobdma area */
+#define CVMX_SCR_SCRATCH               (0)
+/* First location available after cvmx-config.h allocated region. */
+#define CVMX_SCR_REG_AVAIL_BASE        (8)
+
+/*
+ * CVMX_HELPER_FIRST_MBUFF_SKIP is the number of bytes to reserve
+ * before the beginning of the packet. If necessary, override the
+ * default here.  See the IPD section of the hardware manual for MBUFF
+ * SKIP details.
+ */
+#define CVMX_HELPER_FIRST_MBUFF_SKIP 184
+
+/*
+ * CVMX_HELPER_NOT_FIRST_MBUFF_SKIP is the number of bytes to reserve
+ * in each chained packet element. If necessary, override the default
+ * here.
+ */
+#define CVMX_HELPER_NOT_FIRST_MBUFF_SKIP 0
+
+/*
+ * CVMX_HELPER_ENABLE_BACK_PRESSURE controls whether back pressure is
+ * enabled for all input ports. This controls if IPD sends
+ * backpressure to all ports if Octeon's FPA pools don't have enough
+ * packet or work queue entries. Even when this is off, it is still
+ * possible to get backpressure from individual hardware ports. When
+ * configuring backpressure, also check
+ * CVMX_HELPER_DISABLE_*_BACKPRESSURE below. If necessary, override
+ * the default here.
+ */
+#define CVMX_HELPER_ENABLE_BACK_PRESSURE 1
+
+/*
+ * CVMX_HELPER_ENABLE_IPD controls if the IPD is enabled in the helper
+ * function. Once it is enabled the hardware starts accepting
+ * packets. You might want to skip the IPD enable if configuration
+ * changes are need from the default helper setup. If necessary,
+ * override the default here.
+ */
+#define CVMX_HELPER_ENABLE_IPD 0
+
+/*
+ * CVMX_HELPER_INPUT_TAG_TYPE selects the type of tag that the IPD assigns
+ * to incoming packets.
+ */
+#define CVMX_HELPER_INPUT_TAG_TYPE CVMX_POW_TAG_TYPE_ORDERED
+
+#define CVMX_ENABLE_PARAMETER_CHECKING 0
+
+/*
+ * The following select which fields are used by the PIP to generate
+ * the tag on INPUT
+ * 0: don't include
+ * 1: include
+ */
+#define CVMX_HELPER_INPUT_TAG_IPV6_SRC_IP	0
+#define CVMX_HELPER_INPUT_TAG_IPV6_DST_IP   	0
+#define CVMX_HELPER_INPUT_TAG_IPV6_SRC_PORT 	0
+#define CVMX_HELPER_INPUT_TAG_IPV6_DST_PORT 	0
+#define CVMX_HELPER_INPUT_TAG_IPV6_NEXT_HEADER 	0
+#define CVMX_HELPER_INPUT_TAG_IPV4_SRC_IP	0
+#define CVMX_HELPER_INPUT_TAG_IPV4_DST_IP   	0
+#define CVMX_HELPER_INPUT_TAG_IPV4_SRC_PORT 	0
+#define CVMX_HELPER_INPUT_TAG_IPV4_DST_PORT 	0
+#define CVMX_HELPER_INPUT_TAG_IPV4_PROTOCOL	0
+#define CVMX_HELPER_INPUT_TAG_INPUT_PORT	1
+
+/* Select skip mode for input ports */
+#define CVMX_HELPER_INPUT_PORT_SKIP_MODE	CVMX_PIP_PORT_CFG_MODE_SKIPL2
+
+/*
+ * Force backpressure to be disabled.  This overrides all other
+ * backpressure configuration.
+ */
+#define CVMX_HELPER_DISABLE_RGMII_BACKPRESSURE 0
+
+#endif /* __CVMX_CONFIG_H__ */
+
diff --git a/drivers/staging/octeon/cvmx-dbg-defs.h b/drivers/staging/octeon/cvmx-dbg-defs.h
new file mode 100644
index 0000000..abbf42d
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-dbg-defs.h
@@ -0,0 +1,72 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_DBG_DEFS_H__
+#define __CVMX_DBG_DEFS_H__
+
+#define CVMX_DBG_DATA \
+	 CVMX_ADD_IO_SEG(0x00011F00000001E8ull)
+
+union cvmx_dbg_data {
+	uint64_t u64;
+	struct cvmx_dbg_data_s {
+		uint64_t reserved_23_63:41;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} s;
+	struct cvmx_dbg_data_cn30xx {
+		uint64_t reserved_31_63:33;
+		uint64_t pll_mul:3;
+		uint64_t reserved_23_27:5;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} cn30xx;
+	struct cvmx_dbg_data_cn30xx cn31xx;
+	struct cvmx_dbg_data_cn38xx {
+		uint64_t reserved_29_63:35;
+		uint64_t d_mul:4;
+		uint64_t dclk_mul2:1;
+		uint64_t cclk_div2:1;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} cn38xx;
+	struct cvmx_dbg_data_cn38xx cn38xxp2;
+	struct cvmx_dbg_data_cn30xx cn50xx;
+	struct cvmx_dbg_data_cn58xx {
+		uint64_t reserved_29_63:35;
+		uint64_t rem:6;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} cn58xx;
+	struct cvmx_dbg_data_cn58xx cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-fau.h b/drivers/staging/octeon/cvmx-fau.h
new file mode 100644
index 0000000..29bdce6
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-fau.h
@@ -0,0 +1,597 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Interface to the hardware Fetch and Add Unit.
+ */
+
+#ifndef __CVMX_FAU_H__
+#define __CVMX_FAU_H__
+
+/*
+ * Octeon Fetch and Add Unit (FAU)
+ */
+
+#define CVMX_FAU_LOAD_IO_ADDRESS    cvmx_build_io_address(0x1e, 0)
+#define CVMX_FAU_BITS_SCRADDR       63, 56
+#define CVMX_FAU_BITS_LEN           55, 48
+#define CVMX_FAU_BITS_INEVAL        35, 14
+#define CVMX_FAU_BITS_TAGWAIT       13, 13
+#define CVMX_FAU_BITS_NOADD         13, 13
+#define CVMX_FAU_BITS_SIZE          12, 11
+#define CVMX_FAU_BITS_REGISTER      10, 0
+
+typedef enum {
+	CVMX_FAU_OP_SIZE_8 = 0,
+	CVMX_FAU_OP_SIZE_16 = 1,
+	CVMX_FAU_OP_SIZE_32 = 2,
+	CVMX_FAU_OP_SIZE_64 = 3
+} cvmx_fau_op_size_t;
+
+/**
+ * Tagwait return definition. If a timeout occurs, the error
+ * bit will be set. Otherwise the value of the register before
+ * the update will be returned.
+ */
+typedef struct {
+	uint64_t error:1;
+	int64_t value:63;
+} cvmx_fau_tagwait64_t;
+
+/**
+ * Tagwait return definition. If a timeout occurs, the error
+ * bit will be set. Otherwise the value of the register before
+ * the update will be returned.
+ */
+typedef struct {
+	uint64_t error:1;
+	int32_t value:31;
+} cvmx_fau_tagwait32_t;
+
+/**
+ * Tagwait return definition. If a timeout occurs, the error
+ * bit will be set. Otherwise the value of the register before
+ * the update will be returned.
+ */
+typedef struct {
+	uint64_t error:1;
+	int16_t value:15;
+} cvmx_fau_tagwait16_t;
+
+/**
+ * Tagwait return definition. If a timeout occurs, the error
+ * bit will be set. Otherwise the value of the register before
+ * the update will be returned.
+ */
+typedef struct {
+	uint64_t error:1;
+	int8_t value:7;
+} cvmx_fau_tagwait8_t;
+
+/**
+ * Asynchronous tagwait return definition. If a timeout occurs,
+ * the error bit will be set. Otherwise the value of the
+ * register before the update will be returned.
+ */
+typedef union {
+	uint64_t u64;
+	struct {
+		uint64_t invalid:1;
+		uint64_t data:63;	/* unpredictable if invalid is set */
+	} s;
+} cvmx_fau_async_tagwait_result_t;
+
+/**
+ * Builds a store I/O address for writing to the FAU
+ *
+ * @noadd:  0 = Store value is atomically added to the current value
+ *               1 = Store value is atomically written over the current value
+ * @reg:    FAU atomic register to access. 0 <= reg < 2048.
+ *               - Step by 2 for 16 bit access.
+ *               - Step by 4 for 32 bit access.
+ *               - Step by 8 for 64 bit access.
+ * Returns Address to store for atomic update
+ */
+static inline uint64_t __cvmx_fau_store_address(uint64_t noadd, uint64_t reg)
+{
+	return CVMX_ADD_IO_SEG(CVMX_FAU_LOAD_IO_ADDRESS) |
+	       cvmx_build_bits(CVMX_FAU_BITS_NOADD, noadd) |
+	       cvmx_build_bits(CVMX_FAU_BITS_REGISTER, reg);
+}
+
+/**
+ * Builds a I/O address for accessing the FAU
+ *
+ * @tagwait: Should the atomic add wait for the current tag switch
+ *                operation to complete.
+ *                - 0 = Don't wait
+ *                - 1 = Wait for tag switch to complete
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 2 for 16 bit access.
+ *                - Step by 4 for 32 bit access.
+ *                - Step by 8 for 64 bit access.
+ * @value:   Signed value to add.
+ *                Note: When performing 32 and 64 bit access, only the low
+ *                22 bits are available.
+ * Returns Address to read from for atomic update
+ */
+static inline uint64_t __cvmx_fau_atomic_address(uint64_t tagwait, uint64_t reg,
+						 int64_t value)
+{
+	return CVMX_ADD_IO_SEG(CVMX_FAU_LOAD_IO_ADDRESS) |
+	       cvmx_build_bits(CVMX_FAU_BITS_INEVAL, value) |
+	       cvmx_build_bits(CVMX_FAU_BITS_TAGWAIT, tagwait) |
+	       cvmx_build_bits(CVMX_FAU_BITS_REGISTER, reg);
+}
+
+/**
+ * Perform an atomic 64 bit add
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 8 for 64 bit access.
+ * @value:   Signed value to add.
+ *                Note: Only the low 22 bits are available.
+ * Returns Value of the register before the update
+ */
+static inline int64_t cvmx_fau_fetch_and_add64(cvmx_fau_reg_64_t reg,
+					       int64_t value)
+{
+	return cvmx_read64_int64(__cvmx_fau_atomic_address(0, reg, value));
+}
+
+/**
+ * Perform an atomic 32 bit add
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 4 for 32 bit access.
+ * @value:   Signed value to add.
+ *                Note: Only the low 22 bits are available.
+ * Returns Value of the register before the update
+ */
+static inline int32_t cvmx_fau_fetch_and_add32(cvmx_fau_reg_32_t reg,
+					       int32_t value)
+{
+	return cvmx_read64_int32(__cvmx_fau_atomic_address(0, reg, value));
+}
+
+/**
+ * Perform an atomic 16 bit add
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 2 for 16 bit access.
+ * @value:   Signed value to add.
+ * Returns Value of the register before the update
+ */
+static inline int16_t cvmx_fau_fetch_and_add16(cvmx_fau_reg_16_t reg,
+					       int16_t value)
+{
+	return cvmx_read64_int16(__cvmx_fau_atomic_address(0, reg, value));
+}
+
+/**
+ * Perform an atomic 8 bit add
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ * @value:   Signed value to add.
+ * Returns Value of the register before the update
+ */
+static inline int8_t cvmx_fau_fetch_and_add8(cvmx_fau_reg_8_t reg, int8_t value)
+{
+	return cvmx_read64_int8(__cvmx_fau_atomic_address(0, reg, value));
+}
+
+/**
+ * Perform an atomic 64 bit add after the current tag switch
+ * completes
+ *
+ * @reg:    FAU atomic register to access. 0 <= reg < 2048.
+ *               - Step by 8 for 64 bit access.
+ * @value:  Signed value to add.
+ *               Note: Only the low 22 bits are available.
+ * Returns If a timeout occurs, the error bit will be set. Otherwise
+ *         the value of the register before the update will be
+ *         returned
+ */
+static inline cvmx_fau_tagwait64_t
+cvmx_fau_tagwait_fetch_and_add64(cvmx_fau_reg_64_t reg, int64_t value)
+{
+	union {
+		uint64_t i64;
+		cvmx_fau_tagwait64_t t;
+	} result;
+	result.i64 =
+	    cvmx_read64_int64(__cvmx_fau_atomic_address(1, reg, value));
+	return result.t;
+}
+
+/**
+ * Perform an atomic 32 bit add after the current tag switch
+ * completes
+ *
+ * @reg:    FAU atomic register to access. 0 <= reg < 2048.
+ *               - Step by 4 for 32 bit access.
+ * @value:  Signed value to add.
+ *               Note: Only the low 22 bits are available.
+ * Returns If a timeout occurs, the error bit will be set. Otherwise
+ *         the value of the register before the update will be
+ *         returned
+ */
+static inline cvmx_fau_tagwait32_t
+cvmx_fau_tagwait_fetch_and_add32(cvmx_fau_reg_32_t reg, int32_t value)
+{
+	union {
+		uint64_t i32;
+		cvmx_fau_tagwait32_t t;
+	} result;
+	result.i32 =
+	    cvmx_read64_int32(__cvmx_fau_atomic_address(1, reg, value));
+	return result.t;
+}
+
+/**
+ * Perform an atomic 16 bit add after the current tag switch
+ * completes
+ *
+ * @reg:    FAU atomic register to access. 0 <= reg < 2048.
+ *               - Step by 2 for 16 bit access.
+ * @value:  Signed value to add.
+ * Returns If a timeout occurs, the error bit will be set. Otherwise
+ *         the value of the register before the update will be
+ *         returned
+ */
+static inline cvmx_fau_tagwait16_t
+cvmx_fau_tagwait_fetch_and_add16(cvmx_fau_reg_16_t reg, int16_t value)
+{
+	union {
+		uint64_t i16;
+		cvmx_fau_tagwait16_t t;
+	} result;
+	result.i16 =
+	    cvmx_read64_int16(__cvmx_fau_atomic_address(1, reg, value));
+	return result.t;
+}
+
+/**
+ * Perform an atomic 8 bit add after the current tag switch
+ * completes
+ *
+ * @reg:    FAU atomic register to access. 0 <= reg < 2048.
+ * @value:  Signed value to add.
+ * Returns If a timeout occurs, the error bit will be set. Otherwise
+ *         the value of the register before the update will be
+ *         returned
+ */
+static inline cvmx_fau_tagwait8_t
+cvmx_fau_tagwait_fetch_and_add8(cvmx_fau_reg_8_t reg, int8_t value)
+{
+	union {
+		uint64_t i8;
+		cvmx_fau_tagwait8_t t;
+	} result;
+	result.i8 = cvmx_read64_int8(__cvmx_fau_atomic_address(1, reg, value));
+	return result.t;
+}
+
+/**
+ * Builds I/O data for async operations
+ *
+ * @scraddr: Scratch pad byte addres to write to.  Must be 8 byte aligned
+ * @value:   Signed value to add.
+ *                Note: When performing 32 and 64 bit access, only the low
+ *                22 bits are available.
+ * @tagwait: Should the atomic add wait for the current tag switch
+ *                operation to complete.
+ *                - 0 = Don't wait
+ *                - 1 = Wait for tag switch to complete
+ * @size:    The size of the operation:
+ *                - CVMX_FAU_OP_SIZE_8  (0) = 8 bits
+ *                - CVMX_FAU_OP_SIZE_16 (1) = 16 bits
+ *                - CVMX_FAU_OP_SIZE_32 (2) = 32 bits
+ *                - CVMX_FAU_OP_SIZE_64 (3) = 64 bits
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 2 for 16 bit access.
+ *                - Step by 4 for 32 bit access.
+ *                - Step by 8 for 64 bit access.
+ * Returns Data to write using cvmx_send_single
+ */
+static inline uint64_t __cvmx_fau_iobdma_data(uint64_t scraddr, int64_t value,
+					      uint64_t tagwait,
+					      cvmx_fau_op_size_t size,
+					      uint64_t reg)
+{
+	return CVMX_FAU_LOAD_IO_ADDRESS |
+	       cvmx_build_bits(CVMX_FAU_BITS_SCRADDR, scraddr >> 3) |
+	       cvmx_build_bits(CVMX_FAU_BITS_LEN, 1) |
+	       cvmx_build_bits(CVMX_FAU_BITS_INEVAL, value) |
+	       cvmx_build_bits(CVMX_FAU_BITS_TAGWAIT, tagwait) |
+	       cvmx_build_bits(CVMX_FAU_BITS_SIZE, size) |
+	       cvmx_build_bits(CVMX_FAU_BITS_REGISTER, reg);
+}
+
+/**
+ * Perform an async atomic 64 bit add. The old value is
+ * placed in the scratch memory at byte address scraddr.
+ *
+ * @scraddr: Scratch memory byte address to put response in.
+ *                Must be 8 byte aligned.
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 8 for 64 bit access.
+ * @value:   Signed value to add.
+ *                Note: Only the low 22 bits are available.
+ * Returns Placed in the scratch pad register
+ */
+static inline void cvmx_fau_async_fetch_and_add64(uint64_t scraddr,
+						  cvmx_fau_reg_64_t reg,
+						  int64_t value)
+{
+	cvmx_send_single(__cvmx_fau_iobdma_data
+			 (scraddr, value, 0, CVMX_FAU_OP_SIZE_64, reg));
+}
+
+/**
+ * Perform an async atomic 32 bit add. The old value is
+ * placed in the scratch memory at byte address scraddr.
+ *
+ * @scraddr: Scratch memory byte address to put response in.
+ *                Must be 8 byte aligned.
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 4 for 32 bit access.
+ * @value:   Signed value to add.
+ *                Note: Only the low 22 bits are available.
+ * Returns Placed in the scratch pad register
+ */
+static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
+						  cvmx_fau_reg_32_t reg,
+						  int32_t value)
+{
+	cvmx_send_single(__cvmx_fau_iobdma_data
+			 (scraddr, value, 0, CVMX_FAU_OP_SIZE_32, reg));
+}
+
+/**
+ * Perform an async atomic 16 bit add. The old value is
+ * placed in the scratch memory at byte address scraddr.
+ *
+ * @scraddr: Scratch memory byte address to put response in.
+ *                Must be 8 byte aligned.
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 2 for 16 bit access.
+ * @value:   Signed value to add.
+ * Returns Placed in the scratch pad register
+ */
+static inline void cvmx_fau_async_fetch_and_add16(uint64_t scraddr,
+						  cvmx_fau_reg_16_t reg,
+						  int16_t value)
+{
+	cvmx_send_single(__cvmx_fau_iobdma_data
+			 (scraddr, value, 0, CVMX_FAU_OP_SIZE_16, reg));
+}
+
+/**
+ * Perform an async atomic 8 bit add. The old value is
+ * placed in the scratch memory at byte address scraddr.
+ *
+ * @scraddr: Scratch memory byte address to put response in.
+ *                Must be 8 byte aligned.
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ * @value:   Signed value to add.
+ * Returns Placed in the scratch pad register
+ */
+static inline void cvmx_fau_async_fetch_and_add8(uint64_t scraddr,
+						 cvmx_fau_reg_8_t reg,
+						 int8_t value)
+{
+	cvmx_send_single(__cvmx_fau_iobdma_data
+			 (scraddr, value, 0, CVMX_FAU_OP_SIZE_8, reg));
+}
+
+/**
+ * Perform an async atomic 64 bit add after the current tag
+ * switch completes.
+ *
+ * @scraddr: Scratch memory byte address to put response in.  Must be
+ *           8 byte aligned.  If a timeout occurs, the error bit (63)
+ *           will be set. Otherwise the value of the register before
+ *           the update will be returned
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 8 for 64 bit access.
+ * @value:   Signed value to add.
+ *                Note: Only the low 22 bits are available.
+ * Returns Placed in the scratch pad register
+ */
+static inline void cvmx_fau_async_tagwait_fetch_and_add64(uint64_t scraddr,
+							  cvmx_fau_reg_64_t reg,
+							  int64_t value)
+{
+	cvmx_send_single(__cvmx_fau_iobdma_data
+			 (scraddr, value, 1, CVMX_FAU_OP_SIZE_64, reg));
+}
+
+/**
+ * Perform an async atomic 32 bit add after the current tag
+ * switch completes.
+ *
+ * @scraddr: Scratch memory byte address to put response in.  Must be
+ *           8 byte aligned.  If a timeout occurs, the error bit (63)
+ *           will be set. Otherwise the value of the register before
+ *           the update will be returned
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 4 for 32 bit access.
+ * @value:   Signed value to add.
+ *                Note: Only the low 22 bits are available.
+ * Returns Placed in the scratch pad register
+ */
+static inline void cvmx_fau_async_tagwait_fetch_and_add32(uint64_t scraddr,
+							  cvmx_fau_reg_32_t reg,
+							  int32_t value)
+{
+	cvmx_send_single(__cvmx_fau_iobdma_data
+			 (scraddr, value, 1, CVMX_FAU_OP_SIZE_32, reg));
+}
+
+/**
+ * Perform an async atomic 16 bit add after the current tag
+ * switch completes.
+ *
+ * @scraddr: Scratch memory byte address to put response in.  Must be
+ *           8 byte aligned.  If a timeout occurs, the error bit (63)
+ *           will be set. Otherwise the value of the register before
+ *           the update will be returned
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 2 for 16 bit access.
+ * @value:   Signed value to add.
+ *
+ * Returns Placed in the scratch pad register
+ */
+static inline void cvmx_fau_async_tagwait_fetch_and_add16(uint64_t scraddr,
+							  cvmx_fau_reg_16_t reg,
+							  int16_t value)
+{
+	cvmx_send_single(__cvmx_fau_iobdma_data
+			 (scraddr, value, 1, CVMX_FAU_OP_SIZE_16, reg));
+}
+
+/**
+ * Perform an async atomic 8 bit add after the current tag
+ * switch completes.
+ *
+ * @scraddr: Scratch memory byte address to put response in.  Must be
+ *           8 byte aligned.  If a timeout occurs, the error bit (63)
+ *           will be set. Otherwise the value of the register before
+ *           the update will be returned
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ * @value:   Signed value to add.
+ *
+ * Returns Placed in the scratch pad register
+ */
+static inline void cvmx_fau_async_tagwait_fetch_and_add8(uint64_t scraddr,
+							 cvmx_fau_reg_8_t reg,
+							 int8_t value)
+{
+	cvmx_send_single(__cvmx_fau_iobdma_data
+			 (scraddr, value, 1, CVMX_FAU_OP_SIZE_8, reg));
+}
+
+/**
+ * Perform an atomic 64 bit add
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 8 for 64 bit access.
+ * @value:   Signed value to add.
+ */
+static inline void cvmx_fau_atomic_add64(cvmx_fau_reg_64_t reg, int64_t value)
+{
+	cvmx_write64_int64(__cvmx_fau_store_address(0, reg), value);
+}
+
+/**
+ * Perform an atomic 32 bit add
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 4 for 32 bit access.
+ * @value:   Signed value to add.
+ */
+static inline void cvmx_fau_atomic_add32(cvmx_fau_reg_32_t reg, int32_t value)
+{
+	cvmx_write64_int32(__cvmx_fau_store_address(0, reg), value);
+}
+
+/**
+ * Perform an atomic 16 bit add
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 2 for 16 bit access.
+ * @value:   Signed value to add.
+ */
+static inline void cvmx_fau_atomic_add16(cvmx_fau_reg_16_t reg, int16_t value)
+{
+	cvmx_write64_int16(__cvmx_fau_store_address(0, reg), value);
+}
+
+/**
+ * Perform an atomic 8 bit add
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ * @value:   Signed value to add.
+ */
+static inline void cvmx_fau_atomic_add8(cvmx_fau_reg_8_t reg, int8_t value)
+{
+	cvmx_write64_int8(__cvmx_fau_store_address(0, reg), value);
+}
+
+/**
+ * Perform an atomic 64 bit write
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 8 for 64 bit access.
+ * @value:   Signed value to write.
+ */
+static inline void cvmx_fau_atomic_write64(cvmx_fau_reg_64_t reg, int64_t value)
+{
+	cvmx_write64_int64(__cvmx_fau_store_address(1, reg), value);
+}
+
+/**
+ * Perform an atomic 32 bit write
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 4 for 32 bit access.
+ * @value:   Signed value to write.
+ */
+static inline void cvmx_fau_atomic_write32(cvmx_fau_reg_32_t reg, int32_t value)
+{
+	cvmx_write64_int32(__cvmx_fau_store_address(1, reg), value);
+}
+
+/**
+ * Perform an atomic 16 bit write
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ *                - Step by 2 for 16 bit access.
+ * @value:   Signed value to write.
+ */
+static inline void cvmx_fau_atomic_write16(cvmx_fau_reg_16_t reg, int16_t value)
+{
+	cvmx_write64_int16(__cvmx_fau_store_address(1, reg), value);
+}
+
+/**
+ * Perform an atomic 8 bit write
+ *
+ * @reg:     FAU atomic register to access. 0 <= reg < 2048.
+ * @value:   Signed value to write.
+ */
+static inline void cvmx_fau_atomic_write8(cvmx_fau_reg_8_t reg, int8_t value)
+{
+	cvmx_write64_int8(__cvmx_fau_store_address(1, reg), value);
+}
+
+#endif /* __CVMX_FAU_H__ */
diff --git a/drivers/staging/octeon/cvmx-fpa-defs.h b/drivers/staging/octeon/cvmx-fpa-defs.h
new file mode 100644
index 0000000..bf5546b
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-fpa-defs.h
@@ -0,0 +1,403 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_FPA_DEFS_H__
+#define __CVMX_FPA_DEFS_H__
+
+#define CVMX_FPA_BIST_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011800280000E8ull)
+#define CVMX_FPA_CTL_STATUS \
+	 CVMX_ADD_IO_SEG(0x0001180028000050ull)
+#define CVMX_FPA_FPF0_MARKS \
+	 CVMX_ADD_IO_SEG(0x0001180028000000ull)
+#define CVMX_FPA_FPF0_SIZE \
+	 CVMX_ADD_IO_SEG(0x0001180028000058ull)
+#define CVMX_FPA_FPF1_MARKS \
+	 CVMX_ADD_IO_SEG(0x0001180028000008ull)
+#define CVMX_FPA_FPF2_MARKS \
+	 CVMX_ADD_IO_SEG(0x0001180028000010ull)
+#define CVMX_FPA_FPF3_MARKS \
+	 CVMX_ADD_IO_SEG(0x0001180028000018ull)
+#define CVMX_FPA_FPF4_MARKS \
+	 CVMX_ADD_IO_SEG(0x0001180028000020ull)
+#define CVMX_FPA_FPF5_MARKS \
+	 CVMX_ADD_IO_SEG(0x0001180028000028ull)
+#define CVMX_FPA_FPF6_MARKS \
+	 CVMX_ADD_IO_SEG(0x0001180028000030ull)
+#define CVMX_FPA_FPF7_MARKS \
+	 CVMX_ADD_IO_SEG(0x0001180028000038ull)
+#define CVMX_FPA_FPFX_MARKS(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180028000008ull + (((offset) & 7) * 8) - 8 * 1)
+#define CVMX_FPA_FPFX_SIZE(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180028000060ull + (((offset) & 7) * 8) - 8 * 1)
+#define CVMX_FPA_INT_ENB \
+	 CVMX_ADD_IO_SEG(0x0001180028000048ull)
+#define CVMX_FPA_INT_SUM \
+	 CVMX_ADD_IO_SEG(0x0001180028000040ull)
+#define CVMX_FPA_QUE0_PAGE_INDEX \
+	 CVMX_ADD_IO_SEG(0x00011800280000F0ull)
+#define CVMX_FPA_QUE1_PAGE_INDEX \
+	 CVMX_ADD_IO_SEG(0x00011800280000F8ull)
+#define CVMX_FPA_QUE2_PAGE_INDEX \
+	 CVMX_ADD_IO_SEG(0x0001180028000100ull)
+#define CVMX_FPA_QUE3_PAGE_INDEX \
+	 CVMX_ADD_IO_SEG(0x0001180028000108ull)
+#define CVMX_FPA_QUE4_PAGE_INDEX \
+	 CVMX_ADD_IO_SEG(0x0001180028000110ull)
+#define CVMX_FPA_QUE5_PAGE_INDEX \
+	 CVMX_ADD_IO_SEG(0x0001180028000118ull)
+#define CVMX_FPA_QUE6_PAGE_INDEX \
+	 CVMX_ADD_IO_SEG(0x0001180028000120ull)
+#define CVMX_FPA_QUE7_PAGE_INDEX \
+	 CVMX_ADD_IO_SEG(0x0001180028000128ull)
+#define CVMX_FPA_QUEX_AVAILABLE(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180028000098ull + (((offset) & 7) * 8))
+#define CVMX_FPA_QUEX_PAGE_INDEX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800280000F0ull + (((offset) & 7) * 8))
+#define CVMX_FPA_QUE_ACT \
+	 CVMX_ADD_IO_SEG(0x0001180028000138ull)
+#define CVMX_FPA_QUE_EXP \
+	 CVMX_ADD_IO_SEG(0x0001180028000130ull)
+#define CVMX_FPA_WART_CTL \
+	 CVMX_ADD_IO_SEG(0x00011800280000D8ull)
+#define CVMX_FPA_WART_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011800280000E0ull)
+
+union cvmx_fpa_bist_status {
+	uint64_t u64;
+	struct cvmx_fpa_bist_status_s {
+		uint64_t reserved_5_63:59;
+		uint64_t frd:1;
+		uint64_t fpf0:1;
+		uint64_t fpf1:1;
+		uint64_t ffr:1;
+		uint64_t fdr:1;
+	} s;
+	struct cvmx_fpa_bist_status_s cn30xx;
+	struct cvmx_fpa_bist_status_s cn31xx;
+	struct cvmx_fpa_bist_status_s cn38xx;
+	struct cvmx_fpa_bist_status_s cn38xxp2;
+	struct cvmx_fpa_bist_status_s cn50xx;
+	struct cvmx_fpa_bist_status_s cn52xx;
+	struct cvmx_fpa_bist_status_s cn52xxp1;
+	struct cvmx_fpa_bist_status_s cn56xx;
+	struct cvmx_fpa_bist_status_s cn56xxp1;
+	struct cvmx_fpa_bist_status_s cn58xx;
+	struct cvmx_fpa_bist_status_s cn58xxp1;
+};
+
+union cvmx_fpa_ctl_status {
+	uint64_t u64;
+	struct cvmx_fpa_ctl_status_s {
+		uint64_t reserved_18_63:46;
+		uint64_t reset:1;
+		uint64_t use_ldt:1;
+		uint64_t use_stt:1;
+		uint64_t enb:1;
+		uint64_t mem1_err:7;
+		uint64_t mem0_err:7;
+	} s;
+	struct cvmx_fpa_ctl_status_s cn30xx;
+	struct cvmx_fpa_ctl_status_s cn31xx;
+	struct cvmx_fpa_ctl_status_s cn38xx;
+	struct cvmx_fpa_ctl_status_s cn38xxp2;
+	struct cvmx_fpa_ctl_status_s cn50xx;
+	struct cvmx_fpa_ctl_status_s cn52xx;
+	struct cvmx_fpa_ctl_status_s cn52xxp1;
+	struct cvmx_fpa_ctl_status_s cn56xx;
+	struct cvmx_fpa_ctl_status_s cn56xxp1;
+	struct cvmx_fpa_ctl_status_s cn58xx;
+	struct cvmx_fpa_ctl_status_s cn58xxp1;
+};
+
+union cvmx_fpa_fpfx_marks {
+	uint64_t u64;
+	struct cvmx_fpa_fpfx_marks_s {
+		uint64_t reserved_22_63:42;
+		uint64_t fpf_wr:11;
+		uint64_t fpf_rd:11;
+	} s;
+	struct cvmx_fpa_fpfx_marks_s cn38xx;
+	struct cvmx_fpa_fpfx_marks_s cn38xxp2;
+	struct cvmx_fpa_fpfx_marks_s cn56xx;
+	struct cvmx_fpa_fpfx_marks_s cn56xxp1;
+	struct cvmx_fpa_fpfx_marks_s cn58xx;
+	struct cvmx_fpa_fpfx_marks_s cn58xxp1;
+};
+
+union cvmx_fpa_fpfx_size {
+	uint64_t u64;
+	struct cvmx_fpa_fpfx_size_s {
+		uint64_t reserved_11_63:53;
+		uint64_t fpf_siz:11;
+	} s;
+	struct cvmx_fpa_fpfx_size_s cn38xx;
+	struct cvmx_fpa_fpfx_size_s cn38xxp2;
+	struct cvmx_fpa_fpfx_size_s cn56xx;
+	struct cvmx_fpa_fpfx_size_s cn56xxp1;
+	struct cvmx_fpa_fpfx_size_s cn58xx;
+	struct cvmx_fpa_fpfx_size_s cn58xxp1;
+};
+
+union cvmx_fpa_fpf0_marks {
+	uint64_t u64;
+	struct cvmx_fpa_fpf0_marks_s {
+		uint64_t reserved_24_63:40;
+		uint64_t fpf_wr:12;
+		uint64_t fpf_rd:12;
+	} s;
+	struct cvmx_fpa_fpf0_marks_s cn38xx;
+	struct cvmx_fpa_fpf0_marks_s cn38xxp2;
+	struct cvmx_fpa_fpf0_marks_s cn56xx;
+	struct cvmx_fpa_fpf0_marks_s cn56xxp1;
+	struct cvmx_fpa_fpf0_marks_s cn58xx;
+	struct cvmx_fpa_fpf0_marks_s cn58xxp1;
+};
+
+union cvmx_fpa_fpf0_size {
+	uint64_t u64;
+	struct cvmx_fpa_fpf0_size_s {
+		uint64_t reserved_12_63:52;
+		uint64_t fpf_siz:12;
+	} s;
+	struct cvmx_fpa_fpf0_size_s cn38xx;
+	struct cvmx_fpa_fpf0_size_s cn38xxp2;
+	struct cvmx_fpa_fpf0_size_s cn56xx;
+	struct cvmx_fpa_fpf0_size_s cn56xxp1;
+	struct cvmx_fpa_fpf0_size_s cn58xx;
+	struct cvmx_fpa_fpf0_size_s cn58xxp1;
+};
+
+union cvmx_fpa_int_enb {
+	uint64_t u64;
+	struct cvmx_fpa_int_enb_s {
+		uint64_t reserved_28_63:36;
+		uint64_t q7_perr:1;
+		uint64_t q7_coff:1;
+		uint64_t q7_und:1;
+		uint64_t q6_perr:1;
+		uint64_t q6_coff:1;
+		uint64_t q6_und:1;
+		uint64_t q5_perr:1;
+		uint64_t q5_coff:1;
+		uint64_t q5_und:1;
+		uint64_t q4_perr:1;
+		uint64_t q4_coff:1;
+		uint64_t q4_und:1;
+		uint64_t q3_perr:1;
+		uint64_t q3_coff:1;
+		uint64_t q3_und:1;
+		uint64_t q2_perr:1;
+		uint64_t q2_coff:1;
+		uint64_t q2_und:1;
+		uint64_t q1_perr:1;
+		uint64_t q1_coff:1;
+		uint64_t q1_und:1;
+		uint64_t q0_perr:1;
+		uint64_t q0_coff:1;
+		uint64_t q0_und:1;
+		uint64_t fed1_dbe:1;
+		uint64_t fed1_sbe:1;
+		uint64_t fed0_dbe:1;
+		uint64_t fed0_sbe:1;
+	} s;
+	struct cvmx_fpa_int_enb_s cn30xx;
+	struct cvmx_fpa_int_enb_s cn31xx;
+	struct cvmx_fpa_int_enb_s cn38xx;
+	struct cvmx_fpa_int_enb_s cn38xxp2;
+	struct cvmx_fpa_int_enb_s cn50xx;
+	struct cvmx_fpa_int_enb_s cn52xx;
+	struct cvmx_fpa_int_enb_s cn52xxp1;
+	struct cvmx_fpa_int_enb_s cn56xx;
+	struct cvmx_fpa_int_enb_s cn56xxp1;
+	struct cvmx_fpa_int_enb_s cn58xx;
+	struct cvmx_fpa_int_enb_s cn58xxp1;
+};
+
+union cvmx_fpa_int_sum {
+	uint64_t u64;
+	struct cvmx_fpa_int_sum_s {
+		uint64_t reserved_28_63:36;
+		uint64_t q7_perr:1;
+		uint64_t q7_coff:1;
+		uint64_t q7_und:1;
+		uint64_t q6_perr:1;
+		uint64_t q6_coff:1;
+		uint64_t q6_und:1;
+		uint64_t q5_perr:1;
+		uint64_t q5_coff:1;
+		uint64_t q5_und:1;
+		uint64_t q4_perr:1;
+		uint64_t q4_coff:1;
+		uint64_t q4_und:1;
+		uint64_t q3_perr:1;
+		uint64_t q3_coff:1;
+		uint64_t q3_und:1;
+		uint64_t q2_perr:1;
+		uint64_t q2_coff:1;
+		uint64_t q2_und:1;
+		uint64_t q1_perr:1;
+		uint64_t q1_coff:1;
+		uint64_t q1_und:1;
+		uint64_t q0_perr:1;
+		uint64_t q0_coff:1;
+		uint64_t q0_und:1;
+		uint64_t fed1_dbe:1;
+		uint64_t fed1_sbe:1;
+		uint64_t fed0_dbe:1;
+		uint64_t fed0_sbe:1;
+	} s;
+	struct cvmx_fpa_int_sum_s cn30xx;
+	struct cvmx_fpa_int_sum_s cn31xx;
+	struct cvmx_fpa_int_sum_s cn38xx;
+	struct cvmx_fpa_int_sum_s cn38xxp2;
+	struct cvmx_fpa_int_sum_s cn50xx;
+	struct cvmx_fpa_int_sum_s cn52xx;
+	struct cvmx_fpa_int_sum_s cn52xxp1;
+	struct cvmx_fpa_int_sum_s cn56xx;
+	struct cvmx_fpa_int_sum_s cn56xxp1;
+	struct cvmx_fpa_int_sum_s cn58xx;
+	struct cvmx_fpa_int_sum_s cn58xxp1;
+};
+
+union cvmx_fpa_quex_available {
+	uint64_t u64;
+	struct cvmx_fpa_quex_available_s {
+		uint64_t reserved_29_63:35;
+		uint64_t que_siz:29;
+	} s;
+	struct cvmx_fpa_quex_available_s cn30xx;
+	struct cvmx_fpa_quex_available_s cn31xx;
+	struct cvmx_fpa_quex_available_s cn38xx;
+	struct cvmx_fpa_quex_available_s cn38xxp2;
+	struct cvmx_fpa_quex_available_s cn50xx;
+	struct cvmx_fpa_quex_available_s cn52xx;
+	struct cvmx_fpa_quex_available_s cn52xxp1;
+	struct cvmx_fpa_quex_available_s cn56xx;
+	struct cvmx_fpa_quex_available_s cn56xxp1;
+	struct cvmx_fpa_quex_available_s cn58xx;
+	struct cvmx_fpa_quex_available_s cn58xxp1;
+};
+
+union cvmx_fpa_quex_page_index {
+	uint64_t u64;
+	struct cvmx_fpa_quex_page_index_s {
+		uint64_t reserved_25_63:39;
+		uint64_t pg_num:25;
+	} s;
+	struct cvmx_fpa_quex_page_index_s cn30xx;
+	struct cvmx_fpa_quex_page_index_s cn31xx;
+	struct cvmx_fpa_quex_page_index_s cn38xx;
+	struct cvmx_fpa_quex_page_index_s cn38xxp2;
+	struct cvmx_fpa_quex_page_index_s cn50xx;
+	struct cvmx_fpa_quex_page_index_s cn52xx;
+	struct cvmx_fpa_quex_page_index_s cn52xxp1;
+	struct cvmx_fpa_quex_page_index_s cn56xx;
+	struct cvmx_fpa_quex_page_index_s cn56xxp1;
+	struct cvmx_fpa_quex_page_index_s cn58xx;
+	struct cvmx_fpa_quex_page_index_s cn58xxp1;
+};
+
+union cvmx_fpa_que_act {
+	uint64_t u64;
+	struct cvmx_fpa_que_act_s {
+		uint64_t reserved_29_63:35;
+		uint64_t act_que:3;
+		uint64_t act_indx:26;
+	} s;
+	struct cvmx_fpa_que_act_s cn30xx;
+	struct cvmx_fpa_que_act_s cn31xx;
+	struct cvmx_fpa_que_act_s cn38xx;
+	struct cvmx_fpa_que_act_s cn38xxp2;
+	struct cvmx_fpa_que_act_s cn50xx;
+	struct cvmx_fpa_que_act_s cn52xx;
+	struct cvmx_fpa_que_act_s cn52xxp1;
+	struct cvmx_fpa_que_act_s cn56xx;
+	struct cvmx_fpa_que_act_s cn56xxp1;
+	struct cvmx_fpa_que_act_s cn58xx;
+	struct cvmx_fpa_que_act_s cn58xxp1;
+};
+
+union cvmx_fpa_que_exp {
+	uint64_t u64;
+	struct cvmx_fpa_que_exp_s {
+		uint64_t reserved_29_63:35;
+		uint64_t exp_que:3;
+		uint64_t exp_indx:26;
+	} s;
+	struct cvmx_fpa_que_exp_s cn30xx;
+	struct cvmx_fpa_que_exp_s cn31xx;
+	struct cvmx_fpa_que_exp_s cn38xx;
+	struct cvmx_fpa_que_exp_s cn38xxp2;
+	struct cvmx_fpa_que_exp_s cn50xx;
+	struct cvmx_fpa_que_exp_s cn52xx;
+	struct cvmx_fpa_que_exp_s cn52xxp1;
+	struct cvmx_fpa_que_exp_s cn56xx;
+	struct cvmx_fpa_que_exp_s cn56xxp1;
+	struct cvmx_fpa_que_exp_s cn58xx;
+	struct cvmx_fpa_que_exp_s cn58xxp1;
+};
+
+union cvmx_fpa_wart_ctl {
+	uint64_t u64;
+	struct cvmx_fpa_wart_ctl_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ctl:16;
+	} s;
+	struct cvmx_fpa_wart_ctl_s cn30xx;
+	struct cvmx_fpa_wart_ctl_s cn31xx;
+	struct cvmx_fpa_wart_ctl_s cn38xx;
+	struct cvmx_fpa_wart_ctl_s cn38xxp2;
+	struct cvmx_fpa_wart_ctl_s cn50xx;
+	struct cvmx_fpa_wart_ctl_s cn52xx;
+	struct cvmx_fpa_wart_ctl_s cn52xxp1;
+	struct cvmx_fpa_wart_ctl_s cn56xx;
+	struct cvmx_fpa_wart_ctl_s cn56xxp1;
+	struct cvmx_fpa_wart_ctl_s cn58xx;
+	struct cvmx_fpa_wart_ctl_s cn58xxp1;
+};
+
+union cvmx_fpa_wart_status {
+	uint64_t u64;
+	struct cvmx_fpa_wart_status_s {
+		uint64_t reserved_32_63:32;
+		uint64_t status:32;
+	} s;
+	struct cvmx_fpa_wart_status_s cn30xx;
+	struct cvmx_fpa_wart_status_s cn31xx;
+	struct cvmx_fpa_wart_status_s cn38xx;
+	struct cvmx_fpa_wart_status_s cn38xxp2;
+	struct cvmx_fpa_wart_status_s cn50xx;
+	struct cvmx_fpa_wart_status_s cn52xx;
+	struct cvmx_fpa_wart_status_s cn52xxp1;
+	struct cvmx_fpa_wart_status_s cn56xx;
+	struct cvmx_fpa_wart_status_s cn56xxp1;
+	struct cvmx_fpa_wart_status_s cn58xx;
+	struct cvmx_fpa_wart_status_s cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-fpa.c b/drivers/staging/octeon/cvmx-fpa.c
new file mode 100644
index 0000000..55d9147
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-fpa.c
@@ -0,0 +1,183 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Support library for the hardware Free Pool Allocator.
+ *
+ *
+ */
+
+#include "cvmx-config.h"
+#include "cvmx.h"
+#include "cvmx-fpa.h"
+#include "cvmx-ipd.h"
+
+/**
+ * Current state of all the pools. Use access functions
+ * instead of using it directly.
+ */
+CVMX_SHARED cvmx_fpa_pool_info_t cvmx_fpa_pool_info[CVMX_FPA_NUM_POOLS];
+
+/**
+ * Setup a FPA pool to control a new block of memory. The
+ * buffer pointer must be a physical address.
+ *
+ * @pool:       Pool to initialize
+ *                   0 <= pool < 8
+ * @name:       Constant character string to name this pool.
+ *                   String is not copied.
+ * @buffer:     Pointer to the block of memory to use. This must be
+ *                   accessable by all processors and external hardware.
+ * @block_size: Size for each block controlled by the FPA
+ * @num_blocks: Number of blocks
+ *
+ * Returns 0 on Success,
+ *         -1 on failure
+ */
+int cvmx_fpa_setup_pool(uint64_t pool, const char *name, void *buffer,
+			uint64_t block_size, uint64_t num_blocks)
+{
+	char *ptr;
+	if (!buffer) {
+		cvmx_dprintf
+		    ("ERROR: cvmx_fpa_setup_pool: NULL buffer pointer!\n");
+		return -1;
+	}
+	if (pool >= CVMX_FPA_NUM_POOLS) {
+		cvmx_dprintf("ERROR: cvmx_fpa_setup_pool: Illegal pool!\n");
+		return -1;
+	}
+
+	if (block_size < CVMX_FPA_MIN_BLOCK_SIZE) {
+		cvmx_dprintf
+		    ("ERROR: cvmx_fpa_setup_pool: Block size too small.\n");
+		return -1;
+	}
+
+	if (((unsigned long)buffer & (CVMX_FPA_ALIGNMENT - 1)) != 0) {
+		cvmx_dprintf
+		    ("ERROR: cvmx_fpa_setup_pool: Buffer not aligned properly.\n");
+		return -1;
+	}
+
+	cvmx_fpa_pool_info[pool].name = name;
+	cvmx_fpa_pool_info[pool].size = block_size;
+	cvmx_fpa_pool_info[pool].starting_element_count = num_blocks;
+	cvmx_fpa_pool_info[pool].base = buffer;
+
+	ptr = (char *)buffer;
+	while (num_blocks--) {
+		cvmx_fpa_free(ptr, pool, 0);
+		ptr += block_size;
+	}
+	return 0;
+}
+
+/**
+ * Shutdown a Memory pool and validate that it had all of
+ * the buffers originally placed in it.
+ *
+ * @pool:   Pool to shutdown
+ * Returns Zero on success
+ *         - Positive is count of missing buffers
+ *         - Negative is too many buffers or corrupted pointers
+ */
+uint64_t cvmx_fpa_shutdown_pool(uint64_t pool)
+{
+	uint64_t errors = 0;
+	uint64_t count = 0;
+	uint64_t base = cvmx_ptr_to_phys(cvmx_fpa_pool_info[pool].base);
+	uint64_t finish =
+	    base +
+	    cvmx_fpa_pool_info[pool].size *
+	    cvmx_fpa_pool_info[pool].starting_element_count;
+	void *ptr;
+	uint64_t address;
+
+	count = 0;
+	do {
+		ptr = cvmx_fpa_alloc(pool);
+		if (ptr)
+			address = cvmx_ptr_to_phys(ptr);
+		else
+			address = 0;
+		if (address) {
+			if ((address >= base) && (address < finish) &&
+			    (((address -
+			       base) % cvmx_fpa_pool_info[pool].size) == 0)) {
+				count++;
+			} else {
+				cvmx_dprintf
+				    ("ERROR: cvmx_fpa_shutdown_pool: Illegal address 0x%llx in pool %s(%d)\n",
+				     (unsigned long long)address,
+				     cvmx_fpa_pool_info[pool].name, (int)pool);
+				errors++;
+			}
+		}
+	} while (address);
+
+#ifdef CVMX_ENABLE_PKO_FUNCTIONS
+	if (pool == 0)
+		cvmx_ipd_free_ptr();
+#endif
+
+	if (errors) {
+		cvmx_dprintf
+		    ("ERROR: cvmx_fpa_shutdown_pool: Pool %s(%d) started at 0x%llx, ended at 0x%llx, with a step of 0x%llx\n",
+		     cvmx_fpa_pool_info[pool].name, (int)pool,
+		     (unsigned long long)base, (unsigned long long)finish,
+		     (unsigned long long)cvmx_fpa_pool_info[pool].size);
+		return -errors;
+	} else
+		return 0;
+}
+
+uint64_t cvmx_fpa_get_block_size(uint64_t pool)
+{
+	switch (pool) {
+	case 0:
+		return CVMX_FPA_POOL_0_SIZE;
+	case 1:
+		return CVMX_FPA_POOL_1_SIZE;
+	case 2:
+		return CVMX_FPA_POOL_2_SIZE;
+	case 3:
+		return CVMX_FPA_POOL_3_SIZE;
+	case 4:
+		return CVMX_FPA_POOL_4_SIZE;
+	case 5:
+		return CVMX_FPA_POOL_5_SIZE;
+	case 6:
+		return CVMX_FPA_POOL_6_SIZE;
+	case 7:
+		return CVMX_FPA_POOL_7_SIZE;
+	default:
+		return 0;
+	}
+}
diff --git a/drivers/staging/octeon/cvmx-fpa.h b/drivers/staging/octeon/cvmx-fpa.h
new file mode 100644
index 0000000..1d7788f
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-fpa.h
@@ -0,0 +1,299 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Interface to the hardware Free Pool Allocator.
+ *
+ *
+ */
+
+#ifndef __CVMX_FPA_H__
+#define __CVMX_FPA_H__
+
+#include "cvmx-address.h"
+#include "cvmx-fpa-defs.h"
+
+#define CVMX_FPA_NUM_POOLS      8
+#define CVMX_FPA_MIN_BLOCK_SIZE 128
+#define CVMX_FPA_ALIGNMENT      128
+
+/**
+ * Structure describing the data format used for stores to the FPA.
+ */
+typedef union {
+	uint64_t u64;
+	struct {
+		/*
+		 * the (64-bit word) location in scratchpad to write
+		 * to (if len != 0)
+		 */
+		uint64_t scraddr:8;
+		/* the number of words in the response (0 => no response) */
+		uint64_t len:8;
+		/* the ID of the device on the non-coherent bus */
+		uint64_t did:8;
+		/*
+		 * the address that will appear in the first tick on
+		 * the NCB bus.
+		 */
+		uint64_t addr:40;
+	} s;
+} cvmx_fpa_iobdma_data_t;
+
+/**
+ * Structure describing the current state of a FPA pool.
+ */
+typedef struct {
+	/* Name it was created under */
+	const char *name;
+	/* Size of each block */
+	uint64_t size;
+	/* The base memory address of whole block */
+	void *base;
+	/* The number of elements in the pool at creation */
+	uint64_t starting_element_count;
+} cvmx_fpa_pool_info_t;
+
+/**
+ * Current state of all the pools. Use access functions
+ * instead of using it directly.
+ */
+extern cvmx_fpa_pool_info_t cvmx_fpa_pool_info[CVMX_FPA_NUM_POOLS];
+
+/* CSR typedefs have been moved to cvmx-csr-*.h */
+
+/**
+ * Return the name of the pool
+ *
+ * @pool:   Pool to get the name of
+ * Returns The name
+ */
+static inline const char *cvmx_fpa_get_name(uint64_t pool)
+{
+	return cvmx_fpa_pool_info[pool].name;
+}
+
+/**
+ * Return the base of the pool
+ *
+ * @pool:   Pool to get the base of
+ * Returns The base
+ */
+static inline void *cvmx_fpa_get_base(uint64_t pool)
+{
+	return cvmx_fpa_pool_info[pool].base;
+}
+
+/**
+ * Check if a pointer belongs to an FPA pool. Return non-zero
+ * if the supplied pointer is inside the memory controlled by
+ * an FPA pool.
+ *
+ * @pool:   Pool to check
+ * @ptr:    Pointer to check
+ * Returns Non-zero if pointer is in the pool. Zero if not
+ */
+static inline int cvmx_fpa_is_member(uint64_t pool, void *ptr)
+{
+	return ((ptr >= cvmx_fpa_pool_info[pool].base) &&
+		((char *)ptr <
+		 ((char *)(cvmx_fpa_pool_info[pool].base)) +
+		 cvmx_fpa_pool_info[pool].size *
+		 cvmx_fpa_pool_info[pool].starting_element_count));
+}
+
+/**
+ * Enable the FPA for use. Must be performed after any CSR
+ * configuration but before any other FPA functions.
+ */
+static inline void cvmx_fpa_enable(void)
+{
+	union cvmx_fpa_ctl_status status;
+
+	status.u64 = cvmx_read_csr(CVMX_FPA_CTL_STATUS);
+	if (status.s.enb) {
+		cvmx_dprintf
+		    ("Warning: Enabling FPA when FPA already enabled.\n");
+	}
+
+	/*
+	 * Do runtime check as we allow pass1 compiled code to run on
+	 * pass2 chips.
+	 */
+	if (cvmx_octeon_is_pass1()) {
+		union cvmx_fpa_fpfx_marks marks;
+		int i;
+		for (i = 1; i < 8; i++) {
+			marks.u64 =
+			    cvmx_read_csr(CVMX_FPA_FPF1_MARKS + (i - 1) * 8ull);
+			marks.s.fpf_wr = 0xe0;
+			cvmx_write_csr(CVMX_FPA_FPF1_MARKS + (i - 1) * 8ull,
+				       marks.u64);
+		}
+
+		/* Enforce a 10 cycle delay between config and enable */
+		cvmx_wait(10);
+	}
+
+	/* FIXME: CVMX_FPA_CTL_STATUS read is unmodelled */
+	status.u64 = 0;
+	status.s.enb = 1;
+	cvmx_write_csr(CVMX_FPA_CTL_STATUS, status.u64);
+}
+
+/**
+ * Get a new block from the FPA
+ *
+ * @pool:   Pool to get the block from
+ * Returns Pointer to the block or NULL on failure
+ */
+static inline void *cvmx_fpa_alloc(uint64_t pool)
+{
+	uint64_t address =
+	    cvmx_read_csr(CVMX_ADDR_DID(CVMX_FULL_DID(CVMX_OCT_DID_FPA, pool)));
+	if (address)
+		return cvmx_phys_to_ptr(address);
+	else
+		return NULL;
+}
+
+/**
+ * Asynchronously get a new block from the FPA
+ *
+ * @scr_addr: Local scratch address to put response in.  This is a byte address,
+ *                  but must be 8 byte aligned.
+ * @pool:      Pool to get the block from
+ */
+static inline void cvmx_fpa_async_alloc(uint64_t scr_addr, uint64_t pool)
+{
+	cvmx_fpa_iobdma_data_t data;
+
+	/*
+	 * Hardware only uses 64 bit alligned locations, so convert
+	 * from byte address to 64-bit index
+	 */
+	data.s.scraddr = scr_addr >> 3;
+	data.s.len = 1;
+	data.s.did = CVMX_FULL_DID(CVMX_OCT_DID_FPA, pool);
+	data.s.addr = 0;
+	cvmx_send_single(data.u64);
+}
+
+/**
+ * Free a block allocated with a FPA pool.  Does NOT provide memory
+ * ordering in cases where the memory block was modified by the core.
+ *
+ * @ptr:    Block to free
+ * @pool:   Pool to put it in
+ * @num_cache_lines:
+ *               Cache lines to invalidate
+ */
+static inline void cvmx_fpa_free_nosync(void *ptr, uint64_t pool,
+					uint64_t num_cache_lines)
+{
+	cvmx_addr_t newptr;
+	newptr.u64 = cvmx_ptr_to_phys(ptr);
+	newptr.sfilldidspace.didspace =
+	    CVMX_ADDR_DIDSPACE(CVMX_FULL_DID(CVMX_OCT_DID_FPA, pool));
+	/* Prevent GCC from reordering around free */
+	barrier();
+	/* value written is number of cache lines not written back */
+	cvmx_write_io(newptr.u64, num_cache_lines);
+}
+
+/**
+ * Free a block allocated with a FPA pool.  Provides required memory
+ * ordering in cases where memory block was modified by core.
+ *
+ * @ptr:    Block to free
+ * @pool:   Pool to put it in
+ * @num_cache_lines:
+ *               Cache lines to invalidate
+ */
+static inline void cvmx_fpa_free(void *ptr, uint64_t pool,
+				 uint64_t num_cache_lines)
+{
+	cvmx_addr_t newptr;
+	newptr.u64 = cvmx_ptr_to_phys(ptr);
+	newptr.sfilldidspace.didspace =
+	    CVMX_ADDR_DIDSPACE(CVMX_FULL_DID(CVMX_OCT_DID_FPA, pool));
+	/*
+	 * Make sure that any previous writes to memory go out before
+	 * we free this buffer.  This also serves as a barrier to
+	 * prevent GCC from reordering operations to after the
+	 * free.
+	 */
+	CVMX_SYNCWS;
+	/* value written is number of cache lines not written back */
+	cvmx_write_io(newptr.u64, num_cache_lines);
+}
+
+/**
+ * Setup a FPA pool to control a new block of memory.
+ * This can only be called once per pool. Make sure proper
+ * locking enforces this.
+ *
+ * @pool:       Pool to initialize
+ *                   0 <= pool < 8
+ * @name:       Constant character string to name this pool.
+ *                   String is not copied.
+ * @buffer:     Pointer to the block of memory to use. This must be
+ *                   accessable by all processors and external hardware.
+ * @block_size: Size for each block controlled by the FPA
+ * @num_blocks: Number of blocks
+ *
+ * Returns 0 on Success,
+ *         -1 on failure
+ */
+extern int cvmx_fpa_setup_pool(uint64_t pool, const char *name, void *buffer,
+			       uint64_t block_size, uint64_t num_blocks);
+
+/**
+ * Shutdown a Memory pool and validate that it had all of
+ * the buffers originally placed in it. This should only be
+ * called by one processor after all hardware has finished
+ * using the pool.
+ *
+ * @pool:   Pool to shutdown
+ * Returns Zero on success
+ *         - Positive is count of missing buffers
+ *         - Negative is too many buffers or corrupted pointers
+ */
+extern uint64_t cvmx_fpa_shutdown_pool(uint64_t pool);
+
+/**
+ * Get the size of blocks controlled by the pool
+ * This is resolved to a constant at compile time.
+ *
+ * @pool:   Pool to access
+ * Returns Size of the block in bytes
+ */
+uint64_t cvmx_fpa_get_block_size(uint64_t pool);
+
+#endif /*  __CVM_FPA_H__ */
diff --git a/drivers/staging/octeon/cvmx-gmxx-defs.h b/drivers/staging/octeon/cvmx-gmxx-defs.h
new file mode 100644
index 0000000..946a43a
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-gmxx-defs.h
@@ -0,0 +1,2529 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_GMXX_DEFS_H__
+#define __CVMX_GMXX_DEFS_H__
+
+#define CVMX_GMXX_BAD_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000518ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_BIST(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000400ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_CLK_EN(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080007F0ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_HG2_CONTROL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000550ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_INF_MODE(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080007F8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_NXA_ADR(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000510ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_PRTX_CBFC_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000580ull + (((offset) & 0) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_PRTX_CFG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000010ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_ADR_CAM0(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000180ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_ADR_CAM1(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000188ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_ADR_CAM2(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000190ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_ADR_CAM3(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000198ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_ADR_CAM4(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080001A0ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_ADR_CAM5(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080001A8ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_ADR_CAM_EN(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000108ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_ADR_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000100ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_DECISION(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000040ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_FRM_CHK(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000020ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_FRM_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000018ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_FRM_MAX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000030ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_FRM_MIN(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000028ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_IFG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000058ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_INT_EN(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000008ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_INT_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000000ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_JABBER(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000038ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_PAUSE_DROP_TIME(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000068ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_RX_INBND(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000060ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000050ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_OCTS(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000088ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_OCTS_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000098ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_OCTS_DMAC(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080000A8ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_OCTS_DRP(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080000B8ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_PKTS(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000080ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_PKTS_BAD(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080000C0ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_PKTS_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000090ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_PKTS_DMAC(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080000A0ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_STATS_PKTS_DRP(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080000B0ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RXX_UDD_SKP(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000048ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_BP_DROPX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000420ull + (((offset) & 3) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_BP_OFFX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000460ull + (((offset) & 3) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_BP_ONX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000440ull + (((offset) & 3) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_HG2_STATUS(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000548ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_PASS_EN(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080005F8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_PASS_MAPX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000600ull + (((offset) & 15) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_PRTS(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000410ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_PRT_INFO(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004E8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_TX_STATUS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080007E8ull + (((block_id) & 0) * 0x8000000ull))
+#define CVMX_GMXX_RX_XAUI_BAD_COL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000538ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_RX_XAUI_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000530ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_SMACX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000230ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_STAT_BP(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000520ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_APPEND(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000218ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_BURST(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000228ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_CBFC_XOFF(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080005A0ull + (((offset) & 0) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_CBFC_XON(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080005C0ull + (((offset) & 0) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_CLK(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000208ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000270ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_MIN_PKT(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000240ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_PAUSE_PKT_INTERVAL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000248ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_PAUSE_PKT_TIME(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000238ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_PAUSE_TOGO(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000258ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_PAUSE_ZERO(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000260ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_SGMII_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000300ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_SLOT(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000220ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_SOFT_PAUSE(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000250ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT0(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000280ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT1(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000288ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT2(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000290ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT3(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000298ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT4(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080002A0ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT5(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080002A8ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT6(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080002B0ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT7(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080002B8ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT8(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080002C0ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STAT9(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080002C8ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_STATS_CTL(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000268ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TXX_THRESH(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000210ull + (((offset) & 3) * 2048) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_BP(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004D0ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_CLK_MSKX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000780ull + (((offset) & 1) * 8) + (((block_id) & 0) * 0x0ull))
+#define CVMX_GMXX_TX_COL_ATTEMPT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000498ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_CORRUPT(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004D8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_HG2_REG1(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000558ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_HG2_REG2(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000560ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_IFG(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000488ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_INT_EN(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000508ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_INT_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000500ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_JAM(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000490ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_LFSR(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004F8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_OVR_BP(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004C8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_PAUSE_PKT_DMAC(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004A0ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_PAUSE_PKT_TYPE(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004A8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_PRTS(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000480ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_SPI_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004C0ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_SPI_DRAIN(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004E0ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_SPI_MAX(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004B0ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_SPI_ROUNDX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000680ull + (((offset) & 31) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_SPI_THRESH(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800080004B8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_TX_XAUI_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000528ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_GMXX_XAUI_EXT_LOOPBACK(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180008000540ull + (((block_id) & 1) * 0x8000000ull))
+
+union cvmx_gmxx_bad_reg {
+	uint64_t u64;
+	struct cvmx_gmxx_bad_reg_s {
+		uint64_t reserved_31_63:33;
+		uint64_t inb_nxa:4;
+		uint64_t statovr:1;
+		uint64_t loststat:4;
+		uint64_t reserved_18_21:4;
+		uint64_t out_ovr:16;
+		uint64_t ncb_ovr:1;
+		uint64_t out_col:1;
+	} s;
+	struct cvmx_gmxx_bad_reg_cn30xx {
+		uint64_t reserved_31_63:33;
+		uint64_t inb_nxa:4;
+		uint64_t statovr:1;
+		uint64_t reserved_25_25:1;
+		uint64_t loststat:3;
+		uint64_t reserved_5_21:17;
+		uint64_t out_ovr:3;
+		uint64_t reserved_0_1:2;
+	} cn30xx;
+	struct cvmx_gmxx_bad_reg_cn30xx cn31xx;
+	struct cvmx_gmxx_bad_reg_s cn38xx;
+	struct cvmx_gmxx_bad_reg_s cn38xxp2;
+	struct cvmx_gmxx_bad_reg_cn30xx cn50xx;
+	struct cvmx_gmxx_bad_reg_cn52xx {
+		uint64_t reserved_31_63:33;
+		uint64_t inb_nxa:4;
+		uint64_t statovr:1;
+		uint64_t loststat:4;
+		uint64_t reserved_6_21:16;
+		uint64_t out_ovr:4;
+		uint64_t reserved_0_1:2;
+	} cn52xx;
+	struct cvmx_gmxx_bad_reg_cn52xx cn52xxp1;
+	struct cvmx_gmxx_bad_reg_cn52xx cn56xx;
+	struct cvmx_gmxx_bad_reg_cn52xx cn56xxp1;
+	struct cvmx_gmxx_bad_reg_s cn58xx;
+	struct cvmx_gmxx_bad_reg_s cn58xxp1;
+};
+
+union cvmx_gmxx_bist {
+	uint64_t u64;
+	struct cvmx_gmxx_bist_s {
+		uint64_t reserved_17_63:47;
+		uint64_t status:17;
+	} s;
+	struct cvmx_gmxx_bist_cn30xx {
+		uint64_t reserved_10_63:54;
+		uint64_t status:10;
+	} cn30xx;
+	struct cvmx_gmxx_bist_cn30xx cn31xx;
+	struct cvmx_gmxx_bist_cn30xx cn38xx;
+	struct cvmx_gmxx_bist_cn30xx cn38xxp2;
+	struct cvmx_gmxx_bist_cn50xx {
+		uint64_t reserved_12_63:52;
+		uint64_t status:12;
+	} cn50xx;
+	struct cvmx_gmxx_bist_cn52xx {
+		uint64_t reserved_16_63:48;
+		uint64_t status:16;
+	} cn52xx;
+	struct cvmx_gmxx_bist_cn52xx cn52xxp1;
+	struct cvmx_gmxx_bist_cn52xx cn56xx;
+	struct cvmx_gmxx_bist_cn52xx cn56xxp1;
+	struct cvmx_gmxx_bist_s cn58xx;
+	struct cvmx_gmxx_bist_s cn58xxp1;
+};
+
+union cvmx_gmxx_clk_en {
+	uint64_t u64;
+	struct cvmx_gmxx_clk_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t clk_en:1;
+	} s;
+	struct cvmx_gmxx_clk_en_s cn52xx;
+	struct cvmx_gmxx_clk_en_s cn52xxp1;
+	struct cvmx_gmxx_clk_en_s cn56xx;
+	struct cvmx_gmxx_clk_en_s cn56xxp1;
+};
+
+union cvmx_gmxx_hg2_control {
+	uint64_t u64;
+	struct cvmx_gmxx_hg2_control_s {
+		uint64_t reserved_19_63:45;
+		uint64_t hg2tx_en:1;
+		uint64_t hg2rx_en:1;
+		uint64_t phys_en:1;
+		uint64_t logl_en:16;
+	} s;
+	struct cvmx_gmxx_hg2_control_s cn52xx;
+	struct cvmx_gmxx_hg2_control_s cn52xxp1;
+	struct cvmx_gmxx_hg2_control_s cn56xx;
+};
+
+union cvmx_gmxx_inf_mode {
+	uint64_t u64;
+	struct cvmx_gmxx_inf_mode_s {
+		uint64_t reserved_10_63:54;
+		uint64_t speed:2;
+		uint64_t reserved_6_7:2;
+		uint64_t mode:2;
+		uint64_t reserved_3_3:1;
+		uint64_t p0mii:1;
+		uint64_t en:1;
+		uint64_t type:1;
+	} s;
+	struct cvmx_gmxx_inf_mode_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t p0mii:1;
+		uint64_t en:1;
+		uint64_t type:1;
+	} cn30xx;
+	struct cvmx_gmxx_inf_mode_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t en:1;
+		uint64_t type:1;
+	} cn31xx;
+	struct cvmx_gmxx_inf_mode_cn31xx cn38xx;
+	struct cvmx_gmxx_inf_mode_cn31xx cn38xxp2;
+	struct cvmx_gmxx_inf_mode_cn30xx cn50xx;
+	struct cvmx_gmxx_inf_mode_cn52xx {
+		uint64_t reserved_10_63:54;
+		uint64_t speed:2;
+		uint64_t reserved_6_7:2;
+		uint64_t mode:2;
+		uint64_t reserved_2_3:2;
+		uint64_t en:1;
+		uint64_t type:1;
+	} cn52xx;
+	struct cvmx_gmxx_inf_mode_cn52xx cn52xxp1;
+	struct cvmx_gmxx_inf_mode_cn52xx cn56xx;
+	struct cvmx_gmxx_inf_mode_cn52xx cn56xxp1;
+	struct cvmx_gmxx_inf_mode_cn31xx cn58xx;
+	struct cvmx_gmxx_inf_mode_cn31xx cn58xxp1;
+};
+
+union cvmx_gmxx_nxa_adr {
+	uint64_t u64;
+	struct cvmx_gmxx_nxa_adr_s {
+		uint64_t reserved_6_63:58;
+		uint64_t prt:6;
+	} s;
+	struct cvmx_gmxx_nxa_adr_s cn30xx;
+	struct cvmx_gmxx_nxa_adr_s cn31xx;
+	struct cvmx_gmxx_nxa_adr_s cn38xx;
+	struct cvmx_gmxx_nxa_adr_s cn38xxp2;
+	struct cvmx_gmxx_nxa_adr_s cn50xx;
+	struct cvmx_gmxx_nxa_adr_s cn52xx;
+	struct cvmx_gmxx_nxa_adr_s cn52xxp1;
+	struct cvmx_gmxx_nxa_adr_s cn56xx;
+	struct cvmx_gmxx_nxa_adr_s cn56xxp1;
+	struct cvmx_gmxx_nxa_adr_s cn58xx;
+	struct cvmx_gmxx_nxa_adr_s cn58xxp1;
+};
+
+union cvmx_gmxx_prtx_cbfc_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_prtx_cbfc_ctl_s {
+		uint64_t phys_en:16;
+		uint64_t logl_en:16;
+		uint64_t phys_bp:16;
+		uint64_t reserved_4_15:12;
+		uint64_t bck_en:1;
+		uint64_t drp_en:1;
+		uint64_t tx_en:1;
+		uint64_t rx_en:1;
+	} s;
+	struct cvmx_gmxx_prtx_cbfc_ctl_s cn52xx;
+	struct cvmx_gmxx_prtx_cbfc_ctl_s cn56xx;
+};
+
+union cvmx_gmxx_prtx_cfg {
+	uint64_t u64;
+	struct cvmx_gmxx_prtx_cfg_s {
+		uint64_t reserved_14_63:50;
+		uint64_t tx_idle:1;
+		uint64_t rx_idle:1;
+		uint64_t reserved_9_11:3;
+		uint64_t speed_msb:1;
+		uint64_t reserved_4_7:4;
+		uint64_t slottime:1;
+		uint64_t duplex:1;
+		uint64_t speed:1;
+		uint64_t en:1;
+	} s;
+	struct cvmx_gmxx_prtx_cfg_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t slottime:1;
+		uint64_t duplex:1;
+		uint64_t speed:1;
+		uint64_t en:1;
+	} cn30xx;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn31xx;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn38xx;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn38xxp2;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn50xx;
+	struct cvmx_gmxx_prtx_cfg_s cn52xx;
+	struct cvmx_gmxx_prtx_cfg_s cn52xxp1;
+	struct cvmx_gmxx_prtx_cfg_s cn56xx;
+	struct cvmx_gmxx_prtx_cfg_s cn56xxp1;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn58xx;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_adr_cam0 {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam0_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_adr_cam1 {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam1_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_adr_cam2 {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam2_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_adr_cam3 {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam3_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_adr_cam4 {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam4_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_adr_cam5 {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam5_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_adr_cam_en {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t en:8;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_adr_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_ctl_s {
+		uint64_t reserved_4_63:60;
+		uint64_t cam_mode:1;
+		uint64_t mcst:2;
+		uint64_t bcst:1;
+	} s;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_decision {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_decision_s {
+		uint64_t reserved_5_63:59;
+		uint64_t cnt:5;
+	} s;
+	struct cvmx_gmxx_rxx_decision_s cn30xx;
+	struct cvmx_gmxx_rxx_decision_s cn31xx;
+	struct cvmx_gmxx_rxx_decision_s cn38xx;
+	struct cvmx_gmxx_rxx_decision_s cn38xxp2;
+	struct cvmx_gmxx_rxx_decision_s cn50xx;
+	struct cvmx_gmxx_rxx_decision_s cn52xx;
+	struct cvmx_gmxx_rxx_decision_s cn52xxp1;
+	struct cvmx_gmxx_rxx_decision_s cn56xx;
+	struct cvmx_gmxx_rxx_decision_s cn56xxp1;
+	struct cvmx_gmxx_rxx_decision_s cn58xx;
+	struct cvmx_gmxx_rxx_decision_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_frm_chk {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_frm_chk_s {
+		uint64_t reserved_10_63:54;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_gmxx_rxx_frm_chk_s cn30xx;
+	struct cvmx_gmxx_rxx_frm_chk_s cn31xx;
+	struct cvmx_gmxx_rxx_frm_chk_s cn38xx;
+	struct cvmx_gmxx_rxx_frm_chk_s cn38xxp2;
+	struct cvmx_gmxx_rxx_frm_chk_cn50xx {
+		uint64_t reserved_10_63:54;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_6_6:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn50xx;
+	struct cvmx_gmxx_rxx_frm_chk_cn52xx {
+		uint64_t reserved_9_63:55;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn52xx;
+	struct cvmx_gmxx_rxx_frm_chk_cn52xx cn52xxp1;
+	struct cvmx_gmxx_rxx_frm_chk_cn52xx cn56xx;
+	struct cvmx_gmxx_rxx_frm_chk_cn52xx cn56xxp1;
+	struct cvmx_gmxx_rxx_frm_chk_s cn58xx;
+	struct cvmx_gmxx_rxx_frm_chk_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_frm_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_frm_ctl_s {
+		uint64_t reserved_11_63:53;
+		uint64_t null_dis:1;
+		uint64_t pre_align:1;
+		uint64_t pad_len:1;
+		uint64_t vlan_len:1;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} s;
+	struct cvmx_gmxx_rxx_frm_ctl_cn30xx {
+		uint64_t reserved_9_63:55;
+		uint64_t pad_len:1;
+		uint64_t vlan_len:1;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn30xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn31xx {
+		uint64_t reserved_8_63:56;
+		uint64_t vlan_len:1;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn31xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn30xx cn38xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn31xx cn38xxp2;
+	struct cvmx_gmxx_rxx_frm_ctl_cn50xx {
+		uint64_t reserved_11_63:53;
+		uint64_t null_dis:1;
+		uint64_t pre_align:1;
+		uint64_t reserved_7_8:2;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn50xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn50xx cn52xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn50xx cn52xxp1;
+	struct cvmx_gmxx_rxx_frm_ctl_cn50xx cn56xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn56xxp1 {
+		uint64_t reserved_10_63:54;
+		uint64_t pre_align:1;
+		uint64_t reserved_7_8:2;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn56xxp1;
+	struct cvmx_gmxx_rxx_frm_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn30xx cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_frm_max {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_frm_max_s {
+		uint64_t reserved_16_63:48;
+		uint64_t len:16;
+	} s;
+	struct cvmx_gmxx_rxx_frm_max_s cn30xx;
+	struct cvmx_gmxx_rxx_frm_max_s cn31xx;
+	struct cvmx_gmxx_rxx_frm_max_s cn38xx;
+	struct cvmx_gmxx_rxx_frm_max_s cn38xxp2;
+	struct cvmx_gmxx_rxx_frm_max_s cn58xx;
+	struct cvmx_gmxx_rxx_frm_max_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_frm_min {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_frm_min_s {
+		uint64_t reserved_16_63:48;
+		uint64_t len:16;
+	} s;
+	struct cvmx_gmxx_rxx_frm_min_s cn30xx;
+	struct cvmx_gmxx_rxx_frm_min_s cn31xx;
+	struct cvmx_gmxx_rxx_frm_min_s cn38xx;
+	struct cvmx_gmxx_rxx_frm_min_s cn38xxp2;
+	struct cvmx_gmxx_rxx_frm_min_s cn58xx;
+	struct cvmx_gmxx_rxx_frm_min_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_ifg {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_ifg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t ifg:4;
+	} s;
+	struct cvmx_gmxx_rxx_ifg_s cn30xx;
+	struct cvmx_gmxx_rxx_ifg_s cn31xx;
+	struct cvmx_gmxx_rxx_ifg_s cn38xx;
+	struct cvmx_gmxx_rxx_ifg_s cn38xxp2;
+	struct cvmx_gmxx_rxx_ifg_s cn50xx;
+	struct cvmx_gmxx_rxx_ifg_s cn52xx;
+	struct cvmx_gmxx_rxx_ifg_s cn52xxp1;
+	struct cvmx_gmxx_rxx_ifg_s cn56xx;
+	struct cvmx_gmxx_rxx_ifg_s cn56xxp1;
+	struct cvmx_gmxx_rxx_ifg_s cn58xx;
+	struct cvmx_gmxx_rxx_ifg_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_int_en {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_int_en_s {
+		uint64_t reserved_29_63:35;
+		uint64_t hg2cc:1;
+		uint64_t hg2fld:1;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
+		uint64_t pause_drp:1;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_gmxx_rxx_int_en_cn30xx {
+		uint64_t reserved_19_63:45;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} cn30xx;
+	struct cvmx_gmxx_rxx_int_en_cn30xx cn31xx;
+	struct cvmx_gmxx_rxx_int_en_cn30xx cn38xx;
+	struct cvmx_gmxx_rxx_int_en_cn30xx cn38xxp2;
+	struct cvmx_gmxx_rxx_int_en_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_6_6:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn50xx;
+	struct cvmx_gmxx_rxx_int_en_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t hg2cc:1;
+		uint64_t hg2fld:1;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
+		uint64_t pause_drp:1;
+		uint64_t reserved_16_18:3;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t reserved_9_9:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn52xx;
+	struct cvmx_gmxx_rxx_int_en_cn52xx cn52xxp1;
+	struct cvmx_gmxx_rxx_int_en_cn52xx cn56xx;
+	struct cvmx_gmxx_rxx_int_en_cn56xxp1 {
+		uint64_t reserved_27_63:37;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
+		uint64_t pause_drp:1;
+		uint64_t reserved_16_18:3;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t reserved_9_9:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn56xxp1;
+	struct cvmx_gmxx_rxx_int_en_cn58xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} cn58xx;
+	struct cvmx_gmxx_rxx_int_en_cn58xx cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_int_reg {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_int_reg_s {
+		uint64_t reserved_29_63:35;
+		uint64_t hg2cc:1;
+		uint64_t hg2fld:1;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
+		uint64_t pause_drp:1;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_gmxx_rxx_int_reg_cn30xx {
+		uint64_t reserved_19_63:45;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} cn30xx;
+	struct cvmx_gmxx_rxx_int_reg_cn30xx cn31xx;
+	struct cvmx_gmxx_rxx_int_reg_cn30xx cn38xx;
+	struct cvmx_gmxx_rxx_int_reg_cn30xx cn38xxp2;
+	struct cvmx_gmxx_rxx_int_reg_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_6_6:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn50xx;
+	struct cvmx_gmxx_rxx_int_reg_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t hg2cc:1;
+		uint64_t hg2fld:1;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
+		uint64_t pause_drp:1;
+		uint64_t reserved_16_18:3;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t reserved_9_9:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn52xx;
+	struct cvmx_gmxx_rxx_int_reg_cn52xx cn52xxp1;
+	struct cvmx_gmxx_rxx_int_reg_cn52xx cn56xx;
+	struct cvmx_gmxx_rxx_int_reg_cn56xxp1 {
+		uint64_t reserved_27_63:37;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
+		uint64_t pause_drp:1;
+		uint64_t reserved_16_18:3;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t reserved_9_9:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn56xxp1;
+	struct cvmx_gmxx_rxx_int_reg_cn58xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} cn58xx;
+	struct cvmx_gmxx_rxx_int_reg_cn58xx cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_jabber {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_jabber_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_gmxx_rxx_jabber_s cn30xx;
+	struct cvmx_gmxx_rxx_jabber_s cn31xx;
+	struct cvmx_gmxx_rxx_jabber_s cn38xx;
+	struct cvmx_gmxx_rxx_jabber_s cn38xxp2;
+	struct cvmx_gmxx_rxx_jabber_s cn50xx;
+	struct cvmx_gmxx_rxx_jabber_s cn52xx;
+	struct cvmx_gmxx_rxx_jabber_s cn52xxp1;
+	struct cvmx_gmxx_rxx_jabber_s cn56xx;
+	struct cvmx_gmxx_rxx_jabber_s cn56xxp1;
+	struct cvmx_gmxx_rxx_jabber_s cn58xx;
+	struct cvmx_gmxx_rxx_jabber_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_pause_drop_time {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_pause_drop_time_s {
+		uint64_t reserved_16_63:48;
+		uint64_t status:16;
+	} s;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn50xx;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn52xx;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn52xxp1;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn56xx;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn56xxp1;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn58xx;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_rx_inbnd {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_rx_inbnd_s {
+		uint64_t reserved_4_63:60;
+		uint64_t duplex:1;
+		uint64_t speed:2;
+		uint64_t status:1;
+	} s;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn30xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn31xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn38xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn38xxp2;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn50xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn58xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rd_clr:1;
+	} s;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_octs {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_octs_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_gmxx_rxx_stats_octs_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_octs_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_octs_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_octs_dmac {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_octs_drp {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_pkts {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_pkts_bad {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_pkts_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_pkts_dmac {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_stats_pkts_drp {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn58xxp1;
+};
+
+union cvmx_gmxx_rxx_udd_skp {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_udd_skp_s {
+		uint64_t reserved_9_63:55;
+		uint64_t fcssel:1;
+		uint64_t reserved_7_7:1;
+		uint64_t len:7;
+	} s;
+	struct cvmx_gmxx_rxx_udd_skp_s cn30xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn31xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn38xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn38xxp2;
+	struct cvmx_gmxx_rxx_udd_skp_s cn50xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn52xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn52xxp1;
+	struct cvmx_gmxx_rxx_udd_skp_s cn56xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn56xxp1;
+	struct cvmx_gmxx_rxx_udd_skp_s cn58xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn58xxp1;
+};
+
+union cvmx_gmxx_rx_bp_dropx {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_bp_dropx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mark:6;
+	} s;
+	struct cvmx_gmxx_rx_bp_dropx_s cn30xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn31xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn38xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn38xxp2;
+	struct cvmx_gmxx_rx_bp_dropx_s cn50xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn52xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn52xxp1;
+	struct cvmx_gmxx_rx_bp_dropx_s cn56xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn56xxp1;
+	struct cvmx_gmxx_rx_bp_dropx_s cn58xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn58xxp1;
+};
+
+union cvmx_gmxx_rx_bp_offx {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_bp_offx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mark:6;
+	} s;
+	struct cvmx_gmxx_rx_bp_offx_s cn30xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn31xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn38xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn38xxp2;
+	struct cvmx_gmxx_rx_bp_offx_s cn50xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn52xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn52xxp1;
+	struct cvmx_gmxx_rx_bp_offx_s cn56xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn56xxp1;
+	struct cvmx_gmxx_rx_bp_offx_s cn58xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn58xxp1;
+};
+
+union cvmx_gmxx_rx_bp_onx {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_bp_onx_s {
+		uint64_t reserved_9_63:55;
+		uint64_t mark:9;
+	} s;
+	struct cvmx_gmxx_rx_bp_onx_s cn30xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn31xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn38xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn38xxp2;
+	struct cvmx_gmxx_rx_bp_onx_s cn50xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn52xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn52xxp1;
+	struct cvmx_gmxx_rx_bp_onx_s cn56xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn56xxp1;
+	struct cvmx_gmxx_rx_bp_onx_s cn58xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn58xxp1;
+};
+
+union cvmx_gmxx_rx_hg2_status {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_hg2_status_s {
+		uint64_t reserved_48_63:16;
+		uint64_t phtim2go:16;
+		uint64_t xof:16;
+		uint64_t lgtim2go:16;
+	} s;
+	struct cvmx_gmxx_rx_hg2_status_s cn52xx;
+	struct cvmx_gmxx_rx_hg2_status_s cn52xxp1;
+	struct cvmx_gmxx_rx_hg2_status_s cn56xx;
+};
+
+union cvmx_gmxx_rx_pass_en {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_pass_en_s {
+		uint64_t reserved_16_63:48;
+		uint64_t en:16;
+	} s;
+	struct cvmx_gmxx_rx_pass_en_s cn38xx;
+	struct cvmx_gmxx_rx_pass_en_s cn38xxp2;
+	struct cvmx_gmxx_rx_pass_en_s cn58xx;
+	struct cvmx_gmxx_rx_pass_en_s cn58xxp1;
+};
+
+union cvmx_gmxx_rx_pass_mapx {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_pass_mapx_s {
+		uint64_t reserved_4_63:60;
+		uint64_t dprt:4;
+	} s;
+	struct cvmx_gmxx_rx_pass_mapx_s cn38xx;
+	struct cvmx_gmxx_rx_pass_mapx_s cn38xxp2;
+	struct cvmx_gmxx_rx_pass_mapx_s cn58xx;
+	struct cvmx_gmxx_rx_pass_mapx_s cn58xxp1;
+};
+
+union cvmx_gmxx_rx_prt_info {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_prt_info_s {
+		uint64_t reserved_32_63:32;
+		uint64_t drop:16;
+		uint64_t commit:16;
+	} s;
+	struct cvmx_gmxx_rx_prt_info_cn30xx {
+		uint64_t reserved_19_63:45;
+		uint64_t drop:3;
+		uint64_t reserved_3_15:13;
+		uint64_t commit:3;
+	} cn30xx;
+	struct cvmx_gmxx_rx_prt_info_cn30xx cn31xx;
+	struct cvmx_gmxx_rx_prt_info_s cn38xx;
+	struct cvmx_gmxx_rx_prt_info_cn30xx cn50xx;
+	struct cvmx_gmxx_rx_prt_info_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t drop:4;
+		uint64_t reserved_4_15:12;
+		uint64_t commit:4;
+	} cn52xx;
+	struct cvmx_gmxx_rx_prt_info_cn52xx cn52xxp1;
+	struct cvmx_gmxx_rx_prt_info_cn52xx cn56xx;
+	struct cvmx_gmxx_rx_prt_info_cn52xx cn56xxp1;
+	struct cvmx_gmxx_rx_prt_info_s cn58xx;
+	struct cvmx_gmxx_rx_prt_info_s cn58xxp1;
+};
+
+union cvmx_gmxx_rx_prts {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_prts_s {
+		uint64_t reserved_3_63:61;
+		uint64_t prts:3;
+	} s;
+	struct cvmx_gmxx_rx_prts_s cn30xx;
+	struct cvmx_gmxx_rx_prts_s cn31xx;
+	struct cvmx_gmxx_rx_prts_s cn38xx;
+	struct cvmx_gmxx_rx_prts_s cn38xxp2;
+	struct cvmx_gmxx_rx_prts_s cn50xx;
+	struct cvmx_gmxx_rx_prts_s cn52xx;
+	struct cvmx_gmxx_rx_prts_s cn52xxp1;
+	struct cvmx_gmxx_rx_prts_s cn56xx;
+	struct cvmx_gmxx_rx_prts_s cn56xxp1;
+	struct cvmx_gmxx_rx_prts_s cn58xx;
+	struct cvmx_gmxx_rx_prts_s cn58xxp1;
+};
+
+union cvmx_gmxx_rx_tx_status {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_tx_status_s {
+		uint64_t reserved_7_63:57;
+		uint64_t tx:3;
+		uint64_t reserved_3_3:1;
+		uint64_t rx:3;
+	} s;
+	struct cvmx_gmxx_rx_tx_status_s cn30xx;
+	struct cvmx_gmxx_rx_tx_status_s cn31xx;
+	struct cvmx_gmxx_rx_tx_status_s cn50xx;
+};
+
+union cvmx_gmxx_rx_xaui_bad_col {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_xaui_bad_col_s {
+		uint64_t reserved_40_63:24;
+		uint64_t val:1;
+		uint64_t state:3;
+		uint64_t lane_rxc:4;
+		uint64_t lane_rxd:32;
+	} s;
+	struct cvmx_gmxx_rx_xaui_bad_col_s cn52xx;
+	struct cvmx_gmxx_rx_xaui_bad_col_s cn52xxp1;
+	struct cvmx_gmxx_rx_xaui_bad_col_s cn56xx;
+	struct cvmx_gmxx_rx_xaui_bad_col_s cn56xxp1;
+};
+
+union cvmx_gmxx_rx_xaui_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_xaui_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t status:2;
+	} s;
+	struct cvmx_gmxx_rx_xaui_ctl_s cn52xx;
+	struct cvmx_gmxx_rx_xaui_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rx_xaui_ctl_s cn56xx;
+	struct cvmx_gmxx_rx_xaui_ctl_s cn56xxp1;
+};
+
+union cvmx_gmxx_smacx {
+	uint64_t u64;
+	struct cvmx_gmxx_smacx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t smac:48;
+	} s;
+	struct cvmx_gmxx_smacx_s cn30xx;
+	struct cvmx_gmxx_smacx_s cn31xx;
+	struct cvmx_gmxx_smacx_s cn38xx;
+	struct cvmx_gmxx_smacx_s cn38xxp2;
+	struct cvmx_gmxx_smacx_s cn50xx;
+	struct cvmx_gmxx_smacx_s cn52xx;
+	struct cvmx_gmxx_smacx_s cn52xxp1;
+	struct cvmx_gmxx_smacx_s cn56xx;
+	struct cvmx_gmxx_smacx_s cn56xxp1;
+	struct cvmx_gmxx_smacx_s cn58xx;
+	struct cvmx_gmxx_smacx_s cn58xxp1;
+};
+
+union cvmx_gmxx_stat_bp {
+	uint64_t u64;
+	struct cvmx_gmxx_stat_bp_s {
+		uint64_t reserved_17_63:47;
+		uint64_t bp:1;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_gmxx_stat_bp_s cn30xx;
+	struct cvmx_gmxx_stat_bp_s cn31xx;
+	struct cvmx_gmxx_stat_bp_s cn38xx;
+	struct cvmx_gmxx_stat_bp_s cn38xxp2;
+	struct cvmx_gmxx_stat_bp_s cn50xx;
+	struct cvmx_gmxx_stat_bp_s cn52xx;
+	struct cvmx_gmxx_stat_bp_s cn52xxp1;
+	struct cvmx_gmxx_stat_bp_s cn56xx;
+	struct cvmx_gmxx_stat_bp_s cn56xxp1;
+	struct cvmx_gmxx_stat_bp_s cn58xx;
+	struct cvmx_gmxx_stat_bp_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_append {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_append_s {
+		uint64_t reserved_4_63:60;
+		uint64_t force_fcs:1;
+		uint64_t fcs:1;
+		uint64_t pad:1;
+		uint64_t preamble:1;
+	} s;
+	struct cvmx_gmxx_txx_append_s cn30xx;
+	struct cvmx_gmxx_txx_append_s cn31xx;
+	struct cvmx_gmxx_txx_append_s cn38xx;
+	struct cvmx_gmxx_txx_append_s cn38xxp2;
+	struct cvmx_gmxx_txx_append_s cn50xx;
+	struct cvmx_gmxx_txx_append_s cn52xx;
+	struct cvmx_gmxx_txx_append_s cn52xxp1;
+	struct cvmx_gmxx_txx_append_s cn56xx;
+	struct cvmx_gmxx_txx_append_s cn56xxp1;
+	struct cvmx_gmxx_txx_append_s cn58xx;
+	struct cvmx_gmxx_txx_append_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_burst {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_burst_s {
+		uint64_t reserved_16_63:48;
+		uint64_t burst:16;
+	} s;
+	struct cvmx_gmxx_txx_burst_s cn30xx;
+	struct cvmx_gmxx_txx_burst_s cn31xx;
+	struct cvmx_gmxx_txx_burst_s cn38xx;
+	struct cvmx_gmxx_txx_burst_s cn38xxp2;
+	struct cvmx_gmxx_txx_burst_s cn50xx;
+	struct cvmx_gmxx_txx_burst_s cn52xx;
+	struct cvmx_gmxx_txx_burst_s cn52xxp1;
+	struct cvmx_gmxx_txx_burst_s cn56xx;
+	struct cvmx_gmxx_txx_burst_s cn56xxp1;
+	struct cvmx_gmxx_txx_burst_s cn58xx;
+	struct cvmx_gmxx_txx_burst_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_cbfc_xoff {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_cbfc_xoff_s {
+		uint64_t reserved_16_63:48;
+		uint64_t xoff:16;
+	} s;
+	struct cvmx_gmxx_txx_cbfc_xoff_s cn52xx;
+	struct cvmx_gmxx_txx_cbfc_xoff_s cn56xx;
+};
+
+union cvmx_gmxx_txx_cbfc_xon {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_cbfc_xon_s {
+		uint64_t reserved_16_63:48;
+		uint64_t xon:16;
+	} s;
+	struct cvmx_gmxx_txx_cbfc_xon_s cn52xx;
+	struct cvmx_gmxx_txx_cbfc_xon_s cn56xx;
+};
+
+union cvmx_gmxx_txx_clk {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_clk_s {
+		uint64_t reserved_6_63:58;
+		uint64_t clk_cnt:6;
+	} s;
+	struct cvmx_gmxx_txx_clk_s cn30xx;
+	struct cvmx_gmxx_txx_clk_s cn31xx;
+	struct cvmx_gmxx_txx_clk_s cn38xx;
+	struct cvmx_gmxx_txx_clk_s cn38xxp2;
+	struct cvmx_gmxx_txx_clk_s cn50xx;
+	struct cvmx_gmxx_txx_clk_s cn58xx;
+	struct cvmx_gmxx_txx_clk_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t xsdef_en:1;
+		uint64_t xscol_en:1;
+	} s;
+	struct cvmx_gmxx_txx_ctl_s cn30xx;
+	struct cvmx_gmxx_txx_ctl_s cn31xx;
+	struct cvmx_gmxx_txx_ctl_s cn38xx;
+	struct cvmx_gmxx_txx_ctl_s cn38xxp2;
+	struct cvmx_gmxx_txx_ctl_s cn50xx;
+	struct cvmx_gmxx_txx_ctl_s cn52xx;
+	struct cvmx_gmxx_txx_ctl_s cn52xxp1;
+	struct cvmx_gmxx_txx_ctl_s cn56xx;
+	struct cvmx_gmxx_txx_ctl_s cn56xxp1;
+	struct cvmx_gmxx_txx_ctl_s cn58xx;
+	struct cvmx_gmxx_txx_ctl_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_min_pkt {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_min_pkt_s {
+		uint64_t reserved_8_63:56;
+		uint64_t min_size:8;
+	} s;
+	struct cvmx_gmxx_txx_min_pkt_s cn30xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn31xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn38xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn38xxp2;
+	struct cvmx_gmxx_txx_min_pkt_s cn50xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn52xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn52xxp1;
+	struct cvmx_gmxx_txx_min_pkt_s cn56xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn56xxp1;
+	struct cvmx_gmxx_txx_min_pkt_s cn58xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_pause_pkt_interval {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s {
+		uint64_t reserved_16_63:48;
+		uint64_t interval:16;
+	} s;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn30xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn31xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn38xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn38xxp2;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn50xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn52xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn52xxp1;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn56xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn56xxp1;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn58xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_pause_pkt_time {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_pause_pkt_time_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn30xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn31xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn38xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn38xxp2;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn50xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn52xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn52xxp1;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn56xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn56xxp1;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn58xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_pause_togo {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_pause_togo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t msg_time:16;
+		uint64_t time:16;
+	} s;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} cn30xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn31xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn38xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn38xxp2;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn50xx;
+	struct cvmx_gmxx_txx_pause_togo_s cn52xx;
+	struct cvmx_gmxx_txx_pause_togo_s cn52xxp1;
+	struct cvmx_gmxx_txx_pause_togo_s cn56xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn56xxp1;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn58xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn58xxp1;
+};
+
+union cvmx_gmxx_txx_pause_zero {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_pause_zero_s {
+		uint64_t reserved_1_63:63;
+		uint64_t send:1;
+	} s;
+	struct cvmx_gmxx_txx_pause_zero_s cn30xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn31xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn38xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn38xxp2;
+	struct cvmx_gmxx_txx_pause_zero_s cn50xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn52xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn52xxp1;
+	struct cvmx_gmxx_txx_pause_zero_s cn56xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn56xxp1;
+	struct cvmx_gmxx_txx_pause_zero_s cn58xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_sgmii_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_sgmii_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t align:1;
+	} s;
+	struct cvmx_gmxx_txx_sgmii_ctl_s cn52xx;
+	struct cvmx_gmxx_txx_sgmii_ctl_s cn52xxp1;
+	struct cvmx_gmxx_txx_sgmii_ctl_s cn56xx;
+	struct cvmx_gmxx_txx_sgmii_ctl_s cn56xxp1;
+};
+
+union cvmx_gmxx_txx_slot {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_slot_s {
+		uint64_t reserved_10_63:54;
+		uint64_t slot:10;
+	} s;
+	struct cvmx_gmxx_txx_slot_s cn30xx;
+	struct cvmx_gmxx_txx_slot_s cn31xx;
+	struct cvmx_gmxx_txx_slot_s cn38xx;
+	struct cvmx_gmxx_txx_slot_s cn38xxp2;
+	struct cvmx_gmxx_txx_slot_s cn50xx;
+	struct cvmx_gmxx_txx_slot_s cn52xx;
+	struct cvmx_gmxx_txx_slot_s cn52xxp1;
+	struct cvmx_gmxx_txx_slot_s cn56xx;
+	struct cvmx_gmxx_txx_slot_s cn56xxp1;
+	struct cvmx_gmxx_txx_slot_s cn58xx;
+	struct cvmx_gmxx_txx_slot_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_soft_pause {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_soft_pause_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_gmxx_txx_soft_pause_s cn30xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn31xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn38xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn38xxp2;
+	struct cvmx_gmxx_txx_soft_pause_s cn50xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn52xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn52xxp1;
+	struct cvmx_gmxx_txx_soft_pause_s cn56xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn56xxp1;
+	struct cvmx_gmxx_txx_soft_pause_s cn58xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat0 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat0_s {
+		uint64_t xsdef:32;
+		uint64_t xscol:32;
+	} s;
+	struct cvmx_gmxx_txx_stat0_s cn30xx;
+	struct cvmx_gmxx_txx_stat0_s cn31xx;
+	struct cvmx_gmxx_txx_stat0_s cn38xx;
+	struct cvmx_gmxx_txx_stat0_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat0_s cn50xx;
+	struct cvmx_gmxx_txx_stat0_s cn52xx;
+	struct cvmx_gmxx_txx_stat0_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat0_s cn56xx;
+	struct cvmx_gmxx_txx_stat0_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat0_s cn58xx;
+	struct cvmx_gmxx_txx_stat0_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat1 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat1_s {
+		uint64_t scol:32;
+		uint64_t mcol:32;
+	} s;
+	struct cvmx_gmxx_txx_stat1_s cn30xx;
+	struct cvmx_gmxx_txx_stat1_s cn31xx;
+	struct cvmx_gmxx_txx_stat1_s cn38xx;
+	struct cvmx_gmxx_txx_stat1_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat1_s cn50xx;
+	struct cvmx_gmxx_txx_stat1_s cn52xx;
+	struct cvmx_gmxx_txx_stat1_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat1_s cn56xx;
+	struct cvmx_gmxx_txx_stat1_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat1_s cn58xx;
+	struct cvmx_gmxx_txx_stat1_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat2 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat2_s {
+		uint64_t reserved_48_63:16;
+		uint64_t octs:48;
+	} s;
+	struct cvmx_gmxx_txx_stat2_s cn30xx;
+	struct cvmx_gmxx_txx_stat2_s cn31xx;
+	struct cvmx_gmxx_txx_stat2_s cn38xx;
+	struct cvmx_gmxx_txx_stat2_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat2_s cn50xx;
+	struct cvmx_gmxx_txx_stat2_s cn52xx;
+	struct cvmx_gmxx_txx_stat2_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat2_s cn56xx;
+	struct cvmx_gmxx_txx_stat2_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat2_s cn58xx;
+	struct cvmx_gmxx_txx_stat2_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat3 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pkts:32;
+	} s;
+	struct cvmx_gmxx_txx_stat3_s cn30xx;
+	struct cvmx_gmxx_txx_stat3_s cn31xx;
+	struct cvmx_gmxx_txx_stat3_s cn38xx;
+	struct cvmx_gmxx_txx_stat3_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat3_s cn50xx;
+	struct cvmx_gmxx_txx_stat3_s cn52xx;
+	struct cvmx_gmxx_txx_stat3_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat3_s cn56xx;
+	struct cvmx_gmxx_txx_stat3_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat3_s cn58xx;
+	struct cvmx_gmxx_txx_stat3_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat4 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat4_s {
+		uint64_t hist1:32;
+		uint64_t hist0:32;
+	} s;
+	struct cvmx_gmxx_txx_stat4_s cn30xx;
+	struct cvmx_gmxx_txx_stat4_s cn31xx;
+	struct cvmx_gmxx_txx_stat4_s cn38xx;
+	struct cvmx_gmxx_txx_stat4_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat4_s cn50xx;
+	struct cvmx_gmxx_txx_stat4_s cn52xx;
+	struct cvmx_gmxx_txx_stat4_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat4_s cn56xx;
+	struct cvmx_gmxx_txx_stat4_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat4_s cn58xx;
+	struct cvmx_gmxx_txx_stat4_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat5 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat5_s {
+		uint64_t hist3:32;
+		uint64_t hist2:32;
+	} s;
+	struct cvmx_gmxx_txx_stat5_s cn30xx;
+	struct cvmx_gmxx_txx_stat5_s cn31xx;
+	struct cvmx_gmxx_txx_stat5_s cn38xx;
+	struct cvmx_gmxx_txx_stat5_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat5_s cn50xx;
+	struct cvmx_gmxx_txx_stat5_s cn52xx;
+	struct cvmx_gmxx_txx_stat5_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat5_s cn56xx;
+	struct cvmx_gmxx_txx_stat5_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat5_s cn58xx;
+	struct cvmx_gmxx_txx_stat5_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat6 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat6_s {
+		uint64_t hist5:32;
+		uint64_t hist4:32;
+	} s;
+	struct cvmx_gmxx_txx_stat6_s cn30xx;
+	struct cvmx_gmxx_txx_stat6_s cn31xx;
+	struct cvmx_gmxx_txx_stat6_s cn38xx;
+	struct cvmx_gmxx_txx_stat6_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat6_s cn50xx;
+	struct cvmx_gmxx_txx_stat6_s cn52xx;
+	struct cvmx_gmxx_txx_stat6_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat6_s cn56xx;
+	struct cvmx_gmxx_txx_stat6_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat6_s cn58xx;
+	struct cvmx_gmxx_txx_stat6_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat7 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat7_s {
+		uint64_t hist7:32;
+		uint64_t hist6:32;
+	} s;
+	struct cvmx_gmxx_txx_stat7_s cn30xx;
+	struct cvmx_gmxx_txx_stat7_s cn31xx;
+	struct cvmx_gmxx_txx_stat7_s cn38xx;
+	struct cvmx_gmxx_txx_stat7_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat7_s cn50xx;
+	struct cvmx_gmxx_txx_stat7_s cn52xx;
+	struct cvmx_gmxx_txx_stat7_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat7_s cn56xx;
+	struct cvmx_gmxx_txx_stat7_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat7_s cn58xx;
+	struct cvmx_gmxx_txx_stat7_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat8 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat8_s {
+		uint64_t mcst:32;
+		uint64_t bcst:32;
+	} s;
+	struct cvmx_gmxx_txx_stat8_s cn30xx;
+	struct cvmx_gmxx_txx_stat8_s cn31xx;
+	struct cvmx_gmxx_txx_stat8_s cn38xx;
+	struct cvmx_gmxx_txx_stat8_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat8_s cn50xx;
+	struct cvmx_gmxx_txx_stat8_s cn52xx;
+	struct cvmx_gmxx_txx_stat8_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat8_s cn56xx;
+	struct cvmx_gmxx_txx_stat8_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat8_s cn58xx;
+	struct cvmx_gmxx_txx_stat8_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stat9 {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat9_s {
+		uint64_t undflw:32;
+		uint64_t ctl:32;
+	} s;
+	struct cvmx_gmxx_txx_stat9_s cn30xx;
+	struct cvmx_gmxx_txx_stat9_s cn31xx;
+	struct cvmx_gmxx_txx_stat9_s cn38xx;
+	struct cvmx_gmxx_txx_stat9_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat9_s cn50xx;
+	struct cvmx_gmxx_txx_stat9_s cn52xx;
+	struct cvmx_gmxx_txx_stat9_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat9_s cn56xx;
+	struct cvmx_gmxx_txx_stat9_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat9_s cn58xx;
+	struct cvmx_gmxx_txx_stat9_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_stats_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stats_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rd_clr:1;
+	} s;
+	struct cvmx_gmxx_txx_stats_ctl_s cn30xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn31xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn38xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn38xxp2;
+	struct cvmx_gmxx_txx_stats_ctl_s cn50xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn52xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn52xxp1;
+	struct cvmx_gmxx_txx_stats_ctl_s cn56xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn56xxp1;
+	struct cvmx_gmxx_txx_stats_ctl_s cn58xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn58xxp1;
+};
+
+union cvmx_gmxx_txx_thresh {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_thresh_s {
+		uint64_t reserved_9_63:55;
+		uint64_t cnt:9;
+	} s;
+	struct cvmx_gmxx_txx_thresh_cn30xx {
+		uint64_t reserved_7_63:57;
+		uint64_t cnt:7;
+	} cn30xx;
+	struct cvmx_gmxx_txx_thresh_cn30xx cn31xx;
+	struct cvmx_gmxx_txx_thresh_s cn38xx;
+	struct cvmx_gmxx_txx_thresh_s cn38xxp2;
+	struct cvmx_gmxx_txx_thresh_cn30xx cn50xx;
+	struct cvmx_gmxx_txx_thresh_s cn52xx;
+	struct cvmx_gmxx_txx_thresh_s cn52xxp1;
+	struct cvmx_gmxx_txx_thresh_s cn56xx;
+	struct cvmx_gmxx_txx_thresh_s cn56xxp1;
+	struct cvmx_gmxx_txx_thresh_s cn58xx;
+	struct cvmx_gmxx_txx_thresh_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_bp {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_bp_s {
+		uint64_t reserved_4_63:60;
+		uint64_t bp:4;
+	} s;
+	struct cvmx_gmxx_tx_bp_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t bp:3;
+	} cn30xx;
+	struct cvmx_gmxx_tx_bp_cn30xx cn31xx;
+	struct cvmx_gmxx_tx_bp_s cn38xx;
+	struct cvmx_gmxx_tx_bp_s cn38xxp2;
+	struct cvmx_gmxx_tx_bp_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_bp_s cn52xx;
+	struct cvmx_gmxx_tx_bp_s cn52xxp1;
+	struct cvmx_gmxx_tx_bp_s cn56xx;
+	struct cvmx_gmxx_tx_bp_s cn56xxp1;
+	struct cvmx_gmxx_tx_bp_s cn58xx;
+	struct cvmx_gmxx_tx_bp_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_clk_mskx {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_clk_mskx_s {
+		uint64_t reserved_1_63:63;
+		uint64_t msk:1;
+	} s;
+	struct cvmx_gmxx_tx_clk_mskx_s cn30xx;
+	struct cvmx_gmxx_tx_clk_mskx_s cn50xx;
+};
+
+union cvmx_gmxx_tx_col_attempt {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_col_attempt_s {
+		uint64_t reserved_5_63:59;
+		uint64_t limit:5;
+	} s;
+	struct cvmx_gmxx_tx_col_attempt_s cn30xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn31xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn38xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn38xxp2;
+	struct cvmx_gmxx_tx_col_attempt_s cn50xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn52xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn52xxp1;
+	struct cvmx_gmxx_tx_col_attempt_s cn56xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn56xxp1;
+	struct cvmx_gmxx_tx_col_attempt_s cn58xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_corrupt {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_corrupt_s {
+		uint64_t reserved_4_63:60;
+		uint64_t corrupt:4;
+	} s;
+	struct cvmx_gmxx_tx_corrupt_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t corrupt:3;
+	} cn30xx;
+	struct cvmx_gmxx_tx_corrupt_cn30xx cn31xx;
+	struct cvmx_gmxx_tx_corrupt_s cn38xx;
+	struct cvmx_gmxx_tx_corrupt_s cn38xxp2;
+	struct cvmx_gmxx_tx_corrupt_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_corrupt_s cn52xx;
+	struct cvmx_gmxx_tx_corrupt_s cn52xxp1;
+	struct cvmx_gmxx_tx_corrupt_s cn56xx;
+	struct cvmx_gmxx_tx_corrupt_s cn56xxp1;
+	struct cvmx_gmxx_tx_corrupt_s cn58xx;
+	struct cvmx_gmxx_tx_corrupt_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_hg2_reg1 {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_hg2_reg1_s {
+		uint64_t reserved_16_63:48;
+		uint64_t tx_xof:16;
+	} s;
+	struct cvmx_gmxx_tx_hg2_reg1_s cn52xx;
+	struct cvmx_gmxx_tx_hg2_reg1_s cn52xxp1;
+	struct cvmx_gmxx_tx_hg2_reg1_s cn56xx;
+};
+
+union cvmx_gmxx_tx_hg2_reg2 {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_hg2_reg2_s {
+		uint64_t reserved_16_63:48;
+		uint64_t tx_xon:16;
+	} s;
+	struct cvmx_gmxx_tx_hg2_reg2_s cn52xx;
+	struct cvmx_gmxx_tx_hg2_reg2_s cn52xxp1;
+	struct cvmx_gmxx_tx_hg2_reg2_s cn56xx;
+};
+
+union cvmx_gmxx_tx_ifg {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_ifg_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ifg2:4;
+		uint64_t ifg1:4;
+	} s;
+	struct cvmx_gmxx_tx_ifg_s cn30xx;
+	struct cvmx_gmxx_tx_ifg_s cn31xx;
+	struct cvmx_gmxx_tx_ifg_s cn38xx;
+	struct cvmx_gmxx_tx_ifg_s cn38xxp2;
+	struct cvmx_gmxx_tx_ifg_s cn50xx;
+	struct cvmx_gmxx_tx_ifg_s cn52xx;
+	struct cvmx_gmxx_tx_ifg_s cn52xxp1;
+	struct cvmx_gmxx_tx_ifg_s cn56xx;
+	struct cvmx_gmxx_tx_ifg_s cn56xxp1;
+	struct cvmx_gmxx_tx_ifg_s cn58xx;
+	struct cvmx_gmxx_tx_ifg_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_int_en {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_int_en_s {
+		uint64_t reserved_20_63:44;
+		uint64_t late_col:4;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t ncb_nxa:1;
+		uint64_t pko_nxa:1;
+	} s;
+	struct cvmx_gmxx_tx_int_en_cn30xx {
+		uint64_t reserved_19_63:45;
+		uint64_t late_col:3;
+		uint64_t reserved_15_15:1;
+		uint64_t xsdef:3;
+		uint64_t reserved_11_11:1;
+		uint64_t xscol:3;
+		uint64_t reserved_5_7:3;
+		uint64_t undflw:3;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn30xx;
+	struct cvmx_gmxx_tx_int_en_cn31xx {
+		uint64_t reserved_15_63:49;
+		uint64_t xsdef:3;
+		uint64_t reserved_11_11:1;
+		uint64_t xscol:3;
+		uint64_t reserved_5_7:3;
+		uint64_t undflw:3;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn31xx;
+	struct cvmx_gmxx_tx_int_en_s cn38xx;
+	struct cvmx_gmxx_tx_int_en_cn38xxp2 {
+		uint64_t reserved_16_63:48;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t ncb_nxa:1;
+		uint64_t pko_nxa:1;
+	} cn38xxp2;
+	struct cvmx_gmxx_tx_int_en_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_int_en_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t late_col:4;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn52xx;
+	struct cvmx_gmxx_tx_int_en_cn52xx cn52xxp1;
+	struct cvmx_gmxx_tx_int_en_cn52xx cn56xx;
+	struct cvmx_gmxx_tx_int_en_cn52xx cn56xxp1;
+	struct cvmx_gmxx_tx_int_en_s cn58xx;
+	struct cvmx_gmxx_tx_int_en_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_int_reg {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_int_reg_s {
+		uint64_t reserved_20_63:44;
+		uint64_t late_col:4;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t ncb_nxa:1;
+		uint64_t pko_nxa:1;
+	} s;
+	struct cvmx_gmxx_tx_int_reg_cn30xx {
+		uint64_t reserved_19_63:45;
+		uint64_t late_col:3;
+		uint64_t reserved_15_15:1;
+		uint64_t xsdef:3;
+		uint64_t reserved_11_11:1;
+		uint64_t xscol:3;
+		uint64_t reserved_5_7:3;
+		uint64_t undflw:3;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn30xx;
+	struct cvmx_gmxx_tx_int_reg_cn31xx {
+		uint64_t reserved_15_63:49;
+		uint64_t xsdef:3;
+		uint64_t reserved_11_11:1;
+		uint64_t xscol:3;
+		uint64_t reserved_5_7:3;
+		uint64_t undflw:3;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn31xx;
+	struct cvmx_gmxx_tx_int_reg_s cn38xx;
+	struct cvmx_gmxx_tx_int_reg_cn38xxp2 {
+		uint64_t reserved_16_63:48;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t ncb_nxa:1;
+		uint64_t pko_nxa:1;
+	} cn38xxp2;
+	struct cvmx_gmxx_tx_int_reg_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_int_reg_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t late_col:4;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn52xx;
+	struct cvmx_gmxx_tx_int_reg_cn52xx cn52xxp1;
+	struct cvmx_gmxx_tx_int_reg_cn52xx cn56xx;
+	struct cvmx_gmxx_tx_int_reg_cn52xx cn56xxp1;
+	struct cvmx_gmxx_tx_int_reg_s cn58xx;
+	struct cvmx_gmxx_tx_int_reg_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_jam {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_jam_s {
+		uint64_t reserved_8_63:56;
+		uint64_t jam:8;
+	} s;
+	struct cvmx_gmxx_tx_jam_s cn30xx;
+	struct cvmx_gmxx_tx_jam_s cn31xx;
+	struct cvmx_gmxx_tx_jam_s cn38xx;
+	struct cvmx_gmxx_tx_jam_s cn38xxp2;
+	struct cvmx_gmxx_tx_jam_s cn50xx;
+	struct cvmx_gmxx_tx_jam_s cn52xx;
+	struct cvmx_gmxx_tx_jam_s cn52xxp1;
+	struct cvmx_gmxx_tx_jam_s cn56xx;
+	struct cvmx_gmxx_tx_jam_s cn56xxp1;
+	struct cvmx_gmxx_tx_jam_s cn58xx;
+	struct cvmx_gmxx_tx_jam_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_lfsr {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_lfsr_s {
+		uint64_t reserved_16_63:48;
+		uint64_t lfsr:16;
+	} s;
+	struct cvmx_gmxx_tx_lfsr_s cn30xx;
+	struct cvmx_gmxx_tx_lfsr_s cn31xx;
+	struct cvmx_gmxx_tx_lfsr_s cn38xx;
+	struct cvmx_gmxx_tx_lfsr_s cn38xxp2;
+	struct cvmx_gmxx_tx_lfsr_s cn50xx;
+	struct cvmx_gmxx_tx_lfsr_s cn52xx;
+	struct cvmx_gmxx_tx_lfsr_s cn52xxp1;
+	struct cvmx_gmxx_tx_lfsr_s cn56xx;
+	struct cvmx_gmxx_tx_lfsr_s cn56xxp1;
+	struct cvmx_gmxx_tx_lfsr_s cn58xx;
+	struct cvmx_gmxx_tx_lfsr_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_ovr_bp {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_ovr_bp_s {
+		uint64_t reserved_48_63:16;
+		uint64_t tx_prt_bp:16;
+		uint64_t reserved_12_31:20;
+		uint64_t en:4;
+		uint64_t bp:4;
+		uint64_t ign_full:4;
+	} s;
+	struct cvmx_gmxx_tx_ovr_bp_cn30xx {
+		uint64_t reserved_11_63:53;
+		uint64_t en:3;
+		uint64_t reserved_7_7:1;
+		uint64_t bp:3;
+		uint64_t reserved_3_3:1;
+		uint64_t ign_full:3;
+	} cn30xx;
+	struct cvmx_gmxx_tx_ovr_bp_cn30xx cn31xx;
+	struct cvmx_gmxx_tx_ovr_bp_cn38xx {
+		uint64_t reserved_12_63:52;
+		uint64_t en:4;
+		uint64_t bp:4;
+		uint64_t ign_full:4;
+	} cn38xx;
+	struct cvmx_gmxx_tx_ovr_bp_cn38xx cn38xxp2;
+	struct cvmx_gmxx_tx_ovr_bp_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_ovr_bp_s cn52xx;
+	struct cvmx_gmxx_tx_ovr_bp_s cn52xxp1;
+	struct cvmx_gmxx_tx_ovr_bp_s cn56xx;
+	struct cvmx_gmxx_tx_ovr_bp_s cn56xxp1;
+	struct cvmx_gmxx_tx_ovr_bp_cn38xx cn58xx;
+	struct cvmx_gmxx_tx_ovr_bp_cn38xx cn58xxp1;
+};
+
+union cvmx_gmxx_tx_pause_pkt_dmac {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s {
+		uint64_t reserved_48_63:16;
+		uint64_t dmac:48;
+	} s;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn30xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn31xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn38xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn38xxp2;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn50xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn52xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn52xxp1;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn56xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn56xxp1;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn58xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_pause_pkt_type {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_pause_pkt_type_s {
+		uint64_t reserved_16_63:48;
+		uint64_t type:16;
+	} s;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn30xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn31xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn38xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn38xxp2;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn50xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn52xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn52xxp1;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn56xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn56xxp1;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn58xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_prts {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_prts_s {
+		uint64_t reserved_5_63:59;
+		uint64_t prts:5;
+	} s;
+	struct cvmx_gmxx_tx_prts_s cn30xx;
+	struct cvmx_gmxx_tx_prts_s cn31xx;
+	struct cvmx_gmxx_tx_prts_s cn38xx;
+	struct cvmx_gmxx_tx_prts_s cn38xxp2;
+	struct cvmx_gmxx_tx_prts_s cn50xx;
+	struct cvmx_gmxx_tx_prts_s cn52xx;
+	struct cvmx_gmxx_tx_prts_s cn52xxp1;
+	struct cvmx_gmxx_tx_prts_s cn56xx;
+	struct cvmx_gmxx_tx_prts_s cn56xxp1;
+	struct cvmx_gmxx_tx_prts_s cn58xx;
+	struct cvmx_gmxx_tx_prts_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_spi_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t tpa_clr:1;
+		uint64_t cont_pkt:1;
+	} s;
+	struct cvmx_gmxx_tx_spi_ctl_s cn38xx;
+	struct cvmx_gmxx_tx_spi_ctl_s cn38xxp2;
+	struct cvmx_gmxx_tx_spi_ctl_s cn58xx;
+	struct cvmx_gmxx_tx_spi_ctl_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_spi_drain {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_drain_s {
+		uint64_t reserved_16_63:48;
+		uint64_t drain:16;
+	} s;
+	struct cvmx_gmxx_tx_spi_drain_s cn38xx;
+	struct cvmx_gmxx_tx_spi_drain_s cn58xx;
+	struct cvmx_gmxx_tx_spi_drain_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_spi_max {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_max_s {
+		uint64_t reserved_23_63:41;
+		uint64_t slice:7;
+		uint64_t max2:8;
+		uint64_t max1:8;
+	} s;
+	struct cvmx_gmxx_tx_spi_max_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t max2:8;
+		uint64_t max1:8;
+	} cn38xx;
+	struct cvmx_gmxx_tx_spi_max_cn38xx cn38xxp2;
+	struct cvmx_gmxx_tx_spi_max_s cn58xx;
+	struct cvmx_gmxx_tx_spi_max_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_spi_roundx {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_roundx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t round:16;
+	} s;
+	struct cvmx_gmxx_tx_spi_roundx_s cn58xx;
+	struct cvmx_gmxx_tx_spi_roundx_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_spi_thresh {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_thresh_s {
+		uint64_t reserved_6_63:58;
+		uint64_t thresh:6;
+	} s;
+	struct cvmx_gmxx_tx_spi_thresh_s cn38xx;
+	struct cvmx_gmxx_tx_spi_thresh_s cn38xxp2;
+	struct cvmx_gmxx_tx_spi_thresh_s cn58xx;
+	struct cvmx_gmxx_tx_spi_thresh_s cn58xxp1;
+};
+
+union cvmx_gmxx_tx_xaui_ctl {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_xaui_ctl_s {
+		uint64_t reserved_11_63:53;
+		uint64_t hg_pause_hgi:2;
+		uint64_t hg_en:1;
+		uint64_t reserved_7_7:1;
+		uint64_t ls_byp:1;
+		uint64_t ls:2;
+		uint64_t reserved_2_3:2;
+		uint64_t uni_en:1;
+		uint64_t dic_en:1;
+	} s;
+	struct cvmx_gmxx_tx_xaui_ctl_s cn52xx;
+	struct cvmx_gmxx_tx_xaui_ctl_s cn52xxp1;
+	struct cvmx_gmxx_tx_xaui_ctl_s cn56xx;
+	struct cvmx_gmxx_tx_xaui_ctl_s cn56xxp1;
+};
+
+union cvmx_gmxx_xaui_ext_loopback {
+	uint64_t u64;
+	struct cvmx_gmxx_xaui_ext_loopback_s {
+		uint64_t reserved_5_63:59;
+		uint64_t en:1;
+		uint64_t thresh:4;
+	} s;
+	struct cvmx_gmxx_xaui_ext_loopback_s cn52xx;
+	struct cvmx_gmxx_xaui_ext_loopback_s cn52xxp1;
+	struct cvmx_gmxx_xaui_ext_loopback_s cn56xx;
+	struct cvmx_gmxx_xaui_ext_loopback_s cn56xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-helper-board.c b/drivers/staging/octeon/cvmx-helper-board.c
new file mode 100644
index 0000000..3085e38
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-board.c
@@ -0,0 +1,706 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * Helper functions to abstract board specific data about
+ * network ports from the rest of the cvmx-helper files.
+ */
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootinfo.h>
+
+#include "cvmx-config.h"
+
+#include "cvmx-mdio.h"
+
+#include "cvmx-helper.h"
+#include "cvmx-helper-util.h"
+#include "cvmx-helper-board.h"
+
+#include "cvmx-gmxx-defs.h"
+#include "cvmx-asxx-defs.h"
+
+/**
+ * cvmx_override_board_link_get(int ipd_port) is a function
+ * pointer. It is meant to allow customization of the process of
+ * talking to a PHY to determine link speed. It is called every
+ * time a PHY must be polled for link status. Users should set
+ * this pointer to a function before calling any cvmx-helper
+ * operations.
+ */
+cvmx_helper_link_info_t(*cvmx_override_board_link_get) (int ipd_port) =
+    NULL;
+
+/**
+ * Return the MII PHY address associated with the given IPD
+ * port. A result of -1 means there isn't a MII capable PHY
+ * connected to this port. On chips supporting multiple MII
+ * busses the bus number is encoded in bits <15:8>.
+ *
+ * This function must be modified for every new Octeon board.
+ * Internally it uses switch statements based on the cvmx_sysinfo
+ * data to determine board types and revisions. It replies on the
+ * fact that every Octeon board receives a unique board type
+ * enumeration from the bootloader.
+ *
+ * @ipd_port: Octeon IPD port to get the MII address for.
+ *
+ * Returns MII PHY address and bus number or -1.
+ */
+int cvmx_helper_board_get_mii_address(int ipd_port)
+{
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_SIM:
+		/* Simulator doesn't have MII */
+		return -1;
+	case CVMX_BOARD_TYPE_EBT3000:
+	case CVMX_BOARD_TYPE_EBT5800:
+	case CVMX_BOARD_TYPE_THUNDER:
+	case CVMX_BOARD_TYPE_NICPRO2:
+		/* Interface 0 is SPI4, interface 1 is RGMII */
+		if ((ipd_port >= 16) && (ipd_port < 20))
+			return ipd_port - 16;
+		else
+			return -1;
+	case CVMX_BOARD_TYPE_KODAMA:
+	case CVMX_BOARD_TYPE_EBH3100:
+	case CVMX_BOARD_TYPE_HIKARI:
+	case CVMX_BOARD_TYPE_CN3010_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3020_EVB_HS5:
+		/*
+		 * Port 0 is WAN connected to a PHY, Port 1 is GMII
+		 * connected to a switch
+		 */
+		if (ipd_port == 0)
+			return 4;
+		else if (ipd_port == 1)
+			return 9;
+		else
+			return -1;
+	case CVMX_BOARD_TYPE_NAC38:
+		/* Board has 8 RGMII ports PHYs are 0-7 */
+		if ((ipd_port >= 0) && (ipd_port < 4))
+			return ipd_port;
+		else if ((ipd_port >= 16) && (ipd_port < 20))
+			return ipd_port - 16 + 4;
+		else
+			return -1;
+	case CVMX_BOARD_TYPE_EBH3000:
+		/* Board has dual SPI4 and no PHYs */
+		return -1;
+	case CVMX_BOARD_TYPE_EBH5200:
+	case CVMX_BOARD_TYPE_EBH5201:
+	case CVMX_BOARD_TYPE_EBT5200:
+		/*
+		 * Board has 4 SGMII ports. The PHYs start right after the MII
+		 * ports MII0 = 0, MII1 = 1, SGMII = 2-5.
+		 */
+		if ((ipd_port >= 0) && (ipd_port < 4))
+			return ipd_port + 2;
+		else
+			return -1;
+	case CVMX_BOARD_TYPE_EBH5600:
+	case CVMX_BOARD_TYPE_EBH5601:
+	case CVMX_BOARD_TYPE_EBH5610:
+		/*
+		 * Board has 8 SGMII ports. 4 connect out, two connect
+		 * to a switch, and 2 loop to each other
+		 */
+		if ((ipd_port >= 0) && (ipd_port < 4))
+			return ipd_port + 1;
+		else
+			return -1;
+	case CVMX_BOARD_TYPE_CUST_NB5:
+		if (ipd_port == 2)
+			return 4;
+		else
+			return -1;
+	case CVMX_BOARD_TYPE_NIC_XLE_4G:
+		/* Board has 4 SGMII ports. connected QLM3(interface 1) */
+		if ((ipd_port >= 16) && (ipd_port < 20))
+			return ipd_port - 16 + 1;
+		else
+			return -1;
+	case CVMX_BOARD_TYPE_BBGW_REF:
+		/*
+		 * No PHYs are connected to Octeon, everything is
+		 * through switch.
+		 */
+		return -1;
+	}
+
+	/* Some unknown board. Somebody forgot to update this function... */
+	cvmx_dprintf
+	    ("cvmx_helper_board_get_mii_address: Unknown board type %d\n",
+	     cvmx_sysinfo_get()->board_type);
+	return -1;
+}
+
+/**
+ * This function is the board specific method of determining an
+ * ethernet ports link speed. Most Octeon boards have Marvell PHYs
+ * and are handled by the fall through case. This function must be
+ * updated for boards that don't have the normal Marvell PHYs.
+ *
+ * This function must be modified for every new Octeon board.
+ * Internally it uses switch statements based on the cvmx_sysinfo
+ * data to determine board types and revisions. It relies on the
+ * fact that every Octeon board receives a unique board type
+ * enumeration from the bootloader.
+ *
+ * @ipd_port: IPD input port associated with the port we want to get link
+ *                 status for.
+ *
+ * Returns The ports link status. If the link isn't fully resolved, this must
+ *         return zero.
+ */
+cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
+{
+	cvmx_helper_link_info_t result;
+	int phy_addr;
+	int is_broadcom_phy = 0;
+
+	/* Give the user a chance to override the processing of this function */
+	if (cvmx_override_board_link_get)
+		return cvmx_override_board_link_get(ipd_port);
+
+	/* Unless we fix it later, all links are defaulted to down */
+	result.u64 = 0;
+
+	/*
+	 * This switch statement should handle all ports that either don't use
+	 * Marvell PHYS, or don't support in-band status.
+	 */
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_SIM:
+		/* The simulator gives you a simulated 1Gbps full duplex link */
+		result.s.link_up = 1;
+		result.s.full_duplex = 1;
+		result.s.speed = 1000;
+		return result;
+	case CVMX_BOARD_TYPE_EBH3100:
+	case CVMX_BOARD_TYPE_CN3010_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3020_EVB_HS5:
+		/* Port 1 on these boards is always Gigabit */
+		if (ipd_port == 1) {
+			result.s.link_up = 1;
+			result.s.full_duplex = 1;
+			result.s.speed = 1000;
+			return result;
+		}
+		/* Fall through to the generic code below */
+		break;
+	case CVMX_BOARD_TYPE_CUST_NB5:
+		/* Port 1 on these boards is always Gigabit */
+		if (ipd_port == 1) {
+			result.s.link_up = 1;
+			result.s.full_duplex = 1;
+			result.s.speed = 1000;
+			return result;
+		} else		/* The other port uses a broadcom PHY */
+			is_broadcom_phy = 1;
+		break;
+	case CVMX_BOARD_TYPE_BBGW_REF:
+		/* Port 1 on these boards is always Gigabit */
+		if (ipd_port == 2) {
+			/* Port 2 is not hooked up */
+			result.u64 = 0;
+			return result;
+		} else {
+			/* Ports 0 and 1 connect to the switch */
+			result.s.link_up = 1;
+			result.s.full_duplex = 1;
+			result.s.speed = 1000;
+			return result;
+		}
+		break;
+	}
+
+	phy_addr = cvmx_helper_board_get_mii_address(ipd_port);
+	if (phy_addr != -1) {
+		if (is_broadcom_phy) {
+			/*
+			 * Below we are going to read SMI/MDIO
+			 * register 0x19 which works on Broadcom
+			 * parts
+			 */
+			int phy_status =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   0x19);
+			switch ((phy_status >> 8) & 0x7) {
+			case 0:
+				result.u64 = 0;
+				break;
+			case 1:
+				result.s.link_up = 1;
+				result.s.full_duplex = 0;
+				result.s.speed = 10;
+				break;
+			case 2:
+				result.s.link_up = 1;
+				result.s.full_duplex = 1;
+				result.s.speed = 10;
+				break;
+			case 3:
+				result.s.link_up = 1;
+				result.s.full_duplex = 0;
+				result.s.speed = 100;
+				break;
+			case 4:
+				result.s.link_up = 1;
+				result.s.full_duplex = 1;
+				result.s.speed = 100;
+				break;
+			case 5:
+				result.s.link_up = 1;
+				result.s.full_duplex = 1;
+				result.s.speed = 100;
+				break;
+			case 6:
+				result.s.link_up = 1;
+				result.s.full_duplex = 0;
+				result.s.speed = 1000;
+				break;
+			case 7:
+				result.s.link_up = 1;
+				result.s.full_duplex = 1;
+				result.s.speed = 1000;
+				break;
+			}
+		} else {
+			/*
+			 * This code assumes we are using a Marvell
+			 * Gigabit PHY. All the speed information can
+			 * be read from register 17 in one
+			 * go. Somebody using a different PHY will
+			 * need to handle it above in the board
+			 * specific area.
+			 */
+			int phy_status =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff, 17);
+
+			/*
+			 * If the resolve bit 11 isn't set, see if
+			 * autoneg is turned off (bit 12, reg 0). The
+			 * resolve bit doesn't get set properly when
+			 * autoneg is off, so force it.
+			 */
+			if ((phy_status & (1 << 11)) == 0) {
+				int auto_status =
+				    cvmx_mdio_read(phy_addr >> 8,
+						   phy_addr & 0xff, 0);
+				if ((auto_status & (1 << 12)) == 0)
+					phy_status |= 1 << 11;
+			}
+
+			/*
+			 * Only return a link if the PHY has finished
+			 * auto negotiation and set the resolved bit
+			 * (bit 11)
+			 */
+			if (phy_status & (1 << 11)) {
+				result.s.link_up = 1;
+				result.s.full_duplex = ((phy_status >> 13) & 1);
+				switch ((phy_status >> 14) & 3) {
+				case 0:	/* 10 Mbps */
+					result.s.speed = 10;
+					break;
+				case 1:	/* 100 Mbps */
+					result.s.speed = 100;
+					break;
+				case 2:	/* 1 Gbps */
+					result.s.speed = 1000;
+					break;
+				case 3:	/* Illegal */
+					result.u64 = 0;
+					break;
+				}
+			}
+		}
+	} else if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
+		   || OCTEON_IS_MODEL(OCTEON_CN58XX)
+		   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		/*
+		 * We don't have a PHY address, so attempt to use
+		 * in-band status. It is really important that boards
+		 * not supporting in-band status never get
+		 * here. Reading broken in-band status tends to do bad
+		 * things
+		 */
+		union cvmx_gmxx_rxx_rx_inbnd inband_status;
+		int interface = cvmx_helper_get_interface_num(ipd_port);
+		int index = cvmx_helper_get_interface_index_num(ipd_port);
+		inband_status.u64 =
+		    cvmx_read_csr(CVMX_GMXX_RXX_RX_INBND(index, interface));
+
+		result.s.link_up = inband_status.s.status;
+		result.s.full_duplex = inband_status.s.duplex;
+		switch (inband_status.s.speed) {
+		case 0:	/* 10 Mbps */
+			result.s.speed = 10;
+			break;
+		case 1:	/* 100 Mbps */
+			result.s.speed = 100;
+			break;
+		case 2:	/* 1 Gbps */
+			result.s.speed = 1000;
+			break;
+		case 3:	/* Illegal */
+			result.u64 = 0;
+			break;
+		}
+	} else {
+		/*
+		 * We don't have a PHY address and we don't have
+		 * in-band status. There is no way to determine the
+		 * link speed. Return down assuming this port isn't
+		 * wired
+		 */
+		result.u64 = 0;
+	}
+
+	/* If link is down, return all fields as zero. */
+	if (!result.s.link_up)
+		result.u64 = 0;
+
+	return result;
+}
+
+/**
+ * This function as a board specific method of changing the PHY
+ * speed, duplex, and auto-negotiation. This programs the PHY and
+ * not Octeon. This can be used to force Octeon's links to
+ * specific settings.
+ *
+ * @phy_addr:  The address of the PHY to program
+ * @enable_autoneg:
+ *                  Non zero if you want to enable auto-negotiation.
+ * @link_info: Link speed to program. If the speed is zero and auto-negotiation
+ *                  is enabled, all possible negotiation speeds are advertised.
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_helper_board_link_set_phy(int phy_addr,
+				   cvmx_helper_board_set_phy_link_flags_types_t
+				   link_flags,
+				   cvmx_helper_link_info_t link_info)
+{
+
+	/* Set the flow control settings based on link_flags */
+	if ((link_flags & set_phy_link_flags_flow_control_mask) !=
+	    set_phy_link_flags_flow_control_dont_touch) {
+		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
+		reg_autoneg_adver.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
+		reg_autoneg_adver.s.asymmetric_pause =
+		    (link_flags & set_phy_link_flags_flow_control_mask) ==
+		    set_phy_link_flags_flow_control_enable;
+		reg_autoneg_adver.s.pause =
+		    (link_flags & set_phy_link_flags_flow_control_mask) ==
+		    set_phy_link_flags_flow_control_enable;
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
+				reg_autoneg_adver.u16);
+	}
+
+	/* If speed isn't set and autoneg is on advertise all supported modes */
+	if ((link_flags & set_phy_link_flags_autoneg)
+	    && (link_info.s.speed == 0)) {
+		cvmx_mdio_phy_reg_control_t reg_control;
+		cvmx_mdio_phy_reg_status_t reg_status;
+		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
+		cvmx_mdio_phy_reg_extended_status_t reg_extended_status;
+		cvmx_mdio_phy_reg_control_1000_t reg_control_1000;
+
+		reg_status.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_STATUS);
+		reg_autoneg_adver.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
+		reg_autoneg_adver.s.advert_100base_t4 =
+		    reg_status.s.capable_100base_t4;
+		reg_autoneg_adver.s.advert_10base_tx_full =
+		    reg_status.s.capable_10_full;
+		reg_autoneg_adver.s.advert_10base_tx_half =
+		    reg_status.s.capable_10_half;
+		reg_autoneg_adver.s.advert_100base_tx_full =
+		    reg_status.s.capable_100base_x_full;
+		reg_autoneg_adver.s.advert_100base_tx_half =
+		    reg_status.s.capable_100base_x_half;
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
+				reg_autoneg_adver.u16);
+		if (reg_status.s.capable_extended_status) {
+			reg_extended_status.u16 =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   CVMX_MDIO_PHY_REG_EXTENDED_STATUS);
+			reg_control_1000.u16 =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   CVMX_MDIO_PHY_REG_CONTROL_1000);
+			reg_control_1000.s.advert_1000base_t_full =
+			    reg_extended_status.s.capable_1000base_t_full;
+			reg_control_1000.s.advert_1000base_t_half =
+			    reg_extended_status.s.capable_1000base_t_half;
+			cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+					CVMX_MDIO_PHY_REG_CONTROL_1000,
+					reg_control_1000.u16);
+		}
+		reg_control.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_CONTROL);
+		reg_control.s.autoneg_enable = 1;
+		reg_control.s.restart_autoneg = 1;
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
+	} else if ((link_flags & set_phy_link_flags_autoneg)) {
+		cvmx_mdio_phy_reg_control_t reg_control;
+		cvmx_mdio_phy_reg_status_t reg_status;
+		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
+		cvmx_mdio_phy_reg_extended_status_t reg_extended_status;
+		cvmx_mdio_phy_reg_control_1000_t reg_control_1000;
+
+		reg_status.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_STATUS);
+		reg_autoneg_adver.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
+		reg_autoneg_adver.s.advert_100base_t4 = 0;
+		reg_autoneg_adver.s.advert_10base_tx_full = 0;
+		reg_autoneg_adver.s.advert_10base_tx_half = 0;
+		reg_autoneg_adver.s.advert_100base_tx_full = 0;
+		reg_autoneg_adver.s.advert_100base_tx_half = 0;
+		if (reg_status.s.capable_extended_status) {
+			reg_extended_status.u16 =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   CVMX_MDIO_PHY_REG_EXTENDED_STATUS);
+			reg_control_1000.u16 =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   CVMX_MDIO_PHY_REG_CONTROL_1000);
+			reg_control_1000.s.advert_1000base_t_full = 0;
+			reg_control_1000.s.advert_1000base_t_half = 0;
+		}
+		switch (link_info.s.speed) {
+		case 10:
+			reg_autoneg_adver.s.advert_10base_tx_full =
+			    link_info.s.full_duplex;
+			reg_autoneg_adver.s.advert_10base_tx_half =
+			    !link_info.s.full_duplex;
+			break;
+		case 100:
+			reg_autoneg_adver.s.advert_100base_tx_full =
+			    link_info.s.full_duplex;
+			reg_autoneg_adver.s.advert_100base_tx_half =
+			    !link_info.s.full_duplex;
+			break;
+		case 1000:
+			reg_control_1000.s.advert_1000base_t_full =
+			    link_info.s.full_duplex;
+			reg_control_1000.s.advert_1000base_t_half =
+			    !link_info.s.full_duplex;
+			break;
+		}
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
+				reg_autoneg_adver.u16);
+		if (reg_status.s.capable_extended_status)
+			cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+					CVMX_MDIO_PHY_REG_CONTROL_1000,
+					reg_control_1000.u16);
+		reg_control.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_CONTROL);
+		reg_control.s.autoneg_enable = 1;
+		reg_control.s.restart_autoneg = 1;
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
+	} else {
+		cvmx_mdio_phy_reg_control_t reg_control;
+		reg_control.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_CONTROL);
+		reg_control.s.autoneg_enable = 0;
+		reg_control.s.restart_autoneg = 1;
+		reg_control.s.duplex = link_info.s.full_duplex;
+		if (link_info.s.speed == 1000) {
+			reg_control.s.speed_msb = 1;
+			reg_control.s.speed_lsb = 0;
+		} else if (link_info.s.speed == 100) {
+			reg_control.s.speed_msb = 0;
+			reg_control.s.speed_lsb = 1;
+		} else if (link_info.s.speed == 10) {
+			reg_control.s.speed_msb = 0;
+			reg_control.s.speed_lsb = 0;
+		}
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
+	}
+	return 0;
+}
+
+/**
+ * This function is called by cvmx_helper_interface_probe() after it
+ * determines the number of ports Octeon can support on a specific
+ * interface. This function is the per board location to override
+ * this value. It is called with the number of ports Octeon might
+ * support and should return the number of actual ports on the
+ * board.
+ *
+ * This function must be modifed for every new Octeon board.
+ * Internally it uses switch statements based on the cvmx_sysinfo
+ * data to determine board types and revisions. It relys on the
+ * fact that every Octeon board receives a unique board type
+ * enumeration from the bootloader.
+ *
+ * @interface: Interface to probe
+ * @supported_ports:
+ *                  Number of ports Octeon supports.
+ *
+ * Returns Number of ports the actual board supports. Many times this will
+ *         simple be "support_ports".
+ */
+int __cvmx_helper_board_interface_probe(int interface, int supported_ports)
+{
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
+		if (interface == 0)
+			return 2;
+		break;
+	case CVMX_BOARD_TYPE_BBGW_REF:
+		if (interface == 0)
+			return 2;
+		break;
+	case CVMX_BOARD_TYPE_NIC_XLE_4G:
+		if (interface == 0)
+			return 0;
+		break;
+		/* The 2nd interface on the EBH5600 is connected to the Marvel switch,
+		   which we don't support. Disable ports connected to it */
+	case CVMX_BOARD_TYPE_EBH5600:
+		if (interface == 1)
+			return 0;
+		break;
+	}
+	return supported_ports;
+}
+
+/**
+ * Enable packet input/output from the hardware. This function is
+ * called after by cvmx_helper_packet_hardware_enable() to
+ * perform board specific initialization. For most boards
+ * nothing is needed.
+ *
+ * @interface: Interface to enable
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_board_hardware_enable(int interface)
+{
+	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_CN3005_EVB_HS5) {
+		if (interface == 0) {
+			/* Different config for switch port */
+			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0);
+			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
+			/*
+			 * Boards with gigabit WAN ports need a
+			 * different setting that is compatible with
+			 * 100 Mbit settings
+			 */
+			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface),
+				       0xc);
+			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface),
+				       0xc);
+		}
+	} else if (cvmx_sysinfo_get()->board_type ==
+		   CVMX_BOARD_TYPE_CN3010_EVB_HS5) {
+		/*
+		 * Broadcom PHYs require differnet ASX
+		 * clocks. Unfortunately many boards don't define a
+		 * new board Id and simply mangle the
+		 * CN3010_EVB_HS5
+		 */
+		if (interface == 0) {
+			/*
+			 * Some boards use a hacked up bootloader that
+			 * identifies them as CN3010_EVB_HS5
+			 * evaluation boards.  This leads to all kinds
+			 * of configuration problems.  Detect one
+			 * case, and print warning, while trying to do
+			 * the right thing.
+			 */
+			int phy_addr = cvmx_helper_board_get_mii_address(0);
+			if (phy_addr != -1) {
+				int phy_identifier =
+				    cvmx_mdio_read(phy_addr >> 8,
+						   phy_addr & 0xff, 0x2);
+				/* Is it a Broadcom PHY? */
+				if (phy_identifier == 0x0143) {
+					cvmx_dprintf("\n");
+					cvmx_dprintf("ERROR:\n");
+					cvmx_dprintf
+					    ("ERROR: Board type is CVMX_BOARD_TYPE_CN3010_EVB_HS5, but Broadcom PHY found.\n");
+					cvmx_dprintf
+					    ("ERROR: The board type is mis-configured, and software malfunctions are likely.\n");
+					cvmx_dprintf
+					    ("ERROR: All boards require a unique board type to identify them.\n");
+					cvmx_dprintf("ERROR:\n");
+					cvmx_dprintf("\n");
+					cvmx_wait(1000000000);
+					cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX
+						       (0, interface), 5);
+					cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX
+						       (0, interface), 5);
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+cvmx_helper_board_usb_clock_types_t __cvmx_helper_board_usb_get_clock_type(void)
+{
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_BBGW_REF:
+		return USB_CLOCK_TYPE_CRYSTAL_12;
+	}
+	return USB_CLOCK_TYPE_REF_48;
+}
+
+int __cvmx_helper_board_usb_get_num_ports(int supported_ports)
+{
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_NIC_XLE_4G:
+		return 0;
+	}
+
+	return supported_ports;
+}
diff --git a/drivers/staging/octeon/cvmx-helper-board.h b/drivers/staging/octeon/cvmx-helper-board.h
new file mode 100644
index 0000000..dc20b01
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-board.h
@@ -0,0 +1,180 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Helper functions to abstract board specific data about
+ * network ports from the rest of the cvmx-helper files.
+ *
+ */
+#ifndef __CVMX_HELPER_BOARD_H__
+#define __CVMX_HELPER_BOARD_H__
+
+#include "cvmx-helper.h"
+
+typedef enum {
+	USB_CLOCK_TYPE_REF_12,
+	USB_CLOCK_TYPE_REF_24,
+	USB_CLOCK_TYPE_REF_48,
+	USB_CLOCK_TYPE_CRYSTAL_12,
+} cvmx_helper_board_usb_clock_types_t;
+
+typedef enum {
+	set_phy_link_flags_autoneg = 0x1,
+	set_phy_link_flags_flow_control_dont_touch = 0x0 << 1,
+	set_phy_link_flags_flow_control_enable = 0x1 << 1,
+	set_phy_link_flags_flow_control_disable = 0x2 << 1,
+	set_phy_link_flags_flow_control_mask = 0x3 << 1,	/* Mask for 2 bit wide flow control field */
+} cvmx_helper_board_set_phy_link_flags_types_t;
+
+/**
+ * cvmx_override_board_link_get(int ipd_port) is a function
+ * pointer. It is meant to allow customization of the process of
+ * talking to a PHY to determine link speed. It is called every
+ * time a PHY must be polled for link status. Users should set
+ * this pointer to a function before calling any cvmx-helper
+ * operations.
+ */
+extern cvmx_helper_link_info_t(*cvmx_override_board_link_get) (int ipd_port);
+
+/**
+ * Return the MII PHY address associated with the given IPD
+ * port. A result of -1 means there isn't a MII capable PHY
+ * connected to this port. On chips supporting multiple MII
+ * busses the bus number is encoded in bits <15:8>.
+ *
+ * This function must be modifed for every new Octeon board.
+ * Internally it uses switch statements based on the cvmx_sysinfo
+ * data to determine board types and revisions. It relys on the
+ * fact that every Octeon board receives a unique board type
+ * enumeration from the bootloader.
+ *
+ * @ipd_port: Octeon IPD port to get the MII address for.
+ *
+ * Returns MII PHY address and bus number or -1.
+ */
+extern int cvmx_helper_board_get_mii_address(int ipd_port);
+
+/**
+ * This function as a board specific method of changing the PHY
+ * speed, duplex, and autonegotiation. This programs the PHY and
+ * not Octeon. This can be used to force Octeon's links to
+ * specific settings.
+ *
+ * @phy_addr:  The address of the PHY to program
+ * @link_flags:
+ *                  Flags to control autonegotiation.  Bit 0 is autonegotiation
+ *                  enable/disable to maintain backware compatability.
+ * @link_info: Link speed to program. If the speed is zero and autonegotiation
+ *                  is enabled, all possible negotiation speeds are advertised.
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_helper_board_link_set_phy(int phy_addr,
+				   cvmx_helper_board_set_phy_link_flags_types_t
+				   link_flags,
+				   cvmx_helper_link_info_t link_info);
+
+/**
+ * This function is the board specific method of determining an
+ * ethernet ports link speed. Most Octeon boards have Marvell PHYs
+ * and are handled by the fall through case. This function must be
+ * updated for boards that don't have the normal Marvell PHYs.
+ *
+ * This function must be modifed for every new Octeon board.
+ * Internally it uses switch statements based on the cvmx_sysinfo
+ * data to determine board types and revisions. It relys on the
+ * fact that every Octeon board receives a unique board type
+ * enumeration from the bootloader.
+ *
+ * @ipd_port: IPD input port associated with the port we want to get link
+ *                 status for.
+ *
+ * Returns The ports link status. If the link isn't fully resolved, this must
+ *         return zero.
+ */
+extern cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port);
+
+/**
+ * This function is called by cvmx_helper_interface_probe() after it
+ * determines the number of ports Octeon can support on a specific
+ * interface. This function is the per board location to override
+ * this value. It is called with the number of ports Octeon might
+ * support and should return the number of actual ports on the
+ * board.
+ *
+ * This function must be modifed for every new Octeon board.
+ * Internally it uses switch statements based on the cvmx_sysinfo
+ * data to determine board types and revisions. It relys on the
+ * fact that every Octeon board receives a unique board type
+ * enumeration from the bootloader.
+ *
+ * @interface: Interface to probe
+ * @supported_ports:
+ *                  Number of ports Octeon supports.
+ *
+ * Returns Number of ports the actual board supports. Many times this will
+ *         simple be "support_ports".
+ */
+extern int __cvmx_helper_board_interface_probe(int interface,
+					       int supported_ports);
+
+/**
+ * Enable packet input/output from the hardware. This function is
+ * called after by cvmx_helper_packet_hardware_enable() to
+ * perform board specific initialization. For most boards
+ * nothing is needed.
+ *
+ * @interface: Interface to enable
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_board_hardware_enable(int interface);
+
+/**
+ * Gets the clock type used for the USB block based on board type.
+ * Used by the USB code for auto configuration of clock type.
+ *
+ * Returns USB clock type enumeration
+ */
+cvmx_helper_board_usb_clock_types_t
+__cvmx_helper_board_usb_get_clock_type(void);
+
+/**
+ * Adjusts the number of available USB ports on Octeon based on board
+ * specifics.
+ *
+ * @supported_ports: expected number of ports based on chip type;
+ *
+ *
+ * Returns number of available usb ports, based on board specifics.
+ *         Return value is supported_ports if function does not
+ *         override.
+ */
+int __cvmx_helper_board_usb_get_num_ports(int supported_ports);
+
+#endif /* __CVMX_HELPER_BOARD_H__ */
diff --git a/drivers/staging/octeon/cvmx-helper-fpa.c b/drivers/staging/octeon/cvmx-helper-fpa.c
new file mode 100644
index 0000000..c239e5f
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-fpa.c
@@ -0,0 +1,243 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Helper functions for FPA setup.
+ *
+ */
+#include "executive-config.h"
+#include "cvmx-config.h"
+#include "cvmx.h"
+#include "cvmx-bootmem.h"
+#include "cvmx-fpa.h"
+#include "cvmx-helper-fpa.h"
+
+/**
+ * Allocate memory for and initialize a single FPA pool.
+ *
+ * @pool:    Pool to initialize
+ * @buffer_size:  Size of buffers to allocate in bytes
+ * @buffers: Number of buffers to put in the pool. Zero is allowed
+ * @name:    String name of the pool for debugging purposes
+ * Returns Zero on success, non-zero on failure
+ */
+static int __cvmx_helper_initialize_fpa_pool(int pool, uint64_t buffer_size,
+					     uint64_t buffers, const char *name)
+{
+	uint64_t current_num;
+	void *memory;
+	uint64_t align = CVMX_CACHE_LINE_SIZE;
+
+	/*
+	 * Align the allocation so that power of 2 size buffers are
+	 * naturally aligned.
+	 */
+	while (align < buffer_size)
+		align = align << 1;
+
+	if (buffers == 0)
+		return 0;
+
+	current_num = cvmx_read_csr(CVMX_FPA_QUEX_AVAILABLE(pool));
+	if (current_num) {
+		cvmx_dprintf("Fpa pool %d(%s) already has %llu buffers. "
+			     "Skipping setup.\n",
+		     pool, name, (unsigned long long)current_num);
+		return 0;
+	}
+
+	memory = cvmx_bootmem_alloc(buffer_size * buffers, align);
+	if (memory == NULL) {
+		cvmx_dprintf("Out of memory initializing fpa pool %d(%s).\n",
+			     pool, name);
+		return -1;
+	}
+	cvmx_fpa_setup_pool(pool, name, memory, buffer_size, buffers);
+	return 0;
+}
+
+/**
+ * Allocate memory and initialize the FPA pools using memory
+ * from cvmx-bootmem. Specifying zero for the number of
+ * buffers will cause that FPA pool to not be setup. This is
+ * useful if you aren't using some of the hardware and want
+ * to save memory. Use cvmx_helper_initialize_fpa instead of
+ * this function directly.
+ *
+ * @pip_pool: Should always be CVMX_FPA_PACKET_POOL
+ * @pip_size: Should always be CVMX_FPA_PACKET_POOL_SIZE
+ * @pip_buffers:
+ *                 Number of packet buffers.
+ * @wqe_pool: Should always be CVMX_FPA_WQE_POOL
+ * @wqe_size: Should always be CVMX_FPA_WQE_POOL_SIZE
+ * @wqe_entries:
+ *                 Number of work queue entries
+ * @pko_pool: Should always be CVMX_FPA_OUTPUT_BUFFER_POOL
+ * @pko_size: Should always be CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE
+ * @pko_buffers:
+ *                 PKO Command buffers. You should at minimum have two per
+ *                 each PKO queue.
+ * @tim_pool: Should always be CVMX_FPA_TIMER_POOL
+ * @tim_size: Should always be CVMX_FPA_TIMER_POOL_SIZE
+ * @tim_buffers:
+ *                 TIM ring buffer command queues. At least two per timer bucket
+ *                 is recommened.
+ * @dfa_pool: Should always be CVMX_FPA_DFA_POOL
+ * @dfa_size: Should always be CVMX_FPA_DFA_POOL_SIZE
+ * @dfa_buffers:
+ *                 DFA command buffer. A relatively small (32 for example)
+ *                 number should work.
+ * Returns Zero on success, non-zero if out of memory
+ */
+static int __cvmx_helper_initialize_fpa(int pip_pool, int pip_size,
+					int pip_buffers, int wqe_pool,
+					int wqe_size, int wqe_entries,
+					int pko_pool, int pko_size,
+					int pko_buffers, int tim_pool,
+					int tim_size, int tim_buffers,
+					int dfa_pool, int dfa_size,
+					int dfa_buffers)
+{
+	int status;
+
+	cvmx_fpa_enable();
+
+	if ((pip_buffers > 0) && (pip_buffers <= 64))
+		cvmx_dprintf
+		    ("Warning: %d packet buffers may not be enough for hardware"
+		     " prefetch. 65 or more is recommended.\n", pip_buffers);
+
+	if (pip_pool >= 0) {
+		status =
+		    __cvmx_helper_initialize_fpa_pool(pip_pool, pip_size,
+						      pip_buffers,
+						      "Packet Buffers");
+		if (status)
+			return status;
+	}
+
+	if (wqe_pool >= 0) {
+		status =
+		    __cvmx_helper_initialize_fpa_pool(wqe_pool, wqe_size,
+						      wqe_entries,
+						      "Work Queue Entries");
+		if (status)
+			return status;
+	}
+
+	if (pko_pool >= 0) {
+		status =
+		    __cvmx_helper_initialize_fpa_pool(pko_pool, pko_size,
+						      pko_buffers,
+						      "PKO Command Buffers");
+		if (status)
+			return status;
+	}
+
+	if (tim_pool >= 0) {
+		status =
+		    __cvmx_helper_initialize_fpa_pool(tim_pool, tim_size,
+						      tim_buffers,
+						      "TIM Command Buffers");
+		if (status)
+			return status;
+	}
+
+	if (dfa_pool >= 0) {
+		status =
+		    __cvmx_helper_initialize_fpa_pool(dfa_pool, dfa_size,
+						      dfa_buffers,
+						      "DFA Command Buffers");
+		if (status)
+			return status;
+	}
+
+	return 0;
+}
+
+/**
+ * Allocate memory and initialize the FPA pools using memory
+ * from cvmx-bootmem. Sizes of each element in the pools is
+ * controlled by the cvmx-config.h header file. Specifying
+ * zero for any parameter will cause that FPA pool to not be
+ * setup. This is useful if you aren't using some of the
+ * hardware and want to save memory.
+ *
+ * @packet_buffers:
+ *               Number of packet buffers to allocate
+ * @work_queue_entries:
+ *               Number of work queue entries
+ * @pko_buffers:
+ *               PKO Command buffers. You should at minimum have two per
+ *               each PKO queue.
+ * @tim_buffers:
+ *               TIM ring buffer command queues. At least two per timer bucket
+ *               is recommened.
+ * @dfa_buffers:
+ *               DFA command buffer. A relatively small (32 for example)
+ *               number should work.
+ * Returns Zero on success, non-zero if out of memory
+ */
+int cvmx_helper_initialize_fpa(int packet_buffers, int work_queue_entries,
+			       int pko_buffers, int tim_buffers,
+			       int dfa_buffers)
+{
+#ifndef CVMX_FPA_PACKET_POOL
+#define CVMX_FPA_PACKET_POOL -1
+#define CVMX_FPA_PACKET_POOL_SIZE 0
+#endif
+#ifndef CVMX_FPA_WQE_POOL
+#define CVMX_FPA_WQE_POOL -1
+#define CVMX_FPA_WQE_POOL_SIZE 0
+#endif
+#ifndef CVMX_FPA_OUTPUT_BUFFER_POOL
+#define CVMX_FPA_OUTPUT_BUFFER_POOL -1
+#define CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE 0
+#endif
+#ifndef CVMX_FPA_TIMER_POOL
+#define CVMX_FPA_TIMER_POOL -1
+#define CVMX_FPA_TIMER_POOL_SIZE 0
+#endif
+#ifndef CVMX_FPA_DFA_POOL
+#define CVMX_FPA_DFA_POOL -1
+#define CVMX_FPA_DFA_POOL_SIZE 0
+#endif
+	return __cvmx_helper_initialize_fpa(CVMX_FPA_PACKET_POOL,
+					    CVMX_FPA_PACKET_POOL_SIZE,
+					    packet_buffers, CVMX_FPA_WQE_POOL,
+					    CVMX_FPA_WQE_POOL_SIZE,
+					    work_queue_entries,
+					    CVMX_FPA_OUTPUT_BUFFER_POOL,
+					    CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE,
+					    pko_buffers, CVMX_FPA_TIMER_POOL,
+					    CVMX_FPA_TIMER_POOL_SIZE,
+					    tim_buffers, CVMX_FPA_DFA_POOL,
+					    CVMX_FPA_DFA_POOL_SIZE,
+					    dfa_buffers);
+}
diff --git a/drivers/staging/octeon/cvmx-helper-fpa.h b/drivers/staging/octeon/cvmx-helper-fpa.h
new file mode 100644
index 0000000..5ff8c93
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-fpa.h
@@ -0,0 +1,64 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Helper functions for FPA setup.
+ *
+ */
+#ifndef __CVMX_HELPER_H_FPA__
+#define __CVMX_HELPER_H_FPA__
+
+/**
+ * Allocate memory and initialize the FPA pools using memory
+ * from cvmx-bootmem. Sizes of each element in the pools is
+ * controlled by the cvmx-config.h header file. Specifying
+ * zero for any parameter will cause that FPA pool to not be
+ * setup. This is useful if you aren't using some of the
+ * hardware and want to save memory.
+ *
+ * @packet_buffers:
+ *               Number of packet buffers to allocate
+ * @work_queue_entries:
+ *               Number of work queue entries
+ * @pko_buffers:
+ *               PKO Command buffers. You should at minimum have two per
+ *               each PKO queue.
+ * @tim_buffers:
+ *               TIM ring buffer command queues. At least two per timer bucket
+ *               is recommened.
+ * @dfa_buffers:
+ *               DFA command buffer. A relatively small (32 for example)
+ *               number should work.
+ * Returns Zero on success, non-zero if out of memory
+ */
+extern int cvmx_helper_initialize_fpa(int packet_buffers,
+				      int work_queue_entries, int pko_buffers,
+				      int tim_buffers, int dfa_buffers);
+
+#endif /* __CVMX_HELPER_H__ */
diff --git a/drivers/staging/octeon/cvmx-helper-loop.c b/drivers/staging/octeon/cvmx-helper-loop.c
new file mode 100644
index 0000000..55a571a
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-loop.c
@@ -0,0 +1,85 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Functions for LOOP initialization, configuration,
+ * and monitoring.
+ */
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+
+#include "cvmx-helper.h"
+#include "cvmx-pip-defs.h"
+
+/**
+ * Probe a LOOP interface and determine the number of ports
+ * connected to it. The LOOP interface should still be down
+ * after this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+int __cvmx_helper_loop_probe(int interface)
+{
+	union cvmx_ipd_sub_port_fcs ipd_sub_port_fcs;
+	int num_ports = 4;
+	int port;
+
+	/* We need to disable length checking so packet < 64 bytes and jumbo
+	   frames don't get errors */
+	for (port = 0; port < num_ports; port++) {
+		union cvmx_pip_prt_cfgx port_cfg;
+		int ipd_port = cvmx_helper_get_ipd_port(interface, port);
+		port_cfg.u64 = cvmx_read_csr(CVMX_PIP_PRT_CFGX(ipd_port));
+		port_cfg.s.maxerr_en = 0;
+		port_cfg.s.minerr_en = 0;
+		cvmx_write_csr(CVMX_PIP_PRT_CFGX(ipd_port), port_cfg.u64);
+	}
+
+	/* Disable FCS stripping for loopback ports */
+	ipd_sub_port_fcs.u64 = cvmx_read_csr(CVMX_IPD_SUB_PORT_FCS);
+	ipd_sub_port_fcs.s.port_bit2 = 0;
+	cvmx_write_csr(CVMX_IPD_SUB_PORT_FCS, ipd_sub_port_fcs.u64);
+	return num_ports;
+}
+
+/**
+ * Bringup and enable a LOOP interface. After this call packet
+ * I/O should be fully functional. This is called with IPD
+ * enabled but PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_loop_enable(int interface)
+{
+	/* Do nothing. */
+	return 0;
+}
diff --git a/drivers/staging/octeon/cvmx-helper-loop.h b/drivers/staging/octeon/cvmx-helper-loop.h
new file mode 100644
index 0000000..e646a6c
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-loop.h
@@ -0,0 +1,59 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Functions for LOOP initialization, configuration,
+ * and monitoring.
+ *
+ */
+#ifndef __CVMX_HELPER_LOOP_H__
+#define __CVMX_HELPER_LOOP_H__
+
+/**
+ * Probe a LOOP interface and determine the number of ports
+ * connected to it. The LOOP interface should still be down after
+ * this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+extern int __cvmx_helper_loop_probe(int interface);
+
+/**
+ * Bringup and enable a LOOP interface. After this call packet
+ * I/O should be fully functional. This is called with IPD
+ * enabled but PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_loop_enable(int interface);
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-helper-npi.c b/drivers/staging/octeon/cvmx-helper-npi.c
new file mode 100644
index 0000000..7388a1e
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-npi.c
@@ -0,0 +1,113 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Functions for NPI initialization, configuration,
+ * and monitoring.
+ */
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+
+#include "cvmx-helper.h"
+
+#include "cvmx-pip-defs.h"
+
+/**
+ * Probe a NPI interface and determine the number of ports
+ * connected to it. The NPI interface should still be down
+ * after this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+int __cvmx_helper_npi_probe(int interface)
+{
+#if CVMX_PKO_QUEUES_PER_PORT_PCI > 0
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
+		return 4;
+	else if (OCTEON_IS_MODEL(OCTEON_CN56XX)
+		 && !OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X))
+		/* The packet engines didn't exist before pass 2 */
+		return 4;
+	else if (OCTEON_IS_MODEL(OCTEON_CN52XX)
+		 && !OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X))
+		/* The packet engines didn't exist before pass 2 */
+		return 4;
+#if 0
+	/*
+	 * Technically CN30XX, CN31XX, and CN50XX contain packet
+	 * engines, but nobody ever uses them. Since this is the case,
+	 * we disable them here.
+	 */
+	else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
+		 || OCTEON_IS_MODEL(OCTEON_CN50XX))
+		return 2;
+	else if (OCTEON_IS_MODEL(OCTEON_CN30XX))
+		return 1;
+#endif
+#endif
+	return 0;
+}
+
+/**
+ * Bringup and enable a NPI interface. After this call packet
+ * I/O should be fully functional. This is called with IPD
+ * enabled but PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_npi_enable(int interface)
+{
+	/*
+	 * On CN50XX, CN52XX, and CN56XX we need to disable length
+	 * checking so packet < 64 bytes and jumbo frames don't get
+	 * errors.
+	 */
+	if (!OCTEON_IS_MODEL(OCTEON_CN3XXX) &&
+	    !OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+		int num_ports = cvmx_helper_ports_on_interface(interface);
+		int port;
+		for (port = 0; port < num_ports; port++) {
+			union cvmx_pip_prt_cfgx port_cfg;
+			int ipd_port =
+			    cvmx_helper_get_ipd_port(interface, port);
+			port_cfg.u64 =
+			    cvmx_read_csr(CVMX_PIP_PRT_CFGX(ipd_port));
+			port_cfg.s.maxerr_en = 0;
+			port_cfg.s.minerr_en = 0;
+			cvmx_write_csr(CVMX_PIP_PRT_CFGX(ipd_port),
+				       port_cfg.u64);
+		}
+	}
+
+	/* Enables are controlled by the remote host, so nothing to do here */
+	return 0;
+}
diff --git a/drivers/staging/octeon/cvmx-helper-npi.h b/drivers/staging/octeon/cvmx-helper-npi.h
new file mode 100644
index 0000000..908e7b0
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-npi.h
@@ -0,0 +1,60 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Functions for NPI initialization, configuration,
+ * and monitoring.
+ *
+ */
+#ifndef __CVMX_HELPER_NPI_H__
+#define __CVMX_HELPER_NPI_H__
+
+/**
+ * Probe a NPI interface and determine the number of ports
+ * connected to it. The NPI interface should still be down after
+ * this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+extern int __cvmx_helper_npi_probe(int interface);
+
+/**
+ * Bringup and enable a NPI interface. After this call packet
+ * I/O should be fully functional. This is called with IPD
+ * enabled but PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_npi_enable(int interface);
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-helper-rgmii.c b/drivers/staging/octeon/cvmx-helper-rgmii.c
new file mode 100644
index 0000000..aa2d5d7
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-rgmii.c
@@ -0,0 +1,525 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Functions for RGMII/GMII/MII initialization, configuration,
+ * and monitoring.
+ */
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+
+
+#include "cvmx-mdio.h"
+#include "cvmx-pko.h"
+#include "cvmx-helper.h"
+#include "cvmx-helper-board.h"
+
+#include <asm/octeon/cvmx-npi-defs.h>
+#include "cvmx-gmxx-defs.h"
+#include "cvmx-asxx-defs.h"
+#include "cvmx-dbg-defs.h"
+
+void __cvmx_interrupt_gmxx_enable(int interface);
+void __cvmx_interrupt_asxx_enable(int block);
+
+/**
+ * Probe RGMII ports and determine the number present
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of RGMII/GMII/MII ports (0-4).
+ */
+int __cvmx_helper_rgmii_probe(int interface)
+{
+	int num_ports = 0;
+	union cvmx_gmxx_inf_mode mode;
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+
+	if (mode.s.type) {
+		if (OCTEON_IS_MODEL(OCTEON_CN38XX)
+		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+			cvmx_dprintf("ERROR: RGMII initialize called in "
+				     "SPI interface\n");
+		} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
+			   || OCTEON_IS_MODEL(OCTEON_CN30XX)
+			   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+			/*
+			 * On these chips "type" says we're in
+			 * GMII/MII mode. This limits us to 2 ports
+			 */
+			num_ports = 2;
+		} else {
+			cvmx_dprintf("ERROR: Unsupported Octeon model in %s\n",
+				     __func__);
+		}
+	} else {
+		if (OCTEON_IS_MODEL(OCTEON_CN38XX)
+		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+			num_ports = 4;
+		} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
+			   || OCTEON_IS_MODEL(OCTEON_CN30XX)
+			   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+			num_ports = 3;
+		} else {
+			cvmx_dprintf("ERROR: Unsupported Octeon model in %s\n",
+				     __func__);
+		}
+	}
+	return num_ports;
+}
+
+/**
+ * Put an RGMII interface in loopback mode. Internal packets sent
+ * out will be received back again on the same port. Externally
+ * received packets will echo back out.
+ *
+ * @port:   IPD port number to loop.
+ */
+void cvmx_helper_rgmii_internal_loopback(int port)
+{
+	int interface = (port >> 4) & 1;
+	int index = port & 0xf;
+	uint64_t tmp;
+
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	gmx_cfg.u64 = 0;
+	gmx_cfg.s.duplex = 1;
+	gmx_cfg.s.slottime = 1;
+	gmx_cfg.s.speed = 1;
+	cvmx_write_csr(CVMX_GMXX_TXX_CLK(index, interface), 1);
+	cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 0x200);
+	cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0x2000);
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+	tmp = cvmx_read_csr(CVMX_ASXX_PRT_LOOP(interface));
+	cvmx_write_csr(CVMX_ASXX_PRT_LOOP(interface), (1 << index) | tmp);
+	tmp = cvmx_read_csr(CVMX_ASXX_TX_PRT_EN(interface));
+	cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(interface), (1 << index) | tmp);
+	tmp = cvmx_read_csr(CVMX_ASXX_RX_PRT_EN(interface));
+	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(interface), (1 << index) | tmp);
+	gmx_cfg.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+}
+
+/**
+ * Workaround ASX setup errata with CN38XX pass1
+ *
+ * @interface: Interface to setup
+ * @port:      Port to setup (0..3)
+ * @cpu_clock_hz:
+ *                  Chip frequency in Hertz
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_errata_asx_pass1(int interface, int port,
+					  int cpu_clock_hz)
+{
+	/* Set hi water mark as per errata GMX-4 */
+	if (cpu_clock_hz >= 325000000 && cpu_clock_hz < 375000000)
+		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 12);
+	else if (cpu_clock_hz >= 375000000 && cpu_clock_hz < 437000000)
+		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 11);
+	else if (cpu_clock_hz >= 437000000 && cpu_clock_hz < 550000000)
+		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 10);
+	else if (cpu_clock_hz >= 550000000 && cpu_clock_hz < 687000000)
+		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 9);
+	else
+		cvmx_dprintf("Illegal clock frequency (%d). "
+			"CVMX_ASXX_TX_HI_WATERX not set\n", cpu_clock_hz);
+	return 0;
+}
+
+/**
+ * Configure all of the ASX, GMX, and PKO regsiters required
+ * to get RGMII to function on the supplied interface.
+ *
+ * @interface: PKO Interface to configure (0 or 1)
+ *
+ * Returns Zero on success
+ */
+int __cvmx_helper_rgmii_enable(int interface)
+{
+	int num_ports = cvmx_helper_ports_on_interface(interface);
+	int port;
+	struct cvmx_sysinfo *sys_info_ptr = cvmx_sysinfo_get();
+	union cvmx_gmxx_inf_mode mode;
+	union cvmx_asxx_tx_prt_en asx_tx;
+	union cvmx_asxx_rx_prt_en asx_rx;
+
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+
+	if (mode.s.en == 0)
+		return -1;
+	if ((OCTEON_IS_MODEL(OCTEON_CN38XX) ||
+	     OCTEON_IS_MODEL(OCTEON_CN58XX)) && mode.s.type == 1)
+		/* Ignore SPI interfaces */
+		return -1;
+
+	/* Configure the ASX registers needed to use the RGMII ports */
+	asx_tx.u64 = 0;
+	asx_tx.s.prt_en = cvmx_build_mask(num_ports);
+	cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(interface), asx_tx.u64);
+
+	asx_rx.u64 = 0;
+	asx_rx.s.prt_en = cvmx_build_mask(num_ports);
+	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(interface), asx_rx.u64);
+
+	/* Configure the GMX registers needed to use the RGMII ports */
+	for (port = 0; port < num_ports; port++) {
+		/* Setting of CVMX_GMXX_TXX_THRESH has been moved to
+		   __cvmx_helper_setup_gmx() */
+
+		if (cvmx_octeon_is_pass1())
+			__cvmx_helper_errata_asx_pass1(interface, port,
+						       sys_info_ptr->
+						       cpu_clock_hz);
+		else {
+			/*
+			 * Configure more flexible RGMII preamble
+			 * checking. Pass 1 doesn't support this
+			 * feature.
+			 */
+			union cvmx_gmxx_rxx_frm_ctl frm_ctl;
+			frm_ctl.u64 =
+			    cvmx_read_csr(CVMX_GMXX_RXX_FRM_CTL
+					  (port, interface));
+			/* New field, so must be compile time */
+			frm_ctl.s.pre_free = 1;
+			cvmx_write_csr(CVMX_GMXX_RXX_FRM_CTL(port, interface),
+				       frm_ctl.u64);
+		}
+
+		/*
+		 * Each pause frame transmitted will ask for about 10M
+		 * bit times before resume.  If buffer space comes
+		 * available before that time has expired, an XON
+		 * pause frame (0 time) will be transmitted to restart
+		 * the flow.
+		 */
+		cvmx_write_csr(CVMX_GMXX_TXX_PAUSE_PKT_TIME(port, interface),
+			       20000);
+		cvmx_write_csr(CVMX_GMXX_TXX_PAUSE_PKT_INTERVAL
+			       (port, interface), 19000);
+
+		if (OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(port, interface),
+				       16);
+			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(port, interface),
+				       16);
+		} else {
+			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(port, interface),
+				       24);
+			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(port, interface),
+				       24);
+		}
+	}
+
+	__cvmx_helper_setup_gmx(interface, num_ports);
+
+	/* enable the ports now */
+	for (port = 0; port < num_ports; port++) {
+		union cvmx_gmxx_prtx_cfg gmx_cfg;
+		cvmx_helper_link_autoconf(cvmx_helper_get_ipd_port
+					  (interface, port));
+		gmx_cfg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(port, interface));
+		gmx_cfg.s.en = 1;
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(port, interface),
+			       gmx_cfg.u64);
+	}
+	__cvmx_interrupt_asxx_enable(interface);
+	__cvmx_interrupt_gmxx_enable(interface);
+
+	return 0;
+}
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+cvmx_helper_link_info_t __cvmx_helper_rgmii_link_get(int ipd_port)
+{
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+	union cvmx_asxx_prt_loop asxx_prt_loop;
+
+	asxx_prt_loop.u64 = cvmx_read_csr(CVMX_ASXX_PRT_LOOP(interface));
+	if (asxx_prt_loop.s.int_loop & (1 << index)) {
+		/* Force 1Gbps full duplex on internal loopback */
+		cvmx_helper_link_info_t result;
+		result.u64 = 0;
+		result.s.full_duplex = 1;
+		result.s.link_up = 1;
+		result.s.speed = 1000;
+		return result;
+	} else
+		return __cvmx_helper_board_link_get(ipd_port);
+}
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_rgmii_link_set(int ipd_port,
+				 cvmx_helper_link_info_t link_info)
+{
+	int result = 0;
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+	union cvmx_gmxx_prtx_cfg original_gmx_cfg;
+	union cvmx_gmxx_prtx_cfg new_gmx_cfg;
+	union cvmx_pko_mem_queue_qos pko_mem_queue_qos;
+	union cvmx_pko_mem_queue_qos pko_mem_queue_qos_save[16];
+	union cvmx_gmxx_tx_ovr_bp gmx_tx_ovr_bp;
+	union cvmx_gmxx_tx_ovr_bp gmx_tx_ovr_bp_save;
+	int i;
+
+	/* Ignore speed sets in the simulator */
+	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_SIM)
+		return 0;
+
+	/* Read the current settings so we know the current enable state */
+	original_gmx_cfg.u64 =
+	    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	new_gmx_cfg = original_gmx_cfg;
+
+	/* Disable the lowest level RX */
+	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(interface),
+		       cvmx_read_csr(CVMX_ASXX_RX_PRT_EN(interface)) &
+				     ~(1 << index));
+
+	/* Disable all queues so that TX should become idle */
+	for (i = 0; i < cvmx_pko_get_num_queues(ipd_port); i++) {
+		int queue = cvmx_pko_get_base_queue(ipd_port) + i;
+		cvmx_write_csr(CVMX_PKO_REG_READ_IDX, queue);
+		pko_mem_queue_qos.u64 = cvmx_read_csr(CVMX_PKO_MEM_QUEUE_QOS);
+		pko_mem_queue_qos.s.pid = ipd_port;
+		pko_mem_queue_qos.s.qid = queue;
+		pko_mem_queue_qos_save[i] = pko_mem_queue_qos;
+		pko_mem_queue_qos.s.qos_mask = 0;
+		cvmx_write_csr(CVMX_PKO_MEM_QUEUE_QOS, pko_mem_queue_qos.u64);
+	}
+
+	/* Disable backpressure */
+	gmx_tx_ovr_bp.u64 = cvmx_read_csr(CVMX_GMXX_TX_OVR_BP(interface));
+	gmx_tx_ovr_bp_save = gmx_tx_ovr_bp;
+	gmx_tx_ovr_bp.s.bp &= ~(1 << index);
+	gmx_tx_ovr_bp.s.en |= 1 << index;
+	cvmx_write_csr(CVMX_GMXX_TX_OVR_BP(interface), gmx_tx_ovr_bp.u64);
+	cvmx_read_csr(CVMX_GMXX_TX_OVR_BP(interface));
+
+	/*
+	 * Poll the GMX state machine waiting for it to become
+	 * idle. Preferably we should only change speed when it is
+	 * idle. If it doesn't become idle we will still do the speed
+	 * change, but there is a slight chance that GMX will
+	 * lockup.
+	 */
+	cvmx_write_csr(CVMX_NPI_DBG_SELECT,
+		       interface * 0x800 + index * 0x100 + 0x880);
+	CVMX_WAIT_FOR_FIELD64(CVMX_DBG_DATA, union cvmx_dbg_data, data & 7,
+			==, 0, 10000);
+	CVMX_WAIT_FOR_FIELD64(CVMX_DBG_DATA, union cvmx_dbg_data, data & 0xf,
+			==, 0, 10000);
+
+	/* Disable the port before we make any changes */
+	new_gmx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), new_gmx_cfg.u64);
+	cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+
+	/* Set full/half duplex */
+	if (cvmx_octeon_is_pass1())
+		/* Half duplex is broken for 38XX Pass 1 */
+		new_gmx_cfg.s.duplex = 1;
+	else if (!link_info.s.link_up)
+		/* Force full duplex on down links */
+		new_gmx_cfg.s.duplex = 1;
+	else
+		new_gmx_cfg.s.duplex = link_info.s.full_duplex;
+
+	/* Set the link speed. Anything unknown is set to 1Gbps */
+	if (link_info.s.speed == 10) {
+		new_gmx_cfg.s.slottime = 0;
+		new_gmx_cfg.s.speed = 0;
+	} else if (link_info.s.speed == 100) {
+		new_gmx_cfg.s.slottime = 0;
+		new_gmx_cfg.s.speed = 0;
+	} else {
+		new_gmx_cfg.s.slottime = 1;
+		new_gmx_cfg.s.speed = 1;
+	}
+
+	/* Adjust the clocks */
+	if (link_info.s.speed == 10) {
+		cvmx_write_csr(CVMX_GMXX_TXX_CLK(index, interface), 50);
+		cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 0x40);
+		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0);
+	} else if (link_info.s.speed == 100) {
+		cvmx_write_csr(CVMX_GMXX_TXX_CLK(index, interface), 5);
+		cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 0x40);
+		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0);
+	} else {
+		cvmx_write_csr(CVMX_GMXX_TXX_CLK(index, interface), 1);
+		cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 0x200);
+		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0x2000);
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN30XX) || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		if ((link_info.s.speed == 10) || (link_info.s.speed == 100)) {
+			union cvmx_gmxx_inf_mode mode;
+			mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+
+	/*
+	 * Port  .en  .type  .p0mii  Configuration
+	 * ----  ---  -----  ------  -----------------------------------------
+	 *  X      0     X      X    All links are disabled.
+	 *  0      1     X      0    Port 0 is RGMII
+	 *  0      1     X      1    Port 0 is MII
+	 *  1      1     0      X    Ports 1 and 2 are configured as RGMII ports.
+	 *  1      1     1      X    Port 1: GMII/MII; Port 2: disabled. GMII or
+	 *                           MII port is selected by GMX_PRT1_CFG[SPEED].
+	 */
+
+			/* In MII mode, CLK_CNT = 1. */
+			if (((index == 0) && (mode.s.p0mii == 1))
+			    || ((index != 0) && (mode.s.type == 1))) {
+				cvmx_write_csr(CVMX_GMXX_TXX_CLK
+					       (index, interface), 1);
+			}
+		}
+	}
+
+	/* Do a read to make sure all setup stuff is complete */
+	cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+
+	/* Save the new GMX setting without enabling the port */
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), new_gmx_cfg.u64);
+
+	/* Enable the lowest level RX */
+	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(interface),
+		       cvmx_read_csr(CVMX_ASXX_RX_PRT_EN(interface)) | (1 <<
+									index));
+
+	/* Re-enable the TX path */
+	for (i = 0; i < cvmx_pko_get_num_queues(ipd_port); i++) {
+		int queue = cvmx_pko_get_base_queue(ipd_port) + i;
+		cvmx_write_csr(CVMX_PKO_REG_READ_IDX, queue);
+		cvmx_write_csr(CVMX_PKO_MEM_QUEUE_QOS,
+			       pko_mem_queue_qos_save[i].u64);
+	}
+
+	/* Restore backpressure */
+	cvmx_write_csr(CVMX_GMXX_TX_OVR_BP(interface), gmx_tx_ovr_bp_save.u64);
+
+	/* Restore the GMX enable state. Port config is complete */
+	new_gmx_cfg.s.en = original_gmx_cfg.s.en;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), new_gmx_cfg.u64);
+
+	return result;
+}
+
+/**
+ * Configure a port for internal and/or external loopback. Internal loopback
+ * causes packets sent by the port to be received by Octeon. External loopback
+ * causes packets received from the wire to sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *                 Non zero if you want internal loopback
+ * @enable_external:
+ *                 Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+int __cvmx_helper_rgmii_configure_loopback(int ipd_port, int enable_internal,
+					   int enable_external)
+{
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+	int original_enable;
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	union cvmx_asxx_prt_loop asxx_prt_loop;
+
+	/* Read the current enable state and save it */
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	original_enable = gmx_cfg.s.en;
+	/* Force port to be disabled */
+	gmx_cfg.s.en = 0;
+	if (enable_internal) {
+		/* Force speed if we're doing internal loopback */
+		gmx_cfg.s.duplex = 1;
+		gmx_cfg.s.slottime = 1;
+		gmx_cfg.s.speed = 1;
+		cvmx_write_csr(CVMX_GMXX_TXX_CLK(index, interface), 1);
+		cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 0x200);
+		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0x2000);
+	}
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+
+	/* Set the loopback bits */
+	asxx_prt_loop.u64 = cvmx_read_csr(CVMX_ASXX_PRT_LOOP(interface));
+	if (enable_internal)
+		asxx_prt_loop.s.int_loop |= 1 << index;
+	else
+		asxx_prt_loop.s.int_loop &= ~(1 << index);
+	if (enable_external)
+		asxx_prt_loop.s.ext_loop |= 1 << index;
+	else
+		asxx_prt_loop.s.ext_loop &= ~(1 << index);
+	cvmx_write_csr(CVMX_ASXX_PRT_LOOP(interface), asxx_prt_loop.u64);
+
+	/* Force enables in internal loopback */
+	if (enable_internal) {
+		uint64_t tmp;
+		tmp = cvmx_read_csr(CVMX_ASXX_TX_PRT_EN(interface));
+		cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(interface),
+			       (1 << index) | tmp);
+		tmp = cvmx_read_csr(CVMX_ASXX_RX_PRT_EN(interface));
+		cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(interface),
+			       (1 << index) | tmp);
+		original_enable = 1;
+	}
+
+	/* Restore the enable state */
+	gmx_cfg.s.en = original_enable;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+	return 0;
+}
diff --git a/drivers/staging/octeon/cvmx-helper-rgmii.h b/drivers/staging/octeon/cvmx-helper-rgmii.h
new file mode 100644
index 0000000..ea26526
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-rgmii.h
@@ -0,0 +1,110 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Functions for RGMII/GMII/MII initialization, configuration,
+ * and monitoring.
+ *
+ */
+#ifndef __CVMX_HELPER_RGMII_H__
+#define __CVMX_HELPER_RGMII_H__
+
+/**
+ * Probe RGMII ports and determine the number present
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of RGMII/GMII/MII ports (0-4).
+ */
+extern int __cvmx_helper_rgmii_probe(int interface);
+
+/**
+ * Put an RGMII interface in loopback mode. Internal packets sent
+ * out will be received back again on the same port. Externally
+ * received packets will echo back out.
+ *
+ * @port:   IPD port number to loop.
+ */
+extern void cvmx_helper_rgmii_internal_loopback(int port);
+
+/**
+ * Configure all of the ASX, GMX, and PKO regsiters required
+ * to get RGMII to function on the supplied interface.
+ *
+ * @interface: PKO Interface to configure (0 or 1)
+ *
+ * Returns Zero on success
+ */
+extern int __cvmx_helper_rgmii_enable(int interface);
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+extern cvmx_helper_link_info_t __cvmx_helper_rgmii_link_get(int ipd_port);
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_rgmii_link_set(int ipd_port,
+					cvmx_helper_link_info_t link_info);
+
+/**
+ * Configure a port for internal and/or external loopback. Internal loopback
+ * causes packets sent by the port to be received by Octeon. External loopback
+ * causes packets received from the wire to sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *                 Non zero if you want internal loopback
+ * @enable_external:
+ *                 Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+extern int __cvmx_helper_rgmii_configure_loopback(int ipd_port,
+						  int enable_internal,
+						  int enable_external);
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-helper-sgmii.c b/drivers/staging/octeon/cvmx-helper-sgmii.c
new file mode 100644
index 0000000..6214e3b
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-sgmii.c
@@ -0,0 +1,550 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Functions for SGMII initialization, configuration,
+ * and monitoring.
+ */
+
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+
+#include "cvmx-mdio.h"
+#include "cvmx-helper.h"
+#include "cvmx-helper-board.h"
+
+#include "cvmx-gmxx-defs.h"
+#include "cvmx-pcsx-defs.h"
+
+void __cvmx_interrupt_gmxx_enable(int interface);
+void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
+void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
+
+/**
+ * Perform initialization required only once for an SGMII port.
+ *
+ * @interface: Interface to init
+ * @index:     Index of prot on the interface
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_sgmii_hardware_init_one_time(int interface, int index)
+{
+	const uint64_t clock_mhz = cvmx_sysinfo_get()->cpu_clock_hz / 1000000;
+	union cvmx_pcsx_miscx_ctl_reg pcs_misc_ctl_reg;
+	union cvmx_pcsx_linkx_timer_count_reg pcsx_linkx_timer_count_reg;
+	union cvmx_gmxx_prtx_cfg gmxx_prtx_cfg;
+
+	/* Disable GMX */
+	gmxx_prtx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmxx_prtx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmxx_prtx_cfg.u64);
+
+	/*
+	 * Write PCS*_LINK*_TIMER_COUNT_REG[COUNT] with the
+	 * appropriate value. 1000BASE-X specifies a 10ms
+	 * interval. SGMII specifies a 1.6ms interval.
+	 */
+	pcs_misc_ctl_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
+	pcsx_linkx_timer_count_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSX_LINKX_TIMER_COUNT_REG(index, interface));
+	if (pcs_misc_ctl_reg.s.mode) {
+		/* 1000BASE-X */
+		pcsx_linkx_timer_count_reg.s.count =
+		    (10000ull * clock_mhz) >> 10;
+	} else {
+		/* SGMII */
+		pcsx_linkx_timer_count_reg.s.count =
+		    (1600ull * clock_mhz) >> 10;
+	}
+	cvmx_write_csr(CVMX_PCSX_LINKX_TIMER_COUNT_REG(index, interface),
+		       pcsx_linkx_timer_count_reg.u64);
+
+	/*
+	 * Write the advertisement register to be used as the
+	 * tx_Config_Reg<D15:D0> of the autonegotiation.  In
+	 * 1000BASE-X mode, tx_Config_Reg<D15:D0> is PCS*_AN*_ADV_REG.
+	 * In SGMII PHY mode, tx_Config_Reg<D15:D0> is
+	 * PCS*_SGM*_AN_ADV_REG.  In SGMII MAC mode,
+	 * tx_Config_Reg<D15:D0> is the fixed value 0x4001, so this
+	 * step can be skipped.
+	 */
+	if (pcs_misc_ctl_reg.s.mode) {
+		/* 1000BASE-X */
+		union cvmx_pcsx_anx_adv_reg pcsx_anx_adv_reg;
+		pcsx_anx_adv_reg.u64 =
+		    cvmx_read_csr(CVMX_PCSX_ANX_ADV_REG(index, interface));
+		pcsx_anx_adv_reg.s.rem_flt = 0;
+		pcsx_anx_adv_reg.s.pause = 3;
+		pcsx_anx_adv_reg.s.hfd = 1;
+		pcsx_anx_adv_reg.s.fd = 1;
+		cvmx_write_csr(CVMX_PCSX_ANX_ADV_REG(index, interface),
+			       pcsx_anx_adv_reg.u64);
+	} else {
+		union cvmx_pcsx_miscx_ctl_reg pcsx_miscx_ctl_reg;
+		pcsx_miscx_ctl_reg.u64 =
+		    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
+		if (pcsx_miscx_ctl_reg.s.mac_phy) {
+			/* PHY Mode */
+			union cvmx_pcsx_sgmx_an_adv_reg pcsx_sgmx_an_adv_reg;
+			pcsx_sgmx_an_adv_reg.u64 =
+			    cvmx_read_csr(CVMX_PCSX_SGMX_AN_ADV_REG
+					  (index, interface));
+			pcsx_sgmx_an_adv_reg.s.link = 1;
+			pcsx_sgmx_an_adv_reg.s.dup = 1;
+			pcsx_sgmx_an_adv_reg.s.speed = 2;
+			cvmx_write_csr(CVMX_PCSX_SGMX_AN_ADV_REG
+				       (index, interface),
+				       pcsx_sgmx_an_adv_reg.u64);
+		} else {
+			/* MAC Mode - Nothing to do */
+		}
+	}
+	return 0;
+}
+
+/**
+ * Initialize the SERTES link for the first time or after a loss
+ * of link.
+ *
+ * @interface: Interface to init
+ * @index:     Index of prot on the interface
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_sgmii_hardware_init_link(int interface, int index)
+{
+	union cvmx_pcsx_mrx_control_reg control_reg;
+
+	/*
+	 * Take PCS through a reset sequence.
+	 * PCS*_MR*_CONTROL_REG[PWR_DN] should be cleared to zero.
+	 * Write PCS*_MR*_CONTROL_REG[RESET]=1 (while not changing the
+	 * value of the other PCS*_MR*_CONTROL_REG bits).  Read
+	 * PCS*_MR*_CONTROL_REG[RESET] until it changes value to
+	 * zero.
+	 */
+	control_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSX_MRX_CONTROL_REG(index, interface));
+	if (cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM) {
+		control_reg.s.reset = 1;
+		cvmx_write_csr(CVMX_PCSX_MRX_CONTROL_REG(index, interface),
+			       control_reg.u64);
+		if (CVMX_WAIT_FOR_FIELD64
+		    (CVMX_PCSX_MRX_CONTROL_REG(index, interface),
+		     union cvmx_pcsx_mrx_control_reg, reset, ==, 0, 10000)) {
+			cvmx_dprintf("SGMII%d: Timeout waiting for port %d "
+				     "to finish reset\n",
+			     interface, index);
+			return -1;
+		}
+	}
+
+	/*
+	 * Write PCS*_MR*_CONTROL_REG[RST_AN]=1 to ensure a fresh
+	 * sgmii negotiation starts.
+	 */
+	control_reg.s.rst_an = 1;
+	control_reg.s.an_en = 1;
+	control_reg.s.pwr_dn = 0;
+	cvmx_write_csr(CVMX_PCSX_MRX_CONTROL_REG(index, interface),
+		       control_reg.u64);
+
+	/*
+	 * Wait for PCS*_MR*_STATUS_REG[AN_CPT] to be set, indicating
+	 * that sgmii autonegotiation is complete. In MAC mode this
+	 * isn't an ethernet link, but a link between Octeon and the
+	 * PHY.
+	 */
+	if ((cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM) &&
+	    CVMX_WAIT_FOR_FIELD64(CVMX_PCSX_MRX_STATUS_REG(index, interface),
+				  union cvmx_pcsx_mrx_status_reg, an_cpt, ==, 1,
+				  10000)) {
+		/* cvmx_dprintf("SGMII%d: Port %d link timeout\n", interface, index); */
+		return -1;
+	}
+	return 0;
+}
+
+/**
+ * Configure an SGMII link to the specified speed after the SERTES
+ * link is up.
+ *
+ * @interface: Interface to init
+ * @index:     Index of prot on the interface
+ * @link_info: Link state to configure
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_sgmii_hardware_init_link_speed(int interface,
+							int index,
+							cvmx_helper_link_info_t
+							link_info)
+{
+	int is_enabled;
+	union cvmx_gmxx_prtx_cfg gmxx_prtx_cfg;
+	union cvmx_pcsx_miscx_ctl_reg pcsx_miscx_ctl_reg;
+
+	/* Disable GMX before we make any changes. Remember the enable state */
+	gmxx_prtx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	is_enabled = gmxx_prtx_cfg.s.en;
+	gmxx_prtx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmxx_prtx_cfg.u64);
+
+	/* Wait for GMX to be idle */
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_GMXX_PRTX_CFG(index, interface), union cvmx_gmxx_prtx_cfg,
+	     rx_idle, ==, 1, 10000)
+	    || CVMX_WAIT_FOR_FIELD64(CVMX_GMXX_PRTX_CFG(index, interface),
+				     union cvmx_gmxx_prtx_cfg, tx_idle, ==, 1,
+				     10000)) {
+		cvmx_dprintf
+		    ("SGMII%d: Timeout waiting for port %d to be idle\n",
+		     interface, index);
+		return -1;
+	}
+
+	/* Read GMX CFG again to make sure the disable completed */
+	gmxx_prtx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+
+	/*
+	 * Get the misc control for PCS. We will need to set the
+	 * duplication amount.
+	 */
+	pcsx_miscx_ctl_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
+
+	/*
+	 * Use GMXENO to force the link down if the status we get says
+	 * it should be down.
+	 */
+	pcsx_miscx_ctl_reg.s.gmxeno = !link_info.s.link_up;
+
+	/* Only change the duplex setting if the link is up */
+	if (link_info.s.link_up)
+		gmxx_prtx_cfg.s.duplex = link_info.s.full_duplex;
+
+	/* Do speed based setting for GMX */
+	switch (link_info.s.speed) {
+	case 10:
+		gmxx_prtx_cfg.s.speed = 0;
+		gmxx_prtx_cfg.s.speed_msb = 1;
+		gmxx_prtx_cfg.s.slottime = 0;
+		/* Setting from GMX-603 */
+		pcsx_miscx_ctl_reg.s.samp_pt = 25;
+		cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 64);
+		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0);
+		break;
+	case 100:
+		gmxx_prtx_cfg.s.speed = 0;
+		gmxx_prtx_cfg.s.speed_msb = 0;
+		gmxx_prtx_cfg.s.slottime = 0;
+		pcsx_miscx_ctl_reg.s.samp_pt = 0x5;
+		cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 64);
+		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0);
+		break;
+	case 1000:
+		gmxx_prtx_cfg.s.speed = 1;
+		gmxx_prtx_cfg.s.speed_msb = 0;
+		gmxx_prtx_cfg.s.slottime = 1;
+		pcsx_miscx_ctl_reg.s.samp_pt = 1;
+		cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 512);
+		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 8192);
+		break;
+	default:
+		break;
+	}
+
+	/* Write the new misc control for PCS */
+	cvmx_write_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface),
+		       pcsx_miscx_ctl_reg.u64);
+
+	/* Write the new GMX settings with the port still disabled */
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmxx_prtx_cfg.u64);
+
+	/* Read GMX CFG again to make sure the config completed */
+	gmxx_prtx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+
+	/* Restore the enabled / disabled state */
+	gmxx_prtx_cfg.s.en = is_enabled;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmxx_prtx_cfg.u64);
+
+	return 0;
+}
+
+/**
+ * Bring up the SGMII interface to be ready for packet I/O but
+ * leave I/O disabled using the GMX override. This function
+ * follows the bringup documented in 10.6.3 of the manual.
+ *
+ * @interface: Interface to bringup
+ * @num_ports: Number of ports on the interface
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_sgmii_hardware_init(int interface, int num_ports)
+{
+	int index;
+
+	__cvmx_helper_setup_gmx(interface, num_ports);
+
+	for (index = 0; index < num_ports; index++) {
+		int ipd_port = cvmx_helper_get_ipd_port(interface, index);
+		__cvmx_helper_sgmii_hardware_init_one_time(interface, index);
+		__cvmx_helper_sgmii_link_set(ipd_port,
+					     __cvmx_helper_sgmii_link_get
+					     (ipd_port));
+
+	}
+
+	return 0;
+}
+
+/**
+ * Probe a SGMII interface and determine the number of ports
+ * connected to it. The SGMII interface should still be down after
+ * this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+int __cvmx_helper_sgmii_probe(int interface)
+{
+	union cvmx_gmxx_inf_mode mode;
+
+	/*
+	 * Due to errata GMX-700 on CN56XXp1.x and CN52XXp1.x, the
+	 * interface needs to be enabled before IPD otherwise per port
+	 * backpressure may not work properly
+	 */
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+	mode.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_INF_MODE(interface), mode.u64);
+	return 4;
+}
+
+/**
+ * Bringup and enable a SGMII interface. After this call packet
+ * I/O should be fully functional. This is called with IPD
+ * enabled but PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_sgmii_enable(int interface)
+{
+	int num_ports = cvmx_helper_ports_on_interface(interface);
+	int index;
+
+	__cvmx_helper_sgmii_hardware_init(interface, num_ports);
+
+	for (index = 0; index < num_ports; index++) {
+		union cvmx_gmxx_prtx_cfg gmxx_prtx_cfg;
+		gmxx_prtx_cfg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+		gmxx_prtx_cfg.s.en = 1;
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmxx_prtx_cfg.u64);
+		__cvmx_interrupt_pcsx_intx_en_reg_enable(index, interface);
+	}
+	__cvmx_interrupt_pcsxx_int_en_reg_enable(interface);
+	__cvmx_interrupt_gmxx_enable(interface);
+	return 0;
+}
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+cvmx_helper_link_info_t __cvmx_helper_sgmii_link_get(int ipd_port)
+{
+	cvmx_helper_link_info_t result;
+	union cvmx_pcsx_miscx_ctl_reg pcs_misc_ctl_reg;
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+	union cvmx_pcsx_mrx_control_reg pcsx_mrx_control_reg;
+
+	result.u64 = 0;
+
+	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_SIM) {
+		/* The simulator gives you a simulated 1Gbps full duplex link */
+		result.s.link_up = 1;
+		result.s.full_duplex = 1;
+		result.s.speed = 1000;
+		return result;
+	}
+
+	pcsx_mrx_control_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSX_MRX_CONTROL_REG(index, interface));
+	if (pcsx_mrx_control_reg.s.loopbck1) {
+		/* Force 1Gbps full duplex link for internal loopback */
+		result.s.link_up = 1;
+		result.s.full_duplex = 1;
+		result.s.speed = 1000;
+		return result;
+	}
+
+	pcs_misc_ctl_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
+	if (pcs_misc_ctl_reg.s.mode) {
+		/* 1000BASE-X */
+		/* FIXME */
+	} else {
+		union cvmx_pcsx_miscx_ctl_reg pcsx_miscx_ctl_reg;
+		pcsx_miscx_ctl_reg.u64 =
+		    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
+		if (pcsx_miscx_ctl_reg.s.mac_phy) {
+			/* PHY Mode */
+			union cvmx_pcsx_mrx_status_reg pcsx_mrx_status_reg;
+			union cvmx_pcsx_anx_results_reg pcsx_anx_results_reg;
+
+			/*
+			 * Don't bother continuing if the SERTES low
+			 * level link is down
+			 */
+			pcsx_mrx_status_reg.u64 =
+			    cvmx_read_csr(CVMX_PCSX_MRX_STATUS_REG
+					  (index, interface));
+			if (pcsx_mrx_status_reg.s.lnk_st == 0) {
+				if (__cvmx_helper_sgmii_hardware_init_link
+				    (interface, index) != 0)
+					return result;
+			}
+
+			/* Read the autoneg results */
+			pcsx_anx_results_reg.u64 =
+			    cvmx_read_csr(CVMX_PCSX_ANX_RESULTS_REG
+					  (index, interface));
+			if (pcsx_anx_results_reg.s.an_cpt) {
+				/*
+				 * Auto negotiation is complete. Set
+				 * status accordingly.
+				 */
+				result.s.full_duplex =
+				    pcsx_anx_results_reg.s.dup;
+				result.s.link_up =
+				    pcsx_anx_results_reg.s.link_ok;
+				switch (pcsx_anx_results_reg.s.spd) {
+				case 0:
+					result.s.speed = 10;
+					break;
+				case 1:
+					result.s.speed = 100;
+					break;
+				case 2:
+					result.s.speed = 1000;
+					break;
+				default:
+					result.s.speed = 0;
+					result.s.link_up = 0;
+					break;
+				}
+			} else {
+				/*
+				 * Auto negotiation isn't
+				 * complete. Return link down.
+				 */
+				result.s.speed = 0;
+				result.s.link_up = 0;
+			}
+		} else {	/* MAC Mode */
+
+			result = __cvmx_helper_board_link_get(ipd_port);
+		}
+	}
+	return result;
+}
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_sgmii_link_set(int ipd_port,
+				 cvmx_helper_link_info_t link_info)
+{
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+	__cvmx_helper_sgmii_hardware_init_link(interface, index);
+	return __cvmx_helper_sgmii_hardware_init_link_speed(interface, index,
+							    link_info);
+}
+
+/**
+ * Configure a port for internal and/or external loopback. Internal
+ * loopback causes packets sent by the port to be received by
+ * Octeon. External loopback causes packets received from the wire to
+ * sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *                 Non zero if you want internal loopback
+ * @enable_external:
+ *                 Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+int __cvmx_helper_sgmii_configure_loopback(int ipd_port, int enable_internal,
+					   int enable_external)
+{
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+	union cvmx_pcsx_mrx_control_reg pcsx_mrx_control_reg;
+	union cvmx_pcsx_miscx_ctl_reg pcsx_miscx_ctl_reg;
+
+	pcsx_mrx_control_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSX_MRX_CONTROL_REG(index, interface));
+	pcsx_mrx_control_reg.s.loopbck1 = enable_internal;
+	cvmx_write_csr(CVMX_PCSX_MRX_CONTROL_REG(index, interface),
+		       pcsx_mrx_control_reg.u64);
+
+	pcsx_miscx_ctl_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
+	pcsx_miscx_ctl_reg.s.loopbck2 = enable_external;
+	cvmx_write_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface),
+		       pcsx_miscx_ctl_reg.u64);
+
+	__cvmx_helper_sgmii_hardware_init_link(interface, index);
+	return 0;
+}
diff --git a/drivers/staging/octeon/cvmx-helper-sgmii.h b/drivers/staging/octeon/cvmx-helper-sgmii.h
new file mode 100644
index 0000000..19b48d6
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-sgmii.h
@@ -0,0 +1,104 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Functions for SGMII initialization, configuration,
+ * and monitoring.
+ *
+ */
+#ifndef __CVMX_HELPER_SGMII_H__
+#define __CVMX_HELPER_SGMII_H__
+
+/**
+ * Probe a SGMII interface and determine the number of ports
+ * connected to it. The SGMII interface should still be down after
+ * this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+extern int __cvmx_helper_sgmii_probe(int interface);
+
+/**
+ * Bringup and enable a SGMII interface. After this call packet
+ * I/O should be fully functional. This is called with IPD
+ * enabled but PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_sgmii_enable(int interface);
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+extern cvmx_helper_link_info_t __cvmx_helper_sgmii_link_get(int ipd_port);
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_sgmii_link_set(int ipd_port,
+					cvmx_helper_link_info_t link_info);
+
+/**
+ * Configure a port for internal and/or external loopback. Internal loopback
+ * causes packets sent by the port to be received by Octeon. External loopback
+ * causes packets received from the wire to sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *                 Non zero if you want internal loopback
+ * @enable_external:
+ *                 Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+extern int __cvmx_helper_sgmii_configure_loopback(int ipd_port,
+						  int enable_internal,
+						  int enable_external);
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-helper-spi.c b/drivers/staging/octeon/cvmx-helper-spi.c
new file mode 100644
index 0000000..8ba6c83
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-spi.c
@@ -0,0 +1,195 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+void __cvmx_interrupt_gmxx_enable(int interface);
+void __cvmx_interrupt_spxx_int_msk_enable(int index);
+void __cvmx_interrupt_stxx_int_msk_enable(int index);
+
+/*
+ * Functions for SPI initialization, configuration,
+ * and monitoring.
+ */
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+#include "cvmx-spi.h"
+#include "cvmx-helper.h"
+
+#include "cvmx-pip-defs.h"
+#include "cvmx-pko-defs.h"
+
+/*
+ * CVMX_HELPER_SPI_TIMEOUT is used to determine how long the SPI
+ * initialization routines wait for SPI training. You can override the
+ * value using executive-config.h if necessary.
+ */
+#ifndef CVMX_HELPER_SPI_TIMEOUT
+#define CVMX_HELPER_SPI_TIMEOUT 10
+#endif
+
+/**
+ * Probe a SPI interface and determine the number of ports
+ * connected to it. The SPI interface should still be down after
+ * this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+int __cvmx_helper_spi_probe(int interface)
+{
+	int num_ports = 0;
+
+	if ((cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM) &&
+	    cvmx_spi4000_is_present(interface)) {
+		num_ports = 10;
+	} else {
+		union cvmx_pko_reg_crc_enable enable;
+		num_ports = 16;
+		/*
+		 * Unlike the SPI4000, most SPI devices don't
+		 * automatically put on the L2 CRC. For everything
+		 * except for the SPI4000 have PKO append the L2 CRC
+		 * to the packet.
+		 */
+		enable.u64 = cvmx_read_csr(CVMX_PKO_REG_CRC_ENABLE);
+		enable.s.enable |= 0xffff << (interface * 16);
+		cvmx_write_csr(CVMX_PKO_REG_CRC_ENABLE, enable.u64);
+	}
+	__cvmx_helper_setup_gmx(interface, num_ports);
+	return num_ports;
+}
+
+/**
+ * Bringup and enable a SPI interface. After this call packet I/O
+ * should be fully functional. This is called with IPD enabled but
+ * PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_spi_enable(int interface)
+{
+	/*
+	 * Normally the ethernet L2 CRC is checked and stripped in the
+	 * GMX block.  When you are using SPI, this isn' the case and
+	 * IPD needs to check the L2 CRC.
+	 */
+	int num_ports = cvmx_helper_ports_on_interface(interface);
+	int ipd_port;
+	for (ipd_port = interface * 16; ipd_port < interface * 16 + num_ports;
+	     ipd_port++) {
+		union cvmx_pip_prt_cfgx port_config;
+		port_config.u64 = cvmx_read_csr(CVMX_PIP_PRT_CFGX(ipd_port));
+		port_config.s.crc_en = 1;
+		cvmx_write_csr(CVMX_PIP_PRT_CFGX(ipd_port), port_config.u64);
+	}
+
+	if (cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM) {
+		cvmx_spi_start_interface(interface, CVMX_SPI_MODE_DUPLEX,
+					 CVMX_HELPER_SPI_TIMEOUT, num_ports);
+		if (cvmx_spi4000_is_present(interface))
+			cvmx_spi4000_initialize(interface);
+	}
+	__cvmx_interrupt_spxx_int_msk_enable(interface);
+	__cvmx_interrupt_stxx_int_msk_enable(interface);
+	__cvmx_interrupt_gmxx_enable(interface);
+	return 0;
+}
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+cvmx_helper_link_info_t __cvmx_helper_spi_link_get(int ipd_port)
+{
+	cvmx_helper_link_info_t result;
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+	result.u64 = 0;
+
+	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_SIM) {
+		/* The simulator gives you a simulated full duplex link */
+		result.s.link_up = 1;
+		result.s.full_duplex = 1;
+		result.s.speed = 10000;
+	} else if (cvmx_spi4000_is_present(interface)) {
+		union cvmx_gmxx_rxx_rx_inbnd inband =
+		    cvmx_spi4000_check_speed(interface, index);
+		result.s.link_up = inband.s.status;
+		result.s.full_duplex = inband.s.duplex;
+		switch (inband.s.speed) {
+		case 0:	/* 10 Mbps */
+			result.s.speed = 10;
+			break;
+		case 1:	/* 100 Mbps */
+			result.s.speed = 100;
+			break;
+		case 2:	/* 1 Gbps */
+			result.s.speed = 1000;
+			break;
+		case 3:	/* Illegal */
+			result.s.speed = 0;
+			result.s.link_up = 0;
+			break;
+		}
+	} else {
+		/* For generic SPI we can't determine the link, just return some
+		   sane results */
+		result.s.link_up = 1;
+		result.s.full_duplex = 1;
+		result.s.speed = 10000;
+	}
+	return result;
+}
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_spi_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
+{
+	/* Nothing to do. If we have a SPI4000 then the setup was already performed
+	   by cvmx_spi4000_check_speed(). If not then there isn't any link
+	   info */
+	return 0;
+}
diff --git a/drivers/staging/octeon/cvmx-helper-spi.h b/drivers/staging/octeon/cvmx-helper-spi.h
new file mode 100644
index 0000000..69bac03
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-spi.h
@@ -0,0 +1,84 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Functions for SPI initialization, configuration,
+ * and monitoring.
+ */
+#ifndef __CVMX_HELPER_SPI_H__
+#define __CVMX_HELPER_SPI_H__
+
+/**
+ * Probe a SPI interface and determine the number of ports
+ * connected to it. The SPI interface should still be down after
+ * this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+extern int __cvmx_helper_spi_probe(int interface);
+
+/**
+ * Bringup and enable a SPI interface. After this call packet I/O
+ * should be fully functional. This is called with IPD enabled but
+ * PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_spi_enable(int interface);
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+extern cvmx_helper_link_info_t __cvmx_helper_spi_link_get(int ipd_port);
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_spi_link_set(int ipd_port,
+				      cvmx_helper_link_info_t link_info);
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-helper-util.c b/drivers/staging/octeon/cvmx-helper-util.c
new file mode 100644
index 0000000..41ef8a4
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-util.c
@@ -0,0 +1,433 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Small helper utilities.
+ */
+#include <linux/kernel.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+
+#include "cvmx-fpa.h"
+#include "cvmx-pip.h"
+#include "cvmx-pko.h"
+#include "cvmx-ipd.h"
+#include "cvmx-spi.h"
+
+#include "cvmx-helper.h"
+#include "cvmx-helper-util.h"
+
+#include <asm/octeon/cvmx-ipd-defs.h>
+
+/**
+ * Convert a interface mode into a human readable string
+ *
+ * @mode:   Mode to convert
+ *
+ * Returns String
+ */
+const char *cvmx_helper_interface_mode_to_string(cvmx_helper_interface_mode_t
+						 mode)
+{
+	switch (mode) {
+	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+		return "DISABLED";
+	case CVMX_HELPER_INTERFACE_MODE_RGMII:
+		return "RGMII";
+	case CVMX_HELPER_INTERFACE_MODE_GMII:
+		return "GMII";
+	case CVMX_HELPER_INTERFACE_MODE_SPI:
+		return "SPI";
+	case CVMX_HELPER_INTERFACE_MODE_PCIE:
+		return "PCIE";
+	case CVMX_HELPER_INTERFACE_MODE_XAUI:
+		return "XAUI";
+	case CVMX_HELPER_INTERFACE_MODE_SGMII:
+		return "SGMII";
+	case CVMX_HELPER_INTERFACE_MODE_PICMG:
+		return "PICMG";
+	case CVMX_HELPER_INTERFACE_MODE_NPI:
+		return "NPI";
+	case CVMX_HELPER_INTERFACE_MODE_LOOP:
+		return "LOOP";
+	}
+	return "UNKNOWN";
+}
+
+/**
+ * Debug routine to dump the packet structure to the console
+ *
+ * @work:   Work queue entry containing the packet to dump
+ * Returns
+ */
+int cvmx_helper_dump_packet(cvmx_wqe_t *work)
+{
+	uint64_t count;
+	uint64_t remaining_bytes;
+	union cvmx_buf_ptr buffer_ptr;
+	uint64_t start_of_buffer;
+	uint8_t *data_address;
+	uint8_t *end_of_data;
+
+	cvmx_dprintf("Packet Length:   %u\n", work->len);
+	cvmx_dprintf("    Input Port:  %u\n", work->ipprt);
+	cvmx_dprintf("    QoS:         %u\n", work->qos);
+	cvmx_dprintf("    Buffers:     %u\n", work->word2.s.bufs);
+
+	if (work->word2.s.bufs == 0) {
+		union cvmx_ipd_wqe_fpa_queue wqe_pool;
+		wqe_pool.u64 = cvmx_read_csr(CVMX_IPD_WQE_FPA_QUEUE);
+		buffer_ptr.u64 = 0;
+		buffer_ptr.s.pool = wqe_pool.s.wqe_pool;
+		buffer_ptr.s.size = 128;
+		buffer_ptr.s.addr = cvmx_ptr_to_phys(work->packet_data);
+		if (likely(!work->word2.s.not_IP)) {
+			union cvmx_pip_ip_offset pip_ip_offset;
+			pip_ip_offset.u64 = cvmx_read_csr(CVMX_PIP_IP_OFFSET);
+			buffer_ptr.s.addr +=
+			    (pip_ip_offset.s.offset << 3) -
+			    work->word2.s.ip_offset;
+			buffer_ptr.s.addr += (work->word2.s.is_v6 ^ 1) << 2;
+		} else {
+			/*
+			 * WARNING: This code assumes that the packet
+			 * is not RAW. If it was, we would use
+			 * PIP_GBL_CFG[RAW_SHF] instead of
+			 * PIP_GBL_CFG[NIP_SHF].
+			 */
+			union cvmx_pip_gbl_cfg pip_gbl_cfg;
+			pip_gbl_cfg.u64 = cvmx_read_csr(CVMX_PIP_GBL_CFG);
+			buffer_ptr.s.addr += pip_gbl_cfg.s.nip_shf;
+		}
+	} else
+		buffer_ptr = work->packet_ptr;
+	remaining_bytes = work->len;
+
+	while (remaining_bytes) {
+		start_of_buffer =
+		    ((buffer_ptr.s.addr >> 7) - buffer_ptr.s.back) << 7;
+		cvmx_dprintf("    Buffer Start:%llx\n",
+			     (unsigned long long)start_of_buffer);
+		cvmx_dprintf("    Buffer I   : %u\n", buffer_ptr.s.i);
+		cvmx_dprintf("    Buffer Back: %u\n", buffer_ptr.s.back);
+		cvmx_dprintf("    Buffer Pool: %u\n", buffer_ptr.s.pool);
+		cvmx_dprintf("    Buffer Data: %llx\n",
+			     (unsigned long long)buffer_ptr.s.addr);
+		cvmx_dprintf("    Buffer Size: %u\n", buffer_ptr.s.size);
+
+		cvmx_dprintf("\t\t");
+		data_address = (uint8_t *) cvmx_phys_to_ptr(buffer_ptr.s.addr);
+		end_of_data = data_address + buffer_ptr.s.size;
+		count = 0;
+		while (data_address < end_of_data) {
+			if (remaining_bytes == 0)
+				break;
+			else
+				remaining_bytes--;
+			cvmx_dprintf("%02x", (unsigned int)*data_address);
+			data_address++;
+			if (remaining_bytes && (count == 7)) {
+				cvmx_dprintf("\n\t\t");
+				count = 0;
+			} else
+				count++;
+		}
+		cvmx_dprintf("\n");
+
+		if (remaining_bytes)
+			buffer_ptr = *(union cvmx_buf_ptr *)
+				cvmx_phys_to_ptr(buffer_ptr.s.addr - 8);
+	}
+	return 0;
+}
+
+/**
+ * Setup Random Early Drop on a specific input queue
+ *
+ * @queue:  Input queue to setup RED on (0-7)
+ * @pass_thresh:
+ *               Packets will begin slowly dropping when there are less than
+ *               this many packet buffers free in FPA 0.
+ * @drop_thresh:
+ *               All incomming packets will be dropped when there are less
+ *               than this many free packet buffers in FPA 0.
+ * Returns Zero on success. Negative on failure
+ */
+int cvmx_helper_setup_red_queue(int queue, int pass_thresh, int drop_thresh)
+{
+	union cvmx_ipd_qosx_red_marks red_marks;
+	union cvmx_ipd_red_quex_param red_param;
+
+	/* Set RED to begin dropping packets when there are pass_thresh buffers
+	   left. It will linearly drop more packets until reaching drop_thresh
+	   buffers */
+	red_marks.u64 = 0;
+	red_marks.s.drop = drop_thresh;
+	red_marks.s.pass = pass_thresh;
+	cvmx_write_csr(CVMX_IPD_QOSX_RED_MARKS(queue), red_marks.u64);
+
+	/* Use the actual queue 0 counter, not the average */
+	red_param.u64 = 0;
+	red_param.s.prb_con =
+	    (255ul << 24) / (red_marks.s.pass - red_marks.s.drop);
+	red_param.s.avg_con = 1;
+	red_param.s.new_con = 255;
+	red_param.s.use_pcnt = 1;
+	cvmx_write_csr(CVMX_IPD_RED_QUEX_PARAM(queue), red_param.u64);
+	return 0;
+}
+
+/**
+ * Setup Random Early Drop to automatically begin dropping packets.
+ *
+ * @pass_thresh:
+ *               Packets will begin slowly dropping when there are less than
+ *               this many packet buffers free in FPA 0.
+ * @drop_thresh:
+ *               All incomming packets will be dropped when there are less
+ *               than this many free packet buffers in FPA 0.
+ * Returns Zero on success. Negative on failure
+ */
+int cvmx_helper_setup_red(int pass_thresh, int drop_thresh)
+{
+	union cvmx_ipd_portx_bp_page_cnt page_cnt;
+	union cvmx_ipd_bp_prt_red_end ipd_bp_prt_red_end;
+	union cvmx_ipd_red_port_enable red_port_enable;
+	int queue;
+	int interface;
+	int port;
+
+	/* Disable backpressure based on queued buffers. It needs SW support */
+	page_cnt.u64 = 0;
+	page_cnt.s.bp_enb = 0;
+	page_cnt.s.page_cnt = 100;
+	for (interface = 0; interface < 2; interface++) {
+		for (port = cvmx_helper_get_first_ipd_port(interface);
+		     port < cvmx_helper_get_last_ipd_port(interface); port++)
+			cvmx_write_csr(CVMX_IPD_PORTX_BP_PAGE_CNT(port),
+				       page_cnt.u64);
+	}
+
+	for (queue = 0; queue < 8; queue++)
+		cvmx_helper_setup_red_queue(queue, pass_thresh, drop_thresh);
+
+	/* Shutoff the dropping based on the per port page count. SW isn't
+	   decrementing it right now */
+	ipd_bp_prt_red_end.u64 = 0;
+	ipd_bp_prt_red_end.s.prt_enb = 0;
+	cvmx_write_csr(CVMX_IPD_BP_PRT_RED_END, ipd_bp_prt_red_end.u64);
+
+	red_port_enable.u64 = 0;
+	red_port_enable.s.prt_enb = 0xfffffffffull;
+	red_port_enable.s.avg_dly = 10000;
+	red_port_enable.s.prb_dly = 10000;
+	cvmx_write_csr(CVMX_IPD_RED_PORT_ENABLE, red_port_enable.u64);
+
+	return 0;
+}
+
+/**
+ * Setup the common GMX settings that determine the number of
+ * ports. These setting apply to almost all configurations of all
+ * chips.
+ *
+ * @interface: Interface to configure
+ * @num_ports: Number of ports on the interface
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_setup_gmx(int interface, int num_ports)
+{
+	union cvmx_gmxx_tx_prts gmx_tx_prts;
+	union cvmx_gmxx_rx_prts gmx_rx_prts;
+	union cvmx_pko_reg_gmx_port_mode pko_mode;
+	union cvmx_gmxx_txx_thresh gmx_tx_thresh;
+	int index;
+
+	/* Tell GMX the number of TX ports on this interface */
+	gmx_tx_prts.u64 = cvmx_read_csr(CVMX_GMXX_TX_PRTS(interface));
+	gmx_tx_prts.s.prts = num_ports;
+	cvmx_write_csr(CVMX_GMXX_TX_PRTS(interface), gmx_tx_prts.u64);
+
+	/* Tell GMX the number of RX ports on this interface.  This only
+	 ** applies to *GMII and XAUI ports */
+	if (cvmx_helper_interface_get_mode(interface) ==
+	    CVMX_HELPER_INTERFACE_MODE_RGMII
+	    || cvmx_helper_interface_get_mode(interface) ==
+	    CVMX_HELPER_INTERFACE_MODE_SGMII
+	    || cvmx_helper_interface_get_mode(interface) ==
+	    CVMX_HELPER_INTERFACE_MODE_GMII
+	    || cvmx_helper_interface_get_mode(interface) ==
+	    CVMX_HELPER_INTERFACE_MODE_XAUI) {
+		if (num_ports > 4) {
+			cvmx_dprintf("__cvmx_helper_setup_gmx: Illegal "
+				     "num_ports\n");
+			return -1;
+		}
+
+		gmx_rx_prts.u64 = cvmx_read_csr(CVMX_GMXX_RX_PRTS(interface));
+		gmx_rx_prts.s.prts = num_ports;
+		cvmx_write_csr(CVMX_GMXX_RX_PRTS(interface), gmx_rx_prts.u64);
+	}
+
+	/* Skip setting CVMX_PKO_REG_GMX_PORT_MODE on 30XX, 31XX, and 50XX */
+	if (!OCTEON_IS_MODEL(OCTEON_CN30XX) && !OCTEON_IS_MODEL(OCTEON_CN31XX)
+	    && !OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		/* Tell PKO the number of ports on this interface */
+		pko_mode.u64 = cvmx_read_csr(CVMX_PKO_REG_GMX_PORT_MODE);
+		if (interface == 0) {
+			if (num_ports == 1)
+				pko_mode.s.mode0 = 4;
+			else if (num_ports == 2)
+				pko_mode.s.mode0 = 3;
+			else if (num_ports <= 4)
+				pko_mode.s.mode0 = 2;
+			else if (num_ports <= 8)
+				pko_mode.s.mode0 = 1;
+			else
+				pko_mode.s.mode0 = 0;
+		} else {
+			if (num_ports == 1)
+				pko_mode.s.mode1 = 4;
+			else if (num_ports == 2)
+				pko_mode.s.mode1 = 3;
+			else if (num_ports <= 4)
+				pko_mode.s.mode1 = 2;
+			else if (num_ports <= 8)
+				pko_mode.s.mode1 = 1;
+			else
+				pko_mode.s.mode1 = 0;
+		}
+		cvmx_write_csr(CVMX_PKO_REG_GMX_PORT_MODE, pko_mode.u64);
+	}
+
+	/*
+	 * Set GMX to buffer as much data as possible before starting
+	 * transmit.  This reduces the chances that we have a TX under
+	 * run due to memory contention. Any packet that fits entirely
+	 * in the GMX FIFO can never have an under run regardless of
+	 * memory load.
+	 */
+	gmx_tx_thresh.u64 = cvmx_read_csr(CVMX_GMXX_TXX_THRESH(0, interface));
+	if (OCTEON_IS_MODEL(OCTEON_CN30XX) || OCTEON_IS_MODEL(OCTEON_CN31XX)
+	    || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		/* These chips have a fixed max threshold of 0x40 */
+		gmx_tx_thresh.s.cnt = 0x40;
+	} else {
+		/* Choose the max value for the number of ports */
+		if (num_ports <= 1)
+			gmx_tx_thresh.s.cnt = 0x100 / 1;
+		else if (num_ports == 2)
+			gmx_tx_thresh.s.cnt = 0x100 / 2;
+		else
+			gmx_tx_thresh.s.cnt = 0x100 / 4;
+	}
+	/*
+	 * SPI and XAUI can have lots of ports but the GMX hardware
+	 * only ever has a max of 4.
+	 */
+	if (num_ports > 4)
+		num_ports = 4;
+	for (index = 0; index < num_ports; index++)
+		cvmx_write_csr(CVMX_GMXX_TXX_THRESH(index, interface),
+			       gmx_tx_thresh.u64);
+
+	return 0;
+}
+
+/**
+ * Returns the IPD/PKO port number for a port on teh given
+ * interface.
+ *
+ * @interface: Interface to use
+ * @port:      Port on the interface
+ *
+ * Returns IPD/PKO port number
+ */
+int cvmx_helper_get_ipd_port(int interface, int port)
+{
+	switch (interface) {
+	case 0:
+		return port;
+	case 1:
+		return port + 16;
+	case 2:
+		return port + 32;
+	case 3:
+		return port + 36;
+	}
+	return -1;
+}
+
+/**
+ * Returns the interface number for an IPD/PKO port number.
+ *
+ * @ipd_port: IPD/PKO port number
+ *
+ * Returns Interface number
+ */
+int cvmx_helper_get_interface_num(int ipd_port)
+{
+	if (ipd_port < 16)
+		return 0;
+	else if (ipd_port < 32)
+		return 1;
+	else if (ipd_port < 36)
+		return 2;
+	else if (ipd_port < 40)
+		return 3;
+	else
+		cvmx_dprintf("cvmx_helper_get_interface_num: Illegal IPD "
+			     "port number\n");
+
+	return -1;
+}
+
+/**
+ * Returns the interface index number for an IPD/PKO port
+ * number.
+ *
+ * @ipd_port: IPD/PKO port number
+ *
+ * Returns Interface index number
+ */
+int cvmx_helper_get_interface_index_num(int ipd_port)
+{
+	if (ipd_port < 32)
+		return ipd_port & 15;
+	else if (ipd_port < 36)
+		return ipd_port & 3;
+	else if (ipd_port < 40)
+		return ipd_port & 3;
+	else
+		cvmx_dprintf("cvmx_helper_get_interface_index_num: "
+			     "Illegal IPD port number\n");
+
+	return -1;
+}
diff --git a/drivers/staging/octeon/cvmx-helper-util.h b/drivers/staging/octeon/cvmx-helper-util.h
new file mode 100644
index 0000000..6a6e52f
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-util.h
@@ -0,0 +1,215 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * Small helper utilities.
+ *
+ */
+
+#ifndef __CVMX_HELPER_UTIL_H__
+#define __CVMX_HELPER_UTIL_H__
+
+/**
+ * Convert a interface mode into a human readable string
+ *
+ * @mode:   Mode to convert
+ *
+ * Returns String
+ */
+extern const char
+    *cvmx_helper_interface_mode_to_string(cvmx_helper_interface_mode_t mode);
+
+/**
+ * Debug routine to dump the packet structure to the console
+ *
+ * @work:   Work queue entry containing the packet to dump
+ * Returns
+ */
+extern int cvmx_helper_dump_packet(cvmx_wqe_t *work);
+
+/**
+ * Setup Random Early Drop on a specific input queue
+ *
+ * @queue:  Input queue to setup RED on (0-7)
+ * @pass_thresh:
+ *               Packets will begin slowly dropping when there are less than
+ *               this many packet buffers free in FPA 0.
+ * @drop_thresh:
+ *               All incomming packets will be dropped when there are less
+ *               than this many free packet buffers in FPA 0.
+ * Returns Zero on success. Negative on failure
+ */
+extern int cvmx_helper_setup_red_queue(int queue, int pass_thresh,
+				       int drop_thresh);
+
+/**
+ * Setup Random Early Drop to automatically begin dropping packets.
+ *
+ * @pass_thresh:
+ *               Packets will begin slowly dropping when there are less than
+ *               this many packet buffers free in FPA 0.
+ * @drop_thresh:
+ *               All incomming packets will be dropped when there are less
+ *               than this many free packet buffers in FPA 0.
+ * Returns Zero on success. Negative on failure
+ */
+extern int cvmx_helper_setup_red(int pass_thresh, int drop_thresh);
+
+/**
+ * Get the version of the CVMX libraries.
+ *
+ * Returns Version string. Note this buffer is allocated statically
+ *         and will be shared by all callers.
+ */
+extern const char *cvmx_helper_get_version(void);
+
+/**
+ * Setup the common GMX settings that determine the number of
+ * ports. These setting apply to almost all configurations of all
+ * chips.
+ *
+ * @interface: Interface to configure
+ * @num_ports: Number of ports on the interface
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_setup_gmx(int interface, int num_ports);
+
+/**
+ * Returns the IPD/PKO port number for a port on the given
+ * interface.
+ *
+ * @interface: Interface to use
+ * @port:      Port on the interface
+ *
+ * Returns IPD/PKO port number
+ */
+extern int cvmx_helper_get_ipd_port(int interface, int port);
+
+/**
+ * Returns the IPD/PKO port number for the first port on the given
+ * interface.
+ *
+ * @interface: Interface to use
+ *
+ * Returns IPD/PKO port number
+ */
+static inline int cvmx_helper_get_first_ipd_port(int interface)
+{
+	return cvmx_helper_get_ipd_port(interface, 0);
+}
+
+/**
+ * Returns the IPD/PKO port number for the last port on the given
+ * interface.
+ *
+ * @interface: Interface to use
+ *
+ * Returns IPD/PKO port number
+ */
+static inline int cvmx_helper_get_last_ipd_port(int interface)
+{
+	extern int cvmx_helper_ports_on_interface(int interface);
+
+	return cvmx_helper_get_first_ipd_port(interface) +
+	       cvmx_helper_ports_on_interface(interface) - 1;
+}
+
+/**
+ * Free the packet buffers contained in a work queue entry.
+ * The work queue entry is not freed.
+ *
+ * @work:   Work queue entry with packet to free
+ */
+static inline void cvmx_helper_free_packet_data(cvmx_wqe_t *work)
+{
+	uint64_t number_buffers;
+	union cvmx_buf_ptr buffer_ptr;
+	union cvmx_buf_ptr next_buffer_ptr;
+	uint64_t start_of_buffer;
+
+	number_buffers = work->word2.s.bufs;
+	if (number_buffers == 0)
+		return;
+	buffer_ptr = work->packet_ptr;
+
+	/*
+	 * Since the number of buffers is not zero, we know this is
+	 * not a dynamic short packet. We need to check if it is a
+	 * packet received with IPD_CTL_STATUS[NO_WPTR]. If this is
+	 * true, we need to free all buffers except for the first
+	 * one. The caller doesn't expect their WQE pointer to be
+	 * freed
+	 */
+	start_of_buffer = ((buffer_ptr.s.addr >> 7) - buffer_ptr.s.back) << 7;
+	if (cvmx_ptr_to_phys(work) == start_of_buffer) {
+		next_buffer_ptr =
+		    *(union cvmx_buf_ptr *) cvmx_phys_to_ptr(buffer_ptr.s.addr - 8);
+		buffer_ptr = next_buffer_ptr;
+		number_buffers--;
+	}
+
+	while (number_buffers--) {
+		/*
+		 * Remember the back pointer is in cache lines, not
+		 * 64bit words
+		 */
+		start_of_buffer =
+		    ((buffer_ptr.s.addr >> 7) - buffer_ptr.s.back) << 7;
+		/*
+		 * Read pointer to next buffer before we free the
+		 * current buffer.
+		 */
+		next_buffer_ptr =
+		    *(union cvmx_buf_ptr *) cvmx_phys_to_ptr(buffer_ptr.s.addr - 8);
+		cvmx_fpa_free(cvmx_phys_to_ptr(start_of_buffer),
+			      buffer_ptr.s.pool, 0);
+		buffer_ptr = next_buffer_ptr;
+	}
+}
+
+/**
+ * Returns the interface number for an IPD/PKO port number.
+ *
+ * @ipd_port: IPD/PKO port number
+ *
+ * Returns Interface number
+ */
+extern int cvmx_helper_get_interface_num(int ipd_port);
+
+/**
+ * Returns the interface index number for an IPD/PKO port
+ * number.
+ *
+ * @ipd_port: IPD/PKO port number
+ *
+ * Returns Interface index number
+ */
+extern int cvmx_helper_get_interface_index_num(int ipd_port);
+
+#endif /* __CVMX_HELPER_H__ */
diff --git a/drivers/staging/octeon/cvmx-helper-xaui.c b/drivers/staging/octeon/cvmx-helper-xaui.c
new file mode 100644
index 0000000..a11e676
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-xaui.c
@@ -0,0 +1,348 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Functions for XAUI initialization, configuration,
+ * and monitoring.
+ *
+ */
+
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+
+#include "cvmx-helper.h"
+
+#include "cvmx-pko-defs.h"
+#include "cvmx-gmxx-defs.h"
+#include "cvmx-pcsxx-defs.h"
+
+void __cvmx_interrupt_gmxx_enable(int interface);
+void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
+void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
+/**
+ * Probe a XAUI interface and determine the number of ports
+ * connected to it. The XAUI interface should still be down
+ * after this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+int __cvmx_helper_xaui_probe(int interface)
+{
+	int i;
+	union cvmx_gmxx_hg2_control gmx_hg2_control;
+	union cvmx_gmxx_inf_mode mode;
+
+	/*
+	 * Due to errata GMX-700 on CN56XXp1.x and CN52XXp1.x, the
+	 * interface needs to be enabled before IPD otherwise per port
+	 * backpressure may not work properly.
+	 */
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+	mode.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_INF_MODE(interface), mode.u64);
+
+	__cvmx_helper_setup_gmx(interface, 1);
+
+	/*
+	 * Setup PKO to support 16 ports for HiGig2 virtual
+	 * ports. We're pointing all of the PKO packet ports for this
+	 * interface to the XAUI. This allows us to use HiGig2
+	 * backpressure per port.
+	 */
+	for (i = 0; i < 16; i++) {
+		union cvmx_pko_mem_port_ptrs pko_mem_port_ptrs;
+		pko_mem_port_ptrs.u64 = 0;
+		/*
+		 * We set each PKO port to have equal priority in a
+		 * round robin fashion.
+		 */
+		pko_mem_port_ptrs.s.static_p = 0;
+		pko_mem_port_ptrs.s.qos_mask = 0xff;
+		/* All PKO ports map to the same XAUI hardware port */
+		pko_mem_port_ptrs.s.eid = interface * 4;
+		pko_mem_port_ptrs.s.pid = interface * 16 + i;
+		cvmx_write_csr(CVMX_PKO_MEM_PORT_PTRS, pko_mem_port_ptrs.u64);
+	}
+
+	/* If HiGig2 is enabled return 16 ports, otherwise return 1 port */
+	gmx_hg2_control.u64 = cvmx_read_csr(CVMX_GMXX_HG2_CONTROL(interface));
+	if (gmx_hg2_control.s.hg2tx_en)
+		return 16;
+	else
+		return 1;
+}
+
+/**
+ * Bringup and enable a XAUI interface. After this call packet
+ * I/O should be fully functional. This is called with IPD
+ * enabled but PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_xaui_enable(int interface)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	union cvmx_pcsxx_control1_reg xauiCtl;
+	union cvmx_pcsxx_misc_ctl_reg xauiMiscCtl;
+	union cvmx_gmxx_tx_xaui_ctl gmxXauiTxCtl;
+	union cvmx_gmxx_rxx_int_en gmx_rx_int_en;
+	union cvmx_gmxx_tx_int_en gmx_tx_int_en;
+	union cvmx_pcsxx_int_en_reg pcsx_int_en_reg;
+
+	/* (1) Interface has already been enabled. */
+
+	/* (2) Disable GMX. */
+	xauiMiscCtl.u64 = cvmx_read_csr(CVMX_PCSXX_MISC_CTL_REG(interface));
+	xauiMiscCtl.s.gmxeno = 1;
+	cvmx_write_csr(CVMX_PCSXX_MISC_CTL_REG(interface), xauiMiscCtl.u64);
+
+	/* (3) Disable GMX and PCSX interrupts. */
+	gmx_rx_int_en.u64 = cvmx_read_csr(CVMX_GMXX_RXX_INT_EN(0, interface));
+	cvmx_write_csr(CVMX_GMXX_RXX_INT_EN(0, interface), 0x0);
+	gmx_tx_int_en.u64 = cvmx_read_csr(CVMX_GMXX_TX_INT_EN(interface));
+	cvmx_write_csr(CVMX_GMXX_TX_INT_EN(interface), 0x0);
+	pcsx_int_en_reg.u64 = cvmx_read_csr(CVMX_PCSXX_INT_EN_REG(interface));
+	cvmx_write_csr(CVMX_PCSXX_INT_EN_REG(interface), 0x0);
+
+	/* (4) Bring up the PCSX and GMX reconciliation layer. */
+	/* (4)a Set polarity and lane swapping. */
+	/* (4)b */
+	gmxXauiTxCtl.u64 = cvmx_read_csr(CVMX_GMXX_TX_XAUI_CTL(interface));
+	/* Enable better IFG packing and improves performance */
+	gmxXauiTxCtl.s.dic_en = 1;
+	gmxXauiTxCtl.s.uni_en = 0;
+	cvmx_write_csr(CVMX_GMXX_TX_XAUI_CTL(interface), gmxXauiTxCtl.u64);
+
+	/* (4)c Aply reset sequence */
+	xauiCtl.u64 = cvmx_read_csr(CVMX_PCSXX_CONTROL1_REG(interface));
+	xauiCtl.s.lo_pwr = 0;
+	xauiCtl.s.reset = 1;
+	cvmx_write_csr(CVMX_PCSXX_CONTROL1_REG(interface), xauiCtl.u64);
+
+	/* Wait for PCS to come out of reset */
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_PCSXX_CONTROL1_REG(interface), union cvmx_pcsxx_control1_reg,
+	     reset, ==, 0, 10000))
+		return -1;
+	/* Wait for PCS to be aligned */
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_PCSXX_10GBX_STATUS_REG(interface),
+	     union cvmx_pcsxx_10gbx_status_reg, alignd, ==, 1, 10000))
+		return -1;
+	/* Wait for RX to be ready */
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_GMXX_RX_XAUI_CTL(interface), union cvmx_gmxx_rx_xaui_ctl,
+		    status, ==, 0, 10000))
+		return -1;
+
+	/* (6) Configure GMX */
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(0, interface));
+	gmx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(0, interface), gmx_cfg.u64);
+
+	/* Wait for GMX RX to be idle */
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_GMXX_PRTX_CFG(0, interface), union cvmx_gmxx_prtx_cfg,
+		    rx_idle, ==, 1, 10000))
+		return -1;
+	/* Wait for GMX TX to be idle */
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_GMXX_PRTX_CFG(0, interface), union cvmx_gmxx_prtx_cfg,
+		    tx_idle, ==, 1, 10000))
+		return -1;
+
+	/* GMX configure */
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(0, interface));
+	gmx_cfg.s.speed = 1;
+	gmx_cfg.s.speed_msb = 0;
+	gmx_cfg.s.slottime = 1;
+	cvmx_write_csr(CVMX_GMXX_TX_PRTS(interface), 1);
+	cvmx_write_csr(CVMX_GMXX_TXX_SLOT(0, interface), 512);
+	cvmx_write_csr(CVMX_GMXX_TXX_BURST(0, interface), 8192);
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(0, interface), gmx_cfg.u64);
+
+	/* (7) Clear out any error state */
+	cvmx_write_csr(CVMX_GMXX_RXX_INT_REG(0, interface),
+		       cvmx_read_csr(CVMX_GMXX_RXX_INT_REG(0, interface)));
+	cvmx_write_csr(CVMX_GMXX_TX_INT_REG(interface),
+		       cvmx_read_csr(CVMX_GMXX_TX_INT_REG(interface)));
+	cvmx_write_csr(CVMX_PCSXX_INT_REG(interface),
+		       cvmx_read_csr(CVMX_PCSXX_INT_REG(interface)));
+
+	/* Wait for receive link */
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_PCSXX_STATUS1_REG(interface), union cvmx_pcsxx_status1_reg,
+	     rcv_lnk, ==, 1, 10000))
+		return -1;
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_PCSXX_STATUS2_REG(interface), union cvmx_pcsxx_status2_reg,
+	     xmtflt, ==, 0, 10000))
+		return -1;
+	if (CVMX_WAIT_FOR_FIELD64
+	    (CVMX_PCSXX_STATUS2_REG(interface), union cvmx_pcsxx_status2_reg,
+	     rcvflt, ==, 0, 10000))
+		return -1;
+
+	cvmx_write_csr(CVMX_GMXX_RXX_INT_EN(0, interface), gmx_rx_int_en.u64);
+	cvmx_write_csr(CVMX_GMXX_TX_INT_EN(interface), gmx_tx_int_en.u64);
+	cvmx_write_csr(CVMX_PCSXX_INT_EN_REG(interface), pcsx_int_en_reg.u64);
+
+	cvmx_helper_link_autoconf(cvmx_helper_get_ipd_port(interface, 0));
+
+	/* (8) Enable packet reception */
+	xauiMiscCtl.s.gmxeno = 0;
+	cvmx_write_csr(CVMX_PCSXX_MISC_CTL_REG(interface), xauiMiscCtl.u64);
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(0, interface));
+	gmx_cfg.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(0, interface), gmx_cfg.u64);
+
+	__cvmx_interrupt_pcsx_intx_en_reg_enable(0, interface);
+	__cvmx_interrupt_pcsx_intx_en_reg_enable(1, interface);
+	__cvmx_interrupt_pcsx_intx_en_reg_enable(2, interface);
+	__cvmx_interrupt_pcsx_intx_en_reg_enable(3, interface);
+	__cvmx_interrupt_pcsxx_int_en_reg_enable(interface);
+	__cvmx_interrupt_gmxx_enable(interface);
+
+	return 0;
+}
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+cvmx_helper_link_info_t __cvmx_helper_xaui_link_get(int ipd_port)
+{
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	union cvmx_gmxx_tx_xaui_ctl gmxx_tx_xaui_ctl;
+	union cvmx_gmxx_rx_xaui_ctl gmxx_rx_xaui_ctl;
+	union cvmx_pcsxx_status1_reg pcsxx_status1_reg;
+	cvmx_helper_link_info_t result;
+
+	gmxx_tx_xaui_ctl.u64 = cvmx_read_csr(CVMX_GMXX_TX_XAUI_CTL(interface));
+	gmxx_rx_xaui_ctl.u64 = cvmx_read_csr(CVMX_GMXX_RX_XAUI_CTL(interface));
+	pcsxx_status1_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSXX_STATUS1_REG(interface));
+	result.u64 = 0;
+
+	/* Only return a link if both RX and TX are happy */
+	if ((gmxx_tx_xaui_ctl.s.ls == 0) && (gmxx_rx_xaui_ctl.s.status == 0) &&
+	    (pcsxx_status1_reg.s.rcv_lnk == 1)) {
+		result.s.link_up = 1;
+		result.s.full_duplex = 1;
+		result.s.speed = 10000;
+	} else {
+		/* Disable GMX and PCSX interrupts. */
+		cvmx_write_csr(CVMX_GMXX_RXX_INT_EN(0, interface), 0x0);
+		cvmx_write_csr(CVMX_GMXX_TX_INT_EN(interface), 0x0);
+		cvmx_write_csr(CVMX_PCSXX_INT_EN_REG(interface), 0x0);
+	}
+	return result;
+}
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_xaui_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
+{
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	union cvmx_gmxx_tx_xaui_ctl gmxx_tx_xaui_ctl;
+	union cvmx_gmxx_rx_xaui_ctl gmxx_rx_xaui_ctl;
+
+	gmxx_tx_xaui_ctl.u64 = cvmx_read_csr(CVMX_GMXX_TX_XAUI_CTL(interface));
+	gmxx_rx_xaui_ctl.u64 = cvmx_read_csr(CVMX_GMXX_RX_XAUI_CTL(interface));
+
+	/* If the link shouldn't be up, then just return */
+	if (!link_info.s.link_up)
+		return 0;
+
+	/* Do nothing if both RX and TX are happy */
+	if ((gmxx_tx_xaui_ctl.s.ls == 0) && (gmxx_rx_xaui_ctl.s.status == 0))
+		return 0;
+
+	/* Bring the link up */
+	return __cvmx_helper_xaui_enable(interface);
+}
+
+/**
+ * Configure a port for internal and/or external loopback. Internal loopback
+ * causes packets sent by the port to be received by Octeon. External loopback
+ * causes packets received from the wire to sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *                 Non zero if you want internal loopback
+ * @enable_external:
+ *                 Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+extern int __cvmx_helper_xaui_configure_loopback(int ipd_port,
+						 int enable_internal,
+						 int enable_external)
+{
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	union cvmx_pcsxx_control1_reg pcsxx_control1_reg;
+	union cvmx_gmxx_xaui_ext_loopback gmxx_xaui_ext_loopback;
+
+	/* Set the internal loop */
+	pcsxx_control1_reg.u64 =
+	    cvmx_read_csr(CVMX_PCSXX_CONTROL1_REG(interface));
+	pcsxx_control1_reg.s.loopbck1 = enable_internal;
+	cvmx_write_csr(CVMX_PCSXX_CONTROL1_REG(interface),
+		       pcsxx_control1_reg.u64);
+
+	/* Set the external loop */
+	gmxx_xaui_ext_loopback.u64 =
+	    cvmx_read_csr(CVMX_GMXX_XAUI_EXT_LOOPBACK(interface));
+	gmxx_xaui_ext_loopback.s.en = enable_external;
+	cvmx_write_csr(CVMX_GMXX_XAUI_EXT_LOOPBACK(interface),
+		       gmxx_xaui_ext_loopback.u64);
+
+	/* Take the link through a reset */
+	return __cvmx_helper_xaui_enable(interface);
+}
diff --git a/drivers/staging/octeon/cvmx-helper-xaui.h b/drivers/staging/octeon/cvmx-helper-xaui.h
new file mode 100644
index 0000000..4b4db2f
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-xaui.h
@@ -0,0 +1,103 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Functions for XAUI initialization, configuration,
+ * and monitoring.
+ *
+ */
+#ifndef __CVMX_HELPER_XAUI_H__
+#define __CVMX_HELPER_XAUI_H__
+
+/**
+ * Probe a XAUI interface and determine the number of ports
+ * connected to it. The XAUI interface should still be down
+ * after this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+extern int __cvmx_helper_xaui_probe(int interface);
+
+/**
+ * Bringup and enable a XAUI interface. After this call packet
+ * I/O should be fully functional. This is called with IPD
+ * enabled but PKO disabled.
+ *
+ * @interface: Interface to bring up
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_xaui_enable(int interface);
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+extern cvmx_helper_link_info_t __cvmx_helper_xaui_link_get(int ipd_port);
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_xaui_link_set(int ipd_port,
+				       cvmx_helper_link_info_t link_info);
+
+/**
+ * Configure a port for internal and/or external loopback. Internal loopback
+ * causes packets sent by the port to be received by Octeon. External loopback
+ * causes packets received from the wire to sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *                 Non zero if you want internal loopback
+ * @enable_external:
+ *                 Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+extern int __cvmx_helper_xaui_configure_loopback(int ipd_port,
+						 int enable_internal,
+						 int enable_external);
+#endif
diff --git a/drivers/staging/octeon/cvmx-helper.c b/drivers/staging/octeon/cvmx-helper.c
new file mode 100644
index 0000000..5915066
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper.c
@@ -0,0 +1,1058 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * Helper functions for common, but complicated tasks.
+ *
+ */
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+
+#include "cvmx-fpa.h"
+#include "cvmx-pip.h"
+#include "cvmx-pko.h"
+#include "cvmx-ipd.h"
+#include "cvmx-spi.h"
+#include "cvmx-helper.h"
+#include "cvmx-helper-board.h"
+
+#include "cvmx-pip-defs.h"
+#include "cvmx-smix-defs.h"
+#include "cvmx-asxx-defs.h"
+
+/**
+ * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
+ * priorities[16]) is a function pointer. It is meant to allow
+ * customization of the PKO queue priorities based on the port
+ * number. Users should set this pointer to a function before
+ * calling any cvmx-helper operations.
+ */
+void (*cvmx_override_pko_queue_priority) (int pko_port,
+					  uint64_t priorities[16]);
+
+/**
+ * cvmx_override_ipd_port_setup(int ipd_port) is a function
+ * pointer. It is meant to allow customization of the IPD port
+ * setup before packet input/output comes online. It is called
+ * after cvmx-helper does the default IPD configuration, but
+ * before IPD is enabled. Users should set this pointer to a
+ * function before calling any cvmx-helper operations.
+ */
+void (*cvmx_override_ipd_port_setup) (int ipd_port);
+
+/* Port count per interface */
+static int interface_port_count[4] = { 0, 0, 0, 0 };
+
+/* Port last configured link info index by IPD/PKO port */
+static cvmx_helper_link_info_t
+    port_link_info[CVMX_PIP_NUM_INPUT_PORTS];
+
+/**
+ * Return the number of interfaces the chip has. Each interface
+ * may have multiple ports. Most chips support two interfaces,
+ * but the CNX0XX and CNX1XX are exceptions. These only support
+ * one interface.
+ *
+ * Returns Number of interfaces on chip
+ */
+int cvmx_helper_get_number_of_interfaces(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
+		return 4;
+	else
+		return 3;
+}
+
+/**
+ * Return the number of ports on an interface. Depending on the
+ * chip and configuration, this can be 1-16. A value of 0
+ * specifies that the interface doesn't exist or isn't usable.
+ *
+ * @interface: Interface to get the port count for
+ *
+ * Returns Number of ports on interface. Can be Zero.
+ */
+int cvmx_helper_ports_on_interface(int interface)
+{
+	return interface_port_count[interface];
+}
+
+/**
+ * Get the operating mode of an interface. Depending on the Octeon
+ * chip and configuration, this function returns an enumeration
+ * of the type of packet I/O supported by an interface.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Mode of the interface. Unknown or unsupported interfaces return
+ *         DISABLED.
+ */
+cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int interface)
+{
+	union cvmx_gmxx_inf_mode mode;
+	if (interface == 2)
+		return CVMX_HELPER_INTERFACE_MODE_NPI;
+
+	if (interface == 3) {
+		if (OCTEON_IS_MODEL(OCTEON_CN56XX)
+		    || OCTEON_IS_MODEL(OCTEON_CN52XX))
+			return CVMX_HELPER_INTERFACE_MODE_LOOP;
+		else
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+	}
+
+	if (interface == 0
+	    && cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_CN3005_EVB_HS5
+	    && cvmx_sysinfo_get()->board_rev_major == 1) {
+		/*
+		 * Lie about interface type of CN3005 board.  This
+		 * board has a switch on port 1 like the other
+		 * evaluation boards, but it is connected over RGMII
+		 * instead of GMII.  Report GMII mode so that the
+		 * speed is forced to 1 Gbit full duplex.  Other than
+		 * some initial configuration (which does not use the
+		 * output of this function) there is no difference in
+		 * setup between GMII and RGMII modes.
+		 */
+		return CVMX_HELPER_INTERFACE_MODE_GMII;
+	}
+
+	/* Interface 1 is always disabled on CN31XX and CN30XX */
+	if ((interface == 1)
+	    && (OCTEON_IS_MODEL(OCTEON_CN31XX) || OCTEON_IS_MODEL(OCTEON_CN30XX)
+		|| OCTEON_IS_MODEL(OCTEON_CN50XX)
+		|| OCTEON_IS_MODEL(OCTEON_CN52XX)))
+		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		switch (mode.cn56xx.mode) {
+		case 0:
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+		case 1:
+			return CVMX_HELPER_INTERFACE_MODE_XAUI;
+		case 2:
+			return CVMX_HELPER_INTERFACE_MODE_SGMII;
+		case 3:
+			return CVMX_HELPER_INTERFACE_MODE_PICMG;
+		default:
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+		}
+	} else {
+		if (!mode.s.en)
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+		if (mode.s.type) {
+			if (OCTEON_IS_MODEL(OCTEON_CN38XX)
+			    || OCTEON_IS_MODEL(OCTEON_CN58XX))
+				return CVMX_HELPER_INTERFACE_MODE_SPI;
+			else
+				return CVMX_HELPER_INTERFACE_MODE_GMII;
+		} else
+			return CVMX_HELPER_INTERFACE_MODE_RGMII;
+	}
+}
+
+/**
+ * Configure the IPD/PIP tagging and QoS options for a specific
+ * port. This function determines the POW work queue entry
+ * contents for a port. The setup performed here is controlled by
+ * the defines in executive-config.h.
+ *
+ * @ipd_port: Port to configure. This follows the IPD numbering, not the
+ *                 per interface numbering
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_port_setup_ipd(int ipd_port)
+{
+	union cvmx_pip_prt_cfgx port_config;
+	union cvmx_pip_prt_tagx tag_config;
+
+	port_config.u64 = cvmx_read_csr(CVMX_PIP_PRT_CFGX(ipd_port));
+	tag_config.u64 = cvmx_read_csr(CVMX_PIP_PRT_TAGX(ipd_port));
+
+	/* Have each port go to a different POW queue */
+	port_config.s.qos = ipd_port & 0x7;
+
+	/* Process the headers and place the IP header in the work queue */
+	port_config.s.mode = CVMX_HELPER_INPUT_PORT_SKIP_MODE;
+
+	tag_config.s.ip6_src_flag = CVMX_HELPER_INPUT_TAG_IPV6_SRC_IP;
+	tag_config.s.ip6_dst_flag = CVMX_HELPER_INPUT_TAG_IPV6_DST_IP;
+	tag_config.s.ip6_sprt_flag = CVMX_HELPER_INPUT_TAG_IPV6_SRC_PORT;
+	tag_config.s.ip6_dprt_flag = CVMX_HELPER_INPUT_TAG_IPV6_DST_PORT;
+	tag_config.s.ip6_nxth_flag = CVMX_HELPER_INPUT_TAG_IPV6_NEXT_HEADER;
+	tag_config.s.ip4_src_flag = CVMX_HELPER_INPUT_TAG_IPV4_SRC_IP;
+	tag_config.s.ip4_dst_flag = CVMX_HELPER_INPUT_TAG_IPV4_DST_IP;
+	tag_config.s.ip4_sprt_flag = CVMX_HELPER_INPUT_TAG_IPV4_SRC_PORT;
+	tag_config.s.ip4_dprt_flag = CVMX_HELPER_INPUT_TAG_IPV4_DST_PORT;
+	tag_config.s.ip4_pctl_flag = CVMX_HELPER_INPUT_TAG_IPV4_PROTOCOL;
+	tag_config.s.inc_prt_flag = CVMX_HELPER_INPUT_TAG_INPUT_PORT;
+	tag_config.s.tcp6_tag_type = CVMX_HELPER_INPUT_TAG_TYPE;
+	tag_config.s.tcp4_tag_type = CVMX_HELPER_INPUT_TAG_TYPE;
+	tag_config.s.ip6_tag_type = CVMX_HELPER_INPUT_TAG_TYPE;
+	tag_config.s.ip4_tag_type = CVMX_HELPER_INPUT_TAG_TYPE;
+	tag_config.s.non_tag_type = CVMX_HELPER_INPUT_TAG_TYPE;
+	/* Put all packets in group 0. Other groups can be used by the app */
+	tag_config.s.grp = 0;
+
+	cvmx_pip_config_port(ipd_port, port_config, tag_config);
+
+	/* Give the user a chance to override our setting for each port */
+	if (cvmx_override_ipd_port_setup)
+		cvmx_override_ipd_port_setup(ipd_port);
+
+	return 0;
+}
+
+/**
+ * This function probes an interface to determine the actual
+ * number of hardware ports connected to it. It doesn't setup the
+ * ports or enable them. The main goal here is to set the global
+ * interface_port_count[interface] correctly. Hardware setup of the
+ * ports will be performed later.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_helper_interface_probe(int interface)
+{
+	/* At this stage in the game we don't want packets to be moving yet.
+	   The following probe calls should perform hardware setup
+	   needed to determine port counts. Receive must still be disabled */
+	switch (cvmx_helper_interface_get_mode(interface)) {
+		/* These types don't support ports to IPD/PKO */
+	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+	case CVMX_HELPER_INTERFACE_MODE_PCIE:
+		interface_port_count[interface] = 0;
+		break;
+		/* XAUI is a single high speed port */
+	case CVMX_HELPER_INTERFACE_MODE_XAUI:
+		interface_port_count[interface] =
+		    __cvmx_helper_xaui_probe(interface);
+		break;
+		/*
+		 * RGMII/GMII/MII are all treated about the same. Most
+		 * functions refer to these ports as RGMII.
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_RGMII:
+	case CVMX_HELPER_INTERFACE_MODE_GMII:
+		interface_port_count[interface] =
+		    __cvmx_helper_rgmii_probe(interface);
+		break;
+		/*
+		 * SPI4 can have 1-16 ports depending on the device at
+		 * the other end.
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_SPI:
+		interface_port_count[interface] =
+		    __cvmx_helper_spi_probe(interface);
+		break;
+		/*
+		 * SGMII can have 1-4 ports depending on how many are
+		 * hooked up.
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_SGMII:
+	case CVMX_HELPER_INTERFACE_MODE_PICMG:
+		interface_port_count[interface] =
+		    __cvmx_helper_sgmii_probe(interface);
+		break;
+		/* PCI target Network Packet Interface */
+	case CVMX_HELPER_INTERFACE_MODE_NPI:
+		interface_port_count[interface] =
+		    __cvmx_helper_npi_probe(interface);
+		break;
+		/*
+		 * Special loopback only ports. These are not the same
+		 * as other ports in loopback mode.
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_LOOP:
+		interface_port_count[interface] =
+		    __cvmx_helper_loop_probe(interface);
+		break;
+	}
+
+	interface_port_count[interface] =
+	    __cvmx_helper_board_interface_probe(interface,
+						interface_port_count
+						[interface]);
+
+	/* Make sure all global variables propagate to other cores */
+	CVMX_SYNCWS;
+
+	return 0;
+}
+
+/**
+ * Setup the IPD/PIP for the ports on an interface. Packet
+ * classification and tagging are set for every port on the
+ * interface. The number of ports on the interface must already
+ * have been probed.
+ *
+ * @interface: Interface to setup IPD/PIP for
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_interface_setup_ipd(int interface)
+{
+	int ipd_port = cvmx_helper_get_ipd_port(interface, 0);
+	int num_ports = interface_port_count[interface];
+
+	while (num_ports--) {
+		__cvmx_helper_port_setup_ipd(ipd_port);
+		ipd_port++;
+	}
+	return 0;
+}
+
+/**
+ * Setup global setting for IPD/PIP not related to a specific
+ * interface or port. This must be called before IPD is enabled.
+ *
+ * Returns Zero on success, negative on failure.
+ */
+static int __cvmx_helper_global_setup_ipd(void)
+{
+	/* Setup the global packet input options */
+	cvmx_ipd_config(CVMX_FPA_PACKET_POOL_SIZE / 8,
+			CVMX_HELPER_FIRST_MBUFF_SKIP / 8,
+			CVMX_HELPER_NOT_FIRST_MBUFF_SKIP / 8,
+			/* The +8 is to account for the next ptr */
+			(CVMX_HELPER_FIRST_MBUFF_SKIP + 8) / 128,
+			/* The +8 is to account for the next ptr */
+			(CVMX_HELPER_NOT_FIRST_MBUFF_SKIP + 8) / 128,
+			CVMX_FPA_WQE_POOL,
+			CVMX_IPD_OPC_MODE_STT,
+			CVMX_HELPER_ENABLE_BACK_PRESSURE);
+	return 0;
+}
+
+/**
+ * Setup the PKO for the ports on an interface. The number of
+ * queues per port and the priority of each PKO output queue
+ * is set here. PKO must be disabled when this function is called.
+ *
+ * @interface: Interface to setup PKO for
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_interface_setup_pko(int interface)
+{
+	/*
+	 * Each packet output queue has an associated priority. The
+	 * higher the priority, the more often it can send a packet. A
+	 * priority of 8 means it can send in all 8 rounds of
+	 * contention. We're going to make each queue one less than
+	 * the last.  The vector of priorities has been extended to
+	 * support CN5xxx CPUs, where up to 16 queues can be
+	 * associated to a port.  To keep backward compatibility we
+	 * don't change the initial 8 priorities and replicate them in
+	 * the second half.  With per-core PKO queues (PKO lockless
+	 * operation) all queues have the same priority.
+	 */
+	uint64_t priorities[16] =
+	    { 8, 7, 6, 5, 4, 3, 2, 1, 8, 7, 6, 5, 4, 3, 2, 1 };
+
+	/*
+	 * Setup the IPD/PIP and PKO for the ports discovered
+	 * above. Here packet classification, tagging and output
+	 * priorities are set.
+	 */
+	int ipd_port = cvmx_helper_get_ipd_port(interface, 0);
+	int num_ports = interface_port_count[interface];
+	while (num_ports--) {
+		/*
+		 * Give the user a chance to override the per queue
+		 * priorities.
+		 */
+		if (cvmx_override_pko_queue_priority)
+			cvmx_override_pko_queue_priority(ipd_port, priorities);
+
+		cvmx_pko_config_port(ipd_port,
+				     cvmx_pko_get_base_queue_per_core(ipd_port,
+								      0),
+				     cvmx_pko_get_num_queues(ipd_port),
+				     priorities);
+		ipd_port++;
+	}
+	return 0;
+}
+
+/**
+ * Setup global setting for PKO not related to a specific
+ * interface or port. This must be called before PKO is enabled.
+ *
+ * Returns Zero on success, negative on failure.
+ */
+static int __cvmx_helper_global_setup_pko(void)
+{
+	/*
+	 * Disable tagwait FAU timeout. This needs to be done before
+	 * anyone might start packet output using tags.
+	 */
+	union cvmx_iob_fau_timeout fau_to;
+	fau_to.u64 = 0;
+	fau_to.s.tout_val = 0xfff;
+	fau_to.s.tout_enb = 0;
+	cvmx_write_csr(CVMX_IOB_FAU_TIMEOUT, fau_to.u64);
+	return 0;
+}
+
+/**
+ * Setup global backpressure setting.
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_global_setup_backpressure(void)
+{
+#if CVMX_HELPER_DISABLE_RGMII_BACKPRESSURE
+	/* Disable backpressure if configured to do so */
+	/* Disable backpressure (pause frame) generation */
+	int num_interfaces = cvmx_helper_get_number_of_interfaces();
+	int interface;
+	for (interface = 0; interface < num_interfaces; interface++) {
+		switch (cvmx_helper_interface_get_mode(interface)) {
+		case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+		case CVMX_HELPER_INTERFACE_MODE_PCIE:
+		case CVMX_HELPER_INTERFACE_MODE_NPI:
+		case CVMX_HELPER_INTERFACE_MODE_LOOP:
+		case CVMX_HELPER_INTERFACE_MODE_XAUI:
+			break;
+		case CVMX_HELPER_INTERFACE_MODE_RGMII:
+		case CVMX_HELPER_INTERFACE_MODE_GMII:
+		case CVMX_HELPER_INTERFACE_MODE_SPI:
+		case CVMX_HELPER_INTERFACE_MODE_SGMII:
+		case CVMX_HELPER_INTERFACE_MODE_PICMG:
+			cvmx_gmx_set_backpressure_override(interface, 0xf);
+			break;
+		}
+	}
+#endif
+
+	return 0;
+}
+
+/**
+ * Enable packet input/output from the hardware. This function is
+ * called after all internal setup is complete and IPD is enabled.
+ * After this function completes, packets will be accepted from the
+ * hardware ports. PKO should still be disabled to make sure packets
+ * aren't sent out partially setup hardware.
+ *
+ * @interface: Interface to enable
+ *
+ * Returns Zero on success, negative on failure
+ */
+static int __cvmx_helper_packet_hardware_enable(int interface)
+{
+	int result = 0;
+	switch (cvmx_helper_interface_get_mode(interface)) {
+		/* These types don't support ports to IPD/PKO */
+	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+	case CVMX_HELPER_INTERFACE_MODE_PCIE:
+		/* Nothing to do */
+		break;
+		/* XAUI is a single high speed port */
+	case CVMX_HELPER_INTERFACE_MODE_XAUI:
+		result = __cvmx_helper_xaui_enable(interface);
+		break;
+		/*
+		 * RGMII/GMII/MII are all treated about the same. Most
+		 * functions refer to these ports as RGMII
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_RGMII:
+	case CVMX_HELPER_INTERFACE_MODE_GMII:
+		result = __cvmx_helper_rgmii_enable(interface);
+		break;
+		/*
+		 * SPI4 can have 1-16 ports depending on the device at
+		 * the other end
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_SPI:
+		result = __cvmx_helper_spi_enable(interface);
+		break;
+		/*
+		 * SGMII can have 1-4 ports depending on how many are
+		 * hooked up
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_SGMII:
+	case CVMX_HELPER_INTERFACE_MODE_PICMG:
+		result = __cvmx_helper_sgmii_enable(interface);
+		break;
+		/* PCI target Network Packet Interface */
+	case CVMX_HELPER_INTERFACE_MODE_NPI:
+		result = __cvmx_helper_npi_enable(interface);
+		break;
+		/*
+		 * Special loopback only ports. These are not the same
+		 * as other ports in loopback mode
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_LOOP:
+		result = __cvmx_helper_loop_enable(interface);
+		break;
+	}
+	result |= __cvmx_helper_board_hardware_enable(interface);
+	return result;
+}
+
+/**
+ * Function to adjust internal IPD pointer alignments
+ *
+ * Returns 0 on success
+ *         !0 on failure
+ */
+int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
+{
+#define FIX_IPD_FIRST_BUFF_PAYLOAD_BYTES \
+     (CVMX_FPA_PACKET_POOL_SIZE-8-CVMX_HELPER_FIRST_MBUFF_SKIP)
+#define FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES \
+	(CVMX_FPA_PACKET_POOL_SIZE-8-CVMX_HELPER_NOT_FIRST_MBUFF_SKIP)
+#define FIX_IPD_OUTPORT 0
+	/* Ports 0-15 are interface 0, 16-31 are interface 1 */
+#define INTERFACE(port) (port >> 4)
+#define INDEX(port) (port & 0xf)
+	uint64_t *p64;
+	cvmx_pko_command_word0_t pko_command;
+	union cvmx_buf_ptr g_buffer, pkt_buffer;
+	cvmx_wqe_t *work;
+	int size, num_segs = 0, wqe_pcnt, pkt_pcnt;
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	int retry_cnt;
+	int retry_loop_cnt;
+	int mtu;
+	int i;
+	cvmx_helper_link_info_t link_info;
+
+	/* Save values for restore at end */
+	uint64_t prtx_cfg =
+	    cvmx_read_csr(CVMX_GMXX_PRTX_CFG
+			  (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)));
+	uint64_t tx_ptr_en =
+	    cvmx_read_csr(CVMX_ASXX_TX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)));
+	uint64_t rx_ptr_en =
+	    cvmx_read_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)));
+	uint64_t rxx_jabber =
+	    cvmx_read_csr(CVMX_GMXX_RXX_JABBER
+			  (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)));
+	uint64_t frame_max =
+	    cvmx_read_csr(CVMX_GMXX_RXX_FRM_MAX
+			  (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)));
+
+	/* Configure port to gig FDX as required for loopback mode */
+	cvmx_helper_rgmii_internal_loopback(FIX_IPD_OUTPORT);
+
+	/*
+	 * Disable reception on all ports so if traffic is present it
+	 * will not interfere.
+	 */
+	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)), 0);
+
+	cvmx_wait(100000000ull);
+
+	for (retry_loop_cnt = 0; retry_loop_cnt < 10; retry_loop_cnt++) {
+		retry_cnt = 100000;
+		wqe_pcnt = cvmx_read_csr(CVMX_IPD_PTR_COUNT);
+		pkt_pcnt = (wqe_pcnt >> 7) & 0x7f;
+		wqe_pcnt &= 0x7f;
+
+		num_segs = (2 + pkt_pcnt - wqe_pcnt) & 3;
+
+		if (num_segs == 0)
+			goto fix_ipd_exit;
+
+		num_segs += 1;
+
+		size =
+		    FIX_IPD_FIRST_BUFF_PAYLOAD_BYTES +
+		    ((num_segs - 1) * FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES) -
+		    (FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES / 2);
+
+		cvmx_write_csr(CVMX_ASXX_PRT_LOOP(INTERFACE(FIX_IPD_OUTPORT)),
+			       1 << INDEX(FIX_IPD_OUTPORT));
+		CVMX_SYNC;
+
+		g_buffer.u64 = 0;
+		g_buffer.s.addr =
+		    cvmx_ptr_to_phys(cvmx_fpa_alloc(CVMX_FPA_WQE_POOL));
+		if (g_buffer.s.addr == 0) {
+			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT "
+				     "buffer allocation failure.\n");
+			goto fix_ipd_exit;
+		}
+
+		g_buffer.s.pool = CVMX_FPA_WQE_POOL;
+		g_buffer.s.size = num_segs;
+
+		pkt_buffer.u64 = 0;
+		pkt_buffer.s.addr =
+		    cvmx_ptr_to_phys(cvmx_fpa_alloc(CVMX_FPA_PACKET_POOL));
+		if (pkt_buffer.s.addr == 0) {
+			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT "
+				     "buffer allocation failure.\n");
+			goto fix_ipd_exit;
+		}
+		pkt_buffer.s.i = 1;
+		pkt_buffer.s.pool = CVMX_FPA_PACKET_POOL;
+		pkt_buffer.s.size = FIX_IPD_FIRST_BUFF_PAYLOAD_BYTES;
+
+		p64 = (uint64_t *) cvmx_phys_to_ptr(pkt_buffer.s.addr);
+		p64[0] = 0xffffffffffff0000ull;
+		p64[1] = 0x08004510ull;
+		p64[2] = ((uint64_t) (size - 14) << 48) | 0x5ae740004000ull;
+		p64[3] = 0x3a5fc0a81073c0a8ull;
+
+		for (i = 0; i < num_segs; i++) {
+			if (i > 0)
+				pkt_buffer.s.size =
+				    FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES;
+
+			if (i == (num_segs - 1))
+				pkt_buffer.s.i = 0;
+
+			*(uint64_t *) cvmx_phys_to_ptr(g_buffer.s.addr +
+						       8 * i) = pkt_buffer.u64;
+		}
+
+		/* Build the PKO command */
+		pko_command.u64 = 0;
+		pko_command.s.segs = num_segs;
+		pko_command.s.total_bytes = size;
+		pko_command.s.dontfree = 0;
+		pko_command.s.gather = 1;
+
+		gmx_cfg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG
+				  (INDEX(FIX_IPD_OUTPORT),
+				   INTERFACE(FIX_IPD_OUTPORT)));
+		gmx_cfg.s.en = 1;
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG
+			       (INDEX(FIX_IPD_OUTPORT),
+				INTERFACE(FIX_IPD_OUTPORT)), gmx_cfg.u64);
+		cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)),
+			       1 << INDEX(FIX_IPD_OUTPORT));
+		cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)),
+			       1 << INDEX(FIX_IPD_OUTPORT));
+
+		mtu =
+		    cvmx_read_csr(CVMX_GMXX_RXX_JABBER
+				  (INDEX(FIX_IPD_OUTPORT),
+				   INTERFACE(FIX_IPD_OUTPORT)));
+		cvmx_write_csr(CVMX_GMXX_RXX_JABBER
+			       (INDEX(FIX_IPD_OUTPORT),
+				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
+		cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX
+			       (INDEX(FIX_IPD_OUTPORT),
+				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
+
+		cvmx_pko_send_packet_prepare(FIX_IPD_OUTPORT,
+					     cvmx_pko_get_base_queue
+					     (FIX_IPD_OUTPORT),
+					     CVMX_PKO_LOCK_CMD_QUEUE);
+		cvmx_pko_send_packet_finish(FIX_IPD_OUTPORT,
+					    cvmx_pko_get_base_queue
+					    (FIX_IPD_OUTPORT), pko_command,
+					    g_buffer, CVMX_PKO_LOCK_CMD_QUEUE);
+
+		CVMX_SYNC;
+
+		do {
+			work = cvmx_pow_work_request_sync(CVMX_POW_WAIT);
+			retry_cnt--;
+		} while ((work == NULL) && (retry_cnt > 0));
+
+		if (!retry_cnt)
+			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT "
+				     "get_work() timeout occured.\n");
+
+		/* Free packet */
+		if (work)
+			cvmx_helper_free_packet_data(work);
+	}
+
+fix_ipd_exit:
+
+	/* Return CSR configs to saved values */
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG
+		       (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)),
+		       prtx_cfg);
+	cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)),
+		       tx_ptr_en);
+	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)),
+		       rx_ptr_en);
+	cvmx_write_csr(CVMX_GMXX_RXX_JABBER
+		       (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)),
+		       rxx_jabber);
+	cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX
+		       (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)),
+		       frame_max);
+	cvmx_write_csr(CVMX_ASXX_PRT_LOOP(INTERFACE(FIX_IPD_OUTPORT)), 0);
+	/* Set link to down so autonegotiation will set it up again */
+	link_info.u64 = 0;
+	cvmx_helper_link_set(FIX_IPD_OUTPORT, link_info);
+
+	/*
+	 * Bring the link back up as autonegotiation is not done in
+	 * user applications.
+	 */
+	cvmx_helper_link_autoconf(FIX_IPD_OUTPORT);
+
+	CVMX_SYNC;
+	if (num_segs)
+		cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT failed.\n");
+
+	return !!num_segs;
+
+}
+
+/**
+ * Called after all internal packet IO paths are setup. This
+ * function enables IPD/PIP and begins packet input and output.
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_helper_ipd_and_packet_input_enable(void)
+{
+	int num_interfaces;
+	int interface;
+
+	/* Enable IPD */
+	cvmx_ipd_enable();
+
+	/*
+	 * Time to enable hardware ports packet input and output. Note
+	 * that at this point IPD/PIP must be fully functional and PKO
+	 * must be disabled
+	 */
+	num_interfaces = cvmx_helper_get_number_of_interfaces();
+	for (interface = 0; interface < num_interfaces; interface++) {
+		if (cvmx_helper_ports_on_interface(interface) > 0)
+			__cvmx_helper_packet_hardware_enable(interface);
+	}
+
+	/* Finally enable PKO now that the entire path is up and running */
+	cvmx_pko_enable();
+
+	if ((OCTEON_IS_MODEL(OCTEON_CN31XX_PASS1)
+	     || OCTEON_IS_MODEL(OCTEON_CN30XX_PASS1))
+	    && (cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM))
+		__cvmx_helper_errata_fix_ipd_ptr_alignment();
+	return 0;
+}
+
+/**
+ * Initialize the PIP, IPD, and PKO hardware to support
+ * simple priority based queues for the ethernet ports. Each
+ * port is configured with a number of priority queues based
+ * on CVMX_PKO_QUEUES_PER_PORT_* where each queue is lower
+ * priority than the previous.
+ *
+ * Returns Zero on success, non-zero on failure
+ */
+int cvmx_helper_initialize_packet_io_global(void)
+{
+	int result = 0;
+	int interface;
+	union cvmx_l2c_cfg l2c_cfg;
+	union cvmx_smix_en smix_en;
+	const int num_interfaces = cvmx_helper_get_number_of_interfaces();
+
+	/*
+	 * CN52XX pass 1: Due to a bug in 2nd order CDR, it needs to
+	 * be disabled.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_0))
+		__cvmx_helper_errata_qlm_disable_2nd_order_cdr(1);
+
+	/*
+	 * Tell L2 to give the IOB statically higher priority compared
+	 * to the cores. This avoids conditions where IO blocks might
+	 * be starved under very high L2 loads.
+	 */
+	l2c_cfg.u64 = cvmx_read_csr(CVMX_L2C_CFG);
+	l2c_cfg.s.lrf_arb_mode = 0;
+	l2c_cfg.s.rfb_arb_mode = 0;
+	cvmx_write_csr(CVMX_L2C_CFG, l2c_cfg.u64);
+
+	/* Make sure SMI/MDIO is enabled so we can query PHYs */
+	smix_en.u64 = cvmx_read_csr(CVMX_SMIX_EN(0));
+	if (!smix_en.s.en) {
+		smix_en.s.en = 1;
+		cvmx_write_csr(CVMX_SMIX_EN(0), smix_en.u64);
+	}
+
+	/* Newer chips actually have two SMI/MDIO interfaces */
+	if (!OCTEON_IS_MODEL(OCTEON_CN3XXX) &&
+	    !OCTEON_IS_MODEL(OCTEON_CN58XX) &&
+	    !OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		smix_en.u64 = cvmx_read_csr(CVMX_SMIX_EN(1));
+		if (!smix_en.s.en) {
+			smix_en.s.en = 1;
+			cvmx_write_csr(CVMX_SMIX_EN(1), smix_en.u64);
+		}
+	}
+
+	cvmx_pko_initialize_global();
+	for (interface = 0; interface < num_interfaces; interface++) {
+		result |= cvmx_helper_interface_probe(interface);
+		if (cvmx_helper_ports_on_interface(interface) > 0)
+			cvmx_dprintf("Interface %d has %d ports (%s)\n",
+				     interface,
+				     cvmx_helper_ports_on_interface(interface),
+				     cvmx_helper_interface_mode_to_string
+				     (cvmx_helper_interface_get_mode
+				      (interface)));
+		result |= __cvmx_helper_interface_setup_ipd(interface);
+		result |= __cvmx_helper_interface_setup_pko(interface);
+	}
+
+	result |= __cvmx_helper_global_setup_ipd();
+	result |= __cvmx_helper_global_setup_pko();
+
+	/* Enable any flow control and backpressure */
+	result |= __cvmx_helper_global_setup_backpressure();
+
+#if CVMX_HELPER_ENABLE_IPD
+	result |= cvmx_helper_ipd_and_packet_input_enable();
+#endif
+	return result;
+}
+
+/**
+ * Does core local initialization for packet io
+ *
+ * Returns Zero on success, non-zero on failure
+ */
+int cvmx_helper_initialize_packet_io_local(void)
+{
+	return cvmx_pko_initialize_local();
+}
+
+/**
+ * Auto configure an IPD/PKO port link state and speed. This
+ * function basically does the equivalent of:
+ * cvmx_helper_link_set(ipd_port, cvmx_helper_link_get(ipd_port));
+ *
+ * @ipd_port: IPD/PKO port to auto configure
+ *
+ * Returns Link state after configure
+ */
+cvmx_helper_link_info_t cvmx_helper_link_autoconf(int ipd_port)
+{
+	cvmx_helper_link_info_t link_info;
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+
+	if (index >= cvmx_helper_ports_on_interface(interface)) {
+		link_info.u64 = 0;
+		return link_info;
+	}
+
+	link_info = cvmx_helper_link_get(ipd_port);
+	if (link_info.u64 == port_link_info[ipd_port].u64)
+		return link_info;
+
+	/* If we fail to set the link speed, port_link_info will not change */
+	cvmx_helper_link_set(ipd_port, link_info);
+
+	/*
+	 * port_link_info should be the current value, which will be
+	 * different than expect if cvmx_helper_link_set() failed.
+	 */
+	return port_link_info[ipd_port];
+}
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port)
+{
+	cvmx_helper_link_info_t result;
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+
+	/* The default result will be a down link unless the code below
+	   changes it */
+	result.u64 = 0;
+
+	if (index >= cvmx_helper_ports_on_interface(interface))
+		return result;
+
+	switch (cvmx_helper_interface_get_mode(interface)) {
+	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+	case CVMX_HELPER_INTERFACE_MODE_PCIE:
+		/* Network links are not supported */
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_XAUI:
+		result = __cvmx_helper_xaui_link_get(ipd_port);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_GMII:
+		if (index == 0)
+			result = __cvmx_helper_rgmii_link_get(ipd_port);
+		else {
+			result.s.full_duplex = 1;
+			result.s.link_up = 1;
+			result.s.speed = 1000;
+		}
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_RGMII:
+		result = __cvmx_helper_rgmii_link_get(ipd_port);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_SPI:
+		result = __cvmx_helper_spi_link_get(ipd_port);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_SGMII:
+	case CVMX_HELPER_INTERFACE_MODE_PICMG:
+		result = __cvmx_helper_sgmii_link_get(ipd_port);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_NPI:
+	case CVMX_HELPER_INTERFACE_MODE_LOOP:
+		/* Network links are not supported */
+		break;
+	}
+	return result;
+}
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_helper_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
+{
+	int result = -1;
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+
+	if (index >= cvmx_helper_ports_on_interface(interface))
+		return -1;
+
+	switch (cvmx_helper_interface_get_mode(interface)) {
+	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+	case CVMX_HELPER_INTERFACE_MODE_PCIE:
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_XAUI:
+		result = __cvmx_helper_xaui_link_set(ipd_port, link_info);
+		break;
+		/*
+		 * RGMII/GMII/MII are all treated about the same. Most
+		 * functions refer to these ports as RGMII.
+		 */
+	case CVMX_HELPER_INTERFACE_MODE_RGMII:
+	case CVMX_HELPER_INTERFACE_MODE_GMII:
+		result = __cvmx_helper_rgmii_link_set(ipd_port, link_info);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_SPI:
+		result = __cvmx_helper_spi_link_set(ipd_port, link_info);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_SGMII:
+	case CVMX_HELPER_INTERFACE_MODE_PICMG:
+		result = __cvmx_helper_sgmii_link_set(ipd_port, link_info);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_NPI:
+	case CVMX_HELPER_INTERFACE_MODE_LOOP:
+		break;
+	}
+	/* Set the port_link_info here so that the link status is updated
+	   no matter how cvmx_helper_link_set is called. We don't change
+	   the value if link_set failed */
+	if (result == 0)
+		port_link_info[ipd_port].u64 = link_info.u64;
+	return result;
+}
+
+/**
+ * Configure a port for internal and/or external loopback. Internal loopback
+ * causes packets sent by the port to be received by Octeon. External loopback
+ * causes packets received from the wire to sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *                 Non zero if you want internal loopback
+ * @enable_external:
+ *                 Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+int cvmx_helper_configure_loopback(int ipd_port, int enable_internal,
+				   int enable_external)
+{
+	int result = -1;
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+	int index = cvmx_helper_get_interface_index_num(ipd_port);
+
+	if (index >= cvmx_helper_ports_on_interface(interface))
+		return -1;
+
+	switch (cvmx_helper_interface_get_mode(interface)) {
+	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+	case CVMX_HELPER_INTERFACE_MODE_PCIE:
+	case CVMX_HELPER_INTERFACE_MODE_SPI:
+	case CVMX_HELPER_INTERFACE_MODE_NPI:
+	case CVMX_HELPER_INTERFACE_MODE_LOOP:
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_XAUI:
+		result =
+		    __cvmx_helper_xaui_configure_loopback(ipd_port,
+							  enable_internal,
+							  enable_external);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_RGMII:
+	case CVMX_HELPER_INTERFACE_MODE_GMII:
+		result =
+		    __cvmx_helper_rgmii_configure_loopback(ipd_port,
+							   enable_internal,
+							   enable_external);
+		break;
+	case CVMX_HELPER_INTERFACE_MODE_SGMII:
+	case CVMX_HELPER_INTERFACE_MODE_PICMG:
+		result =
+		    __cvmx_helper_sgmii_configure_loopback(ipd_port,
+							   enable_internal,
+							   enable_external);
+		break;
+	}
+	return result;
+}
diff --git a/drivers/staging/octeon/cvmx-helper.h b/drivers/staging/octeon/cvmx-helper.h
new file mode 100644
index 0000000..51916f3
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper.h
@@ -0,0 +1,227 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * Helper functions for common, but complicated tasks.
+ *
+ */
+
+#ifndef __CVMX_HELPER_H__
+#define __CVMX_HELPER_H__
+
+#include "cvmx-config.h"
+#include "cvmx-fpa.h"
+#include "cvmx-wqe.h"
+
+typedef enum {
+	CVMX_HELPER_INTERFACE_MODE_DISABLED,
+	CVMX_HELPER_INTERFACE_MODE_RGMII,
+	CVMX_HELPER_INTERFACE_MODE_GMII,
+	CVMX_HELPER_INTERFACE_MODE_SPI,
+	CVMX_HELPER_INTERFACE_MODE_PCIE,
+	CVMX_HELPER_INTERFACE_MODE_XAUI,
+	CVMX_HELPER_INTERFACE_MODE_SGMII,
+	CVMX_HELPER_INTERFACE_MODE_PICMG,
+	CVMX_HELPER_INTERFACE_MODE_NPI,
+	CVMX_HELPER_INTERFACE_MODE_LOOP,
+} cvmx_helper_interface_mode_t;
+
+typedef union {
+	uint64_t u64;
+	struct {
+		uint64_t reserved_20_63:44;
+		uint64_t link_up:1;	    /**< Is the physical link up? */
+		uint64_t full_duplex:1;	    /**< 1 if the link is full duplex */
+		uint64_t speed:18;	    /**< Speed of the link in Mbps */
+	} s;
+} cvmx_helper_link_info_t;
+
+#include "cvmx-helper-fpa.h"
+
+#include <asm/octeon/cvmx-helper-errata.h>
+#include "cvmx-helper-loop.h"
+#include "cvmx-helper-npi.h"
+#include "cvmx-helper-rgmii.h"
+#include "cvmx-helper-sgmii.h"
+#include "cvmx-helper-spi.h"
+#include "cvmx-helper-util.h"
+#include "cvmx-helper-xaui.h"
+
+/**
+ * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
+ * priorities[16]) is a function pointer. It is meant to allow
+ * customization of the PKO queue priorities based on the port
+ * number. Users should set this pointer to a function before
+ * calling any cvmx-helper operations.
+ */
+extern void (*cvmx_override_pko_queue_priority) (int pko_port,
+						 uint64_t priorities[16]);
+
+/**
+ * cvmx_override_ipd_port_setup(int ipd_port) is a function
+ * pointer. It is meant to allow customization of the IPD port
+ * setup before packet input/output comes online. It is called
+ * after cvmx-helper does the default IPD configuration, but
+ * before IPD is enabled. Users should set this pointer to a
+ * function before calling any cvmx-helper operations.
+ */
+extern void (*cvmx_override_ipd_port_setup) (int ipd_port);
+
+/**
+ * This function enables the IPD and also enables the packet interfaces.
+ * The packet interfaces (RGMII and SPI) must be enabled after the
+ * IPD.  This should be called by the user program after any additional
+ * IPD configuration changes are made if CVMX_HELPER_ENABLE_IPD
+ * is not set in the executive-config.h file.
+ *
+ * Returns 0 on success
+ *         -1 on failure
+ */
+extern int cvmx_helper_ipd_and_packet_input_enable(void);
+
+/**
+ * Initialize the PIP, IPD, and PKO hardware to support
+ * simple priority based queues for the ethernet ports. Each
+ * port is configured with a number of priority queues based
+ * on CVMX_PKO_QUEUES_PER_PORT_* where each queue is lower
+ * priority than the previous.
+ *
+ * Returns Zero on success, non-zero on failure
+ */
+extern int cvmx_helper_initialize_packet_io_global(void);
+
+/**
+ * Does core local initialization for packet io
+ *
+ * Returns Zero on success, non-zero on failure
+ */
+extern int cvmx_helper_initialize_packet_io_local(void);
+
+/**
+ * Returns the number of ports on the given interface.
+ * The interface must be initialized before the port count
+ * can be returned.
+ *
+ * @interface: Which interface to return port count for.
+ *
+ * Returns Port count for interface
+ *         -1 for uninitialized interface
+ */
+extern int cvmx_helper_ports_on_interface(int interface);
+
+/**
+ * Return the number of interfaces the chip has. Each interface
+ * may have multiple ports. Most chips support two interfaces,
+ * but the CNX0XX and CNX1XX are exceptions. These only support
+ * one interface.
+ *
+ * Returns Number of interfaces on chip
+ */
+extern int cvmx_helper_get_number_of_interfaces(void);
+
+/**
+ * Get the operating mode of an interface. Depending on the Octeon
+ * chip and configuration, this function returns an enumeration
+ * of the type of packet I/O supported by an interface.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Mode of the interface. Unknown or unsupported interfaces return
+ *         DISABLED.
+ */
+extern cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
+								   interface);
+
+/**
+ * Auto configure an IPD/PKO port link state and speed. This
+ * function basically does the equivalent of:
+ * cvmx_helper_link_set(ipd_port, cvmx_helper_link_get(ipd_port));
+ *
+ * @ipd_port: IPD/PKO port to auto configure
+ *
+ * Returns Link state after configure
+ */
+extern cvmx_helper_link_info_t cvmx_helper_link_autoconf(int ipd_port);
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+extern cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port);
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int cvmx_helper_link_set(int ipd_port,
+				cvmx_helper_link_info_t link_info);
+
+/**
+ * This function probes an interface to determine the actual
+ * number of hardware ports connected to it. It doesn't setup the
+ * ports or enable them. The main goal here is to set the global
+ * interface_port_count[interface] correctly. Hardware setup of the
+ * ports will be performed later.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int cvmx_helper_interface_probe(int interface);
+
+/**
+ * Configure a port for internal and/or external loopback. Internal loopback
+ * causes packets sent by the port to be received by Octeon. External loopback
+ * causes packets received from the wire to sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *                 Non zero if you want internal loopback
+ * @enable_external:
+ *                 Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+extern int cvmx_helper_configure_loopback(int ipd_port, int enable_internal,
+					  int enable_external);
+
+#endif /* __CVMX_HELPER_H__ */
diff --git a/drivers/staging/octeon/cvmx-interrupt-decodes.c b/drivers/staging/octeon/cvmx-interrupt-decodes.c
new file mode 100644
index 0000000..a3337e3
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-interrupt-decodes.c
@@ -0,0 +1,371 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2009 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * Automatically generated functions useful for enabling
+ * and decoding RSL_INT_BLOCKS interrupts.
+ *
+ */
+
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-gmxx-defs.h"
+#include "cvmx-pcsx-defs.h"
+#include "cvmx-pcsxx-defs.h"
+#include "cvmx-spxx-defs.h"
+#include "cvmx-stxx-defs.h"
+
+#ifndef PRINT_ERROR
+#define PRINT_ERROR(format, ...)
+#endif
+
+
+/**
+ * __cvmx_interrupt_gmxx_rxx_int_en_enable enables all interrupt bits in cvmx_gmxx_rxx_int_en_t
+ */
+void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block)
+{
+	union cvmx_gmxx_rxx_int_en gmx_rx_int_en;
+	cvmx_write_csr(CVMX_GMXX_RXX_INT_REG(index, block),
+		       cvmx_read_csr(CVMX_GMXX_RXX_INT_REG(index, block)));
+	gmx_rx_int_en.u64 = 0;
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX)) {
+		/* Skipping gmx_rx_int_en.s.reserved_29_63 */
+		gmx_rx_int_en.s.hg2cc = 1;
+		gmx_rx_int_en.s.hg2fld = 1;
+		gmx_rx_int_en.s.undat = 1;
+		gmx_rx_int_en.s.uneop = 1;
+		gmx_rx_int_en.s.unsop = 1;
+		gmx_rx_int_en.s.bad_term = 1;
+		gmx_rx_int_en.s.bad_seq = 1;
+		gmx_rx_int_en.s.rem_fault = 1;
+		gmx_rx_int_en.s.loc_fault = 1;
+		gmx_rx_int_en.s.pause_drp = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_16_18 */
+		/*gmx_rx_int_en.s.ifgerr = 1; */
+		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
+		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
+		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
+		gmx_rx_int_en.s.ovrerr = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_9_9 */
+		gmx_rx_int_en.s.skperr = 1;
+		gmx_rx_int_en.s.rcverr = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_5_6 */
+		/*gmx_rx_int_en.s.fcserr = 1; // FCS errors are handled when we get work */
+		gmx_rx_int_en.s.jabber = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_2_2 */
+		gmx_rx_int_en.s.carext = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_0_0 */
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN30XX)) {
+		/* Skipping gmx_rx_int_en.s.reserved_19_63 */
+		/*gmx_rx_int_en.s.phy_dupx = 1; */
+		/*gmx_rx_int_en.s.phy_spd = 1; */
+		/*gmx_rx_int_en.s.phy_link = 1; */
+		/*gmx_rx_int_en.s.ifgerr = 1; */
+		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
+		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
+		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
+		gmx_rx_int_en.s.ovrerr = 1;
+		gmx_rx_int_en.s.niberr = 1;
+		gmx_rx_int_en.s.skperr = 1;
+		gmx_rx_int_en.s.rcverr = 1;
+		/*gmx_rx_int_en.s.lenerr = 1; // Length errors are handled when we get work */
+		gmx_rx_int_en.s.alnerr = 1;
+		/*gmx_rx_int_en.s.fcserr = 1; // FCS errors are handled when we get work */
+		gmx_rx_int_en.s.jabber = 1;
+		gmx_rx_int_en.s.maxerr = 1;
+		gmx_rx_int_en.s.carext = 1;
+		gmx_rx_int_en.s.minerr = 1;
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		/* Skipping gmx_rx_int_en.s.reserved_20_63 */
+		gmx_rx_int_en.s.pause_drp = 1;
+		/*gmx_rx_int_en.s.phy_dupx = 1; */
+		/*gmx_rx_int_en.s.phy_spd = 1; */
+		/*gmx_rx_int_en.s.phy_link = 1; */
+		/*gmx_rx_int_en.s.ifgerr = 1; */
+		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
+		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
+		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
+		gmx_rx_int_en.s.ovrerr = 1;
+		gmx_rx_int_en.s.niberr = 1;
+		gmx_rx_int_en.s.skperr = 1;
+		gmx_rx_int_en.s.rcverr = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_6_6 */
+		gmx_rx_int_en.s.alnerr = 1;
+		/*gmx_rx_int_en.s.fcserr = 1; // FCS errors are handled when we get work */
+		gmx_rx_int_en.s.jabber = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_2_2 */
+		gmx_rx_int_en.s.carext = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_0_0 */
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX)) {
+		/* Skipping gmx_rx_int_en.s.reserved_19_63 */
+		/*gmx_rx_int_en.s.phy_dupx = 1; */
+		/*gmx_rx_int_en.s.phy_spd = 1; */
+		/*gmx_rx_int_en.s.phy_link = 1; */
+		/*gmx_rx_int_en.s.ifgerr = 1; */
+		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
+		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
+		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
+		gmx_rx_int_en.s.ovrerr = 1;
+		gmx_rx_int_en.s.niberr = 1;
+		gmx_rx_int_en.s.skperr = 1;
+		gmx_rx_int_en.s.rcverr = 1;
+		/*gmx_rx_int_en.s.lenerr = 1; // Length errors are handled when we get work */
+		gmx_rx_int_en.s.alnerr = 1;
+		/*gmx_rx_int_en.s.fcserr = 1; // FCS errors are handled when we get work */
+		gmx_rx_int_en.s.jabber = 1;
+		gmx_rx_int_en.s.maxerr = 1;
+		gmx_rx_int_en.s.carext = 1;
+		gmx_rx_int_en.s.minerr = 1;
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN31XX)) {
+		/* Skipping gmx_rx_int_en.s.reserved_19_63 */
+		/*gmx_rx_int_en.s.phy_dupx = 1; */
+		/*gmx_rx_int_en.s.phy_spd = 1; */
+		/*gmx_rx_int_en.s.phy_link = 1; */
+		/*gmx_rx_int_en.s.ifgerr = 1; */
+		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
+		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
+		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
+		gmx_rx_int_en.s.ovrerr = 1;
+		gmx_rx_int_en.s.niberr = 1;
+		gmx_rx_int_en.s.skperr = 1;
+		gmx_rx_int_en.s.rcverr = 1;
+		/*gmx_rx_int_en.s.lenerr = 1; // Length errors are handled when we get work */
+		gmx_rx_int_en.s.alnerr = 1;
+		/*gmx_rx_int_en.s.fcserr = 1; // FCS errors are handled when we get work */
+		gmx_rx_int_en.s.jabber = 1;
+		gmx_rx_int_en.s.maxerr = 1;
+		gmx_rx_int_en.s.carext = 1;
+		gmx_rx_int_en.s.minerr = 1;
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+		/* Skipping gmx_rx_int_en.s.reserved_20_63 */
+		gmx_rx_int_en.s.pause_drp = 1;
+		/*gmx_rx_int_en.s.phy_dupx = 1; */
+		/*gmx_rx_int_en.s.phy_spd = 1; */
+		/*gmx_rx_int_en.s.phy_link = 1; */
+		/*gmx_rx_int_en.s.ifgerr = 1; */
+		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
+		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
+		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
+		gmx_rx_int_en.s.ovrerr = 1;
+		gmx_rx_int_en.s.niberr = 1;
+		gmx_rx_int_en.s.skperr = 1;
+		gmx_rx_int_en.s.rcverr = 1;
+		/*gmx_rx_int_en.s.lenerr = 1; // Length errors are handled when we get work */
+		gmx_rx_int_en.s.alnerr = 1;
+		/*gmx_rx_int_en.s.fcserr = 1; // FCS errors are handled when we get work */
+		gmx_rx_int_en.s.jabber = 1;
+		gmx_rx_int_en.s.maxerr = 1;
+		gmx_rx_int_en.s.carext = 1;
+		gmx_rx_int_en.s.minerr = 1;
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		/* Skipping gmx_rx_int_en.s.reserved_29_63 */
+		gmx_rx_int_en.s.hg2cc = 1;
+		gmx_rx_int_en.s.hg2fld = 1;
+		gmx_rx_int_en.s.undat = 1;
+		gmx_rx_int_en.s.uneop = 1;
+		gmx_rx_int_en.s.unsop = 1;
+		gmx_rx_int_en.s.bad_term = 1;
+		gmx_rx_int_en.s.bad_seq = 0;
+		gmx_rx_int_en.s.rem_fault = 1;
+		gmx_rx_int_en.s.loc_fault = 0;
+		gmx_rx_int_en.s.pause_drp = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_16_18 */
+		/*gmx_rx_int_en.s.ifgerr = 1; */
+		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
+		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
+		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
+		gmx_rx_int_en.s.ovrerr = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_9_9 */
+		gmx_rx_int_en.s.skperr = 1;
+		gmx_rx_int_en.s.rcverr = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_5_6 */
+		/*gmx_rx_int_en.s.fcserr = 1; // FCS errors are handled when we get work */
+		gmx_rx_int_en.s.jabber = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_2_2 */
+		gmx_rx_int_en.s.carext = 1;
+		/* Skipping gmx_rx_int_en.s.reserved_0_0 */
+	}
+	cvmx_write_csr(CVMX_GMXX_RXX_INT_EN(index, block), gmx_rx_int_en.u64);
+}
+/**
+ * __cvmx_interrupt_pcsx_intx_en_reg_enable enables all interrupt bits in cvmx_pcsx_intx_en_reg_t
+ */
+void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block)
+{
+	union cvmx_pcsx_intx_en_reg pcs_int_en_reg;
+	cvmx_write_csr(CVMX_PCSX_INTX_REG(index, block),
+		       cvmx_read_csr(CVMX_PCSX_INTX_REG(index, block)));
+	pcs_int_en_reg.u64 = 0;
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX)) {
+		/* Skipping pcs_int_en_reg.s.reserved_12_63 */
+		/*pcs_int_en_reg.s.dup = 1; // This happens during normal operation */
+		pcs_int_en_reg.s.sync_bad_en = 1;
+		pcs_int_en_reg.s.an_bad_en = 1;
+		pcs_int_en_reg.s.rxlock_en = 1;
+		pcs_int_en_reg.s.rxbad_en = 1;
+		/*pcs_int_en_reg.s.rxerr_en = 1; // This happens during normal operation */
+		pcs_int_en_reg.s.txbad_en = 1;
+		pcs_int_en_reg.s.txfifo_en = 1;
+		pcs_int_en_reg.s.txfifu_en = 1;
+		pcs_int_en_reg.s.an_err_en = 1;
+		/*pcs_int_en_reg.s.xmit_en = 1; // This happens during normal operation */
+		/*pcs_int_en_reg.s.lnkspd_en = 1; // This happens during normal operation */
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		/* Skipping pcs_int_en_reg.s.reserved_12_63 */
+		/*pcs_int_en_reg.s.dup = 1; // This happens during normal operation */
+		pcs_int_en_reg.s.sync_bad_en = 1;
+		pcs_int_en_reg.s.an_bad_en = 1;
+		pcs_int_en_reg.s.rxlock_en = 1;
+		pcs_int_en_reg.s.rxbad_en = 1;
+		/*pcs_int_en_reg.s.rxerr_en = 1; // This happens during normal operation */
+		pcs_int_en_reg.s.txbad_en = 1;
+		pcs_int_en_reg.s.txfifo_en = 1;
+		pcs_int_en_reg.s.txfifu_en = 1;
+		pcs_int_en_reg.s.an_err_en = 1;
+		/*pcs_int_en_reg.s.xmit_en = 1; // This happens during normal operation */
+		/*pcs_int_en_reg.s.lnkspd_en = 1; // This happens during normal operation */
+	}
+	cvmx_write_csr(CVMX_PCSX_INTX_EN_REG(index, block), pcs_int_en_reg.u64);
+}
+/**
+ * __cvmx_interrupt_pcsxx_int_en_reg_enable enables all interrupt bits in cvmx_pcsxx_int_en_reg_t
+ */
+void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index)
+{
+	union cvmx_pcsxx_int_en_reg pcsx_int_en_reg;
+	cvmx_write_csr(CVMX_PCSXX_INT_REG(index),
+		       cvmx_read_csr(CVMX_PCSXX_INT_REG(index)));
+	pcsx_int_en_reg.u64 = 0;
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX)) {
+		/* Skipping pcsx_int_en_reg.s.reserved_6_63 */
+		pcsx_int_en_reg.s.algnlos_en = 1;
+		pcsx_int_en_reg.s.synlos_en = 1;
+		pcsx_int_en_reg.s.bitlckls_en = 1;
+		pcsx_int_en_reg.s.rxsynbad_en = 1;
+		pcsx_int_en_reg.s.rxbad_en = 1;
+		pcsx_int_en_reg.s.txflt_en = 1;
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		/* Skipping pcsx_int_en_reg.s.reserved_6_63 */
+		pcsx_int_en_reg.s.algnlos_en = 1;
+		pcsx_int_en_reg.s.synlos_en = 1;
+		pcsx_int_en_reg.s.bitlckls_en = 0;	/* Happens if XAUI module is not installed */
+		pcsx_int_en_reg.s.rxsynbad_en = 1;
+		pcsx_int_en_reg.s.rxbad_en = 1;
+		pcsx_int_en_reg.s.txflt_en = 1;
+	}
+	cvmx_write_csr(CVMX_PCSXX_INT_EN_REG(index), pcsx_int_en_reg.u64);
+}
+
+/**
+ * __cvmx_interrupt_spxx_int_msk_enable enables all interrupt bits in cvmx_spxx_int_msk_t
+ */
+void __cvmx_interrupt_spxx_int_msk_enable(int index)
+{
+	union cvmx_spxx_int_msk spx_int_msk;
+	cvmx_write_csr(CVMX_SPXX_INT_REG(index),
+		       cvmx_read_csr(CVMX_SPXX_INT_REG(index)));
+	spx_int_msk.u64 = 0;
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX)) {
+		/* Skipping spx_int_msk.s.reserved_12_63 */
+		spx_int_msk.s.calerr = 1;
+		spx_int_msk.s.syncerr = 1;
+		spx_int_msk.s.diperr = 1;
+		spx_int_msk.s.tpaovr = 1;
+		spx_int_msk.s.rsverr = 1;
+		spx_int_msk.s.drwnng = 1;
+		spx_int_msk.s.clserr = 1;
+		spx_int_msk.s.spiovr = 1;
+		/* Skipping spx_int_msk.s.reserved_2_3 */
+		spx_int_msk.s.abnorm = 1;
+		spx_int_msk.s.prtnxa = 1;
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+		/* Skipping spx_int_msk.s.reserved_12_63 */
+		spx_int_msk.s.calerr = 1;
+		spx_int_msk.s.syncerr = 1;
+		spx_int_msk.s.diperr = 1;
+		spx_int_msk.s.tpaovr = 1;
+		spx_int_msk.s.rsverr = 1;
+		spx_int_msk.s.drwnng = 1;
+		spx_int_msk.s.clserr = 1;
+		spx_int_msk.s.spiovr = 1;
+		/* Skipping spx_int_msk.s.reserved_2_3 */
+		spx_int_msk.s.abnorm = 1;
+		spx_int_msk.s.prtnxa = 1;
+	}
+	cvmx_write_csr(CVMX_SPXX_INT_MSK(index), spx_int_msk.u64);
+}
+/**
+ * __cvmx_interrupt_stxx_int_msk_enable enables all interrupt bits in cvmx_stxx_int_msk_t
+ */
+void __cvmx_interrupt_stxx_int_msk_enable(int index)
+{
+	union cvmx_stxx_int_msk stx_int_msk;
+	cvmx_write_csr(CVMX_STXX_INT_REG(index),
+		       cvmx_read_csr(CVMX_STXX_INT_REG(index)));
+	stx_int_msk.u64 = 0;
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX)) {
+		/* Skipping stx_int_msk.s.reserved_8_63 */
+		stx_int_msk.s.frmerr = 1;
+		stx_int_msk.s.unxfrm = 1;
+		stx_int_msk.s.nosync = 1;
+		stx_int_msk.s.diperr = 1;
+		stx_int_msk.s.datovr = 1;
+		stx_int_msk.s.ovrbst = 1;
+		stx_int_msk.s.calpar1 = 1;
+		stx_int_msk.s.calpar0 = 1;
+	}
+	if (OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+		/* Skipping stx_int_msk.s.reserved_8_63 */
+		stx_int_msk.s.frmerr = 1;
+		stx_int_msk.s.unxfrm = 1;
+		stx_int_msk.s.nosync = 1;
+		stx_int_msk.s.diperr = 1;
+		stx_int_msk.s.datovr = 1;
+		stx_int_msk.s.ovrbst = 1;
+		stx_int_msk.s.calpar1 = 1;
+		stx_int_msk.s.calpar0 = 1;
+	}
+	cvmx_write_csr(CVMX_STXX_INT_MSK(index), stx_int_msk.u64);
+}
diff --git a/drivers/staging/octeon/cvmx-interrupt-rsl.c b/drivers/staging/octeon/cvmx-interrupt-rsl.c
new file mode 100644
index 0000000..df50048
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-interrupt-rsl.c
@@ -0,0 +1,140 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Utility functions to decode Octeon's RSL_INT_BLOCKS
+ * interrupts into error messages.
+ */
+
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-asxx-defs.h"
+#include "cvmx-gmxx-defs.h"
+
+#ifndef PRINT_ERROR
+#define PRINT_ERROR(format, ...)
+#endif
+
+void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block);
+
+/**
+ * Enable ASX error interrupts that exist on CN3XXX, CN50XX, and
+ * CN58XX.
+ *
+ * @block:  Interface to enable 0-1
+ */
+void __cvmx_interrupt_asxx_enable(int block)
+{
+	int mask;
+	union cvmx_asxx_int_en csr;
+	/*
+	 * CN38XX and CN58XX have two interfaces with 4 ports per
+	 * interface. All other chips have a max of 3 ports on
+	 * interface 0
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
+		mask = 0xf;	/* Set enables for 4 ports */
+	else
+		mask = 0x7;	/* Set enables for 3 ports */
+
+	/* Enable interface interrupts */
+	csr.u64 = cvmx_read_csr(CVMX_ASXX_INT_EN(block));
+	csr.s.txpsh = mask;
+	csr.s.txpop = mask;
+	csr.s.ovrflw = mask;
+	cvmx_write_csr(CVMX_ASXX_INT_EN(block), csr.u64);
+}
+/**
+ * Enable GMX error reporting for the supplied interface
+ *
+ * @interface: Interface to enable
+ */
+void __cvmx_interrupt_gmxx_enable(int interface)
+{
+	union cvmx_gmxx_inf_mode mode;
+	union cvmx_gmxx_tx_int_en gmx_tx_int_en;
+	int num_ports;
+	int index;
+
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		if (mode.s.en) {
+			switch (mode.cn56xx.mode) {
+			case 1:	/* XAUI */
+				num_ports = 1;
+				break;
+			case 2:	/* SGMII */
+			case 3:	/* PICMG */
+				num_ports = 4;
+				break;
+			default:	/* Disabled */
+				num_ports = 0;
+				break;
+			}
+		} else
+			num_ports = 0;
+	} else {
+		if (mode.s.en) {
+			if (OCTEON_IS_MODEL(OCTEON_CN38XX)
+			    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+				/*
+				 * SPI on CN38XX and CN58XX report all
+				 * errors through port 0.  RGMII needs
+				 * to check all 4 ports
+				 */
+				if (mode.s.type)
+					num_ports = 1;
+				else
+					num_ports = 4;
+			} else {
+				/*
+				 * CN30XX, CN31XX, and CN50XX have two
+				 * or three ports. GMII and MII has 2,
+				 * RGMII has three
+				 */
+				if (mode.s.type)
+					num_ports = 2;
+				else
+					num_ports = 3;
+			}
+		} else
+			num_ports = 0;
+	}
+
+	gmx_tx_int_en.u64 = 0;
+	if (num_ports) {
+		if (OCTEON_IS_MODEL(OCTEON_CN38XX)
+		    || OCTEON_IS_MODEL(OCTEON_CN58XX))
+			gmx_tx_int_en.s.ncb_nxa = 1;
+		gmx_tx_int_en.s.pko_nxa = 1;
+	}
+	gmx_tx_int_en.s.undflw = (1 << num_ports) - 1;
+	cvmx_write_csr(CVMX_GMXX_TX_INT_EN(interface), gmx_tx_int_en.u64);
+	for (index = 0; index < num_ports; index++)
+		__cvmx_interrupt_gmxx_rxx_int_en_enable(index, interface);
+}
diff --git a/drivers/staging/octeon/cvmx-ipd.h b/drivers/staging/octeon/cvmx-ipd.h
new file mode 100644
index 0000000..115a552
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-ipd.h
@@ -0,0 +1,338 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Interface to the hardware Input Packet Data unit.
+ */
+
+#ifndef __CVMX_IPD_H__
+#define __CVMX_IPD_H__
+
+#include <asm/octeon/octeon-feature.h>
+
+#include <asm/octeon/cvmx-ipd-defs.h>
+
+enum cvmx_ipd_mode {
+   CVMX_IPD_OPC_MODE_STT = 0LL,   /* All blocks DRAM, not cached in L2 */
+   CVMX_IPD_OPC_MODE_STF = 1LL,   /* All bloccks into  L2 */
+   CVMX_IPD_OPC_MODE_STF1_STT = 2LL,   /* 1st block L2, rest DRAM */
+   CVMX_IPD_OPC_MODE_STF2_STT = 3LL    /* 1st, 2nd blocks L2, rest DRAM */
+};
+
+#ifndef CVMX_ENABLE_LEN_M8_FIX
+#define CVMX_ENABLE_LEN_M8_FIX 0
+#endif
+
+/* CSR typedefs have been moved to cvmx-csr-*.h */
+typedef union cvmx_ipd_1st_mbuff_skip cvmx_ipd_mbuff_first_skip_t;
+typedef union cvmx_ipd_1st_next_ptr_back cvmx_ipd_first_next_ptr_back_t;
+
+typedef cvmx_ipd_mbuff_first_skip_t cvmx_ipd_mbuff_not_first_skip_t;
+typedef cvmx_ipd_first_next_ptr_back_t cvmx_ipd_second_next_ptr_back_t;
+
+/**
+ * Configure IPD
+ *
+ * @mbuff_size: Packets buffer size in 8 byte words
+ * @first_mbuff_skip:
+ *                   Number of 8 byte words to skip in the first buffer
+ * @not_first_mbuff_skip:
+ *                   Number of 8 byte words to skip in each following buffer
+ * @first_back: Must be same as first_mbuff_skip / 128
+ * @second_back:
+ *                   Must be same as not_first_mbuff_skip / 128
+ * @wqe_fpa_pool:
+ *                   FPA pool to get work entries from
+ * @cache_mode:
+ * @back_pres_enable_flag:
+ *                   Enable or disable port back pressure
+ */
+static inline void cvmx_ipd_config(uint64_t mbuff_size,
+				   uint64_t first_mbuff_skip,
+				   uint64_t not_first_mbuff_skip,
+				   uint64_t first_back,
+				   uint64_t second_back,
+				   uint64_t wqe_fpa_pool,
+				   enum cvmx_ipd_mode cache_mode,
+				   uint64_t back_pres_enable_flag)
+{
+	cvmx_ipd_mbuff_first_skip_t first_skip;
+	cvmx_ipd_mbuff_not_first_skip_t not_first_skip;
+	union cvmx_ipd_packet_mbuff_size size;
+	cvmx_ipd_first_next_ptr_back_t first_back_struct;
+	cvmx_ipd_second_next_ptr_back_t second_back_struct;
+	union cvmx_ipd_wqe_fpa_queue wqe_pool;
+	union cvmx_ipd_ctl_status ipd_ctl_reg;
+
+	first_skip.u64 = 0;
+	first_skip.s.skip_sz = first_mbuff_skip;
+	cvmx_write_csr(CVMX_IPD_1ST_MBUFF_SKIP, first_skip.u64);
+
+	not_first_skip.u64 = 0;
+	not_first_skip.s.skip_sz = not_first_mbuff_skip;
+	cvmx_write_csr(CVMX_IPD_NOT_1ST_MBUFF_SKIP, not_first_skip.u64);
+
+	size.u64 = 0;
+	size.s.mb_size = mbuff_size;
+	cvmx_write_csr(CVMX_IPD_PACKET_MBUFF_SIZE, size.u64);
+
+	first_back_struct.u64 = 0;
+	first_back_struct.s.back = first_back;
+	cvmx_write_csr(CVMX_IPD_1st_NEXT_PTR_BACK, first_back_struct.u64);
+
+	second_back_struct.u64 = 0;
+	second_back_struct.s.back = second_back;
+	cvmx_write_csr(CVMX_IPD_2nd_NEXT_PTR_BACK, second_back_struct.u64);
+
+	wqe_pool.u64 = 0;
+	wqe_pool.s.wqe_pool = wqe_fpa_pool;
+	cvmx_write_csr(CVMX_IPD_WQE_FPA_QUEUE, wqe_pool.u64);
+
+	ipd_ctl_reg.u64 = cvmx_read_csr(CVMX_IPD_CTL_STATUS);
+	ipd_ctl_reg.s.opc_mode = cache_mode;
+	ipd_ctl_reg.s.pbp_en = back_pres_enable_flag;
+	cvmx_write_csr(CVMX_IPD_CTL_STATUS, ipd_ctl_reg.u64);
+
+	/* Note: the example RED code that used to be here has been moved to
+	   cvmx_helper_setup_red */
+}
+
+/**
+ * Enable IPD
+ */
+static inline void cvmx_ipd_enable(void)
+{
+	union cvmx_ipd_ctl_status ipd_reg;
+	ipd_reg.u64 = cvmx_read_csr(CVMX_IPD_CTL_STATUS);
+	if (ipd_reg.s.ipd_en) {
+		cvmx_dprintf
+		    ("Warning: Enabling IPD when IPD already enabled.\n");
+	}
+	ipd_reg.s.ipd_en = 1;
+#if  CVMX_ENABLE_LEN_M8_FIX
+	if (!OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2))
+		ipd_reg.s.len_m8 = TRUE;
+#endif
+	cvmx_write_csr(CVMX_IPD_CTL_STATUS, ipd_reg.u64);
+}
+
+/**
+ * Disable IPD
+ */
+static inline void cvmx_ipd_disable(void)
+{
+	union cvmx_ipd_ctl_status ipd_reg;
+	ipd_reg.u64 = cvmx_read_csr(CVMX_IPD_CTL_STATUS);
+	ipd_reg.s.ipd_en = 0;
+	cvmx_write_csr(CVMX_IPD_CTL_STATUS, ipd_reg.u64);
+}
+
+/**
+ * Supportive function for cvmx_fpa_shutdown_pool.
+ */
+static inline void cvmx_ipd_free_ptr(void)
+{
+	/* Only CN38XXp{1,2} cannot read pointer out of the IPD */
+	if (!OCTEON_IS_MODEL(OCTEON_CN38XX_PASS1)
+	    && !OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2)) {
+		int no_wptr = 0;
+		union cvmx_ipd_ptr_count ipd_ptr_count;
+		ipd_ptr_count.u64 = cvmx_read_csr(CVMX_IPD_PTR_COUNT);
+
+		/* Handle Work Queue Entry in cn56xx and cn52xx */
+		if (octeon_has_feature(OCTEON_FEATURE_NO_WPTR)) {
+			union cvmx_ipd_ctl_status ipd_ctl_status;
+			ipd_ctl_status.u64 = cvmx_read_csr(CVMX_IPD_CTL_STATUS);
+			if (ipd_ctl_status.s.no_wptr)
+				no_wptr = 1;
+		}
+
+		/* Free the prefetched WQE */
+		if (ipd_ptr_count.s.wqev_cnt) {
+			union cvmx_ipd_wqe_ptr_valid ipd_wqe_ptr_valid;
+			ipd_wqe_ptr_valid.u64 =
+			    cvmx_read_csr(CVMX_IPD_WQE_PTR_VALID);
+			if (no_wptr)
+				cvmx_fpa_free(cvmx_phys_to_ptr
+					      ((uint64_t) ipd_wqe_ptr_valid.s.
+					       ptr << 7), CVMX_FPA_PACKET_POOL,
+					      0);
+			else
+				cvmx_fpa_free(cvmx_phys_to_ptr
+					      ((uint64_t) ipd_wqe_ptr_valid.s.
+					       ptr << 7), CVMX_FPA_WQE_POOL, 0);
+		}
+
+		/* Free all WQE in the fifo */
+		if (ipd_ptr_count.s.wqe_pcnt) {
+			int i;
+			union cvmx_ipd_pwp_ptr_fifo_ctl ipd_pwp_ptr_fifo_ctl;
+			ipd_pwp_ptr_fifo_ctl.u64 =
+			    cvmx_read_csr(CVMX_IPD_PWP_PTR_FIFO_CTL);
+			for (i = 0; i < ipd_ptr_count.s.wqe_pcnt; i++) {
+				ipd_pwp_ptr_fifo_ctl.s.cena = 0;
+				ipd_pwp_ptr_fifo_ctl.s.raddr =
+				    ipd_pwp_ptr_fifo_ctl.s.max_cnts +
+				    (ipd_pwp_ptr_fifo_ctl.s.wraddr +
+				     i) % ipd_pwp_ptr_fifo_ctl.s.max_cnts;
+				cvmx_write_csr(CVMX_IPD_PWP_PTR_FIFO_CTL,
+					       ipd_pwp_ptr_fifo_ctl.u64);
+				ipd_pwp_ptr_fifo_ctl.u64 =
+				    cvmx_read_csr(CVMX_IPD_PWP_PTR_FIFO_CTL);
+				if (no_wptr)
+					cvmx_fpa_free(cvmx_phys_to_ptr
+						      ((uint64_t)
+						       ipd_pwp_ptr_fifo_ctl.s.
+						       ptr << 7),
+						      CVMX_FPA_PACKET_POOL, 0);
+				else
+					cvmx_fpa_free(cvmx_phys_to_ptr
+						      ((uint64_t)
+						       ipd_pwp_ptr_fifo_ctl.s.
+						       ptr << 7),
+						      CVMX_FPA_WQE_POOL, 0);
+			}
+			ipd_pwp_ptr_fifo_ctl.s.cena = 1;
+			cvmx_write_csr(CVMX_IPD_PWP_PTR_FIFO_CTL,
+				       ipd_pwp_ptr_fifo_ctl.u64);
+		}
+
+		/* Free the prefetched packet */
+		if (ipd_ptr_count.s.pktv_cnt) {
+			union cvmx_ipd_pkt_ptr_valid ipd_pkt_ptr_valid;
+			ipd_pkt_ptr_valid.u64 =
+			    cvmx_read_csr(CVMX_IPD_PKT_PTR_VALID);
+			cvmx_fpa_free(cvmx_phys_to_ptr
+				      (ipd_pkt_ptr_valid.s.ptr << 7),
+				      CVMX_FPA_PACKET_POOL, 0);
+		}
+
+		/* Free the per port prefetched packets */
+		if (1) {
+			int i;
+			union cvmx_ipd_prc_port_ptr_fifo_ctl
+			    ipd_prc_port_ptr_fifo_ctl;
+			ipd_prc_port_ptr_fifo_ctl.u64 =
+			    cvmx_read_csr(CVMX_IPD_PRC_PORT_PTR_FIFO_CTL);
+
+			for (i = 0; i < ipd_prc_port_ptr_fifo_ctl.s.max_pkt;
+			     i++) {
+				ipd_prc_port_ptr_fifo_ctl.s.cena = 0;
+				ipd_prc_port_ptr_fifo_ctl.s.raddr =
+				    i % ipd_prc_port_ptr_fifo_ctl.s.max_pkt;
+				cvmx_write_csr(CVMX_IPD_PRC_PORT_PTR_FIFO_CTL,
+					       ipd_prc_port_ptr_fifo_ctl.u64);
+				ipd_prc_port_ptr_fifo_ctl.u64 =
+				    cvmx_read_csr
+				    (CVMX_IPD_PRC_PORT_PTR_FIFO_CTL);
+				cvmx_fpa_free(cvmx_phys_to_ptr
+					      ((uint64_t)
+					       ipd_prc_port_ptr_fifo_ctl.s.
+					       ptr << 7), CVMX_FPA_PACKET_POOL,
+					      0);
+			}
+			ipd_prc_port_ptr_fifo_ctl.s.cena = 1;
+			cvmx_write_csr(CVMX_IPD_PRC_PORT_PTR_FIFO_CTL,
+				       ipd_prc_port_ptr_fifo_ctl.u64);
+		}
+
+		/* Free all packets in the holding fifo */
+		if (ipd_ptr_count.s.pfif_cnt) {
+			int i;
+			union cvmx_ipd_prc_hold_ptr_fifo_ctl
+			    ipd_prc_hold_ptr_fifo_ctl;
+
+			ipd_prc_hold_ptr_fifo_ctl.u64 =
+			    cvmx_read_csr(CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL);
+
+			for (i = 0; i < ipd_ptr_count.s.pfif_cnt; i++) {
+				ipd_prc_hold_ptr_fifo_ctl.s.cena = 0;
+				ipd_prc_hold_ptr_fifo_ctl.s.raddr =
+				    (ipd_prc_hold_ptr_fifo_ctl.s.praddr +
+				     i) % ipd_prc_hold_ptr_fifo_ctl.s.max_pkt;
+				cvmx_write_csr(CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL,
+					       ipd_prc_hold_ptr_fifo_ctl.u64);
+				ipd_prc_hold_ptr_fifo_ctl.u64 =
+				    cvmx_read_csr
+				    (CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL);
+				cvmx_fpa_free(cvmx_phys_to_ptr
+					      ((uint64_t)
+					       ipd_prc_hold_ptr_fifo_ctl.s.
+					       ptr << 7), CVMX_FPA_PACKET_POOL,
+					      0);
+			}
+			ipd_prc_hold_ptr_fifo_ctl.s.cena = 1;
+			cvmx_write_csr(CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL,
+				       ipd_prc_hold_ptr_fifo_ctl.u64);
+		}
+
+		/* Free all packets in the fifo */
+		if (ipd_ptr_count.s.pkt_pcnt) {
+			int i;
+			union cvmx_ipd_pwp_ptr_fifo_ctl ipd_pwp_ptr_fifo_ctl;
+			ipd_pwp_ptr_fifo_ctl.u64 =
+			    cvmx_read_csr(CVMX_IPD_PWP_PTR_FIFO_CTL);
+
+			for (i = 0; i < ipd_ptr_count.s.pkt_pcnt; i++) {
+				ipd_pwp_ptr_fifo_ctl.s.cena = 0;
+				ipd_pwp_ptr_fifo_ctl.s.raddr =
+				    (ipd_pwp_ptr_fifo_ctl.s.praddr +
+				     i) % ipd_pwp_ptr_fifo_ctl.s.max_cnts;
+				cvmx_write_csr(CVMX_IPD_PWP_PTR_FIFO_CTL,
+					       ipd_pwp_ptr_fifo_ctl.u64);
+				ipd_pwp_ptr_fifo_ctl.u64 =
+				    cvmx_read_csr(CVMX_IPD_PWP_PTR_FIFO_CTL);
+				cvmx_fpa_free(cvmx_phys_to_ptr
+					      ((uint64_t) ipd_pwp_ptr_fifo_ctl.
+					       s.ptr << 7),
+					      CVMX_FPA_PACKET_POOL, 0);
+			}
+			ipd_pwp_ptr_fifo_ctl.s.cena = 1;
+			cvmx_write_csr(CVMX_IPD_PWP_PTR_FIFO_CTL,
+				       ipd_pwp_ptr_fifo_ctl.u64);
+		}
+
+		/* Reset the IPD to get all buffers out of it */
+		{
+			union cvmx_ipd_ctl_status ipd_ctl_status;
+			ipd_ctl_status.u64 = cvmx_read_csr(CVMX_IPD_CTL_STATUS);
+			ipd_ctl_status.s.reset = 1;
+			cvmx_write_csr(CVMX_IPD_CTL_STATUS, ipd_ctl_status.u64);
+		}
+
+		/* Reset the PIP */
+		{
+			union cvmx_pip_sft_rst pip_sft_rst;
+			pip_sft_rst.u64 = cvmx_read_csr(CVMX_PIP_SFT_RST);
+			pip_sft_rst.s.rst = 1;
+			cvmx_write_csr(CVMX_PIP_SFT_RST, pip_sft_rst.u64);
+		}
+	}
+}
+
+#endif /*  __CVMX_IPD_H__ */
diff --git a/drivers/staging/octeon/cvmx-mdio.h b/drivers/staging/octeon/cvmx-mdio.h
new file mode 100644
index 0000000..c987a75
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-mdio.h
@@ -0,0 +1,506 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * Interface to the SMI/MDIO hardware, including support for both IEEE 802.3
+ * clause 22 and clause 45 operations.
+ *
+ */
+
+#ifndef __CVMX_MIO_H__
+#define __CVMX_MIO_H__
+
+#include "cvmx-smix-defs.h"
+
+/**
+ * PHY register 0 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_CONTROL 0
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t reset:1;
+		uint16_t loopback:1;
+		uint16_t speed_lsb:1;
+		uint16_t autoneg_enable:1;
+		uint16_t power_down:1;
+		uint16_t isolate:1;
+		uint16_t restart_autoneg:1;
+		uint16_t duplex:1;
+		uint16_t collision_test:1;
+		uint16_t speed_msb:1;
+		uint16_t unidirectional_enable:1;
+		uint16_t reserved_0_4:5;
+	} s;
+} cvmx_mdio_phy_reg_control_t;
+
+/**
+ * PHY register 1 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_STATUS 1
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t capable_100base_t4:1;
+		uint16_t capable_100base_x_full:1;
+		uint16_t capable_100base_x_half:1;
+		uint16_t capable_10_full:1;
+		uint16_t capable_10_half:1;
+		uint16_t capable_100base_t2_full:1;
+		uint16_t capable_100base_t2_half:1;
+		uint16_t capable_extended_status:1;
+		uint16_t capable_unidirectional:1;
+		uint16_t capable_mf_preamble_suppression:1;
+		uint16_t autoneg_complete:1;
+		uint16_t remote_fault:1;
+		uint16_t capable_autoneg:1;
+		uint16_t link_status:1;
+		uint16_t jabber_detect:1;
+		uint16_t capable_extended_registers:1;
+
+	} s;
+} cvmx_mdio_phy_reg_status_t;
+
+/**
+ * PHY register 2 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_ID1 2
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t oui_bits_3_18;
+	} s;
+} cvmx_mdio_phy_reg_id1_t;
+
+/**
+ * PHY register 3 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_ID2 3
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t oui_bits_19_24:6;
+		uint16_t model:6;
+		uint16_t revision:4;
+	} s;
+} cvmx_mdio_phy_reg_id2_t;
+
+/**
+ * PHY register 4 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_AUTONEG_ADVER 4
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t next_page:1;
+		uint16_t reserved_14:1;
+		uint16_t remote_fault:1;
+		uint16_t reserved_12:1;
+		uint16_t asymmetric_pause:1;
+		uint16_t pause:1;
+		uint16_t advert_100base_t4:1;
+		uint16_t advert_100base_tx_full:1;
+		uint16_t advert_100base_tx_half:1;
+		uint16_t advert_10base_tx_full:1;
+		uint16_t advert_10base_tx_half:1;
+		uint16_t selector:5;
+	} s;
+} cvmx_mdio_phy_reg_autoneg_adver_t;
+
+/**
+ * PHY register 5 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_LINK_PARTNER_ABILITY 5
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t next_page:1;
+		uint16_t ack:1;
+		uint16_t remote_fault:1;
+		uint16_t reserved_12:1;
+		uint16_t asymmetric_pause:1;
+		uint16_t pause:1;
+		uint16_t advert_100base_t4:1;
+		uint16_t advert_100base_tx_full:1;
+		uint16_t advert_100base_tx_half:1;
+		uint16_t advert_10base_tx_full:1;
+		uint16_t advert_10base_tx_half:1;
+		uint16_t selector:5;
+	} s;
+} cvmx_mdio_phy_reg_link_partner_ability_t;
+
+/**
+ * PHY register 6 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_AUTONEG_EXPANSION 6
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t reserved_5_15:11;
+		uint16_t parallel_detection_fault:1;
+		uint16_t link_partner_next_page_capable:1;
+		uint16_t local_next_page_capable:1;
+		uint16_t page_received:1;
+		uint16_t link_partner_autoneg_capable:1;
+
+	} s;
+} cvmx_mdio_phy_reg_autoneg_expansion_t;
+
+/**
+ * PHY register 9 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_CONTROL_1000 9
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t test_mode:3;
+		uint16_t manual_master_slave:1;
+		uint16_t master:1;
+		uint16_t port_type:1;
+		uint16_t advert_1000base_t_full:1;
+		uint16_t advert_1000base_t_half:1;
+		uint16_t reserved_0_7:8;
+	} s;
+} cvmx_mdio_phy_reg_control_1000_t;
+
+/**
+ * PHY register 10 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_STATUS_1000 10
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t master_slave_fault:1;
+		uint16_t is_master:1;
+		uint16_t local_receiver_ok:1;
+		uint16_t remote_receiver_ok:1;
+		uint16_t remote_capable_1000base_t_full:1;
+		uint16_t remote_capable_1000base_t_half:1;
+		uint16_t reserved_8_9:2;
+		uint16_t idle_error_count:8;
+	} s;
+} cvmx_mdio_phy_reg_status_1000_t;
+
+/**
+ * PHY register 15 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_EXTENDED_STATUS 15
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t capable_1000base_x_full:1;
+		uint16_t capable_1000base_x_half:1;
+		uint16_t capable_1000base_t_full:1;
+		uint16_t capable_1000base_t_half:1;
+		uint16_t reserved_0_11:12;
+	} s;
+} cvmx_mdio_phy_reg_extended_status_t;
+
+/**
+ * PHY register 13 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_MMD_CONTROL 13
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t function:2;
+		uint16_t reserved_5_13:9;
+		uint16_t devad:5;
+	} s;
+} cvmx_mdio_phy_reg_mmd_control_t;
+
+/**
+ * PHY register 14 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_MMD_ADDRESS_DATA 14
+typedef union {
+	uint16_t u16;
+	struct {
+		uint16_t address_data:16;
+	} s;
+} cvmx_mdio_phy_reg_mmd_address_data_t;
+
+/* Operating request encodings. */
+#define MDIO_CLAUSE_22_WRITE    0
+#define MDIO_CLAUSE_22_READ     1
+
+#define MDIO_CLAUSE_45_ADDRESS  0
+#define MDIO_CLAUSE_45_WRITE    1
+#define MDIO_CLAUSE_45_READ_INC 2
+#define MDIO_CLAUSE_45_READ     3
+
+/* MMD identifiers, mostly for accessing devices withing XENPAK modules. */
+#define CVMX_MMD_DEVICE_PMA_PMD      1
+#define CVMX_MMD_DEVICE_WIS          2
+#define CVMX_MMD_DEVICE_PCS          3
+#define CVMX_MMD_DEVICE_PHY_XS       4
+#define CVMX_MMD_DEVICE_DTS_XS       5
+#define CVMX_MMD_DEVICE_TC           6
+#define CVMX_MMD_DEVICE_CL22_EXT     29
+#define CVMX_MMD_DEVICE_VENDOR_1     30
+#define CVMX_MMD_DEVICE_VENDOR_2     31
+
+/* Helper function to put MDIO interface into clause 45 mode */
+static inline void __cvmx_mdio_set_clause45_mode(int bus_id)
+{
+	union cvmx_smix_clk smi_clk;
+	/* Put bus into clause 45 mode */
+	smi_clk.u64 = cvmx_read_csr(CVMX_SMIX_CLK(bus_id));
+	smi_clk.s.mode = 1;
+	smi_clk.s.preamble = 1;
+	cvmx_write_csr(CVMX_SMIX_CLK(bus_id), smi_clk.u64);
+}
+
+/* Helper function to put MDIO interface into clause 22 mode */
+static inline void __cvmx_mdio_set_clause22_mode(int bus_id)
+{
+	union cvmx_smix_clk smi_clk;
+	/* Put bus into clause 22 mode */
+	smi_clk.u64 = cvmx_read_csr(CVMX_SMIX_CLK(bus_id));
+	smi_clk.s.mode = 0;
+	cvmx_write_csr(CVMX_SMIX_CLK(bus_id), smi_clk.u64);
+}
+
+/**
+ * Perform an MII read. This function is used to read PHY
+ * registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @location: Register location to read
+ *
+ * Returns Result from the read or -1 on failure
+ */
+static inline int cvmx_mdio_read(int bus_id, int phy_id, int location)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_rd_dat smi_rd;
+	int timeout = 1000;
+
+	if (octeon_has_feature(OCTEON_FEATURE_MDIO_CLAUSE_45))
+		__cvmx_mdio_set_clause22_mode(bus_id);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_22_READ;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = location;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_rd.u64 = cvmx_read_csr(CVMX_SMIX_RD_DAT(bus_id));
+	} while (smi_rd.s.pending && timeout--);
+
+	if (smi_rd.s.val)
+		return smi_rd.s.dat;
+	else
+		return -1;
+}
+
+/**
+ * Perform an MII write. This function is used to write PHY
+ * registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @location: Register location to write
+ * @val:      Value to write
+ *
+ * Returns -1 on error
+ *         0 on success
+ */
+static inline int cvmx_mdio_write(int bus_id, int phy_id, int location, int val)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_wr_dat smi_wr;
+	int timeout = 1000;
+
+	if (octeon_has_feature(OCTEON_FEATURE_MDIO_CLAUSE_45))
+		__cvmx_mdio_set_clause22_mode(bus_id);
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = val;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(bus_id), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_22_WRITE;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = location;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(bus_id));
+	} while (smi_wr.s.pending && --timeout);
+	if (timeout <= 0)
+		return -1;
+
+	return 0;
+}
+
+/**
+ * Perform an IEEE 802.3 clause 45 MII read. This function is used to
+ * read PHY registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @device:   MDIO Managable Device (MMD) id
+ * @location: Register location to read
+ *
+ * Returns Result from the read or -1 on failure
+ */
+
+static inline int cvmx_mdio_45_read(int bus_id, int phy_id, int device,
+				    int location)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_rd_dat smi_rd;
+	union cvmx_smix_wr_dat smi_wr;
+	int timeout = 1000;
+
+	if (!octeon_has_feature(OCTEON_FEATURE_MDIO_CLAUSE_45))
+		return -1;
+
+	__cvmx_mdio_set_clause45_mode(bus_id);
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = location;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(bus_id), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_45_ADDRESS;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = device;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(bus_id));
+	} while (smi_wr.s.pending && --timeout);
+	if (timeout <= 0) {
+		cvmx_dprintf("cvmx_mdio_45_read: bus_id %d phy_id %2d "
+			     "device %2d register %2d   TIME OUT(address)\n",
+		     bus_id, phy_id, device, location);
+		return -1;
+	}
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_45_READ;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = device;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_rd.u64 = cvmx_read_csr(CVMX_SMIX_RD_DAT(bus_id));
+	} while (smi_rd.s.pending && timeout--);
+
+	if (timeout <= 0) {
+		cvmx_dprintf("cvmx_mdio_45_read: bus_id %d phy_id %2d "
+			     "device %2d register %2d   TIME OUT(data)\n",
+		     bus_id, phy_id, device, location);
+		return -1;
+	}
+
+	if (smi_rd.s.val)
+		return smi_rd.s.dat;
+	else {
+		cvmx_dprintf("cvmx_mdio_45_read: bus_id %d phy_id %2d "
+			     "device %2d register %2d   INVALID READ\n",
+		     bus_id, phy_id, device, location);
+		return -1;
+	}
+}
+
+/**
+ * Perform an IEEE 802.3 clause 45 MII write. This function is used to
+ * write PHY registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @device:   MDIO Managable Device (MMD) id
+ * @location: Register location to write
+ * @val:      Value to write
+ *
+ * Returns -1 on error
+ *         0 on success
+ */
+static inline int cvmx_mdio_45_write(int bus_id, int phy_id, int device,
+				     int location, int val)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_wr_dat smi_wr;
+	int timeout = 1000;
+
+	if (!octeon_has_feature(OCTEON_FEATURE_MDIO_CLAUSE_45))
+		return -1;
+
+	__cvmx_mdio_set_clause45_mode(bus_id);
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = location;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(bus_id), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_45_ADDRESS;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = device;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(bus_id));
+	} while (smi_wr.s.pending && --timeout);
+	if (timeout <= 0)
+		return -1;
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = val;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(bus_id), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_45_WRITE;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = device;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(bus_id));
+	} while (smi_wr.s.pending && --timeout);
+	if (timeout <= 0)
+		return -1;
+
+	return 0;
+}
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-packet.h b/drivers/staging/octeon/cvmx-packet.h
new file mode 100644
index 0000000..62ffe78
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-packet.h
@@ -0,0 +1,65 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Packet buffer defines.
+ */
+
+#ifndef __CVMX_PACKET_H__
+#define __CVMX_PACKET_H__
+
+/**
+ * This structure defines a buffer pointer on Octeon
+ */
+union cvmx_buf_ptr {
+	void *ptr;
+	uint64_t u64;
+	struct {
+		/*
+		 * if set, invert the "free" pick of the overall
+		 * packet. HW always sets this bit to 0 on inbound
+		 * packet
+		 */
+		uint64_t i:1;
+		/*
+		 * Indicates the amount to back up to get to the
+		 * buffer start in cache lines. In most cases this is
+		 * less than one complete cache line, so the value is
+		 * zero.
+		 */
+		uint64_t back:4;
+		/* The pool that the buffer came from / goes to */
+		uint64_t pool:3;
+		/* The size of the segment pointed to by addr (in bytes) */
+		uint64_t size:16;
+		/* Pointer to the first byte of the data, NOT buffer */
+		uint64_t addr:40;
+	} s;
+};
+
+#endif /*  __CVMX_PACKET_H__ */
diff --git a/drivers/staging/octeon/cvmx-pcsx-defs.h b/drivers/staging/octeon/cvmx-pcsx-defs.h
new file mode 100644
index 0000000..d45952d
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-pcsx-defs.h
@@ -0,0 +1,370 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_PCSX_DEFS_H__
+#define __CVMX_PCSX_DEFS_H__
+
+#define CVMX_PCSX_ANX_ADV_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001010ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_ANX_EXT_ST_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001028ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_ANX_LP_ABIL_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001018ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_ANX_RESULTS_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001020ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_INTX_EN_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001088ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_INTX_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001080ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_LINKX_TIMER_COUNT_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001040ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_LOG_ANLX_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001090ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_MISCX_CTL_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001078ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_MRX_CONTROL_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001000ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_MRX_STATUS_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001008ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_RXX_STATES_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001058ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_RXX_SYNC_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001050ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_SGMX_AN_ADV_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001068ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_SGMX_LP_ADV_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001070ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_TXX_STATES_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001060ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSX_TX_RXX_POLARITY_REG(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0001048ull + (((offset) & 3) * 1024) + (((block_id) & 1) * 0x8000000ull))
+
+union cvmx_pcsx_anx_adv_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_anx_adv_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t np:1;
+		uint64_t reserved_14_14:1;
+		uint64_t rem_flt:2;
+		uint64_t reserved_9_11:3;
+		uint64_t pause:2;
+		uint64_t hfd:1;
+		uint64_t fd:1;
+		uint64_t reserved_0_4:5;
+	} s;
+	struct cvmx_pcsx_anx_adv_reg_s cn52xx;
+	struct cvmx_pcsx_anx_adv_reg_s cn52xxp1;
+	struct cvmx_pcsx_anx_adv_reg_s cn56xx;
+	struct cvmx_pcsx_anx_adv_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_anx_ext_st_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_anx_ext_st_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t thou_xfd:1;
+		uint64_t thou_xhd:1;
+		uint64_t thou_tfd:1;
+		uint64_t thou_thd:1;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pcsx_anx_ext_st_reg_s cn52xx;
+	struct cvmx_pcsx_anx_ext_st_reg_s cn52xxp1;
+	struct cvmx_pcsx_anx_ext_st_reg_s cn56xx;
+	struct cvmx_pcsx_anx_ext_st_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_anx_lp_abil_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_anx_lp_abil_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t np:1;
+		uint64_t ack:1;
+		uint64_t rem_flt:2;
+		uint64_t reserved_9_11:3;
+		uint64_t pause:2;
+		uint64_t hfd:1;
+		uint64_t fd:1;
+		uint64_t reserved_0_4:5;
+	} s;
+	struct cvmx_pcsx_anx_lp_abil_reg_s cn52xx;
+	struct cvmx_pcsx_anx_lp_abil_reg_s cn52xxp1;
+	struct cvmx_pcsx_anx_lp_abil_reg_s cn56xx;
+	struct cvmx_pcsx_anx_lp_abil_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_anx_results_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_anx_results_reg_s {
+		uint64_t reserved_7_63:57;
+		uint64_t pause:2;
+		uint64_t spd:2;
+		uint64_t an_cpt:1;
+		uint64_t dup:1;
+		uint64_t link_ok:1;
+	} s;
+	struct cvmx_pcsx_anx_results_reg_s cn52xx;
+	struct cvmx_pcsx_anx_results_reg_s cn52xxp1;
+	struct cvmx_pcsx_anx_results_reg_s cn56xx;
+	struct cvmx_pcsx_anx_results_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_intx_en_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_intx_en_reg_s {
+		uint64_t reserved_12_63:52;
+		uint64_t dup:1;
+		uint64_t sync_bad_en:1;
+		uint64_t an_bad_en:1;
+		uint64_t rxlock_en:1;
+		uint64_t rxbad_en:1;
+		uint64_t rxerr_en:1;
+		uint64_t txbad_en:1;
+		uint64_t txfifo_en:1;
+		uint64_t txfifu_en:1;
+		uint64_t an_err_en:1;
+		uint64_t xmit_en:1;
+		uint64_t lnkspd_en:1;
+	} s;
+	struct cvmx_pcsx_intx_en_reg_s cn52xx;
+	struct cvmx_pcsx_intx_en_reg_s cn52xxp1;
+	struct cvmx_pcsx_intx_en_reg_s cn56xx;
+	struct cvmx_pcsx_intx_en_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_intx_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_intx_reg_s {
+		uint64_t reserved_12_63:52;
+		uint64_t dup:1;
+		uint64_t sync_bad:1;
+		uint64_t an_bad:1;
+		uint64_t rxlock:1;
+		uint64_t rxbad:1;
+		uint64_t rxerr:1;
+		uint64_t txbad:1;
+		uint64_t txfifo:1;
+		uint64_t txfifu:1;
+		uint64_t an_err:1;
+		uint64_t xmit:1;
+		uint64_t lnkspd:1;
+	} s;
+	struct cvmx_pcsx_intx_reg_s cn52xx;
+	struct cvmx_pcsx_intx_reg_s cn52xxp1;
+	struct cvmx_pcsx_intx_reg_s cn56xx;
+	struct cvmx_pcsx_intx_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_linkx_timer_count_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_linkx_timer_count_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t count:16;
+	} s;
+	struct cvmx_pcsx_linkx_timer_count_reg_s cn52xx;
+	struct cvmx_pcsx_linkx_timer_count_reg_s cn52xxp1;
+	struct cvmx_pcsx_linkx_timer_count_reg_s cn56xx;
+	struct cvmx_pcsx_linkx_timer_count_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_log_anlx_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_log_anlx_reg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t lafifovfl:1;
+		uint64_t la_en:1;
+		uint64_t pkt_sz:2;
+	} s;
+	struct cvmx_pcsx_log_anlx_reg_s cn52xx;
+	struct cvmx_pcsx_log_anlx_reg_s cn52xxp1;
+	struct cvmx_pcsx_log_anlx_reg_s cn56xx;
+	struct cvmx_pcsx_log_anlx_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_miscx_ctl_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_miscx_ctl_reg_s {
+		uint64_t reserved_13_63:51;
+		uint64_t sgmii:1;
+		uint64_t gmxeno:1;
+		uint64_t loopbck2:1;
+		uint64_t mac_phy:1;
+		uint64_t mode:1;
+		uint64_t an_ovrd:1;
+		uint64_t samp_pt:7;
+	} s;
+	struct cvmx_pcsx_miscx_ctl_reg_s cn52xx;
+	struct cvmx_pcsx_miscx_ctl_reg_s cn52xxp1;
+	struct cvmx_pcsx_miscx_ctl_reg_s cn56xx;
+	struct cvmx_pcsx_miscx_ctl_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_mrx_control_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_mrx_control_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t reset:1;
+		uint64_t loopbck1:1;
+		uint64_t spdlsb:1;
+		uint64_t an_en:1;
+		uint64_t pwr_dn:1;
+		uint64_t reserved_10_10:1;
+		uint64_t rst_an:1;
+		uint64_t dup:1;
+		uint64_t coltst:1;
+		uint64_t spdmsb:1;
+		uint64_t uni:1;
+		uint64_t reserved_0_4:5;
+	} s;
+	struct cvmx_pcsx_mrx_control_reg_s cn52xx;
+	struct cvmx_pcsx_mrx_control_reg_s cn52xxp1;
+	struct cvmx_pcsx_mrx_control_reg_s cn56xx;
+	struct cvmx_pcsx_mrx_control_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_mrx_status_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_mrx_status_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t hun_t4:1;
+		uint64_t hun_xfd:1;
+		uint64_t hun_xhd:1;
+		uint64_t ten_fd:1;
+		uint64_t ten_hd:1;
+		uint64_t hun_t2fd:1;
+		uint64_t hun_t2hd:1;
+		uint64_t ext_st:1;
+		uint64_t reserved_7_7:1;
+		uint64_t prb_sup:1;
+		uint64_t an_cpt:1;
+		uint64_t rm_flt:1;
+		uint64_t an_abil:1;
+		uint64_t lnk_st:1;
+		uint64_t reserved_1_1:1;
+		uint64_t extnd:1;
+	} s;
+	struct cvmx_pcsx_mrx_status_reg_s cn52xx;
+	struct cvmx_pcsx_mrx_status_reg_s cn52xxp1;
+	struct cvmx_pcsx_mrx_status_reg_s cn56xx;
+	struct cvmx_pcsx_mrx_status_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_rxx_states_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_rxx_states_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t rx_bad:1;
+		uint64_t rx_st:5;
+		uint64_t sync_bad:1;
+		uint64_t sync:4;
+		uint64_t an_bad:1;
+		uint64_t an_st:4;
+	} s;
+	struct cvmx_pcsx_rxx_states_reg_s cn52xx;
+	struct cvmx_pcsx_rxx_states_reg_s cn52xxp1;
+	struct cvmx_pcsx_rxx_states_reg_s cn56xx;
+	struct cvmx_pcsx_rxx_states_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_rxx_sync_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_rxx_sync_reg_s {
+		uint64_t reserved_2_63:62;
+		uint64_t sync:1;
+		uint64_t bit_lock:1;
+	} s;
+	struct cvmx_pcsx_rxx_sync_reg_s cn52xx;
+	struct cvmx_pcsx_rxx_sync_reg_s cn52xxp1;
+	struct cvmx_pcsx_rxx_sync_reg_s cn56xx;
+	struct cvmx_pcsx_rxx_sync_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_sgmx_an_adv_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t link:1;
+		uint64_t ack:1;
+		uint64_t reserved_13_13:1;
+		uint64_t dup:1;
+		uint64_t speed:2;
+		uint64_t reserved_1_9:9;
+		uint64_t one:1;
+	} s;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s cn52xx;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s cn52xxp1;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s cn56xx;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_sgmx_lp_adv_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t link:1;
+		uint64_t reserved_13_14:2;
+		uint64_t dup:1;
+		uint64_t speed:2;
+		uint64_t reserved_1_9:9;
+		uint64_t one:1;
+	} s;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s cn52xx;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s cn52xxp1;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s cn56xx;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_txx_states_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_txx_states_reg_s {
+		uint64_t reserved_7_63:57;
+		uint64_t xmit:2;
+		uint64_t tx_bad:1;
+		uint64_t ord_st:4;
+	} s;
+	struct cvmx_pcsx_txx_states_reg_s cn52xx;
+	struct cvmx_pcsx_txx_states_reg_s cn52xxp1;
+	struct cvmx_pcsx_txx_states_reg_s cn56xx;
+	struct cvmx_pcsx_txx_states_reg_s cn56xxp1;
+};
+
+union cvmx_pcsx_tx_rxx_polarity_reg {
+	uint64_t u64;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t rxovrd:1;
+		uint64_t autorxpl:1;
+		uint64_t rxplrt:1;
+		uint64_t txplrt:1;
+	} s;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s cn52xx;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s cn52xxp1;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s cn56xx;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s cn56xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-pcsxx-defs.h b/drivers/staging/octeon/cvmx-pcsxx-defs.h
new file mode 100644
index 0000000..55d120f
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-pcsxx-defs.h
@@ -0,0 +1,316 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_PCSXX_DEFS_H__
+#define __CVMX_PCSXX_DEFS_H__
+
+#define CVMX_PCSXX_10GBX_STATUS_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000828ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_BIST_STATUS_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000870ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_BIT_LOCK_STATUS_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000850ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_CONTROL1_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000800ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_CONTROL2_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000818ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_INT_EN_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000860ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_INT_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000858ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_LOG_ANL_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000868ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_MISC_CTL_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000848ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_RX_SYNC_STATES_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000838ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_SPD_ABIL_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000810ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_STATUS1_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000808ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_STATUS2_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000820ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_TX_RX_POLARITY_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000840ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PCSXX_TX_RX_STATES_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800B0000830ull + (((block_id) & 1) * 0x8000000ull))
+
+union cvmx_pcsxx_10gbx_status_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_10gbx_status_reg_s {
+		uint64_t reserved_13_63:51;
+		uint64_t alignd:1;
+		uint64_t pattst:1;
+		uint64_t reserved_4_10:7;
+		uint64_t l3sync:1;
+		uint64_t l2sync:1;
+		uint64_t l1sync:1;
+		uint64_t l0sync:1;
+	} s;
+	struct cvmx_pcsxx_10gbx_status_reg_s cn52xx;
+	struct cvmx_pcsxx_10gbx_status_reg_s cn52xxp1;
+	struct cvmx_pcsxx_10gbx_status_reg_s cn56xx;
+	struct cvmx_pcsxx_10gbx_status_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_bist_status_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_bist_status_reg_s {
+		uint64_t reserved_1_63:63;
+		uint64_t bist_status:1;
+	} s;
+	struct cvmx_pcsxx_bist_status_reg_s cn52xx;
+	struct cvmx_pcsxx_bist_status_reg_s cn52xxp1;
+	struct cvmx_pcsxx_bist_status_reg_s cn56xx;
+	struct cvmx_pcsxx_bist_status_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_bit_lock_status_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_bit_lock_status_reg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t bitlck3:1;
+		uint64_t bitlck2:1;
+		uint64_t bitlck1:1;
+		uint64_t bitlck0:1;
+	} s;
+	struct cvmx_pcsxx_bit_lock_status_reg_s cn52xx;
+	struct cvmx_pcsxx_bit_lock_status_reg_s cn52xxp1;
+	struct cvmx_pcsxx_bit_lock_status_reg_s cn56xx;
+	struct cvmx_pcsxx_bit_lock_status_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_control1_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_control1_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t reset:1;
+		uint64_t loopbck1:1;
+		uint64_t spdsel1:1;
+		uint64_t reserved_12_12:1;
+		uint64_t lo_pwr:1;
+		uint64_t reserved_7_10:4;
+		uint64_t spdsel0:1;
+		uint64_t spd:4;
+		uint64_t reserved_0_1:2;
+	} s;
+	struct cvmx_pcsxx_control1_reg_s cn52xx;
+	struct cvmx_pcsxx_control1_reg_s cn52xxp1;
+	struct cvmx_pcsxx_control1_reg_s cn56xx;
+	struct cvmx_pcsxx_control1_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_control2_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_control2_reg_s {
+		uint64_t reserved_2_63:62;
+		uint64_t type:2;
+	} s;
+	struct cvmx_pcsxx_control2_reg_s cn52xx;
+	struct cvmx_pcsxx_control2_reg_s cn52xxp1;
+	struct cvmx_pcsxx_control2_reg_s cn56xx;
+	struct cvmx_pcsxx_control2_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_int_en_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_int_en_reg_s {
+		uint64_t reserved_6_63:58;
+		uint64_t algnlos_en:1;
+		uint64_t synlos_en:1;
+		uint64_t bitlckls_en:1;
+		uint64_t rxsynbad_en:1;
+		uint64_t rxbad_en:1;
+		uint64_t txflt_en:1;
+	} s;
+	struct cvmx_pcsxx_int_en_reg_s cn52xx;
+	struct cvmx_pcsxx_int_en_reg_s cn52xxp1;
+	struct cvmx_pcsxx_int_en_reg_s cn56xx;
+	struct cvmx_pcsxx_int_en_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_int_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_int_reg_s {
+		uint64_t reserved_6_63:58;
+		uint64_t algnlos:1;
+		uint64_t synlos:1;
+		uint64_t bitlckls:1;
+		uint64_t rxsynbad:1;
+		uint64_t rxbad:1;
+		uint64_t txflt:1;
+	} s;
+	struct cvmx_pcsxx_int_reg_s cn52xx;
+	struct cvmx_pcsxx_int_reg_s cn52xxp1;
+	struct cvmx_pcsxx_int_reg_s cn56xx;
+	struct cvmx_pcsxx_int_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_log_anl_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_log_anl_reg_s {
+		uint64_t reserved_7_63:57;
+		uint64_t enc_mode:1;
+		uint64_t drop_ln:2;
+		uint64_t lafifovfl:1;
+		uint64_t la_en:1;
+		uint64_t pkt_sz:2;
+	} s;
+	struct cvmx_pcsxx_log_anl_reg_s cn52xx;
+	struct cvmx_pcsxx_log_anl_reg_s cn52xxp1;
+	struct cvmx_pcsxx_log_anl_reg_s cn56xx;
+	struct cvmx_pcsxx_log_anl_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_misc_ctl_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_misc_ctl_reg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t tx_swap:1;
+		uint64_t rx_swap:1;
+		uint64_t xaui:1;
+		uint64_t gmxeno:1;
+	} s;
+	struct cvmx_pcsxx_misc_ctl_reg_s cn52xx;
+	struct cvmx_pcsxx_misc_ctl_reg_s cn52xxp1;
+	struct cvmx_pcsxx_misc_ctl_reg_s cn56xx;
+	struct cvmx_pcsxx_misc_ctl_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_rx_sync_states_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_rx_sync_states_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t sync3st:4;
+		uint64_t sync2st:4;
+		uint64_t sync1st:4;
+		uint64_t sync0st:4;
+	} s;
+	struct cvmx_pcsxx_rx_sync_states_reg_s cn52xx;
+	struct cvmx_pcsxx_rx_sync_states_reg_s cn52xxp1;
+	struct cvmx_pcsxx_rx_sync_states_reg_s cn56xx;
+	struct cvmx_pcsxx_rx_sync_states_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_spd_abil_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_spd_abil_reg_s {
+		uint64_t reserved_2_63:62;
+		uint64_t tenpasst:1;
+		uint64_t tengb:1;
+	} s;
+	struct cvmx_pcsxx_spd_abil_reg_s cn52xx;
+	struct cvmx_pcsxx_spd_abil_reg_s cn52xxp1;
+	struct cvmx_pcsxx_spd_abil_reg_s cn56xx;
+	struct cvmx_pcsxx_spd_abil_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_status1_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_status1_reg_s {
+		uint64_t reserved_8_63:56;
+		uint64_t flt:1;
+		uint64_t reserved_3_6:4;
+		uint64_t rcv_lnk:1;
+		uint64_t lpable:1;
+		uint64_t reserved_0_0:1;
+	} s;
+	struct cvmx_pcsxx_status1_reg_s cn52xx;
+	struct cvmx_pcsxx_status1_reg_s cn52xxp1;
+	struct cvmx_pcsxx_status1_reg_s cn56xx;
+	struct cvmx_pcsxx_status1_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_status2_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_status2_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dev:2;
+		uint64_t reserved_12_13:2;
+		uint64_t xmtflt:1;
+		uint64_t rcvflt:1;
+		uint64_t reserved_3_9:7;
+		uint64_t tengb_w:1;
+		uint64_t tengb_x:1;
+		uint64_t tengb_r:1;
+	} s;
+	struct cvmx_pcsxx_status2_reg_s cn52xx;
+	struct cvmx_pcsxx_status2_reg_s cn52xxp1;
+	struct cvmx_pcsxx_status2_reg_s cn56xx;
+	struct cvmx_pcsxx_status2_reg_s cn56xxp1;
+};
+
+union cvmx_pcsxx_tx_rx_polarity_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_s {
+		uint64_t reserved_10_63:54;
+		uint64_t xor_rxplrt:4;
+		uint64_t xor_txplrt:4;
+		uint64_t rxplrt:1;
+		uint64_t txplrt:1;
+	} s;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_s cn52xx;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_cn52xxp1 {
+		uint64_t reserved_2_63:62;
+		uint64_t rxplrt:1;
+		uint64_t txplrt:1;
+	} cn52xxp1;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_s cn56xx;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_cn52xxp1 cn56xxp1;
+};
+
+union cvmx_pcsxx_tx_rx_states_reg {
+	uint64_t u64;
+	struct cvmx_pcsxx_tx_rx_states_reg_s {
+		uint64_t reserved_14_63:50;
+		uint64_t term_err:1;
+		uint64_t syn3bad:1;
+		uint64_t syn2bad:1;
+		uint64_t syn1bad:1;
+		uint64_t syn0bad:1;
+		uint64_t rxbad:1;
+		uint64_t algn_st:3;
+		uint64_t rx_st:2;
+		uint64_t tx_st:3;
+	} s;
+	struct cvmx_pcsxx_tx_rx_states_reg_s cn52xx;
+	struct cvmx_pcsxx_tx_rx_states_reg_cn52xxp1 {
+		uint64_t reserved_13_63:51;
+		uint64_t syn3bad:1;
+		uint64_t syn2bad:1;
+		uint64_t syn1bad:1;
+		uint64_t syn0bad:1;
+		uint64_t rxbad:1;
+		uint64_t algn_st:3;
+		uint64_t rx_st:2;
+		uint64_t tx_st:3;
+	} cn52xxp1;
+	struct cvmx_pcsxx_tx_rx_states_reg_s cn56xx;
+	struct cvmx_pcsxx_tx_rx_states_reg_cn52xxp1 cn56xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-pip-defs.h b/drivers/staging/octeon/cvmx-pip-defs.h
new file mode 100644
index 0000000..5a36910
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-pip-defs.h
@@ -0,0 +1,1267 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_PIP_DEFS_H__
+#define __CVMX_PIP_DEFS_H__
+
+/*
+ * Enumeration representing the amount of packet processing
+ * and validation performed by the input hardware.
+ */
+enum cvmx_pip_port_parse_mode {
+	/*
+	 * Packet input doesn't perform any processing of the input
+	 * packet.
+	 */
+	CVMX_PIP_PORT_CFG_MODE_NONE = 0ull,
+	/*
+	 * Full packet processing is performed with pointer starting
+	 * at the L2 (ethernet MAC) header.
+	 */
+	CVMX_PIP_PORT_CFG_MODE_SKIPL2 = 1ull,
+	/*
+	 * Input packets are assumed to be IP.  Results from non IP
+	 * packets is undefined. Pointers reference the beginning of
+	 * the IP header.
+	 */
+	CVMX_PIP_PORT_CFG_MODE_SKIPIP = 2ull
+};
+
+#define CVMX_PIP_BCK_PRS \
+	 CVMX_ADD_IO_SEG(0x00011800A0000038ull)
+#define CVMX_PIP_BIST_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011800A0000000ull)
+#define CVMX_PIP_CRC_CTLX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000040ull + (((offset) & 1) * 8))
+#define CVMX_PIP_CRC_IVX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000050ull + (((offset) & 1) * 8))
+#define CVMX_PIP_DEC_IPSECX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000080ull + (((offset) & 3) * 8))
+#define CVMX_PIP_DSA_SRC_GRP \
+	 CVMX_ADD_IO_SEG(0x00011800A0000190ull)
+#define CVMX_PIP_DSA_VID_GRP \
+	 CVMX_ADD_IO_SEG(0x00011800A0000198ull)
+#define CVMX_PIP_FRM_LEN_CHKX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000180ull + (((offset) & 1) * 8))
+#define CVMX_PIP_GBL_CFG \
+	 CVMX_ADD_IO_SEG(0x00011800A0000028ull)
+#define CVMX_PIP_GBL_CTL \
+	 CVMX_ADD_IO_SEG(0x00011800A0000020ull)
+#define CVMX_PIP_HG_PRI_QOS \
+	 CVMX_ADD_IO_SEG(0x00011800A00001A0ull)
+#define CVMX_PIP_INT_EN \
+	 CVMX_ADD_IO_SEG(0x00011800A0000010ull)
+#define CVMX_PIP_INT_REG \
+	 CVMX_ADD_IO_SEG(0x00011800A0000008ull)
+#define CVMX_PIP_IP_OFFSET \
+	 CVMX_ADD_IO_SEG(0x00011800A0000060ull)
+#define CVMX_PIP_PRT_CFGX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000200ull + (((offset) & 63) * 8))
+#define CVMX_PIP_PRT_TAGX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000400ull + (((offset) & 63) * 8))
+#define CVMX_PIP_QOS_DIFFX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000600ull + (((offset) & 63) * 8))
+#define CVMX_PIP_QOS_VLANX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A00000C0ull + (((offset) & 7) * 8))
+#define CVMX_PIP_QOS_WATCHX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000100ull + (((offset) & 7) * 8))
+#define CVMX_PIP_RAW_WORD \
+	 CVMX_ADD_IO_SEG(0x00011800A00000B0ull)
+#define CVMX_PIP_SFT_RST \
+	 CVMX_ADD_IO_SEG(0x00011800A0000030ull)
+#define CVMX_PIP_STAT0_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000800ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT1_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000808ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT2_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000810ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT3_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000818ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT4_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000820ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT5_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000828ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT6_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000830ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT7_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000838ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT8_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000840ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT9_PRTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0000848ull + (((offset) & 63) * 80))
+#define CVMX_PIP_STAT_CTL \
+	 CVMX_ADD_IO_SEG(0x00011800A0000018ull)
+#define CVMX_PIP_STAT_INB_ERRSX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0001A10ull + (((offset) & 63) * 32))
+#define CVMX_PIP_STAT_INB_OCTSX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0001A08ull + (((offset) & 63) * 32))
+#define CVMX_PIP_STAT_INB_PKTSX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0001A00ull + (((offset) & 63) * 32))
+#define CVMX_PIP_TAG_INCX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800A0001800ull + (((offset) & 63) * 8))
+#define CVMX_PIP_TAG_MASK \
+	 CVMX_ADD_IO_SEG(0x00011800A0000070ull)
+#define CVMX_PIP_TAG_SECRET \
+	 CVMX_ADD_IO_SEG(0x00011800A0000068ull)
+#define CVMX_PIP_TODO_ENTRY \
+	 CVMX_ADD_IO_SEG(0x00011800A0000078ull)
+
+union cvmx_pip_bck_prs {
+	uint64_t u64;
+	struct cvmx_pip_bck_prs_s {
+		uint64_t bckprs:1;
+		uint64_t reserved_13_62:50;
+		uint64_t hiwater:5;
+		uint64_t reserved_5_7:3;
+		uint64_t lowater:5;
+	} s;
+	struct cvmx_pip_bck_prs_s cn38xx;
+	struct cvmx_pip_bck_prs_s cn38xxp2;
+	struct cvmx_pip_bck_prs_s cn56xx;
+	struct cvmx_pip_bck_prs_s cn56xxp1;
+	struct cvmx_pip_bck_prs_s cn58xx;
+	struct cvmx_pip_bck_prs_s cn58xxp1;
+};
+
+union cvmx_pip_bist_status {
+	uint64_t u64;
+	struct cvmx_pip_bist_status_s {
+		uint64_t reserved_18_63:46;
+		uint64_t bist:18;
+	} s;
+	struct cvmx_pip_bist_status_s cn30xx;
+	struct cvmx_pip_bist_status_s cn31xx;
+	struct cvmx_pip_bist_status_s cn38xx;
+	struct cvmx_pip_bist_status_s cn38xxp2;
+	struct cvmx_pip_bist_status_cn50xx {
+		uint64_t reserved_17_63:47;
+		uint64_t bist:17;
+	} cn50xx;
+	struct cvmx_pip_bist_status_s cn52xx;
+	struct cvmx_pip_bist_status_s cn52xxp1;
+	struct cvmx_pip_bist_status_s cn56xx;
+	struct cvmx_pip_bist_status_s cn56xxp1;
+	struct cvmx_pip_bist_status_s cn58xx;
+	struct cvmx_pip_bist_status_s cn58xxp1;
+};
+
+union cvmx_pip_crc_ctlx {
+	uint64_t u64;
+	struct cvmx_pip_crc_ctlx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t invres:1;
+		uint64_t reflect:1;
+	} s;
+	struct cvmx_pip_crc_ctlx_s cn38xx;
+	struct cvmx_pip_crc_ctlx_s cn38xxp2;
+	struct cvmx_pip_crc_ctlx_s cn58xx;
+	struct cvmx_pip_crc_ctlx_s cn58xxp1;
+};
+
+union cvmx_pip_crc_ivx {
+	uint64_t u64;
+	struct cvmx_pip_crc_ivx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iv:32;
+	} s;
+	struct cvmx_pip_crc_ivx_s cn38xx;
+	struct cvmx_pip_crc_ivx_s cn38xxp2;
+	struct cvmx_pip_crc_ivx_s cn58xx;
+	struct cvmx_pip_crc_ivx_s cn58xxp1;
+};
+
+union cvmx_pip_dec_ipsecx {
+	uint64_t u64;
+	struct cvmx_pip_dec_ipsecx_s {
+		uint64_t reserved_18_63:46;
+		uint64_t tcp:1;
+		uint64_t udp:1;
+		uint64_t dprt:16;
+	} s;
+	struct cvmx_pip_dec_ipsecx_s cn30xx;
+	struct cvmx_pip_dec_ipsecx_s cn31xx;
+	struct cvmx_pip_dec_ipsecx_s cn38xx;
+	struct cvmx_pip_dec_ipsecx_s cn38xxp2;
+	struct cvmx_pip_dec_ipsecx_s cn50xx;
+	struct cvmx_pip_dec_ipsecx_s cn52xx;
+	struct cvmx_pip_dec_ipsecx_s cn52xxp1;
+	struct cvmx_pip_dec_ipsecx_s cn56xx;
+	struct cvmx_pip_dec_ipsecx_s cn56xxp1;
+	struct cvmx_pip_dec_ipsecx_s cn58xx;
+	struct cvmx_pip_dec_ipsecx_s cn58xxp1;
+};
+
+union cvmx_pip_dsa_src_grp {
+	uint64_t u64;
+	struct cvmx_pip_dsa_src_grp_s {
+		uint64_t map15:4;
+		uint64_t map14:4;
+		uint64_t map13:4;
+		uint64_t map12:4;
+		uint64_t map11:4;
+		uint64_t map10:4;
+		uint64_t map9:4;
+		uint64_t map8:4;
+		uint64_t map7:4;
+		uint64_t map6:4;
+		uint64_t map5:4;
+		uint64_t map4:4;
+		uint64_t map3:4;
+		uint64_t map2:4;
+		uint64_t map1:4;
+		uint64_t map0:4;
+	} s;
+	struct cvmx_pip_dsa_src_grp_s cn52xx;
+	struct cvmx_pip_dsa_src_grp_s cn52xxp1;
+	struct cvmx_pip_dsa_src_grp_s cn56xx;
+};
+
+union cvmx_pip_dsa_vid_grp {
+	uint64_t u64;
+	struct cvmx_pip_dsa_vid_grp_s {
+		uint64_t map15:4;
+		uint64_t map14:4;
+		uint64_t map13:4;
+		uint64_t map12:4;
+		uint64_t map11:4;
+		uint64_t map10:4;
+		uint64_t map9:4;
+		uint64_t map8:4;
+		uint64_t map7:4;
+		uint64_t map6:4;
+		uint64_t map5:4;
+		uint64_t map4:4;
+		uint64_t map3:4;
+		uint64_t map2:4;
+		uint64_t map1:4;
+		uint64_t map0:4;
+	} s;
+	struct cvmx_pip_dsa_vid_grp_s cn52xx;
+	struct cvmx_pip_dsa_vid_grp_s cn52xxp1;
+	struct cvmx_pip_dsa_vid_grp_s cn56xx;
+};
+
+union cvmx_pip_frm_len_chkx {
+	uint64_t u64;
+	struct cvmx_pip_frm_len_chkx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t maxlen:16;
+		uint64_t minlen:16;
+	} s;
+	struct cvmx_pip_frm_len_chkx_s cn50xx;
+	struct cvmx_pip_frm_len_chkx_s cn52xx;
+	struct cvmx_pip_frm_len_chkx_s cn52xxp1;
+	struct cvmx_pip_frm_len_chkx_s cn56xx;
+	struct cvmx_pip_frm_len_chkx_s cn56xxp1;
+};
+
+union cvmx_pip_gbl_cfg {
+	uint64_t u64;
+	struct cvmx_pip_gbl_cfg_s {
+		uint64_t reserved_19_63:45;
+		uint64_t tag_syn:1;
+		uint64_t ip6_udp:1;
+		uint64_t max_l2:1;
+		uint64_t reserved_11_15:5;
+		uint64_t raw_shf:3;
+		uint64_t reserved_3_7:5;
+		uint64_t nip_shf:3;
+	} s;
+	struct cvmx_pip_gbl_cfg_s cn30xx;
+	struct cvmx_pip_gbl_cfg_s cn31xx;
+	struct cvmx_pip_gbl_cfg_s cn38xx;
+	struct cvmx_pip_gbl_cfg_s cn38xxp2;
+	struct cvmx_pip_gbl_cfg_s cn50xx;
+	struct cvmx_pip_gbl_cfg_s cn52xx;
+	struct cvmx_pip_gbl_cfg_s cn52xxp1;
+	struct cvmx_pip_gbl_cfg_s cn56xx;
+	struct cvmx_pip_gbl_cfg_s cn56xxp1;
+	struct cvmx_pip_gbl_cfg_s cn58xx;
+	struct cvmx_pip_gbl_cfg_s cn58xxp1;
+};
+
+union cvmx_pip_gbl_ctl {
+	uint64_t u64;
+	struct cvmx_pip_gbl_ctl_s {
+		uint64_t reserved_27_63:37;
+		uint64_t dsa_grp_tvid:1;
+		uint64_t dsa_grp_scmd:1;
+		uint64_t dsa_grp_sid:1;
+		uint64_t reserved_21_23:3;
+		uint64_t ring_en:1;
+		uint64_t reserved_17_19:3;
+		uint64_t ignrs:1;
+		uint64_t vs_wqe:1;
+		uint64_t vs_qos:1;
+		uint64_t l2_mal:1;
+		uint64_t tcp_flag:1;
+		uint64_t l4_len:1;
+		uint64_t l4_chk:1;
+		uint64_t l4_prt:1;
+		uint64_t l4_mal:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ip6_eext:2;
+		uint64_t ip4_opts:1;
+		uint64_t ip_hop:1;
+		uint64_t ip_mal:1;
+		uint64_t ip_chk:1;
+	} s;
+	struct cvmx_pip_gbl_ctl_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t ignrs:1;
+		uint64_t vs_wqe:1;
+		uint64_t vs_qos:1;
+		uint64_t l2_mal:1;
+		uint64_t tcp_flag:1;
+		uint64_t l4_len:1;
+		uint64_t l4_chk:1;
+		uint64_t l4_prt:1;
+		uint64_t l4_mal:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ip6_eext:2;
+		uint64_t ip4_opts:1;
+		uint64_t ip_hop:1;
+		uint64_t ip_mal:1;
+		uint64_t ip_chk:1;
+	} cn30xx;
+	struct cvmx_pip_gbl_ctl_cn30xx cn31xx;
+	struct cvmx_pip_gbl_ctl_cn30xx cn38xx;
+	struct cvmx_pip_gbl_ctl_cn30xx cn38xxp2;
+	struct cvmx_pip_gbl_ctl_cn30xx cn50xx;
+	struct cvmx_pip_gbl_ctl_s cn52xx;
+	struct cvmx_pip_gbl_ctl_s cn52xxp1;
+	struct cvmx_pip_gbl_ctl_s cn56xx;
+	struct cvmx_pip_gbl_ctl_cn56xxp1 {
+		uint64_t reserved_21_63:43;
+		uint64_t ring_en:1;
+		uint64_t reserved_17_19:3;
+		uint64_t ignrs:1;
+		uint64_t vs_wqe:1;
+		uint64_t vs_qos:1;
+		uint64_t l2_mal:1;
+		uint64_t tcp_flag:1;
+		uint64_t l4_len:1;
+		uint64_t l4_chk:1;
+		uint64_t l4_prt:1;
+		uint64_t l4_mal:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ip6_eext:2;
+		uint64_t ip4_opts:1;
+		uint64_t ip_hop:1;
+		uint64_t ip_mal:1;
+		uint64_t ip_chk:1;
+	} cn56xxp1;
+	struct cvmx_pip_gbl_ctl_cn30xx cn58xx;
+	struct cvmx_pip_gbl_ctl_cn30xx cn58xxp1;
+};
+
+union cvmx_pip_hg_pri_qos {
+	uint64_t u64;
+	struct cvmx_pip_hg_pri_qos_s {
+		uint64_t reserved_11_63:53;
+		uint64_t qos:3;
+		uint64_t reserved_6_7:2;
+		uint64_t pri:6;
+	} s;
+	struct cvmx_pip_hg_pri_qos_s cn52xx;
+	struct cvmx_pip_hg_pri_qos_s cn52xxp1;
+	struct cvmx_pip_hg_pri_qos_s cn56xx;
+};
+
+union cvmx_pip_int_en {
+	uint64_t u64;
+	struct cvmx_pip_int_en_s {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} s;
+	struct cvmx_pip_int_en_cn30xx {
+		uint64_t reserved_9_63:55;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn30xx;
+	struct cvmx_pip_int_en_cn30xx cn31xx;
+	struct cvmx_pip_int_en_cn30xx cn38xx;
+	struct cvmx_pip_int_en_cn30xx cn38xxp2;
+	struct cvmx_pip_int_en_cn50xx {
+		uint64_t reserved_12_63:52;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pktdrp:1;
+	} cn50xx;
+	struct cvmx_pip_int_en_cn52xx {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pktdrp:1;
+	} cn52xx;
+	struct cvmx_pip_int_en_cn52xx cn52xxp1;
+	struct cvmx_pip_int_en_s cn56xx;
+	struct cvmx_pip_int_en_cn56xxp1 {
+		uint64_t reserved_12_63:52;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn56xxp1;
+	struct cvmx_pip_int_en_cn58xx {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t reserved_9_11:3;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn58xx;
+	struct cvmx_pip_int_en_cn30xx cn58xxp1;
+};
+
+union cvmx_pip_int_reg {
+	uint64_t u64;
+	struct cvmx_pip_int_reg_s {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} s;
+	struct cvmx_pip_int_reg_cn30xx {
+		uint64_t reserved_9_63:55;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn30xx;
+	struct cvmx_pip_int_reg_cn30xx cn31xx;
+	struct cvmx_pip_int_reg_cn30xx cn38xx;
+	struct cvmx_pip_int_reg_cn30xx cn38xxp2;
+	struct cvmx_pip_int_reg_cn50xx {
+		uint64_t reserved_12_63:52;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pktdrp:1;
+	} cn50xx;
+	struct cvmx_pip_int_reg_cn52xx {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pktdrp:1;
+	} cn52xx;
+	struct cvmx_pip_int_reg_cn52xx cn52xxp1;
+	struct cvmx_pip_int_reg_s cn56xx;
+	struct cvmx_pip_int_reg_cn56xxp1 {
+		uint64_t reserved_12_63:52;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn56xxp1;
+	struct cvmx_pip_int_reg_cn58xx {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t reserved_9_11:3;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn58xx;
+	struct cvmx_pip_int_reg_cn30xx cn58xxp1;
+};
+
+union cvmx_pip_ip_offset {
+	uint64_t u64;
+	struct cvmx_pip_ip_offset_s {
+		uint64_t reserved_3_63:61;
+		uint64_t offset:3;
+	} s;
+	struct cvmx_pip_ip_offset_s cn30xx;
+	struct cvmx_pip_ip_offset_s cn31xx;
+	struct cvmx_pip_ip_offset_s cn38xx;
+	struct cvmx_pip_ip_offset_s cn38xxp2;
+	struct cvmx_pip_ip_offset_s cn50xx;
+	struct cvmx_pip_ip_offset_s cn52xx;
+	struct cvmx_pip_ip_offset_s cn52xxp1;
+	struct cvmx_pip_ip_offset_s cn56xx;
+	struct cvmx_pip_ip_offset_s cn56xxp1;
+	struct cvmx_pip_ip_offset_s cn58xx;
+	struct cvmx_pip_ip_offset_s cn58xxp1;
+};
+
+union cvmx_pip_prt_cfgx {
+	uint64_t u64;
+	struct cvmx_pip_prt_cfgx_s {
+		uint64_t reserved_53_63:11;
+		uint64_t pad_len:1;
+		uint64_t vlan_len:1;
+		uint64_t lenerr_en:1;
+		uint64_t maxerr_en:1;
+		uint64_t minerr_en:1;
+		uint64_t grp_wat_47:4;
+		uint64_t qos_wat_47:4;
+		uint64_t reserved_37_39:3;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t hg_qos:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t qos_vsel:1;
+		uint64_t qos_vod:1;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_13_15:3;
+		uint64_t crc_en:1;
+		uint64_t higig_en:1;
+		uint64_t dsa_en:1;
+		uint64_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} s;
+	struct cvmx_pip_prt_cfgx_cn30xx {
+		uint64_t reserved_37_63:27;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t reserved_27_27:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t reserved_18_19:2;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_10_15:6;
+		uint64_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} cn30xx;
+	struct cvmx_pip_prt_cfgx_cn30xx cn31xx;
+	struct cvmx_pip_prt_cfgx_cn38xx {
+		uint64_t reserved_37_63:27;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t reserved_27_27:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t reserved_18_19:2;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_13_15:3;
+		uint64_t crc_en:1;
+		uint64_t reserved_10_11:2;
+		uint64_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} cn38xx;
+	struct cvmx_pip_prt_cfgx_cn38xx cn38xxp2;
+	struct cvmx_pip_prt_cfgx_cn50xx {
+		uint64_t reserved_53_63:11;
+		uint64_t pad_len:1;
+		uint64_t vlan_len:1;
+		uint64_t lenerr_en:1;
+		uint64_t maxerr_en:1;
+		uint64_t minerr_en:1;
+		uint64_t grp_wat_47:4;
+		uint64_t qos_wat_47:4;
+		uint64_t reserved_37_39:3;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t reserved_27_27:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t reserved_19_19:1;
+		uint64_t qos_vod:1;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_13_15:3;
+		uint64_t crc_en:1;
+		uint64_t reserved_10_11:2;
+		uint64_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} cn50xx;
+	struct cvmx_pip_prt_cfgx_s cn52xx;
+	struct cvmx_pip_prt_cfgx_s cn52xxp1;
+	struct cvmx_pip_prt_cfgx_s cn56xx;
+	struct cvmx_pip_prt_cfgx_cn50xx cn56xxp1;
+	struct cvmx_pip_prt_cfgx_cn58xx {
+		uint64_t reserved_37_63:27;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t reserved_27_27:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t reserved_19_19:1;
+		uint64_t qos_vod:1;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_13_15:3;
+		uint64_t crc_en:1;
+		uint64_t reserved_10_11:2;
+		uint64_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} cn58xx;
+	struct cvmx_pip_prt_cfgx_cn58xx cn58xxp1;
+};
+
+union cvmx_pip_prt_tagx {
+	uint64_t u64;
+	struct cvmx_pip_prt_tagx_s {
+		uint64_t reserved_40_63:24;
+		uint64_t grptagbase:4;
+		uint64_t grptagmask:4;
+		uint64_t grptag:1;
+		uint64_t grptag_mskip:1;
+		uint64_t tag_mode:2;
+		uint64_t inc_vs:2;
+		uint64_t inc_vlan:1;
+		uint64_t inc_prt_flag:1;
+		uint64_t ip6_dprt_flag:1;
+		uint64_t ip4_dprt_flag:1;
+		uint64_t ip6_sprt_flag:1;
+		uint64_t ip4_sprt_flag:1;
+		uint64_t ip6_nxth_flag:1;
+		uint64_t ip4_pctl_flag:1;
+		uint64_t ip6_dst_flag:1;
+		uint64_t ip4_dst_flag:1;
+		uint64_t ip6_src_flag:1;
+		uint64_t ip4_src_flag:1;
+		uint64_t tcp6_tag_type:2;
+		uint64_t tcp4_tag_type:2;
+		uint64_t ip6_tag_type:2;
+		uint64_t ip4_tag_type:2;
+		uint64_t non_tag_type:2;
+		uint64_t grp:4;
+	} s;
+	struct cvmx_pip_prt_tagx_cn30xx {
+		uint64_t reserved_40_63:24;
+		uint64_t grptagbase:4;
+		uint64_t grptagmask:4;
+		uint64_t grptag:1;
+		uint64_t reserved_30_30:1;
+		uint64_t tag_mode:2;
+		uint64_t inc_vs:2;
+		uint64_t inc_vlan:1;
+		uint64_t inc_prt_flag:1;
+		uint64_t ip6_dprt_flag:1;
+		uint64_t ip4_dprt_flag:1;
+		uint64_t ip6_sprt_flag:1;
+		uint64_t ip4_sprt_flag:1;
+		uint64_t ip6_nxth_flag:1;
+		uint64_t ip4_pctl_flag:1;
+		uint64_t ip6_dst_flag:1;
+		uint64_t ip4_dst_flag:1;
+		uint64_t ip6_src_flag:1;
+		uint64_t ip4_src_flag:1;
+		uint64_t tcp6_tag_type:2;
+		uint64_t tcp4_tag_type:2;
+		uint64_t ip6_tag_type:2;
+		uint64_t ip4_tag_type:2;
+		uint64_t non_tag_type:2;
+		uint64_t grp:4;
+	} cn30xx;
+	struct cvmx_pip_prt_tagx_cn30xx cn31xx;
+	struct cvmx_pip_prt_tagx_cn30xx cn38xx;
+	struct cvmx_pip_prt_tagx_cn30xx cn38xxp2;
+	struct cvmx_pip_prt_tagx_s cn50xx;
+	struct cvmx_pip_prt_tagx_s cn52xx;
+	struct cvmx_pip_prt_tagx_s cn52xxp1;
+	struct cvmx_pip_prt_tagx_s cn56xx;
+	struct cvmx_pip_prt_tagx_s cn56xxp1;
+	struct cvmx_pip_prt_tagx_cn30xx cn58xx;
+	struct cvmx_pip_prt_tagx_cn30xx cn58xxp1;
+};
+
+union cvmx_pip_qos_diffx {
+	uint64_t u64;
+	struct cvmx_pip_qos_diffx_s {
+		uint64_t reserved_3_63:61;
+		uint64_t qos:3;
+	} s;
+	struct cvmx_pip_qos_diffx_s cn30xx;
+	struct cvmx_pip_qos_diffx_s cn31xx;
+	struct cvmx_pip_qos_diffx_s cn38xx;
+	struct cvmx_pip_qos_diffx_s cn38xxp2;
+	struct cvmx_pip_qos_diffx_s cn50xx;
+	struct cvmx_pip_qos_diffx_s cn52xx;
+	struct cvmx_pip_qos_diffx_s cn52xxp1;
+	struct cvmx_pip_qos_diffx_s cn56xx;
+	struct cvmx_pip_qos_diffx_s cn56xxp1;
+	struct cvmx_pip_qos_diffx_s cn58xx;
+	struct cvmx_pip_qos_diffx_s cn58xxp1;
+};
+
+union cvmx_pip_qos_vlanx {
+	uint64_t u64;
+	struct cvmx_pip_qos_vlanx_s {
+		uint64_t reserved_7_63:57;
+		uint64_t qos1:3;
+		uint64_t reserved_3_3:1;
+		uint64_t qos:3;
+	} s;
+	struct cvmx_pip_qos_vlanx_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t qos:3;
+	} cn30xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn31xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn38xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn38xxp2;
+	struct cvmx_pip_qos_vlanx_cn30xx cn50xx;
+	struct cvmx_pip_qos_vlanx_s cn52xx;
+	struct cvmx_pip_qos_vlanx_s cn52xxp1;
+	struct cvmx_pip_qos_vlanx_s cn56xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn56xxp1;
+	struct cvmx_pip_qos_vlanx_cn30xx cn58xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn58xxp1;
+};
+
+union cvmx_pip_qos_watchx {
+	uint64_t u64;
+	struct cvmx_pip_qos_watchx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t mask:16;
+		uint64_t reserved_28_31:4;
+		uint64_t grp:4;
+		uint64_t reserved_23_23:1;
+		uint64_t qos:3;
+		uint64_t reserved_19_19:1;
+		uint64_t match_type:3;
+		uint64_t match_value:16;
+	} s;
+	struct cvmx_pip_qos_watchx_cn30xx {
+		uint64_t reserved_48_63:16;
+		uint64_t mask:16;
+		uint64_t reserved_28_31:4;
+		uint64_t grp:4;
+		uint64_t reserved_23_23:1;
+		uint64_t qos:3;
+		uint64_t reserved_18_19:2;
+		uint64_t match_type:2;
+		uint64_t match_value:16;
+	} cn30xx;
+	struct cvmx_pip_qos_watchx_cn30xx cn31xx;
+	struct cvmx_pip_qos_watchx_cn30xx cn38xx;
+	struct cvmx_pip_qos_watchx_cn30xx cn38xxp2;
+	struct cvmx_pip_qos_watchx_s cn50xx;
+	struct cvmx_pip_qos_watchx_s cn52xx;
+	struct cvmx_pip_qos_watchx_s cn52xxp1;
+	struct cvmx_pip_qos_watchx_s cn56xx;
+	struct cvmx_pip_qos_watchx_s cn56xxp1;
+	struct cvmx_pip_qos_watchx_cn30xx cn58xx;
+	struct cvmx_pip_qos_watchx_cn30xx cn58xxp1;
+};
+
+union cvmx_pip_raw_word {
+	uint64_t u64;
+	struct cvmx_pip_raw_word_s {
+		uint64_t reserved_56_63:8;
+		uint64_t word:56;
+	} s;
+	struct cvmx_pip_raw_word_s cn30xx;
+	struct cvmx_pip_raw_word_s cn31xx;
+	struct cvmx_pip_raw_word_s cn38xx;
+	struct cvmx_pip_raw_word_s cn38xxp2;
+	struct cvmx_pip_raw_word_s cn50xx;
+	struct cvmx_pip_raw_word_s cn52xx;
+	struct cvmx_pip_raw_word_s cn52xxp1;
+	struct cvmx_pip_raw_word_s cn56xx;
+	struct cvmx_pip_raw_word_s cn56xxp1;
+	struct cvmx_pip_raw_word_s cn58xx;
+	struct cvmx_pip_raw_word_s cn58xxp1;
+};
+
+union cvmx_pip_sft_rst {
+	uint64_t u64;
+	struct cvmx_pip_sft_rst_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rst:1;
+	} s;
+	struct cvmx_pip_sft_rst_s cn30xx;
+	struct cvmx_pip_sft_rst_s cn31xx;
+	struct cvmx_pip_sft_rst_s cn38xx;
+	struct cvmx_pip_sft_rst_s cn50xx;
+	struct cvmx_pip_sft_rst_s cn52xx;
+	struct cvmx_pip_sft_rst_s cn52xxp1;
+	struct cvmx_pip_sft_rst_s cn56xx;
+	struct cvmx_pip_sft_rst_s cn56xxp1;
+	struct cvmx_pip_sft_rst_s cn58xx;
+	struct cvmx_pip_sft_rst_s cn58xxp1;
+};
+
+union cvmx_pip_stat0_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat0_prtx_s {
+		uint64_t drp_pkts:32;
+		uint64_t drp_octs:32;
+	} s;
+	struct cvmx_pip_stat0_prtx_s cn30xx;
+	struct cvmx_pip_stat0_prtx_s cn31xx;
+	struct cvmx_pip_stat0_prtx_s cn38xx;
+	struct cvmx_pip_stat0_prtx_s cn38xxp2;
+	struct cvmx_pip_stat0_prtx_s cn50xx;
+	struct cvmx_pip_stat0_prtx_s cn52xx;
+	struct cvmx_pip_stat0_prtx_s cn52xxp1;
+	struct cvmx_pip_stat0_prtx_s cn56xx;
+	struct cvmx_pip_stat0_prtx_s cn56xxp1;
+	struct cvmx_pip_stat0_prtx_s cn58xx;
+	struct cvmx_pip_stat0_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat1_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat1_prtx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t octs:48;
+	} s;
+	struct cvmx_pip_stat1_prtx_s cn30xx;
+	struct cvmx_pip_stat1_prtx_s cn31xx;
+	struct cvmx_pip_stat1_prtx_s cn38xx;
+	struct cvmx_pip_stat1_prtx_s cn38xxp2;
+	struct cvmx_pip_stat1_prtx_s cn50xx;
+	struct cvmx_pip_stat1_prtx_s cn52xx;
+	struct cvmx_pip_stat1_prtx_s cn52xxp1;
+	struct cvmx_pip_stat1_prtx_s cn56xx;
+	struct cvmx_pip_stat1_prtx_s cn56xxp1;
+	struct cvmx_pip_stat1_prtx_s cn58xx;
+	struct cvmx_pip_stat1_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat2_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat2_prtx_s {
+		uint64_t pkts:32;
+		uint64_t raw:32;
+	} s;
+	struct cvmx_pip_stat2_prtx_s cn30xx;
+	struct cvmx_pip_stat2_prtx_s cn31xx;
+	struct cvmx_pip_stat2_prtx_s cn38xx;
+	struct cvmx_pip_stat2_prtx_s cn38xxp2;
+	struct cvmx_pip_stat2_prtx_s cn50xx;
+	struct cvmx_pip_stat2_prtx_s cn52xx;
+	struct cvmx_pip_stat2_prtx_s cn52xxp1;
+	struct cvmx_pip_stat2_prtx_s cn56xx;
+	struct cvmx_pip_stat2_prtx_s cn56xxp1;
+	struct cvmx_pip_stat2_prtx_s cn58xx;
+	struct cvmx_pip_stat2_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat3_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat3_prtx_s {
+		uint64_t bcst:32;
+		uint64_t mcst:32;
+	} s;
+	struct cvmx_pip_stat3_prtx_s cn30xx;
+	struct cvmx_pip_stat3_prtx_s cn31xx;
+	struct cvmx_pip_stat3_prtx_s cn38xx;
+	struct cvmx_pip_stat3_prtx_s cn38xxp2;
+	struct cvmx_pip_stat3_prtx_s cn50xx;
+	struct cvmx_pip_stat3_prtx_s cn52xx;
+	struct cvmx_pip_stat3_prtx_s cn52xxp1;
+	struct cvmx_pip_stat3_prtx_s cn56xx;
+	struct cvmx_pip_stat3_prtx_s cn56xxp1;
+	struct cvmx_pip_stat3_prtx_s cn58xx;
+	struct cvmx_pip_stat3_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat4_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat4_prtx_s {
+		uint64_t h65to127:32;
+		uint64_t h64:32;
+	} s;
+	struct cvmx_pip_stat4_prtx_s cn30xx;
+	struct cvmx_pip_stat4_prtx_s cn31xx;
+	struct cvmx_pip_stat4_prtx_s cn38xx;
+	struct cvmx_pip_stat4_prtx_s cn38xxp2;
+	struct cvmx_pip_stat4_prtx_s cn50xx;
+	struct cvmx_pip_stat4_prtx_s cn52xx;
+	struct cvmx_pip_stat4_prtx_s cn52xxp1;
+	struct cvmx_pip_stat4_prtx_s cn56xx;
+	struct cvmx_pip_stat4_prtx_s cn56xxp1;
+	struct cvmx_pip_stat4_prtx_s cn58xx;
+	struct cvmx_pip_stat4_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat5_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat5_prtx_s {
+		uint64_t h256to511:32;
+		uint64_t h128to255:32;
+	} s;
+	struct cvmx_pip_stat5_prtx_s cn30xx;
+	struct cvmx_pip_stat5_prtx_s cn31xx;
+	struct cvmx_pip_stat5_prtx_s cn38xx;
+	struct cvmx_pip_stat5_prtx_s cn38xxp2;
+	struct cvmx_pip_stat5_prtx_s cn50xx;
+	struct cvmx_pip_stat5_prtx_s cn52xx;
+	struct cvmx_pip_stat5_prtx_s cn52xxp1;
+	struct cvmx_pip_stat5_prtx_s cn56xx;
+	struct cvmx_pip_stat5_prtx_s cn56xxp1;
+	struct cvmx_pip_stat5_prtx_s cn58xx;
+	struct cvmx_pip_stat5_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat6_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat6_prtx_s {
+		uint64_t h1024to1518:32;
+		uint64_t h512to1023:32;
+	} s;
+	struct cvmx_pip_stat6_prtx_s cn30xx;
+	struct cvmx_pip_stat6_prtx_s cn31xx;
+	struct cvmx_pip_stat6_prtx_s cn38xx;
+	struct cvmx_pip_stat6_prtx_s cn38xxp2;
+	struct cvmx_pip_stat6_prtx_s cn50xx;
+	struct cvmx_pip_stat6_prtx_s cn52xx;
+	struct cvmx_pip_stat6_prtx_s cn52xxp1;
+	struct cvmx_pip_stat6_prtx_s cn56xx;
+	struct cvmx_pip_stat6_prtx_s cn56xxp1;
+	struct cvmx_pip_stat6_prtx_s cn58xx;
+	struct cvmx_pip_stat6_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat7_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat7_prtx_s {
+		uint64_t fcs:32;
+		uint64_t h1519:32;
+	} s;
+	struct cvmx_pip_stat7_prtx_s cn30xx;
+	struct cvmx_pip_stat7_prtx_s cn31xx;
+	struct cvmx_pip_stat7_prtx_s cn38xx;
+	struct cvmx_pip_stat7_prtx_s cn38xxp2;
+	struct cvmx_pip_stat7_prtx_s cn50xx;
+	struct cvmx_pip_stat7_prtx_s cn52xx;
+	struct cvmx_pip_stat7_prtx_s cn52xxp1;
+	struct cvmx_pip_stat7_prtx_s cn56xx;
+	struct cvmx_pip_stat7_prtx_s cn56xxp1;
+	struct cvmx_pip_stat7_prtx_s cn58xx;
+	struct cvmx_pip_stat7_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat8_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat8_prtx_s {
+		uint64_t frag:32;
+		uint64_t undersz:32;
+	} s;
+	struct cvmx_pip_stat8_prtx_s cn30xx;
+	struct cvmx_pip_stat8_prtx_s cn31xx;
+	struct cvmx_pip_stat8_prtx_s cn38xx;
+	struct cvmx_pip_stat8_prtx_s cn38xxp2;
+	struct cvmx_pip_stat8_prtx_s cn50xx;
+	struct cvmx_pip_stat8_prtx_s cn52xx;
+	struct cvmx_pip_stat8_prtx_s cn52xxp1;
+	struct cvmx_pip_stat8_prtx_s cn56xx;
+	struct cvmx_pip_stat8_prtx_s cn56xxp1;
+	struct cvmx_pip_stat8_prtx_s cn58xx;
+	struct cvmx_pip_stat8_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat9_prtx {
+	uint64_t u64;
+	struct cvmx_pip_stat9_prtx_s {
+		uint64_t jabber:32;
+		uint64_t oversz:32;
+	} s;
+	struct cvmx_pip_stat9_prtx_s cn30xx;
+	struct cvmx_pip_stat9_prtx_s cn31xx;
+	struct cvmx_pip_stat9_prtx_s cn38xx;
+	struct cvmx_pip_stat9_prtx_s cn38xxp2;
+	struct cvmx_pip_stat9_prtx_s cn50xx;
+	struct cvmx_pip_stat9_prtx_s cn52xx;
+	struct cvmx_pip_stat9_prtx_s cn52xxp1;
+	struct cvmx_pip_stat9_prtx_s cn56xx;
+	struct cvmx_pip_stat9_prtx_s cn56xxp1;
+	struct cvmx_pip_stat9_prtx_s cn58xx;
+	struct cvmx_pip_stat9_prtx_s cn58xxp1;
+};
+
+union cvmx_pip_stat_ctl {
+	uint64_t u64;
+	struct cvmx_pip_stat_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rdclr:1;
+	} s;
+	struct cvmx_pip_stat_ctl_s cn30xx;
+	struct cvmx_pip_stat_ctl_s cn31xx;
+	struct cvmx_pip_stat_ctl_s cn38xx;
+	struct cvmx_pip_stat_ctl_s cn38xxp2;
+	struct cvmx_pip_stat_ctl_s cn50xx;
+	struct cvmx_pip_stat_ctl_s cn52xx;
+	struct cvmx_pip_stat_ctl_s cn52xxp1;
+	struct cvmx_pip_stat_ctl_s cn56xx;
+	struct cvmx_pip_stat_ctl_s cn56xxp1;
+	struct cvmx_pip_stat_ctl_s cn58xx;
+	struct cvmx_pip_stat_ctl_s cn58xxp1;
+};
+
+union cvmx_pip_stat_inb_errsx {
+	uint64_t u64;
+	struct cvmx_pip_stat_inb_errsx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t errs:16;
+	} s;
+	struct cvmx_pip_stat_inb_errsx_s cn30xx;
+	struct cvmx_pip_stat_inb_errsx_s cn31xx;
+	struct cvmx_pip_stat_inb_errsx_s cn38xx;
+	struct cvmx_pip_stat_inb_errsx_s cn38xxp2;
+	struct cvmx_pip_stat_inb_errsx_s cn50xx;
+	struct cvmx_pip_stat_inb_errsx_s cn52xx;
+	struct cvmx_pip_stat_inb_errsx_s cn52xxp1;
+	struct cvmx_pip_stat_inb_errsx_s cn56xx;
+	struct cvmx_pip_stat_inb_errsx_s cn56xxp1;
+	struct cvmx_pip_stat_inb_errsx_s cn58xx;
+	struct cvmx_pip_stat_inb_errsx_s cn58xxp1;
+};
+
+union cvmx_pip_stat_inb_octsx {
+	uint64_t u64;
+	struct cvmx_pip_stat_inb_octsx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t octs:48;
+	} s;
+	struct cvmx_pip_stat_inb_octsx_s cn30xx;
+	struct cvmx_pip_stat_inb_octsx_s cn31xx;
+	struct cvmx_pip_stat_inb_octsx_s cn38xx;
+	struct cvmx_pip_stat_inb_octsx_s cn38xxp2;
+	struct cvmx_pip_stat_inb_octsx_s cn50xx;
+	struct cvmx_pip_stat_inb_octsx_s cn52xx;
+	struct cvmx_pip_stat_inb_octsx_s cn52xxp1;
+	struct cvmx_pip_stat_inb_octsx_s cn56xx;
+	struct cvmx_pip_stat_inb_octsx_s cn56xxp1;
+	struct cvmx_pip_stat_inb_octsx_s cn58xx;
+	struct cvmx_pip_stat_inb_octsx_s cn58xxp1;
+};
+
+union cvmx_pip_stat_inb_pktsx {
+	uint64_t u64;
+	struct cvmx_pip_stat_inb_pktsx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pkts:32;
+	} s;
+	struct cvmx_pip_stat_inb_pktsx_s cn30xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn31xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn38xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn38xxp2;
+	struct cvmx_pip_stat_inb_pktsx_s cn50xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn52xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn52xxp1;
+	struct cvmx_pip_stat_inb_pktsx_s cn56xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn56xxp1;
+	struct cvmx_pip_stat_inb_pktsx_s cn58xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn58xxp1;
+};
+
+union cvmx_pip_tag_incx {
+	uint64_t u64;
+	struct cvmx_pip_tag_incx_s {
+		uint64_t reserved_8_63:56;
+		uint64_t en:8;
+	} s;
+	struct cvmx_pip_tag_incx_s cn30xx;
+	struct cvmx_pip_tag_incx_s cn31xx;
+	struct cvmx_pip_tag_incx_s cn38xx;
+	struct cvmx_pip_tag_incx_s cn38xxp2;
+	struct cvmx_pip_tag_incx_s cn50xx;
+	struct cvmx_pip_tag_incx_s cn52xx;
+	struct cvmx_pip_tag_incx_s cn52xxp1;
+	struct cvmx_pip_tag_incx_s cn56xx;
+	struct cvmx_pip_tag_incx_s cn56xxp1;
+	struct cvmx_pip_tag_incx_s cn58xx;
+	struct cvmx_pip_tag_incx_s cn58xxp1;
+};
+
+union cvmx_pip_tag_mask {
+	uint64_t u64;
+	struct cvmx_pip_tag_mask_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mask:16;
+	} s;
+	struct cvmx_pip_tag_mask_s cn30xx;
+	struct cvmx_pip_tag_mask_s cn31xx;
+	struct cvmx_pip_tag_mask_s cn38xx;
+	struct cvmx_pip_tag_mask_s cn38xxp2;
+	struct cvmx_pip_tag_mask_s cn50xx;
+	struct cvmx_pip_tag_mask_s cn52xx;
+	struct cvmx_pip_tag_mask_s cn52xxp1;
+	struct cvmx_pip_tag_mask_s cn56xx;
+	struct cvmx_pip_tag_mask_s cn56xxp1;
+	struct cvmx_pip_tag_mask_s cn58xx;
+	struct cvmx_pip_tag_mask_s cn58xxp1;
+};
+
+union cvmx_pip_tag_secret {
+	uint64_t u64;
+	struct cvmx_pip_tag_secret_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dst:16;
+		uint64_t src:16;
+	} s;
+	struct cvmx_pip_tag_secret_s cn30xx;
+	struct cvmx_pip_tag_secret_s cn31xx;
+	struct cvmx_pip_tag_secret_s cn38xx;
+	struct cvmx_pip_tag_secret_s cn38xxp2;
+	struct cvmx_pip_tag_secret_s cn50xx;
+	struct cvmx_pip_tag_secret_s cn52xx;
+	struct cvmx_pip_tag_secret_s cn52xxp1;
+	struct cvmx_pip_tag_secret_s cn56xx;
+	struct cvmx_pip_tag_secret_s cn56xxp1;
+	struct cvmx_pip_tag_secret_s cn58xx;
+	struct cvmx_pip_tag_secret_s cn58xxp1;
+};
+
+union cvmx_pip_todo_entry {
+	uint64_t u64;
+	struct cvmx_pip_todo_entry_s {
+		uint64_t val:1;
+		uint64_t reserved_62_62:1;
+		uint64_t entry:62;
+	} s;
+	struct cvmx_pip_todo_entry_s cn30xx;
+	struct cvmx_pip_todo_entry_s cn31xx;
+	struct cvmx_pip_todo_entry_s cn38xx;
+	struct cvmx_pip_todo_entry_s cn38xxp2;
+	struct cvmx_pip_todo_entry_s cn50xx;
+	struct cvmx_pip_todo_entry_s cn52xx;
+	struct cvmx_pip_todo_entry_s cn52xxp1;
+	struct cvmx_pip_todo_entry_s cn56xx;
+	struct cvmx_pip_todo_entry_s cn56xxp1;
+	struct cvmx_pip_todo_entry_s cn58xx;
+	struct cvmx_pip_todo_entry_s cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-pip.h b/drivers/staging/octeon/cvmx-pip.h
new file mode 100644
index 0000000..78dbce8
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-pip.h
@@ -0,0 +1,524 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Interface to the hardware Packet Input Processing unit.
+ *
+ */
+
+#ifndef __CVMX_PIP_H__
+#define __CVMX_PIP_H__
+
+#include "cvmx-wqe.h"
+#include "cvmx-fpa.h"
+#include "cvmx-pip-defs.h"
+
+#define CVMX_PIP_NUM_INPUT_PORTS                40
+#define CVMX_PIP_NUM_WATCHERS                   4
+
+/*
+ * Encodes the different error and exception codes
+ */
+typedef enum {
+	CVMX_PIP_L4_NO_ERR = 0ull,
+	/*
+	 * 1 = TCP (UDP) packet not long enough to cover TCP (UDP)
+	 * header
+	 */
+	CVMX_PIP_L4_MAL_ERR = 1ull,
+	/* 2  = TCP/UDP checksum failure */
+	CVMX_PIP_CHK_ERR = 2ull,
+	/*
+	 * 3 = TCP/UDP length check (TCP/UDP length does not match IP
+	 * length).
+	 */
+	CVMX_PIP_L4_LENGTH_ERR = 3ull,
+	/* 4  = illegal TCP/UDP port (either source or dest port is zero) */
+	CVMX_PIP_BAD_PRT_ERR = 4ull,
+	/* 8  = TCP flags = FIN only */
+	CVMX_PIP_TCP_FLG8_ERR = 8ull,
+	/* 9  = TCP flags = 0 */
+	CVMX_PIP_TCP_FLG9_ERR = 9ull,
+	/* 10 = TCP flags = FIN+RST+* */
+	CVMX_PIP_TCP_FLG10_ERR = 10ull,
+	/* 11 = TCP flags = SYN+URG+* */
+	CVMX_PIP_TCP_FLG11_ERR = 11ull,
+	/* 12 = TCP flags = SYN+RST+* */
+	CVMX_PIP_TCP_FLG12_ERR = 12ull,
+	/* 13 = TCP flags = SYN+FIN+* */
+	CVMX_PIP_TCP_FLG13_ERR = 13ull
+} cvmx_pip_l4_err_t;
+
+typedef enum {
+
+	CVMX_PIP_IP_NO_ERR = 0ull,
+	/* 1 = not IPv4 or IPv6 */
+	CVMX_PIP_NOT_IP = 1ull,
+	/* 2 = IPv4 header checksum violation */
+	CVMX_PIP_IPV4_HDR_CHK = 2ull,
+	/* 3 = malformed (packet not long enough to cover IP hdr) */
+	CVMX_PIP_IP_MAL_HDR = 3ull,
+	/* 4 = malformed (packet not long enough to cover len in IP hdr) */
+	CVMX_PIP_IP_MAL_PKT = 4ull,
+	/* 5 = TTL / hop count equal zero */
+	CVMX_PIP_TTL_HOP = 5ull,
+	/* 6 = IPv4 options / IPv6 early extension headers */
+	CVMX_PIP_OPTS = 6ull
+} cvmx_pip_ip_exc_t;
+
+/**
+ * NOTES
+ *       late collision (data received before collision)
+ *            late collisions cannot be detected by the receiver
+ *            they would appear as JAM bits which would appear as bad FCS
+ *            or carrier extend error which is CVMX_PIP_EXTEND_ERR
+ */
+typedef enum {
+	/* No error */
+	CVMX_PIP_RX_NO_ERR = 0ull,
+	/* RGM+SPI 1 = partially received packet (buffering/bandwidth
+	 * not adequate) */
+	CVMX_PIP_PARTIAL_ERR = 1ull,
+	/* RGM+SPI 2 = receive packet too large and truncated */
+	CVMX_PIP_JABBER_ERR = 2ull,
+	/*
+	 * RGM 3 = max frame error (pkt len > max frame len) (with FCS
+	 * error)
+	 */
+	CVMX_PIP_OVER_FCS_ERR = 3ull,
+	/* RGM+SPI 4 = max frame error (pkt len > max frame len) */
+	CVMX_PIP_OVER_ERR = 4ull,
+	/*
+	 * RGM 5 = nibble error (data not byte multiple - 100M and 10M
+	 * only)
+	 */
+	CVMX_PIP_ALIGN_ERR = 5ull,
+	/*
+	 * RGM 6 = min frame error (pkt len < min frame len) (with FCS
+	 * error)
+	 */
+	CVMX_PIP_UNDER_FCS_ERR = 6ull,
+	/* RGM     7 = FCS error */
+	CVMX_PIP_GMX_FCS_ERR = 7ull,
+	/* RGM+SPI 8 = min frame error (pkt len < min frame len) */
+	CVMX_PIP_UNDER_ERR = 8ull,
+	/* RGM     9 = Frame carrier extend error */
+	CVMX_PIP_EXTEND_ERR = 9ull,
+	/*
+	 * RGM 10 = length mismatch (len did not match len in L2
+	 * length/type)
+	 */
+	CVMX_PIP_LENGTH_ERR = 10ull,
+	/* RGM 11 = Frame error (some or all data bits marked err) */
+	CVMX_PIP_DAT_ERR = 11ull,
+	/*     SPI 11 = DIP4 error */
+	CVMX_PIP_DIP_ERR = 11ull,
+	/*
+	 * RGM 12 = packet was not large enough to pass the skipper -
+	 * no inspection could occur.
+	 */
+	CVMX_PIP_SKIP_ERR = 12ull,
+	/*
+	 * RGM 13 = studder error (data not repeated - 100M and 10M
+	 * only)
+	 */
+	CVMX_PIP_NIBBLE_ERR = 13ull,
+	/* RGM+SPI 16 = FCS error */
+	CVMX_PIP_PIP_FCS = 16L,
+	/*
+	 * RGM+SPI+PCI 17 = packet was not large enough to pass the
+	 * skipper - no inspection could occur.
+	 */
+	CVMX_PIP_PIP_SKIP_ERR = 17L,
+	/*
+	 * RGM+SPI+PCI 18 = malformed l2 (packet not long enough to
+	 * cover L2 hdr).
+	 */
+	CVMX_PIP_PIP_L2_MAL_HDR = 18L
+	/*
+	 * NOTES: xx = late collision (data received before collision)
+	 *       late collisions cannot be detected by the receiver
+	 *       they would appear as JAM bits which would appear as
+	 *       bad FCS or carrier extend error which is
+	 *       CVMX_PIP_EXTEND_ERR
+	 */
+} cvmx_pip_rcv_err_t;
+
+/**
+ * This defines the err_code field errors in the work Q entry
+ */
+typedef union {
+	cvmx_pip_l4_err_t l4_err;
+	cvmx_pip_ip_exc_t ip_exc;
+	cvmx_pip_rcv_err_t rcv_err;
+} cvmx_pip_err_t;
+
+/**
+ * Status statistics for a port
+ */
+typedef struct {
+	/* Inbound octets marked to be dropped by the IPD */
+	uint32_t dropped_octets;
+	/* Inbound packets marked to be dropped by the IPD */
+	uint32_t dropped_packets;
+	/* RAW PCI Packets received by PIP per port */
+	uint32_t pci_raw_packets;
+	/* Number of octets processed by PIP */
+	uint32_t octets;
+	/* Number of packets processed by PIP */
+	uint32_t packets;
+	/*
+	 * Number of indentified L2 multicast packets.  Does not
+	 * include broadcast packets.  Only includes packets whose
+	 * parse mode is SKIP_TO_L2
+	 */
+	uint32_t multicast_packets;
+	/*
+	 * Number of indentified L2 broadcast packets.  Does not
+	 * include multicast packets.  Only includes packets whose
+	 * parse mode is SKIP_TO_L2
+	 */
+	uint32_t broadcast_packets;
+	/* Number of 64B packets */
+	uint32_t len_64_packets;
+	/* Number of 65-127B packets */
+	uint32_t len_65_127_packets;
+	/* Number of 128-255B packets */
+	uint32_t len_128_255_packets;
+	/* Number of 256-511B packets */
+	uint32_t len_256_511_packets;
+	/* Number of 512-1023B packets */
+	uint32_t len_512_1023_packets;
+	/* Number of 1024-1518B packets */
+	uint32_t len_1024_1518_packets;
+	/* Number of 1519-max packets */
+	uint32_t len_1519_max_packets;
+	/* Number of packets with FCS or Align opcode errors */
+	uint32_t fcs_align_err_packets;
+	/* Number of packets with length < min */
+	uint32_t runt_packets;
+	/* Number of packets with length < min and FCS error */
+	uint32_t runt_crc_packets;
+	/* Number of packets with length > max */
+	uint32_t oversize_packets;
+	/* Number of packets with length > max and FCS error */
+	uint32_t oversize_crc_packets;
+	/* Number of packets without GMX/SPX/PCI errors received by PIP */
+	uint32_t inb_packets;
+	/*
+	 * Total number of octets from all packets received by PIP,
+	 * including CRC
+	 */
+	uint64_t inb_octets;
+	/* Number of packets with GMX/SPX/PCI errors received by PIP */
+	uint16_t inb_errors;
+} cvmx_pip_port_status_t;
+
+/**
+ * Definition of the PIP custom header that can be prepended
+ * to a packet by external hardware.
+ */
+typedef union {
+	uint64_t u64;
+	struct {
+		/*
+		 * Documented as R - Set if the Packet is RAWFULL. If
+		 * set, this header must be the full 8 bytes.
+		 */
+		uint64_t rawfull:1;
+		/* Must be zero */
+		uint64_t reserved0:5;
+		/* PIP parse mode for this packet */
+		uint64_t parse_mode:2;
+		/* Must be zero */
+		uint64_t reserved1:1;
+		/*
+		 * Skip amount, including this header, to the
+		 * beginning of the packet
+		 */
+		uint64_t skip_len:7;
+		/* Must be zero */
+		uint64_t reserved2:6;
+		/* POW input queue for this packet */
+		uint64_t qos:3;
+		/* POW input group for this packet */
+		uint64_t grp:4;
+		/*
+		 * Flag to store this packet in the work queue entry,
+		 * if possible
+		 */
+		uint64_t rs:1;
+		/* POW input tag type */
+		uint64_t tag_type:2;
+		/* POW input tag */
+		uint64_t tag:32;
+	} s;
+} cvmx_pip_pkt_inst_hdr_t;
+
+/* CSR typedefs have been moved to cvmx-csr-*.h */
+
+/**
+ * Configure an ethernet input port
+ *
+ * @port_num: Port number to configure
+ * @port_cfg: Port hardware configuration
+ * @port_tag_cfg:
+ *                 Port POW tagging configuration
+ */
+static inline void cvmx_pip_config_port(uint64_t port_num,
+					union cvmx_pip_prt_cfgx port_cfg,
+					union cvmx_pip_prt_tagx port_tag_cfg)
+{
+	cvmx_write_csr(CVMX_PIP_PRT_CFGX(port_num), port_cfg.u64);
+	cvmx_write_csr(CVMX_PIP_PRT_TAGX(port_num), port_tag_cfg.u64);
+}
+#if 0
+/**
+ * @deprecated      This function is a thin wrapper around the Pass1 version
+ *                  of the CVMX_PIP_QOS_WATCHX CSR; Pass2 has added a field for
+ *                  setting the group that is incompatible with this function,
+ *                  the preferred upgrade path is to use the CSR directly.
+ *
+ * Configure the global QoS packet watchers. Each watcher is
+ * capable of matching a field in a packet to determine the
+ * QoS queue for scheduling.
+ *
+ * @watcher:    Watcher number to configure (0 - 3).
+ * @match_type: Watcher match type
+ * @match_value:
+ *                   Value the watcher will match against
+ * @qos:        QoS queue for packets matching this watcher
+ */
+static inline void cvmx_pip_config_watcher(uint64_t watcher,
+					   cvmx_pip_qos_watch_types match_type,
+					   uint64_t match_value, uint64_t qos)
+{
+	cvmx_pip_port_watcher_cfg_t watcher_config;
+
+	watcher_config.u64 = 0;
+	watcher_config.s.match_type = match_type;
+	watcher_config.s.match_value = match_value;
+	watcher_config.s.qos = qos;
+
+	cvmx_write_csr(CVMX_PIP_QOS_WATCHX(watcher), watcher_config.u64);
+}
+#endif
+/**
+ * Configure the VLAN priority to QoS queue mapping.
+ *
+ * @vlan_priority:
+ *               VLAN priority (0-7)
+ * @qos:    QoS queue for packets matching this watcher
+ */
+static inline void cvmx_pip_config_vlan_qos(uint64_t vlan_priority,
+					    uint64_t qos)
+{
+	union cvmx_pip_qos_vlanx pip_qos_vlanx;
+	pip_qos_vlanx.u64 = 0;
+	pip_qos_vlanx.s.qos = qos;
+	cvmx_write_csr(CVMX_PIP_QOS_VLANX(vlan_priority), pip_qos_vlanx.u64);
+}
+
+/**
+ * Configure the Diffserv to QoS queue mapping.
+ *
+ * @diffserv: Diffserv field value (0-63)
+ * @qos:      QoS queue for packets matching this watcher
+ */
+static inline void cvmx_pip_config_diffserv_qos(uint64_t diffserv, uint64_t qos)
+{
+	union cvmx_pip_qos_diffx pip_qos_diffx;
+	pip_qos_diffx.u64 = 0;
+	pip_qos_diffx.s.qos = qos;
+	cvmx_write_csr(CVMX_PIP_QOS_DIFFX(diffserv), pip_qos_diffx.u64);
+}
+
+/**
+ * Get the status counters for a port.
+ *
+ * @port_num: Port number to get statistics for.
+ * @clear:    Set to 1 to clear the counters after they are read
+ * @status:   Where to put the results.
+ */
+static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
+					    cvmx_pip_port_status_t *status)
+{
+	union cvmx_pip_stat_ctl pip_stat_ctl;
+	union cvmx_pip_stat0_prtx stat0;
+	union cvmx_pip_stat1_prtx stat1;
+	union cvmx_pip_stat2_prtx stat2;
+	union cvmx_pip_stat3_prtx stat3;
+	union cvmx_pip_stat4_prtx stat4;
+	union cvmx_pip_stat5_prtx stat5;
+	union cvmx_pip_stat6_prtx stat6;
+	union cvmx_pip_stat7_prtx stat7;
+	union cvmx_pip_stat8_prtx stat8;
+	union cvmx_pip_stat9_prtx stat9;
+	union cvmx_pip_stat_inb_pktsx pip_stat_inb_pktsx;
+	union cvmx_pip_stat_inb_octsx pip_stat_inb_octsx;
+	union cvmx_pip_stat_inb_errsx pip_stat_inb_errsx;
+
+	pip_stat_ctl.u64 = 0;
+	pip_stat_ctl.s.rdclr = clear;
+	cvmx_write_csr(CVMX_PIP_STAT_CTL, pip_stat_ctl.u64);
+
+	stat0.u64 = cvmx_read_csr(CVMX_PIP_STAT0_PRTX(port_num));
+	stat1.u64 = cvmx_read_csr(CVMX_PIP_STAT1_PRTX(port_num));
+	stat2.u64 = cvmx_read_csr(CVMX_PIP_STAT2_PRTX(port_num));
+	stat3.u64 = cvmx_read_csr(CVMX_PIP_STAT3_PRTX(port_num));
+	stat4.u64 = cvmx_read_csr(CVMX_PIP_STAT4_PRTX(port_num));
+	stat5.u64 = cvmx_read_csr(CVMX_PIP_STAT5_PRTX(port_num));
+	stat6.u64 = cvmx_read_csr(CVMX_PIP_STAT6_PRTX(port_num));
+	stat7.u64 = cvmx_read_csr(CVMX_PIP_STAT7_PRTX(port_num));
+	stat8.u64 = cvmx_read_csr(CVMX_PIP_STAT8_PRTX(port_num));
+	stat9.u64 = cvmx_read_csr(CVMX_PIP_STAT9_PRTX(port_num));
+	pip_stat_inb_pktsx.u64 =
+	    cvmx_read_csr(CVMX_PIP_STAT_INB_PKTSX(port_num));
+	pip_stat_inb_octsx.u64 =
+	    cvmx_read_csr(CVMX_PIP_STAT_INB_OCTSX(port_num));
+	pip_stat_inb_errsx.u64 =
+	    cvmx_read_csr(CVMX_PIP_STAT_INB_ERRSX(port_num));
+
+	status->dropped_octets = stat0.s.drp_octs;
+	status->dropped_packets = stat0.s.drp_pkts;
+	status->octets = stat1.s.octs;
+	status->pci_raw_packets = stat2.s.raw;
+	status->packets = stat2.s.pkts;
+	status->multicast_packets = stat3.s.mcst;
+	status->broadcast_packets = stat3.s.bcst;
+	status->len_64_packets = stat4.s.h64;
+	status->len_65_127_packets = stat4.s.h65to127;
+	status->len_128_255_packets = stat5.s.h128to255;
+	status->len_256_511_packets = stat5.s.h256to511;
+	status->len_512_1023_packets = stat6.s.h512to1023;
+	status->len_1024_1518_packets = stat6.s.h1024to1518;
+	status->len_1519_max_packets = stat7.s.h1519;
+	status->fcs_align_err_packets = stat7.s.fcs;
+	status->runt_packets = stat8.s.undersz;
+	status->runt_crc_packets = stat8.s.frag;
+	status->oversize_packets = stat9.s.oversz;
+	status->oversize_crc_packets = stat9.s.jabber;
+	status->inb_packets = pip_stat_inb_pktsx.s.pkts;
+	status->inb_octets = pip_stat_inb_octsx.s.octs;
+	status->inb_errors = pip_stat_inb_errsx.s.errs;
+
+	if (cvmx_octeon_is_pass1()) {
+		/*
+		 * Kludge to fix Octeon Pass 1 errata - Drop counts
+		 * don't work.
+		 */
+		if (status->inb_packets > status->packets)
+			status->dropped_packets =
+			    status->inb_packets - status->packets;
+		else
+			status->dropped_packets = 0;
+		if (status->inb_octets - status->inb_packets * 4 >
+		    status->octets)
+			status->dropped_octets =
+			    status->inb_octets - status->inb_packets * 4 -
+			    status->octets;
+		else
+			status->dropped_octets = 0;
+	}
+}
+
+/**
+ * Configure the hardware CRC engine
+ *
+ * @interface: Interface to configure (0 or 1)
+ * @invert_result:
+ *                 Invert the result of the CRC
+ * @reflect:  Reflect
+ * @initialization_vector:
+ *                 CRC initialization vector
+ */
+static inline void cvmx_pip_config_crc(uint64_t interface,
+				       uint64_t invert_result, uint64_t reflect,
+				       uint32_t initialization_vector)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+		union cvmx_pip_crc_ctlx config;
+		union cvmx_pip_crc_ivx pip_crc_ivx;
+
+		config.u64 = 0;
+		config.s.invres = invert_result;
+		config.s.reflect = reflect;
+		cvmx_write_csr(CVMX_PIP_CRC_CTLX(interface), config.u64);
+
+		pip_crc_ivx.u64 = 0;
+		pip_crc_ivx.s.iv = initialization_vector;
+		cvmx_write_csr(CVMX_PIP_CRC_IVX(interface), pip_crc_ivx.u64);
+	}
+}
+
+/**
+ * Clear all bits in a tag mask. This should be called on
+ * startup before any calls to cvmx_pip_tag_mask_set. Each bit
+ * set in the final mask represent a byte used in the packet for
+ * tag generation.
+ *
+ * @mask_index: Which tag mask to clear (0..3)
+ */
+static inline void cvmx_pip_tag_mask_clear(uint64_t mask_index)
+{
+	uint64_t index;
+	union cvmx_pip_tag_incx pip_tag_incx;
+	pip_tag_incx.u64 = 0;
+	pip_tag_incx.s.en = 0;
+	for (index = mask_index * 16; index < (mask_index + 1) * 16; index++)
+		cvmx_write_csr(CVMX_PIP_TAG_INCX(index), pip_tag_incx.u64);
+}
+
+/**
+ * Sets a range of bits in the tag mask. The tag mask is used
+ * when the cvmx_pip_port_tag_cfg_t tag_mode is non zero.
+ * There are four separate masks that can be configured.
+ *
+ * @mask_index: Which tag mask to modify (0..3)
+ * @offset: Offset into the bitmask to set bits at. Use the GCC macro
+ *          offsetof() to determine the offsets into packet headers.
+ *          For example, offsetof(ethhdr, protocol) returns the offset
+ *          of the ethernet protocol field.  The bitmask selects which
+ *          bytes to include the the tag, with bit offset X selecting
+ *          byte at offset X from the beginning of the packet data.
+ * @len:    Number of bytes to include. Usually this is the sizeof()
+ *          the field.
+ */
+static inline void cvmx_pip_tag_mask_set(uint64_t mask_index, uint64_t offset,
+					 uint64_t len)
+{
+	while (len--) {
+		union cvmx_pip_tag_incx pip_tag_incx;
+		uint64_t index = mask_index * 16 + offset / 8;
+		pip_tag_incx.u64 = cvmx_read_csr(CVMX_PIP_TAG_INCX(index));
+		pip_tag_incx.s.en |= 0x80 >> (offset & 0x7);
+		cvmx_write_csr(CVMX_PIP_TAG_INCX(index), pip_tag_incx.u64);
+		offset++;
+	}
+}
+
+#endif /*  __CVMX_PIP_H__ */
diff --git a/drivers/staging/octeon/cvmx-pko-defs.h b/drivers/staging/octeon/cvmx-pko-defs.h
new file mode 100644
index 0000000..50e779c
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-pko-defs.h
@@ -0,0 +1,1133 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_PKO_DEFS_H__
+#define __CVMX_PKO_DEFS_H__
+
+#define CVMX_PKO_MEM_COUNT0 \
+	 CVMX_ADD_IO_SEG(0x0001180050001080ull)
+#define CVMX_PKO_MEM_COUNT1 \
+	 CVMX_ADD_IO_SEG(0x0001180050001088ull)
+#define CVMX_PKO_MEM_DEBUG0 \
+	 CVMX_ADD_IO_SEG(0x0001180050001100ull)
+#define CVMX_PKO_MEM_DEBUG1 \
+	 CVMX_ADD_IO_SEG(0x0001180050001108ull)
+#define CVMX_PKO_MEM_DEBUG10 \
+	 CVMX_ADD_IO_SEG(0x0001180050001150ull)
+#define CVMX_PKO_MEM_DEBUG11 \
+	 CVMX_ADD_IO_SEG(0x0001180050001158ull)
+#define CVMX_PKO_MEM_DEBUG12 \
+	 CVMX_ADD_IO_SEG(0x0001180050001160ull)
+#define CVMX_PKO_MEM_DEBUG13 \
+	 CVMX_ADD_IO_SEG(0x0001180050001168ull)
+#define CVMX_PKO_MEM_DEBUG14 \
+	 CVMX_ADD_IO_SEG(0x0001180050001170ull)
+#define CVMX_PKO_MEM_DEBUG2 \
+	 CVMX_ADD_IO_SEG(0x0001180050001110ull)
+#define CVMX_PKO_MEM_DEBUG3 \
+	 CVMX_ADD_IO_SEG(0x0001180050001118ull)
+#define CVMX_PKO_MEM_DEBUG4 \
+	 CVMX_ADD_IO_SEG(0x0001180050001120ull)
+#define CVMX_PKO_MEM_DEBUG5 \
+	 CVMX_ADD_IO_SEG(0x0001180050001128ull)
+#define CVMX_PKO_MEM_DEBUG6 \
+	 CVMX_ADD_IO_SEG(0x0001180050001130ull)
+#define CVMX_PKO_MEM_DEBUG7 \
+	 CVMX_ADD_IO_SEG(0x0001180050001138ull)
+#define CVMX_PKO_MEM_DEBUG8 \
+	 CVMX_ADD_IO_SEG(0x0001180050001140ull)
+#define CVMX_PKO_MEM_DEBUG9 \
+	 CVMX_ADD_IO_SEG(0x0001180050001148ull)
+#define CVMX_PKO_MEM_PORT_PTRS \
+	 CVMX_ADD_IO_SEG(0x0001180050001010ull)
+#define CVMX_PKO_MEM_PORT_QOS \
+	 CVMX_ADD_IO_SEG(0x0001180050001018ull)
+#define CVMX_PKO_MEM_PORT_RATE0 \
+	 CVMX_ADD_IO_SEG(0x0001180050001020ull)
+#define CVMX_PKO_MEM_PORT_RATE1 \
+	 CVMX_ADD_IO_SEG(0x0001180050001028ull)
+#define CVMX_PKO_MEM_QUEUE_PTRS \
+	 CVMX_ADD_IO_SEG(0x0001180050001000ull)
+#define CVMX_PKO_MEM_QUEUE_QOS \
+	 CVMX_ADD_IO_SEG(0x0001180050001008ull)
+#define CVMX_PKO_REG_BIST_RESULT \
+	 CVMX_ADD_IO_SEG(0x0001180050000080ull)
+#define CVMX_PKO_REG_CMD_BUF \
+	 CVMX_ADD_IO_SEG(0x0001180050000010ull)
+#define CVMX_PKO_REG_CRC_CTLX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180050000028ull + (((offset) & 1) * 8))
+#define CVMX_PKO_REG_CRC_ENABLE \
+	 CVMX_ADD_IO_SEG(0x0001180050000020ull)
+#define CVMX_PKO_REG_CRC_IVX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180050000038ull + (((offset) & 1) * 8))
+#define CVMX_PKO_REG_DEBUG0 \
+	 CVMX_ADD_IO_SEG(0x0001180050000098ull)
+#define CVMX_PKO_REG_DEBUG1 \
+	 CVMX_ADD_IO_SEG(0x00011800500000A0ull)
+#define CVMX_PKO_REG_DEBUG2 \
+	 CVMX_ADD_IO_SEG(0x00011800500000A8ull)
+#define CVMX_PKO_REG_DEBUG3 \
+	 CVMX_ADD_IO_SEG(0x00011800500000B0ull)
+#define CVMX_PKO_REG_ENGINE_INFLIGHT \
+	 CVMX_ADD_IO_SEG(0x0001180050000050ull)
+#define CVMX_PKO_REG_ENGINE_THRESH \
+	 CVMX_ADD_IO_SEG(0x0001180050000058ull)
+#define CVMX_PKO_REG_ERROR \
+	 CVMX_ADD_IO_SEG(0x0001180050000088ull)
+#define CVMX_PKO_REG_FLAGS \
+	 CVMX_ADD_IO_SEG(0x0001180050000000ull)
+#define CVMX_PKO_REG_GMX_PORT_MODE \
+	 CVMX_ADD_IO_SEG(0x0001180050000018ull)
+#define CVMX_PKO_REG_INT_MASK \
+	 CVMX_ADD_IO_SEG(0x0001180050000090ull)
+#define CVMX_PKO_REG_QUEUE_MODE \
+	 CVMX_ADD_IO_SEG(0x0001180050000048ull)
+#define CVMX_PKO_REG_QUEUE_PTRS1 \
+	 CVMX_ADD_IO_SEG(0x0001180050000100ull)
+#define CVMX_PKO_REG_READ_IDX \
+	 CVMX_ADD_IO_SEG(0x0001180050000008ull)
+
+union cvmx_pko_mem_count0 {
+	uint64_t u64;
+	struct cvmx_pko_mem_count0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t count:32;
+	} s;
+	struct cvmx_pko_mem_count0_s cn30xx;
+	struct cvmx_pko_mem_count0_s cn31xx;
+	struct cvmx_pko_mem_count0_s cn38xx;
+	struct cvmx_pko_mem_count0_s cn38xxp2;
+	struct cvmx_pko_mem_count0_s cn50xx;
+	struct cvmx_pko_mem_count0_s cn52xx;
+	struct cvmx_pko_mem_count0_s cn52xxp1;
+	struct cvmx_pko_mem_count0_s cn56xx;
+	struct cvmx_pko_mem_count0_s cn56xxp1;
+	struct cvmx_pko_mem_count0_s cn58xx;
+	struct cvmx_pko_mem_count0_s cn58xxp1;
+};
+
+union cvmx_pko_mem_count1 {
+	uint64_t u64;
+	struct cvmx_pko_mem_count1_s {
+		uint64_t reserved_48_63:16;
+		uint64_t count:48;
+	} s;
+	struct cvmx_pko_mem_count1_s cn30xx;
+	struct cvmx_pko_mem_count1_s cn31xx;
+	struct cvmx_pko_mem_count1_s cn38xx;
+	struct cvmx_pko_mem_count1_s cn38xxp2;
+	struct cvmx_pko_mem_count1_s cn50xx;
+	struct cvmx_pko_mem_count1_s cn52xx;
+	struct cvmx_pko_mem_count1_s cn52xxp1;
+	struct cvmx_pko_mem_count1_s cn56xx;
+	struct cvmx_pko_mem_count1_s cn56xxp1;
+	struct cvmx_pko_mem_count1_s cn58xx;
+	struct cvmx_pko_mem_count1_s cn58xxp1;
+};
+
+union cvmx_pko_mem_debug0 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug0_s {
+		uint64_t fau:28;
+		uint64_t cmd:14;
+		uint64_t segs:6;
+		uint64_t size:16;
+	} s;
+	struct cvmx_pko_mem_debug0_s cn30xx;
+	struct cvmx_pko_mem_debug0_s cn31xx;
+	struct cvmx_pko_mem_debug0_s cn38xx;
+	struct cvmx_pko_mem_debug0_s cn38xxp2;
+	struct cvmx_pko_mem_debug0_s cn50xx;
+	struct cvmx_pko_mem_debug0_s cn52xx;
+	struct cvmx_pko_mem_debug0_s cn52xxp1;
+	struct cvmx_pko_mem_debug0_s cn56xx;
+	struct cvmx_pko_mem_debug0_s cn56xxp1;
+	struct cvmx_pko_mem_debug0_s cn58xx;
+	struct cvmx_pko_mem_debug0_s cn58xxp1;
+};
+
+union cvmx_pko_mem_debug1 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug1_s {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} s;
+	struct cvmx_pko_mem_debug1_s cn30xx;
+	struct cvmx_pko_mem_debug1_s cn31xx;
+	struct cvmx_pko_mem_debug1_s cn38xx;
+	struct cvmx_pko_mem_debug1_s cn38xxp2;
+	struct cvmx_pko_mem_debug1_s cn50xx;
+	struct cvmx_pko_mem_debug1_s cn52xx;
+	struct cvmx_pko_mem_debug1_s cn52xxp1;
+	struct cvmx_pko_mem_debug1_s cn56xx;
+	struct cvmx_pko_mem_debug1_s cn56xxp1;
+	struct cvmx_pko_mem_debug1_s cn58xx;
+	struct cvmx_pko_mem_debug1_s cn58xxp1;
+};
+
+union cvmx_pko_mem_debug10 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug10_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug10_cn30xx {
+		uint64_t fau:28;
+		uint64_t cmd:14;
+		uint64_t segs:6;
+		uint64_t size:16;
+	} cn30xx;
+	struct cvmx_pko_mem_debug10_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug10_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug10_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug10_cn50xx {
+		uint64_t reserved_49_63:15;
+		uint64_t ptrs1:17;
+		uint64_t reserved_17_31:15;
+		uint64_t ptrs2:17;
+	} cn50xx;
+	struct cvmx_pko_mem_debug10_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug10_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug10_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug10_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug10_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug10_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug11 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug11_s {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t reserved_0_39:40;
+	} s;
+	struct cvmx_pko_mem_debug11_cn30xx {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} cn30xx;
+	struct cvmx_pko_mem_debug11_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug11_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug11_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug11_cn50xx {
+		uint64_t reserved_23_63:41;
+		uint64_t maj:1;
+		uint64_t uid:3;
+		uint64_t sop:1;
+		uint64_t len:1;
+		uint64_t chk:1;
+		uint64_t cnt:13;
+		uint64_t mod:3;
+	} cn50xx;
+	struct cvmx_pko_mem_debug11_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug11_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug11_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug11_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug11_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug11_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug12 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug12_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug12_cn30xx {
+		uint64_t data:64;
+	} cn30xx;
+	struct cvmx_pko_mem_debug12_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug12_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug12_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug12_cn50xx {
+		uint64_t fau:28;
+		uint64_t cmd:14;
+		uint64_t segs:6;
+		uint64_t size:16;
+	} cn50xx;
+	struct cvmx_pko_mem_debug12_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug12_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug12_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug12_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug12_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug12_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug13 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug13_s {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t reserved_0_55:56;
+	} s;
+	struct cvmx_pko_mem_debug13_cn30xx {
+		uint64_t reserved_51_63:13;
+		uint64_t widx:17;
+		uint64_t ridx2:17;
+		uint64_t widx2:17;
+	} cn30xx;
+	struct cvmx_pko_mem_debug13_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug13_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug13_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug13_cn50xx {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} cn50xx;
+	struct cvmx_pko_mem_debug13_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug13_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug13_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug13_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug13_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug13_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug14 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug14_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug14_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t ridx:17;
+	} cn30xx;
+	struct cvmx_pko_mem_debug14_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug14_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug14_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug14_cn52xx {
+		uint64_t data:64;
+	} cn52xx;
+	struct cvmx_pko_mem_debug14_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug14_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug14_cn52xx cn56xxp1;
+};
+
+union cvmx_pko_mem_debug2 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug2_s {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} s;
+	struct cvmx_pko_mem_debug2_s cn30xx;
+	struct cvmx_pko_mem_debug2_s cn31xx;
+	struct cvmx_pko_mem_debug2_s cn38xx;
+	struct cvmx_pko_mem_debug2_s cn38xxp2;
+	struct cvmx_pko_mem_debug2_s cn50xx;
+	struct cvmx_pko_mem_debug2_s cn52xx;
+	struct cvmx_pko_mem_debug2_s cn52xxp1;
+	struct cvmx_pko_mem_debug2_s cn56xx;
+	struct cvmx_pko_mem_debug2_s cn56xxp1;
+	struct cvmx_pko_mem_debug2_s cn58xx;
+	struct cvmx_pko_mem_debug2_s cn58xxp1;
+};
+
+union cvmx_pko_mem_debug3 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug3_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug3_cn30xx {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} cn30xx;
+	struct cvmx_pko_mem_debug3_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug3_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug3_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug3_cn50xx {
+		uint64_t data:64;
+	} cn50xx;
+	struct cvmx_pko_mem_debug3_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug3_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug3_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug3_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug3_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug3_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug4 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug4_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug4_cn30xx {
+		uint64_t data:64;
+	} cn30xx;
+	struct cvmx_pko_mem_debug4_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug4_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug4_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug4_cn50xx {
+		uint64_t cmnd_segs:3;
+		uint64_t cmnd_siz:16;
+		uint64_t cmnd_off:6;
+		uint64_t uid:3;
+		uint64_t dread_sop:1;
+		uint64_t init_dwrite:1;
+		uint64_t chk_once:1;
+		uint64_t chk_mode:1;
+		uint64_t active:1;
+		uint64_t static_p:1;
+		uint64_t qos:3;
+		uint64_t qcb_ridx:5;
+		uint64_t qid_off_max:4;
+		uint64_t qid_off:4;
+		uint64_t qid_base:8;
+		uint64_t wait:1;
+		uint64_t minor:2;
+		uint64_t major:3;
+	} cn50xx;
+	struct cvmx_pko_mem_debug4_cn52xx {
+		uint64_t curr_siz:8;
+		uint64_t curr_off:16;
+		uint64_t cmnd_segs:6;
+		uint64_t cmnd_siz:16;
+		uint64_t cmnd_off:6;
+		uint64_t uid:2;
+		uint64_t dread_sop:1;
+		uint64_t init_dwrite:1;
+		uint64_t chk_once:1;
+		uint64_t chk_mode:1;
+		uint64_t wait:1;
+		uint64_t minor:2;
+		uint64_t major:3;
+	} cn52xx;
+	struct cvmx_pko_mem_debug4_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug4_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug4_cn52xx cn56xxp1;
+	struct cvmx_pko_mem_debug4_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug4_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug5 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug5_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug5_cn30xx {
+		uint64_t dwri_mod:1;
+		uint64_t dwri_sop:1;
+		uint64_t dwri_len:1;
+		uint64_t dwri_cnt:13;
+		uint64_t cmnd_siz:16;
+		uint64_t uid:1;
+		uint64_t xfer_wor:1;
+		uint64_t xfer_dwr:1;
+		uint64_t cbuf_fre:1;
+		uint64_t reserved_27_27:1;
+		uint64_t chk_mode:1;
+		uint64_t active:1;
+		uint64_t qos:3;
+		uint64_t qcb_ridx:5;
+		uint64_t qid_off:3;
+		uint64_t qid_base:7;
+		uint64_t wait:1;
+		uint64_t minor:2;
+		uint64_t major:4;
+	} cn30xx;
+	struct cvmx_pko_mem_debug5_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug5_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug5_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug5_cn50xx {
+		uint64_t curr_ptr:29;
+		uint64_t curr_siz:16;
+		uint64_t curr_off:16;
+		uint64_t cmnd_segs:3;
+	} cn50xx;
+	struct cvmx_pko_mem_debug5_cn52xx {
+		uint64_t reserved_54_63:10;
+		uint64_t nxt_inflt:6;
+		uint64_t curr_ptr:40;
+		uint64_t curr_siz:8;
+	} cn52xx;
+	struct cvmx_pko_mem_debug5_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug5_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug5_cn52xx cn56xxp1;
+	struct cvmx_pko_mem_debug5_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug5_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug6 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug6_s {
+		uint64_t reserved_37_63:27;
+		uint64_t qid_offres:4;
+		uint64_t qid_offths:4;
+		uint64_t preempter:1;
+		uint64_t preemptee:1;
+		uint64_t preempted:1;
+		uint64_t active:1;
+		uint64_t statc:1;
+		uint64_t qos:3;
+		uint64_t qcb_ridx:5;
+		uint64_t qid_offmax:4;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pko_mem_debug6_cn30xx {
+		uint64_t reserved_11_63:53;
+		uint64_t qid_offm:3;
+		uint64_t static_p:1;
+		uint64_t work_min:3;
+		uint64_t dwri_chk:1;
+		uint64_t dwri_uid:1;
+		uint64_t dwri_mod:2;
+	} cn30xx;
+	struct cvmx_pko_mem_debug6_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug6_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug6_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug6_cn50xx {
+		uint64_t reserved_11_63:53;
+		uint64_t curr_ptr:11;
+	} cn50xx;
+	struct cvmx_pko_mem_debug6_cn52xx {
+		uint64_t reserved_37_63:27;
+		uint64_t qid_offres:4;
+		uint64_t qid_offths:4;
+		uint64_t preempter:1;
+		uint64_t preemptee:1;
+		uint64_t preempted:1;
+		uint64_t active:1;
+		uint64_t statc:1;
+		uint64_t qos:3;
+		uint64_t qcb_ridx:5;
+		uint64_t qid_offmax:4;
+		uint64_t qid_off:4;
+		uint64_t qid_base:8;
+	} cn52xx;
+	struct cvmx_pko_mem_debug6_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug6_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug6_cn52xx cn56xxp1;
+	struct cvmx_pko_mem_debug6_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug6_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug7 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug7_s {
+		uint64_t qos:5;
+		uint64_t tail:1;
+		uint64_t reserved_0_57:58;
+	} s;
+	struct cvmx_pko_mem_debug7_cn30xx {
+		uint64_t reserved_58_63:6;
+		uint64_t dwb:9;
+		uint64_t start:33;
+		uint64_t size:16;
+	} cn30xx;
+	struct cvmx_pko_mem_debug7_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug7_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug7_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug7_cn50xx {
+		uint64_t qos:5;
+		uint64_t tail:1;
+		uint64_t buf_siz:13;
+		uint64_t buf_ptr:33;
+		uint64_t qcb_widx:6;
+		uint64_t qcb_ridx:6;
+	} cn50xx;
+	struct cvmx_pko_mem_debug7_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug7_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug7_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug7_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug7_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug7_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug8 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug8_s {
+		uint64_t reserved_59_63:5;
+		uint64_t tail:1;
+		uint64_t buf_siz:13;
+		uint64_t reserved_0_44:45;
+	} s;
+	struct cvmx_pko_mem_debug8_cn30xx {
+		uint64_t qos:5;
+		uint64_t tail:1;
+		uint64_t buf_siz:13;
+		uint64_t buf_ptr:33;
+		uint64_t qcb_widx:6;
+		uint64_t qcb_ridx:6;
+	} cn30xx;
+	struct cvmx_pko_mem_debug8_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug8_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug8_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug8_cn50xx {
+		uint64_t reserved_28_63:36;
+		uint64_t doorbell:20;
+		uint64_t reserved_6_7:2;
+		uint64_t static_p:1;
+		uint64_t s_tail:1;
+		uint64_t static_q:1;
+		uint64_t qos:3;
+	} cn50xx;
+	struct cvmx_pko_mem_debug8_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t preempter:1;
+		uint64_t doorbell:20;
+		uint64_t reserved_7_7:1;
+		uint64_t preemptee:1;
+		uint64_t static_p:1;
+		uint64_t s_tail:1;
+		uint64_t static_q:1;
+		uint64_t qos:3;
+	} cn52xx;
+	struct cvmx_pko_mem_debug8_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug8_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug8_cn52xx cn56xxp1;
+	struct cvmx_pko_mem_debug8_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug8_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_debug9 {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug9_s {
+		uint64_t reserved_49_63:15;
+		uint64_t ptrs0:17;
+		uint64_t reserved_0_31:32;
+	} s;
+	struct cvmx_pko_mem_debug9_cn30xx {
+		uint64_t reserved_28_63:36;
+		uint64_t doorbell:20;
+		uint64_t reserved_5_7:3;
+		uint64_t s_tail:1;
+		uint64_t static_q:1;
+		uint64_t qos:3;
+	} cn30xx;
+	struct cvmx_pko_mem_debug9_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug9_cn38xx {
+		uint64_t reserved_28_63:36;
+		uint64_t doorbell:20;
+		uint64_t reserved_6_7:2;
+		uint64_t static_p:1;
+		uint64_t s_tail:1;
+		uint64_t static_q:1;
+		uint64_t qos:3;
+	} cn38xx;
+	struct cvmx_pko_mem_debug9_cn38xx cn38xxp2;
+	struct cvmx_pko_mem_debug9_cn50xx {
+		uint64_t reserved_49_63:15;
+		uint64_t ptrs0:17;
+		uint64_t reserved_17_31:15;
+		uint64_t ptrs3:17;
+	} cn50xx;
+	struct cvmx_pko_mem_debug9_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug9_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug9_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug9_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug9_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug9_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_mem_port_ptrs {
+	uint64_t u64;
+	struct cvmx_pko_mem_port_ptrs_s {
+		uint64_t reserved_62_63:2;
+		uint64_t static_p:1;
+		uint64_t qos_mask:8;
+		uint64_t reserved_16_52:37;
+		uint64_t bp_port:6;
+		uint64_t eid:4;
+		uint64_t pid:6;
+	} s;
+	struct cvmx_pko_mem_port_ptrs_s cn52xx;
+	struct cvmx_pko_mem_port_ptrs_s cn52xxp1;
+	struct cvmx_pko_mem_port_ptrs_s cn56xx;
+	struct cvmx_pko_mem_port_ptrs_s cn56xxp1;
+};
+
+union cvmx_pko_mem_port_qos {
+	uint64_t u64;
+	struct cvmx_pko_mem_port_qos_s {
+		uint64_t reserved_61_63:3;
+		uint64_t qos_mask:8;
+		uint64_t reserved_10_52:43;
+		uint64_t eid:4;
+		uint64_t pid:6;
+	} s;
+	struct cvmx_pko_mem_port_qos_s cn52xx;
+	struct cvmx_pko_mem_port_qos_s cn52xxp1;
+	struct cvmx_pko_mem_port_qos_s cn56xx;
+	struct cvmx_pko_mem_port_qos_s cn56xxp1;
+};
+
+union cvmx_pko_mem_port_rate0 {
+	uint64_t u64;
+	struct cvmx_pko_mem_port_rate0_s {
+		uint64_t reserved_51_63:13;
+		uint64_t rate_word:19;
+		uint64_t rate_pkt:24;
+		uint64_t reserved_6_7:2;
+		uint64_t pid:6;
+	} s;
+	struct cvmx_pko_mem_port_rate0_s cn52xx;
+	struct cvmx_pko_mem_port_rate0_s cn52xxp1;
+	struct cvmx_pko_mem_port_rate0_s cn56xx;
+	struct cvmx_pko_mem_port_rate0_s cn56xxp1;
+};
+
+union cvmx_pko_mem_port_rate1 {
+	uint64_t u64;
+	struct cvmx_pko_mem_port_rate1_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rate_lim:24;
+		uint64_t reserved_6_7:2;
+		uint64_t pid:6;
+	} s;
+	struct cvmx_pko_mem_port_rate1_s cn52xx;
+	struct cvmx_pko_mem_port_rate1_s cn52xxp1;
+	struct cvmx_pko_mem_port_rate1_s cn56xx;
+	struct cvmx_pko_mem_port_rate1_s cn56xxp1;
+};
+
+union cvmx_pko_mem_queue_ptrs {
+	uint64_t u64;
+	struct cvmx_pko_mem_queue_ptrs_s {
+		uint64_t s_tail:1;
+		uint64_t static_p:1;
+		uint64_t static_q:1;
+		uint64_t qos_mask:8;
+		uint64_t buf_ptr:36;
+		uint64_t tail:1;
+		uint64_t index:3;
+		uint64_t port:6;
+		uint64_t queue:7;
+	} s;
+	struct cvmx_pko_mem_queue_ptrs_s cn30xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn31xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn38xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn38xxp2;
+	struct cvmx_pko_mem_queue_ptrs_s cn50xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn52xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn52xxp1;
+	struct cvmx_pko_mem_queue_ptrs_s cn56xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn56xxp1;
+	struct cvmx_pko_mem_queue_ptrs_s cn58xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn58xxp1;
+};
+
+union cvmx_pko_mem_queue_qos {
+	uint64_t u64;
+	struct cvmx_pko_mem_queue_qos_s {
+		uint64_t reserved_61_63:3;
+		uint64_t qos_mask:8;
+		uint64_t reserved_13_52:40;
+		uint64_t pid:6;
+		uint64_t qid:7;
+	} s;
+	struct cvmx_pko_mem_queue_qos_s cn30xx;
+	struct cvmx_pko_mem_queue_qos_s cn31xx;
+	struct cvmx_pko_mem_queue_qos_s cn38xx;
+	struct cvmx_pko_mem_queue_qos_s cn38xxp2;
+	struct cvmx_pko_mem_queue_qos_s cn50xx;
+	struct cvmx_pko_mem_queue_qos_s cn52xx;
+	struct cvmx_pko_mem_queue_qos_s cn52xxp1;
+	struct cvmx_pko_mem_queue_qos_s cn56xx;
+	struct cvmx_pko_mem_queue_qos_s cn56xxp1;
+	struct cvmx_pko_mem_queue_qos_s cn58xx;
+	struct cvmx_pko_mem_queue_qos_s cn58xxp1;
+};
+
+union cvmx_pko_reg_bist_result {
+	uint64_t u64;
+	struct cvmx_pko_reg_bist_result_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_reg_bist_result_cn30xx {
+		uint64_t reserved_27_63:37;
+		uint64_t psb2:5;
+		uint64_t count:1;
+		uint64_t rif:1;
+		uint64_t wif:1;
+		uint64_t ncb:1;
+		uint64_t out:1;
+		uint64_t crc:1;
+		uint64_t chk:1;
+		uint64_t qsb:2;
+		uint64_t qcb:2;
+		uint64_t pdb:4;
+		uint64_t psb:7;
+	} cn30xx;
+	struct cvmx_pko_reg_bist_result_cn30xx cn31xx;
+	struct cvmx_pko_reg_bist_result_cn30xx cn38xx;
+	struct cvmx_pko_reg_bist_result_cn30xx cn38xxp2;
+	struct cvmx_pko_reg_bist_result_cn50xx {
+		uint64_t reserved_33_63:31;
+		uint64_t csr:1;
+		uint64_t iob:1;
+		uint64_t out_crc:1;
+		uint64_t out_ctl:3;
+		uint64_t out_sta:1;
+		uint64_t out_wif:1;
+		uint64_t prt_chk:3;
+		uint64_t prt_nxt:1;
+		uint64_t prt_psb:6;
+		uint64_t ncb_inb:2;
+		uint64_t prt_qcb:2;
+		uint64_t prt_qsb:3;
+		uint64_t dat_dat:4;
+		uint64_t dat_ptr:4;
+	} cn50xx;
+	struct cvmx_pko_reg_bist_result_cn52xx {
+		uint64_t reserved_35_63:29;
+		uint64_t csr:1;
+		uint64_t iob:1;
+		uint64_t out_dat:1;
+		uint64_t out_ctl:3;
+		uint64_t out_sta:1;
+		uint64_t out_wif:1;
+		uint64_t prt_chk:3;
+		uint64_t prt_nxt:1;
+		uint64_t prt_psb:8;
+		uint64_t ncb_inb:2;
+		uint64_t prt_qcb:2;
+		uint64_t prt_qsb:3;
+		uint64_t prt_ctl:2;
+		uint64_t dat_dat:2;
+		uint64_t dat_ptr:4;
+	} cn52xx;
+	struct cvmx_pko_reg_bist_result_cn52xx cn52xxp1;
+	struct cvmx_pko_reg_bist_result_cn52xx cn56xx;
+	struct cvmx_pko_reg_bist_result_cn52xx cn56xxp1;
+	struct cvmx_pko_reg_bist_result_cn50xx cn58xx;
+	struct cvmx_pko_reg_bist_result_cn50xx cn58xxp1;
+};
+
+union cvmx_pko_reg_cmd_buf {
+	uint64_t u64;
+	struct cvmx_pko_reg_cmd_buf_s {
+		uint64_t reserved_23_63:41;
+		uint64_t pool:3;
+		uint64_t reserved_13_19:7;
+		uint64_t size:13;
+	} s;
+	struct cvmx_pko_reg_cmd_buf_s cn30xx;
+	struct cvmx_pko_reg_cmd_buf_s cn31xx;
+	struct cvmx_pko_reg_cmd_buf_s cn38xx;
+	struct cvmx_pko_reg_cmd_buf_s cn38xxp2;
+	struct cvmx_pko_reg_cmd_buf_s cn50xx;
+	struct cvmx_pko_reg_cmd_buf_s cn52xx;
+	struct cvmx_pko_reg_cmd_buf_s cn52xxp1;
+	struct cvmx_pko_reg_cmd_buf_s cn56xx;
+	struct cvmx_pko_reg_cmd_buf_s cn56xxp1;
+	struct cvmx_pko_reg_cmd_buf_s cn58xx;
+	struct cvmx_pko_reg_cmd_buf_s cn58xxp1;
+};
+
+union cvmx_pko_reg_crc_ctlx {
+	uint64_t u64;
+	struct cvmx_pko_reg_crc_ctlx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t invres:1;
+		uint64_t refin:1;
+	} s;
+	struct cvmx_pko_reg_crc_ctlx_s cn38xx;
+	struct cvmx_pko_reg_crc_ctlx_s cn38xxp2;
+	struct cvmx_pko_reg_crc_ctlx_s cn58xx;
+	struct cvmx_pko_reg_crc_ctlx_s cn58xxp1;
+};
+
+union cvmx_pko_reg_crc_enable {
+	uint64_t u64;
+	struct cvmx_pko_reg_crc_enable_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enable:32;
+	} s;
+	struct cvmx_pko_reg_crc_enable_s cn38xx;
+	struct cvmx_pko_reg_crc_enable_s cn38xxp2;
+	struct cvmx_pko_reg_crc_enable_s cn58xx;
+	struct cvmx_pko_reg_crc_enable_s cn58xxp1;
+};
+
+union cvmx_pko_reg_crc_ivx {
+	uint64_t u64;
+	struct cvmx_pko_reg_crc_ivx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iv:32;
+	} s;
+	struct cvmx_pko_reg_crc_ivx_s cn38xx;
+	struct cvmx_pko_reg_crc_ivx_s cn38xxp2;
+	struct cvmx_pko_reg_crc_ivx_s cn58xx;
+	struct cvmx_pko_reg_crc_ivx_s cn58xxp1;
+};
+
+union cvmx_pko_reg_debug0 {
+	uint64_t u64;
+	struct cvmx_pko_reg_debug0_s {
+		uint64_t asserts:64;
+	} s;
+	struct cvmx_pko_reg_debug0_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t asserts:17;
+	} cn30xx;
+	struct cvmx_pko_reg_debug0_cn30xx cn31xx;
+	struct cvmx_pko_reg_debug0_cn30xx cn38xx;
+	struct cvmx_pko_reg_debug0_cn30xx cn38xxp2;
+	struct cvmx_pko_reg_debug0_s cn50xx;
+	struct cvmx_pko_reg_debug0_s cn52xx;
+	struct cvmx_pko_reg_debug0_s cn52xxp1;
+	struct cvmx_pko_reg_debug0_s cn56xx;
+	struct cvmx_pko_reg_debug0_s cn56xxp1;
+	struct cvmx_pko_reg_debug0_s cn58xx;
+	struct cvmx_pko_reg_debug0_s cn58xxp1;
+};
+
+union cvmx_pko_reg_debug1 {
+	uint64_t u64;
+	struct cvmx_pko_reg_debug1_s {
+		uint64_t asserts:64;
+	} s;
+	struct cvmx_pko_reg_debug1_s cn50xx;
+	struct cvmx_pko_reg_debug1_s cn52xx;
+	struct cvmx_pko_reg_debug1_s cn52xxp1;
+	struct cvmx_pko_reg_debug1_s cn56xx;
+	struct cvmx_pko_reg_debug1_s cn56xxp1;
+	struct cvmx_pko_reg_debug1_s cn58xx;
+	struct cvmx_pko_reg_debug1_s cn58xxp1;
+};
+
+union cvmx_pko_reg_debug2 {
+	uint64_t u64;
+	struct cvmx_pko_reg_debug2_s {
+		uint64_t asserts:64;
+	} s;
+	struct cvmx_pko_reg_debug2_s cn50xx;
+	struct cvmx_pko_reg_debug2_s cn52xx;
+	struct cvmx_pko_reg_debug2_s cn52xxp1;
+	struct cvmx_pko_reg_debug2_s cn56xx;
+	struct cvmx_pko_reg_debug2_s cn56xxp1;
+	struct cvmx_pko_reg_debug2_s cn58xx;
+	struct cvmx_pko_reg_debug2_s cn58xxp1;
+};
+
+union cvmx_pko_reg_debug3 {
+	uint64_t u64;
+	struct cvmx_pko_reg_debug3_s {
+		uint64_t asserts:64;
+	} s;
+	struct cvmx_pko_reg_debug3_s cn50xx;
+	struct cvmx_pko_reg_debug3_s cn52xx;
+	struct cvmx_pko_reg_debug3_s cn52xxp1;
+	struct cvmx_pko_reg_debug3_s cn56xx;
+	struct cvmx_pko_reg_debug3_s cn56xxp1;
+	struct cvmx_pko_reg_debug3_s cn58xx;
+	struct cvmx_pko_reg_debug3_s cn58xxp1;
+};
+
+union cvmx_pko_reg_engine_inflight {
+	uint64_t u64;
+	struct cvmx_pko_reg_engine_inflight_s {
+		uint64_t reserved_40_63:24;
+		uint64_t engine9:4;
+		uint64_t engine8:4;
+		uint64_t engine7:4;
+		uint64_t engine6:4;
+		uint64_t engine5:4;
+		uint64_t engine4:4;
+		uint64_t engine3:4;
+		uint64_t engine2:4;
+		uint64_t engine1:4;
+		uint64_t engine0:4;
+	} s;
+	struct cvmx_pko_reg_engine_inflight_s cn52xx;
+	struct cvmx_pko_reg_engine_inflight_s cn52xxp1;
+	struct cvmx_pko_reg_engine_inflight_s cn56xx;
+	struct cvmx_pko_reg_engine_inflight_s cn56xxp1;
+};
+
+union cvmx_pko_reg_engine_thresh {
+	uint64_t u64;
+	struct cvmx_pko_reg_engine_thresh_s {
+		uint64_t reserved_10_63:54;
+		uint64_t mask:10;
+	} s;
+	struct cvmx_pko_reg_engine_thresh_s cn52xx;
+	struct cvmx_pko_reg_engine_thresh_s cn52xxp1;
+	struct cvmx_pko_reg_engine_thresh_s cn56xx;
+	struct cvmx_pko_reg_engine_thresh_s cn56xxp1;
+};
+
+union cvmx_pko_reg_error {
+	uint64_t u64;
+	struct cvmx_pko_reg_error_s {
+		uint64_t reserved_3_63:61;
+		uint64_t currzero:1;
+		uint64_t doorbell:1;
+		uint64_t parity:1;
+	} s;
+	struct cvmx_pko_reg_error_cn30xx {
+		uint64_t reserved_2_63:62;
+		uint64_t doorbell:1;
+		uint64_t parity:1;
+	} cn30xx;
+	struct cvmx_pko_reg_error_cn30xx cn31xx;
+	struct cvmx_pko_reg_error_cn30xx cn38xx;
+	struct cvmx_pko_reg_error_cn30xx cn38xxp2;
+	struct cvmx_pko_reg_error_s cn50xx;
+	struct cvmx_pko_reg_error_s cn52xx;
+	struct cvmx_pko_reg_error_s cn52xxp1;
+	struct cvmx_pko_reg_error_s cn56xx;
+	struct cvmx_pko_reg_error_s cn56xxp1;
+	struct cvmx_pko_reg_error_s cn58xx;
+	struct cvmx_pko_reg_error_s cn58xxp1;
+};
+
+union cvmx_pko_reg_flags {
+	uint64_t u64;
+	struct cvmx_pko_reg_flags_s {
+		uint64_t reserved_4_63:60;
+		uint64_t reset:1;
+		uint64_t store_be:1;
+		uint64_t ena_dwb:1;
+		uint64_t ena_pko:1;
+	} s;
+	struct cvmx_pko_reg_flags_s cn30xx;
+	struct cvmx_pko_reg_flags_s cn31xx;
+	struct cvmx_pko_reg_flags_s cn38xx;
+	struct cvmx_pko_reg_flags_s cn38xxp2;
+	struct cvmx_pko_reg_flags_s cn50xx;
+	struct cvmx_pko_reg_flags_s cn52xx;
+	struct cvmx_pko_reg_flags_s cn52xxp1;
+	struct cvmx_pko_reg_flags_s cn56xx;
+	struct cvmx_pko_reg_flags_s cn56xxp1;
+	struct cvmx_pko_reg_flags_s cn58xx;
+	struct cvmx_pko_reg_flags_s cn58xxp1;
+};
+
+union cvmx_pko_reg_gmx_port_mode {
+	uint64_t u64;
+	struct cvmx_pko_reg_gmx_port_mode_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mode1:3;
+		uint64_t mode0:3;
+	} s;
+	struct cvmx_pko_reg_gmx_port_mode_s cn30xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn31xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn38xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn38xxp2;
+	struct cvmx_pko_reg_gmx_port_mode_s cn50xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn52xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn52xxp1;
+	struct cvmx_pko_reg_gmx_port_mode_s cn56xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn56xxp1;
+	struct cvmx_pko_reg_gmx_port_mode_s cn58xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn58xxp1;
+};
+
+union cvmx_pko_reg_int_mask {
+	uint64_t u64;
+	struct cvmx_pko_reg_int_mask_s {
+		uint64_t reserved_3_63:61;
+		uint64_t currzero:1;
+		uint64_t doorbell:1;
+		uint64_t parity:1;
+	} s;
+	struct cvmx_pko_reg_int_mask_cn30xx {
+		uint64_t reserved_2_63:62;
+		uint64_t doorbell:1;
+		uint64_t parity:1;
+	} cn30xx;
+	struct cvmx_pko_reg_int_mask_cn30xx cn31xx;
+	struct cvmx_pko_reg_int_mask_cn30xx cn38xx;
+	struct cvmx_pko_reg_int_mask_cn30xx cn38xxp2;
+	struct cvmx_pko_reg_int_mask_s cn50xx;
+	struct cvmx_pko_reg_int_mask_s cn52xx;
+	struct cvmx_pko_reg_int_mask_s cn52xxp1;
+	struct cvmx_pko_reg_int_mask_s cn56xx;
+	struct cvmx_pko_reg_int_mask_s cn56xxp1;
+	struct cvmx_pko_reg_int_mask_s cn58xx;
+	struct cvmx_pko_reg_int_mask_s cn58xxp1;
+};
+
+union cvmx_pko_reg_queue_mode {
+	uint64_t u64;
+	struct cvmx_pko_reg_queue_mode_s {
+		uint64_t reserved_2_63:62;
+		uint64_t mode:2;
+	} s;
+	struct cvmx_pko_reg_queue_mode_s cn30xx;
+	struct cvmx_pko_reg_queue_mode_s cn31xx;
+	struct cvmx_pko_reg_queue_mode_s cn38xx;
+	struct cvmx_pko_reg_queue_mode_s cn38xxp2;
+	struct cvmx_pko_reg_queue_mode_s cn50xx;
+	struct cvmx_pko_reg_queue_mode_s cn52xx;
+	struct cvmx_pko_reg_queue_mode_s cn52xxp1;
+	struct cvmx_pko_reg_queue_mode_s cn56xx;
+	struct cvmx_pko_reg_queue_mode_s cn56xxp1;
+	struct cvmx_pko_reg_queue_mode_s cn58xx;
+	struct cvmx_pko_reg_queue_mode_s cn58xxp1;
+};
+
+union cvmx_pko_reg_queue_ptrs1 {
+	uint64_t u64;
+	struct cvmx_pko_reg_queue_ptrs1_s {
+		uint64_t reserved_2_63:62;
+		uint64_t idx3:1;
+		uint64_t qid7:1;
+	} s;
+	struct cvmx_pko_reg_queue_ptrs1_s cn50xx;
+	struct cvmx_pko_reg_queue_ptrs1_s cn52xx;
+	struct cvmx_pko_reg_queue_ptrs1_s cn52xxp1;
+	struct cvmx_pko_reg_queue_ptrs1_s cn56xx;
+	struct cvmx_pko_reg_queue_ptrs1_s cn56xxp1;
+	struct cvmx_pko_reg_queue_ptrs1_s cn58xx;
+	struct cvmx_pko_reg_queue_ptrs1_s cn58xxp1;
+};
+
+union cvmx_pko_reg_read_idx {
+	uint64_t u64;
+	struct cvmx_pko_reg_read_idx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t inc:8;
+		uint64_t index:8;
+	} s;
+	struct cvmx_pko_reg_read_idx_s cn30xx;
+	struct cvmx_pko_reg_read_idx_s cn31xx;
+	struct cvmx_pko_reg_read_idx_s cn38xx;
+	struct cvmx_pko_reg_read_idx_s cn38xxp2;
+	struct cvmx_pko_reg_read_idx_s cn50xx;
+	struct cvmx_pko_reg_read_idx_s cn52xx;
+	struct cvmx_pko_reg_read_idx_s cn52xxp1;
+	struct cvmx_pko_reg_read_idx_s cn56xx;
+	struct cvmx_pko_reg_read_idx_s cn56xxp1;
+	struct cvmx_pko_reg_read_idx_s cn58xx;
+	struct cvmx_pko_reg_read_idx_s cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-pko.c b/drivers/staging/octeon/cvmx-pko.c
new file mode 100644
index 0000000..00db915
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-pko.c
@@ -0,0 +1,506 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ * Support library for the hardware Packet Output unit.
+ */
+
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+#include "cvmx-pko.h"
+#include "cvmx-helper.h"
+
+/**
+ * Internal state of packet output
+ */
+
+/**
+ * Call before any other calls to initialize the packet
+ * output system.  This does chip global config, and should only be
+ * done by one core.
+ */
+
+void cvmx_pko_initialize_global(void)
+{
+	int i;
+	uint64_t priority = 8;
+	union cvmx_pko_reg_cmd_buf config;
+
+	/*
+	 * Set the size of the PKO command buffers to an odd number of
+	 * 64bit words. This allows the normal two word send to stay
+	 * aligned and never span a comamnd word buffer.
+	 */
+	config.u64 = 0;
+	config.s.pool = CVMX_FPA_OUTPUT_BUFFER_POOL;
+	config.s.size = CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE / 8 - 1;
+
+	cvmx_write_csr(CVMX_PKO_REG_CMD_BUF, config.u64);
+
+	for (i = 0; i < CVMX_PKO_MAX_OUTPUT_QUEUES; i++)
+		cvmx_pko_config_port(CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID, i, 1,
+				     &priority);
+
+	/*
+	 * If we aren't using all of the queues optimize PKO's
+	 * internal memory.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX)
+	    || OCTEON_IS_MODEL(OCTEON_CN56XX)
+	    || OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		int num_interfaces = cvmx_helper_get_number_of_interfaces();
+		int last_port =
+		    cvmx_helper_get_last_ipd_port(num_interfaces - 1);
+		int max_queues =
+		    cvmx_pko_get_base_queue(last_port) +
+		    cvmx_pko_get_num_queues(last_port);
+		if (OCTEON_IS_MODEL(OCTEON_CN38XX)) {
+			if (max_queues <= 32)
+				cvmx_write_csr(CVMX_PKO_REG_QUEUE_MODE, 2);
+			else if (max_queues <= 64)
+				cvmx_write_csr(CVMX_PKO_REG_QUEUE_MODE, 1);
+		} else {
+			if (max_queues <= 64)
+				cvmx_write_csr(CVMX_PKO_REG_QUEUE_MODE, 2);
+			else if (max_queues <= 128)
+				cvmx_write_csr(CVMX_PKO_REG_QUEUE_MODE, 1);
+		}
+	}
+}
+
+/**
+ * This function does per-core initialization required by the PKO routines.
+ * This must be called on all cores that will do packet output, and must
+ * be called after the FPA has been initialized and filled with pages.
+ *
+ * Returns 0 on success
+ *         !0 on failure
+ */
+int cvmx_pko_initialize_local(void)
+{
+	/* Nothing to do */
+	return 0;
+}
+
+/**
+ * Enables the packet output hardware. It must already be
+ * configured.
+ */
+void cvmx_pko_enable(void)
+{
+	union cvmx_pko_reg_flags flags;
+
+	flags.u64 = cvmx_read_csr(CVMX_PKO_REG_FLAGS);
+	if (flags.s.ena_pko)
+		cvmx_dprintf
+		    ("Warning: Enabling PKO when PKO already enabled.\n");
+
+	flags.s.ena_dwb = 1;
+	flags.s.ena_pko = 1;
+	/*
+	 * always enable big endian for 3-word command. Does nothing
+	 * for 2-word.
+	 */
+	flags.s.store_be = 1;
+	cvmx_write_csr(CVMX_PKO_REG_FLAGS, flags.u64);
+}
+
+/**
+ * Disables the packet output. Does not affect any configuration.
+ */
+void cvmx_pko_disable(void)
+{
+	union cvmx_pko_reg_flags pko_reg_flags;
+	pko_reg_flags.u64 = cvmx_read_csr(CVMX_PKO_REG_FLAGS);
+	pko_reg_flags.s.ena_pko = 0;
+	cvmx_write_csr(CVMX_PKO_REG_FLAGS, pko_reg_flags.u64);
+}
+
+
+/**
+ * Reset the packet output.
+ */
+static void __cvmx_pko_reset(void)
+{
+	union cvmx_pko_reg_flags pko_reg_flags;
+	pko_reg_flags.u64 = cvmx_read_csr(CVMX_PKO_REG_FLAGS);
+	pko_reg_flags.s.reset = 1;
+	cvmx_write_csr(CVMX_PKO_REG_FLAGS, pko_reg_flags.u64);
+}
+
+/**
+ * Shutdown and free resources required by packet output.
+ */
+void cvmx_pko_shutdown(void)
+{
+	union cvmx_pko_mem_queue_ptrs config;
+	int queue;
+
+	cvmx_pko_disable();
+
+	for (queue = 0; queue < CVMX_PKO_MAX_OUTPUT_QUEUES; queue++) {
+		config.u64 = 0;
+		config.s.tail = 1;
+		config.s.index = 0;
+		config.s.port = CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID;
+		config.s.queue = queue & 0x7f;
+		config.s.qos_mask = 0;
+		config.s.buf_ptr = 0;
+		if (!OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+			union cvmx_pko_reg_queue_ptrs1 config1;
+			config1.u64 = 0;
+			config1.s.qid7 = queue >> 7;
+			cvmx_write_csr(CVMX_PKO_REG_QUEUE_PTRS1, config1.u64);
+		}
+		cvmx_write_csr(CVMX_PKO_MEM_QUEUE_PTRS, config.u64);
+		cvmx_cmd_queue_shutdown(CVMX_CMD_QUEUE_PKO(queue));
+	}
+	__cvmx_pko_reset();
+}
+
+/**
+ * Configure a output port and the associated queues for use.
+ *
+ * @port:       Port to configure.
+ * @base_queue: First queue number to associate with this port.
+ * @num_queues: Number of queues to associate with this port
+ * @priority:   Array of priority levels for each queue. Values are
+ *                   allowed to be 0-8. A value of 8 get 8 times the traffic
+ *                   of a value of 1.  A value of 0 indicates that no rounds
+ *                   will be participated in. These priorities can be changed
+ *                   on the fly while the pko is enabled. A priority of 9
+ *                   indicates that static priority should be used.  If static
+ *                   priority is used all queues with static priority must be
+ *                   contiguous starting at the base_queue, and lower numbered
+ *                   queues have higher priority than higher numbered queues.
+ *                   There must be num_queues elements in the array.
+ */
+cvmx_pko_status_t cvmx_pko_config_port(uint64_t port, uint64_t base_queue,
+				       uint64_t num_queues,
+				       const uint64_t priority[])
+{
+	cvmx_pko_status_t result_code;
+	uint64_t queue;
+	union cvmx_pko_mem_queue_ptrs config;
+	union cvmx_pko_reg_queue_ptrs1 config1;
+	int static_priority_base = -1;
+	int static_priority_end = -1;
+
+	if ((port >= CVMX_PKO_NUM_OUTPUT_PORTS)
+	    && (port != CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID)) {
+		cvmx_dprintf("ERROR: cvmx_pko_config_port: Invalid port %llu\n",
+			     (unsigned long long)port);
+		return CVMX_PKO_INVALID_PORT;
+	}
+
+	if (base_queue + num_queues > CVMX_PKO_MAX_OUTPUT_QUEUES) {
+		cvmx_dprintf
+		    ("ERROR: cvmx_pko_config_port: Invalid queue range %llu\n",
+		     (unsigned long long)(base_queue + num_queues));
+		return CVMX_PKO_INVALID_QUEUE;
+	}
+
+	if (port != CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID) {
+		/*
+		 * Validate the static queue priority setup and set
+		 * static_priority_base and static_priority_end
+		 * accordingly.
+		 */
+		for (queue = 0; queue < num_queues; queue++) {
+			/* Find first queue of static priority */
+			if (static_priority_base == -1
+			    && priority[queue] ==
+			    CVMX_PKO_QUEUE_STATIC_PRIORITY)
+				static_priority_base = queue;
+			/* Find last queue of static priority */
+			if (static_priority_base != -1
+			    && static_priority_end == -1
+			    && priority[queue] != CVMX_PKO_QUEUE_STATIC_PRIORITY
+			    && queue)
+				static_priority_end = queue - 1;
+			else if (static_priority_base != -1
+				 && static_priority_end == -1
+				 && queue == num_queues - 1)
+				/* all queues are static priority */
+				static_priority_end = queue;
+			/*
+			 * Check to make sure all static priority
+			 * queues are contiguous.  Also catches some
+			 * cases of static priorites not starting at
+			 * queue 0.
+			 */
+			if (static_priority_end != -1
+			    && (int)queue > static_priority_end
+			    && priority[queue] ==
+			    CVMX_PKO_QUEUE_STATIC_PRIORITY) {
+				cvmx_dprintf("ERROR: cvmx_pko_config_port: "
+					     "Static priority queues aren't "
+					     "contiguous or don't start at "
+					     "base queue. q: %d, eq: %d\n",
+					(int)queue, static_priority_end);
+				return CVMX_PKO_INVALID_PRIORITY;
+			}
+		}
+		if (static_priority_base > 0) {
+			cvmx_dprintf("ERROR: cvmx_pko_config_port: Static "
+				     "priority queues don't start at base "
+				     "queue. sq: %d\n",
+				static_priority_base);
+			return CVMX_PKO_INVALID_PRIORITY;
+		}
+#if 0
+		cvmx_dprintf("Port %d: Static priority queue base: %d, "
+			     "end: %d\n", port,
+			static_priority_base, static_priority_end);
+#endif
+	}
+	/*
+	 * At this point, static_priority_base and static_priority_end
+	 * are either both -1, or are valid start/end queue
+	 * numbers.
+	 */
+
+	result_code = CVMX_PKO_SUCCESS;
+
+#ifdef PKO_DEBUG
+	cvmx_dprintf("num queues: %d (%lld,%lld)\n", num_queues,
+		     CVMX_PKO_QUEUES_PER_PORT_INTERFACE0,
+		     CVMX_PKO_QUEUES_PER_PORT_INTERFACE1);
+#endif
+
+	for (queue = 0; queue < num_queues; queue++) {
+		uint64_t *buf_ptr = NULL;
+
+		config1.u64 = 0;
+		config1.s.idx3 = queue >> 3;
+		config1.s.qid7 = (base_queue + queue) >> 7;
+
+		config.u64 = 0;
+		config.s.tail = queue == (num_queues - 1);
+		config.s.index = queue;
+		config.s.port = port;
+		config.s.queue = base_queue + queue;
+
+		if (!cvmx_octeon_is_pass1()) {
+			config.s.static_p = static_priority_base >= 0;
+			config.s.static_q = (int)queue <= static_priority_end;
+			config.s.s_tail = (int)queue == static_priority_end;
+		}
+		/*
+		 * Convert the priority into an enable bit field. Try
+		 * to space the bits out evenly so the packet don't
+		 * get grouped up
+		 */
+		switch ((int)priority[queue]) {
+		case 0:
+			config.s.qos_mask = 0x00;
+			break;
+		case 1:
+			config.s.qos_mask = 0x01;
+			break;
+		case 2:
+			config.s.qos_mask = 0x11;
+			break;
+		case 3:
+			config.s.qos_mask = 0x49;
+			break;
+		case 4:
+			config.s.qos_mask = 0x55;
+			break;
+		case 5:
+			config.s.qos_mask = 0x57;
+			break;
+		case 6:
+			config.s.qos_mask = 0x77;
+			break;
+		case 7:
+			config.s.qos_mask = 0x7f;
+			break;
+		case 8:
+			config.s.qos_mask = 0xff;
+			break;
+		case CVMX_PKO_QUEUE_STATIC_PRIORITY:
+			/* Pass 1 will fall through to the error case */
+			if (!cvmx_octeon_is_pass1()) {
+				config.s.qos_mask = 0xff;
+				break;
+			}
+		default:
+			cvmx_dprintf("ERROR: cvmx_pko_config_port: Invalid "
+				     "priority %llu\n",
+				(unsigned long long)priority[queue]);
+			config.s.qos_mask = 0xff;
+			result_code = CVMX_PKO_INVALID_PRIORITY;
+			break;
+		}
+
+		if (port != CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID) {
+			cvmx_cmd_queue_result_t cmd_res =
+			    cvmx_cmd_queue_initialize(CVMX_CMD_QUEUE_PKO
+						      (base_queue + queue),
+						      CVMX_PKO_MAX_QUEUE_DEPTH,
+						      CVMX_FPA_OUTPUT_BUFFER_POOL,
+						      CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE
+						      -
+						      CVMX_PKO_COMMAND_BUFFER_SIZE_ADJUST
+						      * 8);
+			if (cmd_res != CVMX_CMD_QUEUE_SUCCESS) {
+				switch (cmd_res) {
+				case CVMX_CMD_QUEUE_NO_MEMORY:
+					cvmx_dprintf("ERROR: "
+						     "cvmx_pko_config_port: "
+						     "Unable to allocate "
+						     "output buffer.\n");
+					return CVMX_PKO_NO_MEMORY;
+				case CVMX_CMD_QUEUE_ALREADY_SETUP:
+					cvmx_dprintf
+					    ("ERROR: cvmx_pko_config_port: Port already setup.\n");
+					return CVMX_PKO_PORT_ALREADY_SETUP;
+				case CVMX_CMD_QUEUE_INVALID_PARAM:
+				default:
+					cvmx_dprintf
+					    ("ERROR: cvmx_pko_config_port: Command queue initialization failed.\n");
+					return CVMX_PKO_CMD_QUEUE_INIT_ERROR;
+				}
+			}
+
+			buf_ptr =
+			    (uint64_t *)
+			    cvmx_cmd_queue_buffer(CVMX_CMD_QUEUE_PKO
+						  (base_queue + queue));
+			config.s.buf_ptr = cvmx_ptr_to_phys(buf_ptr);
+		} else
+			config.s.buf_ptr = 0;
+
+		CVMX_SYNCWS;
+
+		if (!OCTEON_IS_MODEL(OCTEON_CN3XXX))
+			cvmx_write_csr(CVMX_PKO_REG_QUEUE_PTRS1, config1.u64);
+		cvmx_write_csr(CVMX_PKO_MEM_QUEUE_PTRS, config.u64);
+	}
+
+	return result_code;
+}
+
+#ifdef PKO_DEBUG
+/**
+ * Show map of ports -> queues for different cores.
+ */
+void cvmx_pko_show_queue_map()
+{
+	int core, port;
+	int pko_output_ports = 36;
+
+	cvmx_dprintf("port");
+	for (port = 0; port < pko_output_ports; port++)
+		cvmx_dprintf("%3d ", port);
+	cvmx_dprintf("\n");
+
+	for (core = 0; core < CVMX_MAX_CORES; core++) {
+		cvmx_dprintf("\n%2d: ", core);
+		for (port = 0; port < pko_output_ports; port++) {
+			cvmx_dprintf("%3d ",
+				     cvmx_pko_get_base_queue_per_core(port,
+								      core));
+		}
+	}
+	cvmx_dprintf("\n");
+}
+#endif
+
+/**
+ * Rate limit a PKO port to a max packets/sec. This function is only
+ * supported on CN51XX and higher, excluding CN58XX.
+ *
+ * @port:      Port to rate limit
+ * @packets_s: Maximum packet/sec
+ * @burst:     Maximum number of packets to burst in a row before rate
+ *                  limiting cuts in.
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_pko_rate_limit_packets(int port, int packets_s, int burst)
+{
+	union cvmx_pko_mem_port_rate0 pko_mem_port_rate0;
+	union cvmx_pko_mem_port_rate1 pko_mem_port_rate1;
+
+	pko_mem_port_rate0.u64 = 0;
+	pko_mem_port_rate0.s.pid = port;
+	pko_mem_port_rate0.s.rate_pkt =
+	    cvmx_sysinfo_get()->cpu_clock_hz / packets_s / 16;
+	/* No cost per word since we are limited by packets/sec, not bits/sec */
+	pko_mem_port_rate0.s.rate_word = 0;
+
+	pko_mem_port_rate1.u64 = 0;
+	pko_mem_port_rate1.s.pid = port;
+	pko_mem_port_rate1.s.rate_lim =
+	    ((uint64_t) pko_mem_port_rate0.s.rate_pkt * burst) >> 8;
+
+	cvmx_write_csr(CVMX_PKO_MEM_PORT_RATE0, pko_mem_port_rate0.u64);
+	cvmx_write_csr(CVMX_PKO_MEM_PORT_RATE1, pko_mem_port_rate1.u64);
+	return 0;
+}
+
+/**
+ * Rate limit a PKO port to a max bits/sec. This function is only
+ * supported on CN51XX and higher, excluding CN58XX.
+ *
+ * @port:   Port to rate limit
+ * @bits_s: PKO rate limit in bits/sec
+ * @burst:  Maximum number of bits to burst before rate
+ *               limiting cuts in.
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_pko_rate_limit_bits(int port, uint64_t bits_s, int burst)
+{
+	union cvmx_pko_mem_port_rate0 pko_mem_port_rate0;
+	union cvmx_pko_mem_port_rate1 pko_mem_port_rate1;
+	uint64_t clock_rate = cvmx_sysinfo_get()->cpu_clock_hz;
+	uint64_t tokens_per_bit = clock_rate * 16 / bits_s;
+
+	pko_mem_port_rate0.u64 = 0;
+	pko_mem_port_rate0.s.pid = port;
+	/*
+	 * Each packet has a 12 bytes of interframe gap, an 8 byte
+	 * preamble, and a 4 byte CRC. These are not included in the
+	 * per word count. Multiply by 8 to covert to bits and divide
+	 * by 256 for limit granularity.
+	 */
+	pko_mem_port_rate0.s.rate_pkt = (12 + 8 + 4) * 8 * tokens_per_bit / 256;
+	/* Each 8 byte word has 64bits */
+	pko_mem_port_rate0.s.rate_word = 64 * tokens_per_bit;
+
+	pko_mem_port_rate1.u64 = 0;
+	pko_mem_port_rate1.s.pid = port;
+	pko_mem_port_rate1.s.rate_lim = tokens_per_bit * burst / 256;
+
+	cvmx_write_csr(CVMX_PKO_MEM_PORT_RATE0, pko_mem_port_rate0.u64);
+	cvmx_write_csr(CVMX_PKO_MEM_PORT_RATE1, pko_mem_port_rate1.u64);
+	return 0;
+}
diff --git a/drivers/staging/octeon/cvmx-pko.h b/drivers/staging/octeon/cvmx-pko.h
new file mode 100644
index 0000000..f068c19
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-pko.h
@@ -0,0 +1,610 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Interface to the hardware Packet Output unit.
+ *
+ * Starting with SDK 1.7.0, the PKO output functions now support
+ * two types of locking. CVMX_PKO_LOCK_ATOMIC_TAG continues to
+ * function similarly to previous SDKs by using POW atomic tags
+ * to preserve ordering and exclusivity. As a new option, you
+ * can now pass CVMX_PKO_LOCK_CMD_QUEUE which uses a ll/sc
+ * memory based locking instead. This locking has the advantage
+ * of not affecting the tag state but doesn't preserve packet
+ * ordering. CVMX_PKO_LOCK_CMD_QUEUE is appropriate in most
+ * generic code while CVMX_PKO_LOCK_CMD_QUEUE should be used
+ * with hand tuned fast path code.
+ *
+ * Some of other SDK differences visible to the command command
+ * queuing:
+ * - PKO indexes are no longer stored in the FAU. A large
+ *   percentage of the FAU register block used to be tied up
+ *   maintaining PKO queue pointers. These are now stored in a
+ *   global named block.
+ * - The PKO <b>use_locking</b> parameter can now have a global
+ *   effect. Since all application use the same named block,
+ *   queue locking correctly applies across all operating
+ *   systems when using CVMX_PKO_LOCK_CMD_QUEUE.
+ * - PKO 3 word commands are now supported. Use
+ *   cvmx_pko_send_packet_finish3().
+ *
+ */
+
+#ifndef __CVMX_PKO_H__
+#define __CVMX_PKO_H__
+
+#include "cvmx-fpa.h"
+#include "cvmx-pow.h"
+#include "cvmx-cmd-queue.h"
+#include "cvmx-pko-defs.h"
+
+/* Adjust the command buffer size by 1 word so that in the case of using only
+ * two word PKO commands no command words stradle buffers.  The useful values
+ * for this are 0 and 1. */
+#define CVMX_PKO_COMMAND_BUFFER_SIZE_ADJUST (1)
+
+#define CVMX_PKO_MAX_OUTPUT_QUEUES_STATIC 256
+#define CVMX_PKO_MAX_OUTPUT_QUEUES      ((OCTEON_IS_MODEL(OCTEON_CN31XX) || \
+	OCTEON_IS_MODEL(OCTEON_CN3010) || OCTEON_IS_MODEL(OCTEON_CN3005) || \
+	OCTEON_IS_MODEL(OCTEON_CN50XX)) ? 32 : \
+		(OCTEON_IS_MODEL(OCTEON_CN58XX) || \
+		OCTEON_IS_MODEL(OCTEON_CN56XX)) ? 256 : 128)
+#define CVMX_PKO_NUM_OUTPUT_PORTS       40
+/* use this for queues that are not used */
+#define CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID 63
+#define CVMX_PKO_QUEUE_STATIC_PRIORITY  9
+#define CVMX_PKO_ILLEGAL_QUEUE  0xFFFF
+#define CVMX_PKO_MAX_QUEUE_DEPTH 0
+
+typedef enum {
+	CVMX_PKO_SUCCESS,
+	CVMX_PKO_INVALID_PORT,
+	CVMX_PKO_INVALID_QUEUE,
+	CVMX_PKO_INVALID_PRIORITY,
+	CVMX_PKO_NO_MEMORY,
+	CVMX_PKO_PORT_ALREADY_SETUP,
+	CVMX_PKO_CMD_QUEUE_INIT_ERROR
+} cvmx_pko_status_t;
+
+/**
+ * This enumeration represents the differnet locking modes supported by PKO.
+ */
+typedef enum {
+	/*
+	 * PKO doesn't do any locking. It is the responsibility of the
+	 * application to make sure that no other core is accessing
+	 * the same queue at the smae time
+	 */
+	CVMX_PKO_LOCK_NONE = 0,
+	/*
+	 * PKO performs an atomic tagswitch to insure exclusive access
+	 * to the output queue. This will maintain packet ordering on
+	 * output.
+	 */
+	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
+	/*
+	 * PKO uses the common command queue locks to insure exclusive
+	 * access to the output queue. This is a memory based
+	 * ll/sc. This is the most portable locking mechanism.
+	 */
+	CVMX_PKO_LOCK_CMD_QUEUE = 2,
+} cvmx_pko_lock_t;
+
+typedef struct {
+	uint32_t packets;
+	uint64_t octets;
+	uint64_t doorbell;
+} cvmx_pko_port_status_t;
+
+/**
+ * This structure defines the address to use on a packet enqueue
+ */
+typedef union {
+	uint64_t u64;
+	struct {
+		/* Must CVMX_IO_SEG */
+		uint64_t mem_space:2;
+		/* Must be zero */
+		uint64_t reserved:13;
+		/* Must be one */
+		uint64_t is_io:1;
+		/* The ID of the device on the non-coherent bus */
+		uint64_t did:8;
+		/* Must be zero */
+		uint64_t reserved2:4;
+		/* Must be zero */
+		uint64_t reserved3:18;
+		/*
+		 * The hardware likes to have the output port in
+		 * addition to the output queue,
+		 */
+		uint64_t port:6;
+		/*
+		 * The output queue to send the packet to (0-127 are
+		 * legal)
+		 */
+		uint64_t queue:9;
+		/* Must be zero */
+		uint64_t reserved4:3;
+	} s;
+} cvmx_pko_doorbell_address_t;
+
+/**
+ * Structure of the first packet output command word.
+ */
+typedef union {
+	uint64_t u64;
+	struct {
+		/*
+		 * The size of the reg1 operation - could be 8, 16,
+		 * 32, or 64 bits.
+		 */
+		uint64_t size1:2;
+		/*
+		 * The size of the reg0 operation - could be 8, 16,
+		 * 32, or 64 bits.
+		 */
+		uint64_t size0:2;
+		/*
+		 * If set, subtract 1, if clear, subtract packet
+		 * size.
+		 */
+		uint64_t subone1:1;
+		/*
+		 * The register, subtract will be done if reg1 is
+		 * non-zero.
+		 */
+		uint64_t reg1:11;
+		/* If set, subtract 1, if clear, subtract packet size */
+		uint64_t subone0:1;
+		/* The register, subtract will be done if reg0 is non-zero */
+		uint64_t reg0:11;
+		/*
+		 * When set, interpret segment pointer and segment
+		 * bytes in little endian order.
+		 */
+		uint64_t le:1;
+		/*
+		 * When set, packet data not allocated in L2 cache by
+		 * PKO.
+		 */
+		uint64_t n2:1;
+		/*
+		 * If set and rsp is set, word3 contains a pointer to
+		 * a work queue entry.
+		 */
+		uint64_t wqp:1;
+		/* If set, the hardware will send a response when done */
+		uint64_t rsp:1;
+		/*
+		 * If set, the supplied pkt_ptr is really a pointer to
+		 * a list of pkt_ptr's.
+		 */
+		uint64_t gather:1;
+		/*
+		 * If ipoffp1 is non zero, (ipoffp1-1) is the number
+		 * of bytes to IP header, and the hardware will
+		 * calculate and insert the UDP/TCP checksum.
+		 */
+		uint64_t ipoffp1:7;
+		/*
+		 * If set, ignore the I bit (force to zero) from all
+		 * pointer structures.
+		 */
+		uint64_t ignore_i:1;
+		/*
+		 * If clear, the hardware will attempt to free the
+		 * buffers containing the packet.
+		 */
+		uint64_t dontfree:1;
+		/*
+		 * The total number of segs in the packet, if gather
+		 * set, also gather list length.
+		 */
+		uint64_t segs:6;
+		/* Including L2, but no trailing CRC */
+		uint64_t total_bytes:16;
+	} s;
+} cvmx_pko_command_word0_t;
+
+/* CSR typedefs have been moved to cvmx-csr-*.h */
+
+/**
+ * Definition of internal state for Packet output processing
+ */
+typedef struct {
+	/* ptr to start of buffer, offset kept in FAU reg */
+	uint64_t *start_ptr;
+} cvmx_pko_state_elem_t;
+
+/**
+ * Call before any other calls to initialize the packet
+ * output system.
+ */
+extern void cvmx_pko_initialize_global(void);
+extern int cvmx_pko_initialize_local(void);
+
+/**
+ * Enables the packet output hardware. It must already be
+ * configured.
+ */
+extern void cvmx_pko_enable(void);
+
+/**
+ * Disables the packet output. Does not affect any configuration.
+ */
+extern void cvmx_pko_disable(void);
+
+/**
+ * Shutdown and free resources required by packet output.
+ */
+
+extern void cvmx_pko_shutdown(void);
+
+/**
+ * Configure a output port and the associated queues for use.
+ *
+ * @port:       Port to configure.
+ * @base_queue: First queue number to associate with this port.
+ * @num_queues: Number of queues t oassociate with this port
+ * @priority:   Array of priority levels for each queue. Values are
+ *                   allowed to be 1-8. A value of 8 get 8 times the traffic
+ *                   of a value of 1. There must be num_queues elements in the
+ *                   array.
+ */
+extern cvmx_pko_status_t cvmx_pko_config_port(uint64_t port,
+					      uint64_t base_queue,
+					      uint64_t num_queues,
+					      const uint64_t priority[]);
+
+/**
+ * Ring the packet output doorbell. This tells the packet
+ * output hardware that "len" command words have been added
+ * to its pending list.  This command includes the required
+ * CVMX_SYNCWS before the doorbell ring.
+ *
+ * @port:   Port the packet is for
+ * @queue:  Queue the packet is for
+ * @len:    Length of the command in 64 bit words
+ */
+static inline void cvmx_pko_doorbell(uint64_t port, uint64_t queue,
+				     uint64_t len)
+{
+	cvmx_pko_doorbell_address_t ptr;
+
+	ptr.u64 = 0;
+	ptr.s.mem_space = CVMX_IO_SEG;
+	ptr.s.did = CVMX_OCT_DID_PKT_SEND;
+	ptr.s.is_io = 1;
+	ptr.s.port = port;
+	ptr.s.queue = queue;
+	/*
+	 * Need to make sure output queue data is in DRAM before
+	 * doorbell write.
+	 */
+	CVMX_SYNCWS;
+	cvmx_write_io(ptr.u64, len);
+}
+
+/**
+ * Prepare to send a packet.  This may initiate a tag switch to
+ * get exclusive access to the output queue structure, and
+ * performs other prep work for the packet send operation.
+ *
+ * cvmx_pko_send_packet_finish() MUST be called after this function is called,
+ * and must be called with the same port/queue/use_locking arguments.
+ *
+ * The use_locking parameter allows the caller to use three
+ * possible locking modes.
+ * - CVMX_PKO_LOCK_NONE
+ *      - PKO doesn't do any locking. It is the responsibility
+ *          of the application to make sure that no other core
+ *          is accessing the same queue at the smae time.
+ * - CVMX_PKO_LOCK_ATOMIC_TAG
+ *      - PKO performs an atomic tagswitch to insure exclusive
+ *          access to the output queue. This will maintain
+ *          packet ordering on output.
+ * - CVMX_PKO_LOCK_CMD_QUEUE
+ *      - PKO uses the common command queue locks to insure
+ *          exclusive access to the output queue. This is a
+ *          memory based ll/sc. This is the most portable
+ *          locking mechanism.
+ *
+ * NOTE: If atomic locking is used, the POW entry CANNOT be
+ * descheduled, as it does not contain a valid WQE pointer.
+ *
+ * @port:   Port to send it on
+ * @queue:  Queue to use
+ * @use_locking: CVMX_PKO_LOCK_NONE, CVMX_PKO_LOCK_ATOMIC_TAG, or
+ *               CVMX_PKO_LOCK_CMD_QUEUE
+ */
+
+static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
+						cvmx_pko_lock_t use_locking)
+{
+	if (use_locking == CVMX_PKO_LOCK_ATOMIC_TAG) {
+		/*
+		 * Must do a full switch here to handle all cases.  We
+		 * use a fake WQE pointer, as the POW does not access
+		 * this memory.  The WQE pointer and group are only
+		 * used if this work is descheduled, which is not
+		 * supported by the
+		 * cvmx_pko_send_packet_prepare/cvmx_pko_send_packet_finish
+		 * combination.  Note that this is a special case in
+		 * which these fake values can be used - this is not a
+		 * general technique.
+		 */
+		uint32_t tag =
+		    CVMX_TAG_SW_BITS_INTERNAL << CVMX_TAG_SW_SHIFT |
+		    CVMX_TAG_SUBGROUP_PKO << CVMX_TAG_SUBGROUP_SHIFT |
+		    (CVMX_TAG_SUBGROUP_MASK & queue);
+		cvmx_pow_tag_sw_full((cvmx_wqe_t *) cvmx_phys_to_ptr(0x80), tag,
+				     CVMX_POW_TAG_TYPE_ATOMIC, 0);
+	}
+}
+
+/**
+ * Complete packet output. cvmx_pko_send_packet_prepare() must be
+ * called exactly once before this, and the same parameters must be
+ * passed to both cvmx_pko_send_packet_prepare() and
+ * cvmx_pko_send_packet_finish().
+ *
+ * @port:   Port to send it on
+ * @queue:  Queue to use
+ * @pko_command:
+ *               PKO HW command word
+ * @packet: Packet to send
+ * @use_locking: CVMX_PKO_LOCK_NONE, CVMX_PKO_LOCK_ATOMIC_TAG, or
+ *               CVMX_PKO_LOCK_CMD_QUEUE
+ *
+ * Returns returns CVMX_PKO_SUCCESS on success, or error code on
+ * failure of output
+ */
+static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(
+	uint64_t port,
+	uint64_t queue,
+	cvmx_pko_command_word0_t pko_command,
+	union cvmx_buf_ptr packet,
+	cvmx_pko_lock_t use_locking)
+{
+	cvmx_cmd_queue_result_t result;
+	if (use_locking == CVMX_PKO_LOCK_ATOMIC_TAG)
+		cvmx_pow_tag_sw_wait();
+	result = cvmx_cmd_queue_write2(CVMX_CMD_QUEUE_PKO(queue),
+				       (use_locking == CVMX_PKO_LOCK_CMD_QUEUE),
+				       pko_command.u64, packet.u64);
+	if (likely(result == CVMX_CMD_QUEUE_SUCCESS)) {
+		cvmx_pko_doorbell(port, queue, 2);
+		return CVMX_PKO_SUCCESS;
+	} else if ((result == CVMX_CMD_QUEUE_NO_MEMORY)
+		   || (result == CVMX_CMD_QUEUE_FULL)) {
+		return CVMX_PKO_NO_MEMORY;
+	} else {
+		return CVMX_PKO_INVALID_QUEUE;
+	}
+}
+
+/**
+ * Complete packet output. cvmx_pko_send_packet_prepare() must be
+ * called exactly once before this, and the same parameters must be
+ * passed to both cvmx_pko_send_packet_prepare() and
+ * cvmx_pko_send_packet_finish().
+ *
+ * @port:   Port to send it on
+ * @queue:  Queue to use
+ * @pko_command:
+ *               PKO HW command word
+ * @packet: Packet to send
+ * @addr: Plysical address of a work queue entry or physical address
+ *        to zero on complete.
+ * @use_locking: CVMX_PKO_LOCK_NONE, CVMX_PKO_LOCK_ATOMIC_TAG, or
+ *               CVMX_PKO_LOCK_CMD_QUEUE
+ *
+ * Returns returns CVMX_PKO_SUCCESS on success, or error code on
+ * failure of output
+ */
+static inline cvmx_pko_status_t cvmx_pko_send_packet_finish3(
+	uint64_t port,
+	uint64_t queue,
+	cvmx_pko_command_word0_t pko_command,
+	union cvmx_buf_ptr packet,
+	uint64_t addr,
+	cvmx_pko_lock_t use_locking)
+{
+	cvmx_cmd_queue_result_t result;
+	if (use_locking == CVMX_PKO_LOCK_ATOMIC_TAG)
+		cvmx_pow_tag_sw_wait();
+	result = cvmx_cmd_queue_write3(CVMX_CMD_QUEUE_PKO(queue),
+				       (use_locking == CVMX_PKO_LOCK_CMD_QUEUE),
+				       pko_command.u64, packet.u64, addr);
+	if (likely(result == CVMX_CMD_QUEUE_SUCCESS)) {
+		cvmx_pko_doorbell(port, queue, 3);
+		return CVMX_PKO_SUCCESS;
+	} else if ((result == CVMX_CMD_QUEUE_NO_MEMORY)
+		   || (result == CVMX_CMD_QUEUE_FULL)) {
+		return CVMX_PKO_NO_MEMORY;
+	} else {
+		return CVMX_PKO_INVALID_QUEUE;
+	}
+}
+
+/**
+ * Return the pko output queue associated with a port and a specific core.
+ * In normal mode (PKO lockless operation is disabled), the value returned
+ * is the base queue.
+ *
+ * @port:   Port number
+ * @core:   Core to get queue for
+ *
+ * Returns Core-specific output queue
+ */
+static inline int cvmx_pko_get_base_queue_per_core(int port, int core)
+{
+#ifndef CVMX_HELPER_PKO_MAX_PORTS_INTERFACE0
+#define CVMX_HELPER_PKO_MAX_PORTS_INTERFACE0 16
+#endif
+#ifndef CVMX_HELPER_PKO_MAX_PORTS_INTERFACE1
+#define CVMX_HELPER_PKO_MAX_PORTS_INTERFACE1 16
+#endif
+
+	if (port < CVMX_PKO_MAX_PORTS_INTERFACE0)
+		return port * CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 + core;
+	else if (port >= 16 && port < 16 + CVMX_PKO_MAX_PORTS_INTERFACE1)
+		return CVMX_PKO_MAX_PORTS_INTERFACE0 *
+		    CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 + (port -
+							   16) *
+		    CVMX_PKO_QUEUES_PER_PORT_INTERFACE1 + core;
+	else if ((port >= 32) && (port < 36))
+		return CVMX_PKO_MAX_PORTS_INTERFACE0 *
+		    CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 +
+		    CVMX_PKO_MAX_PORTS_INTERFACE1 *
+		    CVMX_PKO_QUEUES_PER_PORT_INTERFACE1 + (port -
+							   32) *
+		    CVMX_PKO_QUEUES_PER_PORT_PCI;
+	else if ((port >= 36) && (port < 40))
+		return CVMX_PKO_MAX_PORTS_INTERFACE0 *
+		    CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 +
+		    CVMX_PKO_MAX_PORTS_INTERFACE1 *
+		    CVMX_PKO_QUEUES_PER_PORT_INTERFACE1 +
+		    4 * CVMX_PKO_QUEUES_PER_PORT_PCI + (port -
+							36) *
+		    CVMX_PKO_QUEUES_PER_PORT_LOOP;
+	else
+		/* Given the limit on the number of ports we can map to
+		 * CVMX_MAX_OUTPUT_QUEUES_STATIC queues (currently 256,
+		 * divided among all cores), the remaining unmapped ports
+		 * are assigned an illegal queue number */
+		return CVMX_PKO_ILLEGAL_QUEUE;
+}
+
+/**
+ * For a given port number, return the base pko output queue
+ * for the port.
+ *
+ * @port:   Port number
+ * Returns Base output queue
+ */
+static inline int cvmx_pko_get_base_queue(int port)
+{
+	return cvmx_pko_get_base_queue_per_core(port, 0);
+}
+
+/**
+ * For a given port number, return the number of pko output queues.
+ *
+ * @port:   Port number
+ * Returns Number of output queues
+ */
+static inline int cvmx_pko_get_num_queues(int port)
+{
+	if (port < 16)
+		return CVMX_PKO_QUEUES_PER_PORT_INTERFACE0;
+	else if (port < 32)
+		return CVMX_PKO_QUEUES_PER_PORT_INTERFACE1;
+	else if (port < 36)
+		return CVMX_PKO_QUEUES_PER_PORT_PCI;
+	else if (port < 40)
+		return CVMX_PKO_QUEUES_PER_PORT_LOOP;
+	else
+		return 0;
+}
+
+/**
+ * Get the status counters for a port.
+ *
+ * @port_num: Port number to get statistics for.
+ * @clear:    Set to 1 to clear the counters after they are read
+ * @status:   Where to put the results.
+ */
+static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
+					    cvmx_pko_port_status_t *status)
+{
+	union cvmx_pko_reg_read_idx pko_reg_read_idx;
+	union cvmx_pko_mem_count0 pko_mem_count0;
+	union cvmx_pko_mem_count1 pko_mem_count1;
+
+	pko_reg_read_idx.u64 = 0;
+	pko_reg_read_idx.s.index = port_num;
+	cvmx_write_csr(CVMX_PKO_REG_READ_IDX, pko_reg_read_idx.u64);
+
+	pko_mem_count0.u64 = cvmx_read_csr(CVMX_PKO_MEM_COUNT0);
+	status->packets = pko_mem_count0.s.count;
+	if (clear) {
+		pko_mem_count0.s.count = port_num;
+		cvmx_write_csr(CVMX_PKO_MEM_COUNT0, pko_mem_count0.u64);
+	}
+
+	pko_mem_count1.u64 = cvmx_read_csr(CVMX_PKO_MEM_COUNT1);
+	status->octets = pko_mem_count1.s.count;
+	if (clear) {
+		pko_mem_count1.s.count = port_num;
+		cvmx_write_csr(CVMX_PKO_MEM_COUNT1, pko_mem_count1.u64);
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+		union cvmx_pko_mem_debug9 debug9;
+		pko_reg_read_idx.s.index = cvmx_pko_get_base_queue(port_num);
+		cvmx_write_csr(CVMX_PKO_REG_READ_IDX, pko_reg_read_idx.u64);
+		debug9.u64 = cvmx_read_csr(CVMX_PKO_MEM_DEBUG9);
+		status->doorbell = debug9.cn38xx.doorbell;
+	} else {
+		union cvmx_pko_mem_debug8 debug8;
+		pko_reg_read_idx.s.index = cvmx_pko_get_base_queue(port_num);
+		cvmx_write_csr(CVMX_PKO_REG_READ_IDX, pko_reg_read_idx.u64);
+		debug8.u64 = cvmx_read_csr(CVMX_PKO_MEM_DEBUG8);
+		status->doorbell = debug8.cn58xx.doorbell;
+	}
+}
+
+/**
+ * Rate limit a PKO port to a max packets/sec. This function is only
+ * supported on CN57XX, CN56XX, CN55XX, and CN54XX.
+ *
+ * @port:      Port to rate limit
+ * @packets_s: Maximum packet/sec
+ * @burst:     Maximum number of packets to burst in a row before rate
+ *                  limiting cuts in.
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int cvmx_pko_rate_limit_packets(int port, int packets_s, int burst);
+
+/**
+ * Rate limit a PKO port to a max bits/sec. This function is only
+ * supported on CN57XX, CN56XX, CN55XX, and CN54XX.
+ *
+ * @port:   Port to rate limit
+ * @bits_s: PKO rate limit in bits/sec
+ * @burst:  Maximum number of bits to burst before rate
+ *               limiting cuts in.
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int cvmx_pko_rate_limit_bits(int port, uint64_t bits_s, int burst);
+
+#endif /* __CVMX_PKO_H__ */
diff --git a/drivers/staging/octeon/cvmx-pow.h b/drivers/staging/octeon/cvmx-pow.h
new file mode 100644
index 0000000..c5d66f2
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-pow.h
@@ -0,0 +1,1982 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * Interface to the hardware Packet Order / Work unit.
+ *
+ * New, starting with SDK 1.7.0, cvmx-pow supports a number of
+ * extended consistency checks. The define
+ * CVMX_ENABLE_POW_CHECKS controls the runtime insertion of POW
+ * internal state checks to find common programming errors. If
+ * CVMX_ENABLE_POW_CHECKS is not defined, checks are by default
+ * enabled. For example, cvmx-pow will check for the following
+ * program errors or POW state inconsistency.
+ * - Requesting a POW operation with an active tag switch in
+ *   progress.
+ * - Waiting for a tag switch to complete for an excessively
+ *   long period. This is normally a sign of an error in locking
+ *   causing deadlock.
+ * - Illegal tag switches from NULL_NULL.
+ * - Illegal tag switches from NULL.
+ * - Illegal deschedule request.
+ * - WQE pointer not matching the one attached to the core by
+ *   the POW.
+ *
+ */
+
+#ifndef __CVMX_POW_H__
+#define __CVMX_POW_H__
+
+#include <asm/octeon/cvmx-pow-defs.h>
+
+#include "cvmx-scratch.h"
+#include "cvmx-wqe.h"
+
+/* Default to having all POW constancy checks turned on */
+#ifndef CVMX_ENABLE_POW_CHECKS
+#define CVMX_ENABLE_POW_CHECKS 1
+#endif
+
+enum cvmx_pow_tag_type {
+	/* Tag ordering is maintained */
+	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
+	/* Tag ordering is maintained, and at most one PP has the tag */
+	CVMX_POW_TAG_TYPE_ATOMIC    = 1L,
+	/*
+	 * The work queue entry from the order - NEVER tag switch from
+	 * NULL to NULL
+	 */
+	CVMX_POW_TAG_TYPE_NULL      = 2L,
+	/* A tag switch to NULL, and there is no space reserved in POW
+	 * - NEVER tag switch to NULL_NULL
+	 * - NEVER tag switch from NULL_NULL
+	 * - NULL_NULL is entered at the beginning of time and on a deschedule.
+	 * - NULL_NULL can be exited by a new work request. A NULL_SWITCH
+	 * load can also switch the state to NULL
+	 */
+	CVMX_POW_TAG_TYPE_NULL_NULL = 3L
+};
+
+/**
+ * Wait flag values for pow functions.
+ */
+typedef enum {
+	CVMX_POW_WAIT = 1,
+	CVMX_POW_NO_WAIT = 0,
+} cvmx_pow_wait_t;
+
+/**
+ *  POW tag operations.  These are used in the data stored to the POW.
+ */
+typedef enum {
+	/*
+	 * switch the tag (only) for this PP
+	 * - the previous tag should be non-NULL in this case
+	 * - tag switch response required
+	 * - fields used: op, type, tag
+	 */
+	CVMX_POW_TAG_OP_SWTAG = 0L,
+	/*
+	 * switch the tag for this PP, with full information
+	 * - this should be used when the previous tag is NULL
+	 * - tag switch response required
+	 * - fields used: address, op, grp, type, tag
+	 */
+	CVMX_POW_TAG_OP_SWTAG_FULL = 1L,
+	/*
+	 * switch the tag (and/or group) for this PP and de-schedule
+	 * - OK to keep the tag the same and only change the group
+	 * - fields used: op, no_sched, grp, type, tag
+	 */
+	CVMX_POW_TAG_OP_SWTAG_DESCH = 2L,
+	/*
+	 * just de-schedule
+	 * - fields used: op, no_sched
+	 */
+	CVMX_POW_TAG_OP_DESCH = 3L,
+	/*
+	 * create an entirely new work queue entry
+	 * - fields used: address, op, qos, grp, type, tag
+	 */
+	CVMX_POW_TAG_OP_ADDWQ = 4L,
+	/*
+	 * just update the work queue pointer and grp for this PP
+	 * - fields used: address, op, grp
+	 */
+	CVMX_POW_TAG_OP_UPDATE_WQP_GRP = 5L,
+	/*
+	 * set the no_sched bit on the de-schedule list
+	 *
+	 * - does nothing if the selected entry is not on the
+	 *   de-schedule list
+	 *
+	 * - does nothing if the stored work queue pointer does not
+	 *   match the address field
+	 *
+	 * - fields used: address, index, op
+	 *
+	 *  Before issuing a *_NSCHED operation, SW must guarantee
+	 *  that all prior deschedules and set/clr NSCHED operations
+	 *  are complete and all prior switches are complete. The
+	 *  hardware provides the opsdone bit and swdone bit for SW
+	 *  polling. After issuing a *_NSCHED operation, SW must
+	 *  guarantee that the set/clr NSCHED is complete before any
+	 *  subsequent operations.
+	 */
+	CVMX_POW_TAG_OP_SET_NSCHED = 6L,
+	/*
+	 * clears the no_sched bit on the de-schedule list
+	 *
+	 * - does nothing if the selected entry is not on the
+	 *   de-schedule list
+	 *
+	 * - does nothing if the stored work queue pointer does not
+	 *   match the address field
+	 *
+	 * - fields used: address, index, op
+	 *
+	 * Before issuing a *_NSCHED operation, SW must guarantee that
+	 * all prior deschedules and set/clr NSCHED operations are
+	 * complete and all prior switches are complete. The hardware
+	 * provides the opsdone bit and swdone bit for SW
+	 * polling. After issuing a *_NSCHED operation, SW must
+	 * guarantee that the set/clr NSCHED is complete before any
+	 * subsequent operations.
+	 */
+	CVMX_POW_TAG_OP_CLR_NSCHED = 7L,
+	/* do nothing */
+	CVMX_POW_TAG_OP_NOP = 15L
+} cvmx_pow_tag_op_t;
+
+/**
+ * This structure defines the store data on a store to POW
+ */
+typedef union {
+	uint64_t u64;
+	struct {
+		/*
+		 * Don't reschedule this entry. no_sched is used for
+		 * CVMX_POW_TAG_OP_SWTAG_DESCH and
+		 * CVMX_POW_TAG_OP_DESCH
+		 */
+		uint64_t no_sched:1;
+		uint64_t unused:2;
+		/* Tontains index of entry for a CVMX_POW_TAG_OP_*_NSCHED */
+		uint64_t index:13;
+		/* The operation to perform */
+		cvmx_pow_tag_op_t op:4;
+		uint64_t unused2:2;
+		/*
+		 * The QOS level for the packet. qos is only used for
+		 * CVMX_POW_TAG_OP_ADDWQ
+		 */
+		uint64_t qos:3;
+		/*
+		 * The group that the work queue entry will be
+		 * scheduled to grp is used for CVMX_POW_TAG_OP_ADDWQ,
+		 * CVMX_POW_TAG_OP_SWTAG_FULL,
+		 * CVMX_POW_TAG_OP_SWTAG_DESCH, and
+		 * CVMX_POW_TAG_OP_UPDATE_WQP_GRP
+		 */
+		uint64_t grp:4;
+		/*
+		 * The type of the tag. type is used for everything
+		 * except CVMX_POW_TAG_OP_DESCH,
+		 * CVMX_POW_TAG_OP_UPDATE_WQP_GRP, and
+		 * CVMX_POW_TAG_OP_*_NSCHED
+		 */
+		uint64_t type:3;
+		/*
+		 * The actual tag. tag is used for everything except
+		 * CVMX_POW_TAG_OP_DESCH,
+		 * CVMX_POW_TAG_OP_UPDATE_WQP_GRP, and
+		 * CVMX_POW_TAG_OP_*_NSCHED
+		 */
+		uint64_t tag:32;
+	} s;
+} cvmx_pow_tag_req_t;
+
+/**
+ * This structure describes the address to load stuff from POW
+ */
+typedef union {
+	uint64_t u64;
+
+    /**
+     * Address for new work request loads (did<2:0> == 0)
+     */
+	struct {
+		/* Mips64 address region. Should be CVMX_IO_SEG */
+		uint64_t mem_region:2;
+		/* Must be zero */
+		uint64_t reserved_49_61:13;
+		/* Must be one */
+		uint64_t is_io:1;
+		/* the ID of POW -- did<2:0> == 0 in this case */
+		uint64_t did:8;
+		/* Must be zero */
+		uint64_t reserved_4_39:36;
+		/*
+		 * If set, don't return load response until work is
+		 * available.
+		 */
+		uint64_t wait:1;
+		/* Must be zero */
+		uint64_t reserved_0_2:3;
+	} swork;
+
+    /**
+     * Address for loads to get POW internal status
+     */
+	struct {
+		/* Mips64 address region. Should be CVMX_IO_SEG */
+		uint64_t mem_region:2;
+		/* Must be zero */
+		uint64_t reserved_49_61:13;
+		/* Must be one */
+		uint64_t is_io:1;
+		/* the ID of POW -- did<2:0> == 1 in this case */
+		uint64_t did:8;
+		/* Must be zero */
+		uint64_t reserved_10_39:30;
+		/* The core id to get status for */
+		uint64_t coreid:4;
+		/*
+		 * If set and get_cur is set, return reverse tag-list
+		 * pointer rather than forward tag-list pointer.
+		 */
+		uint64_t get_rev:1;
+		/*
+		 * If set, return current status rather than pending
+		 * status.
+		 */
+		uint64_t get_cur:1;
+		/*
+		 * If set, get the work-queue pointer rather than
+		 * tag/type.
+		 */
+		uint64_t get_wqp:1;
+		/* Must be zero */
+		uint64_t reserved_0_2:3;
+	} sstatus;
+
+    /**
+     * Address for memory loads to get POW internal state
+     */
+	struct {
+		/* Mips64 address region. Should be CVMX_IO_SEG */
+		uint64_t mem_region:2;
+		/* Must be zero */
+		uint64_t reserved_49_61:13;
+		/* Must be one */
+		uint64_t is_io:1;
+		/* the ID of POW -- did<2:0> == 2 in this case */
+		uint64_t did:8;
+		/* Must be zero */
+		uint64_t reserved_16_39:24;
+		/* POW memory index */
+		uint64_t index:11;
+		/*
+		 * If set, return deschedule information rather than
+		 * the standard response for work-queue index (invalid
+		 * if the work-queue entry is not on the deschedule
+		 * list).
+		 */
+		uint64_t get_des:1;
+		/*
+		 * If set, get the work-queue pointer rather than
+		 * tag/type (no effect when get_des set).
+		 */
+		uint64_t get_wqp:1;
+		/* Must be zero */
+		uint64_t reserved_0_2:3;
+	} smemload;
+
+    /**
+     * Address for index/pointer loads
+     */
+	struct {
+		/* Mips64 address region. Should be CVMX_IO_SEG */
+		uint64_t mem_region:2;
+		/* Must be zero */
+		uint64_t reserved_49_61:13;
+		/* Must be one */
+		uint64_t is_io:1;
+		/* the ID of POW -- did<2:0> == 3 in this case */
+		uint64_t did:8;
+		/* Must be zero */
+		uint64_t reserved_9_39:31;
+		/*
+		 * when {get_rmt ==0 AND get_des_get_tail == 0}, this
+		 * field selects one of eight POW internal-input
+		 * queues (0-7), one per QOS level; values 8-15 are
+		 * illegal in this case; when {get_rmt ==0 AND
+		 * get_des_get_tail == 1}, this field selects one of
+		 * 16 deschedule lists (per group); when get_rmt ==1,
+		 * this field selects one of 16 memory-input queue
+		 * lists.  The two memory-input queue lists associated
+		 * with each QOS level are:
+		 *
+		 * - qosgrp = 0, qosgrp = 8:      QOS0
+		 * - qosgrp = 1, qosgrp = 9:      QOS1
+		 * - qosgrp = 2, qosgrp = 10:     QOS2
+		 * - qosgrp = 3, qosgrp = 11:     QOS3
+		 * - qosgrp = 4, qosgrp = 12:     QOS4
+		 * - qosgrp = 5, qosgrp = 13:     QOS5
+		 * - qosgrp = 6, qosgrp = 14:     QOS6
+		 * - qosgrp = 7, qosgrp = 15:     QOS7
+		 */
+		uint64_t qosgrp:4;
+		/*
+		 * If set and get_rmt is clear, return deschedule list
+		 * indexes rather than indexes for the specified qos
+		 * level; if set and get_rmt is set, return the tail
+		 * pointer rather than the head pointer for the
+		 * specified qos level.
+		 */
+		uint64_t get_des_get_tail:1;
+		/*
+		 * If set, return remote pointers rather than the
+		 * local indexes for the specified qos level.
+		 */
+		uint64_t get_rmt:1;
+		/* Must be zero */
+		uint64_t reserved_0_2:3;
+	} sindexload;
+
+    /**
+     * address for NULL_RD request (did<2:0> == 4) when this is read,
+     * HW attempts to change the state to NULL if it is NULL_NULL (the
+     * hardware cannot switch from NULL_NULL to NULL if a POW entry is
+     * not available - software may need to recover by finishing
+     * another piece of work before a POW entry can ever become
+     * available.)
+     */
+	struct {
+		/* Mips64 address region. Should be CVMX_IO_SEG */
+		uint64_t mem_region:2;
+		/* Must be zero */
+		uint64_t reserved_49_61:13;
+		/* Must be one */
+		uint64_t is_io:1;
+		/* the ID of POW -- did<2:0> == 4 in this case */
+		uint64_t did:8;
+		/* Must be zero */
+		uint64_t reserved_0_39:40;
+	} snull_rd;
+} cvmx_pow_load_addr_t;
+
+/**
+ * This structure defines the response to a load/SENDSINGLE to POW
+ * (except CSR reads)
+ */
+typedef union {
+	uint64_t u64;
+
+    /**
+     * Response to new work request loads
+     */
+	struct {
+		/*
+		 * Set when no new work queue entry was returned.  *
+		 * If there was de-scheduled work, the HW will
+		 * definitely return it. When this bit is set, it
+		 * could mean either mean:
+		 *
+		 * - There was no work, or
+		 *
+		 * - There was no work that the HW could find. This
+		 *   case can happen, regardless of the wait bit value
+		 *   in the original request, when there is work in
+		 *   the IQ's that is too deep down the list.
+		 */
+		uint64_t no_work:1;
+		/* Must be zero */
+		uint64_t reserved_40_62:23;
+		/* 36 in O1 -- the work queue pointer */
+		uint64_t addr:40;
+	} s_work;
+
+    /**
+     * Result for a POW Status Load (when get_cur==0 and get_wqp==0)
+     */
+	struct {
+		uint64_t reserved_62_63:2;
+		/* Set when there is a pending non-NULL SWTAG or
+		 * SWTAG_FULL, and the POW entry has not left the list
+		 * for the original tag. */
+		uint64_t pend_switch:1;
+		/* Set when SWTAG_FULL and pend_switch is set. */
+		uint64_t pend_switch_full:1;
+		/*
+		 * Set when there is a pending NULL SWTAG, or an
+		 * implicit switch to NULL.
+		 */
+		uint64_t pend_switch_null:1;
+		/* Set when there is a pending DESCHED or SWTAG_DESCHED. */
+		uint64_t pend_desched:1;
+		/*
+		 * Set when there is a pending SWTAG_DESCHED and
+		 * pend_desched is set.
+		 */
+		uint64_t pend_desched_switch:1;
+		/* Set when nosched is desired and pend_desched is set. */
+		uint64_t pend_nosched:1;
+		/* Set when there is a pending GET_WORK. */
+		uint64_t pend_new_work:1;
+		/*
+		 * When pend_new_work is set, this bit indicates that
+		 * the wait bit was set.
+		 */
+		uint64_t pend_new_work_wait:1;
+		/* Set when there is a pending NULL_RD. */
+		uint64_t pend_null_rd:1;
+		/* Set when there is a pending CLR_NSCHED. */
+		uint64_t pend_nosched_clr:1;
+		uint64_t reserved_51:1;
+		/* This is the index when pend_nosched_clr is set. */
+		uint64_t pend_index:11;
+		/*
+		 * This is the new_grp when (pend_desched AND
+		 * pend_desched_switch) is set.
+		 */
+		uint64_t pend_grp:4;
+		uint64_t reserved_34_35:2;
+		/*
+		 * This is the tag type when pend_switch or
+		 * (pend_desched AND pend_desched_switch) are set.
+		 */
+		uint64_t pend_type:2;
+		/*
+		 * - this is the tag when pend_switch or (pend_desched
+		 *    AND pend_desched_switch) are set.
+		 */
+		uint64_t pend_tag:32;
+	} s_sstatus0;
+
+    /**
+     * Result for a POW Status Load (when get_cur==0 and get_wqp==1)
+     */
+	struct {
+		uint64_t reserved_62_63:2;
+		/*
+		 * Set when there is a pending non-NULL SWTAG or
+		 * SWTAG_FULL, and the POW entry has not left the list
+		 * for the original tag.
+		 */
+		uint64_t pend_switch:1;
+		/* Set when SWTAG_FULL and pend_switch is set. */
+		uint64_t pend_switch_full:1;
+		/*
+		 * Set when there is a pending NULL SWTAG, or an
+		 * implicit switch to NULL.
+		 */
+		uint64_t pend_switch_null:1;
+		/*
+		 * Set when there is a pending DESCHED or
+		 * SWTAG_DESCHED.
+		 */
+		uint64_t pend_desched:1;
+		/*
+		 * Set when there is a pending SWTAG_DESCHED and
+		 * pend_desched is set.
+		 */
+		uint64_t pend_desched_switch:1;
+		/* Set when nosched is desired and pend_desched is set. */
+		uint64_t pend_nosched:1;
+		/* Set when there is a pending GET_WORK. */
+		uint64_t pend_new_work:1;
+		/*
+		 * When pend_new_work is set, this bit indicates that
+		 * the wait bit was set.
+		 */
+		uint64_t pend_new_work_wait:1;
+		/* Set when there is a pending NULL_RD. */
+		uint64_t pend_null_rd:1;
+		/* Set when there is a pending CLR_NSCHED. */
+		uint64_t pend_nosched_clr:1;
+		uint64_t reserved_51:1;
+		/* This is the index when pend_nosched_clr is set. */
+		uint64_t pend_index:11;
+		/*
+		 * This is the new_grp when (pend_desched AND
+		 * pend_desched_switch) is set.
+		 */
+		uint64_t pend_grp:4;
+		/* This is the wqp when pend_nosched_clr is set. */
+		uint64_t pend_wqp:36;
+	} s_sstatus1;
+
+    /**
+     * Result for a POW Status Load (when get_cur==1, get_wqp==0, and
+     * get_rev==0)
+     */
+	struct {
+		uint64_t reserved_62_63:2;
+		/*
+		 * Points to the next POW entry in the tag list when
+		 * tail == 0 (and tag_type is not NULL or NULL_NULL).
+		 */
+		uint64_t link_index:11;
+		/* The POW entry attached to the core. */
+		uint64_t index:11;
+		/*
+		 * The group attached to the core (updated when new
+		 * tag list entered on SWTAG_FULL).
+		 */
+		uint64_t grp:4;
+		/*
+		 * Set when this POW entry is at the head of its tag
+		 * list (also set when in the NULL or NULL_NULL
+		 * state).
+		 */
+		uint64_t head:1;
+		/*
+		 * Set when this POW entry is at the tail of its tag
+		 * list (also set when in the NULL or NULL_NULL
+		 * state).
+		 */
+		uint64_t tail:1;
+		/*
+		 * The tag type attached to the core (updated when new
+		 * tag list entered on SWTAG, SWTAG_FULL, or
+		 * SWTAG_DESCHED).
+		 */
+		uint64_t tag_type:2;
+		/*
+		 * The tag attached to the core (updated when new tag
+		 * list entered on SWTAG, SWTAG_FULL, or
+		 * SWTAG_DESCHED).
+		 */
+		uint64_t tag:32;
+	} s_sstatus2;
+
+    /**
+     * Result for a POW Status Load (when get_cur==1, get_wqp==0, and get_rev==1)
+     */
+	struct {
+		uint64_t reserved_62_63:2;
+		/*
+		 * Points to the prior POW entry in the tag list when
+		 * head == 0 (and tag_type is not NULL or
+		 * NULL_NULL). This field is unpredictable when the
+		 * core's state is NULL or NULL_NULL.
+		 */
+		uint64_t revlink_index:11;
+		/* The POW entry attached to the core. */
+		uint64_t index:11;
+		/*
+		 * The group attached to the core (updated when new
+		 * tag list entered on SWTAG_FULL).
+		 */
+		uint64_t grp:4;
+		/* Set when this POW entry is at the head of its tag
+		 * list (also set when in the NULL or NULL_NULL
+		 * state).
+		 */
+		uint64_t head:1;
+		/*
+		 * Set when this POW entry is at the tail of its tag
+		 * list (also set when in the NULL or NULL_NULL
+		 * state).
+		 */
+		uint64_t tail:1;
+		/*
+		 * The tag type attached to the core (updated when new
+		 * tag list entered on SWTAG, SWTAG_FULL, or
+		 * SWTAG_DESCHED).
+		 */
+		uint64_t tag_type:2;
+		/*
+		 * The tag attached to the core (updated when new tag
+		 * list entered on SWTAG, SWTAG_FULL, or
+		 * SWTAG_DESCHED).
+		 */
+		uint64_t tag:32;
+	} s_sstatus3;
+
+    /**
+     * Result for a POW Status Load (when get_cur==1, get_wqp==1, and
+     * get_rev==0)
+     */
+	struct {
+		uint64_t reserved_62_63:2;
+		/*
+		 * Points to the next POW entry in the tag list when
+		 * tail == 0 (and tag_type is not NULL or NULL_NULL).
+		 */
+		uint64_t link_index:11;
+		/* The POW entry attached to the core. */
+		uint64_t index:11;
+		/*
+		 * The group attached to the core (updated when new
+		 * tag list entered on SWTAG_FULL).
+		 */
+		uint64_t grp:4;
+		/*
+		 * The wqp attached to the core (updated when new tag
+		 * list entered on SWTAG_FULL).
+		 */
+		uint64_t wqp:36;
+	} s_sstatus4;
+
+    /**
+     * Result for a POW Status Load (when get_cur==1, get_wqp==1, and
+     * get_rev==1)
+     */
+	struct {
+		uint64_t reserved_62_63:2;
+		/*
+		 * Points to the prior POW entry in the tag list when
+		 * head == 0 (and tag_type is not NULL or
+		 * NULL_NULL). This field is unpredictable when the
+		 * core's state is NULL or NULL_NULL.
+		 */
+		uint64_t revlink_index:11;
+		/* The POW entry attached to the core. */
+		uint64_t index:11;
+		/*
+		 * The group attached to the core (updated when new
+		 * tag list entered on SWTAG_FULL).
+		 */
+		uint64_t grp:4;
+		/*
+		 * The wqp attached to the core (updated when new tag
+		 * list entered on SWTAG_FULL).
+		 */
+		uint64_t wqp:36;
+	} s_sstatus5;
+
+    /**
+     * Result For POW Memory Load (get_des == 0 and get_wqp == 0)
+     */
+	struct {
+		uint64_t reserved_51_63:13;
+		/*
+		 * The next entry in the input, free, descheduled_head
+		 * list (unpredictable if entry is the tail of the
+		 * list).
+		 */
+		uint64_t next_index:11;
+		/* The group of the POW entry. */
+		uint64_t grp:4;
+		uint64_t reserved_35:1;
+		/*
+		 * Set when this POW entry is at the tail of its tag
+		 * list (also set when in the NULL or NULL_NULL
+		 * state).
+		 */
+		uint64_t tail:1;
+		/* The tag type of the POW entry. */
+		uint64_t tag_type:2;
+		/* The tag of the POW entry. */
+		uint64_t tag:32;
+	} s_smemload0;
+
+    /**
+     * Result For POW Memory Load (get_des == 0 and get_wqp == 1)
+     */
+	struct {
+		uint64_t reserved_51_63:13;
+		/*
+		 * The next entry in the input, free, descheduled_head
+		 * list (unpredictable if entry is the tail of the
+		 * list).
+		 */
+		uint64_t next_index:11;
+		/* The group of the POW entry. */
+		uint64_t grp:4;
+		/* The WQP held in the POW entry. */
+		uint64_t wqp:36;
+	} s_smemload1;
+
+    /**
+     * Result For POW Memory Load (get_des == 1)
+     */
+	struct {
+		uint64_t reserved_51_63:13;
+		/*
+		 * The next entry in the tag list connected to the
+		 * descheduled head.
+		 */
+		uint64_t fwd_index:11;
+		/* The group of the POW entry. */
+		uint64_t grp:4;
+		/* The nosched bit for the POW entry. */
+		uint64_t nosched:1;
+		/* There is a pending tag switch */
+		uint64_t pend_switch:1;
+		/*
+		 * The next tag type for the new tag list when
+		 * pend_switch is set.
+		 */
+		uint64_t pend_type:2;
+		/*
+		 * The next tag for the new tag list when pend_switch
+		 * is set.
+		 */
+		uint64_t pend_tag:32;
+	} s_smemload2;
+
+    /**
+     * Result For POW Index/Pointer Load (get_rmt == 0/get_des_get_tail == 0)
+     */
+	struct {
+		uint64_t reserved_52_63:12;
+		/*
+		 * set when there is one or more POW entries on the
+		 * free list.
+		 */
+		uint64_t free_val:1;
+		/*
+		 * set when there is exactly one POW entry on the free
+		 * list.
+		 */
+		uint64_t free_one:1;
+		uint64_t reserved_49:1;
+		/*
+		 * when free_val is set, indicates the first entry on
+		 * the free list.
+		 */
+		uint64_t free_head:11;
+		uint64_t reserved_37:1;
+		/*
+		 * when free_val is set, indicates the last entry on
+		 * the free list.
+		 */
+		uint64_t free_tail:11;
+		/*
+		 * set when there is one or more POW entries on the
+		 * input Q list selected by qosgrp.
+		 */
+		uint64_t loc_val:1;
+		/*
+		 * set when there is exactly one POW entry on the
+		 * input Q list selected by qosgrp.
+		 */
+		uint64_t loc_one:1;
+		uint64_t reserved_23:1;
+		/*
+		 * when loc_val is set, indicates the first entry on
+		 * the input Q list selected by qosgrp.
+		 */
+		uint64_t loc_head:11;
+		uint64_t reserved_11:1;
+		/*
+		 * when loc_val is set, indicates the last entry on
+		 * the input Q list selected by qosgrp.
+		 */
+		uint64_t loc_tail:11;
+	} sindexload0;
+
+    /**
+     * Result For POW Index/Pointer Load (get_rmt == 0/get_des_get_tail == 1)
+     */
+	struct {
+		uint64_t reserved_52_63:12;
+		/*
+		 * set when there is one or more POW entries on the
+		 * nosched list.
+		 */
+		uint64_t nosched_val:1;
+		/*
+		 * set when there is exactly one POW entry on the
+		 * nosched list.
+		 */
+		uint64_t nosched_one:1;
+		uint64_t reserved_49:1;
+		/*
+		 * when nosched_val is set, indicates the first entry
+		 * on the nosched list.
+		 */
+		uint64_t nosched_head:11;
+		uint64_t reserved_37:1;
+		/*
+		 * when nosched_val is set, indicates the last entry
+		 * on the nosched list.
+		 */
+		uint64_t nosched_tail:11;
+		/*
+		 * set when there is one or more descheduled heads on
+		 * the descheduled list selected by qosgrp.
+		 */
+		uint64_t des_val:1;
+		/*
+		 * set when there is exactly one descheduled head on
+		 * the descheduled list selected by qosgrp.
+		 */
+		uint64_t des_one:1;
+		uint64_t reserved_23:1;
+		/*
+		 * when des_val is set, indicates the first
+		 * descheduled head on the descheduled list selected
+		 * by qosgrp.
+		 */
+		uint64_t des_head:11;
+		uint64_t reserved_11:1;
+		/*
+		 * when des_val is set, indicates the last descheduled
+		 * head on the descheduled list selected by qosgrp.
+		 */
+		uint64_t des_tail:11;
+	} sindexload1;
+
+    /**
+     * Result For POW Index/Pointer Load (get_rmt == 1/get_des_get_tail == 0)
+     */
+	struct {
+		uint64_t reserved_39_63:25;
+		/*
+		 * Set when this DRAM list is the current head
+		 * (i.e. is the next to be reloaded when the POW
+		 * hardware reloads a POW entry from DRAM). The POW
+		 * hardware alternates between the two DRAM lists
+		 * associated with a QOS level when it reloads work
+		 * from DRAM into the POW unit.
+		 */
+		uint64_t rmt_is_head:1;
+		/*
+		 * Set when the DRAM portion of the input Q list
+		 * selected by qosgrp contains one or more pieces of
+		 * work.
+		 */
+		uint64_t rmt_val:1;
+		/*
+		 * Set when the DRAM portion of the input Q list
+		 * selected by qosgrp contains exactly one piece of
+		 * work.
+		 */
+		uint64_t rmt_one:1;
+		/*
+		 * When rmt_val is set, indicates the first piece of
+		 * work on the DRAM input Q list selected by
+		 * qosgrp.
+		 */
+		uint64_t rmt_head:36;
+	} sindexload2;
+
+    /**
+     * Result For POW Index/Pointer Load (get_rmt ==
+     * 1/get_des_get_tail == 1)
+     */
+	struct {
+		uint64_t reserved_39_63:25;
+		/*
+		 * set when this DRAM list is the current head
+		 * (i.e. is the next to be reloaded when the POW
+		 * hardware reloads a POW entry from DRAM). The POW
+		 * hardware alternates between the two DRAM lists
+		 * associated with a QOS level when it reloads work
+		 * from DRAM into the POW unit.
+		 */
+		uint64_t rmt_is_head:1;
+		/*
+		 * set when the DRAM portion of the input Q list
+		 * selected by qosgrp contains one or more pieces of
+		 * work.
+		 */
+		uint64_t rmt_val:1;
+		/*
+		 * set when the DRAM portion of the input Q list
+		 * selected by qosgrp contains exactly one piece of
+		 * work.
+		 */
+		uint64_t rmt_one:1;
+		/*
+		 * when rmt_val is set, indicates the last piece of
+		 * work on the DRAM input Q list selected by
+		 * qosgrp.
+		 */
+		uint64_t rmt_tail:36;
+	} sindexload3;
+
+    /**
+     * Response to NULL_RD request loads
+     */
+	struct {
+		uint64_t unused:62;
+		/* of type cvmx_pow_tag_type_t. state is one of the
+		 * following:
+		 *
+		 * - CVMX_POW_TAG_TYPE_ORDERED
+		 * - CVMX_POW_TAG_TYPE_ATOMIC
+		 * - CVMX_POW_TAG_TYPE_NULL
+		 * - CVMX_POW_TAG_TYPE_NULL_NULL
+		 */
+		uint64_t state:2;
+	} s_null_rd;
+
+} cvmx_pow_tag_load_resp_t;
+
+/**
+ * This structure describes the address used for stores to the POW.
+ *  The store address is meaningful on stores to the POW.  The
+ *  hardware assumes that an aligned 64-bit store was used for all
+ *  these stores.  Note the assumption that the work queue entry is
+ *  aligned on an 8-byte boundary (since the low-order 3 address bits
+ *  must be zero).  Note that not all fields are used by all
+ *  operations.
+ *
+ *  NOTE: The following is the behavior of the pending switch bit at the PP
+ *       for POW stores (i.e. when did<7:3> == 0xc)
+ *     - did<2:0> == 0      => pending switch bit is set
+ *     - did<2:0> == 1      => no affect on the pending switch bit
+ *     - did<2:0> == 3      => pending switch bit is cleared
+ *     - did<2:0> == 7      => no affect on the pending switch bit
+ *     - did<2:0> == others => must not be used
+ *     - No other loads/stores have an affect on the pending switch bit
+ *     - The switch bus from POW can clear the pending switch bit
+ *
+ *  NOTE: did<2:0> == 2 is used by the HW for a special single-cycle
+ *  ADDWQ command that only contains the pointer). SW must never use
+ *  did<2:0> == 2.
+ */
+typedef union {
+    /**
+     * Unsigned 64 bit integer representation of store address
+     */
+	uint64_t u64;
+
+	struct {
+		/* Memory region.  Should be CVMX_IO_SEG in most cases */
+		uint64_t mem_reg:2;
+		uint64_t reserved_49_61:13;	/* Must be zero */
+		uint64_t is_io:1;	/* Must be one */
+		/* Device ID of POW.  Note that different sub-dids are used. */
+		uint64_t did:8;
+		uint64_t reserved_36_39:4;	/* Must be zero */
+		/* Address field. addr<2:0> must be zero */
+		uint64_t addr:36;
+	} stag;
+} cvmx_pow_tag_store_addr_t;
+
+/**
+ * decode of the store data when an IOBDMA SENDSINGLE is sent to POW
+ */
+typedef union {
+	uint64_t u64;
+
+	struct {
+		/*
+		 * the (64-bit word) location in scratchpad to write
+		 * to (if len != 0)
+		 */
+		uint64_t scraddr:8;
+		/* the number of words in the response (0 => no response) */
+		uint64_t len:8;
+		/* the ID of the device on the non-coherent bus */
+		uint64_t did:8;
+		uint64_t unused:36;
+		/* if set, don't return load response until work is available */
+		uint64_t wait:1;
+		uint64_t unused2:3;
+	} s;
+
+} cvmx_pow_iobdma_store_t;
+
+/* CSR typedefs have been moved to cvmx-csr-*.h */
+
+/**
+ * Get the POW tag for this core. This returns the current
+ * tag type, tag, group, and POW entry index associated with
+ * this core. Index is only valid if the tag type isn't NULL_NULL.
+ * If a tag switch is pending this routine returns the tag before
+ * the tag switch, not after.
+ *
+ * Returns Current tag
+ */
+static inline cvmx_pow_tag_req_t cvmx_pow_get_current_tag(void)
+{
+	cvmx_pow_load_addr_t load_addr;
+	cvmx_pow_tag_load_resp_t load_resp;
+	cvmx_pow_tag_req_t result;
+
+	load_addr.u64 = 0;
+	load_addr.sstatus.mem_region = CVMX_IO_SEG;
+	load_addr.sstatus.is_io = 1;
+	load_addr.sstatus.did = CVMX_OCT_DID_TAG_TAG1;
+	load_addr.sstatus.coreid = cvmx_get_core_num();
+	load_addr.sstatus.get_cur = 1;
+	load_resp.u64 = cvmx_read_csr(load_addr.u64);
+	result.u64 = 0;
+	result.s.grp = load_resp.s_sstatus2.grp;
+	result.s.index = load_resp.s_sstatus2.index;
+	result.s.type = load_resp.s_sstatus2.tag_type;
+	result.s.tag = load_resp.s_sstatus2.tag;
+	return result;
+}
+
+/**
+ * Get the POW WQE for this core. This returns the work queue
+ * entry currently associated with this core.
+ *
+ * Returns WQE pointer
+ */
+static inline cvmx_wqe_t *cvmx_pow_get_current_wqp(void)
+{
+	cvmx_pow_load_addr_t load_addr;
+	cvmx_pow_tag_load_resp_t load_resp;
+
+	load_addr.u64 = 0;
+	load_addr.sstatus.mem_region = CVMX_IO_SEG;
+	load_addr.sstatus.is_io = 1;
+	load_addr.sstatus.did = CVMX_OCT_DID_TAG_TAG1;
+	load_addr.sstatus.coreid = cvmx_get_core_num();
+	load_addr.sstatus.get_cur = 1;
+	load_addr.sstatus.get_wqp = 1;
+	load_resp.u64 = cvmx_read_csr(load_addr.u64);
+	return (cvmx_wqe_t *) cvmx_phys_to_ptr(load_resp.s_sstatus4.wqp);
+}
+
+#ifndef CVMX_MF_CHORD
+#define CVMX_MF_CHORD(dest)         CVMX_RDHWR(dest, 30)
+#endif
+
+/**
+ * Print a warning if a tag switch is pending for this core
+ *
+ * @function: Function name checking for a pending tag switch
+ */
+static inline void __cvmx_pow_warn_if_pending_switch(const char *function)
+{
+	uint64_t switch_complete;
+	CVMX_MF_CHORD(switch_complete);
+	if (!switch_complete)
+		pr_warning("%s called with tag switch in progress\n", function);
+}
+
+/**
+ * Waits for a tag switch to complete by polling the completion bit.
+ * Note that switches to NULL complete immediately and do not need
+ * to be waited for.
+ */
+static inline void cvmx_pow_tag_sw_wait(void)
+{
+	const uint64_t MAX_CYCLES = 1ull << 31;
+	uint64_t switch_complete;
+	uint64_t start_cycle = cvmx_get_cycle();
+	while (1) {
+		CVMX_MF_CHORD(switch_complete);
+		if (unlikely(switch_complete))
+			break;
+		if (unlikely(cvmx_get_cycle() > start_cycle + MAX_CYCLES)) {
+			pr_warning("Tag switch is taking a long time, "
+				   "possible deadlock\n");
+			start_cycle = -MAX_CYCLES - 1;
+		}
+	}
+}
+
+/**
+ * Synchronous work request.  Requests work from the POW.
+ * This function does NOT wait for previous tag switches to complete,
+ * so the caller must ensure that there is not a pending tag switch.
+ *
+ * @wait:   When set, call stalls until work becomes avaiable, or times out.
+ *               If not set, returns immediately.
+ *
+ * Returns Returns the WQE pointer from POW. Returns NULL if no work
+ * was available.
+ */
+static inline cvmx_wqe_t *cvmx_pow_work_request_sync_nocheck(cvmx_pow_wait_t
+							     wait)
+{
+	cvmx_pow_load_addr_t ptr;
+	cvmx_pow_tag_load_resp_t result;
+
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	ptr.u64 = 0;
+	ptr.swork.mem_region = CVMX_IO_SEG;
+	ptr.swork.is_io = 1;
+	ptr.swork.did = CVMX_OCT_DID_TAG_SWTAG;
+	ptr.swork.wait = wait;
+
+	result.u64 = cvmx_read_csr(ptr.u64);
+
+	if (result.s_work.no_work)
+		return NULL;
+	else
+		return (cvmx_wqe_t *) cvmx_phys_to_ptr(result.s_work.addr);
+}
+
+/**
+ * Synchronous work request.  Requests work from the POW.
+ * This function waits for any previous tag switch to complete before
+ * requesting the new work.
+ *
+ * @wait:   When set, call stalls until work becomes avaiable, or times out.
+ *               If not set, returns immediately.
+ *
+ * Returns Returns the WQE pointer from POW. Returns NULL if no work
+ * was available.
+ */
+static inline cvmx_wqe_t *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+{
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	/* Must not have a switch pending when requesting work */
+	cvmx_pow_tag_sw_wait();
+	return cvmx_pow_work_request_sync_nocheck(wait);
+
+}
+
+/**
+ * Synchronous null_rd request.  Requests a switch out of NULL_NULL POW state.
+ * This function waits for any previous tag switch to complete before
+ * requesting the null_rd.
+ *
+ * Returns Returns the POW state of type cvmx_pow_tag_type_t.
+ */
+static inline enum cvmx_pow_tag_type cvmx_pow_work_request_null_rd(void)
+{
+	cvmx_pow_load_addr_t ptr;
+	cvmx_pow_tag_load_resp_t result;
+
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	/* Must not have a switch pending when requesting work */
+	cvmx_pow_tag_sw_wait();
+
+	ptr.u64 = 0;
+	ptr.snull_rd.mem_region = CVMX_IO_SEG;
+	ptr.snull_rd.is_io = 1;
+	ptr.snull_rd.did = CVMX_OCT_DID_TAG_NULL_RD;
+
+	result.u64 = cvmx_read_csr(ptr.u64);
+
+	return (enum cvmx_pow_tag_type) result.s_null_rd.state;
+}
+
+/**
+ * Asynchronous work request.  Work is requested from the POW unit,
+ * and should later be checked with function
+ * cvmx_pow_work_response_async.  This function does NOT wait for
+ * previous tag switches to complete, so the caller must ensure that
+ * there is not a pending tag switch.
+ *
+ * @scr_addr: Scratch memory address that response will be returned
+ *            to, which is either a valid WQE, or a response with the
+ *            invalid bit set.  Byte address, must be 8 byte aligned.
+ *
+ * @wait: 1 to cause response to wait for work to become available (or
+ *        timeout), 0 to cause response to return immediately
+ */
+static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
+						       cvmx_pow_wait_t wait)
+{
+	cvmx_pow_iobdma_store_t data;
+
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	/* scr_addr must be 8 byte aligned */
+	data.s.scraddr = scr_addr >> 3;
+	data.s.len = 1;
+	data.s.did = CVMX_OCT_DID_TAG_SWTAG;
+	data.s.wait = wait;
+	cvmx_send_single(data.u64);
+}
+
+/**
+ * Asynchronous work request.  Work is requested from the POW unit,
+ * and should later be checked with function
+ * cvmx_pow_work_response_async.  This function waits for any previous
+ * tag switch to complete before requesting the new work.
+ *
+ * @scr_addr: Scratch memory address that response will be returned
+ *            to, which is either a valid WQE, or a response with the
+ *            invalid bit set.  Byte address, must be 8 byte aligned.
+ *
+ * @wait: 1 to cause response to wait for work to become available (or
+ *                  timeout), 0 to cause response to return immediately
+ */
+static inline void cvmx_pow_work_request_async(int scr_addr,
+					       cvmx_pow_wait_t wait)
+{
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	/* Must not have a switch pending when requesting work */
+	cvmx_pow_tag_sw_wait();
+	cvmx_pow_work_request_async_nocheck(scr_addr, wait);
+}
+
+/**
+ * Gets result of asynchronous work request.  Performs a IOBDMA sync
+ * to wait for the response.
+ *
+ * @scr_addr: Scratch memory address to get result from Byte address,
+ *            must be 8 byte aligned.
+ *
+ * Returns Returns the WQE from the scratch register, or NULL if no
+ * work was available.
+ */
+static inline cvmx_wqe_t *cvmx_pow_work_response_async(int scr_addr)
+{
+	cvmx_pow_tag_load_resp_t result;
+
+	CVMX_SYNCIOBDMA;
+	result.u64 = cvmx_scratch_read64(scr_addr);
+
+	if (result.s_work.no_work)
+		return NULL;
+	else
+		return (cvmx_wqe_t *) cvmx_phys_to_ptr(result.s_work.addr);
+}
+
+/**
+ * Checks if a work queue entry pointer returned by a work
+ * request is valid.  It may be invalid due to no work
+ * being available or due to a timeout.
+ *
+ * @wqe_ptr: pointer to a work queue entry returned by the POW
+ *
+ * Returns 0 if pointer is valid
+ *         1 if invalid (no work was returned)
+ */
+static inline uint64_t cvmx_pow_work_invalid(cvmx_wqe_t *wqe_ptr)
+{
+	return wqe_ptr == NULL;
+}
+
+/**
+ * Starts a tag switch to the provided tag value and tag type.
+ * Completion for the tag switch must be checked for separately.  This
+ * function does NOT update the work queue entry in dram to match tag
+ * value and type, so the application must keep track of these if they
+ * are important to the application.  This tag switch command must not
+ * be used for switches to NULL, as the tag switch pending bit will be
+ * set by the switch request, but never cleared by the hardware.
+ *
+ * NOTE: This should not be used when switching from a NULL tag.  Use
+ * cvmx_pow_tag_sw_full() instead.
+ *
+ * This function does no checks, so the caller must ensure that any
+ * previous tag switch has completed.
+ *
+ * @tag:      new tag value
+ * @tag_type: new tag type (ordered or atomic)
+ */
+static inline void cvmx_pow_tag_sw_nocheck(uint32_t tag,
+					   enum cvmx_pow_tag_type tag_type)
+{
+	cvmx_addr_t ptr;
+	cvmx_pow_tag_req_t tag_req;
+
+	if (CVMX_ENABLE_POW_CHECKS) {
+		cvmx_pow_tag_req_t current_tag;
+		__cvmx_pow_warn_if_pending_switch(__func__);
+		current_tag = cvmx_pow_get_current_tag();
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL_NULL)
+			pr_warning("%s called with NULL_NULL tag\n",
+				   __func__);
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL)
+			pr_warning("%s called with NULL tag\n", __func__);
+		if ((current_tag.s.type == tag_type)
+		   && (current_tag.s.tag == tag))
+			pr_warning("%s called to perform a tag switch to the "
+				   "same tag\n",
+			     __func__);
+		if (tag_type == CVMX_POW_TAG_TYPE_NULL)
+			pr_warning("%s called to perform a tag switch to "
+				   "NULL. Use cvmx_pow_tag_sw_null() instead\n",
+			     __func__);
+	}
+
+	/*
+	 * Note that WQE in DRAM is not updated here, as the POW does
+	 * not read from DRAM once the WQE is in flight.  See hardware
+	 * manual for complete details.  It is the application's
+	 * responsibility to keep track of the current tag value if
+	 * that is important.
+	 */
+
+	tag_req.u64 = 0;
+	tag_req.s.op = CVMX_POW_TAG_OP_SWTAG;
+	tag_req.s.tag = tag;
+	tag_req.s.type = tag_type;
+
+	ptr.u64 = 0;
+	ptr.sio.mem_region = CVMX_IO_SEG;
+	ptr.sio.is_io = 1;
+	ptr.sio.did = CVMX_OCT_DID_TAG_SWTAG;
+
+	/* once this store arrives at POW, it will attempt the switch
+	   software must wait for the switch to complete separately */
+	cvmx_write_io(ptr.u64, tag_req.u64);
+}
+
+/**
+ * Starts a tag switch to the provided tag value and tag type.
+ * Completion for the tag switch must be checked for separately.  This
+ * function does NOT update the work queue entry in dram to match tag
+ * value and type, so the application must keep track of these if they
+ * are important to the application.  This tag switch command must not
+ * be used for switches to NULL, as the tag switch pending bit will be
+ * set by the switch request, but never cleared by the hardware.
+ *
+ * NOTE: This should not be used when switching from a NULL tag.  Use
+ * cvmx_pow_tag_sw_full() instead.
+ *
+ * This function waits for any previous tag switch to complete, and also
+ * displays an error on tag switches to NULL.
+ *
+ * @tag:      new tag value
+ * @tag_type: new tag type (ordered or atomic)
+ */
+static inline void cvmx_pow_tag_sw(uint32_t tag,
+				   enum cvmx_pow_tag_type tag_type)
+{
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	/*
+	 * Note that WQE in DRAM is not updated here, as the POW does
+	 * not read from DRAM once the WQE is in flight.  See hardware
+	 * manual for complete details.  It is the application's
+	 * responsibility to keep track of the current tag value if
+	 * that is important.
+	 */
+
+	/*
+	 * Ensure that there is not a pending tag switch, as a tag
+	 * switch cannot be started if a previous switch is still
+	 * pending.
+	 */
+	cvmx_pow_tag_sw_wait();
+	cvmx_pow_tag_sw_nocheck(tag, tag_type);
+}
+
+/**
+ * Starts a tag switch to the provided tag value and tag type.
+ * Completion for the tag switch must be checked for separately.  This
+ * function does NOT update the work queue entry in dram to match tag
+ * value and type, so the application must keep track of these if they
+ * are important to the application.  This tag switch command must not
+ * be used for switches to NULL, as the tag switch pending bit will be
+ * set by the switch request, but never cleared by the hardware.
+ *
+ * This function must be used for tag switches from NULL.
+ *
+ * This function does no checks, so the caller must ensure that any
+ * previous tag switch has completed.
+ *
+ * @wqp:      pointer to work queue entry to submit.  This entry is
+ *            updated to match the other parameters
+ * @tag:      tag value to be assigned to work queue entry
+ * @tag_type: type of tag
+ * @group:    group value for the work queue entry.
+ */
+static inline void cvmx_pow_tag_sw_full_nocheck(cvmx_wqe_t *wqp, uint32_t tag,
+						enum cvmx_pow_tag_type tag_type,
+						uint64_t group)
+{
+	cvmx_addr_t ptr;
+	cvmx_pow_tag_req_t tag_req;
+
+	if (CVMX_ENABLE_POW_CHECKS) {
+		cvmx_pow_tag_req_t current_tag;
+		__cvmx_pow_warn_if_pending_switch(__func__);
+		current_tag = cvmx_pow_get_current_tag();
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL_NULL)
+			pr_warning("%s called with NULL_NULL tag\n",
+				   __func__);
+		if ((current_tag.s.type == tag_type)
+		   && (current_tag.s.tag == tag))
+			pr_warning("%s called to perform a tag switch to "
+				   "the same tag\n",
+			     __func__);
+		if (tag_type == CVMX_POW_TAG_TYPE_NULL)
+			pr_warning("%s called to perform a tag switch to "
+				   "NULL. Use cvmx_pow_tag_sw_null() instead\n",
+			     __func__);
+		if (wqp != cvmx_phys_to_ptr(0x80))
+			if (wqp != cvmx_pow_get_current_wqp())
+				pr_warning("%s passed WQE(%p) doesn't match "
+					   "the address in the POW(%p)\n",
+				     __func__, wqp,
+				     cvmx_pow_get_current_wqp());
+	}
+
+	/*
+	 * Note that WQE in DRAM is not updated here, as the POW does
+	 * not read from DRAM once the WQE is in flight.  See hardware
+	 * manual for complete details.  It is the application's
+	 * responsibility to keep track of the current tag value if
+	 * that is important.
+	 */
+
+	tag_req.u64 = 0;
+	tag_req.s.op = CVMX_POW_TAG_OP_SWTAG_FULL;
+	tag_req.s.tag = tag;
+	tag_req.s.type = tag_type;
+	tag_req.s.grp = group;
+
+	ptr.u64 = 0;
+	ptr.sio.mem_region = CVMX_IO_SEG;
+	ptr.sio.is_io = 1;
+	ptr.sio.did = CVMX_OCT_DID_TAG_SWTAG;
+	ptr.sio.offset = CAST64(wqp);
+
+	/*
+	 * once this store arrives at POW, it will attempt the switch
+	 * software must wait for the switch to complete separately.
+	 */
+	cvmx_write_io(ptr.u64, tag_req.u64);
+}
+
+/**
+ * Starts a tag switch to the provided tag value and tag type.
+ * Completion for the tag switch must be checked for separately.  This
+ * function does NOT update the work queue entry in dram to match tag
+ * value and type, so the application must keep track of these if they
+ * are important to the application.  This tag switch command must not
+ * be used for switches to NULL, as the tag switch pending bit will be
+ * set by the switch request, but never cleared by the hardware.
+ *
+ * This function must be used for tag switches from NULL.
+ *
+ * This function waits for any pending tag switches to complete
+ * before requesting the tag switch.
+ *
+ * @wqp:      pointer to work queue entry to submit.  This entry is updated
+ *            to match the other parameters
+ * @tag:      tag value to be assigned to work queue entry
+ * @tag_type: type of tag
+ * @group:      group value for the work queue entry.
+ */
+static inline void cvmx_pow_tag_sw_full(cvmx_wqe_t *wqp, uint32_t tag,
+					enum cvmx_pow_tag_type tag_type,
+					uint64_t group)
+{
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	/*
+	 * Ensure that there is not a pending tag switch, as a tag
+	 * switch cannot be started if a previous switch is still
+	 * pending.
+	 */
+	cvmx_pow_tag_sw_wait();
+	cvmx_pow_tag_sw_full_nocheck(wqp, tag, tag_type, group);
+}
+
+/**
+ * Switch to a NULL tag, which ends any ordering or
+ * synchronization provided by the POW for the current
+ * work queue entry.  This operation completes immediatly,
+ * so completetion should not be waited for.
+ * This function does NOT wait for previous tag switches to complete,
+ * so the caller must ensure that any previous tag switches have completed.
+ */
+static inline void cvmx_pow_tag_sw_null_nocheck(void)
+{
+	cvmx_addr_t ptr;
+	cvmx_pow_tag_req_t tag_req;
+
+	if (CVMX_ENABLE_POW_CHECKS) {
+		cvmx_pow_tag_req_t current_tag;
+		__cvmx_pow_warn_if_pending_switch(__func__);
+		current_tag = cvmx_pow_get_current_tag();
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL_NULL)
+			pr_warning("%s called with NULL_NULL tag\n",
+				   __func__);
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL)
+			pr_warning("%s called when we already have a "
+				   "NULL tag\n",
+			     __func__);
+	}
+
+	tag_req.u64 = 0;
+	tag_req.s.op = CVMX_POW_TAG_OP_SWTAG;
+	tag_req.s.type = CVMX_POW_TAG_TYPE_NULL;
+
+	ptr.u64 = 0;
+	ptr.sio.mem_region = CVMX_IO_SEG;
+	ptr.sio.is_io = 1;
+	ptr.sio.did = CVMX_OCT_DID_TAG_TAG1;
+
+	cvmx_write_io(ptr.u64, tag_req.u64);
+
+	/* switch to NULL completes immediately */
+}
+
+/**
+ * Switch to a NULL tag, which ends any ordering or
+ * synchronization provided by the POW for the current
+ * work queue entry.  This operation completes immediatly,
+ * so completetion should not be waited for.
+ * This function waits for any pending tag switches to complete
+ * before requesting the switch to NULL.
+ */
+static inline void cvmx_pow_tag_sw_null(void)
+{
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	/*
+	 * Ensure that there is not a pending tag switch, as a tag
+	 * switch cannot be started if a previous switch is still
+	 * pending.
+	 */
+	cvmx_pow_tag_sw_wait();
+	cvmx_pow_tag_sw_null_nocheck();
+
+	/* switch to NULL completes immediately */
+}
+
+/**
+ * Submits work to an input queue.  This function updates the work
+ * queue entry in DRAM to match the arguments given.  Note that the
+ * tag provided is for the work queue entry submitted, and is
+ * unrelated to the tag that the core currently holds.
+ *
+ * @wqp:      pointer to work queue entry to submit.  This entry is
+ *            updated to match the other parameters
+ * @tag:      tag value to be assigned to work queue entry
+ * @tag_type: type of tag
+ * @qos:      Input queue to add to.
+ * @grp:      group value for the work queue entry.
+ */
+static inline void cvmx_pow_work_submit(cvmx_wqe_t *wqp, uint32_t tag,
+					enum cvmx_pow_tag_type tag_type,
+					uint64_t qos, uint64_t grp)
+{
+	cvmx_addr_t ptr;
+	cvmx_pow_tag_req_t tag_req;
+
+	wqp->qos = qos;
+	wqp->tag = tag;
+	wqp->tag_type = tag_type;
+	wqp->grp = grp;
+
+	tag_req.u64 = 0;
+	tag_req.s.op = CVMX_POW_TAG_OP_ADDWQ;
+	tag_req.s.type = tag_type;
+	tag_req.s.tag = tag;
+	tag_req.s.qos = qos;
+	tag_req.s.grp = grp;
+
+	ptr.u64 = 0;
+	ptr.sio.mem_region = CVMX_IO_SEG;
+	ptr.sio.is_io = 1;
+	ptr.sio.did = CVMX_OCT_DID_TAG_TAG1;
+	ptr.sio.offset = cvmx_ptr_to_phys(wqp);
+
+	/*
+	 * SYNC write to memory before the work submit.  This is
+	 * necessary as POW may read values from DRAM at this time.
+	 */
+	CVMX_SYNCWS;
+	cvmx_write_io(ptr.u64, tag_req.u64);
+}
+
+/**
+ * This function sets the group mask for a core.  The group mask
+ * indicates which groups each core will accept work from. There are
+ * 16 groups.
+ *
+ * @core_num:   core to apply mask to
+ * @mask:   Group mask. There are 16 groups, so only bits 0-15 are valid,
+ *               representing groups 0-15.
+ *               Each 1 bit in the mask enables the core to accept work from
+ *               the corresponding group.
+ */
+static inline void cvmx_pow_set_group_mask(uint64_t core_num, uint64_t mask)
+{
+	union cvmx_pow_pp_grp_mskx grp_msk;
+
+	grp_msk.u64 = cvmx_read_csr(CVMX_POW_PP_GRP_MSKX(core_num));
+	grp_msk.s.grp_msk = mask;
+	cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(core_num), grp_msk.u64);
+}
+
+/**
+ * This function sets POW static priorities for a core. Each input queue has
+ * an associated priority value.
+ *
+ * @core_num:   core to apply priorities to
+ * @priority:   Vector of 8 priorities, one per POW Input Queue (0-7).
+ *                   Highest priority is 0 and lowest is 7. A priority value
+ *                   of 0xF instructs POW to skip the Input Queue when
+ *                   scheduling to this specific core.
+ *                   NOTE: priorities should not have gaps in values, meaning
+ *                         {0,1,1,1,1,1,1,1} is a valid configuration while
+ *                         {0,2,2,2,2,2,2,2} is not.
+ */
+static inline void cvmx_pow_set_priority(uint64_t core_num,
+					 const uint8_t priority[])
+{
+	/* POW priorities are supported on CN5xxx and later */
+	if (!OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+		union cvmx_pow_pp_grp_mskx grp_msk;
+
+		grp_msk.u64 = cvmx_read_csr(CVMX_POW_PP_GRP_MSKX(core_num));
+		grp_msk.s.qos0_pri = priority[0];
+		grp_msk.s.qos1_pri = priority[1];
+		grp_msk.s.qos2_pri = priority[2];
+		grp_msk.s.qos3_pri = priority[3];
+		grp_msk.s.qos4_pri = priority[4];
+		grp_msk.s.qos5_pri = priority[5];
+		grp_msk.s.qos6_pri = priority[6];
+		grp_msk.s.qos7_pri = priority[7];
+
+		/* Detect gaps between priorities and flag error */
+		{
+			int i;
+			uint32_t prio_mask = 0;
+
+			for (i = 0; i < 8; i++)
+				if (priority[i] != 0xF)
+					prio_mask |= 1 << priority[i];
+
+			if (prio_mask ^ ((1 << cvmx_pop(prio_mask)) - 1)) {
+				pr_err("POW static priorities should be "
+				       "contiguous (0x%llx)\n",
+				     (unsigned long long)prio_mask);
+				return;
+			}
+		}
+
+		cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(core_num), grp_msk.u64);
+	}
+}
+
+/**
+ * Performs a tag switch and then an immediate deschedule. This completes
+ * immediatly, so completion must not be waited for.  This function does NOT
+ * update the wqe in DRAM to match arguments.
+ *
+ * This function does NOT wait for any prior tag switches to complete, so the
+ * calling code must do this.
+ *
+ * Note the following CAVEAT of the Octeon HW behavior when
+ * re-scheduling DE-SCHEDULEd items whose (next) state is
+ * ORDERED:
+ *   - If there are no switches pending at the time that the
+ *     HW executes the de-schedule, the HW will only re-schedule
+ *     the head of the FIFO associated with the given tag. This
+ *     means that in many respects, the HW treats this ORDERED
+ *     tag as an ATOMIC tag. Note that in the SWTAG_DESCH
+ *     case (to an ORDERED tag), the HW will do the switch
+ *     before the deschedule whenever it is possible to do
+ *     the switch immediately, so it may often look like
+ *     this case.
+ *   - If there is a pending switch to ORDERED at the time
+ *     the HW executes the de-schedule, the HW will perform
+ *     the switch at the time it re-schedules, and will be
+ *     able to reschedule any/all of the entries with the
+ *     same tag.
+ * Due to this behavior, the RECOMMENDATION to software is
+ * that they have a (next) state of ATOMIC when they
+ * DE-SCHEDULE. If an ORDERED tag is what was really desired,
+ * SW can choose to immediately switch to an ORDERED tag
+ * after the work (that has an ATOMIC tag) is re-scheduled.
+ * Note that since there are never any tag switches pending
+ * when the HW re-schedules, this switch can be IMMEDIATE upon
+ * the reception of the pointer during the re-schedule.
+ *
+ * @tag:      New tag value
+ * @tag_type: New tag type
+ * @group:    New group value
+ * @no_sched: Control whether this work queue entry will be rescheduled.
+ *                 - 1 : don't schedule this work
+ *                 - 0 : allow this work to be scheduled.
+ */
+static inline void cvmx_pow_tag_sw_desched_nocheck(
+	uint32_t tag,
+	enum cvmx_pow_tag_type tag_type,
+	uint64_t group,
+	uint64_t no_sched)
+{
+	cvmx_addr_t ptr;
+	cvmx_pow_tag_req_t tag_req;
+
+	if (CVMX_ENABLE_POW_CHECKS) {
+		cvmx_pow_tag_req_t current_tag;
+		__cvmx_pow_warn_if_pending_switch(__func__);
+		current_tag = cvmx_pow_get_current_tag();
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL_NULL)
+			pr_warning("%s called with NULL_NULL tag\n",
+				   __func__);
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL)
+			pr_warning("%s called with NULL tag. Deschedule not "
+				   "allowed from NULL state\n",
+			     __func__);
+		if ((current_tag.s.type != CVMX_POW_TAG_TYPE_ATOMIC)
+			&& (tag_type != CVMX_POW_TAG_TYPE_ATOMIC))
+			pr_warning("%s called where neither the before or "
+				   "after tag is ATOMIC\n",
+			     __func__);
+	}
+
+	tag_req.u64 = 0;
+	tag_req.s.op = CVMX_POW_TAG_OP_SWTAG_DESCH;
+	tag_req.s.tag = tag;
+	tag_req.s.type = tag_type;
+	tag_req.s.grp = group;
+	tag_req.s.no_sched = no_sched;
+
+	ptr.u64 = 0;
+	ptr.sio.mem_region = CVMX_IO_SEG;
+	ptr.sio.is_io = 1;
+	ptr.sio.did = CVMX_OCT_DID_TAG_TAG3;
+	/*
+	 * since TAG3 is used, this store will clear the local pending
+	 * switch bit.
+	 */
+	cvmx_write_io(ptr.u64, tag_req.u64);
+}
+
+/**
+ * Performs a tag switch and then an immediate deschedule. This completes
+ * immediatly, so completion must not be waited for.  This function does NOT
+ * update the wqe in DRAM to match arguments.
+ *
+ * This function waits for any prior tag switches to complete, so the
+ * calling code may call this function with a pending tag switch.
+ *
+ * Note the following CAVEAT of the Octeon HW behavior when
+ * re-scheduling DE-SCHEDULEd items whose (next) state is
+ * ORDERED:
+ *   - If there are no switches pending at the time that the
+ *     HW executes the de-schedule, the HW will only re-schedule
+ *     the head of the FIFO associated with the given tag. This
+ *     means that in many respects, the HW treats this ORDERED
+ *     tag as an ATOMIC tag. Note that in the SWTAG_DESCH
+ *     case (to an ORDERED tag), the HW will do the switch
+ *     before the deschedule whenever it is possible to do
+ *     the switch immediately, so it may often look like
+ *     this case.
+ *   - If there is a pending switch to ORDERED at the time
+ *     the HW executes the de-schedule, the HW will perform
+ *     the switch at the time it re-schedules, and will be
+ *     able to reschedule any/all of the entries with the
+ *     same tag.
+ * Due to this behavior, the RECOMMENDATION to software is
+ * that they have a (next) state of ATOMIC when they
+ * DE-SCHEDULE. If an ORDERED tag is what was really desired,
+ * SW can choose to immediately switch to an ORDERED tag
+ * after the work (that has an ATOMIC tag) is re-scheduled.
+ * Note that since there are never any tag switches pending
+ * when the HW re-schedules, this switch can be IMMEDIATE upon
+ * the reception of the pointer during the re-schedule.
+ *
+ * @tag:      New tag value
+ * @tag_type: New tag type
+ * @group:    New group value
+ * @no_sched: Control whether this work queue entry will be rescheduled.
+ *                 - 1 : don't schedule this work
+ *                 - 0 : allow this work to be scheduled.
+ */
+static inline void cvmx_pow_tag_sw_desched(uint32_t tag,
+					   enum cvmx_pow_tag_type tag_type,
+					   uint64_t group, uint64_t no_sched)
+{
+	if (CVMX_ENABLE_POW_CHECKS)
+		__cvmx_pow_warn_if_pending_switch(__func__);
+
+	/* Need to make sure any writes to the work queue entry are complete */
+	CVMX_SYNCWS;
+	/*
+	 * Ensure that there is not a pending tag switch, as a tag
+	 * switch cannot be started if a previous switch is still
+	 * pending.
+	 */
+	cvmx_pow_tag_sw_wait();
+	cvmx_pow_tag_sw_desched_nocheck(tag, tag_type, group, no_sched);
+}
+
+/**
+ * Descchedules the current work queue entry.
+ *
+ * @no_sched: no schedule flag value to be set on the work queue
+ *            entry.  If this is set the entry will not be
+ *            rescheduled.
+ */
+static inline void cvmx_pow_desched(uint64_t no_sched)
+{
+	cvmx_addr_t ptr;
+	cvmx_pow_tag_req_t tag_req;
+
+	if (CVMX_ENABLE_POW_CHECKS) {
+		cvmx_pow_tag_req_t current_tag;
+		__cvmx_pow_warn_if_pending_switch(__func__);
+		current_tag = cvmx_pow_get_current_tag();
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL_NULL)
+			pr_warning("%s called with NULL_NULL tag\n",
+				   __func__);
+		if (current_tag.s.type == CVMX_POW_TAG_TYPE_NULL)
+			pr_warning("%s called with NULL tag. Deschedule not "
+				   "expected from NULL state\n",
+			     __func__);
+	}
+
+	/* Need to make sure any writes to the work queue entry are complete */
+	CVMX_SYNCWS;
+
+	tag_req.u64 = 0;
+	tag_req.s.op = CVMX_POW_TAG_OP_DESCH;
+	tag_req.s.no_sched = no_sched;
+
+	ptr.u64 = 0;
+	ptr.sio.mem_region = CVMX_IO_SEG;
+	ptr.sio.is_io = 1;
+	ptr.sio.did = CVMX_OCT_DID_TAG_TAG3;
+	/*
+	 * since TAG3 is used, this store will clear the local pending
+	 * switch bit.
+	 */
+	cvmx_write_io(ptr.u64, tag_req.u64);
+}
+
+/****************************************************
+* Define usage of bits within the 32 bit tag values.
+*****************************************************/
+
+/*
+ * Number of bits of the tag used by software.  The SW bits are always
+ * a contiguous block of the high starting at bit 31.  The hardware
+ * bits are always the low bits.  By default, the top 8 bits of the
+ * tag are reserved for software, and the low 24 are set by the IPD
+ * unit.
+ */
+#define CVMX_TAG_SW_BITS    (8)
+#define CVMX_TAG_SW_SHIFT   (32 - CVMX_TAG_SW_BITS)
+
+/* Below is the list of values for the top 8 bits of the tag. */
+/*
+ * Tag values with top byte of this value are reserved for internal
+ * executive uses.
+ */
+#define CVMX_TAG_SW_BITS_INTERNAL  0x1
+/* The executive divides the remaining 24 bits as follows:
+ *  - the upper 8 bits (bits 23 - 16 of the tag) define a subgroup
+ *
+ *  - the lower 16 bits (bits 15 - 0 of the tag) define are the value
+ *    with the subgroup
+ *
+ * Note that this section describes the format of tags generated by
+ * software - refer to the hardware documentation for a description of
+ * the tags values generated by the packet input hardware.  Subgroups
+ * are defined here.
+ */
+/* Mask for the value portion of the tag */
+#define CVMX_TAG_SUBGROUP_MASK  0xFFFF
+#define CVMX_TAG_SUBGROUP_SHIFT 16
+#define CVMX_TAG_SUBGROUP_PKO  0x1
+
+/* End of executive tag subgroup definitions */
+
+/*
+ * The remaining values software bit values 0x2 - 0xff are available
+ * for application use.
+ */
+
+/**
+ * This function creates a 32 bit tag value from the two values provided.
+ *
+ * @sw_bits: The upper bits (number depends on configuration) are set
+ *           to this value.  The remainder of bits are set by the
+ *           hw_bits parameter.
+ *
+ * @hw_bits: The lower bits (number depends on configuration) are set
+ *           to this value.  The remainder of bits are set by the
+ *           sw_bits parameter.
+ *
+ * Returns 32 bit value of the combined hw and sw bits.
+ */
+static inline uint32_t cvmx_pow_tag_compose(uint64_t sw_bits, uint64_t hw_bits)
+{
+	return ((sw_bits & cvmx_build_mask(CVMX_TAG_SW_BITS)) <<
+			CVMX_TAG_SW_SHIFT) |
+		(hw_bits & cvmx_build_mask(32 - CVMX_TAG_SW_BITS));
+}
+
+/**
+ * Extracts the bits allocated for software use from the tag
+ *
+ * @tag:    32 bit tag value
+ *
+ * Returns N bit software tag value, where N is configurable with the
+ * CVMX_TAG_SW_BITS define
+ */
+static inline uint32_t cvmx_pow_tag_get_sw_bits(uint64_t tag)
+{
+	return (tag >> (32 - CVMX_TAG_SW_BITS)) &
+		cvmx_build_mask(CVMX_TAG_SW_BITS);
+}
+
+/**
+ *
+ * Extracts the bits allocated for hardware use from the tag
+ *
+ * @tag:    32 bit tag value
+ *
+ * Returns (32 - N) bit software tag value, where N is configurable
+ * with the CVMX_TAG_SW_BITS define
+ */
+static inline uint32_t cvmx_pow_tag_get_hw_bits(uint64_t tag)
+{
+	return tag & cvmx_build_mask(32 - CVMX_TAG_SW_BITS);
+}
+
+/**
+ * Store the current POW internal state into the supplied
+ * buffer. It is recommended that you pass a buffer of at least
+ * 128KB. The format of the capture may change based on SDK
+ * version and Octeon chip.
+ *
+ * @buffer: Buffer to store capture into
+ * @buffer_size:
+ *               The size of the supplied buffer
+ *
+ * Returns Zero on sucess, negative on failure
+ */
+extern int cvmx_pow_capture(void *buffer, int buffer_size);
+
+/**
+ * Dump a POW capture to the console in a human readable format.
+ *
+ * @buffer: POW capture from cvmx_pow_capture()
+ * @buffer_size:
+ *               Size of the buffer
+ */
+extern void cvmx_pow_display(void *buffer, int buffer_size);
+
+/**
+ * Return the number of POW entries supported by this chip
+ *
+ * Returns Number of POW entries
+ */
+extern int cvmx_pow_get_num_entries(void);
+
+#endif /* __CVMX_POW_H__ */
diff --git a/drivers/staging/octeon/cvmx-scratch.h b/drivers/staging/octeon/cvmx-scratch.h
new file mode 100644
index 0000000..96b70cf
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-scratch.h
@@ -0,0 +1,139 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * This file provides support for the processor local scratch memory.
+ * Scratch memory is byte addressable - all addresses are byte addresses.
+ *
+ */
+
+#ifndef __CVMX_SCRATCH_H__
+#define __CVMX_SCRATCH_H__
+
+/*
+ * Note: This define must be a long, not a long long in order to
+ * compile without warnings for both 32bit and 64bit.
+ */
+#define CVMX_SCRATCH_BASE       (-32768l)	/* 0xffffffffffff8000 */
+
+/**
+ * Reads an 8 bit value from the processor local scratchpad memory.
+ *
+ * @address: byte address to read from
+ *
+ * Returns value read
+ */
+static inline uint8_t cvmx_scratch_read8(uint64_t address)
+{
+	return *CASTPTR(volatile uint8_t, CVMX_SCRATCH_BASE + address);
+}
+
+/**
+ * Reads a 16 bit value from the processor local scratchpad memory.
+ *
+ * @address: byte address to read from
+ *
+ * Returns value read
+ */
+static inline uint16_t cvmx_scratch_read16(uint64_t address)
+{
+	return *CASTPTR(volatile uint16_t, CVMX_SCRATCH_BASE + address);
+}
+
+/**
+ * Reads a 32 bit value from the processor local scratchpad memory.
+ *
+ * @address: byte address to read from
+ *
+ * Returns value read
+ */
+static inline uint32_t cvmx_scratch_read32(uint64_t address)
+{
+	return *CASTPTR(volatile uint32_t, CVMX_SCRATCH_BASE + address);
+}
+
+/**
+ * Reads a 64 bit value from the processor local scratchpad memory.
+ *
+ * @address: byte address to read from
+ *
+ * Returns value read
+ */
+static inline uint64_t cvmx_scratch_read64(uint64_t address)
+{
+	return *CASTPTR(volatile uint64_t, CVMX_SCRATCH_BASE + address);
+}
+
+/**
+ * Writes an 8 bit value to the processor local scratchpad memory.
+ *
+ * @address: byte address to write to
+ * @value:   value to write
+ */
+static inline void cvmx_scratch_write8(uint64_t address, uint64_t value)
+{
+	*CASTPTR(volatile uint8_t, CVMX_SCRATCH_BASE + address) =
+	    (uint8_t) value;
+}
+
+/**
+ * Writes a 32 bit value to the processor local scratchpad memory.
+ *
+ * @address: byte address to write to
+ * @value:   value to write
+ */
+static inline void cvmx_scratch_write16(uint64_t address, uint64_t value)
+{
+	*CASTPTR(volatile uint16_t, CVMX_SCRATCH_BASE + address) =
+	    (uint16_t) value;
+}
+
+/**
+ * Writes a 16 bit value to the processor local scratchpad memory.
+ *
+ * @address: byte address to write to
+ * @value:   value to write
+ */
+static inline void cvmx_scratch_write32(uint64_t address, uint64_t value)
+{
+	*CASTPTR(volatile uint32_t, CVMX_SCRATCH_BASE + address) =
+	    (uint32_t) value;
+}
+
+/**
+ * Writes a 64 bit value to the processor local scratchpad memory.
+ *
+ * @address: byte address to write to
+ * @value:   value to write
+ */
+static inline void cvmx_scratch_write64(uint64_t address, uint64_t value)
+{
+	*CASTPTR(volatile uint64_t, CVMX_SCRATCH_BASE + address) = value;
+}
+
+#endif /* __CVMX_SCRATCH_H__ */
diff --git a/drivers/staging/octeon/cvmx-smix-defs.h b/drivers/staging/octeon/cvmx-smix-defs.h
new file mode 100644
index 0000000..9ae45fc
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-smix-defs.h
@@ -0,0 +1,178 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_SMIX_DEFS_H__
+#define __CVMX_SMIX_DEFS_H__
+
+#define CVMX_SMIX_CLK(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001818ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_CMD(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001800ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_EN(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001820ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_RD_DAT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001810ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_WR_DAT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001808ull + (((offset) & 1) * 256))
+
+union cvmx_smix_clk {
+	uint64_t u64;
+	struct cvmx_smix_clk_s {
+		uint64_t reserved_25_63:39;
+		uint64_t mode:1;
+		uint64_t reserved_21_23:3;
+		uint64_t sample_hi:5;
+		uint64_t sample_mode:1;
+		uint64_t reserved_14_14:1;
+		uint64_t clk_idle:1;
+		uint64_t preamble:1;
+		uint64_t sample:4;
+		uint64_t phase:8;
+	} s;
+	struct cvmx_smix_clk_cn30xx {
+		uint64_t reserved_21_63:43;
+		uint64_t sample_hi:5;
+		uint64_t reserved_14_15:2;
+		uint64_t clk_idle:1;
+		uint64_t preamble:1;
+		uint64_t sample:4;
+		uint64_t phase:8;
+	} cn30xx;
+	struct cvmx_smix_clk_cn30xx cn31xx;
+	struct cvmx_smix_clk_cn30xx cn38xx;
+	struct cvmx_smix_clk_cn30xx cn38xxp2;
+	struct cvmx_smix_clk_cn50xx {
+		uint64_t reserved_25_63:39;
+		uint64_t mode:1;
+		uint64_t reserved_21_23:3;
+		uint64_t sample_hi:5;
+		uint64_t reserved_14_15:2;
+		uint64_t clk_idle:1;
+		uint64_t preamble:1;
+		uint64_t sample:4;
+		uint64_t phase:8;
+	} cn50xx;
+	struct cvmx_smix_clk_s cn52xx;
+	struct cvmx_smix_clk_cn50xx cn52xxp1;
+	struct cvmx_smix_clk_s cn56xx;
+	struct cvmx_smix_clk_cn50xx cn56xxp1;
+	struct cvmx_smix_clk_cn30xx cn58xx;
+	struct cvmx_smix_clk_cn30xx cn58xxp1;
+};
+
+union cvmx_smix_cmd {
+	uint64_t u64;
+	struct cvmx_smix_cmd_s {
+		uint64_t reserved_18_63:46;
+		uint64_t phy_op:2;
+		uint64_t reserved_13_15:3;
+		uint64_t phy_adr:5;
+		uint64_t reserved_5_7:3;
+		uint64_t reg_adr:5;
+	} s;
+	struct cvmx_smix_cmd_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t phy_op:1;
+		uint64_t reserved_13_15:3;
+		uint64_t phy_adr:5;
+		uint64_t reserved_5_7:3;
+		uint64_t reg_adr:5;
+	} cn30xx;
+	struct cvmx_smix_cmd_cn30xx cn31xx;
+	struct cvmx_smix_cmd_cn30xx cn38xx;
+	struct cvmx_smix_cmd_cn30xx cn38xxp2;
+	struct cvmx_smix_cmd_s cn50xx;
+	struct cvmx_smix_cmd_s cn52xx;
+	struct cvmx_smix_cmd_s cn52xxp1;
+	struct cvmx_smix_cmd_s cn56xx;
+	struct cvmx_smix_cmd_s cn56xxp1;
+	struct cvmx_smix_cmd_cn30xx cn58xx;
+	struct cvmx_smix_cmd_cn30xx cn58xxp1;
+};
+
+union cvmx_smix_en {
+	uint64_t u64;
+	struct cvmx_smix_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t en:1;
+	} s;
+	struct cvmx_smix_en_s cn30xx;
+	struct cvmx_smix_en_s cn31xx;
+	struct cvmx_smix_en_s cn38xx;
+	struct cvmx_smix_en_s cn38xxp2;
+	struct cvmx_smix_en_s cn50xx;
+	struct cvmx_smix_en_s cn52xx;
+	struct cvmx_smix_en_s cn52xxp1;
+	struct cvmx_smix_en_s cn56xx;
+	struct cvmx_smix_en_s cn56xxp1;
+	struct cvmx_smix_en_s cn58xx;
+	struct cvmx_smix_en_s cn58xxp1;
+};
+
+union cvmx_smix_rd_dat {
+	uint64_t u64;
+	struct cvmx_smix_rd_dat_s {
+		uint64_t reserved_18_63:46;
+		uint64_t pending:1;
+		uint64_t val:1;
+		uint64_t dat:16;
+	} s;
+	struct cvmx_smix_rd_dat_s cn30xx;
+	struct cvmx_smix_rd_dat_s cn31xx;
+	struct cvmx_smix_rd_dat_s cn38xx;
+	struct cvmx_smix_rd_dat_s cn38xxp2;
+	struct cvmx_smix_rd_dat_s cn50xx;
+	struct cvmx_smix_rd_dat_s cn52xx;
+	struct cvmx_smix_rd_dat_s cn52xxp1;
+	struct cvmx_smix_rd_dat_s cn56xx;
+	struct cvmx_smix_rd_dat_s cn56xxp1;
+	struct cvmx_smix_rd_dat_s cn58xx;
+	struct cvmx_smix_rd_dat_s cn58xxp1;
+};
+
+union cvmx_smix_wr_dat {
+	uint64_t u64;
+	struct cvmx_smix_wr_dat_s {
+		uint64_t reserved_18_63:46;
+		uint64_t pending:1;
+		uint64_t val:1;
+		uint64_t dat:16;
+	} s;
+	struct cvmx_smix_wr_dat_s cn30xx;
+	struct cvmx_smix_wr_dat_s cn31xx;
+	struct cvmx_smix_wr_dat_s cn38xx;
+	struct cvmx_smix_wr_dat_s cn38xxp2;
+	struct cvmx_smix_wr_dat_s cn50xx;
+	struct cvmx_smix_wr_dat_s cn52xx;
+	struct cvmx_smix_wr_dat_s cn52xxp1;
+	struct cvmx_smix_wr_dat_s cn56xx;
+	struct cvmx_smix_wr_dat_s cn56xxp1;
+	struct cvmx_smix_wr_dat_s cn58xx;
+	struct cvmx_smix_wr_dat_s cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-spi.c b/drivers/staging/octeon/cvmx-spi.c
new file mode 100644
index 0000000..82794d9
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-spi.c
@@ -0,0 +1,667 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * Support library for the SPI
+ */
+#include <asm/octeon/octeon.h>
+
+#include "cvmx-config.h"
+
+#include "cvmx-pko.h"
+#include "cvmx-spi.h"
+
+#include "cvmx-spxx-defs.h"
+#include "cvmx-stxx-defs.h"
+#include "cvmx-srxx-defs.h"
+
+#define INVOKE_CB(function_p, args...)		\
+	do {					\
+		if (function_p) {		\
+			res = function_p(args); \
+			if (res)		\
+				return res;	\
+		}				\
+	} while (0)
+
+#if CVMX_ENABLE_DEBUG_PRINTS
+static const char *modes[] =
+    { "UNKNOWN", "TX Halfplex", "Rx Halfplex", "Duplex" };
+#endif
+
+/* Default callbacks, can be overridden
+ *  using cvmx_spi_get_callbacks/cvmx_spi_set_callbacks
+ */
+static cvmx_spi_callbacks_t cvmx_spi_callbacks = {
+	.reset_cb = cvmx_spi_reset_cb,
+	.calendar_setup_cb = cvmx_spi_calendar_setup_cb,
+	.clock_detect_cb = cvmx_spi_clock_detect_cb,
+	.training_cb = cvmx_spi_training_cb,
+	.calendar_sync_cb = cvmx_spi_calendar_sync_cb,
+	.interface_up_cb = cvmx_spi_interface_up_cb
+};
+
+/**
+ * Get current SPI4 initialization callbacks
+ *
+ * @callbacks:  Pointer to the callbacks structure.to fill
+ *
+ * Returns Pointer to cvmx_spi_callbacks_t structure.
+ */
+void cvmx_spi_get_callbacks(cvmx_spi_callbacks_t *callbacks)
+{
+	memcpy(callbacks, &cvmx_spi_callbacks, sizeof(cvmx_spi_callbacks));
+}
+
+/**
+ * Set new SPI4 initialization callbacks
+ *
+ * @new_callbacks:  Pointer to an updated callbacks structure.
+ */
+void cvmx_spi_set_callbacks(cvmx_spi_callbacks_t *new_callbacks)
+{
+	memcpy(&cvmx_spi_callbacks, new_callbacks, sizeof(cvmx_spi_callbacks));
+}
+
+/**
+ * Initialize and start the SPI interface.
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for clock synchronization in seconds
+ * @num_ports: Number of SPI ports to configure
+ *
+ * Returns Zero on success, negative of failure.
+ */
+int cvmx_spi_start_interface(int interface, cvmx_spi_mode_t mode, int timeout,
+			     int num_ports)
+{
+	int res = -1;
+
+	if (!(OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX)))
+		return res;
+
+	/* Callback to perform SPI4 reset */
+	INVOKE_CB(cvmx_spi_callbacks.reset_cb, interface, mode);
+
+	/* Callback to perform calendar setup */
+	INVOKE_CB(cvmx_spi_callbacks.calendar_setup_cb, interface, mode,
+		  num_ports);
+
+	/* Callback to perform clock detection */
+	INVOKE_CB(cvmx_spi_callbacks.clock_detect_cb, interface, mode, timeout);
+
+	/* Callback to perform SPI4 link training */
+	INVOKE_CB(cvmx_spi_callbacks.training_cb, interface, mode, timeout);
+
+	/* Callback to perform calendar sync */
+	INVOKE_CB(cvmx_spi_callbacks.calendar_sync_cb, interface, mode,
+		  timeout);
+
+	/* Callback to handle interface coming up */
+	INVOKE_CB(cvmx_spi_callbacks.interface_up_cb, interface, mode);
+
+	return res;
+}
+
+/**
+ * This routine restarts the SPI interface after it has lost synchronization
+ * with its correspondent system.
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for clock synchronization in seconds
+ *
+ * Returns Zero on success, negative of failure.
+ */
+int cvmx_spi_restart_interface(int interface, cvmx_spi_mode_t mode, int timeout)
+{
+	int res = -1;
+
+	if (!(OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX)))
+		return res;
+
+	cvmx_dprintf("SPI%d: Restart %s\n", interface, modes[mode]);
+
+	/* Callback to perform SPI4 reset */
+	INVOKE_CB(cvmx_spi_callbacks.reset_cb, interface, mode);
+
+	/* NOTE: Calendar setup is not performed during restart */
+	/*       Refer to cvmx_spi_start_interface() for the full sequence */
+
+	/* Callback to perform clock detection */
+	INVOKE_CB(cvmx_spi_callbacks.clock_detect_cb, interface, mode, timeout);
+
+	/* Callback to perform SPI4 link training */
+	INVOKE_CB(cvmx_spi_callbacks.training_cb, interface, mode, timeout);
+
+	/* Callback to perform calendar sync */
+	INVOKE_CB(cvmx_spi_callbacks.calendar_sync_cb, interface, mode,
+		  timeout);
+
+	/* Callback to handle interface coming up */
+	INVOKE_CB(cvmx_spi_callbacks.interface_up_cb, interface, mode);
+
+	return res;
+}
+
+/**
+ * Callback to perform SPI4 reset
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+int cvmx_spi_reset_cb(int interface, cvmx_spi_mode_t mode)
+{
+	union cvmx_spxx_dbg_deskew_ctl spxx_dbg_deskew_ctl;
+	union cvmx_spxx_clk_ctl spxx_clk_ctl;
+	union cvmx_spxx_bist_stat spxx_bist_stat;
+	union cvmx_spxx_int_msk spxx_int_msk;
+	union cvmx_stxx_int_msk stxx_int_msk;
+	union cvmx_spxx_trn4_ctl spxx_trn4_ctl;
+	int index;
+	uint64_t MS = cvmx_sysinfo_get()->cpu_clock_hz / 1000;
+
+	/* Disable SPI error events while we run BIST */
+	spxx_int_msk.u64 = cvmx_read_csr(CVMX_SPXX_INT_MSK(interface));
+	cvmx_write_csr(CVMX_SPXX_INT_MSK(interface), 0);
+	stxx_int_msk.u64 = cvmx_read_csr(CVMX_STXX_INT_MSK(interface));
+	cvmx_write_csr(CVMX_STXX_INT_MSK(interface), 0);
+
+	/* Run BIST in the SPI interface */
+	cvmx_write_csr(CVMX_SRXX_COM_CTL(interface), 0);
+	cvmx_write_csr(CVMX_STXX_COM_CTL(interface), 0);
+	spxx_clk_ctl.u64 = 0;
+	spxx_clk_ctl.s.runbist = 1;
+	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
+	cvmx_wait(10 * MS);
+	spxx_bist_stat.u64 = cvmx_read_csr(CVMX_SPXX_BIST_STAT(interface));
+	if (spxx_bist_stat.s.stat0)
+		cvmx_dprintf
+		    ("ERROR SPI%d: BIST failed on receive datapath FIFO\n",
+		     interface);
+	if (spxx_bist_stat.s.stat1)
+		cvmx_dprintf("ERROR SPI%d: BIST failed on RX calendar table\n",
+			     interface);
+	if (spxx_bist_stat.s.stat2)
+		cvmx_dprintf("ERROR SPI%d: BIST failed on TX calendar table\n",
+			     interface);
+
+	/* Clear the calendar table after BIST to fix parity errors */
+	for (index = 0; index < 32; index++) {
+		union cvmx_srxx_spi4_calx srxx_spi4_calx;
+		union cvmx_stxx_spi4_calx stxx_spi4_calx;
+
+		srxx_spi4_calx.u64 = 0;
+		srxx_spi4_calx.s.oddpar = 1;
+		cvmx_write_csr(CVMX_SRXX_SPI4_CALX(index, interface),
+			       srxx_spi4_calx.u64);
+
+		stxx_spi4_calx.u64 = 0;
+		stxx_spi4_calx.s.oddpar = 1;
+		cvmx_write_csr(CVMX_STXX_SPI4_CALX(index, interface),
+			       stxx_spi4_calx.u64);
+	}
+
+	/* Re enable reporting of error interrupts */
+	cvmx_write_csr(CVMX_SPXX_INT_REG(interface),
+		       cvmx_read_csr(CVMX_SPXX_INT_REG(interface)));
+	cvmx_write_csr(CVMX_SPXX_INT_MSK(interface), spxx_int_msk.u64);
+	cvmx_write_csr(CVMX_STXX_INT_REG(interface),
+		       cvmx_read_csr(CVMX_STXX_INT_REG(interface)));
+	cvmx_write_csr(CVMX_STXX_INT_MSK(interface), stxx_int_msk.u64);
+
+	/* Setup the CLKDLY right in the middle */
+	spxx_clk_ctl.u64 = 0;
+	spxx_clk_ctl.s.seetrn = 0;
+	spxx_clk_ctl.s.clkdly = 0x10;
+	spxx_clk_ctl.s.runbist = 0;
+	spxx_clk_ctl.s.statdrv = 0;
+	/* This should always be on the opposite edge as statdrv */
+	spxx_clk_ctl.s.statrcv = 1;
+	spxx_clk_ctl.s.sndtrn = 0;
+	spxx_clk_ctl.s.drptrn = 0;
+	spxx_clk_ctl.s.rcvtrn = 0;
+	spxx_clk_ctl.s.srxdlck = 0;
+	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
+	cvmx_wait(100 * MS);
+
+	/* Reset SRX0 DLL */
+	spxx_clk_ctl.s.srxdlck = 1;
+	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
+
+	/* Waiting for Inf0 Spi4 RX DLL to lock */
+	cvmx_wait(100 * MS);
+
+	/* Enable dynamic alignment */
+	spxx_trn4_ctl.s.trntest = 0;
+	spxx_trn4_ctl.s.jitter = 1;
+	spxx_trn4_ctl.s.clr_boot = 1;
+	spxx_trn4_ctl.s.set_boot = 0;
+	if (OCTEON_IS_MODEL(OCTEON_CN58XX))
+		spxx_trn4_ctl.s.maxdist = 3;
+	else
+		spxx_trn4_ctl.s.maxdist = 8;
+	spxx_trn4_ctl.s.macro_en = 1;
+	spxx_trn4_ctl.s.mux_en = 1;
+	cvmx_write_csr(CVMX_SPXX_TRN4_CTL(interface), spxx_trn4_ctl.u64);
+
+	spxx_dbg_deskew_ctl.u64 = 0;
+	cvmx_write_csr(CVMX_SPXX_DBG_DESKEW_CTL(interface),
+		       spxx_dbg_deskew_ctl.u64);
+
+	return 0;
+}
+
+/**
+ * Callback to setup calendar and miscellaneous settings before clock detection
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @num_ports: Number of ports to configure on SPI
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+int cvmx_spi_calendar_setup_cb(int interface, cvmx_spi_mode_t mode,
+			       int num_ports)
+{
+	int port;
+	int index;
+	if (mode & CVMX_SPI_MODE_RX_HALFPLEX) {
+		union cvmx_srxx_com_ctl srxx_com_ctl;
+		union cvmx_srxx_spi4_stat srxx_spi4_stat;
+
+		/* SRX0 number of Ports */
+		srxx_com_ctl.u64 = 0;
+		srxx_com_ctl.s.prts = num_ports - 1;
+		srxx_com_ctl.s.st_en = 0;
+		srxx_com_ctl.s.inf_en = 0;
+		cvmx_write_csr(CVMX_SRXX_COM_CTL(interface), srxx_com_ctl.u64);
+
+		/* SRX0 Calendar Table. This round robbins through all ports */
+		port = 0;
+		index = 0;
+		while (port < num_ports) {
+			union cvmx_srxx_spi4_calx srxx_spi4_calx;
+			srxx_spi4_calx.u64 = 0;
+			srxx_spi4_calx.s.prt0 = port++;
+			srxx_spi4_calx.s.prt1 = port++;
+			srxx_spi4_calx.s.prt2 = port++;
+			srxx_spi4_calx.s.prt3 = port++;
+			srxx_spi4_calx.s.oddpar =
+			    ~(cvmx_dpop(srxx_spi4_calx.u64) & 1);
+			cvmx_write_csr(CVMX_SRXX_SPI4_CALX(index, interface),
+				       srxx_spi4_calx.u64);
+			index++;
+		}
+		srxx_spi4_stat.u64 = 0;
+		srxx_spi4_stat.s.len = num_ports;
+		srxx_spi4_stat.s.m = 1;
+		cvmx_write_csr(CVMX_SRXX_SPI4_STAT(interface),
+			       srxx_spi4_stat.u64);
+	}
+
+	if (mode & CVMX_SPI_MODE_TX_HALFPLEX) {
+		union cvmx_stxx_arb_ctl stxx_arb_ctl;
+		union cvmx_gmxx_tx_spi_max gmxx_tx_spi_max;
+		union cvmx_gmxx_tx_spi_thresh gmxx_tx_spi_thresh;
+		union cvmx_gmxx_tx_spi_ctl gmxx_tx_spi_ctl;
+		union cvmx_stxx_spi4_stat stxx_spi4_stat;
+		union cvmx_stxx_spi4_dat stxx_spi4_dat;
+
+		/* STX0 Config */
+		stxx_arb_ctl.u64 = 0;
+		stxx_arb_ctl.s.igntpa = 0;
+		stxx_arb_ctl.s.mintrn = 0;
+		cvmx_write_csr(CVMX_STXX_ARB_CTL(interface), stxx_arb_ctl.u64);
+
+		gmxx_tx_spi_max.u64 = 0;
+		gmxx_tx_spi_max.s.max1 = 8;
+		gmxx_tx_spi_max.s.max2 = 4;
+		gmxx_tx_spi_max.s.slice = 0;
+		cvmx_write_csr(CVMX_GMXX_TX_SPI_MAX(interface),
+			       gmxx_tx_spi_max.u64);
+
+		gmxx_tx_spi_thresh.u64 = 0;
+		gmxx_tx_spi_thresh.s.thresh = 4;
+		cvmx_write_csr(CVMX_GMXX_TX_SPI_THRESH(interface),
+			       gmxx_tx_spi_thresh.u64);
+
+		gmxx_tx_spi_ctl.u64 = 0;
+		gmxx_tx_spi_ctl.s.tpa_clr = 0;
+		gmxx_tx_spi_ctl.s.cont_pkt = 0;
+		cvmx_write_csr(CVMX_GMXX_TX_SPI_CTL(interface),
+			       gmxx_tx_spi_ctl.u64);
+
+		/* STX0 Training Control */
+		stxx_spi4_dat.u64 = 0;
+		/*Minimum needed by dynamic alignment */
+		stxx_spi4_dat.s.alpha = 32;
+		stxx_spi4_dat.s.max_t = 0xFFFF;	/*Minimum interval is 0x20 */
+		cvmx_write_csr(CVMX_STXX_SPI4_DAT(interface),
+			       stxx_spi4_dat.u64);
+
+		/* STX0 Calendar Table. This round robbins through all ports */
+		port = 0;
+		index = 0;
+		while (port < num_ports) {
+			union cvmx_stxx_spi4_calx stxx_spi4_calx;
+			stxx_spi4_calx.u64 = 0;
+			stxx_spi4_calx.s.prt0 = port++;
+			stxx_spi4_calx.s.prt1 = port++;
+			stxx_spi4_calx.s.prt2 = port++;
+			stxx_spi4_calx.s.prt3 = port++;
+			stxx_spi4_calx.s.oddpar =
+			    ~(cvmx_dpop(stxx_spi4_calx.u64) & 1);
+			cvmx_write_csr(CVMX_STXX_SPI4_CALX(index, interface),
+				       stxx_spi4_calx.u64);
+			index++;
+		}
+		stxx_spi4_stat.u64 = 0;
+		stxx_spi4_stat.s.len = num_ports;
+		stxx_spi4_stat.s.m = 1;
+		cvmx_write_csr(CVMX_STXX_SPI4_STAT(interface),
+			       stxx_spi4_stat.u64);
+	}
+
+	return 0;
+}
+
+/**
+ * Callback to perform clock detection
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for clock synchronization in seconds
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+int cvmx_spi_clock_detect_cb(int interface, cvmx_spi_mode_t mode, int timeout)
+{
+	int clock_transitions;
+	union cvmx_spxx_clk_stat stat;
+	uint64_t timeout_time;
+	uint64_t MS = cvmx_sysinfo_get()->cpu_clock_hz / 1000;
+
+	/*
+	 * Regardless of operating mode, both Tx and Rx clocks must be
+	 * present for the SPI interface to operate.
+	 */
+	cvmx_dprintf("SPI%d: Waiting to see TsClk...\n", interface);
+	timeout_time = cvmx_get_cycle() + 1000ull * MS * timeout;
+	/*
+	 * Require 100 clock transitions in order to avoid any noise
+	 * in the beginning.
+	 */
+	clock_transitions = 100;
+	do {
+		stat.u64 = cvmx_read_csr(CVMX_SPXX_CLK_STAT(interface));
+		if (stat.s.s4clk0 && stat.s.s4clk1 && clock_transitions) {
+			/*
+			 * We've seen a clock transition, so decrement
+			 * the number we still need.
+			 */
+			clock_transitions--;
+			cvmx_write_csr(CVMX_SPXX_CLK_STAT(interface), stat.u64);
+			stat.s.s4clk0 = 0;
+			stat.s.s4clk1 = 0;
+		}
+		if (cvmx_get_cycle() > timeout_time) {
+			cvmx_dprintf("SPI%d: Timeout\n", interface);
+			return -1;
+		}
+	} while (stat.s.s4clk0 == 0 || stat.s.s4clk1 == 0);
+
+	cvmx_dprintf("SPI%d: Waiting to see RsClk...\n", interface);
+	timeout_time = cvmx_get_cycle() + 1000ull * MS * timeout;
+	/*
+	 * Require 100 clock transitions in order to avoid any noise in the
+	 * beginning.
+	 */
+	clock_transitions = 100;
+	do {
+		stat.u64 = cvmx_read_csr(CVMX_SPXX_CLK_STAT(interface));
+		if (stat.s.d4clk0 && stat.s.d4clk1 && clock_transitions) {
+			/*
+			 * We've seen a clock transition, so decrement
+			 * the number we still need
+			 */
+			clock_transitions--;
+			cvmx_write_csr(CVMX_SPXX_CLK_STAT(interface), stat.u64);
+			stat.s.d4clk0 = 0;
+			stat.s.d4clk1 = 0;
+		}
+		if (cvmx_get_cycle() > timeout_time) {
+			cvmx_dprintf("SPI%d: Timeout\n", interface);
+			return -1;
+		}
+	} while (stat.s.d4clk0 == 0 || stat.s.d4clk1 == 0);
+
+	return 0;
+}
+
+/**
+ * Callback to perform link training
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for link to be trained (in seconds)
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+int cvmx_spi_training_cb(int interface, cvmx_spi_mode_t mode, int timeout)
+{
+	union cvmx_spxx_trn4_ctl spxx_trn4_ctl;
+	union cvmx_spxx_clk_stat stat;
+	uint64_t MS = cvmx_sysinfo_get()->cpu_clock_hz / 1000;
+	uint64_t timeout_time = cvmx_get_cycle() + 1000ull * MS * timeout;
+	int rx_training_needed;
+
+	/* SRX0 & STX0 Inf0 Links are configured - begin training */
+	union cvmx_spxx_clk_ctl spxx_clk_ctl;
+	spxx_clk_ctl.u64 = 0;
+	spxx_clk_ctl.s.seetrn = 0;
+	spxx_clk_ctl.s.clkdly = 0x10;
+	spxx_clk_ctl.s.runbist = 0;
+	spxx_clk_ctl.s.statdrv = 0;
+	/* This should always be on the opposite edge as statdrv */
+	spxx_clk_ctl.s.statrcv = 1;
+	spxx_clk_ctl.s.sndtrn = 1;
+	spxx_clk_ctl.s.drptrn = 1;
+	spxx_clk_ctl.s.rcvtrn = 1;
+	spxx_clk_ctl.s.srxdlck = 1;
+	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
+	cvmx_wait(1000 * MS);
+
+	/* SRX0 clear the boot bit */
+	spxx_trn4_ctl.u64 = cvmx_read_csr(CVMX_SPXX_TRN4_CTL(interface));
+	spxx_trn4_ctl.s.clr_boot = 1;
+	cvmx_write_csr(CVMX_SPXX_TRN4_CTL(interface), spxx_trn4_ctl.u64);
+
+	/* Wait for the training sequence to complete */
+	cvmx_dprintf("SPI%d: Waiting for training\n", interface);
+	cvmx_wait(1000 * MS);
+	/* Wait a really long time here */
+	timeout_time = cvmx_get_cycle() + 1000ull * MS * 600;
+	/*
+	 * The HRM says we must wait for 34 + 16 * MAXDIST training sequences.
+	 * We'll be pessimistic and wait for a lot more.
+	 */
+	rx_training_needed = 500;
+	do {
+		stat.u64 = cvmx_read_csr(CVMX_SPXX_CLK_STAT(interface));
+		if (stat.s.srxtrn && rx_training_needed) {
+			rx_training_needed--;
+			cvmx_write_csr(CVMX_SPXX_CLK_STAT(interface), stat.u64);
+			stat.s.srxtrn = 0;
+		}
+		if (cvmx_get_cycle() > timeout_time) {
+			cvmx_dprintf("SPI%d: Timeout\n", interface);
+			return -1;
+		}
+	} while (stat.s.srxtrn == 0);
+
+	return 0;
+}
+
+/**
+ * Callback to perform calendar data synchronization
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for calendar data in seconds
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+int cvmx_spi_calendar_sync_cb(int interface, cvmx_spi_mode_t mode, int timeout)
+{
+	uint64_t MS = cvmx_sysinfo_get()->cpu_clock_hz / 1000;
+	if (mode & CVMX_SPI_MODE_RX_HALFPLEX) {
+		/* SRX0 interface should be good, send calendar data */
+		union cvmx_srxx_com_ctl srxx_com_ctl;
+		cvmx_dprintf
+		    ("SPI%d: Rx is synchronized, start sending calendar data\n",
+		     interface);
+		srxx_com_ctl.u64 = cvmx_read_csr(CVMX_SRXX_COM_CTL(interface));
+		srxx_com_ctl.s.inf_en = 1;
+		srxx_com_ctl.s.st_en = 1;
+		cvmx_write_csr(CVMX_SRXX_COM_CTL(interface), srxx_com_ctl.u64);
+	}
+
+	if (mode & CVMX_SPI_MODE_TX_HALFPLEX) {
+		/* STX0 has achieved sync */
+		/* The corespondant board should be sending calendar data */
+		/* Enable the STX0 STAT receiver. */
+		union cvmx_spxx_clk_stat stat;
+		uint64_t timeout_time;
+		union cvmx_stxx_com_ctl stxx_com_ctl;
+		stxx_com_ctl.u64 = 0;
+		stxx_com_ctl.s.st_en = 1;
+		cvmx_write_csr(CVMX_STXX_COM_CTL(interface), stxx_com_ctl.u64);
+
+		/* Waiting for calendar sync on STX0 STAT */
+		cvmx_dprintf("SPI%d: Waiting to sync on STX[%d] STAT\n",
+			     interface, interface);
+		timeout_time = cvmx_get_cycle() + 1000ull * MS * timeout;
+		/* SPX0_CLK_STAT - SPX0_CLK_STAT[STXCAL] should be 1 (bit10) */
+		do {
+			stat.u64 = cvmx_read_csr(CVMX_SPXX_CLK_STAT(interface));
+			if (cvmx_get_cycle() > timeout_time) {
+				cvmx_dprintf("SPI%d: Timeout\n", interface);
+				return -1;
+			}
+		} while (stat.s.stxcal == 0);
+	}
+
+	return 0;
+}
+
+/**
+ * Callback to handle interface up
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+int cvmx_spi_interface_up_cb(int interface, cvmx_spi_mode_t mode)
+{
+	union cvmx_gmxx_rxx_frm_min gmxx_rxx_frm_min;
+	union cvmx_gmxx_rxx_frm_max gmxx_rxx_frm_max;
+	union cvmx_gmxx_rxx_jabber gmxx_rxx_jabber;
+
+	if (mode & CVMX_SPI_MODE_RX_HALFPLEX) {
+		union cvmx_srxx_com_ctl srxx_com_ctl;
+		srxx_com_ctl.u64 = cvmx_read_csr(CVMX_SRXX_COM_CTL(interface));
+		srxx_com_ctl.s.inf_en = 1;
+		cvmx_write_csr(CVMX_SRXX_COM_CTL(interface), srxx_com_ctl.u64);
+		cvmx_dprintf("SPI%d: Rx is now up\n", interface);
+	}
+
+	if (mode & CVMX_SPI_MODE_TX_HALFPLEX) {
+		union cvmx_stxx_com_ctl stxx_com_ctl;
+		stxx_com_ctl.u64 = cvmx_read_csr(CVMX_STXX_COM_CTL(interface));
+		stxx_com_ctl.s.inf_en = 1;
+		cvmx_write_csr(CVMX_STXX_COM_CTL(interface), stxx_com_ctl.u64);
+		cvmx_dprintf("SPI%d: Tx is now up\n", interface);
+	}
+
+	gmxx_rxx_frm_min.u64 = 0;
+	gmxx_rxx_frm_min.s.len = 64;
+	cvmx_write_csr(CVMX_GMXX_RXX_FRM_MIN(0, interface),
+		       gmxx_rxx_frm_min.u64);
+	gmxx_rxx_frm_max.u64 = 0;
+	gmxx_rxx_frm_max.s.len = 64 * 1024 - 4;
+	cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX(0, interface),
+		       gmxx_rxx_frm_max.u64);
+	gmxx_rxx_jabber.u64 = 0;
+	gmxx_rxx_jabber.s.cnt = 64 * 1024 - 4;
+	cvmx_write_csr(CVMX_GMXX_RXX_JABBER(0, interface), gmxx_rxx_jabber.u64);
+
+	return 0;
+}
diff --git a/drivers/staging/octeon/cvmx-spi.h b/drivers/staging/octeon/cvmx-spi.h
new file mode 100644
index 0000000..e814648
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-spi.h
@@ -0,0 +1,269 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/*
+ *
+ * This file contains defines for the SPI interface
+ */
+#ifndef __CVMX_SPI_H__
+#define __CVMX_SPI_H__
+
+#include "cvmx-gmxx-defs.h"
+
+/* CSR typedefs have been moved to cvmx-csr-*.h */
+
+typedef enum {
+	CVMX_SPI_MODE_UNKNOWN = 0,
+	CVMX_SPI_MODE_TX_HALFPLEX = 1,
+	CVMX_SPI_MODE_RX_HALFPLEX = 2,
+	CVMX_SPI_MODE_DUPLEX = 3
+} cvmx_spi_mode_t;
+
+/** Callbacks structure to customize SPI4 initialization sequence */
+typedef struct {
+    /** Called to reset SPI4 DLL */
+	int (*reset_cb) (int interface, cvmx_spi_mode_t mode);
+
+    /** Called to setup calendar */
+	int (*calendar_setup_cb) (int interface, cvmx_spi_mode_t mode,
+				  int num_ports);
+
+    /** Called for Tx and Rx clock detection */
+	int (*clock_detect_cb) (int interface, cvmx_spi_mode_t mode,
+				int timeout);
+
+    /** Called to perform link training */
+	int (*training_cb) (int interface, cvmx_spi_mode_t mode, int timeout);
+
+    /** Called for calendar data synchronization */
+	int (*calendar_sync_cb) (int interface, cvmx_spi_mode_t mode,
+				 int timeout);
+
+    /** Called when interface is up */
+	int (*interface_up_cb) (int interface, cvmx_spi_mode_t mode);
+
+} cvmx_spi_callbacks_t;
+
+/**
+ * Return true if the supplied interface is configured for SPI
+ *
+ * @interface: Interface to check
+ * Returns True if interface is SPI
+ */
+static inline int cvmx_spi_is_spi_interface(int interface)
+{
+	uint64_t gmxState = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+	return (gmxState & 0x2) && (gmxState & 0x1);
+}
+
+/**
+ * Initialize and start the SPI interface.
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for clock synchronization in seconds
+ * @num_ports: Number of SPI ports to configure
+ *
+ * Returns Zero on success, negative of failure.
+ */
+extern int cvmx_spi_start_interface(int interface, cvmx_spi_mode_t mode,
+				    int timeout, int num_ports);
+
+/**
+ * This routine restarts the SPI interface after it has lost synchronization
+ * with its corespondant system.
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for clock synchronization in seconds
+ * Returns Zero on success, negative of failure.
+ */
+extern int cvmx_spi_restart_interface(int interface, cvmx_spi_mode_t mode,
+				      int timeout);
+
+/**
+ * Return non-zero if the SPI interface has a SPI4000 attached
+ *
+ * @interface: SPI interface the SPI4000 is connected to
+ *
+ * Returns
+ */
+static inline int cvmx_spi4000_is_present(int interface)
+{
+	return 0;
+}
+
+/**
+ * Initialize the SPI4000 for use
+ *
+ * @interface: SPI interface the SPI4000 is connected to
+ */
+static inline int cvmx_spi4000_initialize(int interface)
+{
+	return 0;
+}
+
+/**
+ * Poll all the SPI4000 port and check its speed
+ *
+ * @interface: Interface the SPI4000 is on
+ * @port:      Port to poll (0-9)
+ * Returns Status of the port. 0=down. All other values the port is up.
+ */
+static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
+	int interface,
+	int port)
+{
+	union cvmx_gmxx_rxx_rx_inbnd r;
+	r.u64 = 0;
+	return r;
+}
+
+/**
+ * Get current SPI4 initialization callbacks
+ *
+ * @callbacks:  Pointer to the callbacks structure.to fill
+ *
+ * Returns Pointer to cvmx_spi_callbacks_t structure.
+ */
+extern void cvmx_spi_get_callbacks(cvmx_spi_callbacks_t *callbacks);
+
+/**
+ * Set new SPI4 initialization callbacks
+ *
+ * @new_callbacks:  Pointer to an updated callbacks structure.
+ */
+extern void cvmx_spi_set_callbacks(cvmx_spi_callbacks_t *new_callbacks);
+
+/**
+ * Callback to perform SPI4 reset
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+extern int cvmx_spi_reset_cb(int interface, cvmx_spi_mode_t mode);
+
+/**
+ * Callback to setup calendar and miscellaneous settings before clock
+ * detection
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @num_ports: Number of ports to configure on SPI
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+extern int cvmx_spi_calendar_setup_cb(int interface, cvmx_spi_mode_t mode,
+				      int num_ports);
+
+/**
+ * Callback to perform clock detection
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for clock synchronization in seconds
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+extern int cvmx_spi_clock_detect_cb(int interface, cvmx_spi_mode_t mode,
+				    int timeout);
+
+/**
+ * Callback to perform link training
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for link to be trained (in seconds)
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+extern int cvmx_spi_training_cb(int interface, cvmx_spi_mode_t mode,
+				int timeout);
+
+/**
+ * Callback to perform calendar data synchronization
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ * @timeout:   Timeout to wait for calendar data in seconds
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+extern int cvmx_spi_calendar_sync_cb(int interface, cvmx_spi_mode_t mode,
+				     int timeout);
+
+/**
+ * Callback to handle interface up
+ *
+ * @interface: The identifier of the packet interface to configure and
+ *                  use as a SPI interface.
+ * @mode:      The operating mode for the SPI interface. The interface
+ *                  can operate as a full duplex (both Tx and Rx data paths
+ *                  active) or as a halfplex (either the Tx data path is
+ *                  active or the Rx data path is active, but not both).
+ *
+ * Returns Zero on success, non-zero error code on failure (will cause
+ * SPI initialization to abort)
+ */
+extern int cvmx_spi_interface_up_cb(int interface, cvmx_spi_mode_t mode);
+
+#endif /* __CVMX_SPI_H__ */
diff --git a/drivers/staging/octeon/cvmx-spxx-defs.h b/drivers/staging/octeon/cvmx-spxx-defs.h
new file mode 100644
index 0000000..b16940e
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-spxx-defs.h
@@ -0,0 +1,347 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_SPXX_DEFS_H__
+#define __CVMX_SPXX_DEFS_H__
+
+#define CVMX_SPXX_BCKPRS_CNT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000340ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_BIST_STAT(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800900007F8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_CLK_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000348ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_CLK_STAT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000350ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_DBG_DESKEW_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000368ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_DBG_DESKEW_STATE(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000370ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_DRV_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000358ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_ERR_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000320ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_INT_DAT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000318ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_INT_MSK(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000308ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_INT_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000300ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_INT_SYNC(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000310ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_TPA_ACC(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000338ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_TPA_MAX(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000330ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_TPA_SEL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000328ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SPXX_TRN4_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000360ull + (((block_id) & 1) * 0x8000000ull))
+
+union cvmx_spxx_bckprs_cnt {
+	uint64_t u64;
+	struct cvmx_spxx_bckprs_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_spxx_bckprs_cnt_s cn38xx;
+	struct cvmx_spxx_bckprs_cnt_s cn38xxp2;
+	struct cvmx_spxx_bckprs_cnt_s cn58xx;
+	struct cvmx_spxx_bckprs_cnt_s cn58xxp1;
+};
+
+union cvmx_spxx_bist_stat {
+	uint64_t u64;
+	struct cvmx_spxx_bist_stat_s {
+		uint64_t reserved_3_63:61;
+		uint64_t stat2:1;
+		uint64_t stat1:1;
+		uint64_t stat0:1;
+	} s;
+	struct cvmx_spxx_bist_stat_s cn38xx;
+	struct cvmx_spxx_bist_stat_s cn38xxp2;
+	struct cvmx_spxx_bist_stat_s cn58xx;
+	struct cvmx_spxx_bist_stat_s cn58xxp1;
+};
+
+union cvmx_spxx_clk_ctl {
+	uint64_t u64;
+	struct cvmx_spxx_clk_ctl_s {
+		uint64_t reserved_17_63:47;
+		uint64_t seetrn:1;
+		uint64_t reserved_12_15:4;
+		uint64_t clkdly:5;
+		uint64_t runbist:1;
+		uint64_t statdrv:1;
+		uint64_t statrcv:1;
+		uint64_t sndtrn:1;
+		uint64_t drptrn:1;
+		uint64_t rcvtrn:1;
+		uint64_t srxdlck:1;
+	} s;
+	struct cvmx_spxx_clk_ctl_s cn38xx;
+	struct cvmx_spxx_clk_ctl_s cn38xxp2;
+	struct cvmx_spxx_clk_ctl_s cn58xx;
+	struct cvmx_spxx_clk_ctl_s cn58xxp1;
+};
+
+union cvmx_spxx_clk_stat {
+	uint64_t u64;
+	struct cvmx_spxx_clk_stat_s {
+		uint64_t reserved_11_63:53;
+		uint64_t stxcal:1;
+		uint64_t reserved_9_9:1;
+		uint64_t srxtrn:1;
+		uint64_t s4clk1:1;
+		uint64_t s4clk0:1;
+		uint64_t d4clk1:1;
+		uint64_t d4clk0:1;
+		uint64_t reserved_0_3:4;
+	} s;
+	struct cvmx_spxx_clk_stat_s cn38xx;
+	struct cvmx_spxx_clk_stat_s cn38xxp2;
+	struct cvmx_spxx_clk_stat_s cn58xx;
+	struct cvmx_spxx_clk_stat_s cn58xxp1;
+};
+
+union cvmx_spxx_dbg_deskew_ctl {
+	uint64_t u64;
+	struct cvmx_spxx_dbg_deskew_ctl_s {
+		uint64_t reserved_30_63:34;
+		uint64_t fallnop:1;
+		uint64_t fall8:1;
+		uint64_t reserved_26_27:2;
+		uint64_t sstep_go:1;
+		uint64_t sstep:1;
+		uint64_t reserved_22_23:2;
+		uint64_t clrdly:1;
+		uint64_t dec:1;
+		uint64_t inc:1;
+		uint64_t mux:1;
+		uint64_t offset:5;
+		uint64_t bitsel:5;
+		uint64_t offdly:6;
+		uint64_t dllfrc:1;
+		uint64_t dlldis:1;
+	} s;
+	struct cvmx_spxx_dbg_deskew_ctl_s cn38xx;
+	struct cvmx_spxx_dbg_deskew_ctl_s cn38xxp2;
+	struct cvmx_spxx_dbg_deskew_ctl_s cn58xx;
+	struct cvmx_spxx_dbg_deskew_ctl_s cn58xxp1;
+};
+
+union cvmx_spxx_dbg_deskew_state {
+	uint64_t u64;
+	struct cvmx_spxx_dbg_deskew_state_s {
+		uint64_t reserved_9_63:55;
+		uint64_t testres:1;
+		uint64_t unxterm:1;
+		uint64_t muxsel:2;
+		uint64_t offset:5;
+	} s;
+	struct cvmx_spxx_dbg_deskew_state_s cn38xx;
+	struct cvmx_spxx_dbg_deskew_state_s cn38xxp2;
+	struct cvmx_spxx_dbg_deskew_state_s cn58xx;
+	struct cvmx_spxx_dbg_deskew_state_s cn58xxp1;
+};
+
+union cvmx_spxx_drv_ctl {
+	uint64_t u64;
+	struct cvmx_spxx_drv_ctl_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_spxx_drv_ctl_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t stx4ncmp:4;
+		uint64_t stx4pcmp:4;
+		uint64_t srx4cmp:8;
+	} cn38xx;
+	struct cvmx_spxx_drv_ctl_cn38xx cn38xxp2;
+	struct cvmx_spxx_drv_ctl_cn58xx {
+		uint64_t reserved_24_63:40;
+		uint64_t stx4ncmp:4;
+		uint64_t stx4pcmp:4;
+		uint64_t reserved_10_15:6;
+		uint64_t srx4cmp:10;
+	} cn58xx;
+	struct cvmx_spxx_drv_ctl_cn58xx cn58xxp1;
+};
+
+union cvmx_spxx_err_ctl {
+	uint64_t u64;
+	struct cvmx_spxx_err_ctl_s {
+		uint64_t reserved_9_63:55;
+		uint64_t prtnxa:1;
+		uint64_t dipcls:1;
+		uint64_t dippay:1;
+		uint64_t reserved_4_5:2;
+		uint64_t errcnt:4;
+	} s;
+	struct cvmx_spxx_err_ctl_s cn38xx;
+	struct cvmx_spxx_err_ctl_s cn38xxp2;
+	struct cvmx_spxx_err_ctl_s cn58xx;
+	struct cvmx_spxx_err_ctl_s cn58xxp1;
+};
+
+union cvmx_spxx_int_dat {
+	uint64_t u64;
+	struct cvmx_spxx_int_dat_s {
+		uint64_t reserved_32_63:32;
+		uint64_t mul:1;
+		uint64_t reserved_14_30:17;
+		uint64_t calbnk:2;
+		uint64_t rsvop:4;
+		uint64_t prt:8;
+	} s;
+	struct cvmx_spxx_int_dat_s cn38xx;
+	struct cvmx_spxx_int_dat_s cn38xxp2;
+	struct cvmx_spxx_int_dat_s cn58xx;
+	struct cvmx_spxx_int_dat_s cn58xxp1;
+};
+
+union cvmx_spxx_int_msk {
+	uint64_t u64;
+	struct cvmx_spxx_int_msk_s {
+		uint64_t reserved_12_63:52;
+		uint64_t calerr:1;
+		uint64_t syncerr:1;
+		uint64_t diperr:1;
+		uint64_t tpaovr:1;
+		uint64_t rsverr:1;
+		uint64_t drwnng:1;
+		uint64_t clserr:1;
+		uint64_t spiovr:1;
+		uint64_t reserved_2_3:2;
+		uint64_t abnorm:1;
+		uint64_t prtnxa:1;
+	} s;
+	struct cvmx_spxx_int_msk_s cn38xx;
+	struct cvmx_spxx_int_msk_s cn38xxp2;
+	struct cvmx_spxx_int_msk_s cn58xx;
+	struct cvmx_spxx_int_msk_s cn58xxp1;
+};
+
+union cvmx_spxx_int_reg {
+	uint64_t u64;
+	struct cvmx_spxx_int_reg_s {
+		uint64_t reserved_32_63:32;
+		uint64_t spf:1;
+		uint64_t reserved_12_30:19;
+		uint64_t calerr:1;
+		uint64_t syncerr:1;
+		uint64_t diperr:1;
+		uint64_t tpaovr:1;
+		uint64_t rsverr:1;
+		uint64_t drwnng:1;
+		uint64_t clserr:1;
+		uint64_t spiovr:1;
+		uint64_t reserved_2_3:2;
+		uint64_t abnorm:1;
+		uint64_t prtnxa:1;
+	} s;
+	struct cvmx_spxx_int_reg_s cn38xx;
+	struct cvmx_spxx_int_reg_s cn38xxp2;
+	struct cvmx_spxx_int_reg_s cn58xx;
+	struct cvmx_spxx_int_reg_s cn58xxp1;
+};
+
+union cvmx_spxx_int_sync {
+	uint64_t u64;
+	struct cvmx_spxx_int_sync_s {
+		uint64_t reserved_12_63:52;
+		uint64_t calerr:1;
+		uint64_t syncerr:1;
+		uint64_t diperr:1;
+		uint64_t tpaovr:1;
+		uint64_t rsverr:1;
+		uint64_t drwnng:1;
+		uint64_t clserr:1;
+		uint64_t spiovr:1;
+		uint64_t reserved_2_3:2;
+		uint64_t abnorm:1;
+		uint64_t prtnxa:1;
+	} s;
+	struct cvmx_spxx_int_sync_s cn38xx;
+	struct cvmx_spxx_int_sync_s cn38xxp2;
+	struct cvmx_spxx_int_sync_s cn58xx;
+	struct cvmx_spxx_int_sync_s cn58xxp1;
+};
+
+union cvmx_spxx_tpa_acc {
+	uint64_t u64;
+	struct cvmx_spxx_tpa_acc_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_spxx_tpa_acc_s cn38xx;
+	struct cvmx_spxx_tpa_acc_s cn38xxp2;
+	struct cvmx_spxx_tpa_acc_s cn58xx;
+	struct cvmx_spxx_tpa_acc_s cn58xxp1;
+};
+
+union cvmx_spxx_tpa_max {
+	uint64_t u64;
+	struct cvmx_spxx_tpa_max_s {
+		uint64_t reserved_32_63:32;
+		uint64_t max:32;
+	} s;
+	struct cvmx_spxx_tpa_max_s cn38xx;
+	struct cvmx_spxx_tpa_max_s cn38xxp2;
+	struct cvmx_spxx_tpa_max_s cn58xx;
+	struct cvmx_spxx_tpa_max_s cn58xxp1;
+};
+
+union cvmx_spxx_tpa_sel {
+	uint64_t u64;
+	struct cvmx_spxx_tpa_sel_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prtsel:4;
+	} s;
+	struct cvmx_spxx_tpa_sel_s cn38xx;
+	struct cvmx_spxx_tpa_sel_s cn38xxp2;
+	struct cvmx_spxx_tpa_sel_s cn58xx;
+	struct cvmx_spxx_tpa_sel_s cn58xxp1;
+};
+
+union cvmx_spxx_trn4_ctl {
+	uint64_t u64;
+	struct cvmx_spxx_trn4_ctl_s {
+		uint64_t reserved_13_63:51;
+		uint64_t trntest:1;
+		uint64_t jitter:3;
+		uint64_t clr_boot:1;
+		uint64_t set_boot:1;
+		uint64_t maxdist:5;
+		uint64_t macro_en:1;
+		uint64_t mux_en:1;
+	} s;
+	struct cvmx_spxx_trn4_ctl_s cn38xx;
+	struct cvmx_spxx_trn4_ctl_s cn38xxp2;
+	struct cvmx_spxx_trn4_ctl_s cn58xx;
+	struct cvmx_spxx_trn4_ctl_s cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-srxx-defs.h b/drivers/staging/octeon/cvmx-srxx-defs.h
new file mode 100644
index 0000000..d82b366
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-srxx-defs.h
@@ -0,0 +1,126 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_SRXX_DEFS_H__
+#define __CVMX_SRXX_DEFS_H__
+
+#define CVMX_SRXX_COM_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000200ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SRXX_IGN_RX_FULL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000218ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SRXX_SPI4_CALX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000000ull + (((offset) & 31) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SRXX_SPI4_STAT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000208ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SRXX_SW_TICK_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000220ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_SRXX_SW_TICK_DAT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000228ull + (((block_id) & 1) * 0x8000000ull))
+
+union cvmx_srxx_com_ctl {
+	uint64_t u64;
+	struct cvmx_srxx_com_ctl_s {
+		uint64_t reserved_8_63:56;
+		uint64_t prts:4;
+		uint64_t st_en:1;
+		uint64_t reserved_1_2:2;
+		uint64_t inf_en:1;
+	} s;
+	struct cvmx_srxx_com_ctl_s cn38xx;
+	struct cvmx_srxx_com_ctl_s cn38xxp2;
+	struct cvmx_srxx_com_ctl_s cn58xx;
+	struct cvmx_srxx_com_ctl_s cn58xxp1;
+};
+
+union cvmx_srxx_ign_rx_full {
+	uint64_t u64;
+	struct cvmx_srxx_ign_rx_full_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ignore:16;
+	} s;
+	struct cvmx_srxx_ign_rx_full_s cn38xx;
+	struct cvmx_srxx_ign_rx_full_s cn38xxp2;
+	struct cvmx_srxx_ign_rx_full_s cn58xx;
+	struct cvmx_srxx_ign_rx_full_s cn58xxp1;
+};
+
+union cvmx_srxx_spi4_calx {
+	uint64_t u64;
+	struct cvmx_srxx_spi4_calx_s {
+		uint64_t reserved_17_63:47;
+		uint64_t oddpar:1;
+		uint64_t prt3:4;
+		uint64_t prt2:4;
+		uint64_t prt1:4;
+		uint64_t prt0:4;
+	} s;
+	struct cvmx_srxx_spi4_calx_s cn38xx;
+	struct cvmx_srxx_spi4_calx_s cn38xxp2;
+	struct cvmx_srxx_spi4_calx_s cn58xx;
+	struct cvmx_srxx_spi4_calx_s cn58xxp1;
+};
+
+union cvmx_srxx_spi4_stat {
+	uint64_t u64;
+	struct cvmx_srxx_spi4_stat_s {
+		uint64_t reserved_16_63:48;
+		uint64_t m:8;
+		uint64_t reserved_7_7:1;
+		uint64_t len:7;
+	} s;
+	struct cvmx_srxx_spi4_stat_s cn38xx;
+	struct cvmx_srxx_spi4_stat_s cn38xxp2;
+	struct cvmx_srxx_spi4_stat_s cn58xx;
+	struct cvmx_srxx_spi4_stat_s cn58xxp1;
+};
+
+union cvmx_srxx_sw_tick_ctl {
+	uint64_t u64;
+	struct cvmx_srxx_sw_tick_ctl_s {
+		uint64_t reserved_14_63:50;
+		uint64_t eop:1;
+		uint64_t sop:1;
+		uint64_t mod:4;
+		uint64_t opc:4;
+		uint64_t adr:4;
+	} s;
+	struct cvmx_srxx_sw_tick_ctl_s cn38xx;
+	struct cvmx_srxx_sw_tick_ctl_s cn58xx;
+	struct cvmx_srxx_sw_tick_ctl_s cn58xxp1;
+};
+
+union cvmx_srxx_sw_tick_dat {
+	uint64_t u64;
+	struct cvmx_srxx_sw_tick_dat_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_srxx_sw_tick_dat_s cn38xx;
+	struct cvmx_srxx_sw_tick_dat_s cn58xx;
+	struct cvmx_srxx_sw_tick_dat_s cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-stxx-defs.h b/drivers/staging/octeon/cvmx-stxx-defs.h
new file mode 100644
index 0000000..4f209b6
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-stxx-defs.h
@@ -0,0 +1,292 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_STXX_DEFS_H__
+#define __CVMX_STXX_DEFS_H__
+
+#define CVMX_STXX_ARB_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000608ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_BCKPRS_CNT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000688ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_COM_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000600ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_DIP_CNT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000690ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_IGN_CAL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000610ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_INT_MSK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800900006A0ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_INT_REG(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000698ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_INT_SYNC(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800900006A8ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_MIN_BST(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000618ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_SPI4_CALX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000400ull + (((offset) & 31) * 8) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_SPI4_DAT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000628ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_SPI4_STAT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000630ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_STAT_BYTES_HI(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000648ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_STAT_BYTES_LO(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000680ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_STAT_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000638ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_STXX_STAT_PKT_XMT(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180090000640ull + (((block_id) & 1) * 0x8000000ull))
+
+union cvmx_stxx_arb_ctl {
+	uint64_t u64;
+	struct cvmx_stxx_arb_ctl_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mintrn:1;
+		uint64_t reserved_4_4:1;
+		uint64_t igntpa:1;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_stxx_arb_ctl_s cn38xx;
+	struct cvmx_stxx_arb_ctl_s cn38xxp2;
+	struct cvmx_stxx_arb_ctl_s cn58xx;
+	struct cvmx_stxx_arb_ctl_s cn58xxp1;
+};
+
+union cvmx_stxx_bckprs_cnt {
+	uint64_t u64;
+	struct cvmx_stxx_bckprs_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_stxx_bckprs_cnt_s cn38xx;
+	struct cvmx_stxx_bckprs_cnt_s cn38xxp2;
+	struct cvmx_stxx_bckprs_cnt_s cn58xx;
+	struct cvmx_stxx_bckprs_cnt_s cn58xxp1;
+};
+
+union cvmx_stxx_com_ctl {
+	uint64_t u64;
+	struct cvmx_stxx_com_ctl_s {
+		uint64_t reserved_4_63:60;
+		uint64_t st_en:1;
+		uint64_t reserved_1_2:2;
+		uint64_t inf_en:1;
+	} s;
+	struct cvmx_stxx_com_ctl_s cn38xx;
+	struct cvmx_stxx_com_ctl_s cn38xxp2;
+	struct cvmx_stxx_com_ctl_s cn58xx;
+	struct cvmx_stxx_com_ctl_s cn58xxp1;
+};
+
+union cvmx_stxx_dip_cnt {
+	uint64_t u64;
+	struct cvmx_stxx_dip_cnt_s {
+		uint64_t reserved_8_63:56;
+		uint64_t frmmax:4;
+		uint64_t dipmax:4;
+	} s;
+	struct cvmx_stxx_dip_cnt_s cn38xx;
+	struct cvmx_stxx_dip_cnt_s cn38xxp2;
+	struct cvmx_stxx_dip_cnt_s cn58xx;
+	struct cvmx_stxx_dip_cnt_s cn58xxp1;
+};
+
+union cvmx_stxx_ign_cal {
+	uint64_t u64;
+	struct cvmx_stxx_ign_cal_s {
+		uint64_t reserved_16_63:48;
+		uint64_t igntpa:16;
+	} s;
+	struct cvmx_stxx_ign_cal_s cn38xx;
+	struct cvmx_stxx_ign_cal_s cn38xxp2;
+	struct cvmx_stxx_ign_cal_s cn58xx;
+	struct cvmx_stxx_ign_cal_s cn58xxp1;
+};
+
+union cvmx_stxx_int_msk {
+	uint64_t u64;
+	struct cvmx_stxx_int_msk_s {
+		uint64_t reserved_8_63:56;
+		uint64_t frmerr:1;
+		uint64_t unxfrm:1;
+		uint64_t nosync:1;
+		uint64_t diperr:1;
+		uint64_t datovr:1;
+		uint64_t ovrbst:1;
+		uint64_t calpar1:1;
+		uint64_t calpar0:1;
+	} s;
+	struct cvmx_stxx_int_msk_s cn38xx;
+	struct cvmx_stxx_int_msk_s cn38xxp2;
+	struct cvmx_stxx_int_msk_s cn58xx;
+	struct cvmx_stxx_int_msk_s cn58xxp1;
+};
+
+union cvmx_stxx_int_reg {
+	uint64_t u64;
+	struct cvmx_stxx_int_reg_s {
+		uint64_t reserved_9_63:55;
+		uint64_t syncerr:1;
+		uint64_t frmerr:1;
+		uint64_t unxfrm:1;
+		uint64_t nosync:1;
+		uint64_t diperr:1;
+		uint64_t datovr:1;
+		uint64_t ovrbst:1;
+		uint64_t calpar1:1;
+		uint64_t calpar0:1;
+	} s;
+	struct cvmx_stxx_int_reg_s cn38xx;
+	struct cvmx_stxx_int_reg_s cn38xxp2;
+	struct cvmx_stxx_int_reg_s cn58xx;
+	struct cvmx_stxx_int_reg_s cn58xxp1;
+};
+
+union cvmx_stxx_int_sync {
+	uint64_t u64;
+	struct cvmx_stxx_int_sync_s {
+		uint64_t reserved_8_63:56;
+		uint64_t frmerr:1;
+		uint64_t unxfrm:1;
+		uint64_t nosync:1;
+		uint64_t diperr:1;
+		uint64_t datovr:1;
+		uint64_t ovrbst:1;
+		uint64_t calpar1:1;
+		uint64_t calpar0:1;
+	} s;
+	struct cvmx_stxx_int_sync_s cn38xx;
+	struct cvmx_stxx_int_sync_s cn38xxp2;
+	struct cvmx_stxx_int_sync_s cn58xx;
+	struct cvmx_stxx_int_sync_s cn58xxp1;
+};
+
+union cvmx_stxx_min_bst {
+	uint64_t u64;
+	struct cvmx_stxx_min_bst_s {
+		uint64_t reserved_9_63:55;
+		uint64_t minb:9;
+	} s;
+	struct cvmx_stxx_min_bst_s cn38xx;
+	struct cvmx_stxx_min_bst_s cn38xxp2;
+	struct cvmx_stxx_min_bst_s cn58xx;
+	struct cvmx_stxx_min_bst_s cn58xxp1;
+};
+
+union cvmx_stxx_spi4_calx {
+	uint64_t u64;
+	struct cvmx_stxx_spi4_calx_s {
+		uint64_t reserved_17_63:47;
+		uint64_t oddpar:1;
+		uint64_t prt3:4;
+		uint64_t prt2:4;
+		uint64_t prt1:4;
+		uint64_t prt0:4;
+	} s;
+	struct cvmx_stxx_spi4_calx_s cn38xx;
+	struct cvmx_stxx_spi4_calx_s cn38xxp2;
+	struct cvmx_stxx_spi4_calx_s cn58xx;
+	struct cvmx_stxx_spi4_calx_s cn58xxp1;
+};
+
+union cvmx_stxx_spi4_dat {
+	uint64_t u64;
+	struct cvmx_stxx_spi4_dat_s {
+		uint64_t reserved_32_63:32;
+		uint64_t alpha:16;
+		uint64_t max_t:16;
+	} s;
+	struct cvmx_stxx_spi4_dat_s cn38xx;
+	struct cvmx_stxx_spi4_dat_s cn38xxp2;
+	struct cvmx_stxx_spi4_dat_s cn58xx;
+	struct cvmx_stxx_spi4_dat_s cn58xxp1;
+};
+
+union cvmx_stxx_spi4_stat {
+	uint64_t u64;
+	struct cvmx_stxx_spi4_stat_s {
+		uint64_t reserved_16_63:48;
+		uint64_t m:8;
+		uint64_t reserved_7_7:1;
+		uint64_t len:7;
+	} s;
+	struct cvmx_stxx_spi4_stat_s cn38xx;
+	struct cvmx_stxx_spi4_stat_s cn38xxp2;
+	struct cvmx_stxx_spi4_stat_s cn58xx;
+	struct cvmx_stxx_spi4_stat_s cn58xxp1;
+};
+
+union cvmx_stxx_stat_bytes_hi {
+	uint64_t u64;
+	struct cvmx_stxx_stat_bytes_hi_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_stxx_stat_bytes_hi_s cn38xx;
+	struct cvmx_stxx_stat_bytes_hi_s cn38xxp2;
+	struct cvmx_stxx_stat_bytes_hi_s cn58xx;
+	struct cvmx_stxx_stat_bytes_hi_s cn58xxp1;
+};
+
+union cvmx_stxx_stat_bytes_lo {
+	uint64_t u64;
+	struct cvmx_stxx_stat_bytes_lo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_stxx_stat_bytes_lo_s cn38xx;
+	struct cvmx_stxx_stat_bytes_lo_s cn38xxp2;
+	struct cvmx_stxx_stat_bytes_lo_s cn58xx;
+	struct cvmx_stxx_stat_bytes_lo_s cn58xxp1;
+};
+
+union cvmx_stxx_stat_ctl {
+	uint64_t u64;
+	struct cvmx_stxx_stat_ctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t clr:1;
+		uint64_t bckprs:4;
+	} s;
+	struct cvmx_stxx_stat_ctl_s cn38xx;
+	struct cvmx_stxx_stat_ctl_s cn38xxp2;
+	struct cvmx_stxx_stat_ctl_s cn58xx;
+	struct cvmx_stxx_stat_ctl_s cn58xxp1;
+};
+
+union cvmx_stxx_stat_pkt_xmt {
+	uint64_t u64;
+	struct cvmx_stxx_stat_pkt_xmt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_stxx_stat_pkt_xmt_s cn38xx;
+	struct cvmx_stxx_stat_pkt_xmt_s cn38xxp2;
+	struct cvmx_stxx_stat_pkt_xmt_s cn58xx;
+	struct cvmx_stxx_stat_pkt_xmt_s cn58xxp1;
+};
+
+#endif
diff --git a/drivers/staging/octeon/cvmx-wqe.h b/drivers/staging/octeon/cvmx-wqe.h
new file mode 100644
index 0000000..6536109
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-wqe.h
@@ -0,0 +1,397 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * This header file defines the work queue entry (wqe) data structure.
+ * Since this is a commonly used structure that depends on structures
+ * from several hardware blocks, those definitions have been placed
+ * in this file to create a single point of definition of the wqe
+ * format.
+ * Data structures are still named according to the block that they
+ * relate to.
+ *
+ */
+
+#ifndef __CVMX_WQE_H__
+#define __CVMX_WQE_H__
+
+#include "cvmx-packet.h"
+
+
+#define OCT_TAG_TYPE_STRING(x)						\
+	(((x) == CVMX_POW_TAG_TYPE_ORDERED) ?  "ORDERED" :		\
+		(((x) == CVMX_POW_TAG_TYPE_ATOMIC) ?  "ATOMIC" :	\
+			(((x) == CVMX_POW_TAG_TYPE_NULL) ?  "NULL" :	\
+				"NULL_NULL")))
+
+/**
+ * HW decode / err_code in work queue entry
+ */
+typedef union {
+	uint64_t u64;
+
+	/* Use this struct if the hardware determines that the packet is IP */
+	struct {
+		/* HW sets this to the number of buffers used by this packet */
+		uint64_t bufs:8;
+		/* HW sets to the number of L2 bytes prior to the IP */
+		uint64_t ip_offset:8;
+		/* set to 1 if we found DSA/VLAN in the L2 */
+		uint64_t vlan_valid:1;
+		/* Set to 1 if the DSA/VLAN tag is stacked */
+		uint64_t vlan_stacked:1;
+		uint64_t unassigned:1;
+		/* HW sets to the DSA/VLAN CFI flag (valid when vlan_valid) */
+		uint64_t vlan_cfi:1;
+		/* HW sets to the DSA/VLAN_ID field (valid when vlan_valid) */
+		uint64_t vlan_id:12;
+		/* Ring Identifier (if PCIe). Requires PIP_GBL_CTL[RING_EN]=1 */
+		uint64_t pr:4;
+		uint64_t unassigned2:8;
+		/* the packet needs to be decompressed */
+		uint64_t dec_ipcomp:1;
+		/* the packet is either TCP or UDP */
+		uint64_t tcp_or_udp:1;
+		/* the packet needs to be decrypted (ESP or AH) */
+		uint64_t dec_ipsec:1;
+		/* the packet is IPv6 */
+		uint64_t is_v6:1;
+
+		/*
+		 * (rcv_error, not_IP, IP_exc, is_frag, L4_error,
+		 * software, etc.).
+		 */
+
+		/*
+		 * reserved for software use, hardware will clear on
+		 * packet creation.
+		 */
+		uint64_t software:1;
+		/* exceptional conditions below */
+		/* the receive interface hardware detected an L4 error
+		 * (only applies if !is_frag) (only applies if
+		 * !rcv_error && !not_IP && !IP_exc && !is_frag)
+		 * failure indicated in err_code below, decode:
+		 *
+		 * - 1 = Malformed L4
+		 * - 2 = L4 Checksum Error: the L4 checksum value is
+		 * - 3 = UDP Length Error: The UDP length field would
+		 *       make the UDP data longer than what remains in
+		 *       the IP packet (as defined by the IP header
+		 *       length field).
+		 * - 4 = Bad L4 Port: either the source or destination
+		 *       TCP/UDP port is 0.
+		 * - 8 = TCP FIN Only: the packet is TCP and only the
+		 *       FIN flag set.
+		 * - 9 = TCP No Flags: the packet is TCP and no flags
+		 *       are set.
+		 * - 10 = TCP FIN RST: the packet is TCP and both FIN
+		 *        and RST are set.
+		 * - 11 = TCP SYN URG: the packet is TCP and both SYN
+		 *        and URG are set.
+		 * - 12 = TCP SYN RST: the packet is TCP and both SYN
+		 *        and RST are set.
+		 * - 13 = TCP SYN FIN: the packet is TCP and both SYN
+		 *        and FIN are set.
+		 */
+		uint64_t L4_error:1;
+		/* set if the packet is a fragment */
+		uint64_t is_frag:1;
+		/* the receive interface hardware detected an IP error
+		 * / exception (only applies if !rcv_error && !not_IP)
+		 * failure indicated in err_code below, decode:
+		 *
+		 * - 1 = Not IP: the IP version field is neither 4 nor
+		 *       6.
+		 * - 2 = IPv4 Header Checksum Error: the IPv4 header
+		 *       has a checksum violation.
+		 * - 3 = IP Malformed Header: the packet is not long
+		 *       enough to contain the IP header.
+		 * - 4 = IP Malformed: the packet is not long enough
+		 *	 to contain the bytes indicated by the IP
+		 *	 header. Pad is allowed.
+		 * - 5 = IP TTL Hop: the IPv4 TTL field or the IPv6
+		 *       Hop Count field are zero.
+		 * - 6 = IP Options
+		 */
+		uint64_t IP_exc:1;
+		/*
+		 * Set if the hardware determined that the packet is a
+		 * broadcast.
+		 */
+		uint64_t is_bcast:1;
+		/*
+		 * St if the hardware determined that the packet is a
+		 * multi-cast.
+		 */
+		uint64_t is_mcast:1;
+		/*
+		 * Set if the packet may not be IP (must be zero in
+		 * this case).
+		 */
+		uint64_t not_IP:1;
+		/*
+		 * The receive interface hardware detected a receive
+		 * error (must be zero in this case).
+		 */
+		uint64_t rcv_error:1;
+		/* lower err_code = first-level descriptor of the
+		 * work */
+		/* zero for packet submitted by hardware that isn't on
+		 * the slow path */
+		/* type is cvmx_pip_err_t */
+		uint64_t err_code:8;
+	} s;
+
+	/* use this to get at the 16 vlan bits */
+	struct {
+		uint64_t unused1:16;
+		uint64_t vlan:16;
+		uint64_t unused2:32;
+	} svlan;
+
+	/*
+	 * use this struct if the hardware could not determine that
+	 * the packet is ip.
+	 */
+	struct {
+		/*
+		 * HW sets this to the number of buffers used by this
+		 * packet.
+		 */
+		uint64_t bufs:8;
+		uint64_t unused:8;
+		/* set to 1 if we found DSA/VLAN in the L2 */
+		uint64_t vlan_valid:1;
+		/* Set to 1 if the DSA/VLAN tag is stacked */
+		uint64_t vlan_stacked:1;
+		uint64_t unassigned:1;
+		/*
+		 * HW sets to the DSA/VLAN CFI flag (valid when
+		 * vlan_valid)
+		 */
+		uint64_t vlan_cfi:1;
+		/*
+		 * HW sets to the DSA/VLAN_ID field (valid when
+		 * vlan_valid).
+		 */
+		uint64_t vlan_id:12;
+		/*
+		 * Ring Identifier (if PCIe). Requires
+		 * PIP_GBL_CTL[RING_EN]=1
+		 */
+		uint64_t pr:4;
+		uint64_t unassigned2:12;
+		/*
+		 * reserved for software use, hardware will clear on
+		 * packet creation.
+		 */
+		uint64_t software:1;
+		uint64_t unassigned3:1;
+		/*
+		 * set if the hardware determined that the packet is
+		 * rarp.
+		 */
+		uint64_t is_rarp:1;
+		/*
+		 * set if the hardware determined that the packet is
+		 * arp
+		 */
+		uint64_t is_arp:1;
+		/*
+		 * set if the hardware determined that the packet is a
+		 * broadcast.
+		 */
+		uint64_t is_bcast:1;
+		/*
+		 * set if the hardware determined that the packet is a
+		 * multi-cast
+		 */
+		uint64_t is_mcast:1;
+		/*
+		 * set if the packet may not be IP (must be one in
+		 * this case)
+		 */
+		uint64_t not_IP:1;
+		/* The receive interface hardware detected a receive
+		 * error.  Failure indicated in err_code below,
+		 * decode:
+		 *
+		 * - 1 = partial error: a packet was partially
+		 *       received, but internal buffering / bandwidth
+		 *       was not adequate to receive the entire
+		 *       packet.
+		 * - 2 = jabber error: the RGMII packet was too large
+		 *       and is truncated.
+		 * - 3 = overrun error: the RGMII packet is longer
+		 *       than allowed and had an FCS error.
+		 * - 4 = oversize error: the RGMII packet is longer
+		 *       than allowed.
+		 * - 5 = alignment error: the RGMII packet is not an
+		 *       integer number of bytes
+		 *       and had an FCS error (100M and 10M only).
+		 * - 6 = fragment error: the RGMII packet is shorter
+		 *       than allowed and had an FCS error.
+		 * - 7 = GMX FCS error: the RGMII packet had an FCS
+		 *       error.
+		 * - 8 = undersize error: the RGMII packet is shorter
+		 *       than allowed.
+		 * - 9 = extend error: the RGMII packet had an extend
+		 *       error.
+		 * - 10 = length mismatch error: the RGMII packet had
+		 *        a length that did not match the length field
+		 *        in the L2 HDR.
+		 * - 11 = RGMII RX error/SPI4 DIP4 Error: the RGMII
+		 * 	  packet had one or more data reception errors
+		 * 	  (RXERR) or the SPI4 packet had one or more
+		 * 	  DIP4 errors.
+		 * - 12 = RGMII skip error/SPI4 Abort Error: the RGMII
+		 *        packet was not large enough to cover the
+		 *        skipped bytes or the SPI4 packet was
+		 *        terminated with an About EOPS.
+		 * - 13 = RGMII nibble error/SPI4 Port NXA Error: the
+		 *        RGMII packet had a studder error (data not
+		 *        repeated - 10/100M only) or the SPI4 packet
+		 *        was sent to an NXA.
+		 * - 16 = FCS error: a SPI4.2 packet had an FCS error.
+		 * - 17 = Skip error: a packet was not large enough to
+		 *        cover the skipped bytes.
+		 * - 18 = L2 header malformed: the packet is not long
+		 *        enough to contain the L2.
+		 */
+
+		uint64_t rcv_error:1;
+		/*
+		 * lower err_code = first-level descriptor of the
+		 * work
+		 */
+		/*
+		 * zero for packet submitted by hardware that isn't on
+		 * the slow path
+		 */
+		/* type is cvmx_pip_err_t (union, so can't use directly */
+		uint64_t err_code:8;
+	} snoip;
+
+} cvmx_pip_wqe_word2;
+
+/**
+ * Work queue entry format
+ *
+ * must be 8-byte aligned
+ */
+typedef struct {
+
+    /*****************************************************************
+     * WORD 0
+     *  HW WRITE: the following 64 bits are filled by HW when a packet arrives
+     */
+
+    /**
+     * raw chksum result generated by the HW
+     */
+	uint16_t hw_chksum;
+    /**
+     * Field unused by hardware - available for software
+     */
+	uint8_t unused;
+    /**
+     * Next pointer used by hardware for list maintenance.
+     * May be written/read by HW before the work queue
+     *           entry is scheduled to a PP
+     * (Only 36 bits used in Octeon 1)
+     */
+	uint64_t next_ptr:40;
+
+    /*****************************************************************
+     * WORD 1
+     *  HW WRITE: the following 64 bits are filled by HW when a packet arrives
+     */
+
+    /**
+     * HW sets to the total number of bytes in the packet
+     */
+	uint64_t len:16;
+    /**
+     * HW sets this to input physical port
+     */
+	uint64_t ipprt:6;
+
+    /**
+     * HW sets this to what it thought the priority of the input packet was
+     */
+	uint64_t qos:3;
+
+    /**
+     * the group that the work queue entry will be scheduled to
+     */
+	uint64_t grp:4;
+    /**
+     * the type of the tag (ORDERED, ATOMIC, NULL)
+     */
+	uint64_t tag_type:3;
+    /**
+     * the synchronization/ordering tag
+     */
+	uint64_t tag:32;
+
+    /**
+     * WORD 2 HW WRITE: the following 64-bits are filled in by
+     *   hardware when a packet arrives This indicates a variety of
+     *   status and error conditions.
+     */
+	cvmx_pip_wqe_word2 word2;
+
+    /**
+     * Pointer to the first segment of the packet.
+     */
+	union cvmx_buf_ptr packet_ptr;
+
+    /**
+     *   HW WRITE: octeon will fill in a programmable amount from the
+     *             packet, up to (at most, but perhaps less) the amount
+     *             needed to fill the work queue entry to 128 bytes
+     *
+     *   If the packet is recognized to be IP, the hardware starts
+     *   (except that the IPv4 header is padded for appropriate
+     *   alignment) writing here where the IP header starts.  If the
+     *   packet is not recognized to be IP, the hardware starts
+     *   writing the beginning of the packet here.
+     */
+	uint8_t packet_data[96];
+
+    /**
+     * If desired, SW can make the work Q entry any length. For the
+     * purposes of discussion here, Assume 128B always, as this is all that
+     * the hardware deals with.
+     *
+     */
+
+} CVMX_CACHE_LINE_ALIGNED cvmx_wqe_t;
+
+#endif /* __CVMX_WQE_H__ */
diff --git a/drivers/staging/octeon/ethernet-common.c b/drivers/staging/octeon/ethernet-common.c
new file mode 100644
index 0000000..3e6f5b8
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-common.c
@@ -0,0 +1,328 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <net/dst.h>
+
+#include <asm/atomic.h>
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "ethernet-tx.h"
+#include "ethernet-mdio.h"
+#include "ethernet-util.h"
+#include "octeon-ethernet.h"
+#include "ethernet-common.h"
+
+#include "cvmx-pip.h"
+#include "cvmx-pko.h"
+#include "cvmx-fau.h"
+#include "cvmx-helper.h"
+
+#include "cvmx-gmxx-defs.h"
+
+/**
+ * Get the low level ethernet statistics
+ *
+ * @dev:    Device to get the statistics from
+ * Returns Pointer to the statistics
+ */
+static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
+{
+	cvmx_pip_port_status_t rx_status;
+	cvmx_pko_port_status_t tx_status;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+
+	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
+		if (octeon_is_simulation()) {
+			/* The simulator doesn't support statistics */
+			memset(&rx_status, 0, sizeof(rx_status));
+			memset(&tx_status, 0, sizeof(tx_status));
+		} else {
+			cvmx_pip_get_port_status(priv->port, 1, &rx_status);
+			cvmx_pko_get_port_status(priv->port, 1, &tx_status);
+		}
+
+		priv->stats.rx_packets += rx_status.inb_packets;
+		priv->stats.tx_packets += tx_status.packets;
+		priv->stats.rx_bytes += rx_status.inb_octets;
+		priv->stats.tx_bytes += tx_status.octets;
+		priv->stats.multicast += rx_status.multicast_packets;
+		priv->stats.rx_crc_errors += rx_status.inb_errors;
+		priv->stats.rx_frame_errors += rx_status.fcs_align_err_packets;
+
+		/*
+		 * The drop counter must be incremented atomically
+		 * since the RX tasklet also increments it.
+		 */
+#ifdef CONFIG_64BIT
+		atomic64_add(rx_status.dropped_packets,
+			     (atomic64_t *)&priv->stats.rx_dropped);
+#else
+		atomic_add(rx_status.dropped_packets,
+			     (atomic_t *)&priv->stats.rx_dropped);
+#endif
+	}
+
+	return &priv->stats;
+}
+
+/**
+ * Set the multicast list. Currently unimplemented.
+ *
+ * @dev:    Device to work on
+ */
+static void cvm_oct_common_set_multicast_list(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	if ((interface < 2)
+	    && (cvmx_helper_interface_get_mode(interface) !=
+		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+		union cvmx_gmxx_rxx_adr_ctl control;
+		control.u64 = 0;
+		control.s.bcst = 1;	/* Allow broadcast MAC addresses */
+
+		if (dev->mc_list || (dev->flags & IFF_ALLMULTI) ||
+		    (dev->flags & IFF_PROMISC))
+			/* Force accept multicast packets */
+			control.s.mcst = 2;
+		else
+			/* Force reject multicat packets */
+			control.s.mcst = 1;
+
+		if (dev->flags & IFF_PROMISC)
+			/*
+			 * Reject matches if promisc. Since CAM is
+			 * shut off, should accept everything.
+			 */
+			control.s.cam_mode = 0;
+		else
+			/* Filter packets based on the CAM */
+			control.s.cam_mode = 1;
+
+		gmx_cfg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmx_cfg.u64 & ~1ull);
+
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CTL(index, interface),
+			       control.u64);
+		if (dev->flags & IFF_PROMISC)
+			cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN
+				       (index, interface), 0);
+		else
+			cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN
+				       (index, interface), 1);
+
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmx_cfg.u64);
+	}
+}
+
+/**
+ * Set the hardware MAC address for a device
+ *
+ * @dev:    Device to change the MAC address for
+ * @addr:   Address structure to change it too. MAC address is addr + 2.
+ * Returns Zero on success
+ */
+static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	memcpy(dev->dev_addr, addr + 2, 6);
+
+	if ((interface < 2)
+	    && (cvmx_helper_interface_get_mode(interface) !=
+		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+		int i;
+		uint8_t *ptr = addr;
+		uint64_t mac = 0;
+		for (i = 0; i < 6; i++)
+			mac = (mac << 8) | (uint64_t) (ptr[i + 2]);
+
+		gmx_cfg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmx_cfg.u64 & ~1ull);
+
+		cvmx_write_csr(CVMX_GMXX_SMACX(index, interface), mac);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM0(index, interface),
+			       ptr[2]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM1(index, interface),
+			       ptr[3]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM2(index, interface),
+			       ptr[4]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM3(index, interface),
+			       ptr[5]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM4(index, interface),
+			       ptr[6]);
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM5(index, interface),
+			       ptr[7]);
+		cvm_oct_common_set_multicast_list(dev);
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
+			       gmx_cfg.u64);
+	}
+	return 0;
+}
+
+/**
+ * Change the link MTU. Unimplemented
+ *
+ * @dev:     Device to change
+ * @new_mtu: The new MTU
+ *
+ * Returns Zero on success
+ */
+static int cvm_oct_common_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	int vlan_bytes = 4;
+#else
+	int vlan_bytes = 0;
+#endif
+
+	/*
+	 * Limit the MTU to make sure the ethernet packets are between
+	 * 64 bytes and 65535 bytes.
+	 */
+	if ((new_mtu + 14 + 4 + vlan_bytes < 64)
+	    || (new_mtu + 14 + 4 + vlan_bytes > 65392)) {
+		pr_err("MTU must be between %d and %d.\n",
+		       64 - 14 - 4 - vlan_bytes, 65392 - 14 - 4 - vlan_bytes);
+		return -EINVAL;
+	}
+	dev->mtu = new_mtu;
+
+	if ((interface < 2)
+	    && (cvmx_helper_interface_get_mode(interface) !=
+		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+		/* Add ethernet header and FCS, and VLAN if configured. */
+		int max_packet = new_mtu + 14 + 4 + vlan_bytes;
+
+		if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
+		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+			/* Signal errors on packets larger than the MTU */
+			cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX(index, interface),
+				       max_packet);
+		} else {
+			/*
+			 * Set the hardware to truncate packets larger
+			 * than the MTU and smaller the 64 bytes.
+			 */
+			union cvmx_pip_frm_len_chkx frm_len_chk;
+			frm_len_chk.u64 = 0;
+			frm_len_chk.s.minlen = 64;
+			frm_len_chk.s.maxlen = max_packet;
+			cvmx_write_csr(CVMX_PIP_FRM_LEN_CHKX(interface),
+				       frm_len_chk.u64);
+		}
+		/*
+		 * Set the hardware to truncate packets larger than
+		 * the MTU. The jabber register must be set to a
+		 * multiple of 8 bytes, so round up.
+		 */
+		cvmx_write_csr(CVMX_GMXX_RXX_JABBER(index, interface),
+			       (max_packet + 7) & ~7u);
+	}
+	return 0;
+}
+
+/**
+ * Per network device initialization
+ *
+ * @dev:    Device to initialize
+ * Returns Zero on success
+ */
+int cvm_oct_common_init(struct net_device *dev)
+{
+	static int count;
+	char mac[8] = { 0x00, 0x00,
+		octeon_bootinfo->mac_addr_base[0],
+		octeon_bootinfo->mac_addr_base[1],
+		octeon_bootinfo->mac_addr_base[2],
+		octeon_bootinfo->mac_addr_base[3],
+		octeon_bootinfo->mac_addr_base[4],
+		octeon_bootinfo->mac_addr_base[5] + count
+	};
+	struct octeon_ethernet *priv = netdev_priv(dev);
+
+	/*
+	 * Force the interface to use the POW send if always_use_pow
+	 * was specified or it is in the pow send list.
+	 */
+	if ((pow_send_group != -1)
+	    && (always_use_pow || strstr(pow_send_list, dev->name)))
+		priv->queue = -1;
+
+	if (priv->queue != -1) {
+		dev->hard_start_xmit = cvm_oct_xmit;
+		if (USE_HW_TCPUDP_CHECKSUM)
+			dev->features |= NETIF_F_IP_CSUM;
+	} else
+		dev->hard_start_xmit = cvm_oct_xmit_pow;
+	count++;
+
+	dev->get_stats = cvm_oct_common_get_stats;
+	dev->set_mac_address = cvm_oct_common_set_mac_address;
+	dev->set_multicast_list = cvm_oct_common_set_multicast_list;
+	dev->change_mtu = cvm_oct_common_change_mtu;
+	dev->do_ioctl = cvm_oct_ioctl;
+	/* We do our own locking, Linux doesn't need to */
+	dev->features |= NETIF_F_LLTX;
+	SET_ETHTOOL_OPS(dev, &cvm_oct_ethtool_ops);
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = cvm_oct_poll_controller;
+#endif
+
+	cvm_oct_mdio_setup_device(dev);
+	dev->set_mac_address(dev, mac);
+	dev->change_mtu(dev, dev->mtu);
+
+	/*
+	 * Zero out stats for port so we won't mistakenly show
+	 * counters from the bootloader.
+	 */
+	memset(dev->get_stats(dev), 0, sizeof(struct net_device_stats));
+
+	return 0;
+}
+
+void cvm_oct_common_uninit(struct net_device *dev)
+{
+	/* Currently nothing to do */
+}
diff --git a/drivers/staging/octeon/ethernet-common.h b/drivers/staging/octeon/ethernet-common.h
new file mode 100644
index 0000000..2bd9cd7
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-common.h
@@ -0,0 +1,29 @@
+/*********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+*********************************************************************/
+
+int cvm_oct_common_init(struct net_device *dev);
+void cvm_oct_common_uninit(struct net_device *dev);
diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
new file mode 100644
index 0000000..8f7374e
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -0,0 +1,134 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+
+/*
+ * A few defines are used to control the operation of this driver:
+ *  CONFIG_CAVIUM_RESERVE32
+ *      This kernel config options controls the amount of memory configured
+ *      in a wired TLB entry for all processes to share. If this is set, the
+ *      driver will use this memory instead of kernel memory for pools. This
+ *      allows 32bit userspace application to access the buffers, but also
+ *      requires all received packets to be copied.
+ *  CONFIG_CAVIUM_OCTEON_NUM_PACKET_BUFFERS
+ *      This kernel config option allows the user to control the number of
+ *      packet and work queue buffers allocated by the driver. If this is zero,
+ *      the driver uses the default from below.
+ *  USE_SKBUFFS_IN_HW
+ *      Tells the driver to populate the packet buffers with kernel skbuffs.
+ *      This allows the driver to receive packets without copying them. It also
+ *      means that 32bit userspace can't access the packet buffers.
+ *  USE_32BIT_SHARED
+ *      This define tells the driver to allocate memory for buffers from the
+ *      32bit sahred region instead of the kernel memory space.
+ *  USE_HW_TCPUDP_CHECKSUM
+ *      Controls if the Octeon TCP/UDP checksum engine is used for packet
+ *      output. If this is zero, the kernel will perform the checksum in
+ *      software.
+ *  USE_MULTICORE_RECEIVE
+ *      Process receive interrupts on multiple cores. This spreads the network
+ *      load across the first 8 processors. If ths is zero, only one core
+ *      processes incomming packets.
+ *  USE_ASYNC_IOBDMA
+ *      Use asynchronous IO access to hardware. This uses Octeon's asynchronous
+ *      IOBDMAs to issue IO accesses without stalling. Set this to zero
+ *      to disable this. Note that IOBDMAs require CVMSEG.
+ *  REUSE_SKBUFFS_WITHOUT_FREE
+ *      Allows the TX path to free an skbuff into the FPA hardware pool. This
+ *      can significantly improve performance for forwarding and bridging, but
+ *      may be somewhat dangerous. Checks are made, but if any buffer is reused
+ *      without the proper Linux cleanup, the networking stack may have very
+ *      bizarre bugs.
+ */
+#ifndef __ETHERNET_DEFINES_H__
+#define __ETHERNET_DEFINES_H__
+
+#include "cvmx-config.h"
+
+
+#define OCTEON_ETHERNET_VERSION "1.9"
+
+#ifndef CONFIG_CAVIUM_RESERVE32
+#define CONFIG_CAVIUM_RESERVE32 0
+#endif
+
+#if CONFIG_CAVIUM_RESERVE32
+#define USE_32BIT_SHARED            1
+#define USE_SKBUFFS_IN_HW           0
+#define REUSE_SKBUFFS_WITHOUT_FREE  0
+#else
+#define USE_32BIT_SHARED            0
+#define USE_SKBUFFS_IN_HW           1
+#ifdef CONFIG_NETFILTER
+#define REUSE_SKBUFFS_WITHOUT_FREE  0
+#else
+#define REUSE_SKBUFFS_WITHOUT_FREE  1
+#endif
+#endif
+
+/* Max interrupts per second per core */
+#define INTERRUPT_LIMIT             10000
+
+/* Don't limit the number of interrupts */
+/*#define INTERRUPT_LIMIT             0     */
+#define USE_HW_TCPUDP_CHECKSUM      1
+
+#define USE_MULTICORE_RECEIVE       1
+
+/* Enable Random Early Dropping under load */
+#define USE_RED                     1
+#define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
+
+/*
+ * Allow SW based preamble removal at 10Mbps to workaround PHYs giving
+ * us bad preambles.
+ */
+#define USE_10MBPS_PREAMBLE_WORKAROUND 1
+/*
+ * Use this to have all FPA frees also tell the L2 not to write data
+ * to memory.
+ */
+#define DONT_WRITEBACK(x)           (x)
+/* Use this to not have FPA frees control L2 */
+/*#define DONT_WRITEBACK(x)         0   */
+
+/* Maximum number of packets to process per interrupt. */
+#define MAX_RX_PACKETS 120
+#define MAX_OUT_QUEUE_DEPTH 1000
+
+#ifndef CONFIG_SMP
+#undef USE_MULTICORE_RECEIVE
+#define USE_MULTICORE_RECEIVE 0
+#endif
+
+#define IP_PROTOCOL_TCP             6
+#define IP_PROTOCOL_UDP             0x11
+
+#define FAU_NUM_PACKET_BUFFERS_TO_FREE (CVMX_FAU_REG_END - sizeof(uint32_t))
+#define TOTAL_NUMBER_OF_PORTS       (CVMX_PIP_NUM_INPUT_PORTS+1)
+
+
+#endif /* __ETHERNET_DEFINES_H__ */
diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
new file mode 100644
index 0000000..93cab0a
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -0,0 +1,231 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <net/dst.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "octeon-ethernet.h"
+#include "ethernet-mdio.h"
+
+#include "cvmx-helper-board.h"
+
+#include "cvmx-smix-defs.h"
+
+DECLARE_MUTEX(mdio_sem);
+
+/**
+ * Perform an MII read. Called by the generic MII routines
+ *
+ * @dev:      Device to perform read for
+ * @phy_id:   The MII phy id
+ * @location: Register location to read
+ * Returns Result from the read or zero on failure
+ */
+static int cvm_oct_mdio_read(struct net_device *dev, int phy_id, int location)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_rd_dat smi_rd;
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = 1;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = location;
+	cvmx_write_csr(CVMX_SMIX_CMD(0), smi_cmd.u64);
+
+	do {
+		if (!in_interrupt())
+			yield();
+		smi_rd.u64 = cvmx_read_csr(CVMX_SMIX_RD_DAT(0));
+	} while (smi_rd.s.pending);
+
+	if (smi_rd.s.val)
+		return smi_rd.s.dat;
+	else
+		return 0;
+}
+
+static int cvm_oct_mdio_dummy_read(struct net_device *dev, int phy_id,
+				   int location)
+{
+	return 0xffff;
+}
+
+/**
+ * Perform an MII write. Called by the generic MII routines
+ *
+ * @dev:      Device to perform write for
+ * @phy_id:   The MII phy id
+ * @location: Register location to write
+ * @val:      Value to write
+ */
+static void cvm_oct_mdio_write(struct net_device *dev, int phy_id, int location,
+			       int val)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_wr_dat smi_wr;
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = val;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(0), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = 0;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = location;
+	cvmx_write_csr(CVMX_SMIX_CMD(0), smi_cmd.u64);
+
+	do {
+		if (!in_interrupt())
+			yield();
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(0));
+	} while (smi_wr.s.pending);
+}
+
+static void cvm_oct_mdio_dummy_write(struct net_device *dev, int phy_id,
+				     int location, int val)
+{
+}
+
+static void cvm_oct_get_drvinfo(struct net_device *dev,
+				struct ethtool_drvinfo *info)
+{
+	strcpy(info->driver, "cavium-ethernet");
+	strcpy(info->version, OCTEON_ETHERNET_VERSION);
+	strcpy(info->bus_info, "Builtin");
+}
+
+static int cvm_oct_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int ret;
+
+	down(&mdio_sem);
+	ret = mii_ethtool_gset(&priv->mii_info, cmd);
+	up(&mdio_sem);
+
+	return ret;
+}
+
+static int cvm_oct_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int ret;
+
+	down(&mdio_sem);
+	ret = mii_ethtool_sset(&priv->mii_info, cmd);
+	up(&mdio_sem);
+
+	return ret;
+}
+
+static int cvm_oct_nway_reset(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int ret;
+
+	down(&mdio_sem);
+	ret = mii_nway_restart(&priv->mii_info);
+	up(&mdio_sem);
+
+	return ret;
+}
+
+static u32 cvm_oct_get_link(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	u32 ret;
+
+	down(&mdio_sem);
+	ret = mii_link_ok(&priv->mii_info);
+	up(&mdio_sem);
+
+	return ret;
+}
+
+struct ethtool_ops cvm_oct_ethtool_ops = {
+	.get_drvinfo = cvm_oct_get_drvinfo,
+	.get_settings = cvm_oct_get_settings,
+	.set_settings = cvm_oct_set_settings,
+	.nway_reset = cvm_oct_nway_reset,
+	.get_link = cvm_oct_get_link,
+	.get_sg = ethtool_op_get_sg,
+	.get_tx_csum = ethtool_op_get_tx_csum,
+};
+
+/**
+ * IOCTL support for PHY control
+ *
+ * @dev:    Device to change
+ * @rq:     the request
+ * @cmd:    the command
+ * Returns Zero on success
+ */
+int cvm_oct_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	struct mii_ioctl_data *data = if_mii(rq);
+	unsigned int duplex_chg;
+	int ret;
+
+	down(&mdio_sem);
+	ret = generic_mii_ioctl(&priv->mii_info, data, cmd, &duplex_chg);
+	up(&mdio_sem);
+
+	return ret;
+}
+
+/**
+ * Setup the MDIO device structures
+ *
+ * @dev:    Device to setup
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvm_oct_mdio_setup_device(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int phy_id = cvmx_helper_board_get_mii_address(priv->port);
+	if (phy_id != -1) {
+		priv->mii_info.dev = dev;
+		priv->mii_info.phy_id = phy_id;
+		priv->mii_info.phy_id_mask = 0xff;
+		priv->mii_info.supports_gmii = 1;
+		priv->mii_info.reg_num_mask = 0x1f;
+		priv->mii_info.mdio_read = cvm_oct_mdio_read;
+		priv->mii_info.mdio_write = cvm_oct_mdio_write;
+	} else {
+		/* Supply dummy MDIO routines so the kernel won't crash
+		   if the user tries to read them */
+		priv->mii_info.mdio_read = cvm_oct_mdio_dummy_read;
+		priv->mii_info.mdio_write = cvm_oct_mdio_dummy_write;
+	}
+	return 0;
+}
diff --git a/drivers/staging/octeon/ethernet-mdio.h b/drivers/staging/octeon/ethernet-mdio.h
new file mode 100644
index 0000000..6314141
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-mdio.h
@@ -0,0 +1,46 @@
+/*********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+*********************************************************************/
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/init.h>
+#include <linux/etherdevice.h>
+#include <linux/ip.h>
+#include <linux/string.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <net/dst.h>
+#ifdef CONFIG_XFRM
+#include <linux/xfrm.h>
+#include <net/xfrm.h>
+#endif /* CONFIG_XFRM */
+
+extern struct ethtool_ops cvm_oct_ethtool_ops;
+int cvm_oct_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+int cvm_oct_mdio_setup_device(struct net_device *dev);
diff --git a/drivers/staging/octeon/ethernet-mem.c b/drivers/staging/octeon/ethernet-mem.c
new file mode 100644
index 0000000..b595903
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-mem.c
@@ -0,0 +1,198 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/mii.h>
+#include <net/dst.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+
+#include "cvmx-fpa.h"
+
+/**
+ * Fill the supplied hardware pool with skbuffs
+ *
+ * @pool:     Pool to allocate an skbuff for
+ * @size:     Size of the buffer needed for the pool
+ * @elements: Number of buffers to allocate
+ */
+static int cvm_oct_fill_hw_skbuff(int pool, int size, int elements)
+{
+	int freed = elements;
+	while (freed) {
+
+		struct sk_buff *skb = dev_alloc_skb(size + 128);
+		if (unlikely(skb == NULL)) {
+			pr_warning
+			    ("Failed to allocate skb for hardware pool %d\n",
+			     pool);
+			break;
+		}
+
+		skb_reserve(skb, 128 - (((unsigned long)skb->data) & 0x7f));
+		*(struct sk_buff **)(skb->data - sizeof(void *)) = skb;
+		cvmx_fpa_free(skb->data, pool, DONT_WRITEBACK(size / 128));
+		freed--;
+	}
+	return elements - freed;
+}
+
+/**
+ * Free the supplied hardware pool of skbuffs
+ *
+ * @pool:     Pool to allocate an skbuff for
+ * @size:     Size of the buffer needed for the pool
+ * @elements: Number of buffers to allocate
+ */
+static void cvm_oct_free_hw_skbuff(int pool, int size, int elements)
+{
+	char *memory;
+
+	do {
+		memory = cvmx_fpa_alloc(pool);
+		if (memory) {
+			struct sk_buff *skb =
+			    *(struct sk_buff **)(memory - sizeof(void *));
+			elements--;
+			dev_kfree_skb(skb);
+		}
+	} while (memory);
+
+	if (elements < 0)
+		pr_warning("Freeing of pool %u had too many skbuffs (%d)\n",
+		     pool, elements);
+	else if (elements > 0)
+		pr_warning("Freeing of pool %u is missing %d skbuffs\n",
+		       pool, elements);
+}
+
+/**
+ * This function fills a hardware pool with memory. Depending
+ * on the config defines, this memory might come from the
+ * kernel or global 32bit memory allocated with
+ * cvmx_bootmem_alloc.
+ *
+ * @pool:     Pool to populate
+ * @size:     Size of each buffer in the pool
+ * @elements: Number of buffers to allocate
+ */
+static int cvm_oct_fill_hw_memory(int pool, int size, int elements)
+{
+	char *memory;
+	int freed = elements;
+
+	if (USE_32BIT_SHARED) {
+		extern uint64_t octeon_reserve32_memory;
+
+		memory =
+		    cvmx_bootmem_alloc_range(elements * size, 128,
+					     octeon_reserve32_memory,
+					     octeon_reserve32_memory +
+					     (CONFIG_CAVIUM_RESERVE32 << 20) -
+					     1);
+		if (memory == NULL)
+			panic("Unable to allocate %u bytes for FPA pool %d\n",
+			      elements * size, pool);
+
+		pr_notice("Memory range %p - %p reserved for "
+			  "hardware\n", memory,
+			  memory + elements * size - 1);
+
+		while (freed) {
+			cvmx_fpa_free(memory, pool, 0);
+			memory += size;
+			freed--;
+		}
+	} else {
+		while (freed) {
+			/* We need to force alignment to 128 bytes here */
+			memory = kmalloc(size + 127, GFP_ATOMIC);
+			if (unlikely(memory == NULL)) {
+				pr_warning("Unable to allocate %u bytes for "
+					   "FPA pool %d\n",
+				     elements * size, pool);
+				break;
+			}
+			memory = (char *)(((unsigned long)memory + 127) & -128);
+			cvmx_fpa_free(memory, pool, 0);
+			freed--;
+		}
+	}
+	return elements - freed;
+}
+
+/**
+ * Free memory previously allocated with cvm_oct_fill_hw_memory
+ *
+ * @pool:     FPA pool to free
+ * @size:     Size of each buffer in the pool
+ * @elements: Number of buffers that should be in the pool
+ */
+static void cvm_oct_free_hw_memory(int pool, int size, int elements)
+{
+	if (USE_32BIT_SHARED) {
+		pr_warning("Warning: 32 shared memory is not freeable\n");
+	} else {
+		char *memory;
+		do {
+			memory = cvmx_fpa_alloc(pool);
+			if (memory) {
+				elements--;
+				kfree(phys_to_virt(cvmx_ptr_to_phys(memory)));
+			}
+		} while (memory);
+
+		if (elements < 0)
+			pr_warning("Freeing of pool %u had too many "
+				   "buffers (%d)\n",
+			       pool, elements);
+		else if (elements > 0)
+			pr_warning("Warning: Freeing of pool %u is "
+				"missing %d buffers\n",
+			     pool, elements);
+	}
+}
+
+int cvm_oct_mem_fill_fpa(int pool, int size, int elements)
+{
+	int freed;
+	if (USE_SKBUFFS_IN_HW)
+		freed = cvm_oct_fill_hw_skbuff(pool, size, elements);
+	else
+		freed = cvm_oct_fill_hw_memory(pool, size, elements);
+	return freed;
+}
+
+void cvm_oct_mem_empty_fpa(int pool, int size, int elements)
+{
+	if (USE_SKBUFFS_IN_HW)
+		cvm_oct_free_hw_skbuff(pool, size, elements);
+	else
+		cvm_oct_free_hw_memory(pool, size, elements);
+}
diff --git a/drivers/staging/octeon/ethernet-mem.h b/drivers/staging/octeon/ethernet-mem.h
new file mode 100644
index 0000000..713f2ed
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-mem.h
@@ -0,0 +1,29 @@
+/*********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+********************************************************************/
+
+int cvm_oct_mem_fill_fpa(int pool, int size, int elements);
+void cvm_oct_mem_empty_fpa(int pool, int size, int elements);
diff --git a/drivers/staging/octeon/ethernet-proc.c b/drivers/staging/octeon/ethernet-proc.c
new file mode 100644
index 0000000..8fa88fc
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-proc.c
@@ -0,0 +1,256 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <net/dst.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "octeon-ethernet.h"
+#include "ethernet-defines.h"
+
+#include "cvmx-helper.h"
+#include "cvmx-pip.h"
+
+static unsigned long long cvm_oct_stats_read_switch(struct net_device *dev,
+						    int phy_id, int offset)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+
+	priv->mii_info.mdio_write(dev, phy_id, 0x1d, 0xcc00 | offset);
+	return ((uint64_t) priv->mii_info.
+		mdio_read(dev, phy_id,
+			  0x1e) << 16) | (uint64_t) priv->mii_info.
+	    mdio_read(dev, phy_id, 0x1f);
+}
+
+static int cvm_oct_stats_switch_show(struct seq_file *m, void *v)
+{
+	static const int ports[] = { 0, 1, 2, 3, 9, -1 };
+	struct net_device *dev = cvm_oct_device[0];
+	int index = 0;
+
+	while (ports[index] != -1) {
+
+		/* Latch port */
+		struct octeon_ethernet *priv = netdev_priv(dev);
+
+		priv->mii_info.mdio_write(dev, 0x1b, 0x1d,
+					  0xdc00 | ports[index]);
+		seq_printf(m, "\nSwitch Port %d\n", ports[index]);
+		seq_printf(m, "InGoodOctets:   %12llu\t"
+			   "OutOctets:      %12llu\t"
+			   "64 Octets:      %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b,
+						     0x00) |
+			   (cvm_oct_stats_read_switch(dev, 0x1b, 0x01) << 32),
+			   cvm_oct_stats_read_switch(dev, 0x1b,
+						     0x0E) |
+			   (cvm_oct_stats_read_switch(dev, 0x1b, 0x0F) << 32),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x08));
+
+		seq_printf(m, "InBadOctets:    %12llu\t"
+			   "OutUnicast:     %12llu\t"
+			   "65-127 Octets:  %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x02),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x10),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x09));
+
+		seq_printf(m, "InUnicast:      %12llu\t"
+			   "OutBroadcasts:  %12llu\t"
+			   "128-255 Octets: %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x04),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x13),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x0A));
+
+		seq_printf(m, "InBroadcasts:   %12llu\t"
+			   "OutMulticasts:  %12llu\t"
+			   "256-511 Octets: %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x06),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x12),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x0B));
+
+		seq_printf(m, "InMulticasts:   %12llu\t"
+			   "OutPause:       %12llu\t"
+			   "512-1023 Octets:%12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x07),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x15),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x0C));
+
+		seq_printf(m, "InPause:        %12llu\t"
+			   "Excessive:      %12llu\t"
+			   "1024-Max Octets:%12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x16),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x11),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x0D));
+
+		seq_printf(m, "InUndersize:    %12llu\t"
+			   "Collisions:     %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x18),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x1E));
+
+		seq_printf(m, "InFragments:    %12llu\t"
+			   "Deferred:       %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x19),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x05));
+
+		seq_printf(m, "InOversize:     %12llu\t"
+			   "Single:         %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x1A),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x14));
+
+		seq_printf(m, "InJabber:       %12llu\t"
+			   "Multiple:       %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x1B),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x17));
+
+		seq_printf(m, "In RxErr:       %12llu\t"
+			   "OutFCSErr:      %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x1C),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x03));
+
+		seq_printf(m, "InFCSErr:       %12llu\t"
+			   "Late:           %12llu\n",
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x1D),
+			   cvm_oct_stats_read_switch(dev, 0x1b, 0x1F));
+		index++;
+	}
+	return 0;
+}
+
+/**
+ * User is reading /proc/octeon_ethernet_stats
+ *
+ * @m:
+ * @v:
+ * Returns
+ */
+static int cvm_oct_stats_show(struct seq_file *m, void *v)
+{
+	struct octeon_ethernet *priv;
+	int port;
+
+	for (port = 0; port < TOTAL_NUMBER_OF_PORTS; port++) {
+
+		if (cvm_oct_device[port]) {
+			priv = netdev_priv(cvm_oct_device[port]);
+
+			seq_printf(m, "\nOcteon Port %d (%s)\n", port,
+				   cvm_oct_device[port]->name);
+			seq_printf(m,
+				   "rx_packets:             %12lu\t"
+				   "tx_packets:             %12lu\n",
+				   priv->stats.rx_packets,
+				   priv->stats.tx_packets);
+			seq_printf(m,
+				   "rx_bytes:               %12lu\t"
+				   "tx_bytes:               %12lu\n",
+				   priv->stats.rx_bytes, priv->stats.tx_bytes);
+			seq_printf(m,
+				   "rx_errors:              %12lu\t"
+				   "tx_errors:              %12lu\n",
+				   priv->stats.rx_errors,
+				   priv->stats.tx_errors);
+			seq_printf(m,
+				   "rx_dropped:             %12lu\t"
+				   "tx_dropped:             %12lu\n",
+				   priv->stats.rx_dropped,
+				   priv->stats.tx_dropped);
+			seq_printf(m,
+				   "rx_length_errors:       %12lu\t"
+				   "tx_aborted_errors:      %12lu\n",
+				   priv->stats.rx_length_errors,
+				   priv->stats.tx_aborted_errors);
+			seq_printf(m,
+				   "rx_over_errors:         %12lu\t"
+				   "tx_carrier_errors:      %12lu\n",
+				   priv->stats.rx_over_errors,
+				   priv->stats.tx_carrier_errors);
+			seq_printf(m,
+				   "rx_crc_errors:          %12lu\t"
+				   "tx_fifo_errors:         %12lu\n",
+				   priv->stats.rx_crc_errors,
+				   priv->stats.tx_fifo_errors);
+			seq_printf(m,
+				   "rx_frame_errors:        %12lu\t"
+				   "tx_heartbeat_errors:    %12lu\n",
+				   priv->stats.rx_frame_errors,
+				   priv->stats.tx_heartbeat_errors);
+			seq_printf(m,
+				   "rx_fifo_errors:         %12lu\t"
+				   "tx_window_errors:       %12lu\n",
+				   priv->stats.rx_fifo_errors,
+				   priv->stats.tx_window_errors);
+			seq_printf(m,
+				   "rx_missed_errors:       %12lu\t"
+				   "multicast:              %12lu\n",
+				   priv->stats.rx_missed_errors,
+				   priv->stats.multicast);
+		}
+	}
+
+	if (cvm_oct_device[0]) {
+		priv = netdev_priv(cvm_oct_device[0]);
+		if (priv->imode == CVMX_HELPER_INTERFACE_MODE_GMII)
+			cvm_oct_stats_switch_show(m, v);
+	}
+	return 0;
+}
+
+/**
+ * /proc/octeon_ethernet_stats was openned. Use the single_open iterator
+ *
+ * @inode:
+ * @file:
+ * Returns
+ */
+static int cvm_oct_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cvm_oct_stats_show, NULL);
+}
+
+static const struct file_operations cvm_oct_stats_operations = {
+	.open = cvm_oct_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+void cvm_oct_proc_initialize(void)
+{
+	struct proc_dir_entry *entry =
+	    create_proc_entry("octeon_ethernet_stats", 0, NULL);
+	if (entry)
+		entry->proc_fops = &cvm_oct_stats_operations;
+}
+
+void cvm_oct_proc_shutdown(void)
+{
+	remove_proc_entry("octeon_ethernet_stats", NULL);
+}
diff --git a/drivers/staging/octeon/ethernet-proc.h b/drivers/staging/octeon/ethernet-proc.h
new file mode 100644
index 0000000..82c7d9f
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-proc.h
@@ -0,0 +1,29 @@
+/*********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+*********************************************************************/
+
+void cvm_oct_proc_initialize(void);
+void cvm_oct_proc_shutdown(void);
diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
new file mode 100644
index 0000000..8579f16
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -0,0 +1,397 @@
+/*********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/mii.h>
+#include <net/dst.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "octeon-ethernet.h"
+#include "ethernet-common.h"
+#include "ethernet-util.h"
+
+#include "cvmx-helper.h"
+
+#include <asm/octeon/cvmx-ipd-defs.h>
+#include <asm/octeon/cvmx-npi-defs.h>
+#include "cvmx-gmxx-defs.h"
+
+DEFINE_SPINLOCK(global_register_lock);
+
+static int number_rgmii_ports;
+
+static void cvm_oct_rgmii_poll(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	unsigned long flags;
+	cvmx_helper_link_info_t link_info;
+
+	/*
+	 * Take the global register lock since we are going to touch
+	 * registers that affect more than one port.
+	 */
+	spin_lock_irqsave(&global_register_lock, flags);
+
+	link_info = cvmx_helper_link_get(priv->port);
+	if (link_info.u64 == priv->link_info) {
+
+		/*
+		 * If the 10Mbps preamble workaround is supported and we're
+		 * at 10Mbps we may need to do some special checking.
+		 */
+		if (USE_10MBPS_PREAMBLE_WORKAROUND && (link_info.s.speed == 10)) {
+
+			/*
+			 * Read the GMXX_RXX_INT_REG[PCTERR] bit and
+			 * see if we are getting preamble errors.
+			 */
+			int interface = INTERFACE(priv->port);
+			int index = INDEX(priv->port);
+			union cvmx_gmxx_rxx_int_reg gmxx_rxx_int_reg;
+			gmxx_rxx_int_reg.u64 =
+			    cvmx_read_csr(CVMX_GMXX_RXX_INT_REG
+					  (index, interface));
+			if (gmxx_rxx_int_reg.s.pcterr) {
+
+				/*
+				 * We are getting preamble errors at
+				 * 10Mbps.  Most likely the PHY is
+				 * giving us packets with mis aligned
+				 * preambles. In order to get these
+				 * packets we need to disable preamble
+				 * checking and do it in software.
+				 */
+				union cvmx_gmxx_rxx_frm_ctl gmxx_rxx_frm_ctl;
+				union cvmx_ipd_sub_port_fcs ipd_sub_port_fcs;
+
+				/* Disable preamble checking */
+				gmxx_rxx_frm_ctl.u64 =
+				    cvmx_read_csr(CVMX_GMXX_RXX_FRM_CTL
+						  (index, interface));
+				gmxx_rxx_frm_ctl.s.pre_chk = 0;
+				cvmx_write_csr(CVMX_GMXX_RXX_FRM_CTL
+					       (index, interface),
+					       gmxx_rxx_frm_ctl.u64);
+
+				/* Disable FCS stripping */
+				ipd_sub_port_fcs.u64 =
+				    cvmx_read_csr(CVMX_IPD_SUB_PORT_FCS);
+				ipd_sub_port_fcs.s.port_bit &=
+				    0xffffffffull ^ (1ull << priv->port);
+				cvmx_write_csr(CVMX_IPD_SUB_PORT_FCS,
+					       ipd_sub_port_fcs.u64);
+
+				/* Clear any error bits */
+				cvmx_write_csr(CVMX_GMXX_RXX_INT_REG
+					       (index, interface),
+					       gmxx_rxx_int_reg.u64);
+				DEBUGPRINT("%s: Using 10Mbps with software "
+					   "preamble removal\n",
+				     dev->name);
+			}
+		}
+		spin_unlock_irqrestore(&global_register_lock, flags);
+		return;
+	}
+
+	/* If the 10Mbps preamble workaround is allowed we need to on
+	   preamble checking, FCS stripping, and clear error bits on
+	   every speed change. If errors occur during 10Mbps operation
+	   the above code will change this stuff */
+	if (USE_10MBPS_PREAMBLE_WORKAROUND) {
+
+		union cvmx_gmxx_rxx_frm_ctl gmxx_rxx_frm_ctl;
+		union cvmx_ipd_sub_port_fcs ipd_sub_port_fcs;
+		union cvmx_gmxx_rxx_int_reg gmxx_rxx_int_reg;
+		int interface = INTERFACE(priv->port);
+		int index = INDEX(priv->port);
+
+		/* Enable preamble checking */
+		gmxx_rxx_frm_ctl.u64 =
+		    cvmx_read_csr(CVMX_GMXX_RXX_FRM_CTL(index, interface));
+		gmxx_rxx_frm_ctl.s.pre_chk = 1;
+		cvmx_write_csr(CVMX_GMXX_RXX_FRM_CTL(index, interface),
+			       gmxx_rxx_frm_ctl.u64);
+		/* Enable FCS stripping */
+		ipd_sub_port_fcs.u64 = cvmx_read_csr(CVMX_IPD_SUB_PORT_FCS);
+		ipd_sub_port_fcs.s.port_bit |= 1ull << priv->port;
+		cvmx_write_csr(CVMX_IPD_SUB_PORT_FCS, ipd_sub_port_fcs.u64);
+		/* Clear any error bits */
+		gmxx_rxx_int_reg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_RXX_INT_REG(index, interface));
+		cvmx_write_csr(CVMX_GMXX_RXX_INT_REG(index, interface),
+			       gmxx_rxx_int_reg.u64);
+	}
+
+	link_info = cvmx_helper_link_autoconf(priv->port);
+	priv->link_info = link_info.u64;
+	spin_unlock_irqrestore(&global_register_lock, flags);
+
+	/* Tell Linux */
+	if (link_info.s.link_up) {
+
+		if (!netif_carrier_ok(dev))
+			netif_carrier_on(dev);
+		if (priv->queue != -1)
+			DEBUGPRINT
+			    ("%s: %u Mbps %s duplex, port %2d, queue %2d\n",
+			     dev->name, link_info.s.speed,
+			     (link_info.s.full_duplex) ? "Full" : "Half",
+			     priv->port, priv->queue);
+		else
+			DEBUGPRINT("%s: %u Mbps %s duplex, port %2d, POW\n",
+				   dev->name, link_info.s.speed,
+				   (link_info.s.full_duplex) ? "Full" : "Half",
+				   priv->port);
+	} else {
+
+		if (netif_carrier_ok(dev))
+			netif_carrier_off(dev);
+		DEBUGPRINT("%s: Link down\n", dev->name);
+	}
+}
+
+static irqreturn_t cvm_oct_rgmii_rml_interrupt(int cpl, void *dev_id)
+{
+	union cvmx_npi_rsl_int_blocks rsl_int_blocks;
+	int index;
+	irqreturn_t return_status = IRQ_NONE;
+
+	rsl_int_blocks.u64 = cvmx_read_csr(CVMX_NPI_RSL_INT_BLOCKS);
+
+	/* Check and see if this interrupt was caused by the GMX0 block */
+	if (rsl_int_blocks.s.gmx0) {
+
+		int interface = 0;
+		/* Loop through every port of this interface */
+		for (index = 0;
+		     index < cvmx_helper_ports_on_interface(interface);
+		     index++) {
+
+			/* Read the GMX interrupt status bits */
+			union cvmx_gmxx_rxx_int_reg gmx_rx_int_reg;
+			gmx_rx_int_reg.u64 =
+			    cvmx_read_csr(CVMX_GMXX_RXX_INT_REG
+					  (index, interface));
+			gmx_rx_int_reg.u64 &=
+			    cvmx_read_csr(CVMX_GMXX_RXX_INT_EN
+					  (index, interface));
+			/* Poll the port if inband status changed */
+			if (gmx_rx_int_reg.s.phy_dupx
+			    || gmx_rx_int_reg.s.phy_link
+			    || gmx_rx_int_reg.s.phy_spd) {
+
+				struct net_device *dev =
+				    cvm_oct_device[cvmx_helper_get_ipd_port
+						   (interface, index)];
+				if (dev)
+					cvm_oct_rgmii_poll(dev);
+				gmx_rx_int_reg.u64 = 0;
+				gmx_rx_int_reg.s.phy_dupx = 1;
+				gmx_rx_int_reg.s.phy_link = 1;
+				gmx_rx_int_reg.s.phy_spd = 1;
+				cvmx_write_csr(CVMX_GMXX_RXX_INT_REG
+					       (index, interface),
+					       gmx_rx_int_reg.u64);
+				return_status = IRQ_HANDLED;
+			}
+		}
+	}
+
+	/* Check and see if this interrupt was caused by the GMX1 block */
+	if (rsl_int_blocks.s.gmx1) {
+
+		int interface = 1;
+		/* Loop through every port of this interface */
+		for (index = 0;
+		     index < cvmx_helper_ports_on_interface(interface);
+		     index++) {
+
+			/* Read the GMX interrupt status bits */
+			union cvmx_gmxx_rxx_int_reg gmx_rx_int_reg;
+			gmx_rx_int_reg.u64 =
+			    cvmx_read_csr(CVMX_GMXX_RXX_INT_REG
+					  (index, interface));
+			gmx_rx_int_reg.u64 &=
+			    cvmx_read_csr(CVMX_GMXX_RXX_INT_EN
+					  (index, interface));
+			/* Poll the port if inband status changed */
+			if (gmx_rx_int_reg.s.phy_dupx
+			    || gmx_rx_int_reg.s.phy_link
+			    || gmx_rx_int_reg.s.phy_spd) {
+
+				struct net_device *dev =
+				    cvm_oct_device[cvmx_helper_get_ipd_port
+						   (interface, index)];
+				if (dev)
+					cvm_oct_rgmii_poll(dev);
+				gmx_rx_int_reg.u64 = 0;
+				gmx_rx_int_reg.s.phy_dupx = 1;
+				gmx_rx_int_reg.s.phy_link = 1;
+				gmx_rx_int_reg.s.phy_spd = 1;
+				cvmx_write_csr(CVMX_GMXX_RXX_INT_REG
+					       (index, interface),
+					       gmx_rx_int_reg.u64);
+				return_status = IRQ_HANDLED;
+			}
+		}
+	}
+	return return_status;
+}
+
+static int cvm_oct_rgmii_open(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+	cvmx_helper_link_info_t link_info;
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+
+	if (!octeon_is_simulation()) {
+		link_info = cvmx_helper_link_get(priv->port);
+		if (!link_info.s.link_up)
+			netif_carrier_off(dev);
+	}
+
+	return 0;
+}
+
+static int cvm_oct_rgmii_stop(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+	return 0;
+}
+
+int cvm_oct_rgmii_init(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int r;
+
+	cvm_oct_common_init(dev);
+	dev->open = cvm_oct_rgmii_open;
+	dev->stop = cvm_oct_rgmii_stop;
+	dev->stop(dev);
+
+	/*
+	 * Due to GMX errata in CN3XXX series chips, it is necessary
+	 * to take the link down immediately whne the PHY changes
+	 * state. In order to do this we call the poll function every
+	 * time the RGMII inband status changes.  This may cause
+	 * problems if the PHY doesn't implement inband status
+	 * properly.
+	 */
+	if (number_rgmii_ports == 0) {
+		r = request_irq(OCTEON_IRQ_RML, cvm_oct_rgmii_rml_interrupt,
+				IRQF_SHARED, "RGMII", &number_rgmii_ports);
+	}
+	number_rgmii_ports++;
+
+	/*
+	 * Only true RGMII ports need to be polled. In GMII mode, port
+	 * 0 is really a RGMII port.
+	 */
+	if (((priv->imode == CVMX_HELPER_INTERFACE_MODE_GMII)
+	     && (priv->port == 0))
+	    || (priv->imode == CVMX_HELPER_INTERFACE_MODE_RGMII)) {
+
+		if (!octeon_is_simulation()) {
+
+			union cvmx_gmxx_rxx_int_en gmx_rx_int_en;
+			int interface = INTERFACE(priv->port);
+			int index = INDEX(priv->port);
+
+			/*
+			 * Enable interrupts on inband status changes
+			 * for this port.
+			 */
+			gmx_rx_int_en.u64 =
+			    cvmx_read_csr(CVMX_GMXX_RXX_INT_EN
+					  (index, interface));
+			gmx_rx_int_en.s.phy_dupx = 1;
+			gmx_rx_int_en.s.phy_link = 1;
+			gmx_rx_int_en.s.phy_spd = 1;
+			cvmx_write_csr(CVMX_GMXX_RXX_INT_EN(index, interface),
+				       gmx_rx_int_en.u64);
+			priv->poll = cvm_oct_rgmii_poll;
+		}
+	}
+
+	return 0;
+}
+
+void cvm_oct_rgmii_uninit(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	cvm_oct_common_uninit(dev);
+
+	/*
+	 * Only true RGMII ports need to be polled. In GMII mode, port
+	 * 0 is really a RGMII port.
+	 */
+	if (((priv->imode == CVMX_HELPER_INTERFACE_MODE_GMII)
+	     && (priv->port == 0))
+	    || (priv->imode == CVMX_HELPER_INTERFACE_MODE_RGMII)) {
+
+		if (!octeon_is_simulation()) {
+
+			union cvmx_gmxx_rxx_int_en gmx_rx_int_en;
+			int interface = INTERFACE(priv->port);
+			int index = INDEX(priv->port);
+
+			/*
+			 * Disable interrupts on inband status changes
+			 * for this port.
+			 */
+			gmx_rx_int_en.u64 =
+			    cvmx_read_csr(CVMX_GMXX_RXX_INT_EN
+					  (index, interface));
+			gmx_rx_int_en.s.phy_dupx = 0;
+			gmx_rx_int_en.s.phy_link = 0;
+			gmx_rx_int_en.s.phy_spd = 0;
+			cvmx_write_csr(CVMX_GMXX_RXX_INT_EN(index, interface),
+				       gmx_rx_int_en.u64);
+		}
+	}
+
+	/* Remove the interrupt handler when the last port is removed. */
+	number_rgmii_ports--;
+	if (number_rgmii_ports == 0)
+		free_irq(OCTEON_IRQ_RML, &number_rgmii_ports);
+}
diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
new file mode 100644
index 0000000..1b237b7
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -0,0 +1,505 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/cache.h>
+#include <linux/netdevice.h>
+#include <linux/init.h>
+#include <linux/etherdevice.h>
+#include <linux/ip.h>
+#include <linux/string.h>
+#include <linux/prefetch.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <net/dst.h>
+#ifdef CONFIG_XFRM
+#include <linux/xfrm.h>
+#include <net/xfrm.h>
+#endif /* CONFIG_XFRM */
+
+#include <asm/atomic.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "octeon-ethernet.h"
+#include "ethernet-mem.h"
+#include "ethernet-util.h"
+
+#include "cvmx-helper.h"
+#include "cvmx-wqe.h"
+#include "cvmx-fau.h"
+#include "cvmx-pow.h"
+#include "cvmx-pip.h"
+#include "cvmx-scratch.h"
+
+#include "cvmx-gmxx-defs.h"
+
+struct cvm_tasklet_wrapper {
+	struct tasklet_struct t;
+};
+
+/*
+ * Aligning the tasklet_struct on cachline boundries seems to decrease
+ * throughput even though in theory it would reduce contantion on the
+ * cache lines containing the locks.
+ */
+
+static struct cvm_tasklet_wrapper cvm_oct_tasklet[NR_CPUS];
+
+/**
+ * Interrupt handler. The interrupt occurs whenever the POW
+ * transitions from 0->1 packets in our group.
+ *
+ * @cpl:
+ * @dev_id:
+ * @regs:
+ * Returns
+ */
+irqreturn_t cvm_oct_do_interrupt(int cpl, void *dev_id)
+{
+	/* Acknowledge the interrupt */
+	if (INTERRUPT_LIMIT)
+		cvmx_write_csr(CVMX_POW_WQ_INT, 1 << pow_receive_group);
+	else
+		cvmx_write_csr(CVMX_POW_WQ_INT, 0x10001 << pow_receive_group);
+	preempt_disable();
+	tasklet_schedule(&cvm_oct_tasklet[smp_processor_id()].t);
+	preempt_enable();
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/**
+ * This is called when the kernel needs to manually poll the
+ * device. For Octeon, this is simply calling the interrupt
+ * handler. We actually poll all the devices, not just the
+ * one supplied.
+ *
+ * @dev:    Device to poll. Unused
+ */
+void cvm_oct_poll_controller(struct net_device *dev)
+{
+	preempt_disable();
+	tasklet_schedule(&cvm_oct_tasklet[smp_processor_id()].t);
+	preempt_enable();
+}
+#endif
+
+/**
+ * This is called on receive errors, and determines if the packet
+ * can be dropped early-on in cvm_oct_tasklet_rx().
+ *
+ * @work: Work queue entry pointing to the packet.
+ * Returns Non-zero if the packet can be dropped, zero otherwise.
+ */
+static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
+{
+	if ((work->word2.snoip.err_code == 10) && (work->len <= 64)) {
+		/*
+		 * Ignore length errors on min size packets. Some
+		 * equipment incorrectly pads packets to 64+4FCS
+		 * instead of 60+4FCS.  Note these packets still get
+		 * counted as frame errors.
+		 */
+	} else
+	    if (USE_10MBPS_PREAMBLE_WORKAROUND
+		&& ((work->word2.snoip.err_code == 5)
+		    || (work->word2.snoip.err_code == 7))) {
+
+		/*
+		 * We received a packet with either an alignment error
+		 * or a FCS error. This may be signalling that we are
+		 * running 10Mbps with GMXX_RXX_FRM_CTL[PRE_CHK}
+		 * off. If this is the case we need to parse the
+		 * packet to determine if we can remove a non spec
+		 * preamble and generate a correct packet.
+		 */
+		int interface = cvmx_helper_get_interface_num(work->ipprt);
+		int index = cvmx_helper_get_interface_index_num(work->ipprt);
+		union cvmx_gmxx_rxx_frm_ctl gmxx_rxx_frm_ctl;
+		gmxx_rxx_frm_ctl.u64 =
+		    cvmx_read_csr(CVMX_GMXX_RXX_FRM_CTL(index, interface));
+		if (gmxx_rxx_frm_ctl.s.pre_chk == 0) {
+
+			uint8_t *ptr =
+			    cvmx_phys_to_ptr(work->packet_ptr.s.addr);
+			int i = 0;
+
+			while (i < work->len - 1) {
+				if (*ptr != 0x55)
+					break;
+				ptr++;
+				i++;
+			}
+
+			if (*ptr == 0xd5) {
+				/*
+				   DEBUGPRINT("Port %d received 0xd5 preamble\n", work->ipprt);
+				 */
+				work->packet_ptr.s.addr += i + 1;
+				work->len -= i + 5;
+			} else if ((*ptr & 0xf) == 0xd) {
+				/*
+				   DEBUGPRINT("Port %d received 0x?d preamble\n", work->ipprt);
+				 */
+				work->packet_ptr.s.addr += i;
+				work->len -= i + 4;
+				for (i = 0; i < work->len; i++) {
+					*ptr =
+					    ((*ptr & 0xf0) >> 4) |
+					    ((*(ptr + 1) & 0xf) << 4);
+					ptr++;
+				}
+			} else {
+				DEBUGPRINT("Port %d unknown preamble, packet "
+					   "dropped\n",
+				     work->ipprt);
+				/*
+				   cvmx_helper_dump_packet(work);
+				 */
+				cvm_oct_free_work(work);
+				return 1;
+			}
+		}
+	} else {
+		DEBUGPRINT("Port %d receive error code %d, packet dropped\n",
+			   work->ipprt, work->word2.snoip.err_code);
+		cvm_oct_free_work(work);
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * Tasklet function that is scheduled on a core when an interrupt occurs.
+ *
+ * @unused:
+ */
+void cvm_oct_tasklet_rx(unsigned long unused)
+{
+	const int coreid = cvmx_get_core_num();
+	uint64_t old_group_mask;
+	uint64_t old_scratch;
+	int rx_count = 0;
+	int number_to_free;
+	int num_freed;
+	int packet_not_copied;
+
+	/* Prefetch cvm_oct_device since we know we need it soon */
+	prefetch(cvm_oct_device);
+
+	if (USE_ASYNC_IOBDMA) {
+		/* Save scratch in case userspace is using it */
+		CVMX_SYNCIOBDMA;
+		old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+	}
+
+	/* Only allow work for our group (and preserve priorities) */
+	old_group_mask = cvmx_read_csr(CVMX_POW_PP_GRP_MSKX(coreid));
+	cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(coreid),
+		       (old_group_mask & ~0xFFFFull) | 1 << pow_receive_group);
+
+	if (USE_ASYNC_IOBDMA)
+		cvmx_pow_work_request_async(CVMX_SCR_SCRATCH, CVMX_POW_NO_WAIT);
+
+	while (1) {
+		struct sk_buff *skb = NULL;
+		int skb_in_hw;
+		cvmx_wqe_t *work;
+
+		if (USE_ASYNC_IOBDMA) {
+			work = cvmx_pow_work_response_async(CVMX_SCR_SCRATCH);
+		} else {
+			if ((INTERRUPT_LIMIT == 0)
+			    || likely(rx_count < MAX_RX_PACKETS))
+				work =
+				    cvmx_pow_work_request_sync
+				    (CVMX_POW_NO_WAIT);
+			else
+				work = NULL;
+		}
+		prefetch(work);
+		if (work == NULL)
+			break;
+
+		/*
+		 * Limit each core to processing MAX_RX_PACKETS
+		 * packets without a break.  This way the RX can't
+		 * starve the TX task.
+		 */
+		if (USE_ASYNC_IOBDMA) {
+
+			if ((INTERRUPT_LIMIT == 0)
+			    || likely(rx_count < MAX_RX_PACKETS))
+				cvmx_pow_work_request_async_nocheck
+				    (CVMX_SCR_SCRATCH, CVMX_POW_NO_WAIT);
+			else {
+				cvmx_scratch_write64(CVMX_SCR_SCRATCH,
+						     0x8000000000000000ull);
+				cvmx_pow_tag_sw_null_nocheck();
+			}
+		}
+
+		skb_in_hw = USE_SKBUFFS_IN_HW && work->word2.s.bufs == 1;
+		if (likely(skb_in_hw)) {
+			skb =
+			    *(struct sk_buff
+			      **)(cvm_oct_get_buffer_ptr(work->packet_ptr) -
+				  sizeof(void *));
+			prefetch(&skb->head);
+			prefetch(&skb->len);
+		}
+		prefetch(cvm_oct_device[work->ipprt]);
+
+		rx_count++;
+		/* Immediately throw away all packets with receive errors */
+		if (unlikely(work->word2.snoip.rcv_error)) {
+			if (cvm_oct_check_rcv_error(work))
+				continue;
+		}
+
+		/*
+		 * We can only use the zero copy path if skbuffs are
+		 * in the FPA pool and the packet fits in a single
+		 * buffer.
+		 */
+		if (likely(skb_in_hw)) {
+			/*
+			 * This calculation was changed in case the
+			 * skb header is using a different address
+			 * aliasing type than the buffer. It doesn't
+			 * make any differnece now, but the new one is
+			 * more correct.
+			 */
+			skb->data =
+			    skb->head + work->packet_ptr.s.addr -
+			    cvmx_ptr_to_phys(skb->head);
+			prefetch(skb->data);
+			skb->len = work->len;
+			skb_set_tail_pointer(skb, skb->len);
+			packet_not_copied = 1;
+		} else {
+
+			/*
+			 * We have to copy the packet. First allocate
+			 * an skbuff for it.
+			 */
+			skb = dev_alloc_skb(work->len);
+			if (!skb) {
+				DEBUGPRINT("Port %d failed to allocate "
+					   "skbuff, packet dropped\n",
+				     work->ipprt);
+				cvm_oct_free_work(work);
+				continue;
+			}
+
+			/*
+			 * Check if we've received a packet that was
+			 * entirely stored in the work entry. This is
+			 * untested.
+			 */
+			if (unlikely(work->word2.s.bufs == 0)) {
+				uint8_t *ptr = work->packet_data;
+
+				if (likely(!work->word2.s.not_IP)) {
+					/*
+					 * The beginning of the packet
+					 * moves for IP packets.
+					 */
+					if (work->word2.s.is_v6)
+						ptr += 2;
+					else
+						ptr += 6;
+				}
+				memcpy(skb_put(skb, work->len), ptr, work->len);
+				/* No packet buffers to free */
+			} else {
+				int segments = work->word2.s.bufs;
+				union cvmx_buf_ptr segment_ptr =
+					work->packet_ptr;
+				int len = work->len;
+
+				while (segments--) {
+					union cvmx_buf_ptr next_ptr =
+					    *(union cvmx_buf_ptr *)
+					    cvmx_phys_to_ptr(segment_ptr.s.
+							     addr - 8);
+			/*
+			 * Octeon Errata PKI-100: The segment size is
+			 * wrong. Until it is fixed, calculate the
+			 * segment size based on the packet pool
+			 * buffer size. When it is fixed, the
+			 * following line should be replaced with this
+			 * one: int segment_size =
+			 * segment_ptr.s.size;
+			 */
+					int segment_size =
+					    CVMX_FPA_PACKET_POOL_SIZE -
+					    (segment_ptr.s.addr -
+					     (((segment_ptr.s.addr >> 7) -
+					       segment_ptr.s.back) << 7));
+					/* Don't copy more than what is left
+					   in the packet */
+					if (segment_size > len)
+						segment_size = len;
+					/* Copy the data into the packet */
+					memcpy(skb_put(skb, segment_size),
+					       cvmx_phys_to_ptr(segment_ptr.s.
+								addr),
+					       segment_size);
+					/* Reduce the amount of bytes left
+					   to copy */
+					len -= segment_size;
+					segment_ptr = next_ptr;
+				}
+			}
+			packet_not_copied = 0;
+		}
+
+		if (likely((work->ipprt < TOTAL_NUMBER_OF_PORTS) &&
+			   cvm_oct_device[work->ipprt])) {
+			struct net_device *dev = cvm_oct_device[work->ipprt];
+			struct octeon_ethernet *priv = netdev_priv(dev);
+
+			/* Only accept packets for devices
+			   that are currently up */
+			if (likely(dev->flags & IFF_UP)) {
+				skb->protocol = eth_type_trans(skb, dev);
+				skb->dev = dev;
+
+				if (unlikely
+				    (work->word2.s.not_IP
+				     || work->word2.s.IP_exc
+				     || work->word2.s.L4_error))
+					skb->ip_summed = CHECKSUM_NONE;
+				else
+					skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+				/* Increment RX stats for virtual ports */
+				if (work->ipprt >= CVMX_PIP_NUM_INPUT_PORTS) {
+#ifdef CONFIG_64BIT
+					atomic64_add(1, (atomic64_t *)&priv->stats.rx_packets);
+					atomic64_add(skb->len, (atomic64_t *)&priv->stats.rx_bytes);
+#else
+					atomic_add(1, (atomic_t *)&priv->stats.rx_packets);
+					atomic_add(skb->len, (atomic_t *)&priv->stats.rx_bytes);
+#endif
+				}
+				netif_receive_skb(skb);
+			} else {
+				/*
+				 * Drop any packet received for a
+				 * device that isn't up.
+				 */
+				/*
+				   DEBUGPRINT("%s: Device not up, packet dropped\n",
+				   dev->name);
+				 */
+#ifdef CONFIG_64BIT
+				atomic64_add(1, (atomic64_t *)&priv->stats.rx_dropped);
+#else
+				atomic_add(1, (atomic_t *)&priv->stats.rx_dropped);
+#endif
+				dev_kfree_skb_irq(skb);
+			}
+		} else {
+			/*
+			 * Drop any packet received for a device that
+			 * doesn't exist.
+			 */
+			DEBUGPRINT("Port %d not controlled by Linux, packet "
+				   "dropped\n",
+			     work->ipprt);
+			dev_kfree_skb_irq(skb);
+		}
+		/*
+		 * Check to see if the skbuff and work share the same
+		 * packet buffer.
+		 */
+		if (USE_SKBUFFS_IN_HW && likely(packet_not_copied)) {
+			/*
+			 * This buffer needs to be replaced, increment
+			 * the number of buffers we need to free by
+			 * one.
+			 */
+			cvmx_fau_atomic_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE,
+					      1);
+
+			cvmx_fpa_free(work, CVMX_FPA_WQE_POOL,
+				      DONT_WRITEBACK(1));
+		} else {
+			cvm_oct_free_work(work);
+		}
+	}
+
+	/* Restore the original POW group mask */
+	cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(coreid), old_group_mask);
+	if (USE_ASYNC_IOBDMA) {
+		/* Restore the scratch area */
+		cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
+	}
+
+	if (USE_SKBUFFS_IN_HW) {
+		/* Refill the packet buffer pool */
+		number_to_free =
+		    cvmx_fau_fetch_and_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE, 0);
+
+		if (number_to_free > 0) {
+			cvmx_fau_atomic_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE,
+					      -number_to_free);
+			num_freed =
+			    cvm_oct_mem_fill_fpa(CVMX_FPA_PACKET_POOL,
+						 CVMX_FPA_PACKET_POOL_SIZE,
+						 number_to_free);
+			if (num_freed != number_to_free) {
+				cvmx_fau_atomic_add32
+				    (FAU_NUM_PACKET_BUFFERS_TO_FREE,
+				     number_to_free - num_freed);
+			}
+		}
+	}
+}
+
+void cvm_oct_rx_initialize(void)
+{
+	int i;
+	/* Initialize all of the tasklets */
+	for (i = 0; i < NR_CPUS; i++)
+		tasklet_init(&cvm_oct_tasklet[i].t, cvm_oct_tasklet_rx, 0);
+}
+
+void cvm_oct_rx_shutdown(void)
+{
+	int i;
+	/* Shutdown all of the tasklets */
+	for (i = 0; i < NR_CPUS; i++)
+		tasklet_kill(&cvm_oct_tasklet[i].t);
+}
diff --git a/drivers/staging/octeon/ethernet-rx.h b/drivers/staging/octeon/ethernet-rx.h
new file mode 100644
index 0000000..a9b72b8
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-rx.h
@@ -0,0 +1,33 @@
+/*********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+*********************************************************************/
+
+irqreturn_t cvm_oct_do_interrupt(int cpl, void *dev_id);
+void cvm_oct_poll_controller(struct net_device *dev);
+void cvm_oct_tasklet_rx(unsigned long unused);
+
+void cvm_oct_rx_initialize(void);
+void cvm_oct_rx_shutdown(void);
diff --git a/drivers/staging/octeon/ethernet-sgmii.c b/drivers/staging/octeon/ethernet-sgmii.c
new file mode 100644
index 0000000..58fa39c
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-sgmii.c
@@ -0,0 +1,129 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/mii.h>
+#include <net/dst.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "octeon-ethernet.h"
+#include "ethernet-util.h"
+#include "ethernet-common.h"
+
+#include "cvmx-helper.h"
+
+#include "cvmx-gmxx-defs.h"
+
+static int cvm_oct_sgmii_open(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+	cvmx_helper_link_info_t link_info;
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+
+	if (!octeon_is_simulation()) {
+		link_info = cvmx_helper_link_get(priv->port);
+		if (!link_info.s.link_up)
+			netif_carrier_off(dev);
+	}
+
+	return 0;
+}
+
+static int cvm_oct_sgmii_stop(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+	return 0;
+}
+
+static void cvm_oct_sgmii_poll(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	cvmx_helper_link_info_t link_info;
+
+	link_info = cvmx_helper_link_get(priv->port);
+	if (link_info.u64 == priv->link_info)
+		return;
+
+	link_info = cvmx_helper_link_autoconf(priv->port);
+	priv->link_info = link_info.u64;
+
+	/* Tell Linux */
+	if (link_info.s.link_up) {
+
+		if (!netif_carrier_ok(dev))
+			netif_carrier_on(dev);
+		if (priv->queue != -1)
+			DEBUGPRINT
+			    ("%s: %u Mbps %s duplex, port %2d, queue %2d\n",
+			     dev->name, link_info.s.speed,
+			     (link_info.s.full_duplex) ? "Full" : "Half",
+			     priv->port, priv->queue);
+		else
+			DEBUGPRINT("%s: %u Mbps %s duplex, port %2d, POW\n",
+				   dev->name, link_info.s.speed,
+				   (link_info.s.full_duplex) ? "Full" : "Half",
+				   priv->port);
+	} else {
+		if (netif_carrier_ok(dev))
+			netif_carrier_off(dev);
+		DEBUGPRINT("%s: Link down\n", dev->name);
+	}
+}
+
+int cvm_oct_sgmii_init(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	cvm_oct_common_init(dev);
+	dev->open = cvm_oct_sgmii_open;
+	dev->stop = cvm_oct_sgmii_stop;
+	dev->stop(dev);
+	if (!octeon_is_simulation())
+		priv->poll = cvm_oct_sgmii_poll;
+
+	/* FIXME: Need autoneg logic */
+	return 0;
+}
+
+void cvm_oct_sgmii_uninit(struct net_device *dev)
+{
+	cvm_oct_common_uninit(dev);
+}
diff --git a/drivers/staging/octeon/ethernet-spi.c b/drivers/staging/octeon/ethernet-spi.c
new file mode 100644
index 0000000..e0971bb
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-spi.c
@@ -0,0 +1,323 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/mii.h>
+#include <net/dst.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "octeon-ethernet.h"
+#include "ethernet-common.h"
+#include "ethernet-util.h"
+
+#include "cvmx-spi.h"
+
+#include <asm/octeon/cvmx-npi-defs.h>
+#include "cvmx-spxx-defs.h"
+#include "cvmx-stxx-defs.h"
+
+static int number_spi_ports;
+static int need_retrain[2] = { 0, 0 };
+
+static irqreturn_t cvm_oct_spi_rml_interrupt(int cpl, void *dev_id)
+{
+	irqreturn_t return_status = IRQ_NONE;
+	union cvmx_npi_rsl_int_blocks rsl_int_blocks;
+
+	/* Check and see if this interrupt was caused by the GMX block */
+	rsl_int_blocks.u64 = cvmx_read_csr(CVMX_NPI_RSL_INT_BLOCKS);
+	if (rsl_int_blocks.s.spx1) {	/* 19 - SPX1_INT_REG & STX1_INT_REG */
+
+		union cvmx_spxx_int_reg spx_int_reg;
+		union cvmx_stxx_int_reg stx_int_reg;
+
+		spx_int_reg.u64 = cvmx_read_csr(CVMX_SPXX_INT_REG(1));
+		cvmx_write_csr(CVMX_SPXX_INT_REG(1), spx_int_reg.u64);
+		if (!need_retrain[1]) {
+
+			spx_int_reg.u64 &= cvmx_read_csr(CVMX_SPXX_INT_MSK(1));
+			if (spx_int_reg.s.spf)
+				pr_err("SPI1: SRX Spi4 interface down\n");
+			if (spx_int_reg.s.calerr)
+				pr_err("SPI1: SRX Spi4 Calendar table "
+				       "parity error\n");
+			if (spx_int_reg.s.syncerr)
+				pr_err("SPI1: SRX Consecutive Spi4 DIP4 "
+				       "errors have exceeded "
+				       "SPX_ERR_CTL[ERRCNT]\n");
+			if (spx_int_reg.s.diperr)
+				pr_err("SPI1: SRX Spi4 DIP4 error\n");
+			if (spx_int_reg.s.tpaovr)
+				pr_err("SPI1: SRX Selected port has hit "
+				       "TPA overflow\n");
+			if (spx_int_reg.s.rsverr)
+				pr_err("SPI1: SRX Spi4 reserved control "
+				       "word detected\n");
+			if (spx_int_reg.s.drwnng)
+				pr_err("SPI1: SRX Spi4 receive FIFO "
+				       "drowning/overflow\n");
+			if (spx_int_reg.s.clserr)
+				pr_err("SPI1: SRX Spi4 packet closed on "
+				       "non-16B alignment without EOP\n");
+			if (spx_int_reg.s.spiovr)
+				pr_err("SPI1: SRX Spi4 async FIFO overflow\n");
+			if (spx_int_reg.s.abnorm)
+				pr_err("SPI1: SRX Abnormal packet "
+				       "termination (ERR bit)\n");
+			if (spx_int_reg.s.prtnxa)
+				pr_err("SPI1: SRX Port out of range\n");
+		}
+
+		stx_int_reg.u64 = cvmx_read_csr(CVMX_STXX_INT_REG(1));
+		cvmx_write_csr(CVMX_STXX_INT_REG(1), stx_int_reg.u64);
+		if (!need_retrain[1]) {
+
+			stx_int_reg.u64 &= cvmx_read_csr(CVMX_STXX_INT_MSK(1));
+			if (stx_int_reg.s.syncerr)
+				pr_err("SPI1: STX Interface encountered a "
+				       "fatal error\n");
+			if (stx_int_reg.s.frmerr)
+				pr_err("SPI1: STX FRMCNT has exceeded "
+				       "STX_DIP_CNT[MAXFRM]\n");
+			if (stx_int_reg.s.unxfrm)
+				pr_err("SPI1: STX Unexpected framing "
+				       "sequence\n");
+			if (stx_int_reg.s.nosync)
+				pr_err("SPI1: STX ERRCNT has exceeded "
+				       "STX_DIP_CNT[MAXDIP]\n");
+			if (stx_int_reg.s.diperr)
+				pr_err("SPI1: STX DIP2 error on the Spi4 "
+				       "Status channel\n");
+			if (stx_int_reg.s.datovr)
+				pr_err("SPI1: STX Spi4 FIFO overflow error\n");
+			if (stx_int_reg.s.ovrbst)
+				pr_err("SPI1: STX Transmit packet burst "
+				       "too big\n");
+			if (stx_int_reg.s.calpar1)
+				pr_err("SPI1: STX Calendar Table Parity "
+				       "Error Bank1\n");
+			if (stx_int_reg.s.calpar0)
+				pr_err("SPI1: STX Calendar Table Parity "
+				       "Error Bank0\n");
+		}
+
+		cvmx_write_csr(CVMX_SPXX_INT_MSK(1), 0);
+		cvmx_write_csr(CVMX_STXX_INT_MSK(1), 0);
+		need_retrain[1] = 1;
+		return_status = IRQ_HANDLED;
+	}
+
+	if (rsl_int_blocks.s.spx0) {	/* 18 - SPX0_INT_REG & STX0_INT_REG */
+		union cvmx_spxx_int_reg spx_int_reg;
+		union cvmx_stxx_int_reg stx_int_reg;
+
+		spx_int_reg.u64 = cvmx_read_csr(CVMX_SPXX_INT_REG(0));
+		cvmx_write_csr(CVMX_SPXX_INT_REG(0), spx_int_reg.u64);
+		if (!need_retrain[0]) {
+
+			spx_int_reg.u64 &= cvmx_read_csr(CVMX_SPXX_INT_MSK(0));
+			if (spx_int_reg.s.spf)
+				pr_err("SPI0: SRX Spi4 interface down\n");
+			if (spx_int_reg.s.calerr)
+				pr_err("SPI0: SRX Spi4 Calendar table "
+				       "parity error\n");
+			if (spx_int_reg.s.syncerr)
+				pr_err("SPI0: SRX Consecutive Spi4 DIP4 "
+				       "errors have exceeded "
+				       "SPX_ERR_CTL[ERRCNT]\n");
+			if (spx_int_reg.s.diperr)
+				pr_err("SPI0: SRX Spi4 DIP4 error\n");
+			if (spx_int_reg.s.tpaovr)
+				pr_err("SPI0: SRX Selected port has hit "
+				       "TPA overflow\n");
+			if (spx_int_reg.s.rsverr)
+				pr_err("SPI0: SRX Spi4 reserved control "
+				       "word detected\n");
+			if (spx_int_reg.s.drwnng)
+				pr_err("SPI0: SRX Spi4 receive FIFO "
+				       "drowning/overflow\n");
+			if (spx_int_reg.s.clserr)
+				pr_err("SPI0: SRX Spi4 packet closed on "
+				       "non-16B alignment without EOP\n");
+			if (spx_int_reg.s.spiovr)
+				pr_err("SPI0: SRX Spi4 async FIFO overflow\n");
+			if (spx_int_reg.s.abnorm)
+				pr_err("SPI0: SRX Abnormal packet "
+				       "termination (ERR bit)\n");
+			if (spx_int_reg.s.prtnxa)
+				pr_err("SPI0: SRX Port out of range\n");
+		}
+
+		stx_int_reg.u64 = cvmx_read_csr(CVMX_STXX_INT_REG(0));
+		cvmx_write_csr(CVMX_STXX_INT_REG(0), stx_int_reg.u64);
+		if (!need_retrain[0]) {
+
+			stx_int_reg.u64 &= cvmx_read_csr(CVMX_STXX_INT_MSK(0));
+			if (stx_int_reg.s.syncerr)
+				pr_err("SPI0: STX Interface encountered a "
+				       "fatal error\n");
+			if (stx_int_reg.s.frmerr)
+				pr_err("SPI0: STX FRMCNT has exceeded "
+				       "STX_DIP_CNT[MAXFRM]\n");
+			if (stx_int_reg.s.unxfrm)
+				pr_err("SPI0: STX Unexpected framing "
+				       "sequence\n");
+			if (stx_int_reg.s.nosync)
+				pr_err("SPI0: STX ERRCNT has exceeded "
+				       "STX_DIP_CNT[MAXDIP]\n");
+			if (stx_int_reg.s.diperr)
+				pr_err("SPI0: STX DIP2 error on the Spi4 "
+				       "Status channel\n");
+			if (stx_int_reg.s.datovr)
+				pr_err("SPI0: STX Spi4 FIFO overflow error\n");
+			if (stx_int_reg.s.ovrbst)
+				pr_err("SPI0: STX Transmit packet burst "
+				       "too big\n");
+			if (stx_int_reg.s.calpar1)
+				pr_err("SPI0: STX Calendar Table Parity "
+				       "Error Bank1\n");
+			if (stx_int_reg.s.calpar0)
+				pr_err("SPI0: STX Calendar Table Parity "
+				       "Error Bank0\n");
+		}
+
+		cvmx_write_csr(CVMX_SPXX_INT_MSK(0), 0);
+		cvmx_write_csr(CVMX_STXX_INT_MSK(0), 0);
+		need_retrain[0] = 1;
+		return_status = IRQ_HANDLED;
+	}
+
+	return return_status;
+}
+
+static void cvm_oct_spi_enable_error_reporting(int interface)
+{
+	union cvmx_spxx_int_msk spxx_int_msk;
+	union cvmx_stxx_int_msk stxx_int_msk;
+
+	spxx_int_msk.u64 = cvmx_read_csr(CVMX_SPXX_INT_MSK(interface));
+	spxx_int_msk.s.calerr = 1;
+	spxx_int_msk.s.syncerr = 1;
+	spxx_int_msk.s.diperr = 1;
+	spxx_int_msk.s.tpaovr = 1;
+	spxx_int_msk.s.rsverr = 1;
+	spxx_int_msk.s.drwnng = 1;
+	spxx_int_msk.s.clserr = 1;
+	spxx_int_msk.s.spiovr = 1;
+	spxx_int_msk.s.abnorm = 1;
+	spxx_int_msk.s.prtnxa = 1;
+	cvmx_write_csr(CVMX_SPXX_INT_MSK(interface), spxx_int_msk.u64);
+
+	stxx_int_msk.u64 = cvmx_read_csr(CVMX_STXX_INT_MSK(interface));
+	stxx_int_msk.s.frmerr = 1;
+	stxx_int_msk.s.unxfrm = 1;
+	stxx_int_msk.s.nosync = 1;
+	stxx_int_msk.s.diperr = 1;
+	stxx_int_msk.s.datovr = 1;
+	stxx_int_msk.s.ovrbst = 1;
+	stxx_int_msk.s.calpar1 = 1;
+	stxx_int_msk.s.calpar0 = 1;
+	cvmx_write_csr(CVMX_STXX_INT_MSK(interface), stxx_int_msk.u64);
+}
+
+static void cvm_oct_spi_poll(struct net_device *dev)
+{
+	static int spi4000_port;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface;
+
+	for (interface = 0; interface < 2; interface++) {
+
+		if ((priv->port == interface * 16) && need_retrain[interface]) {
+
+			if (cvmx_spi_restart_interface
+			    (interface, CVMX_SPI_MODE_DUPLEX, 10) == 0) {
+				need_retrain[interface] = 0;
+				cvm_oct_spi_enable_error_reporting(interface);
+			}
+		}
+
+		/*
+		 * The SPI4000 TWSI interface is very slow. In order
+		 * not to bring the system to a crawl, we only poll a
+		 * single port every second. This means negotiation
+		 * speed changes take up to 10 seconds, but at least
+		 * we don't waste absurd amounts of time waiting for
+		 * TWSI.
+		 */
+		if (priv->port == spi4000_port) {
+			/*
+			 * This function does nothing if it is called on an
+			 * interface without a SPI4000.
+			 */
+			cvmx_spi4000_check_speed(interface, priv->port);
+			/*
+			 * Normal ordering increments. By decrementing
+			 * we only match once per iteration.
+			 */
+			spi4000_port--;
+			if (spi4000_port < 0)
+				spi4000_port = 10;
+		}
+	}
+}
+
+int cvm_oct_spi_init(struct net_device *dev)
+{
+	int r;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+
+	if (number_spi_ports == 0) {
+		r = request_irq(OCTEON_IRQ_RML, cvm_oct_spi_rml_interrupt,
+				IRQF_SHARED, "SPI", &number_spi_ports);
+	}
+	number_spi_ports++;
+
+	if ((priv->port == 0) || (priv->port == 16)) {
+		cvm_oct_spi_enable_error_reporting(INTERFACE(priv->port));
+		priv->poll = cvm_oct_spi_poll;
+	}
+	cvm_oct_common_init(dev);
+	return 0;
+}
+
+void cvm_oct_spi_uninit(struct net_device *dev)
+{
+	int interface;
+
+	cvm_oct_common_uninit(dev);
+	number_spi_ports--;
+	if (number_spi_ports == 0) {
+		for (interface = 0; interface < 2; interface++) {
+			cvmx_write_csr(CVMX_SPXX_INT_MSK(interface), 0);
+			cvmx_write_csr(CVMX_STXX_INT_MSK(interface), 0);
+		}
+		free_irq(8 + 46, &number_spi_ports);
+	}
+}
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
new file mode 100644
index 0000000..77b7122
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -0,0 +1,634 @@
+/*********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+*********************************************************************/
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/init.h>
+#include <linux/etherdevice.h>
+#include <linux/ip.h>
+#include <linux/string.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <net/dst.h>
+#ifdef CONFIG_XFRM
+#include <linux/xfrm.h>
+#include <net/xfrm.h>
+#endif /* CONFIG_XFRM */
+
+#include <asm/atomic.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "octeon-ethernet.h"
+#include "ethernet-util.h"
+
+#include "cvmx-wqe.h"
+#include "cvmx-fau.h"
+#include "cvmx-pko.h"
+#include "cvmx-helper.h"
+
+#include "cvmx-gmxx-defs.h"
+
+/*
+ * You can define GET_SKBUFF_QOS() to override how the skbuff output
+ * function determines which output queue is used. The default
+ * implementation always uses the base queue for the port. If, for
+ * example, you wanted to use the skb->priority fieid, define
+ * GET_SKBUFF_QOS as: #define GET_SKBUFF_QOS(skb) ((skb)->priority)
+ */
+#ifndef GET_SKBUFF_QOS
+#define GET_SKBUFF_QOS(skb) 0
+#endif
+
+/**
+ * Packet transmit
+ *
+ * @skb:    Packet to send
+ * @dev:    Device info structure
+ * Returns Always returns zero
+ */
+int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	cvmx_pko_command_word0_t pko_command;
+	union cvmx_buf_ptr hw_buffer;
+	uint64_t old_scratch;
+	uint64_t old_scratch2;
+	int dropped;
+	int qos;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int32_t in_use;
+	int32_t buffers_to_free;
+#if REUSE_SKBUFFS_WITHOUT_FREE
+	unsigned char *fpa_head;
+#endif
+
+	/*
+	 * Prefetch the private data structure.  It is larger that one
+	 * cache line.
+	 */
+	prefetch(priv);
+
+	/* Start off assuming no drop */
+	dropped = 0;
+
+	/*
+	 * The check on CVMX_PKO_QUEUES_PER_PORT_* is designed to
+	 * completely remove "qos" in the event neither interface
+	 * supports multiple queues per port.
+	 */
+	if ((CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 > 1) ||
+	    (CVMX_PKO_QUEUES_PER_PORT_INTERFACE1 > 1)) {
+		qos = GET_SKBUFF_QOS(skb);
+		if (qos <= 0)
+			qos = 0;
+		else if (qos >= cvmx_pko_get_num_queues(priv->port))
+			qos = 0;
+	} else
+		qos = 0;
+
+	if (USE_ASYNC_IOBDMA) {
+		/* Save scratch in case userspace is using it */
+		CVMX_SYNCIOBDMA;
+		old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+		old_scratch2 = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
+
+		/*
+		 * Assume we're going to be able t osend this
+		 * packet. Fetch and increment the number of pending
+		 * packets for output.
+		 */
+		cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH + 8,
+					       FAU_NUM_PACKET_BUFFERS_TO_FREE,
+					       0);
+		cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH,
+					       priv->fau + qos * 4, 1);
+	}
+
+	/*
+	 * The CN3XXX series of parts has an errata (GMX-401) which
+	 * causes the GMX block to hang if a collision occurs towards
+	 * the end of a <68 byte packet. As a workaround for this, we
+	 * pad packets to be 68 bytes whenever we are in half duplex
+	 * mode. We don't handle the case of having a small packet but
+	 * no room to add the padding.  The kernel should always give
+	 * us at least a cache line
+	 */
+	if ((skb->len < 64) && OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+		union cvmx_gmxx_prtx_cfg gmx_prt_cfg;
+		int interface = INTERFACE(priv->port);
+		int index = INDEX(priv->port);
+
+		if (interface < 2) {
+			/* We only need to pad packet in half duplex mode */
+			gmx_prt_cfg.u64 =
+			    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+			if (gmx_prt_cfg.s.duplex == 0) {
+				int add_bytes = 64 - skb->len;
+				if ((skb_tail_pointer(skb) + add_bytes) <=
+				    skb_end_pointer(skb))
+					memset(__skb_put(skb, add_bytes), 0,
+					       add_bytes);
+			}
+		}
+	}
+
+	/* Build the PKO buffer pointer */
+	hw_buffer.u64 = 0;
+	hw_buffer.s.addr = cvmx_ptr_to_phys(skb->data);
+	hw_buffer.s.pool = 0;
+	hw_buffer.s.size =
+	    (unsigned long)skb_end_pointer(skb) - (unsigned long)skb->head;
+
+	/* Build the PKO command */
+	pko_command.u64 = 0;
+	pko_command.s.n2 = 1;	/* Don't pollute L2 with the outgoing packet */
+	pko_command.s.segs = 1;
+	pko_command.s.total_bytes = skb->len;
+	pko_command.s.size0 = CVMX_FAU_OP_SIZE_32;
+	pko_command.s.subone0 = 1;
+
+	pko_command.s.dontfree = 1;
+	pko_command.s.reg0 = priv->fau + qos * 4;
+	/*
+	 * See if we can put this skb in the FPA pool. Any strange
+	 * behavior from the Linux networking stack will most likely
+	 * be caused by a bug in the following code. If some field is
+	 * in use by the network stack and get carried over when a
+	 * buffer is reused, bad thing may happen.  If in doubt and
+	 * you dont need the absolute best performance, disable the
+	 * define REUSE_SKBUFFS_WITHOUT_FREE. The reuse of buffers has
+	 * shown a 25% increase in performance under some loads.
+	 */
+#if REUSE_SKBUFFS_WITHOUT_FREE
+	fpa_head = skb->head + 128 - ((unsigned long)skb->head & 0x7f);
+	if (unlikely(skb->data < fpa_head)) {
+		/*
+		 * printk("TX buffer beginning can't meet FPA
+		 * alignment constraints\n");
+		 */
+		goto dont_put_skbuff_in_hw;
+	}
+	if (unlikely
+	    ((skb_end_pointer(skb) - fpa_head) < CVMX_FPA_PACKET_POOL_SIZE)) {
+		/*
+		   printk("TX buffer isn't large enough for the FPA\n");
+		 */
+		goto dont_put_skbuff_in_hw;
+	}
+	if (unlikely(skb_shared(skb))) {
+		/*
+		   printk("TX buffer sharing data with someone else\n");
+		 */
+		goto dont_put_skbuff_in_hw;
+	}
+	if (unlikely(skb_cloned(skb))) {
+		/*
+		   printk("TX buffer has been cloned\n");
+		 */
+		goto dont_put_skbuff_in_hw;
+	}
+	if (unlikely(skb_header_cloned(skb))) {
+		/*
+		   printk("TX buffer header has been cloned\n");
+		 */
+		goto dont_put_skbuff_in_hw;
+	}
+	if (unlikely(skb->destructor)) {
+		/*
+		   printk("TX buffer has a destructor\n");
+		 */
+		goto dont_put_skbuff_in_hw;
+	}
+	if (unlikely(skb_shinfo(skb)->nr_frags)) {
+		/*
+		   printk("TX buffer has fragments\n");
+		 */
+		goto dont_put_skbuff_in_hw;
+	}
+	if (unlikely
+	    (skb->truesize !=
+	     sizeof(*skb) + skb_end_pointer(skb) - skb->head)) {
+		/*
+		   printk("TX buffer truesize has been changed\n");
+		 */
+		goto dont_put_skbuff_in_hw;
+	}
+
+	/*
+	 * We can use this buffer in the FPA.  We don't need the FAU
+	 * update anymore
+	 */
+	pko_command.s.reg0 = 0;
+	pko_command.s.dontfree = 0;
+
+	hw_buffer.s.back = (skb->data - fpa_head) >> 7;
+	*(struct sk_buff **)(fpa_head - sizeof(void *)) = skb;
+
+	/*
+	 * The skbuff will be reused without ever being freed. We must
+	 * cleanup a bunch of Linux stuff.
+	 */
+	dst_release(skb->dst);
+	skb->dst = NULL;
+#ifdef CONFIG_XFRM
+	secpath_put(skb->sp);
+	skb->sp = NULL;
+#endif
+	nf_reset(skb);
+
+#ifdef CONFIG_NET_SCHED
+	skb->tc_index = 0;
+#ifdef CONFIG_NET_CLS_ACT
+	skb->tc_verd = 0;
+#endif /* CONFIG_NET_CLS_ACT */
+#endif /* CONFIG_NET_SCHED */
+
+dont_put_skbuff_in_hw:
+#endif /* REUSE_SKBUFFS_WITHOUT_FREE */
+
+	/* Check if we can use the hardware checksumming */
+	if (USE_HW_TCPUDP_CHECKSUM && (skb->protocol == htons(ETH_P_IP)) &&
+	    (ip_hdr(skb)->version == 4) && (ip_hdr(skb)->ihl == 5) &&
+	    ((ip_hdr(skb)->frag_off == 0) || (ip_hdr(skb)->frag_off == 1 << 14))
+	    && ((ip_hdr(skb)->protocol == IP_PROTOCOL_TCP)
+		|| (ip_hdr(skb)->protocol == IP_PROTOCOL_UDP))) {
+		/* Use hardware checksum calc */
+		pko_command.s.ipoffp1 = sizeof(struct ethhdr) + 1;
+	}
+
+	if (USE_ASYNC_IOBDMA) {
+		/* Get the number of skbuffs in use by the hardware */
+		CVMX_SYNCIOBDMA;
+		in_use = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+		buffers_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
+	} else {
+		/* Get the number of skbuffs in use by the hardware */
+		in_use = cvmx_fau_fetch_and_add32(priv->fau + qos * 4, 1);
+		buffers_to_free =
+		    cvmx_fau_fetch_and_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE, 0);
+	}
+
+	/*
+	 * If we're sending faster than the receive can free them then
+	 * don't do the HW free.
+	 */
+	if ((buffers_to_free < -100) && !pko_command.s.dontfree) {
+		pko_command.s.dontfree = 1;
+		pko_command.s.reg0 = priv->fau + qos * 4;
+	}
+
+	cvmx_pko_send_packet_prepare(priv->port, priv->queue + qos,
+				     CVMX_PKO_LOCK_CMD_QUEUE);
+
+	/* Drop this packet if we have too many already queued to the HW */
+	if (unlikely
+	    (skb_queue_len(&priv->tx_free_list[qos]) >= MAX_OUT_QUEUE_DEPTH)) {
+		/*
+		   DEBUGPRINT("%s: Tx dropped. Too many queued\n", dev->name);
+		 */
+		dropped = 1;
+	}
+	/* Send the packet to the output queue */
+	else if (unlikely
+		 (cvmx_pko_send_packet_finish
+		  (priv->port, priv->queue + qos, pko_command, hw_buffer,
+		   CVMX_PKO_LOCK_CMD_QUEUE))) {
+		DEBUGPRINT("%s: Failed to send the packet\n", dev->name);
+		dropped = 1;
+	}
+
+	if (USE_ASYNC_IOBDMA) {
+		/* Restore the scratch area */
+		cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
+		cvmx_scratch_write64(CVMX_SCR_SCRATCH + 8, old_scratch2);
+	}
+
+	if (unlikely(dropped)) {
+		dev_kfree_skb_any(skb);
+		cvmx_fau_atomic_add32(priv->fau + qos * 4, -1);
+		priv->stats.tx_dropped++;
+	} else {
+		if (USE_SKBUFFS_IN_HW) {
+			/* Put this packet on the queue to be freed later */
+			if (pko_command.s.dontfree)
+				skb_queue_tail(&priv->tx_free_list[qos], skb);
+			else {
+				cvmx_fau_atomic_add32
+				    (FAU_NUM_PACKET_BUFFERS_TO_FREE, -1);
+				cvmx_fau_atomic_add32(priv->fau + qos * 4, -1);
+			}
+		} else {
+			/* Put this packet on the queue to be freed later */
+			skb_queue_tail(&priv->tx_free_list[qos], skb);
+		}
+	}
+
+	/* Free skbuffs not in use by the hardware, possibly two at a time */
+	if (skb_queue_len(&priv->tx_free_list[qos]) > in_use) {
+		spin_lock(&priv->tx_free_list[qos].lock);
+		/*
+		 * Check again now that we have the lock. It might
+		 * have changed.
+		 */
+		if (skb_queue_len(&priv->tx_free_list[qos]) > in_use)
+			dev_kfree_skb(__skb_dequeue(&priv->tx_free_list[qos]));
+		if (skb_queue_len(&priv->tx_free_list[qos]) > in_use)
+			dev_kfree_skb(__skb_dequeue(&priv->tx_free_list[qos]));
+		spin_unlock(&priv->tx_free_list[qos].lock);
+	}
+
+	return 0;
+}
+
+/**
+ * Packet transmit to the POW
+ *
+ * @skb:    Packet to send
+ * @dev:    Device info structure
+ * Returns Always returns zero
+ */
+int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	void *packet_buffer;
+	void *copy_location;
+
+	/* Get a work queue entry */
+	cvmx_wqe_t *work = cvmx_fpa_alloc(CVMX_FPA_WQE_POOL);
+	if (unlikely(work == NULL)) {
+		DEBUGPRINT("%s: Failed to allocate a work queue entry\n",
+			   dev->name);
+		priv->stats.tx_dropped++;
+		dev_kfree_skb(skb);
+		return 0;
+	}
+
+	/* Get a packet buffer */
+	packet_buffer = cvmx_fpa_alloc(CVMX_FPA_PACKET_POOL);
+	if (unlikely(packet_buffer == NULL)) {
+		DEBUGPRINT("%s: Failed to allocate a packet buffer\n",
+			   dev->name);
+		cvmx_fpa_free(work, CVMX_FPA_WQE_POOL, DONT_WRITEBACK(1));
+		priv->stats.tx_dropped++;
+		dev_kfree_skb(skb);
+		return 0;
+	}
+
+	/*
+	 * Calculate where we need to copy the data to. We need to
+	 * leave 8 bytes for a next pointer (unused). We also need to
+	 * include any configure skip. Then we need to align the IP
+	 * packet src and dest into the same 64bit word. The below
+	 * calculation may add a little extra, but that doesn't
+	 * hurt.
+	 */
+	copy_location = packet_buffer + sizeof(uint64_t);
+	copy_location += ((CVMX_HELPER_FIRST_MBUFF_SKIP + 7) & 0xfff8) + 6;
+
+	/*
+	 * We have to copy the packet since whoever processes this
+	 * packet will free it to a hardware pool. We can't use the
+	 * trick of counting outstanding packets like in
+	 * cvm_oct_xmit.
+	 */
+	memcpy(copy_location, skb->data, skb->len);
+
+	/*
+	 * Fill in some of the work queue fields. We may need to add
+	 * more if the software at the other end needs them.
+	 */
+	work->hw_chksum = skb->csum;
+	work->len = skb->len;
+	work->ipprt = priv->port;
+	work->qos = priv->port & 0x7;
+	work->grp = pow_send_group;
+	work->tag_type = CVMX_HELPER_INPUT_TAG_TYPE;
+	work->tag = pow_send_group;	/* FIXME */
+	/* Default to zero. Sets of zero later are commented out */
+	work->word2.u64 = 0;
+	work->word2.s.bufs = 1;
+	work->packet_ptr.u64 = 0;
+	work->packet_ptr.s.addr = cvmx_ptr_to_phys(copy_location);
+	work->packet_ptr.s.pool = CVMX_FPA_PACKET_POOL;
+	work->packet_ptr.s.size = CVMX_FPA_PACKET_POOL_SIZE;
+	work->packet_ptr.s.back = (copy_location - packet_buffer) >> 7;
+
+	if (skb->protocol == htons(ETH_P_IP)) {
+		work->word2.s.ip_offset = 14;
+#if 0
+		work->word2.s.vlan_valid = 0;	/* FIXME */
+		work->word2.s.vlan_cfi = 0;	/* FIXME */
+		work->word2.s.vlan_id = 0;	/* FIXME */
+		work->word2.s.dec_ipcomp = 0;	/* FIXME */
+#endif
+		work->word2.s.tcp_or_udp =
+		    (ip_hdr(skb)->protocol == IP_PROTOCOL_TCP)
+		    || (ip_hdr(skb)->protocol == IP_PROTOCOL_UDP);
+#if 0
+		/* FIXME */
+		work->word2.s.dec_ipsec = 0;
+		/* We only support IPv4 right now */
+		work->word2.s.is_v6 = 0;
+		/* Hardware would set to zero */
+		work->word2.s.software = 0;
+		/* No error, packet is internal */
+		work->word2.s.L4_error = 0;
+#endif
+		work->word2.s.is_frag = !((ip_hdr(skb)->frag_off == 0)
+					  || (ip_hdr(skb)->frag_off ==
+					      1 << 14));
+#if 0
+		/* Assume Linux is sending a good packet */
+		work->word2.s.IP_exc = 0;
+#endif
+		work->word2.s.is_bcast = (skb->pkt_type == PACKET_BROADCAST);
+		work->word2.s.is_mcast = (skb->pkt_type == PACKET_MULTICAST);
+#if 0
+		/* This is an IP packet */
+		work->word2.s.not_IP = 0;
+		/* No error, packet is internal */
+		work->word2.s.rcv_error = 0;
+		/* No error, packet is internal */
+		work->word2.s.err_code = 0;
+#endif
+
+		/*
+		 * When copying the data, include 4 bytes of the
+		 * ethernet header to align the same way hardware
+		 * does.
+		 */
+		memcpy(work->packet_data, skb->data + 10,
+		       sizeof(work->packet_data));
+	} else {
+#if 0
+		work->word2.snoip.vlan_valid = 0;	/* FIXME */
+		work->word2.snoip.vlan_cfi = 0;	/* FIXME */
+		work->word2.snoip.vlan_id = 0;	/* FIXME */
+		work->word2.snoip.software = 0;	/* Hardware would set to zero */
+#endif
+		work->word2.snoip.is_rarp = skb->protocol == htons(ETH_P_RARP);
+		work->word2.snoip.is_arp = skb->protocol == htons(ETH_P_ARP);
+		work->word2.snoip.is_bcast =
+		    (skb->pkt_type == PACKET_BROADCAST);
+		work->word2.snoip.is_mcast =
+		    (skb->pkt_type == PACKET_MULTICAST);
+		work->word2.snoip.not_IP = 1;	/* IP was done up above */
+#if 0
+		/* No error, packet is internal */
+		work->word2.snoip.rcv_error = 0;
+		/* No error, packet is internal */
+		work->word2.snoip.err_code = 0;
+#endif
+		memcpy(work->packet_data, skb->data, sizeof(work->packet_data));
+	}
+
+	/* Submit the packet to the POW */
+	cvmx_pow_work_submit(work, work->tag, work->tag_type, work->qos,
+			     work->grp);
+	priv->stats.tx_packets++;
+	priv->stats.tx_bytes += skb->len;
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+/**
+ * Transmit a work queue entry out of the ethernet port. Both
+ * the work queue entry and the packet data can optionally be
+ * freed. The work will be freed on error as well.
+ *
+ * @dev:     Device to transmit out.
+ * @work_queue_entry:
+ *                Work queue entry to send
+ * @do_free: True if the work queue entry and packet data should be
+ *                freed. If false, neither will be freed.
+ * @qos:     Index into the queues for this port to transmit on. This
+ *                is used to implement QoS if their are multiple queues per
+ *                port. This parameter must be between 0 and the number of
+ *                queues per port minus 1. Values outside of this range will
+ *                be change to zero.
+ *
+ * Returns Zero on success, negative on failure.
+ */
+int cvm_oct_transmit_qos(struct net_device *dev, void *work_queue_entry,
+			 int do_free, int qos)
+{
+	unsigned long flags;
+	union cvmx_buf_ptr hw_buffer;
+	cvmx_pko_command_word0_t pko_command;
+	int dropped;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	cvmx_wqe_t *work = work_queue_entry;
+
+	if (!(dev->flags & IFF_UP)) {
+		DEBUGPRINT("%s: Device not up\n", dev->name);
+		if (do_free)
+			cvm_oct_free_work(work);
+		return -1;
+	}
+
+	/* The check on CVMX_PKO_QUEUES_PER_PORT_* is designed to completely
+	   remove "qos" in the event neither interface supports
+	   multiple queues per port */
+	if ((CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 > 1) ||
+	    (CVMX_PKO_QUEUES_PER_PORT_INTERFACE1 > 1)) {
+		if (qos <= 0)
+			qos = 0;
+		else if (qos >= cvmx_pko_get_num_queues(priv->port))
+			qos = 0;
+	} else
+		qos = 0;
+
+	/* Start off assuming no drop */
+	dropped = 0;
+
+	local_irq_save(flags);
+	cvmx_pko_send_packet_prepare(priv->port, priv->queue + qos,
+				     CVMX_PKO_LOCK_CMD_QUEUE);
+
+	/* Build the PKO buffer pointer */
+	hw_buffer.u64 = 0;
+	hw_buffer.s.addr = work->packet_ptr.s.addr;
+	hw_buffer.s.pool = CVMX_FPA_PACKET_POOL;
+	hw_buffer.s.size = CVMX_FPA_PACKET_POOL_SIZE;
+	hw_buffer.s.back = work->packet_ptr.s.back;
+
+	/* Build the PKO command */
+	pko_command.u64 = 0;
+	pko_command.s.n2 = 1;	/* Don't pollute L2 with the outgoing packet */
+	pko_command.s.dontfree = !do_free;
+	pko_command.s.segs = work->word2.s.bufs;
+	pko_command.s.total_bytes = work->len;
+
+	/* Check if we can use the hardware checksumming */
+	if (unlikely(work->word2.s.not_IP || work->word2.s.IP_exc))
+		pko_command.s.ipoffp1 = 0;
+	else
+		pko_command.s.ipoffp1 = sizeof(struct ethhdr) + 1;
+
+	/* Send the packet to the output queue */
+	if (unlikely
+	    (cvmx_pko_send_packet_finish
+	     (priv->port, priv->queue + qos, pko_command, hw_buffer,
+	      CVMX_PKO_LOCK_CMD_QUEUE))) {
+		DEBUGPRINT("%s: Failed to send the packet\n", dev->name);
+		dropped = -1;
+	}
+	local_irq_restore(flags);
+
+	if (unlikely(dropped)) {
+		if (do_free)
+			cvm_oct_free_work(work);
+		priv->stats.tx_dropped++;
+	} else if (do_free)
+		cvmx_fpa_free(work, CVMX_FPA_WQE_POOL, DONT_WRITEBACK(1));
+
+	return dropped;
+}
+EXPORT_SYMBOL(cvm_oct_transmit_qos);
+
+/**
+ * This function frees all skb that are currenty queued for TX.
+ *
+ * @dev:    Device being shutdown
+ */
+void cvm_oct_tx_shutdown(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	unsigned long flags;
+	int qos;
+
+	for (qos = 0; qos < 16; qos++) {
+		spin_lock_irqsave(&priv->tx_free_list[qos].lock, flags);
+		while (skb_queue_len(&priv->tx_free_list[qos]))
+			dev_kfree_skb_any(__skb_dequeue
+					  (&priv->tx_free_list[qos]));
+		spin_unlock_irqrestore(&priv->tx_free_list[qos].lock, flags);
+	}
+}
diff --git a/drivers/staging/octeon/ethernet-tx.h b/drivers/staging/octeon/ethernet-tx.h
new file mode 100644
index 0000000..5106236
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-tx.h
@@ -0,0 +1,32 @@
+/*********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+*********************************************************************/
+
+int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev);
+int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev);
+int cvm_oct_transmit_qos(struct net_device *dev, void *work_queue_entry,
+			 int do_free, int qos);
+void cvm_oct_tx_shutdown(struct net_device *dev);
diff --git a/drivers/staging/octeon/ethernet-util.h b/drivers/staging/octeon/ethernet-util.h
new file mode 100644
index 0000000..37b6659
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-util.h
@@ -0,0 +1,81 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+*********************************************************************/
+
+#define DEBUGPRINT(format, ...) do { if (printk_ratelimit()) 		\
+					printk(format, ##__VA_ARGS__);	\
+				} while (0)
+
+/**
+ * Given a packet data address, return a pointer to the
+ * beginning of the packet buffer.
+ *
+ * @packet_ptr: Packet data hardware address
+ * Returns Packet buffer pointer
+ */
+static inline void *cvm_oct_get_buffer_ptr(union cvmx_buf_ptr packet_ptr)
+{
+	return cvmx_phys_to_ptr(((packet_ptr.s.addr >> 7) - packet_ptr.s.back)
+				<< 7);
+}
+
+/**
+ * Given an IPD/PKO port number, return the logical interface it is
+ * on.
+ *
+ * @ipd_port: Port to check
+ *
+ * Returns Logical interface
+ */
+static inline int INTERFACE(int ipd_port)
+{
+	if (ipd_port < 32)	/* Interface 0 or 1 for RGMII,GMII,SPI, etc */
+		return ipd_port >> 4;
+	else if (ipd_port < 36)	/* Interface 2 for NPI */
+		return 2;
+	else if (ipd_port < 40)	/* Interface 3 for loopback */
+		return 3;
+	else if (ipd_port == 40)	/* Non existant interface for POW0 */
+		return 4;
+	else
+		panic("Illegal ipd_port %d passed to INTERFACE\n", ipd_port);
+}
+
+/**
+ * Given an IPD/PKO port number, return the port's index on a
+ * logical interface.
+ *
+ * @ipd_port: Port to check
+ *
+ * Returns Index into interface port list
+ */
+static inline int INDEX(int ipd_port)
+{
+	if (ipd_port < 32)
+		return ipd_port & 15;
+	else
+		return ipd_port & 3;
+}
diff --git a/drivers/staging/octeon/ethernet-xaui.c b/drivers/staging/octeon/ethernet-xaui.c
new file mode 100644
index 0000000..f08eb32
--- /dev/null
+++ b/drivers/staging/octeon/ethernet-xaui.c
@@ -0,0 +1,127 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/mii.h>
+#include <net/dst.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "octeon-ethernet.h"
+#include "ethernet-common.h"
+#include "ethernet-util.h"
+
+#include "cvmx-helper.h"
+
+#include "cvmx-gmxx-defs.h"
+
+static int cvm_oct_xaui_open(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+	cvmx_helper_link_info_t link_info;
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+
+	if (!octeon_is_simulation()) {
+		link_info = cvmx_helper_link_get(priv->port);
+		if (!link_info.s.link_up)
+			netif_carrier_off(dev);
+	}
+	return 0;
+}
+
+static int cvm_oct_xaui_stop(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+	return 0;
+}
+
+static void cvm_oct_xaui_poll(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	cvmx_helper_link_info_t link_info;
+
+	link_info = cvmx_helper_link_get(priv->port);
+	if (link_info.u64 == priv->link_info)
+		return;
+
+	link_info = cvmx_helper_link_autoconf(priv->port);
+	priv->link_info = link_info.u64;
+
+	/* Tell Linux */
+	if (link_info.s.link_up) {
+
+		if (!netif_carrier_ok(dev))
+			netif_carrier_on(dev);
+		if (priv->queue != -1)
+			DEBUGPRINT
+			    ("%s: %u Mbps %s duplex, port %2d, queue %2d\n",
+			     dev->name, link_info.s.speed,
+			     (link_info.s.full_duplex) ? "Full" : "Half",
+			     priv->port, priv->queue);
+		else
+			DEBUGPRINT("%s: %u Mbps %s duplex, port %2d, POW\n",
+				   dev->name, link_info.s.speed,
+				   (link_info.s.full_duplex) ? "Full" : "Half",
+				   priv->port);
+	} else {
+		if (netif_carrier_ok(dev))
+			netif_carrier_off(dev);
+		DEBUGPRINT("%s: Link down\n", dev->name);
+	}
+}
+
+int cvm_oct_xaui_init(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	cvm_oct_common_init(dev);
+	dev->open = cvm_oct_xaui_open;
+	dev->stop = cvm_oct_xaui_stop;
+	dev->stop(dev);
+	if (!octeon_is_simulation())
+		priv->poll = cvm_oct_xaui_poll;
+
+	return 0;
+}
+
+void cvm_oct_xaui_uninit(struct net_device *dev)
+{
+	cvm_oct_common_uninit(dev);
+}
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
new file mode 100644
index 0000000..e8ef9e0
--- /dev/null
+++ b/drivers/staging/octeon/ethernet.c
@@ -0,0 +1,507 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/delay.h>
+#include <linux/mii.h>
+
+#include <net/dst.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "ethernet-defines.h"
+#include "ethernet-mem.h"
+#include "ethernet-rx.h"
+#include "ethernet-tx.h"
+#include "ethernet-util.h"
+#include "ethernet-proc.h"
+#include "ethernet-common.h"
+#include "octeon-ethernet.h"
+
+#include "cvmx-pip.h"
+#include "cvmx-pko.h"
+#include "cvmx-fau.h"
+#include "cvmx-ipd.h"
+#include "cvmx-helper.h"
+
+#include "cvmx-smix-defs.h"
+
+#if defined(CONFIG_CAVIUM_OCTEON_NUM_PACKET_BUFFERS) \
+	&& CONFIG_CAVIUM_OCTEON_NUM_PACKET_BUFFERS
+int num_packet_buffers = CONFIG_CAVIUM_OCTEON_NUM_PACKET_BUFFERS;
+#else
+int num_packet_buffers = 1024;
+#endif
+module_param(num_packet_buffers, int, 0444);
+MODULE_PARM_DESC(num_packet_buffers, "\n"
+	"\tNumber of packet buffers to allocate and store in the\n"
+	"\tFPA. By default, 1024 packet buffers are used unless\n"
+	"\tCONFIG_CAVIUM_OCTEON_NUM_PACKET_BUFFERS is defined.");
+
+int pow_receive_group = 15;
+module_param(pow_receive_group, int, 0444);
+MODULE_PARM_DESC(pow_receive_group, "\n"
+	"\tPOW group to receive packets from. All ethernet hardware\n"
+	"\twill be configured to send incomming packets to this POW\n"
+	"\tgroup. Also any other software can submit packets to this\n"
+	"\tgroup for the kernel to process.");
+
+int pow_send_group = -1;
+module_param(pow_send_group, int, 0644);
+MODULE_PARM_DESC(pow_send_group, "\n"
+	"\tPOW group to send packets to other software on. This\n"
+	"\tcontrols the creation of the virtual device pow0.\n"
+	"\talways_use_pow also depends on this value.");
+
+int always_use_pow;
+module_param(always_use_pow, int, 0444);
+MODULE_PARM_DESC(always_use_pow, "\n"
+	"\tWhen set, always send to the pow group. This will cause\n"
+	"\tpackets sent to real ethernet devices to be sent to the\n"
+	"\tPOW group instead of the hardware. Unless some other\n"
+	"\tapplication changes the config, packets will still be\n"
+	"\treceived from the low level hardware. Use this option\n"
+	"\tto allow a CVMX app to intercept all packets from the\n"
+	"\tlinux kernel. You must specify pow_send_group along with\n"
+	"\tthis option.");
+
+char pow_send_list[128] = "";
+module_param_string(pow_send_list, pow_send_list, sizeof(pow_send_list), 0444);
+MODULE_PARM_DESC(pow_send_list, "\n"
+	"\tComma separated list of ethernet devices that should use the\n"
+	"\tPOW for transmit instead of the actual ethernet hardware. This\n"
+	"\tis a per port version of always_use_pow. always_use_pow takes\n"
+	"\tprecedence over this list. For example, setting this to\n"
+	"\t\"eth2,spi3,spi7\" would cause these three devices to transmit\n"
+	"\tusing the pow_send_group.");
+
+static int disable_core_queueing = 1;
+module_param(disable_core_queueing, int, 0444);
+MODULE_PARM_DESC(disable_core_queueing, "\n"
+	"\tWhen set the networking core's tx_queue_len is set to zero.  This\n"
+	"\tallows packets to be sent without lock contention in the packet\n"
+	"\tscheduler resulting in some cases in improved throughput.\n");
+
+/**
+ * Periodic timer to check auto negotiation
+ */
+static struct timer_list cvm_oct_poll_timer;
+
+/**
+ * Array of every ethernet device owned by this driver indexed by
+ * the ipd input port number.
+ */
+struct net_device *cvm_oct_device[TOTAL_NUMBER_OF_PORTS];
+
+extern struct semaphore mdio_sem;
+
+/**
+ * Periodic timer tick for slow management operations
+ *
+ * @arg:    Device to check
+ */
+static void cvm_do_timer(unsigned long arg)
+{
+	static int port;
+	if (port < CVMX_PIP_NUM_INPUT_PORTS) {
+		if (cvm_oct_device[port]) {
+			int queues_per_port;
+			int qos;
+			struct octeon_ethernet *priv =
+				netdev_priv(cvm_oct_device[port]);
+			if (priv->poll) {
+				/* skip polling if we don't get the lock */
+				if (!down_trylock(&mdio_sem)) {
+					priv->poll(cvm_oct_device[port]);
+					up(&mdio_sem);
+				}
+			}
+
+			queues_per_port = cvmx_pko_get_num_queues(port);
+			/* Drain any pending packets in the free list */
+			for (qos = 0; qos < queues_per_port; qos++) {
+				if (skb_queue_len(&priv->tx_free_list[qos])) {
+					spin_lock(&priv->tx_free_list[qos].
+						  lock);
+					while (skb_queue_len
+					       (&priv->tx_free_list[qos]) >
+					       cvmx_fau_fetch_and_add32(priv->
+									fau +
+									qos * 4,
+									0))
+						dev_kfree_skb(__skb_dequeue
+							      (&priv->
+							       tx_free_list
+							       [qos]));
+					spin_unlock(&priv->tx_free_list[qos].
+						    lock);
+				}
+			}
+			cvm_oct_device[port]->get_stats(cvm_oct_device[port]);
+		}
+		port++;
+		/* Poll the next port in a 50th of a second.
+		   This spreads the polling of ports out a little bit */
+		mod_timer(&cvm_oct_poll_timer, jiffies + HZ / 50);
+	} else {
+		port = 0;
+		/* All ports have been polled. Start the next iteration through
+		   the ports in one second */
+		mod_timer(&cvm_oct_poll_timer, jiffies + HZ);
+	}
+}
+
+/**
+ * Configure common hardware for all interfaces
+ */
+static __init void cvm_oct_configure_common_hw(void)
+{
+	int r;
+	/* Setup the FPA */
+	cvmx_fpa_enable();
+	cvm_oct_mem_fill_fpa(CVMX_FPA_PACKET_POOL, CVMX_FPA_PACKET_POOL_SIZE,
+			     num_packet_buffers);
+	cvm_oct_mem_fill_fpa(CVMX_FPA_WQE_POOL, CVMX_FPA_WQE_POOL_SIZE,
+			     num_packet_buffers);
+	if (CVMX_FPA_OUTPUT_BUFFER_POOL != CVMX_FPA_PACKET_POOL)
+		cvm_oct_mem_fill_fpa(CVMX_FPA_OUTPUT_BUFFER_POOL,
+				     CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE, 128);
+
+	if (USE_RED)
+		cvmx_helper_setup_red(num_packet_buffers / 4,
+				      num_packet_buffers / 8);
+
+	/* Enable the MII interface */
+	if (!octeon_is_simulation())
+		cvmx_write_csr(CVMX_SMIX_EN(0), 1);
+
+	/* Register an IRQ hander for to receive POW interrupts */
+	r = request_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group,
+			cvm_oct_do_interrupt, IRQF_SHARED, "Ethernet",
+			cvm_oct_device);
+
+#if defined(CONFIG_SMP) && 0
+	if (USE_MULTICORE_RECEIVE) {
+		irq_set_affinity(OCTEON_IRQ_WORKQ0 + pow_receive_group,
+				 cpu_online_mask);
+	}
+#endif
+}
+
+/**
+ * Free a work queue entry received in a intercept callback.
+ *
+ * @work_queue_entry:
+ *               Work queue entry to free
+ * Returns Zero on success, Negative on failure.
+ */
+int cvm_oct_free_work(void *work_queue_entry)
+{
+	cvmx_wqe_t *work = work_queue_entry;
+
+	int segments = work->word2.s.bufs;
+	union cvmx_buf_ptr segment_ptr = work->packet_ptr;
+
+	while (segments--) {
+		union cvmx_buf_ptr next_ptr = *(union cvmx_buf_ptr *)
+			cvmx_phys_to_ptr(segment_ptr.s.addr - 8);
+		if (unlikely(!segment_ptr.s.i))
+			cvmx_fpa_free(cvm_oct_get_buffer_ptr(segment_ptr),
+				      segment_ptr.s.pool,
+				      DONT_WRITEBACK(CVMX_FPA_PACKET_POOL_SIZE /
+						     128));
+		segment_ptr = next_ptr;
+	}
+	cvmx_fpa_free(work, CVMX_FPA_WQE_POOL, DONT_WRITEBACK(1));
+
+	return 0;
+}
+EXPORT_SYMBOL(cvm_oct_free_work);
+
+/**
+ * Module/ driver initialization. Creates the linux network
+ * devices.
+ *
+ * Returns Zero on success
+ */
+static int __init cvm_oct_init_module(void)
+{
+	int num_interfaces;
+	int interface;
+	int fau = FAU_NUM_PACKET_BUFFERS_TO_FREE;
+	int qos;
+
+	pr_notice("cavium-ethernet %s\n", OCTEON_ETHERNET_VERSION);
+
+	cvm_oct_proc_initialize();
+	cvm_oct_rx_initialize();
+	cvm_oct_configure_common_hw();
+
+	cvmx_helper_initialize_packet_io_global();
+
+	/* Change the input group for all ports before input is enabled */
+	num_interfaces = cvmx_helper_get_number_of_interfaces();
+	for (interface = 0; interface < num_interfaces; interface++) {
+		int num_ports = cvmx_helper_ports_on_interface(interface);
+		int port;
+
+		for (port = cvmx_helper_get_ipd_port(interface, 0);
+		     port < cvmx_helper_get_ipd_port(interface, num_ports);
+		     port++) {
+			union cvmx_pip_prt_tagx pip_prt_tagx;
+			pip_prt_tagx.u64 =
+			    cvmx_read_csr(CVMX_PIP_PRT_TAGX(port));
+			pip_prt_tagx.s.grp = pow_receive_group;
+			cvmx_write_csr(CVMX_PIP_PRT_TAGX(port),
+				       pip_prt_tagx.u64);
+		}
+	}
+
+	cvmx_helper_ipd_and_packet_input_enable();
+
+	memset(cvm_oct_device, 0, sizeof(cvm_oct_device));
+
+	/*
+	 * Initialize the FAU used for counting packet buffers that
+	 * need to be freed.
+	 */
+	cvmx_fau_atomic_write32(FAU_NUM_PACKET_BUFFERS_TO_FREE, 0);
+
+	if ((pow_send_group != -1)) {
+		struct net_device *dev;
+		pr_info("\tConfiguring device for POW only access\n");
+		dev = alloc_etherdev(sizeof(struct octeon_ethernet));
+		if (dev) {
+			/* Initialize the device private structure. */
+			struct octeon_ethernet *priv = netdev_priv(dev);
+			memset(priv, 0, sizeof(struct octeon_ethernet));
+
+			dev->init = cvm_oct_common_init;
+			priv->imode = CVMX_HELPER_INTERFACE_MODE_DISABLED;
+			priv->port = CVMX_PIP_NUM_INPUT_PORTS;
+			priv->queue = -1;
+			strcpy(dev->name, "pow%d");
+			for (qos = 0; qos < 16; qos++)
+				skb_queue_head_init(&priv->tx_free_list[qos]);
+
+			if (register_netdev(dev) < 0) {
+				pr_err("Failed to register ethernet "
+					 "device for POW\n");
+				kfree(dev);
+			} else {
+				cvm_oct_device[CVMX_PIP_NUM_INPUT_PORTS] = dev;
+				pr_info("%s: POW send group %d, receive "
+					"group %d\n",
+				     dev->name, pow_send_group,
+				     pow_receive_group);
+			}
+		} else {
+			pr_err("Failed to allocate ethernet device "
+				 "for POW\n");
+		}
+	}
+
+	num_interfaces = cvmx_helper_get_number_of_interfaces();
+	for (interface = 0; interface < num_interfaces; interface++) {
+		cvmx_helper_interface_mode_t imode =
+		    cvmx_helper_interface_get_mode(interface);
+		int num_ports = cvmx_helper_ports_on_interface(interface);
+		int port;
+
+		for (port = cvmx_helper_get_ipd_port(interface, 0);
+		     port < cvmx_helper_get_ipd_port(interface, num_ports);
+		     port++) {
+			struct octeon_ethernet *priv;
+			struct net_device *dev =
+			    alloc_etherdev(sizeof(struct octeon_ethernet));
+			if (!dev) {
+				pr_err("Failed to allocate ethernet device "
+					 "for port %d\n", port);
+				continue;
+			}
+			if (disable_core_queueing)
+				dev->tx_queue_len = 0;
+
+			/* Initialize the device private structure. */
+			priv = netdev_priv(dev);
+			memset(priv, 0, sizeof(struct octeon_ethernet));
+
+			priv->imode = imode;
+			priv->port = port;
+			priv->queue = cvmx_pko_get_base_queue(priv->port);
+			priv->fau = fau - cvmx_pko_get_num_queues(port) * 4;
+			for (qos = 0; qos < 16; qos++)
+				skb_queue_head_init(&priv->tx_free_list[qos]);
+			for (qos = 0; qos < cvmx_pko_get_num_queues(port);
+			     qos++)
+				cvmx_fau_atomic_write32(priv->fau + qos * 4, 0);
+
+			switch (priv->imode) {
+
+			/* These types don't support ports to IPD/PKO */
+			case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+			case CVMX_HELPER_INTERFACE_MODE_PCIE:
+			case CVMX_HELPER_INTERFACE_MODE_PICMG:
+				break;
+
+			case CVMX_HELPER_INTERFACE_MODE_NPI:
+				dev->init = cvm_oct_common_init;
+				dev->uninit = cvm_oct_common_uninit;
+				strcpy(dev->name, "npi%d");
+				break;
+
+			case CVMX_HELPER_INTERFACE_MODE_XAUI:
+				dev->init = cvm_oct_xaui_init;
+				dev->uninit = cvm_oct_xaui_uninit;
+				strcpy(dev->name, "xaui%d");
+				break;
+
+			case CVMX_HELPER_INTERFACE_MODE_LOOP:
+				dev->init = cvm_oct_common_init;
+				dev->uninit = cvm_oct_common_uninit;
+				strcpy(dev->name, "loop%d");
+				break;
+
+			case CVMX_HELPER_INTERFACE_MODE_SGMII:
+				dev->init = cvm_oct_sgmii_init;
+				dev->uninit = cvm_oct_sgmii_uninit;
+				strcpy(dev->name, "eth%d");
+				break;
+
+			case CVMX_HELPER_INTERFACE_MODE_SPI:
+				dev->init = cvm_oct_spi_init;
+				dev->uninit = cvm_oct_spi_uninit;
+				strcpy(dev->name, "spi%d");
+				break;
+
+			case CVMX_HELPER_INTERFACE_MODE_RGMII:
+			case CVMX_HELPER_INTERFACE_MODE_GMII:
+				dev->init = cvm_oct_rgmii_init;
+				dev->uninit = cvm_oct_rgmii_uninit;
+				strcpy(dev->name, "eth%d");
+				break;
+			}
+
+			if (!dev->init) {
+				kfree(dev);
+			} else if (register_netdev(dev) < 0) {
+				pr_err("Failed to register ethernet device "
+					 "for interface %d, port %d\n",
+					 interface, priv->port);
+				kfree(dev);
+			} else {
+				cvm_oct_device[priv->port] = dev;
+				fau -=
+				    cvmx_pko_get_num_queues(priv->port) *
+				    sizeof(uint32_t);
+			}
+		}
+	}
+
+	if (INTERRUPT_LIMIT) {
+		/*
+		 * Set the POW timer rate to give an interrupt at most
+		 * INTERRUPT_LIMIT times per second.
+		 */
+		cvmx_write_csr(CVMX_POW_WQ_INT_PC,
+			       octeon_bootinfo->eclock_hz / (INTERRUPT_LIMIT *
+							     16 * 256) << 8);
+
+		/*
+		 * Enable POW timer interrupt. It will count when
+		 * there are packets available.
+		 */
+		cvmx_write_csr(CVMX_POW_WQ_INT_THRX(pow_receive_group),
+			       0x1ful << 24);
+	} else {
+		/* Enable POW interrupt when our port has at least one packet */
+		cvmx_write_csr(CVMX_POW_WQ_INT_THRX(pow_receive_group), 0x1001);
+	}
+
+	/* Enable the poll timer for checking RGMII status */
+	init_timer(&cvm_oct_poll_timer);
+	cvm_oct_poll_timer.data = 0;
+	cvm_oct_poll_timer.function = cvm_do_timer;
+	mod_timer(&cvm_oct_poll_timer, jiffies + HZ);
+
+	return 0;
+}
+
+/**
+ * Module / driver shutdown
+ *
+ * Returns Zero on success
+ */
+static void __exit cvm_oct_cleanup_module(void)
+{
+	int port;
+
+	/* Disable POW interrupt */
+	cvmx_write_csr(CVMX_POW_WQ_INT_THRX(pow_receive_group), 0);
+
+	cvmx_ipd_disable();
+
+	/* Free the interrupt handler */
+	free_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group, cvm_oct_device);
+
+	del_timer(&cvm_oct_poll_timer);
+	cvm_oct_rx_shutdown();
+	cvmx_pko_disable();
+
+	/* Free the ethernet devices */
+	for (port = 0; port < TOTAL_NUMBER_OF_PORTS; port++) {
+		if (cvm_oct_device[port]) {
+			cvm_oct_tx_shutdown(cvm_oct_device[port]);
+			unregister_netdev(cvm_oct_device[port]);
+			kfree(cvm_oct_device[port]);
+			cvm_oct_device[port] = NULL;
+		}
+	}
+
+	cvmx_pko_shutdown();
+	cvm_oct_proc_shutdown();
+
+	cvmx_ipd_free_ptr();
+
+	/* Free the HW pools */
+	cvm_oct_mem_empty_fpa(CVMX_FPA_PACKET_POOL, CVMX_FPA_PACKET_POOL_SIZE,
+			      num_packet_buffers);
+	cvm_oct_mem_empty_fpa(CVMX_FPA_WQE_POOL, CVMX_FPA_WQE_POOL_SIZE,
+			      num_packet_buffers);
+	if (CVMX_FPA_OUTPUT_BUFFER_POOL != CVMX_FPA_PACKET_POOL)
+		cvm_oct_mem_empty_fpa(CVMX_FPA_OUTPUT_BUFFER_POOL,
+				      CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE, 128);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium Networks <support@caviumnetworks.com>");
+MODULE_DESCRIPTION("Cavium Networks Octeon ethernet driver.");
+module_init(cvm_oct_init_module);
+module_exit(cvm_oct_cleanup_module);
diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
new file mode 100644
index 0000000..b319907
--- /dev/null
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -0,0 +1,127 @@
+/**********************************************************************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2007 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+**********************************************************************/
+
+/*
+ * External interface for the Cavium Octeon ethernet driver.
+ */
+#ifndef OCTEON_ETHERNET_H
+#define OCTEON_ETHERNET_H
+
+/**
+ * This is the definition of the Ethernet driver's private
+ * driver state stored in netdev_priv(dev).
+ */
+struct octeon_ethernet {
+	/* PKO hardware output port */
+	int port;
+	/* PKO hardware queue for the port */
+	int queue;
+	/* Hardware fetch and add to count outstanding tx buffers */
+	int fau;
+	/*
+	 * Type of port. This is one of the enums in
+	 * cvmx_helper_interface_mode_t
+	 */
+	int imode;
+	/* List of outstanding tx buffers per queue */
+	struct sk_buff_head tx_free_list[16];
+	/* Device statistics */
+	struct net_device_stats stats
+;	/* Generic MII info structure */
+	struct mii_if_info mii_info;
+	/* Last negotiated link state */
+	uint64_t link_info;
+	/* Called periodically to check link status */
+	void (*poll) (struct net_device *dev);
+};
+
+/**
+ * Free a work queue entry received in a intercept callback.
+ *
+ * @work_queue_entry:
+ *               Work queue entry to free
+ * Returns Zero on success, Negative on failure.
+ */
+int cvm_oct_free_work(void *work_queue_entry);
+
+/**
+ * Transmit a work queue entry out of the ethernet port. Both
+ * the work queue entry and the packet data can optionally be
+ * freed. The work will be freed on error as well.
+ *
+ * @dev:     Device to transmit out.
+ * @work_queue_entry:
+ *                Work queue entry to send
+ * @do_free: True if the work queue entry and packet data should be
+ *                freed. If false, neither will be freed.
+ * @qos:     Index into the queues for this port to transmit on. This
+ *                is used to implement QoS if their are multiple queues per
+ *                port. This parameter must be between 0 and the number of
+ *                queues per port minus 1. Values outside of this range will
+ *                be change to zero.
+ *
+ * Returns Zero on success, negative on failure.
+ */
+int cvm_oct_transmit_qos(struct net_device *dev, void *work_queue_entry,
+			 int do_free, int qos);
+
+/**
+ * Transmit a work queue entry out of the ethernet port. Both
+ * the work queue entry and the packet data can optionally be
+ * freed. The work will be freed on error as well. This simply
+ * wraps cvmx_oct_transmit_qos() for backwards compatability.
+ *
+ * @dev:     Device to transmit out.
+ * @work_queue_entry:
+ *                Work queue entry to send
+ * @do_free: True if the work queue entry and packet data should be
+ *                freed. If false, neither will be freed.
+ *
+ * Returns Zero on success, negative on failure.
+ */
+static inline int cvm_oct_transmit(struct net_device *dev,
+				   void *work_queue_entry, int do_free)
+{
+	return cvm_oct_transmit_qos(dev, work_queue_entry, do_free, 0);
+}
+
+extern int cvm_oct_rgmii_init(struct net_device *dev);
+extern void cvm_oct_rgmii_uninit(struct net_device *dev);
+extern int cvm_oct_sgmii_init(struct net_device *dev);
+extern void cvm_oct_sgmii_uninit(struct net_device *dev);
+extern int cvm_oct_spi_init(struct net_device *dev);
+extern void cvm_oct_spi_uninit(struct net_device *dev);
+extern int cvm_oct_xaui_init(struct net_device *dev);
+extern void cvm_oct_xaui_uninit(struct net_device *dev);
+
+extern int always_use_pow;
+extern int pow_send_group;
+extern int pow_receive_group;
+extern char pow_send_list[];
+extern struct net_device *cvm_oct_device[];
+
+#endif
-- 
1.6.0.6
