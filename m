Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2005 14:27:42 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:29851 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8126484AbVLTO1S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Dec 2005 14:27:18 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jBKERxt11783;
	Tue, 20 Dec 2005 18:27:59 +0400
Message-ID: <43A814EF.6060509@ru.mvista.com>
Date:	Tue, 20 Dec 2005 17:27:59 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] PNX8550 NAND flash driver
References: <43A2F819.1040106@ru.mvista.com>
In-Reply-To: <43A2F819.1040106@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050702040603060002030909"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050702040603060002030909
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Vladimir A. Barinov wrote:

> Hi All,
>
> Attached patch is NAND flash driver for PNX8550 based platforms.
> Any comments and suggestions are highly appreciated.

Sorry, but this patch is not complete. It's needed to add 
include/../nand.h file.

Attachment is the recasted variant (removing "volatile u16 *" usage, 
"prink" usage changes and some cosmetic changes) with nand.h part.

Vladimir

--------------050702040603060002030909
Content-Type: text/plain;
 name="nand.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nand.patch"

Signed-off-by: vbarinov@ru.mvista.com

 drivers/mtd/nand/Kconfig             |    6 
 drivers/mtd/nand/Makefile            |    1 
 drivers/mtd/nand/pnx8550.c           |  694 +++++++++++++++++++++++++++++++++++
 include/asm-mips/mach-pnx8550/nand.h |   22 +
 4 files changed, 721 insertions(+), 2 deletions(-)

Index: linux-2.6.15_0/drivers/mtd/nand/Kconfig
===================================================================
--- linux-2.6.15_0.orig/drivers/mtd/nand/Kconfig
+++ linux-2.6.15_0/drivers/mtd/nand/Kconfig
@@ -90,6 +90,12 @@ config MTD_NAND_S3C2410
 	  No board specfic support is done by this driver, each board
 	  must advertise a platform_device for the driver to attach.
 
+config MTD_NAND_PNX8550
+	tristate "NAND Flash support for PNX8550"
+	depends on PNX8550 && MTD_NAND
+	help
+	  This enables the NAND flash controller on the PNX8550.
+
 config MTD_NAND_S3C2410_DEBUG
 	bool "S3C2410 NAND driver debug"
 	depends on MTD_NAND_S3C2410
Index: linux-2.6.15_0/drivers/mtd/nand/pnx8550.c
===================================================================
--- /dev/null
+++ linux-2.6.15_0/drivers/mtd/nand/pnx8550.c
@@ -0,0 +1,694 @@
+/*
+ * Copyright (C) 2005 Koninklijke Philips Electronics N.V.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * 
+ * Overview:
+ *   This is a device driver for the NAND flash device found on the
+ *   PNX8550 board which utilizes the Samsung K9F5616U0C part. This is
+ *   a 32MByte (16M x 16 bits) NAND flash device.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/compatmac.h>
+#include <linux/interrupt.h>
+#include <linux/mtd/partitions.h>
+#include <asm/io.h>
+#include <asm/mach-pnx8550/nand.h>
+
+#define UBTM_NAME                 "microBTM"
+#define UBTM_BLOCK_START         ( 0x00000000)
+#define UBTM_BLOCK_END           ( 0x00004000)	/* 16K size, first block */
+#define UBTM_SIZE                ( UBTM_BLOCK_END - UBTM_BLOCK_START)
+
+#define BOOTLOADER_NAME           "bootloader"
+#define BOOTLOADER_BLOCK_START   ( UBTM_BLOCK_END)
+#define BOOTLOADER_BLOCK_END     ( 0x00040000)	/* 256K -  16K = 240K    */
+#define BOOTLOADER_SIZE          ( BOOTLOADER_BLOCK_END - BOOTLOADER_BLOCK_START)
+
+#define ROMFS_SYS_NAME            "ROMFS-Tools"
+#define ROMFS_SYS_BLOCK_START    ( BOOTLOADER_BLOCK_END)
+#define ROMFS_SYS_BLOCK_END      ( 0x00600000)	/*   6M - 256K = 5.75M   */
+#define ROMFS_SYS_SIZE           ( ROMFS_SYS_BLOCK_END - ROMFS_SYS_BLOCK_START)
+
+#define ROMFS_APP_NAME            "ROMFS-User"
+#define ROMFS_APP_BLOCK_START    ( ROMFS_SYS_BLOCK_END)
+#define ROMFS_APP_BLOCK_END      ( 0x01000000)	/*  16M -   6M = 10M     */
+#define ROMFS_APP_SIZE           ( ROMFS_APP_BLOCK_END - ROMFS_APP_BLOCK_START)
+
+#define USER_NAME                 "User"
+#define USER_BLOCK_START         ( ROMFS_APP_BLOCK_END)
+#define USER_BLOCK_END           ( 0x02000000)	/*  32M -  16M = 16M     */
+#define USER_SIZE                ( USER_BLOCK_END - USER_BLOCK_START)
+
+#define NAND_ADDR(_col, _page) ((_col) & (mtd->oobblock - 1)) + ((_page) << this->page_shift)
+
+#define NAND_ADDR_SEND(_addr) writew(0, pNandAddr + _addr)
+
+#define NAND_TRANSFER_TO(_addr, _buffer, _bytes)   pnx8550_nand_transfer(_buffer, pNandAddr + _addr, _bytes, 1)
+#define NAND_TRANSFER_FROM(_addr, _buffer, _bytes) pnx8550_nand_transfer(pNandAddr + _addr, _buffer, _bytes, 0)
+
+/*
+ * Define partitions for flash device
+ */
+#define NUM_PARTITIONS 5
+const static struct mtd_partition partition_info[NUM_PARTITIONS] = {
+	{
+	 .name = UBTM_NAME,
+	 .offset = UBTM_BLOCK_START,
+	 .size = UBTM_SIZE},
+	{
+	 .name = BOOTLOADER_NAME,
+	 .offset = BOOTLOADER_BLOCK_START,
+	 .size = BOOTLOADER_SIZE},
+	{
+	 .name = ROMFS_SYS_NAME,
+	 .offset = ROMFS_SYS_BLOCK_START,
+	 .size = ROMFS_SYS_SIZE},
+	{
+	 .name = ROMFS_APP_NAME,
+	 .offset = ROMFS_APP_BLOCK_START,
+	 .size = ROMFS_APP_SIZE},
+	{
+	 .name = USER_NAME,
+	 .offset = USER_BLOCK_START,
+	 .size = USER_SIZE}
+};
+
+/* Bad block descriptor for 16Bit nand flash */
+static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
+static struct nand_bbt_descr nand16bit_memorybased = {
+	.options = 0,
+	.offs = 0,
+	.len = 2,
+	.pattern = scan_ff_pattern
+};
+
+/* OOB Placement information that lines up with the boot loader code */
+static struct nand_oobinfo nand16bit_oob_16 = {
+	.useecc = MTD_NANDECC_AUTOPLACE,
+	.eccbytes = 6,
+	.eccpos = {2, 3, 4, 5, 6, 7},
+	.oobfree = {{8, 8}}
+};
+
+/* Pointer into XIO for access to the 16Bit NAND flash device */
+static u8 *pNandAddr;
+
+/* Last command sent to the pnx8550_nand_command function */
+static int last_command = -1;
+/*
+ * Next column address to read/write, set by pnx8550_nand_command
+ * updated by the read/write functions
+ */
+static int last_col_addr = -1;
+/*
+ *  Next page address to read/write, set by pnx8550_nand_command
+ *  updated by the read/write functions
+ */
+static int last_page_addr = -1;
+
+/* 32bit Aligned/DMA buffer */
+static u_char *transferBuffer;
+
+static struct mtd_info pnx8550_mtd;
+static struct nand_chip pnx8550_nand;
+
+/**
+ * Setup the registers in PCIXIO
+ */
+static void pnx8550_nand_register_setup(u_char cmd_no,
+					u_char addr_no,
+					u_char include_data,
+					u_char monitor_ACK,
+					u_char enable64M, int cmd_a, int cmd_b)
+{
+	unsigned int reg_nand = 0;
+	reg_nand |= enable64M ? PNX8550_XIO_FLASH_64MB : 0;
+	reg_nand |= include_data ? PNX8550_XIO_FLASH_INC_DATA : 0;
+	reg_nand |= PNX8550_XIO_FLASH_CMD_PH(cmd_no);
+	reg_nand |= PNX8550_XIO_FLASH_ADR_PH(addr_no);
+	reg_nand |= PNX8550_XIO_FLASH_CMD_A(cmd_a);
+	reg_nand |= PNX8550_XIO_FLASH_CMD_B(cmd_b);
+	PNX8550_XIO_FLASH_CTRL = reg_nand;
+	barrier();
+}
+
+/**
+ * Wait for the device to be ready for the next command
+ */
+static inline void pnx8550_nand_wait_for_dev_ready(void)
+{
+	while ((PNX8550_XIO_CTRL & PNX8550_XIO_CTRL_XIO_ACK) == 0) ;
+}
+
+/**
+ * Transfer data to/from the NAND chip using DMA
+ *
+ * @from:  Address to transfer data from
+ * @to:    Address to transfer the data to
+ * @bytes: Number of bytes to transfer
+ * @toxio: Whether the transfer is going to XIO or not.
+ */
+static void pnx8550_nand_transferDMA(void *from, void *to, int bytes, int toxio)
+{
+	int cmd = 0;
+	u32 internal;
+	u32 external;
+
+	if (toxio) {
+		cmd = PNX8550_DMA_CTRL_PCI_CMD_WRITE;
+		dma_cache_wback((unsigned long)from, bytes);
+		internal = (u32) virt_to_phys(from);
+		external = (u32) to - KSEG1;
+	} else {
+		cmd = PNX8550_DMA_CTRL_PCI_CMD_READ;
+		internal = (u32) virt_to_phys(to);
+		external = (u32) from - KSEG1;
+	}
+
+	local_irq_disable();
+	PNX8550_DMA_TRANS_SIZE = bytes >> 2;	/* Length in words */
+	PNX8550_DMA_EXT_ADDR = external;
+	PNX8550_DMA_INT_ADDR = internal;
+	PNX8550_DMA_INT_CLEAR = 0xffff;
+	PNX8550_DMA_CTRL = PNX8550_DMA_CTRL_BURST_512 |
+	    PNX8550_DMA_CTRL_SND2XIO | PNX8550_DMA_CTRL_INIT_DMA | cmd;
+
+	while ((PNX8550_DMA_INT_STATUS & PNX8550_DMA_INT_COMPL) == 0) ;
+
+	if (!toxio)
+		dma_cache_inv((unsigned long)to, bytes);
+
+	local_irq_enable();
+}
+
+/**
+ * Transfer data to/from the NAND chip.
+ * This function decides whether to use DMA or not depending on
+ * the amount of data to transfer and the alignment of the buffers.
+ *
+ * @from:  Address to transfer data from
+ * @to:    Address to transfer the data to
+ * @bytes: Number of bytes to transfer
+ * @toxio: Whether the transfer is going to XIO or not.
+ */
+static void pnx8550_nand_transfer(void *from, void *to, int bytes, int toxio)
+{
+	u16 *from16 = (u16 *) from;
+	u16 *to16 = (u16 *) to;
+
+	int i;
+
+	if ((u32) from & 3)
+		printk(KERN_INFO "%s: from buffer not 32bit aligned, will not "
+			 "use fastest transfer mechanism\n", __FUNCTION__);
+	if ((u32) to & 3)
+		printk(KERN_INFO "%s: to buffer not 32bit aligned, will not "
+			 "use fastest transfer mechanism\n", __FUNCTION__);
+
+	if (((bytes & 3) || (bytes < 16)) || ((u32) to & 3) || ((u32) from & 3)) {
+		if (((bytes & 1) == 0) &&
+		    (((u32) to & 1) == 0) && (((u32) from & 1) == 0)) {
+			int words = bytes / 2;
+
+			local_irq_disable();
+			for (i = 0; i < words; i++)
+				to16[i] = from16[i];
+			local_irq_enable();
+		} 
+		else
+			printk(KERN_ERR "%s: Transfer failed, "
+			       "byte-aligned transfers no allowed!\n",
+			        __FUNCTION__);
+	} else {
+		pnx8550_nand_transferDMA(from, to, bytes, toxio);
+	}
+}
+
+/**
+ * pnx8550_nand_read_byte - read one byte endianess aware from the chip
+ * @mtd:	MTD device structure
+ */
+static u_char pnx8550_nand_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd->priv;
+	u16 data = 0;
+	int addr = NAND_ADDR(last_col_addr, last_page_addr);
+	/*
+	 * Read ID is a special case as we have to read BOTH bytes at the same
+	 * time otherwise it doesn't work, once we have both bytes we work out
+	 * which one we want.
+	 */
+	if (last_command == NAND_CMD_READID) {
+		u32 data32;
+		data32 = cpu_to_le32(readl(pNandAddr + 0));
+		if (last_col_addr)
+			data = (u16) (data32 >> 16);
+		else
+			data = (u16) data32;
+	} else {
+		data = readw(pNandAddr + addr);
+		if ((addr & 0x1) == 1)
+			data = (data & 0xff00) >> 16;
+	}
+	/*
+	 * Status is a special case, we don't need to increment the address
+	 * because the address isn't used by the chip
+	 */
+	if (last_command != NAND_CMD_STATUS)
+		last_col_addr++;
+
+	return data & 0xff;
+}
+
+/**
+ * pnx8550_nand_read_word - read one word from the chip
+ * @mtd:	MTD device structure
+ *
+ * Read function for 16bit buswith without
+ * endianess conversion
+ */
+static u16 pnx8550_nand_read_word(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd->priv;
+	int addr = NAND_ADDR(last_col_addr, last_page_addr);
+	u16 data = readw(pNandAddr + addr);
+	return data;
+}
+
+/**
+ * pnx8550_nand_write_byte - write one byte endianess aware to the chip
+ * @mtd:	MTD device structure
+ * @byte:	pointer to data byte to write
+ *
+ * Write function for 16bit buswith with
+ * endianess conversion
+ */
+static void pnx8550_nand_write_byte(struct mtd_info *mtd, u_char byte)
+{
+	struct nand_chip *this = mtd->priv;
+	int addr = NAND_ADDR(last_col_addr, last_page_addr);
+	writew(le16_to_cpu((u16) byte), pNandAddr + addr);
+}
+
+/**
+ * pnx8550_nand_write_word - write one word to the chip
+ * @mtd:	MTD device structure
+ * @word:	data word to write
+ *
+ * Write function for 16bit buswith without
+ * endianess conversion
+ */
+static void pnx8550_nand_write_word(struct mtd_info *mtd, u16 word)
+{
+	struct nand_chip *this = mtd->priv;
+	int addr = NAND_ADDR(last_col_addr, last_page_addr);
+	writew(word, pNandAddr + addr);
+}
+
+/**
+ * pnx8550_nand_write_buf - write buffer to chip
+ * @mtd:	MTD device structure
+ * @buf:	data buffer
+ * @len:	number of bytes to write
+ */
+static void pnx8550_nand_write_buf(struct mtd_info *mtd, const u_char * buf,
+				   int len)
+{
+	struct nand_chip *this = mtd->priv;
+	int addr = NAND_ADDR(last_col_addr, last_page_addr);
+	int pageLen;
+	int oobLen = 0;
+	u_char *transBuf = (u_char *) buf;
+
+	/* some sanity checking, word access only please */
+	if (len & 1)
+		pr_debug("%s: non-word aligned length requested!\n",
+			 __FUNCTION__);
+
+	memcpy(transferBuffer, buf, len);
+	transBuf = transferBuffer;
+
+	/*
+	 * Work out whether we are going to write to the OOB area
+	 * after a standard page write.
+	 * This is not the case when the command function is called
+	 * with a column address > page size. Then we write as though
+	 * it is to the page rather than the OOB as the command function
+	 * has already selected the OOB area.
+	 */
+	if ((last_col_addr + len) > mtd->oobblock)
+		oobLen = (last_col_addr + len) - mtd->oobblock;
+	pageLen = len - oobLen;
+
+	/* Clear the done flag */
+	PNX8550_GPXIO_CTRL |= PNX8550_GPXIO_CLR_DONE;
+	if (pageLen > 0)
+		NAND_TRANSFER_TO(addr, transBuf, pageLen);
+
+	if (oobLen > 0) {
+		pnx8550_nand_wait_for_dev_ready();
+
+		pnx8550_nand_register_setup(1, 0, 0, 1, 0, NAND_CMD_READOOB, 0);
+		/* Work out where in the OOB we are going to start to write */
+		addr = NAND_ADDR(last_col_addr - mtd->oobblock, last_page_addr);
+		NAND_ADDR_SEND(addr);
+		pnx8550_nand_register_setup(2, 3, 1, 1, 0, NAND_CMD_SEQIN,
+					    NAND_CMD_PAGEPROG);
+
+		/* Clear the done flag */
+		PNX8550_GPXIO_CTRL |= PNX8550_GPXIO_CLR_DONE;
+		NAND_TRANSFER_TO(addr, transBuf + pageLen, oobLen);
+	}
+
+	/*
+	 * Increment the address so on the next write we write in the
+	 * correct place.
+	 */
+	last_col_addr += len;
+	if (last_col_addr >= mtd->oobblock + mtd->oobsize) {
+		last_col_addr -= mtd->oobblock + mtd->oobsize;
+		last_page_addr++;
+	}
+}
+
+/**
+ * pnx8550_nand_read_buf - read chip data into buffer
+ * @mtd:	MTD device structure
+ * @buf:	buffer to store date
+ * @len:	number of bytes to read
+ */
+static void pnx8550_nand_read_buf(struct mtd_info *mtd, u_char * buf, int len)
+{
+	struct nand_chip *this = mtd->priv;
+	int addr = NAND_ADDR(last_col_addr, last_page_addr);
+	int pageLen;
+	int oobLen = 0;
+	u_char *transBuf = buf;
+
+	/* some sanity checking, word access only please */
+	if (len & 1)
+		pr_debug("%s: non-word aligned length\n", __FUNCTION__);
+
+	transBuf = transferBuffer;
+
+	/*
+	 * Work out whether we are going to read the OOB area
+	 * after a standard page read.
+	 * This is not the case when the command function is called
+	 * with a column address > page size. Then we read as though
+	 * it is from the page rather than the OOB as the command
+	 * function has already selected the OOB area.
+	 */
+	if ((last_col_addr + len) > mtd->oobblock)
+		oobLen = (last_col_addr + len) - mtd->oobblock;
+
+	pageLen = len - oobLen;
+
+	if (pageLen)
+		NAND_TRANSFER_FROM(addr, transBuf, pageLen);
+
+	if (oobLen > 0) {
+		pnx8550_nand_register_setup(1, 3, 1, 1, 0, NAND_CMD_READOOB, 0);
+		addr = NAND_ADDR(last_col_addr - mtd->oobblock, last_page_addr);
+		NAND_TRANSFER_FROM(addr, transBuf + pageLen, oobLen);
+	}
+
+	if (transBuf != buf)
+		memcpy(buf, transBuf, len);
+
+	/*
+	 * Increment the address so on the next read we read from the
+	 * correct place.
+	 */
+	last_col_addr += len;
+	if (last_col_addr > mtd->oobblock + mtd->oobsize) {
+		last_col_addr -= mtd->oobblock + mtd->oobsize;
+		last_page_addr++;
+	}
+	return;
+}
+
+/**
+ * pnx8550_nand_verify_buf -  Verify chip data against buffer
+ * @mtd:	MTD device structure
+ * @buf:	buffer containing the data to compare
+ * @len:	number of bytes to compare
+ *
+ */
+static int pnx8550_nand_verify_buf(struct mtd_info *mtd, const u_char * buf,
+				   int len)
+{
+	int result = 0;
+
+	/* some sanity checking, word access only please */
+	if (len & 1)
+		pr_debug("%s: non-word aligned length\n", __FUNCTION__);
+
+	pnx8550_nand_read_buf(mtd, transferBuffer, len);
+	if (memcmp(buf, transferBuffer, len))
+		result = -EFAULT;
+
+	return result;
+
+}
+
+/**
+ * pnx8550_nand_command - Send command to NAND device
+ * @mtd:	MTD device structure
+ * @command:	the command to be sent
+ * @column:	the column address for this command, -1 if none
+ * @page_addr:	the page address for this command, -1 if none
+ *
+ * Send command to NAND device.
+ */
+static void pnx8550_nand_command(struct mtd_info *mtd, unsigned command,
+				 int column, int page_addr)
+{
+	register struct nand_chip *this = mtd->priv;
+	u_char addr_no = 0;
+	u_char spare = 0;
+	int addr;
+	/*
+	   If we are starting a write work out whether it is to the
+	   OOB or the main page and position the pointer correctly.
+	 */
+	if (command == NAND_CMD_SEQIN) {
+		int readcmd;
+		int col = column;
+		if (column >= mtd->oobblock) {
+			/* OOB area */
+			col -= mtd->oobblock;
+			readcmd = NAND_CMD_READOOB;
+			spare = 1;
+		} else {
+			readcmd = NAND_CMD_READ0;
+		}
+		pnx8550_nand_register_setup(1, 0, 0, 1, 0, readcmd, 0);
+		addr = NAND_ADDR(col, page_addr);
+		NAND_ADDR_SEND(addr);
+	}
+
+	/* Check the number of address bytes */
+	if ((column == -1) && (page_addr == -1)) {
+		addr_no = 0;
+		column = 0;
+		page_addr = 0;
+	} else if ((column == -1) && (page_addr != -1)) {
+		addr_no = 2;
+		column = 0;
+	} else if ((column != -1) && (page_addr == -1)) {
+		addr_no = 1;
+		page_addr = 0;
+	} else {
+		addr_no = 3;
+	}
+
+	last_command = command;
+	last_col_addr = column;
+	last_page_addr = page_addr;
+
+	switch (command) {
+	case NAND_CMD_PAGEPROG:
+		/* Nothing to do, we've already done it! */
+		return;
+
+	case NAND_CMD_SEQIN:
+		if (addr_no != 3)
+			printk(KERN_ERR
+			       "NAND: Command %02x needs 3 byte address, "
+			       "but addr_no = %d\n", command, addr_no);
+		pnx8550_nand_register_setup(2, 3, 1, 1, spare, NAND_CMD_SEQIN,
+					    NAND_CMD_PAGEPROG);
+		return;
+
+	case NAND_CMD_ERASE1:
+		if (addr_no != 2)
+			pr_debug("NAND: Command %02x needs 2 byte" "address, "
+				 "but addr_no = %d\n", command, addr_no);
+		PNX8550_GPXIO_CTRL |= PNX8550_GPXIO_CLR_DONE;
+		pnx8550_nand_register_setup(2, 2, 0, 1, 0, NAND_CMD_ERASE1,
+					    NAND_CMD_ERASE2);
+		addr = NAND_ADDR(column, page_addr);
+		NAND_ADDR_SEND(addr);
+		return;
+
+	case NAND_CMD_ERASE2:
+		/* Nothing to do, we've already done it! */
+		return;
+
+	case NAND_CMD_STATUS:
+		if (addr_no != 0)
+			pr_debug("NAND: Command %02x needs 0 byte address, "
+				 "but addr_no = %d\n", command, addr_no);
+		pnx8550_nand_register_setup(1, 0, 1, 0, 0, NAND_CMD_STATUS, 0);
+		return;
+
+	case NAND_CMD_RESET:
+		if (addr_no != 0)
+			pr_debug("NAND: Command %02x needs 0 byte address, "
+				 "but addr_no = %d\n", command, addr_no);
+		pnx8550_nand_register_setup(1, 0, 0, 0, 0, NAND_CMD_RESET, 0);
+		addr = NAND_ADDR(column, page_addr);
+		NAND_ADDR_SEND(addr);
+		return;
+
+	case NAND_CMD_READ0:
+		if (addr_no != 3)
+			pr_debug("NAND: Command %02x needs 3 byte address, "
+				 "but addr_no = %d\n", command, addr_no);
+		pnx8550_nand_register_setup(1, 3, 1, 1, 0, NAND_CMD_READ0, 0);
+		return;
+
+	case NAND_CMD_READ1:
+		printk(KERN_ERR "Wrong command: %02x\n", command);
+		return;
+
+	case NAND_CMD_READOOB:
+		if (addr_no != 3)
+			pr_debug("NAND: Command %02x needs 3 byte address, "
+				 "but addr_no = %d\n", command, addr_no);
+		pnx8550_nand_register_setup(1, 3, 1, 1, 0, NAND_CMD_READOOB, 0);
+		return;
+
+	case NAND_CMD_READID:
+		if (addr_no != 1)
+			pr_debug("NAND: Command %02x needs 1 byte address, "
+				 "but addr_no = %d\n", command, addr_no);
+		pnx8550_nand_register_setup(1, 1, 1, 0, 0, NAND_CMD_READID, 0);
+		return;
+	}
+}
+
+/**
+ * Return true if the device is ready, false otherwise
+ */
+static int pnx8550_nand_dev_ready(struct mtd_info *mtd)
+{
+	return ((PNX8550_XIO_CTRL & PNX8550_XIO_CTRL_XIO_ACK) != 0);
+}
+
+/**
+ *	hardware specific access to control-lines
+ */
+static void pnx8550_nand_hwcontrol(struct mtd_info *mtd, int cmd)
+{
+	/* Nothing to do here, its all done by the XIO block */
+}
+
+/**
+ * Main initialization routine
+ */
+int __init pnx8550_nand_init(void)
+{
+	struct nand_chip *this;
+
+	/* Get pointer to private data */
+	this = &pnx8550_nand;
+
+	/* Work out address of Nand Flash */
+	pNandAddr = (u8 *) (KSEG1 | (PNX8550_BASE18_ADDR & (~0x7)));
+
+	pNandAddr = (u8 *) (((u32) pNandAddr) +
+			     ((PNX8550_XIO_SEL0 & PNX8550_XIO_SEL0_OFFSET_MASK)
+			      >> PNX8550_XIO_SEL0_OFFSET_SHIFT) * 8 * 1024 *
+			     1024);
+
+	/* Link the private data with the MTD structure */
+	pnx8550_mtd.priv = this;
+	this->chip_delay = 15;
+	this->options = NAND_BUSWIDTH_16;
+	this->cmdfunc = pnx8550_nand_command;
+	this->read_byte = pnx8550_nand_read_byte;
+	this->read_word = pnx8550_nand_read_word;
+	this->read_buf = pnx8550_nand_read_buf;
+	this->write_byte = pnx8550_nand_write_byte;
+	this->write_word = pnx8550_nand_write_word;
+	this->write_buf = pnx8550_nand_write_buf;
+	this->verify_buf = pnx8550_nand_verify_buf;
+	this->dev_ready = pnx8550_nand_dev_ready;
+	this->hwcontrol = pnx8550_nand_hwcontrol;
+	this->eccmode = NAND_ECC_SOFT;
+	this->badblock_pattern = &nand16bit_memorybased;
+	this->autooob = &nand16bit_oob_16;
+
+	transferBuffer =
+	    kmalloc(pnx8550_mtd.oobblock + pnx8550_mtd.oobsize,
+		    GFP_DMA | GFP_KERNEL);
+	if (!transferBuffer) {
+		printk(KERN_ERR
+		       "Unable to allocate NAND data buffer for PNX8550\n");
+		return -ENOMEM;
+	}
+
+	/* Scan to find existence of the device */
+	if (nand_scan(&pnx8550_mtd, 1)) {
+		printk(KERN_ERR "No NAND devices\n");
+		return -ENXIO;
+	}
+
+	add_mtd_partitions(&pnx8550_mtd, partition_info, NUM_PARTITIONS);
+
+	return 0;
+}
+
+module_init(pnx8550_nand_init);
+
+#ifdef MODULE
+static void __exit pnx8550_nand_cleanup(void)
+{
+	nand_release(&pnx8550_mtd);
+	kfree(transferBuffer);
+}
+
+module_exit(pnx8550_nand_cleanup);
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Charrett");
+MODULE_DESCRIPTION("Driver for 16Bit NAND Flash on the XIO bus for PNX8550");
Index: linux-2.6.15_0/drivers/mtd/nand/Makefile
===================================================================
--- linux-2.6.15_0.orig/drivers/mtd/nand/Makefile
+++ linux-2.6.15_0/drivers/mtd/nand/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_MTD_NAND_H1900)		+= h1910.o
 obj-$(CONFIG_MTD_NAND_RTC_FROM4)	+= rtc_from4.o
 obj-$(CONFIG_MTD_NAND_SHARPSL)		+= sharpsl.o
 obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
+obj-$(CONFIG_MTD_NAND_PNX8550)		+= pnx8550.o
 
 nand-objs = nand_base.o nand_bbt.o
Index: linux-2.6.15_0/include/asm-mips/mach-pnx8550/nand.h
===================================================================
--- linux-2.6.15_0.orig/include/asm-mips/mach-pnx8550/nand.h
+++ linux-2.6.15_0/include/asm-mips/mach-pnx8550/nand.h
@@ -4,10 +4,14 @@
 #define PNX8550_NAND_BASE_ADDR   0x10000000
 #define PNX8550_PCIXIO_BASE	 0xBBE40000
 
+#define PNX8550_BASE10_ADDR      *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x050)
+#define PNX8550_BASE14_ADDR      *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x054)
+#define PNX8550_BASE18_ADDR      *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x058)
 #define PNX8550_DMA_EXT_ADDR     *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x800)
 #define PNX8550_DMA_INT_ADDR     *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x804)
 #define PNX8550_DMA_TRANS_SIZE   *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x808)
 #define PNX8550_DMA_CTRL         *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x80c)
+#define PNX8550_XIO_CTRL         *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x810)
 #define PNX8550_XIO_SEL0         *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x814)
 #define PNX8550_GPXIO_ADDR       *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x820)
 #define PNX8550_GPXIO_WR         *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0x824)
@@ -21,6 +25,8 @@
 #define PNX8550_DMA_INT_ENABLE   *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0xfd4)
 #define PNX8550_DMA_INT_CLEAR    *(volatile unsigned long *)(PNX8550_PCIXIO_BASE + 0xfd8)
 
+#define PNX8550_XIO_CTRL_XIO_ACK     0x00000002
+
 #define PNX8550_XIO_SEL0_EN_16BIT    0x00800000
 #define PNX8550_XIO_SEL0_USE_ACK     0x00400000
 #define PNX8550_XIO_SEL0_REN_HIGH    0x00100000
@@ -39,6 +45,9 @@
 #define PNX8550_XIO_SEL0_SIZE_64MB   0x00000006
 #define PNX8550_XIO_SEL0_ENAB        0x00000001
 
+#define PNX8550_XIO_SEL0_OFFSET_SHIFT 5
+#define PNX8550_XIO_SEL0_OFFSET_MASK  (0xf << PNX8550_XIO_SEL0_OFFSET_SHIFT)
+
 #define PNX8550_SEL0_DEFAULT ((PNX8550_XIO_SEL0_EN_16BIT)  | \
                               (PNX8550_XIO_SEL0_REN_HIGH*0)| \
 	                      (PNX8550_XIO_SEL0_REN_LOW*2) | \
@@ -59,11 +68,15 @@
 
 #define PNX8550_XIO_FLASH_64MB       0x00200000
 #define PNX8550_XIO_FLASH_INC_DATA   0x00100000
-#define PNX8550_XIO_FLASH_CMD_PH     0x000C0000
+#define PNX8550_XIO_FLASH_CMD_PH_SHIFT 18
+#define PNX8550_XIO_FLASH_CMD_PH_MASK  (3 << PNX8550_XIO_FLASH_CMD_PH_SHIFT)
+#define PNX8550_XIO_FLASH_CMD_PH(_x)   (((_x) << PNX8550_XIO_FLASH_CMD_PH_SHIFT) & PNX8550_XIO_FLASH_CMD_PH_MASK)
+#define PNX8550_XIO_FLASH_ADR_PH_SHIFT 16
+#define PNX8550_XIO_FLASH_ADR_PH_MASK  (3 << PNX8550_XIO_FLASH_ADR_PH_SHIFT)
+#define PNX8550_XIO_FLASH_ADR_PH(_x)   (((_x) << PNX8550_XIO_FLASH_ADR_PH_SHIFT) & PNX8550_XIO_FLASH_ADR_PH_MASK)
 #define PNX8550_XIO_FLASH_CMD_PH2    0x00080000
 #define PNX8550_XIO_FLASH_CMD_PH1    0x00040000
 #define PNX8550_XIO_FLASH_CMD_PH0    0x00000000
-#define PNX8550_XIO_FLASH_ADR_PH     0x00030000
 #define PNX8550_XIO_FLASH_ADR_PH3    0x00030000
 #define PNX8550_XIO_FLASH_ADR_PH2    0x00020000
 #define PNX8550_XIO_FLASH_ADR_PH1    0x00010000
@@ -118,4 +131,9 @@
 #define PNX8550_DMA_INT_CLR_M_ABORT	(1<<2)
 #define PNX8550_DMA_INT_CLR_T_ABORT	(1<<1)
 
+#define PNX8550_DMA_INT_ACK          0x00004000
+#define PNX8550_DMA_INT_COMPL        0x00001000
+#define PNX8550_DMA_INT_NONSUP       0x00000200
+#define PNX8550_DMA_INT_ABORT        0x00000004
+
 #endif

--------------050702040603060002030909--
