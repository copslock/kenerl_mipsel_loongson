Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 16:48:38 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:64279
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3465714AbVJTPsL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 16:48:11 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9KFm8P8002056;
	Thu, 20 Oct 2005 08:48:08 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9KFm8ku002053;
	Thu, 20 Oct 2005 08:48:08 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.48184.340986.463557@dl2.hq2.avtrex.com>
Date:	Thu, 20 Oct 2005 08:48:08 -0700
To:	linux-mips@linux-mips.org
CC:	linux-ide@vger.kernel.org
CC:	linux-kernel@vger.kernel.org
Subject: Patch: ATI Xilleon port 10/11 Xilleon IDE controller support
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the tenth part of my Xilleon port.

I am sending the full set of patches to linux-mips@linux-mips.org
which is archived at: http://www.linux-mips.org/archives/

Only the patches that touch generic parts of the kernel are coming
here.

This patch adds the Xilleon's IDE driver.

Patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

Xilleon IDE controller support.

---
commit 2a66e82b3d2b02aca88cc2f60286fba0c114139d
tree af6a21de182519250b49d5b127342b969c022174
parent 162fee1af111103bb6e6275c2e51a550ff393cbc
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:59:58 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:59:58 -0700

 drivers/ide/Kconfig       |    7 
 drivers/ide/pci/Makefile  |    1 
 drivers/ide/pci/xilleon.c |  637 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 645 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -740,6 +740,13 @@ config BLK_DEV_VIA82CXXX
 	  This allows the kernel to change PIO, DMA and UDMA speeds and to
 	  configure the chip to optimum performance.
 
+config BLK_DEV_IDE_XILLEON
+	bool "Xilleon chipset support"
+	depends on ATI_XILLEON
+	help
+	  This driver provides support for the Xilleon's on chip IDE
+          controller.
+
 endif
 
 config BLK_DEV_IDE_PMAC
diff --git a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
--- a/drivers/ide/pci/Makefile
+++ b/drivers/ide/pci/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_BLK_DEV_SLC90E66)		+= slc90
 obj-$(CONFIG_BLK_DEV_TRIFLEX)		+= triflex.o
 obj-$(CONFIG_BLK_DEV_TRM290)		+= trm290.o
 obj-$(CONFIG_BLK_DEV_VIA82CXXX)		+= via82cxxx.o
+obj-$(CONFIG_BLK_DEV_IDE_XILLEON)	+= xilleon.o
 
 # Must appear at the end of the block
 obj-$(CONFIG_BLK_DEV_GENERIC)          += generic.o
diff --git a/drivers/ide/pci/xilleon.c b/drivers/ide/pci/xilleon.c
new file mode 100644
--- /dev/null
+++ b/drivers/ide/pci/xilleon.c
@@ -0,0 +1,637 @@
+/*
+ * ATI Xilleon 225/226 UDMA controller driver
+ *
+ * Copyright (C) 2001, 2002 Metro Link, Inc.
+ *
+ * Port to kernel version 2.6.12 by David Daney loosely based on the 2.4.18
+ * version by Metro Link and ATI.  Also based on code in via82cxxx.c
+ *
+ *
+ * May be copied or modified under the terms of the GNU General Public License 
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+
+#include <linux/stat.h>
+#include <linux/proc_fs.h>
+
+#include <asm/mach-xilleon/xilleon.h>
+#include <asm/mach-xilleon/xilleonreg_kernel.h>
+#include <asm/mach-xilleon/xilleonint.h>
+
+#include <asm/io.h>
+
+int xilleon_ide_proc;
+
+static struct pci_dev *bmide_dev;
+
+/* #define DEBUG 1 */
+
+#if defined(CONFIG_PROC_FS)
+static u8 xilleon_proc = 0;
+
+/**
+ *	xilleon_ide_get_info		-	generate xilleon /proc file 
+ *	@buffer: buffer for data
+ *	@addr: set to start of data to use
+ *	@offset: current file offset
+ *	@count: size of read
+ *
+ *	Fills in buffer with the debugging/configuration information for
+ *	the Xilleon tuning and attached drives
+ */
+
+static int xilleon_ide_get_info(char *buffer,
+				char **addr, off_t offset, int count)
+{
+	char *p = buffer;
+	u32 bibma = pci_resource_start(bmide_dev, 4);
+	struct pci_dev *dev = bmide_dev;
+	u8 c0 = 0;
+	u8 c1 = 0;
+	u8 d0 = 0;
+	u8 d1 = 0;
+	u8 udma_control;
+
+	p += sprintf(p, "\n     ATI Xilleon Chipset.\n");
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &c1);
+
+	p+= sprintf(p, "       Revision:   %#x\n", c1);
+
+        /*
+         * at that point bibma+0x2 et bibma+0xa are byte registers
+         * to investigate:
+         */
+
+	pci_read_config_byte(bmide_dev, pciideIDE_UDMA_CONTROL, &udma_control);
+	pci_read_config_byte(bmide_dev, pciideX225_IDE_DMA_MODE + 0, &d0);
+	pci_read_config_byte(bmide_dev, pciideX225_IDE_DMA_MODE + 1, &d1);
+
+
+	c0 = inb_p((unsigned short)bibma + 0x02);
+	c1 = inb_p((unsigned short)bibma + 0x0a);
+
+	p += sprintf(p, "--------------- Primary Channel ----------------\n");
+	p += sprintf(p, "                %sabled\n",
+		     (c0&0x80) ? "dis" : " en");
+
+	p += sprintf(p, "--------------- drive0 --------- drive1 --------\n");
+	p += sprintf(p, "DMA enabled:    %s              %s\n",
+		     (c0&0x20) ? "yes" : "no ",
+		     (c0&0x40) ? "yes" : "no ");
+
+	p += sprintf(p, "UDMA enabled:   %s              %s\n",
+		     (udma_control & 0x01) ? "yes" : "no ",
+		     (udma_control & 0x02) ? "yes" : "no ");
+
+	p += sprintf(p, "Mode:           %sDMA %d          %sDMA %d\n",
+		     d0 & 0x10 ? "U" : " ", d0 & 0xf,
+		     d1 & 0x10 ? "U" : " ", d1 & 0xf);
+	
+	return p-buffer;     /* => must be less than 4k! */
+}
+
+#endif
+
+/*
+ * initialize the x225 chip
+ */
+
+static unsigned int __devinit pci_init_x225_ide (struct pci_dev *dev,
+						 const char *name)
+{
+	u32 bmbase  = 0;
+
+#ifdef DEBUG
+	u8 rev  = 0;
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+	printk(KERN_INFO "XILLEON 210/225/226 IDE:"
+	       " rev %02x IDE UDMA controller on pci%s\n", 
+	       rev, dev->slot_name);
+#endif
+	bmide_dev = dev;
+
+	/* Indicate drives are capable of dma transfers */
+	pci_read_config_dword(bmide_dev, pciideX225_IDE_BM_BASE, &bmbase);
+	bmbase &= 0xfffffff0;
+	outb((inb(bmbase + ioideX225_IDE_PRI_BM_STATUS) | 0x60),
+	     bmbase + ioideX225_IDE_PRI_BM_STATUS);
+	outb((inb(bmbase + ioideX225_IDE_SEC_BM_STATUS) | 0x60),
+	     bmbase + ioideX225_IDE_SEC_BM_STATUS);
+
+	return 0;
+}
+
+/********************************************************
+*
+* max_drive_pio_mode
+*
+* Determine the maximum pio mode supported by this drive
+*
+*********************************************************/
+static byte max_drive_pio_mode (ide_drive_t *drive)
+{
+	unsigned short pio_timing[6] = {960, 480, 240, 180, 120, 90};
+	unsigned short adv_modes     = drive->id->eide_pio_modes;
+	unsigned short iordy_time    = drive->id->eide_pio_iordy;
+	byte mode_mask               = 0x01;
+	byte max_pio = 2;
+
+	if (drive->id->field_valid & 0x02) {
+		/* If the drive supports flow control, use the minimum
+		 * iordy time to find the best pio mode supported by
+		 * the drive. */
+		if (drive->id->eide_pio_iordy > 0) {
+			/* iordy supported, use minimum drive timing to
+			   find best mode. */
+			for (max_pio = 5;
+			     max_pio && iordy_time > pio_timing[max_pio];
+			     max_pio--);
+		} else {
+			/* iordy not supported, use advanced mode support
+			   flags to find best mode. */
+			for (max_pio = 2;
+			     adv_modes & mode_mask; mode_mask <<= 1) {
+				max_pio++;
+			}
+		}
+	}     
+#ifdef DEBUG
+	printk("XILLEON 210/225/226 IDE drive %d, max pio mode = %d\n",
+	       drive->dn, max_pio);
+#endif
+	return max_pio;
+}
+
+/********************************************************
+*
+* max_drive_dma_mode
+*
+* Determine the maximum dma mode supported by this drive
+*
+*********************************************************/
+static byte max_drive_dma_mode (ide_drive_t *drive)
+{
+	unsigned short dma_modes = drive->id->dma_mword;
+	unsigned short mode_mask = 0x80;
+	byte max_dma             = 0;
+
+	if (drive->id->field_valid & 0x02 && dma_modes & 0xff) {
+		for (max_dma = 7;
+		     (dma_modes & mode_mask) == 0; mode_mask >>= 1) {
+			max_dma--;
+		}
+#ifdef DEBUG
+		printk("XILLEON 210/225/226 IDE drive %d,"
+		       " max dma mode = %d\n", drive->dn, max_dma);
+#endif        
+		return max_dma;
+	} else {
+#ifdef DEBUG
+		printk("XILLEON 210/225/226 IDE drive %d,"
+		       " dma not supported\n", drive->dn);
+#endif
+		return 0x0f;
+	}
+}
+
+/********************************************************
+*
+* max_drive_udma_mode
+*
+* Determine the maximum dma mode supported by this drive
+*
+*********************************************************/
+static byte max_drive_udma_mode (ide_drive_t *drive)
+{
+	unsigned short udma_modes = drive->id->dma_ultra;
+	unsigned short mode_mask  = 0x80;
+	byte max_udma             = 0;
+
+	if (drive->id->field_valid & 0x04 && udma_modes & 0xff) {
+		for (max_udma = 7;
+		     (udma_modes & mode_mask) == 0; mode_mask >>= 1) {
+			max_udma--;
+		}
+		if (eighty_ninty_three(drive)) {
+#ifdef DEBUG
+			printk("XILLEON 210/225/226 IDE drive %d,"
+			       " max udma mode = %d\n", drive->dn, max_udma);
+#endif        
+			return max_udma;
+		} else {
+#ifdef DEBUG
+			printk("XILLEON 210/225/226 IDE IDE cable does not"
+			       " support UDMA modes > 2."
+			       "  Drive %d, max udma mode = %d\n",
+			       drive->dn, max_udma > 2 ? 2 : max_udma);
+#endif        
+			return max_udma > 2 ? 2 : max_udma;
+		}
+	} else {
+#ifdef DEBUG
+		printk("XILLEON 210/225/226 IDE drive %d,"
+		       " udma not supported\n", drive->dn);
+#endif
+		return 0x0f;
+	}
+}
+
+
+static int x225_ide_tune_chipset (ide_drive_t *drive, byte speed)
+{
+
+	ide_hwif_t *hwif    = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+	int err;
+   
+	u32 work_dword;
+
+	u8 tmg_cntl_reg_off;  /* timing register offset */
+	u8 pio_cntl_reg_off;  /* pio control register offset */
+	u8 pio_mode_reg_off;  /* pio mode register offset */
+	u8 pio_mode_reg;      /* pio mode register contents */
+	u8 pio_mode;          /* pio mode  */
+#if 0
+	u8 pio_control;       /* pio control register */
+#endif
+	u8 dma_mode_reg_off;  /* dma mode register offset */
+	u8 dma_mode;          /* dma mode */
+
+	if (drive->dn > 3)    /* we  support four drives */
+		return -1;
+
+	/* Setup register offsets for current drive */
+	/* Assume drives 0/1 are on primary, 2/3 are on secondary */
+	if (drive->dn > 1) {
+		pio_mode_reg_off = pciideX225_IDE_PIO_MODE+1;
+		pio_cntl_reg_off = pciideX225_IDE_PIO_CONTROL+1;
+		tmg_cntl_reg_off = drive->dn&1 ?
+			pciideX225_IDE_TMG_CNTL+2 : pciideX225_IDE_TMG_CNTL+3;
+		dma_mode_reg_off = drive->dn&1 ?
+			pciideX225_IDE_DMA_MODE+3 : pciideX225_IDE_DMA_MODE+2;
+	} else {
+		pio_mode_reg_off = pciideX225_IDE_PIO_MODE;
+		pio_cntl_reg_off = pciideX225_IDE_PIO_CONTROL;
+		tmg_cntl_reg_off = drive->dn&1 ?
+			pciideX225_IDE_TMG_CNTL : pciideX225_IDE_TMG_CNTL+1;
+		dma_mode_reg_off = drive->dn&1 ?
+			pciideX225_IDE_DMA_MODE+1 : pciideX225_IDE_DMA_MODE;
+	}
+
+	/* Reset auto-calc override so that controller calculates mode
+	   timing. */
+	pci_write_config_byte(dev, tmg_cntl_reg_off, 0x7f);
+
+	/* All three transfer types require pio mode to be set to */
+	/* maximum mode supported by both the drive and controller */
+	/* Get the current contents and clear the mode field for this drive*/
+	pci_read_config_byte(dev, pio_mode_reg_off, &pio_mode_reg);
+	pio_mode_reg = drive->dn&1 ? pio_mode_reg & 0x07 : pio_mode_reg & 0x70;
+	/* Get the highest mode the drive can support */
+	pio_mode   = max_drive_pio_mode(drive);
+
+#if 0
+	/* All three transfer types require udma control to be set/reset */
+	/* according to the transfer mode to be used */
+	/* Get the current contents and clear the enable flag for this drive*/
+	pci_read_config_byte(dev, pciideIDE_UDMA_CONTROL, &udma_control_reg);
+	udma_control_reg = drive->dn ?
+		udma_control_reg & 0xfd : pio_mode_reg & 0xfe;
+#endif
+	switch(speed) {
+        case XFER_PIO_4:
+        case XFER_PIO_3:
+        case XFER_PIO_2:
+        case XFER_PIO_1:
+        case XFER_PIO_0:
+		/* Setting transfer mode to PIO */
+		/* If requested mode is higher than drive supports,
+		   set to highest supported */
+		pio_mode = pio_mode > (speed - XFER_PIO_0) ?
+			speed - XFER_PIO_0 : pio_mode;
+
+#ifdef DEBUG
+		printk("xilleon_ide_tune_chipset for drive %s (%d),"
+		       " pio mode %d\n", drive->name, drive->dn, pio_mode);
+#endif
+
+#if 0
+		/* Enable prefetch and write posting */
+		pci_read_config_byte(dev, pio_cntl_reg_off, &pio_control);
+		pio_control = drive->dn ?
+			pio_control | 0x50 : pio_control | 0xa0;
+		pci_write_config_byte(dev, pio_cntl_reg_off, pio_control);
+#endif
+		break;
+
+        case XFER_MW_DMA_2:
+        case XFER_MW_DMA_1:
+        case XFER_MW_DMA_0:
+		/* Setting transfer mode to Multiword DMA */
+		dma_mode   = speed - XFER_MW_DMA_0;        
+		pci_write_config_byte(dev, dma_mode_reg_off, dma_mode); 
+#ifdef DEBUG
+		printk("xilleon_ide_tune_chipset for drive %s (%d),"
+		       " dma mode %d, pio mode %d\n", 
+		       drive->name, drive->dn, dma_mode, pio_mode);
+#endif
+		break;
+
+        case XFER_UDMA_5:
+        case XFER_UDMA_4:
+        case XFER_UDMA_3:
+        case XFER_UDMA_2:
+        case XFER_UDMA_1:
+        case XFER_UDMA_0:
+		/* Setting transfer mode to Ultra DMA */
+		dma_mode  = (speed - XFER_UDMA_0)|0x10;
+		pci_write_config_byte(dev, dma_mode_reg_off, dma_mode);
+#ifdef DEBUG
+		printk("xilleon_ide_tune_chipset for drive %s (%d),"
+		       " udma mode %d, pio mode %d\n", 
+		       drive->name, drive->dn, (speed - XFER_UDMA_0),
+		       pio_mode);
+#endif
+        default:
+		break;
+	}
+
+	if (!drive->init_speed)
+		drive->init_speed = speed;
+
+	/* Set Read and Write Combining */
+	pci_read_config_dword(dev, pciideX225_IDE_PCI_BUSMASTER_CNTL,
+			      &work_dword);
+	pci_write_config_dword(dev, pciideX225_IDE_PCI_BUSMASTER_CNTL,
+			       work_dword|0x60);
+
+	pio_mode_reg |= drive->dn&1 ? pio_mode << 4 : pio_mode;
+	pci_write_config_byte(dev, pio_mode_reg_off, pio_mode_reg);
+	err = ide_config_drive_speed(drive, speed);
+	drive->current_speed = speed;
+
+#if 0
+	pci_read_config_word(dev, pciideIDE_DEVICE_ID, &work_word);
+	printk("IDE_DEVICE_ID          =     %04x\n", work_word);
+
+	pci_read_config_dword(dev, pciideIDE_TMG_CNTL, &work_dword);
+	printk("IDE_TMG_CNTL           = %08x\n", work_dword);
+
+	pci_read_config_word(dev, pciideIDE_PIO_CONTROL, &work_word);
+	printk("IDE_PIO_CONTROL        =     %04x\n", work_word);
+
+	pci_read_config_word(dev, pciideIDE_PIO_MODE, &work_word);
+	printk("IDE_PIO_MODE           =     %04x\n", work_word);
+ 
+	pci_read_config_dword(dev, pciideIDE_DMA_MODE, &work_dword);
+	printk("IDE_DMA_MODE           = %08x\n", work_dword);
+
+	pci_read_config_dword(dev, pciideIDE_PCI_BUSMASTER_CNTL, &work_dword);
+	printk("IDE_PCI_BUSMASTER_CNTL = %08x\n", work_dword);
+#endif
+
+	return err;
+}
+
+/************************************
+
+config_chipset_for_pio              
+
+Set the controller and drive to the 
+highest pio mode supported by both  
+
+*************************************/
+
+static void config_chipset_for_pio (ide_drive_t *drive)
+{
+	byte speed = XFER_PIO_0 + max_drive_pio_mode (drive);
+
+	(void) x225_ide_tune_chipset(drive, speed);
+
+	drive->current_speed = speed;
+
+#ifdef DEBUG
+	printk("config_chipset_for_pio, speed is %d \n", speed);
+#endif
+}
+
+static void x225_ide_tune_drive (ide_drive_t *drive, byte pio)
+{
+#ifdef DEBUG
+	printk("tune drive %s (%d) for pio %d\n", drive->name, drive->dn, pio);
+#endif
+	(void) x225_ide_tune_chipset(drive, XFER_PIO_0 + pio);
+}
+
+static int config_chipset_for_dma (ide_drive_t *drive)
+{
+	struct hd_driveid *id = drive->id;
+	byte speed = 0x0f;
+
+#ifdef DEBUG
+	printk("config_chipset_for_dma for drive %s (%d)\n",
+	       drive->name, drive->dn);
+#endif
+
+	/* Check if drive supports ultra dma - get highest supported mode */
+	if ((speed = max_drive_udma_mode (drive)) != 0x0f) {
+		speed = speed > 5 ? 5 + XFER_UDMA_0 : speed + XFER_UDMA_0;
+		/* Check if drive supports dma - get highest supported mode */
+	} else if ((speed = max_drive_dma_mode (drive)) != 0x0f) {
+		speed = speed > 2 ? 2 + XFER_MW_DMA_0 : speed + XFER_MW_DMA_0;
+	} 
+	if(speed == 0x0f) {
+		/* Speed not set yet, get max pio mode supported
+		   by the drive. */
+		speed = max_drive_pio_mode (drive);
+		speed = speed > 4 ? 4 + XFER_PIO_0 : speed + XFER_PIO_0;
+	}
+	(void) x225_ide_tune_chipset(drive, speed);
+
+	/* Set return code based on drive id information. */
+	return (((id->dma_ultra & 0xff00 && id->field_valid & 0x04) || 
+		 (id->dma_mword & 0xff00 && id->field_valid & 0x02)) ? 1 : 0);
+}
+
+static int config_drive_xfer_rate (ide_drive_t *drive)
+{
+	struct hd_driveid *id = drive->id;
+	int use_dma = 1;
+	ide_hwif_t *hwif = HWIF(drive);
+    
+#ifdef DEBUG
+	printk("config_drive_xfer_rate for drive %s (%d)\n",
+	       drive->name, drive->dn);
+#endif
+
+	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+		/* Consult the list of known "bad" drives */
+		if (__ide_dma_bad_drive (drive))
+			use_dma = 0;
+		/* Not in list of bad drives - check udma */
+		else if (id->field_valid & 0x06)
+			/* Try to config ultra dma or multiword dma */
+			use_dma = config_chipset_for_dma(drive);
+
+		if (use_dma)
+			config_chipset_for_pio(drive);
+
+	}
+    
+	return use_dma ?
+		hwif->ide_dma_on(drive) : hwif->ide_dma_off_quietly(drive);
+}
+
+static void ide_outbsync_x22x (ide_drive_t *drive, u8 addr,
+			       unsigned long port)
+{
+	outb(addr, port);
+	wmb();
+}
+
+/*
+ * Init the hwif structure for this controller
+ */
+static void __devinit ide_init_x225 (ide_hwif_t *hwif)
+{
+	if (!hwif->irq) {
+#ifdef CONFIG_XILLEON_IDE_SEC
+		hwif->irq = X225_IDE_INT_SEC;
+#else
+		hwif->irq = X225_IDE_INT;
+#endif
+	}
+	hwif->tuneproc = x225_ide_tune_drive;
+	hwif->speedproc = x225_ide_tune_chipset;
+	hwif->serialized = 1;
+
+	hwif->OUTBSYNC = ide_outbsync_x22x;
+
+
+	if (hwif->dma_base) {
+		if (!noautodma)
+			hwif->autodma = 1;
+		hwif->ide_dma_check = config_drive_xfer_rate;
+		hwif->udma_four = 1;
+	} else {
+		hwif->autodma = 0;
+		hwif->drives[0].autotune = 1;
+		hwif->drives[1].autotune = 1;
+	}
+
+#if defined(CONFIG_PROC_FS)
+	if (!xilleon_proc) {
+		ide_pci_create_host_proc("xilleon", xilleon_ide_get_info);
+		xilleon_proc = 1;
+	}
+#endif /* CONFIG_PROC_FS */
+	return;
+}
+
+static void __devinit ide_dmacapable_x22x(ide_hwif_t *hwif,
+					  unsigned long dmabase)
+{
+	hwif->dma_base = dmabase;
+	ide_setup_dma(hwif, dmabase, 8);
+}
+
+static int __devinit init_setup_x22x (struct pci_dev *dev,
+				      ide_pci_device_t *d)
+{
+	return ide_setup_pci_device(dev, d);
+}
+
+static ide_pci_device_t xilleon_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name         = "X225",
+		.init_setup   = init_setup_x22x,
+		.init_chipset = pci_init_x225_ide,
+		.init_iops    = NULL,
+		.init_hwif    = ide_init_x225,
+		.init_dma     = ide_dmacapable_x22x,
+		.channels     = 1,
+		.autodma      = AUTODMA,
+		.enablebits   = {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable     = ON_BOARD,
+		.extra	      = 0,
+	},{	/* 1 */
+		.name	      = "X226",
+		.init_setup   = init_setup_x22x,
+		.init_chipset = pci_init_x225_ide,
+		.init_iops    = NULL,
+		.init_hwif    = ide_init_x225,
+		.init_dma     = ide_dmacapable_x22x,
+		.channels     = 1,
+		.autodma      = AUTODMA,
+		.enablebits   = {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable     = ON_BOARD,
+		.extra	      = 0,
+	},{	/* 2 */
+		.name	      = "X210",
+		.init_setup   = init_setup_x22x,
+		.init_chipset = pci_init_x225_ide,
+		.init_iops    = NULL,
+		.init_hwif    = ide_init_x225,
+		.init_dma     = ide_dmacapable_x22x,
+		.channels     = 1,
+		.autodma      = AUTODMA,
+		.enablebits   = {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable     = ON_BOARD,
+		.extra	      = 0,
+	}
+};
+
+static struct pci_device_id xilleon_pci_tbl[] __devinitdata = {
+        { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_X225_IDE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+        { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_X226_IDE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+        { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_X210_IDE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+        { 0, },
+};
+
+ 
+static int __devinit xilleon_init_one(struct pci_dev *dev,
+				      const struct pci_device_id *id)
+{
+	ide_pci_device_t *d = &xilleon_chipsets[id->driver_data];
+	return ide_setup_pci_device(dev, d);
+}
+
+static struct pci_driver driver = {
+        .name     = "xilleon_ide",
+        .id_table = xilleon_pci_tbl,
+        .probe    = xilleon_init_one,
+};
+
+
+static int xilleon_ide_init(void)
+{
+        return ide_pci_register_driver(&driver);
+}
+ 
+static void xilleon_ide_exit(void)
+{
+        ide_pci_unregister_driver(&driver);
+}
+ 
+module_init(xilleon_ide_init);
+module_exit(xilleon_ide_exit);
+
+MODULE_DESCRIPTION("PCI driver module for Xilleon IDE");
+MODULE_LICENSE("GPL");


 
