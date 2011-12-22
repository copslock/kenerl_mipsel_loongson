Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2011 18:18:40 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:32931 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903644Ab1LVRSg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Dec 2011 18:18:36 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pBMHIZv7016910;
        Thu, 22 Dec 2011 17:18:35 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pBMHIXAO016903;
        Thu, 22 Dec 2011 17:18:33 GMT
Date:   Thu, 22 Dec 2011 17:18:33 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "James E.J. Bottomley" <JBottomley@parallels.com>
Cc:     linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] SCSI: Change size of factor from u64 to unsigned int.
Message-ID: <20111222171833.GA16435@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18217

Struct scsi_device.sector_size is unsigned int, so the value of factor
can have at most 23 significant bits.

Adding a type check to do_div() caught these two do_div as the only
invocations in the kernel passing a non-32-bit divisor.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-scsi@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/scsi/sd.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index fa3a591..42a1ff6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1335,8 +1335,7 @@ static unsigned int sd_completed_bytes(struct scsi_cmnd *scmd)
 		start_lba <<= 1;
 		end_lba <<= 1;
 	} else {
-		/* be careful ... don't want any overflows */
-		u64 factor = scmd->device->sector_size / 512;
+		unsigned int factor = scmd->device->sector_size / 512;
 		do_div(start_lba, factor);
 		do_div(end_lba, factor);
 	}
