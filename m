Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2008 00:19:39 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:14814 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S23779283AbYKTATY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2008 00:19:24 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 60605C808B;
	Thu, 20 Nov 2008 02:19:17 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 6xTT5h+bnE-G; Thu, 20 Nov 2008 02:19:17 +0200 (EET)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 45539C8084;
	Thu, 20 Nov 2008 02:19:17 +0200 (EET)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 2F8A3B4020; Thu, 20 Nov 2008 02:19:16 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com
Cc:	linux-mips@linux-mips.org,
	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Subject: [PATCH] SCSI: fix the return type of the remove() method in sgiwd93.c
Date:	Thu, 20 Nov 2008 02:19:17 +0200
Message-Id: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

This patch fixes the following compilation warning:

  CC [M]  drivers/scsi/sgiwd93.o
drivers/scsi/sgiwd93.c:314: warning: initialization from incompatible
pointer type

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 drivers/scsi/sgiwd93.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
index 31fe605..672a521 100644
--- a/drivers/scsi/sgiwd93.c
+++ b/drivers/scsi/sgiwd93.c
@@ -297,7 +297,7 @@ out:
 	return err;
 }
 
-static void __exit sgiwd93_remove(struct platform_device *pdev)
+static int __exit sgiwd93_remove(struct platform_device *pdev)
 {
 	struct Scsi_Host *host = platform_get_drvdata(pdev);
 	struct ip22_hostdata *hdata = (struct ip22_hostdata *) host->hostdata;
@@ -307,6 +307,8 @@ static void __exit sgiwd93_remove(struct platform_device *pdev)
 	free_irq(pd->irq, host);
 	dma_free_noncoherent(&pdev->dev, HPC_DMA_SIZE, hdata->cpu, hdata->dma);
 	scsi_host_put(host);
+
+	return 0;
 }
 
 static struct platform_driver sgiwd93_driver = {
-- 
1.5.4.3
