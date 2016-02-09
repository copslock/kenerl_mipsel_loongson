Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:15:36 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36651 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011737AbcBIIOckRSb5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:32 +0100
Received: by mail-lf0-f66.google.com with SMTP id h198so5993002lfh.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xZfcWlFoCJ1UmBmlNpMTe2J/wf1irJEygUpOLmgcukY=;
        b=I20WDUwUYKqzO91VNpIhEmDPNgTR5dPiqW0e7aFdcRFspbWwk287vncsEUjSIQIaZc
         99kh5kQQFmqYfqq/Xa5vC7FMrBh/lPxb699ruaNIWsFgv6icw1A7P2+NCzH2F9y7C0zd
         6oMNcUprCqsngy+/lBrLQas7hWk0uU3jcrL0/edifGWlYJRWhFodRZgpwjQzIvvKt/CD
         In7DH5aH7oy1C5FNS2L+qLepInt72bQzuT/h38n+hdWJx+8m8Dvw3KrIqiiEbKaT3dfr
         LgQF2STtK1uY2VEvLMwSr+7qehkFlDhdEJk9jRSNiGPw0nJMeyPuUpCPiCsiuNxrCR5c
         s1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xZfcWlFoCJ1UmBmlNpMTe2J/wf1irJEygUpOLmgcukY=;
        b=ENVCFFqX4ND1KBfpA8uJhuRcWdQHpaL4e8LNGUM3MtW0duZyYzDtQcWh70Uf466EPI
         vu4DhgLQ7az2q4iLv28NOs5WoYS+LI4aPktlxq1BW+OUGVyftu/GwtNu+l2COxmb8Cbq
         TJU2vS2MbVcpnW5ymJBgmlMeFnkq6HfYN5ZuMHoJQTZ4Z/uG9xp++YCKt3cJA6N6G9kd
         P/o/ruEjE4UXDrsqZIhFSkJOOA8Jh60cjgRPid00mCmFGVr12NFA7t5k4mhZmKgSYnaB
         Rgp7o/RE2ftbjG42kTJuye0ZVHQPu+PE2Z0KAXY22tg05MP1P12JUcaFlJegb8bEpFlX
         wZqw==
X-Gm-Message-State: AG10YOTvGF2JigXDP6pTV3by/uTangV4wN2sLlIf3HPQkwEZ5vPA8q+Z2yzae5ruT6gYUA==
X-Received: by 10.25.23.24 with SMTP id n24mr13609327lfi.66.1455005667426;
        Tue, 09 Feb 2016 00:14:27 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:26 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>
Subject: [RFC v5 04/15] WIP: MIPS: ath79: setup.c: disable platform code for OF boards
Date:   Tue,  9 Feb 2016 11:13:50 +0300
Message-Id: <1455005641-7079-5-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51880
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
index 99ab4bb..d65d161 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -206,15 +206,16 @@ void __init plat_mem_setup(void)
 	else if (fw_arg0 == -2)
 		__dt_setup_arch((void *)fw_arg1);
 
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
