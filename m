Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2009 20:52:05 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:58674 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492947AbZGTSve (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Jul 2009 20:51:34 +0200
Received: by bwz4 with SMTP id 4so2465681bwz.0
        for <linux-mips@linux-mips.org>; Mon, 20 Jul 2009 11:51:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LsTyHMB2IsolIPCvy37hM1wjGxY6kIdQnbBAeercqYU=;
        b=ajMjxRfMcip4bA29UND66njmnGHe7EVY1I6jvUsP8zdIC8S/udFZ/VMljFoTLqgcTE
         zjOFfZALlumQsXKAnW7X5k9vCu2/YyFMwxubhclS+5FPi8VehvsUBBbOtUhH+2Xmni+j
         cb6atbO7KnsHBlWjUlqTqKLIaGkDh2OwruJXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x8lz3wM363mS2wPUDd9Pb2Cjm0BO0HY6a7nqar6/G2GFzn+ElHOSiSd90C156YZ6kb
         BL3exAZTQrcrIWVh9ahJtYTxoFbobVd+H04FfUWKpWBBuUomNsmMzp9J8034H5W8gRYZ
         ++3CW4EL57N9T8/m6LKJS+2zb+o8isngX48/c=
Received: by 10.103.241.5 with SMTP id t5mr2340768mur.127.1248115889095;
        Mon, 20 Jul 2009 11:51:29 -0700 (PDT)
Received: from localhost.localdomain (p5496D3B0.dip.t-dialin.net [84.150.211.176])
        by mx.google.com with ESMTPS id j9sm23733035mue.51.2009.07.20.11.51.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 11:51:28 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] au1xmmc: allow platforms to disable certain host capabilities
Date:	Mon, 20 Jul 2009 20:51:22 +0200
Message-Id: <1248115882-20221-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248115882-20221-1-git-send-email-manuel.lauss@gmail.com>
References: <1248115882-20221-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Although the hardware supports a 4/8bit SD interface and the driver
unconditionally advertises all hardware caps to the MMC core, not all
datalines may actually be wired up.  This patch introduces another
field to au1xmmc platform data allowing platforms to disable certain
advanced host controller features.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/au1100_mmc.h |    1 +
 drivers/mmc/host/au1xmmc.c                     |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1100_mmc.h b/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
index c35e209..a674643 100644
--- a/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
+++ b/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
@@ -46,6 +46,7 @@ struct au1xmmc_platform_data {
 	int(*card_readonly)(void *mmc_host);
 	void(*set_power)(void *mmc_host, int state);
 	struct led_classdev *led;
+	unsigned long mask_host_caps;
 };
 
 #define SD0_BASE	0xB0600000
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 70509c9..d50e7ea 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1005,6 +1005,9 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	mmc->ocr_avail = AU1XMMC_OCR;
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
 
+	/* platform may not be able to use 4/8 bit datapath */
+	mmc->caps &= ~(host->platdata->mask_host_caps);
+
 	host->status = HOST_S_IDLE;
 
 	/* board-specific carddetect setup, if any */
-- 
1.6.3.3
