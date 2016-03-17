Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:35:16 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35607 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006763AbcCQDelO6-wp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:41 +0100
Received: by mail-lf0-f68.google.com with SMTP id e138so2230892lfe.2;
        Wed, 16 Mar 2016 20:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bT+psSZ3OM+firbWVWXMPjvTAcouNggaBZLor6j88/Y=;
        b=WZpd4yLgv5uhwAmQWbZMYpPErXvilS6KlW4rWiVM37gsudcEqVxoU2HTqNXXDIbeQG
         UdG5SfoMDgvSQC697W/I/790v+0UyXnvCir4GU6xiTOBYY/ip5Whu2eTK9TTMDytjT+S
         wvqzCMZpZEwrw9TfcCRViTh9QAVerY9x47TIVd421TrmkVjLFAJGrrPyxLeqLkX6jnpo
         qNZ4iv8srK+SOX9j10vdwPCiCRD9p6QLcAKyJXdRzLJTRSm353uc/Fxgpu8Sd92ZMWsK
         mpC1xWl/1x3J2GzNSVW1XLTx6DiYOw+iGox62YtHbH0B9v6AzR58hpxJp2jirBGwmbjA
         M/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bT+psSZ3OM+firbWVWXMPjvTAcouNggaBZLor6j88/Y=;
        b=V+g5PzoSFaeADGy5e5NL8llrePlynSFfSdgiDQeRVjaT0sVDwW9oGavUYqMin2OSk9
         ufskx5u2EXQRqAqYg+Yw83H2aCS9CcBNkN9oTPJfVRv9QTp+3PqCvLpq/gHdllyDupFw
         xiZderTnorcBRBy3DSlzIICaO0sYor7XNxbTFiuDqLDTfNexvMiXAmBfY/zkKXMG/BZi
         IlSV7jnHJx96KjPM7igMeV/davSnzmLowBpX1Uu6I4CInZUUsEER0ukUEpEJZQugEqYr
         893DudixdKquxz7F1NgMABl5vGQKOIsA/8CvVwChW+4LQB8D3Z1YsrBh2deLGREbdWB+
         WKKw==
X-Gm-Message-State: AD7BkJJzAs8JKLWztZXBlsM3BBh6BQPWo7vZCf+RntiyXbWbBUnhfeDhevScQUkBoqoFPA==
X-Received: by 10.25.24.71 with SMTP id o68mr2755689lfi.153.1458185675962;
        Wed, 16 Mar 2016 20:34:35 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:35 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Weijie Gao <hackpascal@gmail.com>, Alban Bedel <albeu@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 02/18] MIPS: ath79: Fix the ar724x clock calculation
Date:   Thu, 17 Mar 2016 06:34:09 +0300
Message-Id: <1458185665-4521-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

From: Weijie Gao <hackpascal@gmail.com>

According to the AR7242 datasheet section 2.8, AR724X CPUs use a 40MHz
input clock as the REF_CLK instead of 5MHz.

The correct CPU PLL calculation procedure is as follows:
CPU_PLL = (FB * REF_CLK) / REF_DIV / 2.

This patch is compatible with the current calculation procedure with
default FB and REF_DIV values.

Tested on AR7240, AR7241 and AR7242.

Signed-off-by: Weijie Gao <hackpascal@gmail.com>
Signed-off-by: Alban Bedel <albeu@free.fr>
[albeu@free.fr: Fixed the commit log message]
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ath79/clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index eb5117c..ed28465 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -26,7 +26,7 @@
 #include "common.h"
 
 #define AR71XX_BASE_FREQ	40000000
-#define AR724X_BASE_FREQ	5000000
+#define AR724X_BASE_FREQ	40000000
 #define AR913X_BASE_FREQ	5000000
 
 static struct clk *clks[3];
@@ -103,8 +103,8 @@ static void __init ar724x_clocks_init(void)
 	div = ((pll >> AR724X_PLL_FB_SHIFT) & AR724X_PLL_FB_MASK);
 	freq = div * ref_rate;
 
-	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK);
-	freq *= div;
+	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK) * 2;
+	freq /= div;
 
 	cpu_rate = freq;
 
-- 
2.7.0
