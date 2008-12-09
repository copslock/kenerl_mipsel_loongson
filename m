Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2008 01:44:04 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:25680 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207532AbYLIBng (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Dec 2008 01:43:36 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493dcd30000b>; Mon, 08 Dec 2008 20:43:12 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 17:40:03 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 17:40:03 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB91e0Ka020396;
	Mon, 8 Dec 2008 17:40:01 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB91e0Vx020395;
	Mon, 8 Dec 2008 17:40:00 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-ide@vger.kernel.org
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] libata: Add special ata_pio_need_iordy() handling for Compact Flash.
Date:	Mon,  8 Dec 2008 17:39:57 -0800
Message-Id: <1228786798-20369-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <493DCBEA.9090007@caviumnetworks.com>
References: <493DCBEA.9090007@caviumnetworks.com>
X-OriginalArrivalTime: 09 Dec 2008 01:40:03.0632 (UTC) FILETIME=[0E988B00:01C9599F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

According to the Compact Flash specification r4.1, PIO modes 5 and 6
do not use iordy.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/ata/libata-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b156d83..febdcb7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1923,6 +1923,10 @@ unsigned int ata_pio_need_iordy(const struct ata_device *adev)
 	   as the caller should know this */
 	if (adev->link->ap->flags & ATA_FLAG_NO_IORDY)
 		return 0;
+	/* CF spec. r4.1 Table 22 says no iordy on PIO5 and PIO6.  */
+	if (ata_id_is_cfa(adev->id)
+	    && (adev->pio_mode == XFER_PIO_5 || adev->pio_mode == XFER_PIO_6))
+		return 0;
 	/* PIO3 and higher it is mandatory */
 	if (adev->pio_mode > XFER_PIO_2)
 		return 1;
-- 
1.5.6.5
