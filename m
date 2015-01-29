Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 10:54:32 +0100 (CET)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34561 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011293AbbA2JyNHaEYl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 10:54:13 +0100
Received: by mail-wi0-f180.google.com with SMTP id h11so22058618wiw.1;
        Thu, 29 Jan 2015 01:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfwqWCBBpV+WvLUq44dDgQoXGsvls8+luEDIqnbKk0Y=;
        b=ouXRF/kQ36JuruD0vIMs0uct06QF9Yy89646cMoyseQb+FWRPiyOZr7PQefF5jUbbe
         vfQSTlIUZnurhH06SXMG52LspjaOASySkMavtVSV1vThdICmGqLxbCS2DuqIZ19u8xnb
         NUzUILyWnhGAWtv7MpjXyFrcx4CKRII5SOtnxHrCMhUdqWlmHidNofdmJyGmM2U3566O
         svtsp9ByfZz0Bst7Xj81gXgkg3m0XlCaPASZu1imXpzoOVf8izgX/aXie8hJHuEZujSH
         HSG1q1+0HIY8NjS/QN0yUbIqmv5+QKma956zfjC7W2tihJpw3mEZ/X/7q4VUOaSkNAlY
         hR6g==
X-Received: by 10.180.74.109 with SMTP id s13mr2477881wiv.33.1422525247411;
        Thu, 29 Jan 2015 01:54:07 -0800 (PST)
Received: from dargo.Speedport_W_724V_01011603_00_005 (p5484D55C.dip0.t-ipconnect.de. [84.132.213.92])
        by mx.google.com with ESMTPSA id ej10sm1762691wib.2.2015.01.29.01.54.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jan 2015 01:54:06 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/2] MIPS: Alchemy: preset loops_per_jiffy based on CPU clock
Date:   Thu, 29 Jan 2015 10:54:03 +0100
Message-Id: <1422525243-1756-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422525243-1756-1-git-send-email-manuel.lauss@gmail.com>
References: <1422525243-1756-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45520
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

This was lost during the rewrite of clock framework support.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/clock.c | 6 ++++++
 arch/mips/alchemy/common/setup.c | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 428c9f0..680fbb6 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -133,6 +133,12 @@ static unsigned long alchemy_clk_cpu_recalc(struct clk_hw *hw,
 	return t;
 }
 
+void __init alchemy_set_lpj(void)
+{
+	preset_lpj = alchemy_clk_cpu_recalc(NULL, ALCHEMY_ROOTCLK_RATE);
+	preset_lpj = preset_lpj / 2 / HZ;
+}
+
 static struct clk_ops alchemy_clkops_cpu = {
 	.recalc_rate	= alchemy_clk_cpu_recalc,
 };
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 4e72daf..2902138 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -34,10 +34,12 @@
 #include <au1000.h>
 
 extern void __init board_setup(void);
-extern void set_cpuspec(void);
+extern void __init alchemy_set_lpj(void);
 
 void __init plat_mem_setup(void)
 {
+	alchemy_set_lpj();
+
 	if (au1xxx_cpu_needs_config_od())
 		/* Various early Au1xx0 errata corrected by this */
 		set_c0_config(1 << 19); /* Set Config[OD] */
-- 
2.2.2
