Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:07:27 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46391 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008837AbaLOSGfXt62L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:06:35 +0100
Received: by mail-lb0-f174.google.com with SMTP id 10so9568309lbg.19
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JMT0sZhlnkbTUfJ7ALyCVGVIydQDsRyLZgzcqSiUTkE=;
        b=IWFz5pN4sdHKmZYkjBNlrAHmtf47aSl32KV4gTIlQB7eEyHRBkQPB1cCADdyl73XLu
         ofixr1jYbcGWvmKalltAAaXww0X7pi0KacM1TBfAQ6TxeN6K3/OIoMBeThdt9bWICq83
         TzBCQPk1w4LUStzVpiYuMrUEYQFsbhg6ykmVFeOVOhEU6hayMBDP4REk1tm7soPj8806
         AlIB4wjGM/FJf7h61qukL4E5k5oi3/HFv48/uwpHdiNN4XK13GMotvSskGWREWehZrd0
         Ou2Wdj9Is1pIqZv/XPpsTT4M7Rv8z7ciz18IOL4oKuBrTdzYAITQMv3u+IK6dvA+4Eby
         yByg==
X-Received: by 10.112.101.100 with SMTP id ff4mr31297916lbb.94.1418666790099;
        Mon, 15 Dec 2014 10:06:30 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:29 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 05/14] MIPS: OCTEON: Delete unused COP2 saving code
Date:   Mon, 15 Dec 2014 21:03:11 +0300
Message-Id: <1418666603-15159-6-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Commit 2c952e06e4f5 ("MIPS: Move cop2 save/restore to switch_to()")
removes assembler code to store COP2 registers.  Commit
a36d8225bceb ("MIPS: OCTEON: Enable use of FPU") mistakenly
restores it

Fixes: a36d8225bceb ("MIPS: OCTEON: Enable use of FPU")
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/kernel/octeon_switch.S | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index f0a699d..423ae83 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -52,32 +52,6 @@
 	.set pop
 1:
 
-	/* check if we need to save COP2 registers */
-	LONG_L	t0, ST_OFF(t3)
-	bbit0	t0, 30, 1f
-
-	/* Disable COP2 in the stored process state */
-	li	t1, ST0_CU2
-	xor	t0, t1
-	LONG_S	t0, ST_OFF(t3)
-
-	/* Enable COP2 so we can save it */
-	mfc0	t0, CP0_STATUS
-	or	t0, t1
-	mtc0	t0, CP0_STATUS
-
-	/* Save COP2 */
-	daddu	a0, THREAD_CP2
-	jal octeon_cop2_save
-	dsubu	a0, THREAD_CP2
-
-	/* Disable COP2 now that we are done */
-	mfc0	t0, CP0_STATUS
-	li	t1, ST0_CU2
-	xor	t0, t1
-	mtc0	t0, CP0_STATUS
-
-1:
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	/* Check if we need to store CVMSEG state */
 	dmfc0	t0, $11,7	/* CvmMemCtl */
-- 
2.1.3
