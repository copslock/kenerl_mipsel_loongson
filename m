Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:11:49 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33585 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011929AbcBAAK4rl2vA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:10:56 +0100
Received: by mail-lf0-f52.google.com with SMTP id m1so10787572lfg.0
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RR6JF4DtAdlfUpHIPp56QY7pFXyDt3YIRTEI7p7XGI8=;
        b=gFvf5gf0T/3oy6o53W3xId8camBiNDFP1LNjpcxvHecl4PHjAejVjU2H0CEuVy8ZN6
         CwUSDNBFwZzjdJk+pdbl35pWvHfI6uUjFZDB1xyO2K2wqX8SwV758/37Af6ojh4op1e7
         XCdlJ1/LOlhgIbWd7DW3Gd8k/hcPzWWd2q3wqo4f09GJ6nzE3nZcF9OfzS0TJLuvahtR
         jJx/k2YEtMuQrGp2ga5CGsXKNygFvoi0p1H3Rr2RA2pJrHzLy4/PwEtXaTukHjXcdUFN
         1jXsZf+3JaZtGh+7CUv1A6Fw0OxyOimKuSqZGnZ1begYk+Jo/i5gWJHBUFxNO50WBLS+
         kqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RR6JF4DtAdlfUpHIPp56QY7pFXyDt3YIRTEI7p7XGI8=;
        b=TEwxflWZDkrT+ES/GQ3eyUIVfKDv2gpjnsNHkzhYzwn89Hggk7CJj94xBa7myv/CXt
         FZtfqtPY0xvr2Mh5+eEByjn9rlkMrHTFoyEVqkWFLT84raWCnLTcPm254BNFgv9f8j9M
         AYBbQOUcIBPe99+vwEsfNWYPmUmaA7sjyM7E8agyaLSeVj2oRp7/J7RxfnnDcKU+4qi7
         am+S3LiBxKkrl5CCeQzW2+NB+tttyGGrZ+8DunhQUTvg3MEtBAhzfvBWvlCu3Cy+D3R9
         zogywbYeiZP+ffjZ6+Cf27dzaS26jr2NlU6bsD+EyPC/0jOJ3vxtDk3c8S48WA6PmyVD
         H0cg==
X-Gm-Message-State: AG10YOQfblfsoPbpF4NRCn7rQAxqc8GIj6jlUJP+ysdq+lrCBUDFyL4PnSru/bhY7TK5Fw==
X-Received: by 10.25.142.213 with SMTP id q204mr7149858lfd.46.1454285451552;
        Sun, 31 Jan 2016 16:10:51 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:51 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>
Subject: [RFC v4 03/15] WIP: MIPS: ath79: setup.c: disable platform code for OF boards
Date:   Mon,  1 Feb 2016 03:10:28 +0300
Message-Id: <1454285440-18916-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51564
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

For OF boards we have to skip platform initialization code
so we can prove that OF code do all necessary initialization.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ath79/setup.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index be451ee4a..2b31018 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -208,15 +208,16 @@ void __init plat_mem_setup(void)
 		__dt_setup_arch(__dtb_start);
 #endif
 
-	ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
-					   AR71XX_RESET_SIZE);
-	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
-					 AR71XX_PLL_SIZE);
-	ath79_detect_sys_type();
-	ath79_ddr_ctrl_init();
-
-	if (mips_machtype != ATH79_MACH_GENERIC_OF)
+	if (mips_machtype != ATH79_MACH_GENERIC_OF) {
+		ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
+						   AR71XX_RESET_SIZE);
+		ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
+						 AR71XX_PLL_SIZE);
+		ath79_detect_sys_type();
+		ath79_ddr_ctrl_init();
+
 		detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
+	}
 
 	_machine_restart = ath79_restart;
 	_machine_halt = ath79_halt;
-- 
2.7.0
