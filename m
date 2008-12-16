Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Dec 2008 13:04:56 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:13197 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S24207395AbYLPNEv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Dec 2008 13:04:51 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 75292C8073;
	Tue, 16 Dec 2008 15:04:45 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 6WQRvbEv2VbX; Tue, 16 Dec 2008 15:04:45 +0200 (EET)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 53627C8012;
	Tue, 16 Dec 2008 15:04:45 +0200 (EET)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 12A64B4018; Tue, 16 Dec 2008 15:04:44 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com
Cc:	linux-mips@linux-mips.org,
	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Subject: [PATCH RESEND] [SCSI] Fix compilation warning in sgiwd93.c
Date:	Tue, 16 Dec 2008 15:04:44 +0200
Message-Id: <1229432684-20444-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The remove() callback in platform drivers should return int in
accordance to the definition of the platform_driver structure.
However, the SGI-specific WD93 SCSI controller driver defines
the callback as a void function, which causes the following
compilation warning:

drivers/scsi/sgiwd93.c:314: warning: initialization from
incompatible pointer type

This patch fixes the warning by changing the return type of
the remove() callback to what the core driver code requires.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 drivers/scsi/sgiwd93.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
index 31fe605..0807b26 100644
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
@@ -307,6 +307,7 @@ static void __exit sgiwd93_remove(struct platform_device *pdev)
 	free_irq(pd->irq, host);
 	dma_free_noncoherent(&pdev->dev, HPC_DMA_SIZE, hdata->cpu, hdata->dma);
 	scsi_host_put(host);
+	return 0;
 }
 
 static struct platform_driver sgiwd93_driver = {
-- 
1.5.4.3
