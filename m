Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:37:12 +0100 (CET)
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36280 "EHLO
        mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007072AbcCQDeuJjbTp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:50 +0100
Received: by mail-lb0-f196.google.com with SMTP id sa3so4245203lbb.3
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N52EEtju0G8gVNPbAEONMFfms3RGrdCMdywFfBd0UhI=;
        b=BXGJZXOEp+kNotiQ4ZE2pL6irvCO85DAV4YEEA1p/oY1ZowrAYM4J6rhIOtOH8pFVQ
         03L26EGy6TaYvR7YCKiI98RB+2Akk+VDOwmmGXd5kKFL4QjcrUl9XkcrIXaHK1wT8F9Z
         lVlOvy38JXMCf+IpNIvUwFUzaoTU8LmPYYIn73sIrsEYb+pWoROT/XKxO4Dd6CR2TGTZ
         xUIZFVQA9agIRnFc2Ufku/qqxsujqpsqnkQ44PN8WEAcLPw0CuDSskJUsumi1FzXrzQW
         cG2++XUYMDqDWQfsfxXm+AC6CqwxqoWsbEVHWT4mXpPDrOKJlglhauI8QDCtDLFQ8mz+
         2pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N52EEtju0G8gVNPbAEONMFfms3RGrdCMdywFfBd0UhI=;
        b=H/ZWM4ER7c9REGzLLYv1dbEKKFJ7PIc1XVRFgZBQljAOGuqwSvHIoHYFX4nUO1p+8K
         0WPI8AANjXMfN9R4H0R3vUKS3IXgr78hvycy0xkiksR2WLqCKZhO0G7DyM+YrNiKR07+
         cDLlaKeSvMvNbzyDzHj9voitW95wGCXgZgTjf9Sh7zFG0pHSXb5FIlrXqYqP6pOoaMww
         Frh0NsMU/VqiaCNTr0rO8uznh8hwaY+PXZHXKdBzDqpExtuoRVwHgZFbFLrvwnkfKfr+
         oCXlg70lie2s1GIctTAUB5xUht1PAXDxvAjd/63nkLaB5pv0Ov2VzPT1bZLyp/4qAWGx
         OaqQ==
X-Gm-Message-State: AD7BkJK9jf0x2/oizPZ/QR4TATOPjdyGSl6Fx3QlllsrsMmTgS52Qp2Vm6QLq4whsQR89Q==
X-Received: by 10.112.29.4 with SMTP id f4mr2656696lbh.92.1458185684916;
        Wed, 16 Mar 2016 20:34:44 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:44 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 09/18] MIPS: ath79: setup.c: disable platform code for OF boards
Date:   Thu, 17 Mar 2016 06:34:16 +0300
Message-Id: <1458185665-4521-10-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52623
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
Reviewed-by: Marek Vasut <marex@denx.de>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ath79/setup.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 61e3a59..4d02ab5 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -207,15 +207,16 @@ void __init plat_mem_setup(void)
 	else if (fw_arg0 == -2)
 		__dt_setup_arch((void *)fw_arg1);
 
-	ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
-					   AR71XX_RESET_SIZE);
-	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
-					 AR71XX_PLL_SIZE);
-	ath79_detect_sys_type();
-	ath79_ddr_ctrl_init();
+	if (mips_machtype != ATH79_MACH_GENERIC_OF) {
+		ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
+						   AR71XX_RESET_SIZE);
+		ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
+						 AR71XX_PLL_SIZE);
+		ath79_detect_sys_type();
+		ath79_ddr_ctrl_init();
 
-	if (mips_machtype != ATH79_MACH_GENERIC_OF)
 		detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
+	}
 
 	_machine_restart = ath79_restart;
 	_machine_halt = ath79_halt;
-- 
2.7.0
