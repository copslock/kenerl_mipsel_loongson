Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 22:47:30 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:41733 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3467599AbWBMWrV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 22:47:21 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id BB75164D3D; Mon, 13 Feb 2006 22:53:37 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C2E8F82BB; Mon, 13 Feb 2006 22:53:31 +0000 (GMT)
Date:	Mon, 13 Feb 2006 22:53:31 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Please pull drivers/scsi/dec_esp.c from Linus' git
Message-ID: <20060213225331.GA5315@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

linux-mips git on DECstation currently fails to compile with:

  CC      drivers/scsi/dec_esp.o
drivers/scsi/dec_esp.c:137: error: static declaration of ‘dec_esp_detect’ follows non-static declaration
drivers/scsi/dec_esp.c:101: error: previous declaration of ‘dec_esp_detect’ was here
make[2]: *** [drivers/scsi/dec_esp.o] Error 1
make[1]: *** [drivers/scsi] Error 2

This declaration is correct in Linus' git tree but not in ours.  Ralf,
can you please compare the two again and sync.

The current delta is included below.


--- drivers/scsi/dec_esp.c	2006-02-13 21:48:12.000000000 +0000
+++ /home/tbm/index.html?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux-2.6.git;a=blob_plain;h=a35ee43a48df78e1b627c63e33e6895035d0fe1a;f=drivers%2Fscsi%2Fdec_esp.c	2006-02-13 22:52:06.000000000 +0000
@@ -55,7 +55,7 @@
 
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static void dma_drain(struct NCR_ESP *esp);
-static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd * sp);
+static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
 static void dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length);
 static void dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length);
@@ -64,9 +64,9 @@
 static int  dma_irq_p(struct NCR_ESP *esp);
 static int  dma_ports_p(struct NCR_ESP *esp);
 static void dma_setup(struct NCR_ESP *esp, u32 addr, int count, int write);
-static void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp);
-static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, Scsi_Cmnd * sp);
-static void dma_advance_sg(Scsi_Cmnd * sp);
+static void dma_mmu_get_scsi_one(struct NCR_ESP *esp, struct scsi_cmnd * sp);
+static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, struct scsi_cmnd * sp);
+static void dma_advance_sg(struct scsi_cmnd * sp);
 
 static void pmaz_dma_drain(struct NCR_ESP *esp);
 static void pmaz_dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length);
@@ -74,7 +74,7 @@
 static void pmaz_dma_ints_off(struct NCR_ESP *esp);
 static void pmaz_dma_ints_on(struct NCR_ESP *esp);
 static void pmaz_dma_setup(struct NCR_ESP *esp, u32 addr, int count, int write);
-static void pmaz_dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp);
+static void pmaz_dma_mmu_get_scsi_one(struct NCR_ESP *esp, struct scsi_cmnd * sp);
 
 #define TC_ESP_RAM_SIZE 0x20000
 #define ESP_TGT_DMA_SIZE ((TC_ESP_RAM_SIZE/7) & ~(sizeof(int)-1))
@@ -98,7 +98,7 @@
 static irqreturn_t scsi_dma_err_int(int, void *, struct pt_regs *);
 static irqreturn_t scsi_dma_int(int, void *, struct pt_regs *);
 
-int dec_esp_detect(struct scsi_host_template * tpnt);
+static int dec_esp_detect(struct scsi_host_template * tpnt);
 
 static int dec_esp_release(struct Scsi_Host *shost)
 {
@@ -112,7 +112,7 @@
 
 static struct scsi_host_template driver_template = {
 	.proc_name		= "dec_esp",
-	.proc_info		= &esp_proc_info,
+	.proc_info		= esp_proc_info,
 	.name			= "NCR53C94",
 	.detect			= dec_esp_detect,
 	.slave_alloc		= esp_slave_alloc,
@@ -230,7 +230,7 @@
 			mem_start = get_tc_base_addr(slot);
 
 			/* Store base addr into esp struct */
-			esp->slot = mem_start;
+			esp->slot = CPHYSADDR(mem_start);
 
 			esp->dregs = 0;
 			esp->eregs = (void *)CKSEG1ADDR(mem_start +
@@ -379,7 +379,7 @@
 	}
 }
 
-static int dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd * sp)
+static int dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd * sp)
 {
 	return sp->SCp.this_residual;
 }
@@ -491,12 +491,12 @@
 		dma_init_write(esp, addr, count);
 }
 
-static void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp)
+static void dma_mmu_get_scsi_one(struct NCR_ESP *esp, struct scsi_cmnd * sp)
 {
 	sp->SCp.ptr = (char *)virt_to_phys(sp->request_buffer);
 }
 
-static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, Scsi_Cmnd * sp)
+static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, struct scsi_cmnd * sp)
 {
 	int sz = sp->SCp.buffers_residual;
 	struct scatterlist *sg = sp->SCp.buffer;
@@ -508,7 +508,7 @@
 	sp->SCp.ptr = (char *)(sp->SCp.buffer->dma_address);
 }
 
-static void dma_advance_sg(Scsi_Cmnd * sp)
+static void dma_advance_sg(struct scsi_cmnd * sp)
 {
 	sp->SCp.ptr = (char *)(sp->SCp.buffer->dma_address);
 }
@@ -572,7 +572,7 @@
 		pmaz_dma_init_write(esp, addr, count);
 }
 
-static void pmaz_dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp)
+static void pmaz_dma_mmu_get_scsi_one(struct NCR_ESP *esp, struct scsi_cmnd * sp)
 {
 	sp->SCp.ptr = (char *)virt_to_phys(sp->request_buffer);
 }

-- 
Martin Michlmayr
http://www.cyrius.com/
