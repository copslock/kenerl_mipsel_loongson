Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2006 13:28:36 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:41732 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133437AbWAVN2P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Jan 2006 13:28:15 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id AAB8764D3D; Sun, 22 Jan 2006 13:32:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 189C78545; Sun, 22 Jan 2006 13:31:47 +0000 (GMT)
Date:	Sun, 22 Jan 2006 13:31:47 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: dec_esp.c needs merging with upstream
Message-ID: <20060122133147.GA23020@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Ralf,

In October 2005, Christoph Hellwig <hch@lst.de> removed the
Scsi_Host_Template typedef (d0be4a7d29ad0bd3ce2209dd9e46d410b632db59).
The converted dec_esp.c is in mainline git already but it seems you
ignored that change when you synced with mainline.  We need the
following patch:


--- a/drivers/scsi/dec_esp.c~	2006-01-22 13:14:35.000000000 +0000
+++ b/drivers/scsi/dec_esp.c	2006-01-22 13:19:03.000000000 +0000
@@ -98,7 +98,7 @@
 static irqreturn_t scsi_dma_err_int(int, void *, struct pt_regs *);
 static irqreturn_t scsi_dma_int(int, void *, struct pt_regs *);
 
-int dec_esp_detect(Scsi_Host_Template * tpnt);
+int dec_esp_detect(struct scsi_host_template * tpnt);
 
 static int dec_esp_release(struct Scsi_Host *shost)
 {
@@ -110,7 +110,7 @@
 	return 0;
 }
 
-static Scsi_Host_Template driver_template = {
+static struct scsi_host_template driver_template = {
 	.proc_name		= "dec_esp",
 	.proc_info		= &esp_proc_info,
 	.name			= "NCR53C94",


See
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;h=3ee68c4af3fd7228c1be63254b9f884614f9ebb2;f=drivers/scsi/dec_esp.c

-- 
Martin Michlmayr
http://www.cyrius.com/
