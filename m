Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 22:59:27 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33798 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012255AbcBMV6dmf3Ki (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:33 +0100
Received: by mail-lf0-f67.google.com with SMTP id 78so5751887lfy.1;
        Sat, 13 Feb 2016 13:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bT+psSZ3OM+firbWVWXMPjvTAcouNggaBZLor6j88/Y=;
        b=Tsi6VxuqaY6gxUOQICK8MRuuP2tmCBhYIIy+txIZE3Gbibo0cCIiIUF0/+yixAYYbw
         PNTYM0Rrbvb9eqyu+Xf1mYEI/E6PKBBamrvzRPttpqklj6otdy++gLpmLjhjrWpwDVd9
         T7WGzvCUcrbeImqF8r26H5fnbOpnx9D3vjRaOEFGFOnbV/M+KRG7sV3t7fQmsX24A8ZN
         KZtehgSdlT8zUK+ZdJKeaJ+WrET9TD0RAluGDEQzAC6YpQqw+P5rwkNM6Sm0B+t079UX
         hxhReYULYWhNPtLrA3iqJLIDgM9WE/uHheZXBbJCkDgGmC8enyUiE8Q7TG2cOcosaPV1
         RDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bT+psSZ3OM+firbWVWXMPjvTAcouNggaBZLor6j88/Y=;
        b=VmBFFOFqEzIfZzn2ByHPKsq/YV3XBeCV6YnnvBNJ33Zw8yUzE0TeUEtCbnVLJVfTcE
         IctzAlW8rAWgV17D1YhvZmxJS2WYRH0wGeS/DEfAMBsR+t4M3j/uftWADLjl1xt6HhV7
         yv84SQzo7/pyqzGbg5bLtt+XwqNELoJKPofV6ss1j9NU5eXkmiz6EPIC/EV6LyuTw3wM
         OzyoeNMvfHxjab4OVGu6KgmKEtGWGFgFYovbcNiVZlVpgHkzw0Rvlkp+WabbOLSGMRlv
         c83AVVmvyXOQU8j9VflW+O18AA3cd23mll/HYYH1rEakm8amKjd9iLD1DV3dgZVsI90i
         ObjQ==
X-Gm-Message-State: AG10YOToySfhig8Sj2WW5MyGipGjPCyLNW8CjAqgOb7QsF+J/xT82E68ayUI06yQaaJ24g==
X-Received: by 10.25.37.136 with SMTP id l130mr3114114lfl.60.1455400708472;
        Sat, 13 Feb 2016 13:58:28 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:27 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>
Subject: [PATCH 03/10] MIPS: ath79: Fix the ar724x clock calculation
Date:   Sun, 14 Feb 2016 00:58:10 +0300
Message-Id: <1455400697-29898-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52035
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
