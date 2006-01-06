Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 16:35:09 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:9654 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133585AbWAFQer (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2006 16:34:47 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k06GY0Ar000480;
	Fri, 6 Jan 2006 08:36:31 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 06 Jan 2006 08:36:21 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k06GaLVP007358; Fri, 6
 Jan 2006 08:36:21 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id C5CD9202D; Fri, 6 Jan 2006
 09:36:20 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k06Gi9Yc016061; Fri, 6 Jan 2006 09:44:09
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k06Gi6Wn016060; Fri, 6 Jan 2006 09:44:06 -0700
Date:	Fri, 6 Jan 2006 09:44:06 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org, rmk+lkml@arm.linux.org.uk,
	drzeus@drzeus.cx
Subject: [PATCH]  Force MMC/SD to 512 byte block sizes
Message-ID: <20060106164406.GA15617@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FA0430F2C42669973-01-01
Content-Type: multipart/mixed;
 boundary=45Z9DzgjV8m4Oswq
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--45Z9DzgjV8m4Oswq
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch is not specific to the AU1200 SD driver, but thats what
we used to debug and verify this, so thats why it is applied against
the linux-mips tree.   Pierre, I'm sending this to you too, because I thought
you may be interested.

Large SD cards (>=2GB) report a physical block size greater then 512 bytes
(2GB reports 1024, and 4GB reports 2048).  However, a sample of different 
brands of USB attached SD readers have shown that the logical block size 
is still forced to 512 bytes.

The original mmc_block code was setting the block size to whatever the
card was reporting, thereby causing much pain and suffering when using
a card initialized elsewhere (bad partition tables, invalid FAT tables, etc).

This patch forces the block size to be 512 bytes, and adjusts the 
capacity accordingly.   With this you should be able to happily use very
large cards interchangeably between platforms.  At least, it has worked for
us.

Comments welcome,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--45Z9DzgjV8m4Oswq
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: attachment;
 filename=mmc_fix.patch
Content-Transfer-Encoding: 7bit

PATCH: Force MMC/SD to 512 byte block sizes.

Angry customers and investigation into USB attached MMC/SD
readers have lead us to believe that the SD device block size should
be fixed at 512 bytes regardless of the block size reported by the card.
This comes into play with >2G cards.  After applying this fix, filesystems
written with a USB card reader can be read by the MMC subsystem and 
vice-versa.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/mmc/mmc_block.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index d91fcf7..96fa121 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -303,6 +303,7 @@ static struct mmc_blk_data *mmc_blk_allo
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
+	unsigned long cap;
 
 	devidx = find_first_zero_bit(dev_use, MMC_NUM_MINORS);
 	if (devidx >= MMC_NUM_MINORS)
@@ -356,10 +357,19 @@ static struct mmc_blk_data *mmc_blk_allo
 		sprintf(md->disk->disk_name, "mmcblk%d", devidx);
 		sprintf(md->disk->devfs_name, "mmc/blk%d", devidx);
 
-		md->block_bits = card->csd.read_blkbits;
+		if (card->csd.read_blkbits > 9) {
+			md->block_bits = 9;
+
+			cap = card->csd.capacity <<
+				(card->csd.read_blkbits - 9);
+		}
+		else {
+			md->block_bits = card->csd.read_blkbits;
+			cap = card->csd.capacity;
+		}
 
 		blk_queue_hardsect_size(md->queue.queue, 1 << md->block_bits);
-		set_capacity(md->disk, card->csd.capacity);
+		set_capacity(md->disk, cap);
 	}
  out:
 	return md;
@@ -373,7 +383,7 @@ mmc_blk_set_blksize(struct mmc_blk_data 
 
 	mmc_card_claim_host(card);
 	cmd.opcode = MMC_SET_BLOCKLEN;
-	cmd.arg = 1 << card->csd.read_blkbits;
+	cmd.arg = 1 << ((card->csd.read_blkbits > 9) ? 9 : card->csd.read_blkbits);
 	cmd.flags = MMC_RSP_R1;
 	err = mmc_wait_for_cmd(card->host, &cmd, 5);
 	mmc_card_release_host(card);

--45Z9DzgjV8m4Oswq--
