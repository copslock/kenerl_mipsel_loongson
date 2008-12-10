Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 23:40:28 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:45899 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207735AbYLJXjy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Dec 2008 23:39:54 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494053400002>; Wed, 10 Dec 2008 18:39:44 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 15:39:24 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 15:39:24 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBANdJb1012351;
	Wed, 10 Dec 2008 15:39:19 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBANdJkE012350;
	Wed, 10 Dec 2008 15:39:19 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-ide@vger.kernel.org
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] libata: Add special ata_pio_need_iordy() handling for Compact Flash.
Date:	Wed, 10 Dec 2008 15:39:12 -0800
Message-Id: <1228952353-12323-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <494052D1.10208@caviumnetworks.com>
References: <494052D1.10208@caviumnetworks.com>
X-OriginalArrivalTime: 10 Dec 2008 23:39:24.0066 (UTC) FILETIME=[884DF020:01C95B20]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21576
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
index 1be2dde..b4a35d8 100644
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
