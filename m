Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:12:35 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.241]:6053 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023389AbZEOWMY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:12:24 +0100
Received: by rv-out-0708.google.com with SMTP id b17so344303rvf.0
        for <multiple recipients>; Fri, 15 May 2009 15:12:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=2ZEBSPVljwRrH/dJR1uWziDpxU/PPp6yB0CM2NlXGLY=;
        b=go/61Khv/KUR5hiWP6i0o6uQgDw753z9LV70Y7E6UCuTDbDALtqXulaEa+zv0TvFw0
         T1WEORCBWKa7Cum14idFdmPnfOKP99cl0kvRuPIYkhkcdqX0ghXo9cjMg9hvSevT620b
         JKLvSakugfBrhSO40INoaVp2mH18zrbsnTXh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Zeb09oivvYrLsbMaF9LQvZdiNumU7n5C7AQ85ls4HPwEJ4J/ZRXqH3QfRrF4DxHJwh
         /AH5sF3TUkEng7pYaapjmjiN+3BfeBm6XSYK+QZuaTx48RTmvmQaNmU5lje2u3yGe0Hy
         /3rsk04UPoh0zRRnKlLG4OAdOzDoiEVRd2juw=
Received: by 10.141.146.4 with SMTP id y4mr1360282rvn.9.1242425511198;
        Fri, 15 May 2009 15:11:51 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id f42sm5075768rvb.41.2009.05.15.15.11.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:11:50 -0700 (PDT)
Subject: [PATCH 14/30] loongson: add basic fuloong(2f) support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:11:43 +0800
Message-Id: <1242425503.10164.155.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From d34ce4df75cd3b101c909d5d3d3a6651a3f64656 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 03:21:19 +0800
Subject: [PATCH 14/30] loongson: add basic fuloong(2f) support

fuloong(2e) have an VIA686B south bridge, but fuloong(2f) have an AMD
CS5536 south bridge.
---
 arch/mips/Makefile                                 |    1 +
 .../mips/include/asm/mach-loongson/cs5536/cs5536.h |  576 +++++
 .../include/asm/mach-loongson/cs5536/cs5536_pci.h  |  181 ++
 arch/mips/include/asm/mach-loongson/cs5536/mfgpt.h |   15 +
 .../mips/include/asm/mach-loongson/cs5536/pcireg.h |  485 ++++
 arch/mips/include/asm/mach-loongson/machine.h      |   30 +
 arch/mips/loongson/Kconfig                         |   28 +
 arch/mips/loongson/Makefile                        |    6 +
 arch/mips/loongson/common/Makefile                 |    6 +
 arch/mips/loongson/common/bonito-irq.c             |    5 +
 arch/mips/loongson/common/cs5536_vsm.c             | 2321
++++++++++++++++++++
 arch/mips/loongson/common/mem.c                    |    1 +
 arch/mips/loongson/fuloong-2f/Makefile             |    5 +
 arch/mips/loongson/fuloong-2f/irq.c                |   57 +
 arch/mips/loongson/fuloong-2f/reset.c              |   75 +
 arch/mips/pci/Makefile                             |    3 +-
 arch/mips/pci/fixup-fuloong2f.c                    |  189 ++
 arch/mips/pci/ops-fuloong2e.c                      |  159 --
 arch/mips/pci/ops-loongson2.c                      |  210 ++
 19 files changed, 4193 insertions(+), 160 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
 create mode 100644
arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/mfgpt.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/pcireg.h
 create mode 100644 arch/mips/loongson/common/cs5536_vsm.c
 create mode 100644 arch/mips/loongson/fuloong-2f/Makefile
 create mode 100644 arch/mips/loongson/fuloong-2f/irq.c
 create mode 100644 arch/mips/loongson/fuloong-2f/reset.c
 create mode 100644 arch/mips/pci/fixup-fuloong2f.c
 delete mode 100644 arch/mips/pci/ops-fuloong2e.c
 create mode 100644 arch/mips/pci/ops-loongson2.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 6cbfc22..abf16c1 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -310,6 +310,7 @@ core-$(CONFIG_LOONGSON_SYSTEMS)
+=arch/mips/loongson/
 cflags-$(CONFIG_LOONGSON_SYSTEMS) += -I
$(srctree)/arch/mips/include/asm/mach-loongson \
 					-mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) +=0xffffffff80100000
+load-$(CONFIG_LEMOTE_FULOONG2F) +=0xffffffff80200000
 
 #
 # MIPS Malta board
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
b/arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
new file mode 100644
index 0000000..502b464
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
@@ -0,0 +1,576 @@
+/*
+ * The include file of cs5536 sourthbridge define which is used in the
pmon only.
+ * you can modify it or change it, please set the modify time and
steps.
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author : jlliu <liujl@lemote.com>
+ */
+
+#ifndef	_CS5536_H
+#define	_CS5536_H
+
+extern void _rdmsr(u32 msr, u32 * hi, u32 * lo);
+extern void _wrmsr(u32 msr, u32 hi, u32 lo);
+
+/*************************************************************************/
+
+/*
+ * basic define
+ */
+#define	PCI_IO_BASE_VA	mips_io_port_base
+
+/*
+ * MSR module base
+ */
+#define	CS5536_SB_MSR_BASE	(0x00000000)
+#define	CS5536_GLIU_MSR_BASE	(0x10000000)
+#define	CS5536_ILLEGAL_MSR_BASE	(0x20000000)
+#define	CS5536_USB_MSR_BASE	(0x40000000)
+#define	CS5536_IDE_MSR_BASE	(0x60000000)
+#define	CS5536_DIVIL_MSR_BASE	(0x80000000)
+#define	CS5536_ACC_MSR_BASE	(0xa0000000)
+#define	CS5536_UNUSED_MSR_BASE	(0xc0000000)
+#define	CS5536_GLCP_MSR_BASE	(0xe0000000)
+
+#define	SB_MSR_REG(offset)	(CS5536_SB_MSR_BASE	| offset)
+#define	GLIU_MSR_REG(offset)	(CS5536_GLIU_MSR_BASE	| offset)
+#define	ILLEGAL_MSR_REG(offset)	(CS5536_ILLEGAL_MSR_BASE| offset)
+#define	USB_MSR_REG(offset)	(CS5536_USB_MSR_BASE	| offset)
+#define	IDE_MSR_REG(offset)	(CS5536_IDE_MSR_BASE	| offset)
+#define	DIVIL_MSR_REG(offset)	(CS5536_DIVIL_MSR_BASE	| offset)
+#define	ACC_MSR_REG(offset)	(CS5536_ACC_MSR_BASE	| offset)
+#define	UNUSED_MSR_REG(offset)	(CS5536_UNUSED_MSR_BASE	| offset)
+#define	GLCP_MSR_REG(offset)	(CS5536_GLCP_MSR_BASE	| offset)
+
+/*
+ * BAR SPACE OF VIRTUAL PCI : range for pci probe use, length is the
actual size. 
+ */
+/* IO space for all DIVIL modules */
+#define	CS5536_IRQ_RANGE		0xffffffe0	/* USERD FOR PCI PROBE */
+#define	CS5536_IRQ_LENGTH		0x20	/* THE REGS ACTUAL LENGTH */
+#define	CS5536_SMB_RANGE		0xfffffff8
+#define	CS5536_SMB_LENGTH		0x08
+#define	CS5536_GPIO_RANGE		0xffffff00
+#define	CS5536_GPIO_LENGTH		0x100
+#define	CS5536_MFGPT_RANGE		0xffffffc0
+#define	CS5536_MFGPT_LENGTH		0x40
+#define	CS5536_ACPI_RANGE		0xffffffe0
+#define	CS5536_ACPI_LENGTH		0x20
+#define	CS5536_PMS_RANGE		0xffffff80
+#define	CS5536_PMS_LENGTH		0x80
+/* MEM space for 4KB nand flash; IO space for 16B nor flash. */
+#ifdef	CS5536_USE_NOR_FLASH
+#define	CS5536_FLSH0_RANGE	0xfffffff0
+#define	CS5536_FLSH0_LENGTH	0x10
+#define	CS5536_FLSH1_RANGE	0xfffffff0
+#define	CS5536_FLSH1_LENGTH	0x10
+#define	CS5536_FLSH2_RANGE	0xfffffff0
+#define	CS5536_FLSH2_LENGTH	0x10
+#define	CS5536_FLSH3_RANGE	0xfffffff0
+#define	CS5536_FLSH3_LENGTH	0x10
+#else
+#define	CS5536_FLSH0_RANGE	0xfffff000
+#define	CS5536_FLSH0_LENGTH	0x1000
+#define	CS5536_FLSH1_RANGE	0xfffff000
+#define	CS5536_FLSH1_LENGTH	0x1000
+#define	CS5536_FLSH2_RANGE	0xfffff000
+#define	CS5536_FLSH2_LENGTH	0x1000
+#define	CS5536_FLSH3_RANGE	0xfffff000
+#define	CS5536_FLSH3_LENGTH	0x1000
+#endif
+/* IO space for IDE */
+#define	CS5536_IDE_RANGE	0xfffffff0
+#define	CS5536_IDE_LENGTH	0x10
+/* IO space for ACC */
+#define	CS5536_ACC_RANGE	0xffffff80
+#define	CS5536_ACC_LENGTH	0x80
+/* MEM space for ALL USB modules */
+/* #define       CS5536_OHCI_RANGE       0xfffffff0 */
+#define	CS5536_OHCI_RANGE	0xfffff000
+#define	CS5536_OHCI_LENGTH	0x1000
+/* #define       CS5536_EHCI_RANGE       0xfffffff0 */
+#define	CS5536_EHCI_RANGE	0xfffff000
+#define	CS5536_EHCI_LENGTH	0x1000
+#define	CS5536_UDC_RANGE	0xffffe000
+#define	CS5536_UDC_LENGTH	0x2000
+#define	CS5536_OTG_RANGE	0xfffff000
+#define	CS5536_OTG_LENGTH	0x1000
+
+/*
+ * PCI MSR ACCESS
+ */
+#define	PCI_MSR_CTRL		0xF0
+#define	PCI_MSR_ADDR		0xF4
+#define	PCI_MSR_DATA_LO		0xF8
+#define	PCI_MSR_DATA_HI		0xFC
+
+/******************************* MSR
*********************************************/
+
+/*
+ * GLIU STANDARD MSR
+ */
+#define	GLIU_CAP		0x00
+#define	GLIU_CONFIG		0x01
+#define	GLIU_SMI		0x02
+#define	GLIU_ERROR		0x03
+#define	GLIU_PM			0x04
+#define	GLIU_DIAG		0x05
+
+/*
+ * GLIU SPEC. MSR
+ */
+#define	GLIU_P2D_BM0		0x20
+#define	GLIU_P2D_BM1		0x21
+#define	GLIU_P2D_BM2		0x22
+#define	GLIU_P2D_BMK0		0x23
+#define	GLIU_P2D_BMK1		0x24
+#define	GLIU_P2D_BM3		0x25
+#define	GLIU_P2D_BM4		0x26
+#define	GLIU_COH		0x80
+#define	GLIU_PAE		0x81
+#define	GLIU_ARB		0x82
+#define	GLIU_ASMI		0x83
+#define	GLIU_AERR		0x84
+#define	GLIU_DEBUG		0x85
+#define	GLIU_PHY_CAP		0x86
+#define	GLIU_NOUT_RESP		0x87
+#define	GLIU_NOUT_WDATA		0x88
+#define	GLIU_WHOAMI		0x8B
+#define	GLIU_SLV_DIS		0x8C
+#define	GLIU_IOD_BM0		0xE0
+#define	GLIU_IOD_BM1		0xE1
+#define	GLIU_IOD_BM2		0xE2
+#define	GLIU_IOD_BM3		0xE3
+#define	GLIU_IOD_BM4		0xE4
+#define	GLIU_IOD_BM5		0xE5
+#define	GLIU_IOD_BM6		0xE6
+#define	GLIU_IOD_BM7		0xE7
+#define	GLIU_IOD_BM8		0xE8
+#define	GLIU_IOD_BM9		0xE9
+#define	GLIU_IOD_SC0		0xEA
+#define	GLIU_IOD_SC1		0xEB
+#define	GLIU_IOD_SC2		0xEC
+#define	GLIU_IOD_SC3		0xED
+#define	GLIU_IOD_SC4		0xEE
+#define	GLIU_IOD_SC5		0xEF
+#define	GLIU_IOD_SC6		0xF0
+#define	GLIU_IOD_SC7		0xF1
+
+/*
+ * SB STANDARD
+ */
+#define	SB_CAP		0x00
+#define	SB_CONFIG	0x01
+#define	SB_SMI		0x02
+#define	SB_ERROR	0x03
+#define	SB_MAR_ERR_EN		0x00000001
+#define	SB_TAR_ERR_EN		0x00000002
+#define	SB_RSVD_BIT1		0x00000004
+#define	SB_EXCEP_ERR_EN		0x00000008
+#define	SB_SYSE_ERR_EN		0x00000010
+#define	SB_PARE_ERR_EN		0x00000020
+#define	SB_TAS_ERR_EN		0x00000040
+#define	SB_MAR_ERR_FLAG		0x00010000
+#define	SB_TAR_ERR_FLAG		0x00020000
+#define	SB_RSVD_BIT2		0x00040000
+#define	SB_EXCEP_ERR_FLAG	0x00080000
+#define	SB_SYSE_ERR_FLAG	0x00100000
+#define	SB_PARE_ERR_FLAG	0x00200000
+#define	SB_TAS_ERR_FLAG		0x00400000
+#define	SB_PM		0x04
+#define	SB_DIAG		0x05
+
+/*
+ * SB SPEC.
+ */
+#define	SB_CTRL		0x10
+#define	SB_R0		0x20
+#define	SB_R1		0x21
+#define	SB_R2		0x22
+#define	SB_R3		0x23
+#define	SB_R4		0x24
+#define	SB_R5		0x25
+#define	SB_R6		0x26
+#define	SB_R7		0x27
+#define	SB_R8		0x28
+#define	SB_R9		0x29
+#define	SB_R10		0x2A
+#define	SB_R11		0x2B
+#define	SB_R12		0x2C
+#define	SB_R13		0x2D
+#define	SB_R14		0x2E
+#define	SB_R15		0x2F
+
+/*
+ * GLCP STANDARD
+ */
+#define	GLCP_CAP		0x00
+#define	GLCP_CONFIG		0x01
+#define	GLCP_SMI		0x02
+#define	GLCP_ERROR		0x03
+#define	GLCP_PM			0x04
+#define	GLCP_DIAG		0x05
+
+/*
+ * GLCP SPEC. 
+ */
+#define	GLCP_CLK_DIS_DELAY	0x08
+#define	GLCP_PM_CLK_DISABLE	0x09
+#define	GLCP_GLB_PM		0x0B
+#define	GLCP_DBG_OUT		0x0C
+#define	GLCP_RSVD1		0x0D
+#define	GLCP_SOFT_COM		0x0E
+#define	SOFT_BAR_SMB_FLAG		0x00000001
+#define	SOFT_BAR_GPIO_FLAG		0x00000002
+#define	SOFT_BAR_MFGPT_FLAG		0x00000004
+#define	SOFT_BAR_IRQ_FLAG		0x00000008
+#define	SOFT_BAR_PMS_FLAG		0x00000010
+#define	SOFT_BAR_ACPI_FLAG		0x00000020
+#define	SOFT_BAR_FLSH0_FLAG		0x00000040
+#define	SOFT_BAR_FLSH1_FLAG		0x00000080
+#define	SOFT_BAR_FLSH2_FLAG		0x00000100
+#define	SOFT_BAR_FLSH3_FLAG		0x00000200
+#define	SOFT_BAR_IDE_FLAG		0x00000400
+#define	SOFT_BAR_ACC_FLAG		0x00000800
+#define	SOFT_BAR_OHCI_FLAG		0x00001000
+#define	SOFT_BAR_EHCI_FLAG		0x00002000
+#define	SOFT_BAR_UDC_FLAG		0x00004000
+#define	SOFT_BAR_OTG_FLAG		0x00008000
+#define	GLCP_RSVD2			0x0F
+#define	GLCP_CLK_OFF		0x10
+#define	GLCP_CLK_ACTIVE		0x11
+#define	GLCP_CLK_DISABLE	0x12
+#define	GLCP_CLK4ACK		0x13
+#define	GLCP_SYS_RST		0x14
+#define	GLCP_RSVD3			0x15
+#define	GLCP_DBG_CLK_CTRL	0x16
+#define	GLCP_CHIP_REV_ID	0x17
+
+/*
+ * DIVIL STANDARD
+ */
+#define	DIVIL_CAP		0x00
+#define	DIVIL_CONFIG	0x01
+#define	DIVIL_SMI		0x02
+#define	DIVIL_ERROR		0x03
+#define	DIVIL_PM		0x04
+#define	DIVIL_DIAG		0x05
+
+/*
+ * DIVIL SPEC. 
+ */
+#define	DIVIL_LBAR_IRQ		0x08
+#define	DIVIL_LBAR_KEL		0x09
+#define	DIVIL_LBAR_SMB		0x0B
+#define	DIVIL_LBAR_GPIO		0x0C
+#define	DIVIL_LBAR_MFGPT	0x0D
+#define	DIVIL_LBAR_ACPI		0x0E
+#define	DIVIL_LBAR_PMS		0x0F
+#define	DIVIL_LBAR_FLSH0	0x10
+#define	DIVIL_LBAR_FLSH1	0x11
+#define	DIVIL_LBAR_FLSH2	0x12
+#define	DIVIL_LBAR_FLSH3	0x13
+#define	DIVIL_LEG_IO		0x14
+#define	DIVIL_BALL_OPTS		0x15
+#define	DIVIL_SOFT_IRQ		0x16
+#define	DIVIL_SOFT_RESET	0x17
+/* NOR FLASH */
+#define	NORF_CTRL		0x18
+#define	NORF_T01		0x19
+#define	NORF_T23		0x1A
+/* NAND FLASH */
+#define	NANDF_DATA		0x1B
+#define	NANDF_CTRL		0x1C
+#define	NANDF_RSVD		0x1D
+/* KEL Keyboard Emulation Logic */
+#define	KEL_CTRL		0x1F
+/* PIC */
+#define	PIC_YSEL_LOW		0x20
+#define	PIC_YSEL_LOW_USB_SHIFT		8
+#define	PIC_YSEL_LOW_ACC_SHIFT		16
+#define	PIC_YSEL_LOW_FLASH_SHIFT	24
+#define	PIC_YSEL_HIGH		0x21
+#define	PIC_ZSEL_LOW		0x22
+#define	PIC_ZSEL_HIGH		0x23
+#define	PIC_IRQM_PRIM		0x24
+#define	PIC_IRQM_LPC		0x25
+#define	PIC_XIRR_STS_LOW	0x26
+#define	PIC_XIRR_STS_HIGH	0x27
+#define	PCI_SHDW		0x34
+/* MFGPT */
+#define	MFGPT_IRQ		0x28
+#define	MFGPT_NR		0x29
+#define	MFGPT_RSVD		0x2A
+#define	MFGPT_SETUP		0x2B
+/* FLOPPY */
+#define	FLPY_3F2_SHDW		0x30
+#define	FLPY_3F7_SHDW		0x31
+#define	FLPY_372_SHDW		0x32
+#define	FLPY_377_SHDW		0x33
+/* PIT */
+#define	PIT_SHDW		0x36
+#define	PIT_CNTRL		0x37
+/* UART */
+#define	UART1_MOD		0x38
+#define	UART1_DONG		0x39
+#define	UART1_CONF		0x3A
+#define	UART1_RSVD		0x3B
+#define	UART2_MOD		0x3C
+#define	UART2_DONG		0x3D
+#define	UART2_CONF		0x3E
+#define	UART2_RSVD		0x3F
+/* DMA */
+#define	DIVIL_AC_DMA		0x1E
+#define	DMA_MAP			0x40
+#define	DMA_SHDW_CH0		0x41
+#define	DMA_SHDW_CH1		0x42
+#define	DMA_SHDW_CH2		0x43
+#define	DMA_SHDW_CH3		0x44
+#define	DMA_SHDW_CH4		0x45
+#define	DMA_SHDW_CH5		0x46
+#define	DMA_SHDW_CH6		0x47
+#define	DMA_SHDW_CH7		0x48
+#define	DMA_MSK_SHDW		0x49
+/* LPC */
+#define	LPC_EADDR		0x4C
+#define	LPC_ESTAT		0x4D
+#define	LPC_SIRQ		0x4E
+#define	LPC_RSVD		0x4F
+/* PMC */
+#define	PMC_LTMR		0x50
+#define	PMC_RSVD		0x51
+/* RTC */
+#define	RTC_RAM_LOCK		0x54
+#define	RTC_DOMA_OFFSET		0x55
+#define	RTC_MONA_OFFSET		0x56
+#define	RTC_CEN_OFFSET		0x57
+
+/*
+ * IDE STANDARD 
+ */
+#define	IDE_CAP		0x00
+#define	IDE_CONFIG	0x01
+#define	IDE_SMI		0x02
+#define	IDE_ERROR	0x03
+#define	IDE_PM		0x04
+#define	IDE_DIAG	0x05
+
+/*
+ * IDE SPEC. 
+ */
+#define	IDE_IO_BAR	0x08
+#define	IDE_CFG		0x10
+#define	IDE_DTC		0x12
+#define	IDE_CAST	0x13
+#define	IDE_ETC		0x14
+#define	IDE_INTERNAL_PM	0x15
+
+/*
+ * ACC STANDARD
+ */
+#define	ACC_CAP		0x00
+#define	ACC_CONFIG	0x01
+#define	ACC_SMI		0x02
+#define	ACC_ERROR	0x03
+#define	ACC_PM		0x04
+#define	ACC_DIAG	0x05
+
+/*
+ * USB STANDARD
+ */
+#define	USB_CAP		0x00
+#define	USB_CONFIG	0x01
+#define	USB_SMI		0x02
+#define	USB_ERROR	0x03
+#define	USB_PM		0x04
+#define	USB_DIAG	0x05
+
+/*
+ * USB SPEC.
+ */
+#define	USB_OHCI	0x08
+#define	USB_EHCI	0x09
+#define	USB_UDC		0x0A
+#define	USB_OTG		0x0B
+
+/********************************** NATIVE
****************************************/
+/* IDE NATIVE registers */
+#define	IDE_BM_CMD	0x00
+#define	IDE_BM_STS	0x02
+#define	IDE_BM_PRD	0x04
+
+/* OHCI native registers */
+#define	OHCI_REVISION		0x00
+#define	OHCI_CONTROL		0x04
+#define	OHCI_COMMAND_STATUS	0x08
+#define	OHCI_INT_STATUS		0x0C
+#define	OHCI_INT_ENABLE		0x10
+#define	OHCI_INT_DISABLE	0x14
+#define	OHCI_HCCA		0x18
+#define	OHCI_PERI_CUR_ED	0x1C
+#define	OHCI_CTRL_HEAD_ED	0x20
+#define	OHCI_CTRL_CUR_ED	0x24
+#define	OHCI_BULK_HEAD_ED	0x28
+#define	OHCI_BULK_CUR_ED	0x2C
+#define	OHCI_DONE_HEAD		0x30
+#define	OHCI_FM_INTERVAL	0x34
+#define	OHCI_FM_REMAINING	0x38
+#define	OHCI_FM_NUMBER		0x3C
+#define	OHCI_PERI_START		0x40
+#define	OHCI_LS_THRESHOLD	0x44
+#define	OHCI_RH_DESCRIPTORA	0x48
+#define	OHCI_RH_DESCRIPTORB	0x4C
+#define	OHCI_RH_STATUS		0x50
+#define	OHCI_RH_PORT_STATUS1	0x54
+#define	OHCI_RH_PORT_STATUS2	0x58
+#define	OHCI_RH_PORT_STATUS3	0x5C
+#define	OHCI_RH_PORT_STATUS4	0x60
+
+/* KEL : MEM SPACE; REG :32BITS WIDTH */
+#define	KEL_HCE_CTRL	0x100
+#define	KEL_HCE_IN	0x104
+#define	KEL_HCE_OUT	0x108
+#define	KEL_HCE_STS	0x10C
+#define	KEL_PORTA	0x92	/* 8bits */
+/* PIC : I/O SPACE; REG : 8BITS */
+#define	PIC_ICW1_MASTER	0x20
+#define	PIC_ICW1_SLAVE	0xA0
+#define	PIC_ICW2_MASTER	0x21
+#define	PIC_ICW2_SLAVE	0xA1
+#define	PIC_ICW3_MASTER	0x21
+#define	PIC_ICW3_SLAVE	0xA1
+#define	PIC_ICW4_MASTER	0x21
+#define	PIC_ICW4_SLAVE	0xA1
+#define	PIC_OCW1_MASTER	0x21
+#define	PIC_OCW1_SLAVE	0xA1
+#define	PIC_OCW2_MASTER	0x20
+#define	PIC_OCW2_SLAVE	0xA0
+#define	PIC_OCW3_MASTER	0x20
+#define	PIC_OCW3_SLAVE	0xA0
+#define	PIC_IRR_MASTER	0x20
+#define	PIC_IRR_SLAVE	0xA0
+#define	PIC_ISR_MASTER	0x20
+#define	PIC_ISR_SLAVE	0xA0
+#define	PIC_INT_SEL1	0x4D0
+#define	PIC_INT_SEL2	0x4D1
+/* GPIO : I/O SPACE; REG : 32BITS */
+#define	GPIOL_OUT_VAL		0x00
+#define	GPIOL_OUT_EN		0x04
+#define	GPIOL_OUT_OD_EN		0x08
+#define	GPIOL_OUT_INVRT_EN	0x0c
+#define	GPIOL_OUT_AUX1_SEL	0x10
+#define	GPIOL_OUT_AUX2_SEL	0x14
+#define	GPIOL_PU_EN		0x18
+#define	GPIOL_PD_EN		0x1c
+#define	GPIOL_IN_EN		0x20
+#define	GPIOL_IN_INVRT_EN	0x24
+#define	GPIOL_IN_FLTR_EN	0x28
+#define	GPIOL_IN_EVNTCNT_EN	0x2c
+#define	GPIOL_IN_READBACK	0x30
+#define	GPIOL_IN_AUX1_SEL	0x34
+#define	GPIOL_EVNT_EN		0x38
+#define	GPIOL_LOCK_EN		0x3c
+#define	GPIOL_IN_POSEDGE_EN	0x40
+#define	GPIOL_IN_NEGEDGE_EN	0x44
+#define	GPIOL_IN_POSEDGE_STS	0x48
+#define	GPIOL_IN_NEGEDGE_STS	0x4c
+#define	GPIOH_OUT_VAL		0x80
+#define	GPIOH_OUT_EN		0x84
+#define	GPIOH_OUT_OD_EN		0x88
+#define	GPIOH_OUT_INVRT_EN	0x8c
+#define	GPIOH_OUT_AUX1_SEL	0x90
+#define	GPIOH_OUT_AUX2_SEL	0x94
+#define	GPIOH_PU_EN		0x98
+#define	GPIOH_PD_EN		0x9c
+#define	GPIOH_IN_EN		0xA0
+#define	GPIOH_IN_INVRT_EN	0xA4
+#define	GPIOH_IN_FLTR_EN	0xA8
+#define	GPIOH_IN_EVNTCNT_EN	0xAc
+#define	GPIOH_IN_READBACK	0xB0
+#define	GPIOH_IN_AUX1_SEL	0xB4
+#define	GPIOH_EVNT_EN		0xB8
+#define	GPIOH_LOCK_EN		0xBc
+#define	GPIOH_IN_POSEDGE_EN	0xC0
+#define	GPIOH_IN_NEGEDGE_EN	0xC4
+#define	GPIOH_IN_POSEDGE_STS	0xC8
+#define	GPIOH_IN_NEGEDGE_STS	0xCC
+/* SMB : I/O SPACE, REG : 8BITS WIDTH */
+#define	SMB_SDA				0x00
+#define	SMB_STS				0x01
+#define	SMB_STS_SLVSTP		(1 << 7)
+#define	SMB_STS_SDAST		(1 << 6)
+#define	SMB_STS_BER		(1 << 5)
+#define	SMB_STS_NEGACK		(1 << 4)
+#define	SMB_STS_STASTR		(1 << 3)
+#define	SMB_STS_NMATCH		(1 << 2)
+#define	SMB_STS_MASTER		(1 << 1)
+#define	SMB_STS_XMIT		(1 << 0)
+#define	SMB_CTRL_STS			0x02
+#define	SMB_CSTS_TGSTL		(1 << 5)
+#define	SMB_CSTS_TSDA		(1 << 4)
+#define	SMB_CSTS_GCMTCH		(1 << 3)
+#define	SMB_CSTS_MATCH		(1 << 2)
+#define	SMB_CSTS_BB		(1 << 1)
+#define	SMB_CSTS_BUSY		(1 << 0)
+#define	SMB_CTRL1			0x03
+#define	SMB_CTRL1_STASTRE	(1 << 7)
+#define	SMB_CTRL1_NMINTE	(1 << 6)
+#define	SMB_CTRL1_GCMEN		(1 << 5)
+#define	SMB_CTRL1_ACK		(1 << 4)
+#define	SMB_CTRL1_RSVD		(1 << 3)
+#define	SMB_CTRL1_INTEN		(1 << 2)
+#define	SMB_CTRL1_STOP		(1 << 1)
+#define	SMB_CTRL1_START		(1 << 0)
+#define	SMB_ADDR			0x04
+#define	SMB_ADDR_SAEN		(1 << 7)
+#define	SMB_CONTROLLER_ADDR	(0xef << 0)
+#define	SMB_CTRL2			0x05
+#define	SMB_FREQ		(0x20 << 1)	/* (0x7f << 1) */
+#define	SMB_ENABLE		(0x01 << 0)
+#define	SMB_CTRL3			0x06
+
+/*********************************** LEGACY I/O
*******************************/
+
+/*
+ * LEGACY I/O SPACE BASE
+ */
+#define	CS5536_LEGACY_BASE_ADDR		(PCI_IO_BASE_VA | 0x0000)
+
+/*
+ * IDE LEGACY REG : legacy IO address is 0x170~0x177 and 0x376
(0x1f0~0x1f7 and 0x3f6)
+ * all registers are 16bits except the IDE_LEGACY_DATA reg
+ * some registers are read only and the 
+ */
+#define	PRI_IDE_LEGACY_REG(offset) 	(CS5536_LEGACY_BASE_ADDR | 0x1f0 |
offset)
+#define	SEC_IDE_LEGACY_REG(offset)	(CS5536_LEGACY_BASE_ADDR | 0x170 |
offset)
+
+#define	IDE_LEGACY_DATA		0x00	/* RW */
+#define	IDE_LEGACY_ERROR	0x01	/* RO */
+#define	IDE_LEGACY_FEATURE	0x01	/* WO */
+#define	IDE_LEGACY_SECTOR_COUNT	0x02	/* RW */
+#define	IDE_LEGACY_SECTOR_NUM	0x03	/* RW */
+#define	IDE_LEGACY_CYL_LO	0x04	/* RW */
+#define	IDE_LEGACY_CYL_HI	0x05	/* RW */
+#define	IDE_LEGACY_HEAD		0x06	/* RW */
+#define	IDE_LEGACY_HEAD_DRV		(1 << 4)
+#define	IDE_LEGACY_HEAD_LBA		(1 << 6)
+#define	IDE_LEGACY_HEAD_IBM		(1 << 7 | 1 << 5)
+#define	IDE_LEGACY_STATUS	0x07	/* RO */
+#define IDE_LEGACY_STATUS_ERR		(1 << 0)
+#define	IDE_LEGACY_STATUS_IDX		(1 << 1)
+#define IDE_LEGACY_STATUS_CORR		(1 << 2)
+#define	IDE_LEGACY_STATUS_DRQ		(1 << 3)
+#define	IDE_LEGACY_STATUS_DSC 		(1 << 4)
+#define	IDE_LEGACY_STATUS_DWF		(1 << 5)
+#define	IDE_LEGACY_STATUS_DRDY		(1 << 6)
+#define	IDE_LEGACY_STATUS_BUSY		(1 << 7)
+#define	IDE_LEGACY_COMMAND	0x07	/* WO */
+#define	IDE_LEGACY_ASTATUS	0x206	/* RO */
+#define	IDE_LEGACY_CTRL		0x206	/* WO */
+#define	IDE_LEGACY_CTRL_IDS	0x02
+#define	IDE_LEGACY_CTRL_RST	0x04
+#define	IDE_LEGACY_CTRL_4BIT	0x08
+
+/**********************************************************************************/
+
+#endif				/* _CS5536_H */
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h
b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h
new file mode 100644
index 0000000..e60a824
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h
@@ -0,0 +1,181 @@
+/*
+ * the definition file of cs5536 Virtual Support Module(VSM).
+ * pci configuration space can be accessed through the VSM, so
+ * there is no need the MSR read/write now, except the spec. MSR
+ * registers which are not implemented yet.
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author : jlliu, liujl@lemote.com
+ */
+
+#ifndef	_CS5536_PCI_H
+#define	_CS5536_PCI_H
+
+#define PCI_OPS_CS5536_IDSEL    14
+extern void cs5536_pci_conf_write4(int function, int reg, u32 value);
+extern u32  cs5536_pci_conf_read4(int function, int reg);
+
+/*
+#define	TEST_CS5536_USE_FLASH
+#ifdef	TEST_CS5536_USE_FLASH
+#define	TEST_CS5536_USE_NOR_FLASH
+#endif
+*/
+#define	TEST_CS5536_USE_EHCI
+#define	TEST_CS5536_USE_UDC
+#define	TEST_CS5536_USE_OTG
+
+#define	PCI_SPECIAL_SHUTDOWN	1
+#define	CS5536_FLASH_INTR	6
+#define	CS5536_ACC_INTR		9
+#define	CS5536_IDE_INTR		14
+#define	CS5536_USB_INTR		11
+#define	CS5536_UART1_INTR	4
+#define	CS5536_UART2_INTR	3
+
+/************************* PCI BUS DEVICE FUNCTION
********************/
+
+/*
+ * PCI bus device function
+ */
+#define	PCI_BUS_CS5536		0
+#define	PCI_IDSEL_CS5536	14
+#define	PCI_CFG_BASE		0x02000000
+
+#define	CS5536_ISA_FUNC		0
+#define	CS5536_FLASH_FUNC	1
+#define	CS5536_IDE_FUNC		2
+#define	CS5536_ACC_FUNC		3
+#define	CS5536_OHCI_FUNC	4
+#define	CS5536_EHCI_FUNC	5
+#define	CS5536_UDC_FUNC		6
+#define	CS5536_OTG_FUNC		7
+#define	CS5536_FUNC_START	0
+#define	CS5536_FUNC_END		7
+#define	CS5536_FUNC_COUNT	(CS5536_FUNC_END - CS5536_FUNC_START + 1)
+
+/***************************** STANDARD PCI-2.2 EXPANSION
***********************/
+
+/*
+ * PCI configuration space
+ * we have to virtualize the PCI configure space head, so we should
+ * define the necessary IDs and some others.
+ */
+/* VENDOR ID */
+#define	CS5536_VENDOR_ID	0x1022
+
+/* DEVICE ID */
+#define	CS5536_ISA_DEVICE_ID		0x2090
+#define	CS5536_FLASH_DEVICE_ID		0x2091
+#define	CS5536_IDE_DEVICE_ID		0x209a
+#define	CS5536_ACC_DEVICE_ID		0x2093
+#define	CS5536_OHCI_DEVICE_ID		0x2094
+#define	CS5536_EHCI_DEVICE_ID		0x2095
+#define	CS5536_UDC_DEVICE_ID		0x2096
+#define	CS5536_OTG_DEVICE_ID		0x2097
+
+/* CLASS CODE : CLASS SUB-CLASS INTERFACE */
+#define	CS5536_ISA_CLASS_CODE		0x060100
+#define	CS5536_FLASH_CLASS_CODE		0x050100
+#define CS5536_IDE_CLASS_CODE		0x010180
+#define	CS5536_ACC_CLASS_CODE		0x040100
+#define	CS5536_OHCI_CLASS_CODE		0x0C0310
+#define	CS5536_EHCI_CLASS_CODE		0x0C0320
+#define	CS5536_UDC_CLASS_CODE		0x0C03FE
+#define	CS5536_OTG_CLASS_CODE		0x0C0380
+
+/* BHLC : BIST HEADER-TYPE LATENCY-TIMER CACHE-LINE-SIZE */
+#define	PCI_NONE_BIST			0x00	//RO not implemented yet.
+#define	PCI_BRIDGE_HEADER_TYPE		0x80	//RO
+#define	PCI_NORMAL_HEADER_TYPE		0x00
+#define	PCI_NORMAL_LATENCY_TIMER	0x00
+#define	PCI_NORMAL_CACHE_LINE_SIZE	0x08	//RW
+
+/* BAR */
+#define	PCI_BAR0_REG			0x10
+#define	PCI_BAR1_REG			0x14
+#define	PCI_BAR2_REG			0x18
+#define	PCI_BAR3_REG			0x1c
+#define	PCI_BAR4_REG			0x20
+#define	PCI_BAR5_REG			0x24
+#define	PCI_BAR_COUNT			6
+#define	PCI_BAR_RANGE_MASK		0xFFFFFFFF
+
+/* CARDBUS CIS POINTER */
+#define	PCI_CARDBUS_CIS_POINTER		0x00000000
+
+/* SUBSYSTEM VENDOR ID  */
+#define	CS5536_SUB_VENDOR_ID		CS5536_VENDOR_ID
+
+/* SUBSYSTEM ID */
+#define	CS5536_ISA_SUB_ID		CS5536_ISA_DEVICE_ID
+#define	CS5536_FLASH_SUB_ID		CS5536_FLASH_DEVICE_ID
+#define	CS5536_IDE_SUB_ID		CS5536_IDE_DEVICE_ID
+#define	CS5536_ACC_SUB_ID		CS5536_ACC_DEVICE_ID
+#define	CS5536_OHCI_SUB_ID		CS5536_OHCI_DEVICE_ID
+#define	CS5536_EHCI_SUB_ID		CS5536_EHCI_DEVICE_ID
+#define	CS5536_UDC_SUB_ID		CS5536_UDC_DEVICE_ID
+#define	CS5536_OTG_SUB_ID		CS5536_OTG_DEVICE_ID
+
+/* EXPANSION ROM BAR */
+#define	PCI_EXPANSION_ROM_BAR		0x00000000
+
+/* CAPABILITIES POINTER */
+#define	PCI_CAPLIST_POINTER		0x00000000
+#define PCI_CAPLIST_USB_POINTER		0x40
+/* INTERRUPT */
+#define	PCI_MAX_LATENCY			0x40
+#define	PCI_MIN_GRANT			0x00
+#define	PCI_DEFAULT_PIN			0x01
+
+/**************************** EXPANSION PCI REG
**************************************/
+
+/*
+ * ISA EXPANSION
+ */
+#define	PCI_UART1_INT_REG 	0x50
+#define PCI_UART2_INT_REG	0x54
+#define	PCI_ISA_FIXUP_REG	0x58
+
+/*
+ * FLASH EXPANSION
+ */
+#define	PCI_FLASH_INT_REG		0x50
+#define	PCI_NOR_FLASH_CTRL_REG		0x40
+#define	PCI_NOR_FLASH_T01_REG		0x44
+#define	PCI_NOR_FLASH_T23_REG		0x48
+#define	PCI_NAND_FLASH_TDATA_REG	0x60
+#define	PCI_NAND_FLASH_TCTRL_REG	0x64
+#define	PCI_NAND_FLASH_RSVD_REG		0x68
+#define	PCI_FLASH_SELECT_REG		0x70
+
+/*
+ * IDE EXPANSION
+ */
+#define	PCI_IDE_CFG_REG		0x40
+#define	CS5536_IDE_FLASH_SIGNATURE	0xDEADBEEF
+#define	PCI_IDE_DTC_REG		0x48
+#define	PCI_IDE_CAST_REG	0x4C
+#define	PCI_IDE_ETC_REG		0x50
+#define	PCI_IDE_PM_REG		0x54
+#define	PCI_IDE_INT_REG		0x60
+
+/*
+ * ACC EXPANSION
+ */
+#define	PCI_ACC_INT_REG		0x50
+
+/*
+ * OHCI EXPANSION : INTTERUPT IS IMPLEMENTED BY THE OHCI
+ */
+#define	PCI_OHCI_PM_REG		0x40
+#define	PCI_OHCI_INT_REG	0x50
+
+/*
+ * EHCI EXPANSION
+ */
+#define	PCI_EHCI_LEGSMIEN_REG	0x50
+#define	PCI_EHCI_LEGSMISTS_REG	0x54
+#define	PCI_EHCI_FLADJ_REG	0x60
+
+#endif				/* _CS5536_PCI_H_ */
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/mfgpt.h
b/arch/mips/include/asm/mach-loongson/cs5536/mfgpt.h
new file mode 100644
index 0000000..c435389
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cs5536/mfgpt.h
@@ -0,0 +1,15 @@
+/*
+ * cs5536 mfgpt header file
+ */
+
+#ifndef _CS5536_MFGPT_H
+#define _CS5536_MFGPT_H
+
+#include <cs5536/cs5536.h>
+
+#define MFGPT_BASE	mfgpt_base
+#define MFGPT0_CMP2	(MFGPT_BASE + 2)
+#define MFGPT0_CNT	(MFGPT_BASE + 4)
+#define MFGPT0_SETUP	(MFGPT_BASE + 6) 
+
+#endif /*!_CS5536_MFGPT_H */
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/pcireg.h
b/arch/mips/include/asm/mach-loongson/cs5536/pcireg.h
new file mode 100644
index 0000000..aa823d3
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cs5536/pcireg.h
@@ -0,0 +1,485 @@
+/*
+ * Copyright (c) 2001, 2006 www.ict.ac.cn.
+ * Copyright (c) 2006, 2008 www.lemote.com.cn.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the named License,
+ * or any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DEV_PCI_PCIREG_H_
+#define	_DEV_PCI_PCIREG_H_
+
+
+/*
+ * Standardized PCI configuration information
+ *
+ * XXX This is not complete.
+ */
+
+/*
+ * Device identification register; contains a vendor ID and a device
ID.
+ */
+#define	PCI_ID_REG			0x00
+
+typedef u_int16_t pci_vendor_id_t;
+typedef u_int16_t pci_product_id_t;
+
+#define	PCI_VENDOR_SHIFT			0
+#define	PCI_VENDOR_MASK				0xffff
+#define	PCI_VENDOR(id) \
+	    (((id) >> PCI_VENDOR_SHIFT) & PCI_VENDOR_MASK)
+
+#define	PCI_PRODUCT_SHIFT			16
+#define	PCI_PRODUCT_MASK			0xffff
+#define	PCI_PRODUCT(id) \
+	    (((id) >> PCI_PRODUCT_SHIFT) & PCI_PRODUCT_MASK)
+
+/*
+ * Command and status register.
+ */
+#define	PCI_COMMAND_STATUS_REG			0x04
+
+#define	PCI_COMMAND_IO_ENABLE			0x00000001
+#define	PCI_COMMAND_MEM_ENABLE			0x00000002
+#define	PCI_COMMAND_MASTER_ENABLE		0x00000004
+#define	PCI_COMMAND_SPECIAL_ENABLE		0x00000008
+#define	PCI_COMMAND_INVALIDATE_ENABLE		0x00000010
+#define	PCI_COMMAND_PALETTE_ENABLE		0x00000020
+#define	PCI_COMMAND_PARITY_ENABLE		0x00000040
+#define	PCI_COMMAND_STEPPING_ENABLE		0x00000080
+#define	PCI_COMMAND_SERR_ENABLE			0x00000100
+#define	PCI_COMMAND_BACKTOBACK_ENABLE		0x00000200
+
+#define	PCI_STATUS_CAPLIST_SUPPORT		0x00100000
+#define	PCI_STATUS_66MHZ_SUPPORT		0x00200000
+#define	PCI_STATUS_UDF_SUPPORT			0x00400000
+#define	PCI_STATUS_BACKTOBACK_SUPPORT		0x00800000
+#define	PCI_STATUS_PARITY_ERROR			0x01000000
+#define	PCI_STATUS_DEVSEL_FAST			0x00000000
+#define	PCI_STATUS_DEVSEL_MEDIUM		0x02000000
+#define	PCI_STATUS_DEVSEL_SLOW			0x04000000
+#define	PCI_STATUS_DEVSEL_MASK			0x06000000
+#define	PCI_STATUS_TARGET_TARGET_ABORT		0x08000000
+#define	PCI_STATUS_MASTER_TARGET_ABORT		0x10000000
+#define	PCI_STATUS_MASTER_ABORT			0x20000000
+#define	PCI_STATUS_SPECIAL_ERROR		0x40000000
+#define	PCI_STATUS_PARITY_DETECT		0x80000000
+
+/*
+ * PCI Class and Revision Register; defines type and revision of
device.
+ */
+#define	PCI_CLASS_REG			0x08
+
+typedef u_int8_t pci_class_t;
+typedef u_int8_t pci_subclass_t;
+typedef u_int8_t pci_interface_t;
+typedef u_int8_t pci_revision_t;
+
+#define	PCI_CLASS_SHIFT				24
+#define	PCI_CLASS_MASK				0xff
+#define	PCI_CLASS(cr) \
+	    (((cr) >> PCI_CLASS_SHIFT) & PCI_CLASS_MASK)
+
+#define	PCI_SUBCLASS_SHIFT			16
+#define	PCI_SUBCLASS_MASK			0xff
+#define	PCI_SUBCLASS(cr) \
+	    (((cr) >> PCI_SUBCLASS_SHIFT) & PCI_SUBCLASS_MASK)
+
+#define PCI_ISCLASS(what, class, subclass) \
+	(((what) & 0xffff0000) == (class << 24 | subclass << 16))
+
+#define	PCI_INTERFACE_SHIFT			8
+#define	PCI_INTERFACE_MASK			0xff
+#define	PCI_INTERFACE(cr) \
+	    (((cr) >> PCI_INTERFACE_SHIFT) & PCI_INTERFACE_MASK)
+
+#define	PCI_REVISION_SHIFT			0
+#define	PCI_REVISION_MASK			0xff
+#define	PCI_REVISION(cr) \
+	    (((cr) >> PCI_REVISION_SHIFT) & PCI_REVISION_MASK)
+
+/* base classes */
+#define	PCI_CLASS_PREHISTORIC			0x00
+#define	PCI_CLASS_MASS_STORAGE			0x01
+#define	PCI_CLASS_NETWORK			0x02
+#define	PCI_CLASS_DISPLAY			0x03
+#define	PCI_CLASS_MULTIMEDIA			0x04
+#define	PCI_CLASS_MEMORY			0x05
+#define	PCI_CLASS_BRIDGE			0x06
+#define	PCI_CLASS_COMMUNICATIONS		0x07
+#define	PCI_CLASS_SYSTEM			0x08
+#define	PCI_CLASS_INPUT				0x09
+#define	PCI_CLASS_DOCK				0x0a
+#define	PCI_CLASS_PROCESSOR			0x0b
+#define	PCI_CLASS_SERIALBUS			0x0c
+#define	PCI_CLASS_WIRELESS			0x0d
+#define	PCI_CLASS_I2O				0x0e
+#define	PCI_CLASS_SATCOM			0x0f
+#define	PCI_CLASS_CRYPTO			0x10
+#define	PCI_CLASS_DASP				0x11
+#define	PCI_CLASS_UNDEFINED			0xff
+
+/* 0x00 prehistoric subclasses */
+#define	PCI_SUBCLASS_PREHISTORIC_MISC		0x00
+#define	PCI_SUBCLASS_PREHISTORIC_VGA		0x01
+
+/* 0x01 mass storage subclasses */
+#define	PCI_SUBCLASS_MASS_STORAGE_SCSI		0x00
+#define	PCI_SUBCLASS_MASS_STORAGE_IDE		0x01
+#define	PCI_SUBCLASS_MASS_STORAGE_FLOPPY	0x02
+#define	PCI_SUBCLASS_MASS_STORAGE_IPI		0x03
+#define	PCI_SUBCLASS_MASS_STORAGE_RAID		0x04
+#define	PCI_SUBCLASS_MASS_STORAGE_ATA		0x05
+#define	PCI_SUBCLASS_MASS_STORAGE_MISC		0x80
+
+/* 0x02 network subclasses */
+#define	PCI_SUBCLASS_NETWORK_ETHERNET		0x00
+#define	PCI_SUBCLASS_NETWORK_TOKENRING		0x01
+#define	PCI_SUBCLASS_NETWORK_FDDI		0x02
+#define	PCI_SUBCLASS_NETWORK_ATM		0x03
+#define	PCI_SUBCLASS_NETWORK_ISDN		0x04
+#define	PCI_SUBCLASS_NETWORK_WORLDFIP		0x05
+#define	PCI_SUBCLASS_NETWORK_PCIMGMULTICOMP	0x06
+#define	PCI_SUBCLASS_NETWORK_MISC		0x80
+
+/* 0x03 display subclasses */
+#define	PCI_SUBCLASS_DISPLAY_VGA		0x00
+#define	PCI_SUBCLASS_DISPLAY_XGA		0x01
+#define	PCI_SUBCLASS_DISPLAY_3D			0x02
+#define	PCI_SUBCLASS_DISPLAY_MISC		0x80
+
+/* 0x04 multimedia subclasses */
+#define	PCI_SUBCLASS_MULTIMEDIA_VIDEO		0x00
+#define	PCI_SUBCLASS_MULTIMEDIA_AUDIO		0x01
+#define	PCI_SUBCLASS_MULTIMEDIA_TELEPHONY	0x02
+#define	PCI_SUBCLASS_MULTIMEDIA_MISC		0x80
+
+/* 0x05 memory subclasses */
+#define	PCI_SUBCLASS_MEMORY_RAM			0x00
+#define	PCI_SUBCLASS_MEMORY_FLASH		0x01
+#define	PCI_SUBCLASS_MEMORY_MISC		0x80
+
+/* 0x06 bridge subclasses */
+#define	PCI_SUBCLASS_BRIDGE_HOST		0x00
+#define	PCI_SUBCLASS_BRIDGE_ISA			0x01
+#define	PCI_SUBCLASS_BRIDGE_EISA		0x02
+#define	PCI_SUBCLASS_BRIDGE_MC			0x03
+#define	PCI_SUBCLASS_BRIDGE_PCI			0x04
+#define	PCI_SUBCLASS_BRIDGE_PCMCIA		0x05
+#define	PCI_SUBCLASS_BRIDGE_NUBUS		0x06
+#define	PCI_SUBCLASS_BRIDGE_CARDBUS		0x07
+#define	PCI_SUBCLASS_BRIDGE_RACEWAY		0x08
+#define	PCI_SUBCLASS_BRIDGE_STPCI		0x09
+#define	PCI_SUBCLASS_BRIDGE_INFINIBAND		0x0a
+#define	PCI_SUBCLASS_BRIDGE_MISC		0x80
+
+/* 0x07 communications subclasses */
+#define	PCI_SUBCLASS_COMMUNICATIONS_SERIAL	0x00
+#define	PCI_SUBCLASS_COMMUNICATIONS_PARALLEL	0x01
+#define	PCI_SUBCLASS_COMMUNICATIONS_MPSERIAL	0x02
+#define	PCI_SUBCLASS_COMMUNICATIONS_MODEM	0x03
+#define	PCI_SUBCLASS_COMMUNICATIONS_MISC	0x80
+
+/* 0x08 system subclasses */
+#define	PCI_SUBCLASS_SYSTEM_PIC			0x00
+#define	PCI_SUBCLASS_SYSTEM_DMA			0x01
+#define	PCI_SUBCLASS_SYSTEM_TIMER		0x02
+#define	PCI_SUBCLASS_SYSTEM_RTC			0x03
+#define	PCI_SUBCLASS_SYSTEM_PCIHOTPLUG		0x04
+#define	PCI_SUBCLASS_SYSTEM_MISC		0x80
+
+/* 0x09 input subclasses */
+#define	PCI_SUBCLASS_INPUT_KEYBOARD		0x00
+#define	PCI_SUBCLASS_INPUT_DIGITIZER		0x01
+#define	PCI_SUBCLASS_INPUT_MOUSE		0x02
+#define	PCI_SUBCLASS_INPUT_SCANNER		0x03
+#define	PCI_SUBCLASS_INPUT_GAMEPORT		0x04
+#define	PCI_SUBCLASS_INPUT_MISC			0x80
+
+/* 0x0a dock subclasses */
+#define	PCI_SUBCLASS_DOCK_GENERIC		0x00
+#define	PCI_SUBCLASS_DOCK_MISC			0x80
+
+/* 0x0b processor subclasses */
+#define	PCI_SUBCLASS_PROCESSOR_386		0x00
+#define	PCI_SUBCLASS_PROCESSOR_486		0x01
+#define	PCI_SUBCLASS_PROCESSOR_PENTIUM		0x02
+#define	PCI_SUBCLASS_PROCESSOR_ALPHA		0x10
+#define	PCI_SUBCLASS_PROCESSOR_POWERPC		0x20
+#define	PCI_SUBCLASS_PROCESSOR_MIPS		0x30
+#define	PCI_SUBCLASS_PROCESSOR_COPROC		0x40
+
+/* 0x0c serial bus subclasses */
+#define	PCI_SUBCLASS_SERIALBUS_FIREWIRE		0x00
+#define	PCI_SUBCLASS_SERIALBUS_ACCESS		0x01
+#define	PCI_SUBCLASS_SERIALBUS_SSA		0x02
+#define	PCI_SUBCLASS_SERIALBUS_USB		0x03
+#define	PCI_SUBCLASS_SERIALBUS_FIBER		0x04
+#define	PCI_SUBCLASS_SERIALBUS_SMBUS		0x05
+#define	PCI_SUBCLASS_SERIALBUS_INFINIBAND	0x06
+#define	PCI_SUBCLASS_SERIALBUS_IPMI		0x07
+#define	PCI_SUBCLASS_SERIALBUS_SERCOS		0x08
+#define	PCI_SUBCLASS_SERIALBUS_CANBUS		0x09
+
+/* 0x0d wireless subclasses */
+#define	PCI_SUBCLASS_WIRELESS_IRDA		0x00
+#define	PCI_SUBCLASS_WIRELESS_CONSUMERIR	0x01
+#define	PCI_SUBCLASS_WIRELESS_RF		0x10
+#define	PCI_SUBCLASS_WIRELESS_MISC		0x80
+
+/* 0x0e I2O (Intelligent I/O) subclasses */
+#define	PCI_SUBCLASS_I2O_STANDARD		0x00
+
+/* 0x0f satellite communication subclasses */
+/*	PCI_SUBCLASS_SATCOM_???			0x00    / * XXX ??? */
+#define	PCI_SUBCLASS_SATCOM_TV			0x01
+#define	PCI_SUBCLASS_SATCOM_AUDIO		0x02
+#define	PCI_SUBCLASS_SATCOM_VOICE		0x03
+#define	PCI_SUBCLASS_SATCOM_DATA		0x04
+
+/* 0x10 encryption/decryption subclasses */
+#define	PCI_SUBCLASS_CRYPTO_NETCOMP		0x00
+#define	PCI_SUBCLASS_CRYPTO_ENTERTAINMENT	0x10
+#define	PCI_SUBCLASS_CRYPTO_MISC		0x80
+
+/* 0x11 data acquisition and signal processing subclasses */
+#define	PCI_SUBCLASS_DASP_DPIO			0x00
+#define	PCI_SUBCLASS_DASP_TIMEFREQ		0x01
+#define	PCI_SUBCLASS_DASP_MISC			0x80
+
+/*
+ * PCI BIST/Header Type/Latency Timer/Cache Line Size Register.
+ */
+#define	PCI_BHLC_REG			0x0c
+
+#define	PCI_BIST_SHIFT				24
+#define	PCI_BIST_MASK				0xff
+#define	PCI_BIST(bhlcr) \
+	    (((bhlcr) >> PCI_BIST_SHIFT) & PCI_BIST_MASK)
+
+#define	PCI_HDRTYPE_SHIFT			16
+#define	PCI_HDRTYPE_MASK			0xff
+#define	PCI_HDRTYPE(bhlcr) \
+	    (((bhlcr) >> PCI_HDRTYPE_SHIFT) & PCI_HDRTYPE_MASK)
+
+#define PCI_HDRTYPE_TYPE(bhlcr) \
+	    (PCI_HDRTYPE(bhlcr) & 0x7f)
+#define	PCI_HDRTYPE_MULTIFN(bhlcr) \
+	    ((PCI_HDRTYPE(bhlcr) & 0x80) != 0)
+
+#define	PCI_LATTIMER_SHIFT			8
+#define	PCI_LATTIMER_MASK			0xff
+#define	PCI_LATTIMER(bhlcr) \
+	    (((bhlcr) >> PCI_LATTIMER_SHIFT) & PCI_LATTIMER_MASK)
+
+#define	PCI_CACHELINE_SHIFT			0
+#define	PCI_CACHELINE_MASK			0xff
+#define	PCI_CACHELINE(bhlcr) \
+	    (((bhlcr) >> PCI_CACHELINE_SHIFT) & PCI_CACHELINE_MASK)
+
+/* config registers for header type 0 devices */
+
+#define PCI_MAPS	0x10
+#define PCI_CARDBUSCIS	0x28
+#define PCI_SUBVEND_0	0x2c
+#define PCI_SUBDEV_0	0x2e
+#define PCI_INTLINE	0x3c
+#define PCI_INTPIN	0x3d
+#define PCI_MINGNT	0x3e
+#define PCI_MAXLAT	0x3f
+
+/* config registers for header type 1 devices */
+
+#define PCI_SECSTAT_1	0 /**/
+
+#define PCI_PRIBUS_1	0x18
+#define PCI_SECBUS_1	0x19
+#define PCI_SUBBUS_1	0x1a
+#define PCI_SECLAT_1	0x1b
+
+#define PCI_IOBASEL_1	0x1c
+#define PCI_IOLIMITL_1	0x1d
+#define PCI_IOBASEH_1	0x30 /**/
+#define PCI_IOLIMITH_1	0x32 /**/ 
+
+#define PCI_MEMBASE_1	0x20
+#define PCI_MEMLIMIT_1	0x22
+
+#define PCI_PMBASEL_1	0x24
+#define PCI_PMLIMITL_1	0x26
+#define PCI_PMBASEH_1	0 /**/
+#define PCI_PMLIMITH_1	0 /**/
+
+#define PCI_BRIDGECTL_1 0 /**/
+
+#define PCI_SUBVEND_1	0x34
+#define PCI_SUBDEV_1	0x36
+
+/* config registers for header type 2 devices */
+
+#define PCI_SECSTAT_2	0x16
+
+#define PCI_PRIBUS_2	0x18
+#define PCI_SECBUS_2	0x19
+#define PCI_SUBBUS_2	0x1a
+#define PCI_SECLAT_2	0x1b
+
+#define PCI_MEMBASE0_2	0x1c
+#define PCI_MEMLIMIT0_2 0x20
+#define PCI_MEMBASE1_2	0x24
+#define PCI_MEMLIMIT1_2 0x28
+#define PCI_IOBASE0_2	0x2c
+#define PCI_IOLIMIT0_2	0x30
+#define PCI_IOBASE1_2	0x34
+#define PCI_IOLIMIT1_2	0x38
+
+#define PCI_BRIDGECTL_2 0x3e
+
+#define PCI_SUBVEND_2	0x40
+#define PCI_SUBDEV_2	0x42
+
+#define PCI_PCCARDIF_2	0x44
+
+/*
+ * Mapping registers
+ */
+#define	PCI_MAPREG_START		0x10
+#define	PCI_MAPREG_END			0x28
+#define	PCI_MAPREG_ROM			0x30
+#define	PCI_MAPREG_PPB_END		0x18
+#define	PCI_MAPREG_PCB_END		0x14
+
+#define	PCI_MAPREG_TYPE(mr)						\
+	    ((mr) & PCI_MAPREG_TYPE_MASK)
+#define	PCI_MAPREG_TYPE_MASK			0x00000001
+
+#define	PCI_MAPREG_TYPE_MEM			0x00000000
+#define	PCI_MAPREG_TYPE_IO			0x00000001
+#define	PCI_MAPREG_TYPE_ROM			0x00000001
+
+#define	PCI_MAPREG_MEM_TYPE(mr)						\
+	    ((mr) & PCI_MAPREG_MEM_TYPE_MASK)
+#define	PCI_MAPREG_MEM_TYPE_MASK		0x00000006
+
+#define	PCI_MAPREG_MEM_TYPE_32BIT		0x00000000
+#define	PCI_MAPREG_MEM_TYPE_32BIT_1M		0x00000002
+#define	PCI_MAPREG_MEM_TYPE_64BIT		0x00000004
+
+#define	PCI_MAPREG_MEM_CACHEABLE(mr)					\
+	    (((mr) & PCI_MAPREG_MEM_CACHEABLE_MASK) != 0)
+#define	PCI_MAPREG_MEM_CACHEABLE_MASK		0x00000008
+
+#define	PCI_MAPREG_MEM_PREFETCHABLE(mr)					\
+	    (((mr) & PCI_MAPREG_MEM_PREFETCHABLE_MASK) != 0)
+#define	PCI_MAPREG_MEM_PREFETCHABLE_MASK	0x00000008
+
+#define	PCI_MAPREG_MEM_ADDR(mr)						\
+	    ((mr) & PCI_MAPREG_MEM_ADDR_MASK)
+#define	PCI_MAPREG_MEM_SIZE(mr)						\
+	    (PCI_MAPREG_MEM_ADDR(mr) & -PCI_MAPREG_MEM_ADDR(mr))
+#define	PCI_MAPREG_MEM_ADDR_MASK		0xfffffff0
+
+#define	PCI_MAPREG_MEM64_ADDR(mr)					\
+	    ((mr) & PCI_MAPREG_MEM64_ADDR_MASK)
+#define	PCI_MAPREG_MEM64_SIZE(mr)					\
+	    (PCI_MAPREG_MEM64_ADDR(mr) & -PCI_MAPREG_MEM64_ADDR(mr))
+#define	PCI_MAPREG_MEM64_ADDR_MASK		0xfffffffffffffff0
+
+#define	PCI_MAPREG_IO_ADDR(mr)						\
+	    ((mr) & PCI_MAPREG_IO_ADDR_MASK)
+#define	PCI_MAPREG_IO_SIZE(mr)						\
+	    (PCI_MAPREG_IO_ADDR(mr) & -PCI_MAPREG_IO_ADDR(mr))
+#define	PCI_MAPREG_IO_ADDR_MASK			0xfffffffe
+
+#define	PCI_MAPREG_ROM_ADDR(mr)						\
+	    ((mr) & PCI_MAPREG_ROM_ADDR_MASK)
+#define	PCI_MAPREG_ROM_SIZE(mr)						\
+	    (PCI_MAPREG_ROM_ADDR(mr) & -PCI_MAPREG_ROM_ADDR(mr))
+#define	PCI_MAPREG_ROM_ADDR_MASK		0xfffff800
+
+/*
+ * Cardbus CIS pointer (PCI rev. 2.1)
+ */
+#define PCI_CARDBUS_CIS_REG 0x28
+
+/*
+ * Subsystem identification register; contains a vendor ID and a device
ID.
+ * Types/macros for PCI_ID_REG apply.
+ * (PCI rev. 2.1)
+ */
+#define PCI_SUBSYS_ID_REG 0x2c
+
+/*
+ * capabilities link list (PCI rev. 2.2)
+ */
+#define PCI_CAPLISTPTR_REG		0x34
+#define PCI_CAPLIST_PTR(cpr) ((cpr) & 0xff)
+#define PCI_CAPLIST_NEXT(cr) (((cr) >> 8) & 0xff)
+#define PCI_CAPLIST_CAP(cr) ((cr) & 0xff)
+
+#define PCI_CAP_REESSERVED	0x00
+#define PCI_CAP_PWRMGMT		0x01
+#define PCI_CAP_AGP		0x02
+#define PCI_CAP_VPD		0x03
+#define PCI_CAP_SLOTID		0x04
+#define PCI_CAP_MBI		0x05
+#define PCI_CAP_CPCI_HOTSWAP	0x06
+#define PCI_CAP_PCIX		0x07
+#define PCI_CAP_LDT		0x08
+#define PCI_CAP_VENDSPEC	0x09
+#define PCI_CAP_DEBUGPORT	0x0a
+#define PCI_CAP_CPCI_RSRCCTL	0x0b
+#define PCI_CAP_HOTPLUG		0x0c
+
+/*
+ * Power Management Control Status Register; access via capability
pointer.
+ */
+#define PCI_PMCSR_STATE_MASK	0x03
+#define PCI_PMCSR_STATE_D0	0x00
+#define PCI_PMCSR_STATE_D1	0x01
+#define PCI_PMCSR_STATE_D2	0x02
+#define PCI_PMCSR_STATE_D3	0x03
+
+/*
+ * Interrupt Configuration Register; contains interrupt pin and line.
+ */
+#define	PCI_INTERRUPT_REG		0x3c
+
+typedef u_int8_t pci_intr_pin_t;
+typedef u_int8_t pci_intr_line_t;
+
+#define	PCI_INTERRUPT_PIN_SHIFT			8
+#define	PCI_INTERRUPT_PIN_MASK			0xff
+#define	PCI_INTERRUPT_PIN(icr) \
+	    (((icr) >> PCI_INTERRUPT_PIN_SHIFT) & PCI_INTERRUPT_PIN_MASK)
+
+#define	PCI_INTERRUPT_LINE_SHIFT		0
+#define	PCI_INTERRUPT_LINE_MASK			0xff
+#define	PCI_INTERRUPT_LINE(icr) \
+	    (((icr) >> PCI_INTERRUPT_LINE_SHIFT) & PCI_INTERRUPT_LINE_MASK)
+
+#define	PCI_MIN_GNT_SHIFT			16
+#define	PCI_MIN_GNT_MASK			0xff
+#define	PCI_MIN_GNT(icr) \
+	    (((icr) >> PCI_MIN_GNT_SHIFT) & PCI_MIN_GNT_MASK)
+
+#define	PCI_MAX_LAT_SHIFT			24
+#define	PCI_MAX_LAT_MASK			0xff
+#define	PCI_MAX_LAT(icr) \
+	    (((icr) >> PCI_MAX_LAT_SHIFT) & PCI_MAX_LAT_MASK)
+
+#define	PCI_INTERRUPT_PIN_NONE			0x00
+#define	PCI_INTERRUPT_PIN_A			0x01
+#define	PCI_INTERRUPT_PIN_B			0x02
+#define	PCI_INTERRUPT_PIN_C			0x03
+#define	PCI_INTERRUPT_PIN_D			0x04
+#define	PCI_INTERRUPT_PIN_MAX			0x04
+
+#endif /* _DEV_PCI_PCIREG_H_ */
diff --git a/arch/mips/include/asm/mach-loongson/machine.h
b/arch/mips/include/asm/mach-loongson/machine.h
index 3614619..577b86c 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -13,6 +13,8 @@
 #ifndef __MACHINE_H
 #define __MACHINE_H
 
+#ifdef CONFIG_LEMOTE_FULOONG2E
+
 #define MACH_NAME			"lemote-fuloong(2e)"
 
 #define LOONGSON_UART_BASE		0x1fd003f8
@@ -23,5 +25,33 @@
 #define LOONGSON_TIMER_IRQ        	(MIPS_CPU_IRQ_BASE + 7)
 #define LOONGSON_DMATIMEOUT_IRQ   	(LOONGSON_IRQ_BASE + 10) 
 
+#else /* CONFIG_LEMOTE_FULOONG2F */
+
+#define MACH_NAME			"lemote-fuloong(2f)"
+
+#define LOONGSON_UART_BASE		0x1fd002f8
+
+#define LOONGSON_TIMER_IRQ		(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
+#define LOONGSON_PERFCNT_IRQ		(MIPS_CPU_IRQ_BASE + 6)	/* cpu perf
counter */
+#define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
+#define LOONGSON_UART_IRQ		(MIPS_CPU_IRQ_BASE + 3)	/* cpu serial port
*/
+#define LOONGSON_SOUTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)	/* i8259 */
+
+#define LOONGSON_INT_BIT_GPIO1		(1 << 1)
+#define LOONGSON_INT_BIT_GPIO2		(1 << 2)
+#define LOONGSON_INT_BIT_GPIO3		(1 << 3)
+#define LOONGSON_INT_BIT_PCI_INTA	(1 << 4)
+#define LOONGSON_INT_BIT_PCI_INTB	(1 << 5)
+#define LOONGSON_INT_BIT_PCI_INTC	(1 << 6)
+#define LOONGSON_INT_BIT_PCI_INTD	(1 << 7)
+#define LOONGSON_INT_BIT_PCI_PERR	(1 << 8)
+#define LOONGSON_INT_BIT_PCI_SERR	(1 << 9)
+#define LOONGSON_INT_BIT_DDR		(1 << 10)
+#define LOONGSON_INT_BIT_INT0		(1 << 11)
+#define LOONGSON_INT_BIT_INT1		(1 << 12)
+#define LOONGSON_INT_BIT_INT2		(1 << 13)
+#define LOONGSON_INT_BIT_INT3		(1 << 14)
+
+#endif
 
 #endif				/* ! __MACHINE_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 9ae71a5..42a5309 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -27,4 +27,32 @@ config LEMOTE_FULOONG2E
 	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
 	  an FPGA northbridge
 
+config LEMOTE_FULOONG2F
+	bool "Lemote Fuloong(2f) mini-PC"
+	select ARCH_SPARSEMEM_ENABLE
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON2F
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select HW_HAS_PCI
+	select I8259
+	select ISA
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select CPU_HAS_WB
+	select CS5536
+	help
+	  Lemote Fulong mini-PC board based on the Chinese Loongson-2F CPU
+
 endchoice
+
+config CS5536
+	bool
diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
index cc9f1c8..e9b8a81 100644
--- a/arch/mips/loongson/Makefile
+++ b/arch/mips/loongson/Makefile
@@ -9,3 +9,9 @@ obj-$(CONFIG_LOONGSON_SYSTEMS) += common/
 #
 
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fuloong-2e/
+
+#
+# Lemote Fuloong mini-PC (Loongson 2F-based)
+#
+
+obj-$(CONFIG_LEMOTE_FULOONG2F)	+= fuloong-2f/
diff --git a/arch/mips/loongson/common/Makefile
b/arch/mips/loongson/common/Makefile
index cda3d77..869adb5 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -17,4 +17,10 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 #
 obj-$(CONFIG_RTC_DRV_CMOS) += rtc.o
 
+#
+# Enable CS5536 Virtual Support Module(VSM) for virtulize the PCI
configure
+# space
+#
+obj-$(CONFIG_CS5536) += cs5536_vsm.o
+
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/common/bonito-irq.c
b/arch/mips/loongson/common/bonito-irq.c
index 61f473d..d5a5ae8 100644
--- a/arch/mips/loongson/common/bonito-irq.c
+++ b/arch/mips/loongson/common/bonito-irq.c
@@ -53,10 +53,13 @@ static struct irq_chip bonito_irq_type = {
 	.unmask	= bonito_irq_enable,
 };
 
+/* there is no need to handle dma timeout in loongson-2f base machines
*/
+#ifdef CONFIG_CPU_LOONGSON2E
 static struct irqaction dma_timeout_irqaction = {
 	.handler	= no_action,
 	.name		= "dma_timeout",
 };
+#endif
 
 void bonito_irq_init(void)
 {
@@ -66,5 +69,7 @@ void bonito_irq_init(void)
 		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
 	}
 
+#ifdef CONFIG_CPU_LOONGSON2E
 	setup_irq(LOONGSON_DMATIMEOUT_IRQ, &dma_timeout_irqaction);
+#endif
 }
diff --git a/arch/mips/loongson/common/cs5536_vsm.c
b/arch/mips/loongson/common/cs5536_vsm.c
new file mode 100644
index 0000000..727b871
--- /dev/null
+++ b/arch/mips/loongson/common/cs5536_vsm.c
@@ -0,0 +1,2321 @@
+/*
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author : jlliu, liujl@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published by
the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
+ * option) any later version.
+ *
+ * 	the Virtual Support Module(VSM) for virtulize the PCI configure  
+ * 	space. so user can access the PCI configure space directly as
+ *	a normal multi-function PCI device which following the PCI-2.2 spec.
+ */
+#include <linux/types.h>
+
+#include <cs5536/cs5536.h>
+#include <cs5536/cs5536_pci.h>
+#include <cs5536/pcireg.h>
+
+/* internal used functions */
+
+/*
+ * enable/disable the divil module bar space.
+ *
+ * For all the DIVIL module LBAR, you should control the DIVIL LBAR reg
+ * and the RCONFx(0~5) reg to use the modules.
+ */
+static void divil_lbar_enable_disable(int enable)
+{
+	u32 hi, lo;
+
+	/* 
+	 * The DIVIL IRQ is not used yet. and make the RCONF0 reserved.
+	 */
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), hi, lo);
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), hi, lo);
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), hi, lo);
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), hi, lo);
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), hi, lo);
+
+	/*
+	 * RCONF0 is reserved to the DIVIL IRQ mdoule
+	 */
+#if	0
+	_rdmsr(SB_MSR_REG(SB_R1), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R1), hi, lo);
+
+	_rdmsr(SB_MSR_REG(SB_R2), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R2), hi, lo);
+
+	_rdmsr(SB_MSR_REG(SB_R3), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R3), hi, lo);
+
+	_rdmsr(SB_MSR_REG(SB_R4), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R4), hi, lo);
+
+	_rdmsr(SB_MSR_REG(SB_R5), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R5), hi, lo);
+#endif
+	return;
+}
+
+#ifdef	TEST_CS5536_USE_FLASH
+/*
+ * enable or disable the region of flashs(NOR or NAND)
+ *
+ * the same as the DIVIL other modules above, two groups of regs should
be modified
+ * here to control the region. DIVIL flash LBAR and the RCONFx(6~9
reserved).
+ */
+static void flash_lbar_enable_disable(int enable)
+{
+	u32 hi, lo;
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
+	if (enable)
+		hi |= 0x01;
+	else
+		hi &= ~0x01;
+	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);
+
+	_rdmsr(SB_MSR_REG(SB_R6), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R6), hi, lo);
+
+	_rdmsr(SB_MSR_REG(SB_R7), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R7), hi, lo);
+
+	_rdmsr(SB_MSR_REG(SB_R8), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R8), hi, lo);
+
+	_rdmsr(SB_MSR_REG(SB_R9), &hi, &lo);
+	if (enable)
+		lo |= 0x01;
+	else
+		lo &= ~0x01;
+	_wrmsr(SB_MSR_REG(SB_R9), hi, lo);
+
+	return;
+}
+#endif
+
+/* cs5536 modules */
+
+/*
+ * isa_write : isa write transfering.
+ * WE assume that the ISA is not the BUS MASTER.!!!
+ */
+/* FAST BACK TO BACK '1' for BUS MASTER '0' for BUS SALVE */
+/* COMMAND :
+ * 	bit0 : IO SPACE ENABLE
+ *	bit1 : MEMORY SPACE ENABLE(ignore)
+ *	bit2 : BUS MASTER ENABLE(ignore)
+ *	bit3 : SPECIAL CYCLE(ignore)? default is ignored.
+ *	bit4 : MEMORY WRITE and INVALIDATE(ignore)
+ *	bit5 : VGA PALETTE(ignore)
+ *	bit6 : PARITY ERROR(ignore)? : default is ignored.
+ *	bit7 : WAIT CYCLE CONTROL(ignore)
+ *	bit8 : SYSTEM ERROR(ignore)
+ *	bit9 : FAST BACK TO BACK(ignore)
+ *	bit10-bit15 : RESERVED
+ * STATUS :
+ *	bit0-bit3 : RESERVED
+ *	bit4 : CAPABILITY LIST(ignore)
+ *	bit5 : 66MHZ CAPABLE
+ *	bit6 : RESERVED
+ *	bit7 : FAST BACK TO BACK(ignore)
+ *	bit8 : DATA PARITY ERROR DETECED(ignore)
+ *	bit9-bit10 : DEVSEL TIMING(ALL MEDIUM)
+ *	bit11: SIGNALED TARGET ABORT
+ *	bit12: RECEIVED TARGET ABORT
+ *	bit13: RECEIVED MASTER ABORT
+ *	bit14: SIGNALED SYSTEM ERROR
+ *	bit15: DETECTED PARITY ERROR
+ */
+static void pci_isa_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+	u32 temp;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_IO_ENABLE) {
+			divil_lbar_enable_disable(1);
+		} else {
+			divil_lbar_enable_disable(0);
+		}
+#if	0
+		/* PER response enable or disable. */
+		if (value & PCI_COMMAND_PARITY_ENABLE) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			lo |= SB_PARE_ERR_EN;
+			_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+		} else {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			lo &= ~SB_PARE_ERR_EN;
+			_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+		}
+#endif
+		/* status */
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		temp = lo & 0x0000ffff;
+		if ((value & PCI_STATUS_TARGET_TARGET_ABORT) &&
+		    (lo & SB_TAS_ERR_EN)) {
+			temp |= SB_TAS_ERR_FLAG;
+		}
+		if ((value & PCI_STATUS_MASTER_TARGET_ABORT) &&
+		    (lo & SB_TAR_ERR_EN)) {
+			temp |= SB_TAR_ERR_FLAG;
+		}
+		if ((value & PCI_STATUS_MASTER_ABORT)
+		    && (lo & SB_MAR_ERR_EN)) {
+			temp |= SB_MAR_ERR_FLAG;
+		}
+		if ((value & PCI_STATUS_PARITY_DETECT)
+		    && (lo & SB_PARE_ERR_EN)) {
+			temp |= SB_PARE_ERR_FLAG;
+		}
+		lo = temp;
+		_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+		break;
+	case PCI_BHLC_REG:
+		value &= 0x0000ff00;
+		_rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
+		hi &= 0xffffff00;
+		hi |= (value >> 8);
+		_wrmsr(SB_MSR_REG(SB_CTRL), hi, lo);
+		break;
+	case PCI_BAR0_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_SMB_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* SMB NATIVE IO space has 8bytes */
+			hi = 0x0000f001;
+			lo = value & 0x0000fff8;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), hi, lo);
+
+			/* RCONFx is 4bytes in units for IO space. */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_SMB_LENGTH - 4) << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R0), hi, lo);
+		}
+		break;
+	case PCI_BAR1_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_GPIO_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* GPIO NATIVE reg is 256bytes */
+			hi = 0x0000f001;
+			lo = value & 0x0000ff00;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), hi, lo);
+
+			/* RCONFx is 4bytes in units for IO space */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_GPIO_LENGTH - 4)
+			     << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R1), hi, lo);
+		}
+		break;
+	case PCI_BAR2_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_MFGPT_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* MFGPT NATIVE reg is 64bytes */
+			hi = 0x0000f001;
+			lo = value & 0x0000ffc0;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), hi, lo);
+
+			/* RCONFx is 4bytes in units for IO space */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_MFGPT_LENGTH - 4)
+			     << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R2), hi, lo);
+		}
+		break;
+	case PCI_BAR3_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_IRQ_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* IRQ NATIVE reg is 32bytes */
+			hi = 0x0000f001;
+			lo = value & 0x0000ffc0;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_IRQ), hi, lo);
+
+			/* RCONFx is 4bytes in units for IO space */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_IRQ_LENGTH - 4) << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R3), hi, lo);
+		}
+		break;
+	case PCI_BAR4_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_PMS_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* PMS NATIVE reg is 128bytes */
+			hi = 0x0000f001;
+			lo = value & 0x0000ff80;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), hi, lo);
+
+			/* RCONFx is 4bytes in units for IO space. */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_PMS_LENGTH - 4) << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R4), hi, lo);
+		}
+		break;
+	case PCI_BAR5_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_ACPI_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* ACPI NATIVE reg is 32bytes */
+			hi = 0x0000f001;
+			lo = value & 0x0000ffe0;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), hi, lo);
+
+			/* RCONFx is 4bytes in units for IO space. */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_ACPI_LENGTH - 4)
+			     << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R5), hi, lo);
+		}
+		break;
+	case PCI_UART1_INT_REG:
+		if (value) {
+			/* enable uart1 interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
+			lo &= ~(0xf << 24);
+			lo |= (CS5536_UART1_INTR << 24);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
+		} else {
+			/* disable uart1 interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
+			lo &= ~(0xf << 24);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
+		}
+		break;
+	case PCI_UART2_INT_REG:
+		if (value) {
+			/* enable uart2 interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
+			lo &= ~(0xf << 28);
+			lo |= (CS5536_UART2_INTR << 28);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
+		} else {
+			/* disable uart2 interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
+			lo &= ~(0xf << 28);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
+		}
+		break;
+	case PCI_ISA_FIXUP_REG:
+		if (value) {
+			/* enable the TARGET ABORT/MASTER ABORT etc. */
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			lo |= 0x00000063;
+			_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+		}
+
+	default:
+		/* ALL OTHER PCI CONFIG SPACE HEADER IS NOT IMPLEMENTED. */
+		break;
+	}
+
+	return;
+}
+
+/*
+ * isa_read : isa read transfering.
+ * we assume that the ISA is not the BUS MASTER. 
+ */
+
+ /* COMMAND :
+  *     bit0 : IO SPACE ENABLE
+  *     bit1 : MEMORY SPACE ENABLE(ignore)
+  *     bit2 : BUS MASTER ENABLE(ignore)
+  *     bit3 : SPECIAL CYCLE(ignore)? default is ignored.
+  *     bit4 : MEMORY WRITE and INVALIDATE(ignore)
+  *     bit5 : VGA PALETTE(ignore)
+  *     bit6 : PARITY ERROR(ignore)? : default is ignored.
+  *     bit7 : WAIT CYCLE CONTROL(ignore)
+  *     bit8 : SYSTEM ERROR(ignore)
+  *     bit9 : FAST BACK TO BACK(ignore)
+  *     bit10-bit15 : RESERVED
+  * STATUS :
+  *     bit0-bit3 : RESERVED
+  *     bit4 : CAPABILITY LIST(ignore)
+  *     bit5 : 66MHZ CAPABLE
+  *     bit6 : RESERVED
+  *     bit7 : FAST BACK TO BACK(ignore)
+  *     bit8 : DATA PARITY ERROR DETECED(ignore)?
+  *     bit9-bit10 : DEVSEL TIMING(ALL MEDIUM)
+  *     bit11: SIGNALED TARGET ABORT
+  *     bit12: RECEIVED TARGET ABORT
+  *     bit13: RECEIVED MASTER ABORT
+  *     bit14: SIGNALED SYSTEM ERROR
+  *     bit15: DETECTED PARITY ERROR(?)
+  */
+
+static u32 pci_isa_read_reg(int reg)
+{
+	u32 conf_data;
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_ISA_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+		conf_data = 0;
+		/* command */
+		/* we just check the first LBAR for the IO enable bit, */
+		/* maybe we should changed later. */
+		_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
+		if (hi & 0x01) {
+			conf_data |= PCI_COMMAND_IO_ENABLE;
+		}
+		/* conf_data |= PCI_COMMAND_IO_ENABLE | PCI_COMMAND_MEM_ENABLE |
PCI_COMMAND_MASTER_ENABLE; */
+#if	0
+		conf_data |= PCI_COMMAND_SPECIAL_ENABLE;
+#endif
+#if	0
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_EN) {
+			conf_data |= PCI_COMMAND_PARITY_ENABLE;
+		} else {
+			conf_data &= ~PCI_COMMAND_PARITY_ENABLE;
+		}
+#endif
+		/* status */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+#if	1
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+#endif
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_TAS_ERR_FLAG)
+			conf_data |= PCI_STATUS_TARGET_TARGET_ABORT;
+		if (lo & SB_TAR_ERR_FLAG)
+			conf_data |= PCI_STATUS_MASTER_TARGET_ABORT;
+		if (lo & SB_MAR_ERR_FLAG)
+			conf_data |= PCI_STATUS_MASTER_ABORT;
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_DETECT;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_CHIP_REV_ID), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_ISA_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		_rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
+		hi &= 0x000000f8;
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_BRIDGE_HEADER_TYPE << 16)
+		    | (hi << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+		/*
+		 * we only use the LBAR of DIVIL, no RCONF used. 
+		 * all of them are IO space.
+		 */
+	case PCI_BAR0_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_SMB_FLAG) {
+			conf_data = CS5536_SMB_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_SMB_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
+			conf_data = lo & 0x0000fff8;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_BAR1_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_GPIO_FLAG) {
+			conf_data = CS5536_GPIO_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_GPIO_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+			conf_data = lo & 0x0000ff00;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_BAR2_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_MFGPT_FLAG) {
+			conf_data = CS5536_MFGPT_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_MFGPT_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &hi, &lo);
+			conf_data = lo & 0x0000ffc0;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+#if	1
+	case PCI_BAR3_REG:
+		conf_data = 0;
+		break;
+#else
+	case PCI_BAR3_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_IRQ_FLAG) {
+			conf_data = CS5536_IRQ_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_IRQ_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_IRQ), &hi, &lo);
+			conf_data = lo & 0x0000ffc0;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+#endif
+	case PCI_BAR4_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_PMS_FLAG) {
+			conf_data = CS5536_PMS_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_PMS_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), &hi, &lo);
+			conf_data = lo & 0x0000ff80;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_BAR5_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_ACPI_FLAG) {
+			conf_data = CS5536_ACPI_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_ACPI_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), &hi, &lo);
+			conf_data = lo & 0x0000ffe0;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_ISA_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
+								(0x00 << 8) | 0x00;
+		break;
+	default:
+		conf_data = 0;
+		break;
+	}
+
+	return conf_data;
+}
+
+#ifdef	TEST_CS5536_USE_FLASH
+
+#ifndef	TEST_CS5536_USE_NOR_FLASH	/* for nand flash */
+static void pci_flash_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_MEM_ENABLE) {
+			flash_lbar_enable_disable(1);
+		} else {
+			flash_lbar_enable_disable(0);
+		}
+		/* status */
+		if (value & PCI_STATUS_PARITY_ERROR) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			if (lo & SB_PARE_ERR_FLAG) {
+				lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+			}
+		}
+		break;
+	case PCI_BAR0_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			/* make the flag for reading the bar length. */
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_FLSH0_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if ((value & 0x01) == 0x00) {
+			/* mem space nand flash native reg base addr */
+			hi = 0xfffff007;
+			lo = value & 0xfffff000;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);
+
+			/* RCONFx is 4KB in units for mem space. */
+			hi = ((value & 0xfffff000) << 12) |
+			    ((CS5536_FLSH0_LENGTH & 0xfffff000) -
+			     (1 << 12)) | 0x00;
+			lo = ((value & 0xfffff000) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R6), hi, lo);
+		}
+		break;
+	case PCI_BAR1_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_FLSH1_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if ((value & 0x01) == 0x00) {
+			/* mem space nand flash native reg base addr */
+			hi = 0xfffff007;
+			lo = value & 0xfffff000;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);
+
+			/* RCONFx is 4KB in units for mem space. */
+			hi = ((value & 0xfffff000) << 12) |
+			    ((CS5536_FLSH1_LENGTH & 0xfffff000) -
+			     (1 << 12)) | 0x00;
+			lo = ((value & 0xfffff000) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R7), hi, lo);
+		}
+		break;
+	case PCI_BAR2_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_FLSH2_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if ((value & 0x01) == 0x00) {
+			/* mem space nand flash native reg base addr */
+			hi = 0xfffff007;
+			lo = value & 0xfffff000;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);
+
+			/* RCONFx is 4KB in units for mem space. */
+			hi = ((value & 0xfffff000) << 12) |
+			    ((CS5536_FLSH2_LENGTH & 0xfffff000) -
+			     (1 << 12)) | 0x00;
+			lo = ((value & 0xfffff000) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R8), hi, lo);
+		}
+		break;
+	case PCI_BAR3_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_FLSH3_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if ((value & 0x01) == 0x00) {
+			/* mem space nand flash native reg base addr */
+			hi = 0xfffff007;
+			lo = value & 0xfffff000;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);
+
+			/* RCONFx is 4KB in units for mem space. */
+			hi = ((value & 0xfffff000) << 12) |
+			    ((CS5536_FLSH3_LENGTH & 0xfffff000) -
+			     (1 << 12)) | 0x00;
+			lo = ((value & 0xfffff000) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R9), hi, lo);
+		}
+		break;
+	case PCI_FLASH_INT_REG:
+		if (value) {
+			/* enable all the flash interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+			lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
+			lo |= (CS5536_FLASH_INTR << PIC_YSEL_LOW_FLASH_SHIFT);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+		} else {
+			/* disable all the flash interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+			lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+		}
+		break;
+	case PCI_NAND_FLASH_TDATA_REG:
+		hi = 0;
+		lo = value;
+		_wrmsr(DIVIL_MSR_REG(NANDF_DATA), hi, lo);
+		break;
+	case PCI_NAND_FLASH_TCTRL_REG:
+		hi = 0;
+		lo = value & 0x00000fff;
+		_wrmsr(DIVIL_MSR_REG(NANDF_CTRL), hi, lo);
+		break;
+	case PCI_NAND_FLASH_RSVD_REG:
+		hi = 0;
+		lo = value;
+		_wrmsr(DIVIL_MSR_REG(NANDF_RSVD), hi, lo);
+		break;
+	case PCI_FLASH_SELECT_REG:
+		if (value == CS5536_IDE_FLASH_SIGNATURE) {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
+			lo &= ~0x01;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return;
+}
+
+static u32 pci_flash_read_reg(int reg)
+{
+	u32 conf_data;
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_FLASH_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+		conf_data = 0;
+		/* command */
+		/* we just read one lbar for returning. */
+		_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+		if (hi & 0x01)
+			conf_data |= PCI_COMMAND_MEM_ENABLE;
+		/* STATUS */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_ERROR;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(DIVIL_MSR_REG(DIVIL_CAP), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_FLASH_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16)
+		    | (PCI_NORMAL_LATENCY_TIMER << 8) |
+		    PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+	case PCI_BAR0_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_FLSH0_FLAG) {
+			conf_data = CS5536_FLSH0_RANGE | PCI_MAPREG_TYPE_MEM;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_FLSH0_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+			conf_data = lo;
+			conf_data &= ~0x0f;
+		}
+		break;
+	case PCI_BAR1_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_FLSH1_FLAG) {
+			conf_data = CS5536_FLSH1_RANGE | PCI_MAPREG_TYPE_MEM;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_FLSH1_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
+			conf_data = lo;
+			conf_data &= ~0x0f;
+		}
+		break;
+	case PCI_BAR2_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_FLSH2_FLAG) {
+			conf_data = CS5536_FLSH2_RANGE | PCI_MAPREG_TYPE_MEM;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_FLSH2_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
+			conf_data = lo;
+			conf_data &= ~0x0f;
+		}
+		break;
+	case PCI_BAR3_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_FLSH3_FLAG) {
+			conf_data = CS5536_FLSH3_RANGE | PCI_MAPREG_TYPE_MEM;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_FLSH3_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
+			conf_data = lo;
+			conf_data &= ~0x0f;
+		}
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_FLASH_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
+		break;
+	case PCI_NAND_FLASH_TDATA_REG:
+		_rdmsr(DIVIL_MSR_REG(NANDF_DATA), &hi, &lo);
+		conf_data = lo;
+		break;
+	case PCI_NAND_FLASH_TCTRL_REG:
+		_rdmsr(DIVIL_MSR_REG(NANDF_CTRL), &hi, &lo);
+		conf_data = lo & 0x00000fff;
+		break;
+	case PCI_NAND_FLASH_RSVD_REG:
+		_rdmsr(DIVIL_MSR_REG(NANDF_RSVD), &hi, &lo);
+		conf_data = lo;
+		break;
+	case PCI_FLASH_SELECT_REG:
+		_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
+		conf_data = lo & 0x01;
+		break;
+
+	}
+	return 0;
+}
+
+#else				/* nor flash */
+
+static void pci_flash_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_IO_ENABLE) {
+			flash_lbar_enable_disable(1);
+		} else {
+			flash_lbar_enable_disable(0);
+		}
+		/* status */
+		if (value & PCI_STATUS_PARITY_ERROR) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			if (lo & SB_PARE_ERR_FLAG) {
+				lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+			}
+		}
+		break;
+	case PCI_BAR0_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_FLSH0_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* IO space of 16bytes nor flash */
+			hi = 0x0000fff1;
+			lo = value & 0x0000fff0;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);
+
+			/* RCONFx used for 16bytes reserved. */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_FLSH0_LENGTH - 4)
+			     << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R6), hi, lo);
+		}
+		break;
+	case PCI_BAR1_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_FLSH1_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* IO space of 16bytes nor flash */
+			hi = 0x0000fff1;
+			lo = value & 0x0000fff0;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);
+
+			/* RCONFx used for 16bytes reserved. */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_FLSH1_LENGTH - 4)
+			     << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R7), hi, lo);
+		}
+		break;
+	case PCI_BAR2_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_FLSH2_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			hi = 0x0000fff1;
+			lo = value & 0x0000fff0;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);
+
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_FLSH2_LENGTH - 4)
+			     << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R8), hi, lo);
+		}
+		break;
+	case PCI_BAR3_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_FLSH3_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			/* 16bytes for nor flash */
+			hi = 0x0000fff1;
+			lo = value & 0x0000fff0;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);
+
+			/* 16bytes of IO space of RCONFx region. */
+			hi = ((value & 0x000ffffc) << 12) |
+			    ((CS5536_FLSH3_LENGTH - 4)
+			     << 12) | 0x01;
+			lo = ((value & 0x000ffffc) << 12) | 0x01;
+			_wrmsr(SB_MSR_REG(SB_R9), hi, lo);
+		}
+		break;
+
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
+		break;
+	case PCI_FLASH_INT_REG:
+		if (value) {
+			/* enable all the flash interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+			lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
+			lo |= (CS5536_FLASH_INTR << PIC_YSEL_LOW_FLASH_SHIFT);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+		} else {
+			/* disable all the flash interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+			lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+		}
+		break;
+	case PCI_NOR_FLASH_CTRL_REG:
+		hi = 0;
+		lo = value & 0x000000ff;
+		_wrmsr(DIVIL_MSR_REG(NORF_CTRL), hi, lo);
+		break;
+	case PCI_NOR_FLASH_T01_REG:
+		hi = 0;
+		lo = value;
+		_wrmsr(DIVIL_MSR_REG(NORF_T01), hi, lo);
+		break;
+	case PCI_NOR_FLASH_T23_REG:
+		hi = 0;
+		lo = value;
+		_wrmsr(DIVIL_MSR_REG(NORF_T23), hi, lo);
+		break;
+	case PCI_FLASH_SELECT_REG:
+		if (value == CS5536_IDE_FLASH_SIGNATURE) {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
+			lo &= ~0x01;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return;
+}
+
+static u32 pci_flash_read_reg(int reg)
+{
+	u32 conf_data;
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_FLASH_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+		conf_data = 0;
+		/* command */
+		/* we just check one flash bar for returning. */
+		_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+		if (hi & 0x01)
+			conf_data |= PCI_COMMAND_IO_ENABLE;
+		/* STATUS */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_ERROR;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(DIVIL_MSR_REG(DIVIL_CAP), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_FLASH_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16)
+		    | (PCI_NORMAL_LATENCY_TIMER << 8) |
+		    PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+	case PCI_BAR0_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_FLSH0_FLAG) {
+			conf_data = CS5536_FLSH0_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_FLSH0_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+			conf_data = lo & 0x0000ffff;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_BAR1_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_FLSH1_FLAG) {
+			conf_data = CS5536_FLSH1_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_FLSH1_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
+			conf_data = lo & 0x0000ffff;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_BAR2_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_FLSH2_FLAG) {
+			conf_data = CS5536_FLSH2_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_FLSH2_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
+			conf_data = lo & 0x0000ffff;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_BAR3_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_FLSH3_FLAG) {
+			conf_data = CS5536_FLSH3_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_FLSH3_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
+			conf_data = lo & 0x0000ffff;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_FLASH_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
+		break;
+	case PCI_NOR_FLASH_CTRL_REG:
+		_rdmsr(DIVIL_MSR_REG(NORF_CTRL), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		break;
+	case PCI_NOR_FLASH_T01_REG:
+		_rdmsr(DIVIL_MSR_REG(NORF_T01), &hi, &lo);
+		conf_data = lo;
+		break;
+	case PCI_NOR_FLASH_T23_REG:
+		_rdmsr(DIVIL_MSR_REG(NORF_T23), &hi, &lo);
+		conf_data = lo;
+		break;
+	default:
+		conf_data = 0;
+		break;
+	}
+	return conf_data;
+}
+#endif				/* TEST_CS5536_USE_NOR_FLASH */
+
+#else				/* TEST_CS5536_USE_FLASH */
+
+static void pci_flash_write_reg(int reg, u32 value)
+{
+	return;
+}
+
+static u32 pci_flash_read_reg(int reg)
+{
+	return 0xffffffff;
+}
+
+#endif				/* TEST_CS5536_USE_FLASH */
+
+/*
+ * ide_write : ide write transfering
+ */
+static void pci_ide_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_MASTER_ENABLE) {
+			_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+			lo |= (0x03 << 4);
+			_wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);
+		} else {
+			_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+			lo &= ~(0x03 << 4);
+			_wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);
+		}
+		/* status */
+		if (value & PCI_STATUS_PARITY_ERROR) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			if (lo & SB_PARE_ERR_FLAG) {
+				lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+			}
+		}
+		break;
+	case PCI_BHLC_REG:
+		value &= 0x0000ff00;
+		_rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
+		hi &= 0xffffff00;
+		hi |= (value >> 8);
+		_wrmsr(SB_MSR_REG(SB_CTRL), hi, lo);
+		break;
+	case PCI_BAR4_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_IDE_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			hi = 0x00000000;
+			/* lo = ((value & 0x0fffffff) << 4) | 0x001; */
+			lo = (value & 0xfffffff0) | 0x1;
+			_wrmsr(IDE_MSR_REG(IDE_IO_BAR), hi, lo);
+
+			value &= 0xfffffffc;
+			hi = 0x60000000 | ((value & 0x000ff000) >> 12);
+			lo = 0x000ffff0 | ((value & 0x00000fff) << 20);
+			_wrmsr(GLIU_MSR_REG(GLIU_IOD_BM2), hi, lo);
+		}
+		break;
+	case PCI_IDE_CFG_REG:
+		if (value == CS5536_IDE_FLASH_SIGNATURE) {
+			_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
+			lo |= 0x01;
+			_wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
+		} else {
+			hi = 0;
+			lo = value;
+			_wrmsr(IDE_MSR_REG(IDE_CFG), hi, lo);
+		}
+		break;
+	case PCI_IDE_DTC_REG:
+		hi = 0;
+		lo = value;
+		_wrmsr(IDE_MSR_REG(IDE_DTC), hi, lo);
+		break;
+	case PCI_IDE_CAST_REG:
+		hi = 0;
+		lo = value;
+		_wrmsr(IDE_MSR_REG(IDE_CAST), hi, lo);
+		break;
+	case PCI_IDE_ETC_REG:
+		hi = 0;
+		lo = value;
+		_wrmsr(IDE_MSR_REG(IDE_ETC), hi, lo);
+		break;
+	case PCI_IDE_PM_REG:
+		hi = 0;
+		lo = value;
+		_wrmsr(IDE_MSR_REG(IDE_INTERNAL_PM), hi, lo);
+		break;
+	default:
+		break;
+	}
+
+	return;
+}
+
+/*
+ * ide_read : ide read tranfering.
+ */
+static u32 pci_ide_read_reg(int reg)
+{
+	u32 conf_data;
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_IDE_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+		conf_data = 0;
+		/* command */
+		_rdmsr(IDE_MSR_REG(IDE_IO_BAR), &hi, &lo);
+		if (lo & 0xfffffff0)
+			conf_data |= PCI_COMMAND_IO_ENABLE;
+		_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+		if ((lo & 0x30) == 0x30)
+			conf_data |= PCI_COMMAND_MASTER_ENABLE;
+		/* conf_data |= PCI_COMMAND_BACKTOBACK_ENABLE??? HOW TO GET.. */
+		/* STATUS */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_ERROR;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(IDE_MSR_REG(IDE_CAP), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_IDE_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		_rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
+		hi &= 0x000000f8;
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16)
+		    | (hi << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+	case PCI_BAR0_REG:
+		conf_data = 0x00000000;
+		break;
+	case PCI_BAR1_REG:
+		conf_data = 0x00000000;
+		break;
+	case PCI_BAR2_REG:
+		conf_data = 0x00000000;
+		break;
+	case PCI_BAR3_REG:
+		conf_data = 0x00000000;
+		break;
+	case PCI_BAR4_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_IDE_FLAG) {
+			conf_data = CS5536_IDE_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_IDE_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(IDE_MSR_REG(IDE_IO_BAR), &hi, &lo);
+			/* conf_data = lo >> 4; */
+			conf_data = lo & 0xfffffff0;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_BAR5_REG:
+		conf_data = 0x00000000;
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_IDE_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_IDE_INTR);
+		break;
+	case PCI_IDE_CFG_REG:
+		_rdmsr(IDE_MSR_REG(IDE_CFG), &hi, &lo);
+		conf_data = lo;
+		break;
+	case PCI_IDE_DTC_REG:
+		_rdmsr(IDE_MSR_REG(IDE_DTC), &hi, &lo);
+		conf_data = lo;
+		break;
+	case PCI_IDE_CAST_REG:
+		_rdmsr(IDE_MSR_REG(IDE_CAST), &hi, &lo);
+		conf_data = lo;
+		break;
+	case PCI_IDE_ETC_REG:
+		_rdmsr(IDE_MSR_REG(IDE_ETC), &hi, &lo);
+		conf_data = lo;
+	case PCI_IDE_PM_REG:
+		_rdmsr(IDE_MSR_REG(IDE_INTERNAL_PM), &hi, &lo);
+		conf_data = lo;
+		break;
+
+	default:
+		conf_data = 0;
+		break;
+	}
+
+	return conf_data;
+}
+
+static void pci_acc_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_MASTER_ENABLE) {
+			_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+			lo |= (0x03 << 8);
+			_wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);
+		} else {
+			_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+			lo &= ~(0x03 << 8);
+			_wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);
+		}
+		/* status */
+		if (value & PCI_STATUS_PARITY_ERROR) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			if (lo & SB_PARE_ERR_FLAG) {
+				lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+			}
+		}
+		break;
+	case PCI_BAR0_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_ACC_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if (value & 0x01) {
+			value &= 0xfffffffc;
+			hi = 0xA0000000 | ((value & 0x000ff000) >> 12);
+			lo = 0x000fff80 | ((value & 0x00000fff) << 20);
+			_wrmsr(GLIU_MSR_REG(GLIU_IOD_BM1), hi, lo);
+		}
+		break;
+	case PCI_ACC_INT_REG:
+		if (value) {
+			/* enable all the acc interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+			lo &= ~(0xf << PIC_YSEL_LOW_ACC_SHIFT);
+			lo |= (CS5536_ACC_INTR << PIC_YSEL_LOW_ACC_SHIFT);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+		} else {
+			/* disable all the usb interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+			lo &= ~(0xf << PIC_YSEL_LOW_ACC_SHIFT);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return;
+}
+
+static u32 pci_acc_read_reg(int reg)
+{
+	u32 hi, lo;
+	u32 conf_data;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_ACC_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+
+		conf_data = 0;
+		/* command */
+		_rdmsr(GLIU_MSR_REG(GLIU_IOD_BM1), &hi, &lo);
+		if (((lo & 0xfff00000) || (hi & 0x000000ff))
+		    && ((hi & 0xf0000000) == 0xa0000000))
+			conf_data |= PCI_COMMAND_IO_ENABLE;
+		_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+		if ((lo & 0x300) == 0x300)
+			conf_data |= PCI_COMMAND_MASTER_ENABLE;
+		/* conf_data |= PCI_COMMAND_BACKTOBACK_ENABLE??? HOW TO GET.. */
+		/* STATUS */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_ERROR;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(ACC_MSR_REG(ACC_CAP), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_ACC_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16)
+		    | (PCI_NORMAL_LATENCY_TIMER << 8) |
+		    PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+	case PCI_BAR0_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_ACC_FLAG) {
+			conf_data = CS5536_ACC_RANGE | PCI_MAPREG_TYPE_IO;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_ACC_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(GLIU_MSR_REG(GLIU_IOD_BM1), &hi, &lo);
+			conf_data = (hi & 0x000000ff) << 12;
+			conf_data |= (lo & 0xfff00000) >> 20;
+			conf_data |= 0x01;
+			conf_data &= ~0x02;
+		}
+		break;
+	case PCI_BAR1_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR2_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR3_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR4_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR5_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_ACC_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_USB_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_ACC_INTR);
+		break;
+	default:
+		conf_data = 0;
+		break;
+	}
+
+	return conf_data;
+}
+
+/*
+ * ohci_write : ohci write tranfering.
+ */
+static void pci_ohci_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_MASTER_ENABLE) {
+			_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+			hi |= (1 << 2);
+			_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+			hi &= ~(1 << 2);
+			_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+		}
+		if (value & PCI_COMMAND_MEM_ENABLE) {
+			_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+			hi |= (1 << 1);
+			_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+			hi &= ~(1 << 1);
+			_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+		}
+		/* status */
+		if (value & PCI_STATUS_PARITY_ERROR) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			if (lo & SB_PARE_ERR_FLAG) {
+				lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+			}
+		}
+		break;
+	case PCI_BAR0_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_OHCI_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if ((value & 0x01) == 0x00) {
+			_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+			/* lo = (value & 0xffffff00) << 8; */
+			lo = value;
+			_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+
+			value &= 0xfffffff0;
+			hi = 0x40000000 | ((value & 0xff000000) >> 24);
+			lo = 0x000fffff | ((value & 0x00fff000) << 8);
+			_wrmsr(GLIU_MSR_REG(GLIU_P2D_BM3), hi, lo);
+		}
+		break;
+	case PCI_INTERRUPT_REG:
+		value &= 0x000000ff;
+		break;
+	case PCI_OHCI_PM_REG:
+		break;
+	case PCI_OHCI_INT_REG:
+		if (value) {
+			/* enable all the usb interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+			lo &= ~(0xf << 8);
+			lo |= (CS5536_USB_INTR << 8);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+		} else {
+			/* disable all the usb interrupt in PIC */
+			_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+			lo &= ~(0xf << 8);
+			_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return;
+}
+
+/*
+ * ohci_read : ohci read transfering.
+ */
+static u32 pci_ohci_read_reg(int reg)
+{
+	u32 conf_data;
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_OHCI_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+		conf_data = 0;
+		/* command */
+		_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+		if (hi & 0x04)
+			conf_data |= PCI_COMMAND_MASTER_ENABLE;
+		if (hi & 0x02)
+			conf_data |= PCI_COMMAND_MEM_ENABLE;
+		/* status */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_ERROR;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_OHCI_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16)
+		    | (0x00 << 8)
+		    | PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+	case PCI_BAR0_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_OHCI_FLAG) {
+			conf_data = CS5536_OHCI_RANGE | PCI_MAPREG_TYPE_MEM;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_OHCI_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+			/* conf_data = lo >> 8; */
+			conf_data = lo & 0xffffff00;
+			conf_data &= ~0x0000000f;	/* 32bit mem */
+		}
+		break;
+	case PCI_BAR1_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR2_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR3_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR4_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR5_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_OHCI_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_USB_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
+		break;
+	case PCI_OHCI_PM_REG:
+		conf_data = 0;
+		break;
+	case PCI_OHCI_INT_REG:
+		_rdmsr(DIVIL_MSR_REG(0x20), &hi, &lo);
+		if ((lo & 0x00000f00) == 11)
+			conf_data = 1;
+		else
+			conf_data = 0;
+		break;
+	default:
+		conf_data = 0;
+		break;
+	}
+
+	return conf_data;
+}
+
+#ifdef	TEST_CS5536_USE_EHCI
+static void pci_ehci_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_MASTER_ENABLE) {
+			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+			hi |= (1 << 2);
+			_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+			hi &= ~(1 << 2);
+			_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+		}
+		if (value & PCI_COMMAND_MEM_ENABLE) {
+			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+			hi |= (1 << 1);
+			_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+			hi &= ~(1 << 1);
+			_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+		}
+		/* status */
+		if (value & PCI_STATUS_PARITY_ERROR) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			if (lo & SB_PARE_ERR_FLAG) {
+				lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+			}
+		}
+		break;
+	case PCI_BAR0_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_EHCI_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if ((value & 0x01) == 0x00) {
+			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+			lo = value;
+			_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+
+			value &= 0xfffffff0;
+			hi = 0x40000000 | ((value & 0xff000000) >> 24);
+			lo = 0x000fffff | ((value & 0x00fff000) << 8);
+			_wrmsr(GLIU_MSR_REG(GLIU_P2D_BM4), hi, lo);
+		}
+		break;
+	case PCI_EHCI_LEGSMIEN_REG:
+		_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+		hi &= 0x003f0000;
+		hi |= (value & 0x3f) << 16;
+		_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+		break;
+	case PCI_EHCI_FLADJ_REG:
+		_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+		hi &= ~0x00003f00;
+		hi |= value & 0x00003f00;
+		_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+		break;
+	default:
+		break;
+	}
+
+	return;
+}
+
+static u32 pci_ehci_read_reg(int reg)
+{
+	u32 conf_data;
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_EHCI_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+		conf_data = 0;
+		/* command */
+		_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+		if (hi & 0x04)
+			conf_data |= PCI_COMMAND_MASTER_ENABLE;
+		if (hi & 0x02)
+			conf_data |= PCI_COMMAND_MEM_ENABLE;
+		/* status */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_ERROR;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_EHCI_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16)
+		    | (PCI_NORMAL_LATENCY_TIMER << 8) |
+		    PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+	case PCI_BAR0_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_EHCI_FLAG) {
+			conf_data = CS5536_EHCI_RANGE | PCI_MAPREG_TYPE_MEM;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_EHCI_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+			conf_data = lo & 0xfffff000;
+		}
+		break;
+	case PCI_BAR1_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR2_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR3_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR4_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR5_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_EHCI_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_USB_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
+		break;
+	case PCI_EHCI_LEGSMIEN_REG:
+		_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+		conf_data = (hi & 0x003f0000) >> 16;
+		break;
+	case PCI_EHCI_LEGSMISTS_REG:
+		_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+		conf_data = (hi & 0x3f000000) >> 24;
+		break;
+	case PCI_EHCI_FLADJ_REG:
+		_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+		conf_data = hi & 0x00003f00;
+		break;
+	default:
+		conf_data = 0;
+		break;
+	}
+
+	return conf_data;
+}
+#else
+static void pci_ehci_write_reg(int reg, u32 value)
+{
+	return;
+}
+
+static u32 pci_ehci_read_reg(int reg)
+{
+	return 0xffffffff;
+}
+
+#endif
+
+#ifdef	TEST_CS5536_USE_UDC
+static void pci_udc_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_MASTER_ENABLE) {
+			_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+			hi |= (1 << 2);
+			_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+			hi &= ~(1 << 2);
+			_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+		}
+		if (value & PCI_COMMAND_MEM_ENABLE) {
+			_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+			hi |= (1 << 1);
+			_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+			hi &= ~(1 << 1);
+			_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+		}
+		/* status */
+		if (value & PCI_STATUS_PARITY_ERROR) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			if (lo & SB_PARE_ERR_FLAG) {
+				lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+			}
+		}
+		break;
+	case PCI_BAR0_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_UDC_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if ((value & 0x01) == 0x00) {
+			_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+			lo = value;
+			_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+
+			value &= 0xfffffff0;
+			hi = 0x40000000 | ((value & 0xff000000) >> 24);
+			lo = 0x000fffff | ((value & 0x00fff000) << 8);
+			_wrmsr(GLIU_MSR_REG(GLIU_P2D_BM0), hi, lo);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return;
+}
+
+static u32 pci_udc_read_reg(int reg)
+{
+	u32 conf_data;
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_UDC_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+		conf_data = 0;
+		/* command */
+		_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+		if (hi & 0x04)
+			conf_data |= PCI_COMMAND_MASTER_ENABLE;
+		if (hi & 0x02)
+			conf_data |= PCI_COMMAND_MEM_ENABLE;
+		/* status */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_ERROR;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_UDC_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16)
+		    | (0x00 << 8)
+		    | PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+	case PCI_BAR0_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_UDC_FLAG) {
+			conf_data = CS5536_UDC_RANGE | PCI_MAPREG_TYPE_MEM;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_UDC_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+			conf_data = lo & 0xfffff000;
+			conf_data &= ~0x0000000f;	/* 32bit mem */
+		}
+		break;
+	case PCI_BAR1_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR2_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR3_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR4_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR5_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_UDC_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_USB_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
+		break;
+	default:
+		conf_data = 0;
+		break;
+	}
+
+	return conf_data;
+}
+
+#else				/* TEST_CS5536_USE_UDC */
+
+static void pci_udc_write_reg(int reg, u32 value)
+{
+	return;
+}
+
+static u32 pci_udc_read_reg(int reg)
+{
+	return 0xffffffff;
+}
+
+#endif				/* TEST_CS5536_USE_UDC */
+
+#ifdef	TEST_CS5536_USE_OTG
+static void pci_otg_write_reg(int reg, u32 value)
+{
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_COMMAND_STATUS_REG:
+		/* command */
+		if (value & PCI_COMMAND_MEM_ENABLE) {
+			_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+			hi |= (1 << 1);
+			_wrmsr(USB_MSR_REG(USB_OTG), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+			hi &= ~(1 << 1);
+			_wrmsr(USB_MSR_REG(USB_OTG), hi, lo);
+		}
+		/* status */
+		if (value & PCI_STATUS_PARITY_ERROR) {
+			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+			if (lo & SB_PARE_ERR_FLAG) {
+				lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+			}
+		}
+		break;
+	case PCI_BAR0_REG:
+		if (value == PCI_BAR_RANGE_MASK) {
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo |= SOFT_BAR_OTG_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else if ((value & 0x01) == 0x00) {
+			_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+			lo = value & 0xffffff00;
+			_wrmsr(USB_MSR_REG(USB_OTG), hi, lo);
+
+			value &= 0xfffffff0;
+			hi = 0x40000000 | ((value & 0xff000000) >> 24);
+			lo = 0x000fffff | ((value & 0x00fff000) << 8);
+			_wrmsr(GLIU_MSR_REG(GLIU_P2D_BM1), hi, lo);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return;
+}
+
+static u32 pci_otg_read_reg(int reg)
+{
+	u32 conf_data;
+	u32 hi, lo;
+
+	switch (reg) {
+	case PCI_ID_REG:
+		conf_data = (CS5536_OTG_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+		break;
+	case PCI_COMMAND_STATUS_REG:
+		conf_data = 0;
+		/* command */
+		_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+		if (hi & 0x02)
+			conf_data |= PCI_COMMAND_MEM_ENABLE;
+		/* status */
+		conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+		conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+		_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+		if (lo & SB_PARE_ERR_FLAG)
+			conf_data |= PCI_STATUS_PARITY_ERROR;
+		conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+		break;
+	case PCI_CLASS_REG:
+		_rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
+		conf_data = lo & 0x000000ff;
+		conf_data |= (CS5536_OTG_CLASS_CODE << 8);
+		break;
+	case PCI_BHLC_REG:
+		conf_data =
+		    (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16)
+		    | (0x00 << 8)
+		    | PCI_NORMAL_CACHE_LINE_SIZE;
+		break;
+	case PCI_BAR0_REG:
+		_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+		if (lo & SOFT_BAR_OTG_FLAG) {
+			conf_data = CS5536_OTG_RANGE | PCI_MAPREG_TYPE_MEM;
+			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+			lo &= ~SOFT_BAR_OTG_FLAG;
+			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+		} else {
+			_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+			conf_data = lo & 0xffffff00;
+			conf_data &= ~0x0000000f;
+		}
+		break;
+	case PCI_BAR1_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR2_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR3_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR4_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_BAR5_REG:
+		conf_data = 0x000000;
+		break;
+	case PCI_CARDBUS_CIS_REG:
+		conf_data = PCI_CARDBUS_CIS_POINTER;
+		break;
+	case PCI_SUBSYS_ID_REG:
+		conf_data = (CS5536_OTG_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+		break;
+	case PCI_MAPREG_ROM:
+		conf_data = PCI_EXPANSION_ROM_BAR;
+		break;
+	case PCI_CAPLISTPTR_REG:
+		conf_data = PCI_CAPLIST_USB_POINTER;
+		break;
+	case PCI_INTERRUPT_REG:
+		conf_data =
+		    (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+		    (PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
+		break;
+	default:
+		conf_data = 0;
+		break;
+	}
+
+	return conf_data;
+}
+
+#else				/* TEST_CS5536_USE_OTG */
+
+static void pci_otg_write_reg(int reg, u32 value)
+{
+	return;
+}
+
+static u32 pci_otg_read_reg(int reg)
+{
+	return 0xffffffff;
+}
+
+#endif				/* TEST_CS5536_USE_OTG */
+
+/* read/write to PCI config space and transfer it to MSR write */
+
+/*
+ * write to PCI config space and transfer it to MSR write.
+ */
+void cs5536_pci_conf_write4(int function, int reg, u32 value)
+{
+	/* some basic checking. */
+	if ((function < CS5536_FUNC_START) || (function > CS5536_FUNC_END)) {
+		return;
+	}
+	if ((reg < 0) || (reg > 0x100) || ((reg & 0x03) != 0)) {
+		return;
+	}
+
+	switch (function) {
+	case CS5536_ISA_FUNC:
+		pci_isa_write_reg(reg, value);
+		break;
+	case CS5536_FLASH_FUNC:
+		pci_flash_write_reg(reg, value);
+		break;
+	case CS5536_IDE_FUNC:
+		pci_ide_write_reg(reg, value);
+		break;
+	case CS5536_ACC_FUNC:
+		pci_acc_write_reg(reg, value);
+		break;
+	case CS5536_OHCI_FUNC:
+		pci_ohci_write_reg(reg, value);
+		break;
+	case CS5536_EHCI_FUNC:
+		pci_ehci_write_reg(reg, value);
+		break;
+	case CS5536_UDC_FUNC:
+		pci_udc_write_reg(reg, value);
+		break;
+	case CS5536_OTG_FUNC:
+		pci_otg_write_reg(reg, value);
+		break;
+	default:
+		break;
+	}
+	return;
+}
+
+/*
+ * read PCI config space and transfer it to MSR access.
+ */
+u32 cs5536_pci_conf_read4(int function, int reg)
+{
+	u32 data = 0;
+
+	/* some basic checking. */
+	if ((function < CS5536_FUNC_START) || (function > CS5536_FUNC_END)) {
+		return 0;
+	}
+	if ((reg < 0) || ((reg & 0x03) != 0)) {
+		return 0;
+	}
+	if (reg > 0x100)
+		return 0xffffffff;
+
+	switch (function) {
+	case CS5536_ISA_FUNC:
+		data = pci_isa_read_reg(reg);
+		break;
+	case CS5536_FLASH_FUNC:
+		data = pci_flash_read_reg(reg);
+		break;
+	case CS5536_IDE_FUNC:
+		data = pci_ide_read_reg(reg);
+		break;
+	case CS5536_ACC_FUNC:
+		data = pci_acc_read_reg(reg);
+		break;
+	case CS5536_OHCI_FUNC:
+		data = pci_ohci_read_reg(reg);
+		break;
+	case CS5536_EHCI_FUNC:
+		data = pci_ehci_read_reg(reg);
+		break;
+	case CS5536_UDC_FUNC:
+		data = pci_udc_read_reg(reg);
+		break;
+	case CS5536_OTG_FUNC:
+		data = pci_otg_read_reg(reg);
+		break;
+	default:
+		break;
+	}
+	return data;
+}
diff --git a/arch/mips/loongson/common/mem.c
b/arch/mips/loongson/common/mem.c
index 85de2dc..059d43f 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -11,6 +11,7 @@
 
 #include <asm/bootinfo.h>
 
+#include <loongson.h>
 #include <mem.h>
 
 extern unsigned int memsize, highmemsize;
diff --git a/arch/mips/loongson/fuloong-2f/Makefile
b/arch/mips/loongson/fuloong-2f/Makefile
new file mode 100644
index 0000000..010b86c
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2f/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for fuloong-2f
+#
+
+obj-y += irq.o reset.o
diff --git a/arch/mips/loongson/fuloong-2f/irq.c
b/arch/mips/loongson/fuloong-2f/irq.c
new file mode 100644
index 0000000..94a4def
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2f/irq.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or
modify it
+ *  under  the terms of  the GNU General  Public License as published
by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at
your
+ *  option) any later version.
+ */
+
+#include <linux/interrupt.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+inline int mach_i8259_irq(void)
+{
+	int irq, isr, imr;
+
+	irq = -1;
+
+	if ((LOONGSON_INTISR & LOONGSON_INTEN) & LOONGSON_INT_BIT_INT0) {
+		imr = inb(0x21) | (inb(0xa1) << 8);
+		isr = inb(0x20) | (inb(0xa0) << 8);
+		isr &= ~0x4;	/* irq2 for cascade */
+		isr &= ~imr;
+		irq = ffs(isr) - 1;
+	}
+
+	return irq;
+}
+
+extern void bonito_irqdispatch(void);
+extern void i8259_irqdispatch(void);
+
+inline void mach_irq_dispatch(unsigned int pending)
+{
+	if (pending & CAUSEF_IP7) {
+		do_IRQ( LOONGSON_TIMER_IRQ );
+	} else if (pending & CAUSEF_IP6) {	/* North Bridge, Performance
counter */
+		do_IRQ( LOONGSON_PERFCNT_IRQ );
+		bonito_irqdispatch();
+	} else if (pending & CAUSEF_IP3) {	/* CPU UART */
+		do_IRQ( LOONGSON_UART_IRQ );
+	} else if (pending & CAUSEF_IP2) {	/* South Bridge */
+		i8259_irqdispatch();
+	} else {
+		spurious_interrupt();
+	}
+}
+
+void __init set_irq_trigger_mode(void)
+{
+	/* setup cs5536 as high level trigger */
+	LOONGSON_INTPOL = LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1;
+	LOONGSON_INTEDGE &= ~(LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1);
+}
diff --git a/arch/mips/loongson/fuloong-2f/reset.c
b/arch/mips/loongson/fuloong-2f/reset.c
new file mode 100644
index 0000000..19a0941
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2f/reset.c
@@ -0,0 +1,75 @@
+/* Board-specific reboot/shutdown routines
+ *
+ * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published by
the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
+ * option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+
+#include <loongson.h>
+
+/* cs5536 is the south bridge used by fuloong2f mini PC */
+#include <cs5536/cs5536.h>	
+
+void inline mach_prepare_reboot(void)
+{
+	/* 
+	 * reset cpu to full speed, this is needed when enabling cpu
frequency 
+	 * scalling
+	 */
+	LOONGSON_CHIPCFG0 |= 0x7;
+
+	/* send a reset signal to south bridge. 
+	 * anyone of the following two methods works well.
+	 *
+	 * NOTE: if enable "Power Management" in kernel, rtl8169 will not
reset
+	 * normally with this reset operation and it will not work in PMON,
but 
+	 * you can tyep halt command and then reboot, seems the hardware
reset 
+	 * logic not work normally.
+	 */
+#if 0 
+	{
+		u32 hi, lo;
+		_rdmsr(GLCP_MSR_REG(GLCP_SYS_RST), &hi, &lo);
+		lo |= 0x00000001;
+		_wrmsr(GLCP_MSR_REG(GLCP_SYS_RST), hi, lo);
+	}
+#else	
+	{
+		u32 hi, lo;
+		_rdmsr(DIVIL_MSR_REG(DIVIL_SOFT_RESET), &hi, &lo);
+		lo |= 0x00000001;
+		_wrmsr(DIVIL_MSR_REG(DIVIL_SOFT_RESET), hi, lo);
+	}
+#endif
+}
+
+void inline mach_prepare_shutdown(void)
+{
+	u32 hi, lo, val;
+	phys_addr_t gpio_base;
+
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+
+	gpio_base = mips_io_port_base | (lo & 0xff00);
+
+	/* make cs5536 gpio13 output enable */
+	val = (readl((u32 *) (gpio_base + GPIOL_OUT_EN)) & ~(1 << (16 + 13)))
+	    | (1 << 13);
+	writel(val, (u32 *) (gpio_base + GPIOL_OUT_EN));
+	mmiowb();
+	/* make cs5536 gpio13 output low level voltage. */
+	val = (readl((u32 *) (gpio_base + GPIOL_OUT_VAL)) & ~(1 << (13)))
+	    | (1 << (16 + 13));
+	writel(val, (u32 *) (gpio_base + GPIOL_OUT_VAL));
+	mmiowb();
+}
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index a0cc238..b96ed14 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -26,7 +26,8 @@ obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
-obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-fuloong2e.o
+obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
+obj-$(CONFIG_LEMOTE_FULOONG2F)	+= fixup-fuloong2f.o ops-loongson2.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-fuloong2f.c
b/arch/mips/pci/fixup-fuloong2f.c
new file mode 100644
index 0000000..8118e91
--- /dev/null
+++ b/arch/mips/pci/fixup-fuloong2f.c
@@ -0,0 +1,189 @@
+/*
+ * Copyright (C) 2008 Lemote Technology
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or
modify it
+ *  under  the terms of  the GNU General  Public License as published
by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at
your
+ *  option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <loongson.h>
+#include <cs5536/cs5536.h>
+
+/* 
+ * PCI interrupt pins 
+ *
+ * These should not be changed, or you should consider loongson2f
interrupt register and
+ * your pci card dispatch
+ */
+#define PCIA		4
+#define PCIB		5
+#define PCIC		6
+#define PCID		7
+
+/* all the pci device has the PCIA pin, check the datasheet. */
+static char irq_tab[][5] __initdata = {
+	/*      INTA    INTB    INTC    INTD */
+	{0, 0, 0, 0, 0},	/*  11: Unused */
+	{0, 0, 0, 0, 0},	/*  12: Unused */
+	{0, 0, 0, 0, 0},	/*  13: Unused */
+	{0, 0, 0, 0, 0},	/*  14: Unused */
+	{0, 0, 0, 0, 0},	/*  15: Unused */
+	{0, 0, 0, 0, 0},	/*  16: Unused */
+	{0, PCIA, 0, 0, 0},	/*  17: RTL8110-0 */
+	{0, PCIB, 0, 0, 0},	/*  18: RTL8110-1 */
+	{0, PCIC, 0, 0, 0},	/*  19: SiI3114 */
+	{0, PCID, 0, 0, 0},	/*  20: 3-ports nec usb */
+	{0, PCIA, PCIB, PCIC, PCID},	/*  21: PCI-SLOT */
+	{0, 0, 0, 0, 0},	/*  22: Unused */
+	{0, 0, 0, 0, 0},	/*  23: Unused */
+	{0, 0, 0, 0, 0},	/*  24: Unused */
+	{0, 0, 0, 0, 0},	/*  25: Unused */
+	{0, 0, 0, 0, 0},	/*  26: Unused */
+	{0, 0, 0, 0, 0},	/*  27: Unused */
+};
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int virq;
+
+	if ((PCI_SLOT(dev->devfn) != (14)) && (PCI_SLOT(dev->devfn) < 32)) {
+		virq = irq_tab[slot][pin];
+		printk("slot: %d, pin: %d, irq: %d\n", slot, pin,
+		       virq + LOONGSON_IRQ_BASE);
+		if (virq != 0)
+			return (LOONGSON_IRQ_BASE + virq);
+		else
+			return 0;
+	} else if (PCI_SLOT(dev->devfn) == 14) {	/*  cs5536 */
+		switch (PCI_FUNC(dev->devfn)) {
+		case 2:
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 14);
+			return 14;	/*  for IDE */
+		case 3:
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
+			return 9;	/*  for AUDIO */
+		case 4:	/*  for OHCI */
+		case 5:	/*  for EHCI */
+		case 6:	/*  for UDC */
+		case 7:	/*  for OTG */
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+			return 11;
+		}
+		return dev->irq;
+	} else {
+		printk(" strange pci slot number.\n");
+		return 0;
+	}
+}
+
+/* Do platform specific device initialization at pci_enable_device()
time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+/* CS5536 SPEC. fixup */
+static void __init loongson_cs5536_isa_fixup(struct pci_dev *pdev)
+{
+	/* the uart1 and uart2 interrupt in PIC is enabled as default */
+	pci_write_config_dword(pdev, 0x50, 1);
+	pci_write_config_dword(pdev, 0x54, 1);
+	/* enable the pci MASTER ABORT/ TARGET ABORT etc. */
+	/* pci_write_config_dword(pdev, 0x58, 1); */
+	return;
+}
+
+static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
+{
+	/* setting the mutex pin as IDE function */
+	/* the IDE interrupt in PIC is enabled as default */
+	pci_write_config_dword(pdev, 0x40, 0xDEADBEEF);
+	return;
+}
+
+static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
+{
+	u8 val;
+
+	/* enable the AUDIO interrupt in PIC  */
+	pci_write_config_dword(pdev, 0x50, 1);
+
+#if 1
+	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
+	printk("cs5536 acc latency %x\n", val);
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
+#endif
+	return;
+}
+
+static void __init loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
+{
+	/* enable the OHCI interrupt in PIC */
+	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
+	pci_write_config_dword(pdev, 0x50, 1);
+	return;
+}
+
+static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
+{
+	u32 hi, lo;
+
+	/* Serial short detect enable */
+	_rdmsr(USB_MSR_REG(USB_CONFIG), &hi, &lo);
+	_wrmsr(USB_MSR_REG(USB_CONFIG), (1 << 1) | (1 << 2) | (1 << 3), lo);
+
+#if 0
+	{
+		u32 bar;
+		void __iomem *base;
+
+		/* Write to clear diag register */
+		_rdmsr(USB_MSR_REG(USB_DIAG), &hi, &lo);
+		_wrmsr(USB_MSR_REG(USB_DIAG), hi, lo);
+
+		pci_read_config_dword(pdev, 0x10, &bar);
+		base = ioremap_nocache(bar, 0x100);
+
+		/* Make HCCAPARMS writable */
+		writel(readl(base + 0xA0) | (1 << 1), (base + 0xA0));
+
+		/* EECP=50h, IST=01h, ASPC=1h */
+		writel(0x00000012, base + 0x08);
+		iounmap(base);
+	}
+#endif
+
+	/* setting the USB2.0 micro frame length */
+	pci_write_config_dword(pdev, 0x60, 0x2000);
+	return;
+}
+
+static void __init loongson_nec_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+
+	pci_read_config_dword(pdev, 0xe0, &val);
+	/* Only 2 port be used */
+	pci_write_config_dword(pdev, 0xe0, (val & ~3) | 0x2);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_ISA,
+			 loongson_cs5536_isa_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_OHC,
+			 loongson_cs5536_ohci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_EHC,
+			 loongson_cs5536_ehci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+			 loongson_cs5536_acc_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_IDE,
+			 loongson_cs5536_ide_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+			 loongson_nec_fixup);
diff --git a/arch/mips/pci/ops-fuloong2e.c
b/arch/mips/pci/ops-fuloong2e.c
deleted file mode 100644
index dbcc1eb..0000000
--- a/arch/mips/pci/ops-fuloong2e.c
+++ /dev/null
@@ -1,159 +0,0 @@
-/*
- * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
- *	All rights reserved.
- *	Authors: Carsten Langgaard <carstenl@mips.com>
- *		 Maciej W. Rozycki <macro@mips.com>
- *
- *  This program is free software; you can distribute it and/or modify
it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but
WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License
along
- *  with this program; if not, write to the Free Software Foundation,
Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * MIPS boards specific PCI support.
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <loongson.h>
-
-#define PCI_ACCESS_READ  0
-#define PCI_ACCESS_WRITE 1
-
-#define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(LOONGSON_PCICFG_BASE |
(offset))
-#define ID_SEL_BEGIN 11
-#define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
-
-
-static int loongson_pcibios_config_access(unsigned char access_type,
-				      struct pci_bus *bus,
-				      unsigned int devfn, int where,
-				      u32 * data)
-{
-	u32 busnum = bus->number;
-	u32 addr, type;
-	u32 dummy;
-	void *addrp;
-	int device = PCI_SLOT(devfn);
-	int function = PCI_FUNC(devfn);
-	int reg = where & ~3;
-
-	if (busnum == 0) {
-		/* Type 0 configuration for onboard PCI bus */
-		if (device > MAX_DEV_NUM)
-			return -1;
-
-		addr = (1 << (device + ID_SEL_BEGIN)) | (function << 8) | reg;
-		type = 0;
-	} else {
-		/* Type 1 configuration for offboard PCI bus */
-		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
-		type = 0x10000;
-	}
-
-	/* Clear aborts */
-	LOONGSON_PCICMD |= LOONGSON_PCICMD_MABORT_CLR |
LOONGSON_PCICMD_MTABORT_CLR;
-
-	LOONGSON_PCIMAP_CFG = (addr >> 16) | type;
-
-	/* Flush Bonito register block */
-	dummy = LOONGSON_PCIMAP_CFG;
-	mmiowb();
-
-	addrp = CFG_SPACE_REG(addr & 0xffff);
-	if (access_type == PCI_ACCESS_WRITE) {
-		writel(cpu_to_le32(*data), addrp);
-	} else {
-		*data = le32_to_cpu(readl(addrp));
-	}
-
-	/* Detect Master/Target abort */
-	if (LOONGSON_PCICMD & (LOONGSON_PCICMD_MABORT_CLR |
-			     LOONGSON_PCICMD_MTABORT_CLR)) {
-		/* Error occurred */
-
-		/* Clear bits */
-		LOONGSON_PCICMD |= (LOONGSON_PCICMD_MABORT_CLR |
-				  LOONGSON_PCICMD_MTABORT_CLR);
-
-		return -1;
-	}
-
-	return 0;
-
-}
-
-
-/*
- * We can't address 8 and 16 bit words directly.  Instead we have to
- * read/write a 32bit word and mask/modify the data we actually want.
- */
-static int loongson_pcibios_read(struct pci_bus *bus, unsigned int
devfn,
-			     int where, int size, u32 * val)
-{
-	u32 data = 0;
-
-	if ((size == 2) && (where & 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	else if ((size == 4) && (where & 3))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
-				       &data))
-		return -1;
-
-	if (size == 1)
-		*val = (data >> ((where & 3) << 3)) & 0xff;
-	else if (size == 2)
-		*val = (data >> ((where & 3) << 3)) & 0xffff;
-	else
-		*val = data;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int loongson_pcibios_write(struct pci_bus *bus, unsigned int
devfn,
-			      int where, int size, u32 val)
-{
-	u32 data = 0;
-
-	if ((size == 2) && (where & 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	else if ((size == 4) && (where & 3))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (size == 4)
-		data = val;
-	else {
-		if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
-		                               where, &data))
-			return -1;
-
-		if (size == 1)
-			data = (data & ~(0xff << ((where & 3) << 3))) |
-				(val << ((where & 3) << 3));
-		else if (size == 2)
-			data = (data & ~(0xffff << ((where & 3) << 3))) |
-				(val << ((where & 3) << 3));
-	}
-
-	if (loongson_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn,
where,
-				       &data))
-		return -1;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-struct pci_ops loongson_pci_ops = {
-	.read = loongson_pcibios_read,
-	.write = loongson_pcibios_write
-};
diff --git a/arch/mips/pci/ops-loongson2.c
b/arch/mips/pci/ops-loongson2.c
new file mode 100644
index 0000000..a391307
--- /dev/null
+++ b/arch/mips/pci/ops-loongson2.c
@@ -0,0 +1,210 @@
+/*
+ * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
+ *
+ *  This program is free software; you can distribute it and/or modify
it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but
WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
along
+ *  with this program; if not, write to the Free Software Foundation,
Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * MIPS boards specific PCI support.
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <loongson.h>
+
+#ifdef CONFIG_CS5536
+#include <cs5536/cs5536_pci.h>
+#endif
+
+#define PCI_ACCESS_READ  0
+#define PCI_ACCESS_WRITE 1
+
+#define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(LOONGSON_PCICFG_BASE |
(offset))
+#define ID_SEL_BEGIN 11
+#define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
+
+
+static int loongson_pcibios_config_access(unsigned char access_type,
+				      struct pci_bus *bus,
+				      unsigned int devfn, int where,
+				      u32 * data)
+{
+	u32 busnum = bus->number;
+	u32 addr, type;
+	u32 dummy;
+	void *addrp;
+	int device = PCI_SLOT(devfn);
+	int function = PCI_FUNC(devfn);
+	int reg = where & ~3;
+
+	if (busnum == 0) {
+		/* board-specific parts, currently, only fuloong2f,yeeloong2f use
CS5536,
+		   fuloong2e use via686b */
+#ifdef CONFIG_CS5536
+		/*  
+		 * CS5536 PCI ACCESS ROUTINE, Note the functions circle call:
+		 *
loongson_pcibios_config_access()--->cs5536_pci_conf_read/write4()--->
+		 *    _rdmsr/_wrmsr()--->loongson_pcibios_read/write()
+		 */
+		if ((PCI_OPS_CS5536_IDSEL == device) && (reg < 0xF0)) {
+			switch (access_type) {
+			case PCI_ACCESS_READ:
+				*data = cs5536_pci_conf_read4(function, reg);
+				break;
+			case PCI_ACCESS_WRITE:
+				cs5536_pci_conf_write4(function, reg, *data);
+				break;
+			}
+			return 0;
+		}
+#endif
+		/* Type 0 configuration for onboard PCI bus */
+		if (device > MAX_DEV_NUM)
+			return -1;
+
+		addr = (1 << (device + ID_SEL_BEGIN)) | (function << 8) | reg;
+		type = 0;
+	} else {
+		/* Type 1 configuration for offboard PCI bus */
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		type = 0x10000;
+	}
+
+	/* Clear aborts */
+	LOONGSON_PCICMD |= LOONGSON_PCICMD_MABORT_CLR |
LOONGSON_PCICMD_MTABORT_CLR;
+
+	LOONGSON_PCIMAP_CFG = (addr >> 16) | type;
+
+	/* Flush Bonito register block */
+	dummy = LOONGSON_PCIMAP_CFG;
+	mmiowb();
+
+	addrp = CFG_SPACE_REG(addr & 0xffff);
+	if (access_type == PCI_ACCESS_WRITE) {
+		writel(cpu_to_le32(*data), addrp);
+	} else {
+		*data = le32_to_cpu(readl(addrp));
+	}
+
+	/* Detect Master/Target abort */
+	if (LOONGSON_PCICMD & (LOONGSON_PCICMD_MABORT_CLR |
+			     LOONGSON_PCICMD_MTABORT_CLR)) {
+		/* Error occurred */
+
+		/* Clear bits */
+		LOONGSON_PCICMD |= (LOONGSON_PCICMD_MABORT_CLR |
+				  LOONGSON_PCICMD_MTABORT_CLR);
+
+		return -1;
+	}
+
+	return 0;
+
+}
+
+
+/*
+ * We can't address 8 and 16 bit words directly.  Instead we have to
+ * read/write a 32bit word and mask/modify the data we actually want.
+ */
+static int loongson_pcibios_read(struct pci_bus *bus, unsigned int
devfn,
+			     int where, int size, u32 * val)
+{
+	u32 data = 0;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
+				       &data))
+		return -1;
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int loongson_pcibios_write(struct pci_bus *bus, unsigned int
devfn,
+			      int where, int size, u32 val)
+{
+	u32 data = 0;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (size == 4)
+		data = val;
+	else {
+		if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
+		                               where, &data))
+			return -1;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+	}
+
+	if (loongson_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn,
where,
+				       &data))
+		return -1;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops loongson_pci_ops = {
+	.read = loongson_pcibios_read,
+	.write = loongson_pcibios_write
+};
+
+#ifdef CONFIG_CS5536
+void _rdmsr(u32 msr, u32 * hi, u32 * lo)
+{
+	struct pci_bus bus = {
+		.number = 0
+	};
+	u32 devfn = PCI_DEVFN(PCI_OPS_CS5536_IDSEL, 0);
+	loongson_pcibios_write(&bus, devfn, 0xf4, 4, msr);
+	loongson_pcibios_read(&bus, devfn, 0xf8, 4, lo);
+	loongson_pcibios_read(&bus, devfn, 0xfc, 4, hi);
+}
+
+void _wrmsr(u32 msr, u32 hi, u32 lo)
+{
+	struct pci_bus bus = {
+		.number = 0
+	};
+	u32 devfn = PCI_DEVFN(PCI_OPS_CS5536_IDSEL, 0);
+	loongson_pcibios_write(&bus, devfn, 0xf4, 4, msr);
+	loongson_pcibios_write(&bus, devfn, 0xf8, 4, lo);
+	loongson_pcibios_write(&bus, devfn, 0xfc, 4, hi);
+}
+
+EXPORT_SYMBOL(_rdmsr);
+EXPORT_SYMBOL(_wrmsr);
+#endif
-- 
1.6.2.1
