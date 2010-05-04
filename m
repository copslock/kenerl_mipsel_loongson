Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:58:22 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:46335 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492378Ab0EDJzb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:31 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119707qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.99.210 with SMTP id v18mr4165631qan.87.1272966931111; Tue, 
        04 May 2010 02:55:31 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:31 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:31 +0800
Message-ID: <q2u180e2c241005040255n628614a0p828116a04f65a894@mail.gmail.com>
Subject: [PATCH 8/12] gdium uses different freq of mclk&m1xclk of sm501
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com
Cc:     vince@simtec.co.uk, ben@simtec.co.uk
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Gdium uses different freq of mclk&m1xclk of sm501. This seems a dirty
hack. Maybe we need a configuration option for changing the freq of
these clocks.

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 drivers/mfd/sm501.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index ce5dfce..5e55cbd 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1606,10 +1606,15 @@ static struct sm501_initdata sm501_pci_initdata = {
 	.devices	= SM501_USE_ALL,

 	/* Errata AB-3 says that 72MHz is the fastest available
-	 * for 33MHZ PCI with proper bus-mastering operation */
-
+	 * for 33MHZ PCI with proper bus-mastering operation
+	 * For gdium, it works under 84&112M clock freq.*/
+#ifdef CONFIG_DEXXON_GDIUM
+	.mclk		= 84 * MHZ,
+	.m1xclk		= 112 * MHZ,
+#else
 	.mclk		= 72 * MHZ,
 	.m1xclk		= 144 * MHZ,
+#endif
 };

 static struct sm501_platdata_fbsub sm501_pdata_fbsub = {
-- 
1.5.6.5
