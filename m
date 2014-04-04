Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 16:33:54 +0200 (CEST)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:52811 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822276AbaDDOdeTm2mR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 16:33:34 +0200
Received: by mail-wg0-f45.google.com with SMTP id l18so3530672wgh.4
        for <linux-mips@linux-mips.org>; Fri, 04 Apr 2014 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3sJyhoUCbMGHOLPMgq3QU1Vkf+iw7iDPpQDE+YV2ZZE=;
        b=cr9XMHMHP3QdLvLGcu+vEqkvMZHmolO9O4lkjQdwBxMC94471+nC5D/YSDdboPgVN8
         NWOh7sMUIPG70mAHLZPuo6+e4p9CSq7456CIKSoayIkdyLYHjGsx0rZvuyRaaop2Mf6R
         XQEoVUN49BNc6qr73unDiaixjXsqZmQlq7kMWw+EXDwqogpSbSPvI5jBDdq09HASiKWe
         WKrew7oCMvFnohTZOFBTK1JTeTLkqv0AW8RFGTs7ks0Yd+WK+n2vpjpVUqKJek7LZW3J
         395r61GXPhxRGDNUWnGPLz5aazGteueGYx+IfuEQq2jqyQsIAc0mAoP74SsJy/7qMQs5
         S/aQ==
X-Received: by 10.180.76.142 with SMTP id k14mr5019582wiw.21.1396622009014;
        Fri, 04 Apr 2014 07:33:29 -0700 (PDT)
Received: from localhost.localdomain (p57A35AD1.dip0.t-ipconnect.de. [87.163.90.209])
        by mx.google.com with ESMTPSA id x45sm19945862eef.15.2014.04.04.07.33.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Apr 2014 07:33:28 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: devboards: sit and spin after poweroff
Date:   Fri,  4 Apr 2014 16:33:24 +0200
Message-Id: <1396622004-157911-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396622004-157911-1-git-send-email-manuel.lauss@gmail.com>
References: <1396622004-157911-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

earlier boards don't implement the poweroff bit in CPLD, instead let the cpu
spin in the wait function.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index 8df86eb..be139a0 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -11,6 +11,7 @@
 #include <linux/pm.h>
 
 #include <asm/bootinfo.h>
+#include <asm/idle.h>
 #include <asm/reboot.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
@@ -53,6 +54,8 @@ static void db1x_power_off(void)
 {
 	bcsr_write(BCSR_RESETS, 0);
 	bcsr_write(BCSR_SYSTEM, BCSR_SYSTEM_PWROFF | BCSR_SYSTEM_RESET);
+	while (1)		/* sit and spin */
+		cpu_wait();
 }
 
 static void db1x_reset(char *c)
-- 
1.9.1
