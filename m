Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 23:01:13 +0100 (CET)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36275 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012341AbcBMV6kUrRoi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:40 +0100
Received: by mail-lb0-f194.google.com with SMTP id zr1so4957276lbb.3;
        Sat, 13 Feb 2016 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gmcHFJhJj4v2K7szJgcDQd4hvIxKvMCEuHBA9nKw614=;
        b=E4Pg2J3roDf3EWPuip/L+sHy3XA4rvg4LxECr079zVdIt1jf0SyxSi7u+6sD+C9XZI
         mv9Z/QfEfCleQKD/EIc/wK/lXJCU7AiB19YWUmSPPfuDyWHBhXMmOI3JYnV26e1QXxdo
         Lvi7nvpYCGRfN71HaSmdfYKHKlxKGo9nDWxGs3066YEiQGXebTyrUQSoFMdMNayeYbKX
         W0ADRg+0GUwUYkdB4+tLzKlX6p+GS2G3XrUwXmtxuav7uYhi+QmGb0IJSOymyUI8bszb
         aUeIF6eQhhxCB9wOIXjpT9vVUs7d/8wyOk2RRdfjF6K9p4M8h1ur2Z1bJojbm7thwZxm
         Le6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gmcHFJhJj4v2K7szJgcDQd4hvIxKvMCEuHBA9nKw614=;
        b=jwo+n7iFfRsJimyiUCivjJLzrx0bEdAkIDP21Z7I0SPMhcMnN6O6kk10w5rUDlWQ/E
         etdm6xIOJZUKh9MEnklN4qB598ZC0O+WIQUjIKsF8nx3N2Nf6kTGruDETpkZBuTDkRfp
         D8yR8nYEHBYDlrfBpZJhQkN3HMgdQjMV/pz/D4444ddMDl9HDstMktTbuI6aUmG5zgXj
         Cm/f3gP2HFMqMUCGQJ3KuXUpmpv4VPluOqOv57OI8tKB+m3z53DwCbN6+4CdnJ8yekCr
         AWZCjl87wl2eSF82oWVcc7vfcIDV+fVgPXbQGSo3snPfI2Fw87rQoNJxXZoqcLJrG53Q
         YX8g==
X-Gm-Message-State: AG10YOSrMcOt8jvyDIWB8aiUIQErJpdfGoh0OWE1MzjSZbvprE8pxihH+C/irwqAZJ0Cvg==
X-Received: by 10.112.198.131 with SMTP id jc3mr3708848lbc.118.1455400715093;
        Sat, 13 Feb 2016 13:58:35 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:34 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [RFC 09/10] MIPS: ath79: setup.c: disable platform code for OF boards
Date:   Sun, 14 Feb 2016 00:58:16 +0300
Message-Id: <1455400697-29898-10-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52041
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
