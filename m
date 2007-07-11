Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 15:14:14 +0100 (BST)
Received: from mail.blastwave.org ([147.87.98.10]:31163 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20021490AbXGKOOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 15:14:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id 6248CF958
	for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 16:13:36 +0200 (MEST)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2JeoDIF43tb0 for <linux-mips@linux-mips.org>;
	Wed, 11 Jul 2007 16:13:09 +0200 (MEST)
Received: from aki.intern.liechtiag.ch (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id 1F393F8A7
	for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 16:13:03 +0200 (MEST)
Date:	Wed, 11 Jul 2007 16:13:02 +0200
From:	Attila Kinali <attila@kinali.ch>
To:	linux-mips@linux-mips.org
Subject: Re: mtdram with huge sizes
Message-Id: <20070711161302.6d8ea633.attila@kinali.ch>
In-Reply-To: <20070711112511.41a633b6.attila@kinali.ch>
References: <20070711112511.41a633b6.attila@kinali.ch>
Organization: SEELE
X-Mailer: Sylpheed 2.4.0rc (GTK+ 2.10.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__11_Jul_2007_16_13_02_+0200_j7zEg1COMn/fp53X"
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart=_Wed__11_Jul_2007_16_13_02_+0200_j7zEg1COMn/fp53X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jul 2007 11:25:11 +0200
Attila Kinali <attila@kinali.ch> wrote:

> Before i start poking around in mtdram.c and replacing vmalloc
> by get_free_page() calls i wanted to ask whether anyone has done
> something similar already or has a better idea what to do.

Scratch that, doing it myself was faster.
If anyone cares, the patch is attached.

			Attila Kinali

-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred

--Multipart=_Wed__11_Jul_2007_16_13_02_+0200_j7zEg1COMn/fp53X
Content-Type: text/x-diff;
 name="mtdram.diff"
Content-Disposition: attachment;
 filename="mtdram.diff"
Content-Transfer-Encoding: 7bit

--- drivers/mtd/devices/mtdram.c.orig	2007-07-11 11:46:39.000000000 +0200
+++ drivers/mtd/devices/mtdram.c	2007-07-11 15:53:16.000000000 +0200
@@ -35,62 +35,118 @@
 
 static int ram_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
+	size_t erased = 0;
+	int page;
+	void ** table = mtd->priv;
+
 	if (instr->addr + instr->len > mtd->size)
 		return -EINVAL;
 
-	memset((char *)mtd->priv + instr->addr, 0xff, instr->len);
+	page = instr->addr / PAGE_SIZE;
 
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
+	while(erased < instr->len) {
+		loff_t ofs = (instr->addr + erased) % PAGE_SIZE;
+		int to_erase = instr->len - erased;
+		
+		if(to_erase > PAGE_SIZE - ofs)
+			to_erase = PAGE_SIZE - ofs;
 
-	return 0;
-}
+		memset(table[page] + ofs, 0xff, to_erase);
 
-static int ram_point(struct mtd_info *mtd, loff_t from, size_t len,
-		size_t *retlen, u_char **mtdbuf)
-{
-	if (from + len > mtd->size)
-		return -EINVAL;
+		erased += to_erase;
+		page++;
+	}
+
+	instr->state = MTD_ERASE_DONE;
+	mtd_erase_callback(instr);
 
-	*mtdbuf = mtd->priv + from;
-	*retlen = len;
 	return 0;
 }
 
-static void ram_unpoint(struct mtd_info *mtd, u_char * addr, loff_t from,
-		size_t len)
-{
-}
 
 static int ram_read(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
+	size_t copied = 0;
+	int page;
+	void ** table = mtd->priv;
+
 	if (from + len > mtd->size)
 		return -EINVAL;
 
-	memcpy(buf, mtd->priv + from, len);
+	page = from / PAGE_SIZE;
+
+	/* mtdblock relies on receiving all data
+	 * at once. so we have to take care of
+	 * copying everything
+	 */
+	while(copied < len) {
+		loff_t ofs = (from + copied) % PAGE_SIZE;
+		int to_copy = len - copied;
+		
+		if(to_copy > PAGE_SIZE - ofs)
+			to_copy = PAGE_SIZE - ofs;
+
+		memcpy(buf + copied, table[page] + ofs, to_copy);
 
-	*retlen = len;
+		copied += to_copy;
+		page++;
+	}
+
+	*retlen = copied;
 	return 0;
 }
 
 static int ram_write(struct mtd_info *mtd, loff_t to, size_t len,
 		size_t *retlen, const u_char *buf)
 {
+	size_t copied = 0;
+	int page;
+	void ** table = mtd->priv;
+
 	if (to + len > mtd->size)
 		return -EINVAL;
 
-	memcpy((char *)mtd->priv + to, buf, len);
+	page = to / PAGE_SIZE;
+
+	/* mtdblock relies on sending all data
+	 * at once. so we have to take care of
+	 * copying everything
+	 */
+	while(copied < len) {
+		loff_t ofs = (to + copied) % PAGE_SIZE;
+		int to_copy = len - copied;
+		
+		if(to_copy > PAGE_SIZE - ofs)
+			to_copy = PAGE_SIZE - ofs;
 
-	*retlen = len;
+		memcpy(table[page] + ofs, buf + copied, to_copy);
+
+		copied += to_copy;
+		page++;
+	}
+
+	*retlen = copied;
 	return 0;
 }
 
 static void __exit cleanup_mtdram(void)
 {
+	void ** table;
+	int i, table_size;
+
 	if (mtd_info) {
+		table = mtd_info->priv;
+		if(table) {
+			table_size = mtd_info->size / PAGE_SIZE;
+			if(mtd_info->size % PAGE_SIZE)
+				table_size++;
+			for(i=0; i < table_size; i++) 
+				free_page((unsigned long)table[i]);
+			kfree(table);
+			table = NULL;
+		}
 		del_mtd_device(mtd_info);
-		vfree(mtd_info->priv);
 		kfree(mtd_info);
 	}
 }
@@ -111,8 +167,8 @@
 
 	mtd->owner = THIS_MODULE;
 	mtd->erase = ram_erase;
-	mtd->point = ram_point;
-	mtd->unpoint = ram_unpoint;
+	mtd->point = NULL;
+	mtd->unpoint = NULL;
 	mtd->read = ram_read;
 	mtd->write = ram_write;
 
@@ -125,8 +181,10 @@
 
 static int __init init_mtdram(void)
 {
-	void *addr;
-	int err;
+	void **addr=NULL;
+	int err = 0;
+	int i = 0;
+	int table_size;
 
 	if (!total_size)
 		return -EINVAL;
@@ -136,20 +194,45 @@
 	if (!mtd_info)
 		return -ENOMEM;
 
-	addr = vmalloc(MTDRAM_TOTAL_SIZE);
+	table_size = MTDRAM_TOTAL_SIZE / PAGE_SIZE;
+	if(MTDRAM_TOTAL_SIZE % PAGE_SIZE)
+		table_size++;
+
+	addr = kmalloc(table_size * sizeof(void*), GFP_KERNEL);
 	if (!addr) {
 		kfree(mtd_info);
 		mtd_info = NULL;
 		return -ENOMEM;
 	}
+
+	memset(addr, 0, table_size * sizeof(void*));
+
+	for(i = 0; i < table_size; i++) {
+		addr[i] = (void*) __get_free_page(GFP_KERNEL);
+		if(!addr[i]) {
+			err = -ENOMEM;
+			break;
+		}
+		memset(addr[i], 0xff, PAGE_SIZE);
+	}
+
+
 	err = mtdram_init_device(mtd_info, addr, MTDRAM_TOTAL_SIZE, "mtdram test device");
+
 	if (err) {
-		vfree(addr);
+		if(addr) {
+			/* use i as a counter how many pages 
+			 * have been allocated */
+			for(--i; i >= 0; i--) 
+				free_page((unsigned long) addr[i]);
+			kfree(addr);
+			addr = NULL;
+		}
 		kfree(mtd_info);
 		mtd_info = NULL;
 		return err;
 	}
-	memset(mtd_info->priv, 0xff, MTDRAM_TOTAL_SIZE);
+
 	return err;
 }
 

--Multipart=_Wed__11_Jul_2007_16_13_02_+0200_j7zEg1COMn/fp53X--
