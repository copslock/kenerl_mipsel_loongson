Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 16:07:09 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49974 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012117AbbA2PGx2z-Wq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 16:06:53 +0100
Received: by mail-wi0-f177.google.com with SMTP id r20so25787252wiv.4;
        Thu, 29 Jan 2015 07:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgjs8evP2LFJ0S0VeAwSehNbGHv9ofiBu3q5+8qp8Y8=;
        b=qCMh6wmdDMGgxKfpBBS+c9UiNnJAZRPgkMSKWOY7YB7tZbrwuHpP+Gl8X1do9DCy0d
         dHv6QwpHuitf+wt2GSh7g57A/N0PoeAgH86SZEZ253NSdhn3GacE/h2nm6wqVYGFGsFn
         7Ff+ILsIdIDx8C3WsbIJrLQqUp1R7Ikibwc7sfo/2xxVSFx11GD11pj8F1mjjCJwXAdu
         FfNQVm4J3wx623fODqez5MdfWtGBxsADuryLN28SIVxmgUl9eO2kD231TeGCku+fCcSb
         h7g35vSA2FvFtPLKkULDv7yi7X9NBSan8FvwPWRZoXIL43QIKsrICssAV4+uZ+rxVRtu
         qiQw==
X-Received: by 10.180.74.144 with SMTP id t16mr2125183wiv.28.1422544008411;
        Thu, 29 Jan 2015 07:06:48 -0800 (PST)
Received: from dargo.Speedport_W_724V_01011603_00_005 (p4FCD26FC.dip0.t-ipconnect.de. [79.205.38.252])
        by mx.google.com with ESMTPSA id lk2sm2828460wic.22.2015.01.29.07.06.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jan 2015 07:06:47 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2 2/3] MIPS: Alchemy: preset loops_per_jiffy based on CPU clock
Date:   Thu, 29 Jan 2015 16:06:43 +0100
Message-Id: <1422544004-25254-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422544004-25254-1-git-send-email-manuel.lauss@gmail.com>
References: <1422544004-25254-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45535
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
v2: more syntactic sugar for Sergei, keep set_cpuspec()

 arch/mips/alchemy/common/clock.c | 6 ++++++
 arch/mips/alchemy/common/setup.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index f8f54b8..d8737a8 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -133,6 +133,12 @@ static unsigned long alchemy_clk_cpu_recalc(struct clk_hw *hw,
 	return t;
 }
 
+void __init alchemy_set_lpj(void)
+{
+	preset_lpj = alchemy_clk_cpu_recalc(NULL, ALCHEMY_ROOTCLK_RATE);
+	preset_lpj /= 2 * HZ;
+}
+
 static struct clk_ops alchemy_clkops_cpu = {
 	.recalc_rate	= alchemy_clk_cpu_recalc,
 };
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 4e72daf..9a0c4c8 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -35,9 +35,12 @@
 
 extern void __init board_setup(void);
 extern void set_cpuspec(void);
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
