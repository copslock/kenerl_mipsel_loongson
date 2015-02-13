Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2015 14:35:54 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:54596 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012488AbbBMNfwnGxnU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2015 14:35:52 +0100
Received: by mail-we0-f177.google.com with SMTP id m14so10766945wev.8;
        Fri, 13 Feb 2015 05:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=sOYJi29DZbDqAvVizPgpjA2B6675DOSSvj6TP+GUCw8=;
        b=K73r8yS6pgZTw/itrqUwCi/x4EWxCuLMItOwXb/ej8pq03dRE2/lBODZ3zItPqcHb/
         RJxMmTk6srluIjggcyQmSaaw1KWx4LCNLuk2Za5ynivaFl+FCUkHdHeHwz/T+GgknWin
         zk0q0nyCji6lIAwoy/zfu3/tsBtLSrk2HAD1EDMlt8YwaFPo1cIqu/vHK1uTEPe1uH9u
         IGxJ15mQikpWbVBHVr1Ql1UoyMR9LeCyM054OgA9fl04OrfHyCAlXG/IIe5uMnZtHDaL
         6xWiyjbH74fh2k5BttJynlgX78sZDLEqt21dHwuKBApKPLcWKTQCIGeWn9k0VMIC0Rzx
         5taw==
X-Received: by 10.194.61.65 with SMTP id n1mr18510078wjr.53.1423834547686;
        Fri, 13 Feb 2015 05:35:47 -0800 (PST)
Received: from cizrna.lan (37-48-37-7.tmcz.cz. [37.48.37.7])
        by mx.google.com with ESMTPSA id cf12sm10141447wjb.10.2015.02.13.05.35.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Feb 2015 05:35:46 -0800 (PST)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-mips@linux-mips.org
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Michael Turquette <mturquette@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Alchemy: Remove bogus args from alchemy_clk_fgcs_detr
Date:   Fri, 13 Feb 2015 14:34:54 +0100
Message-Id: <1423834499-13674-1-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomeu.vizoso@collabora.com
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

They were added to this function by mistake when they were added to the
clk_ops.determine_rate callback.

Fixes: 1c8e600440c7 ("clk: Add rate constraints to clocks")
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/mips/alchemy/common/clock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 4e65404..604b7d0 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -373,8 +373,6 @@ static long alchemy_calc_div(unsigned long rate, unsigned long prate,
 }
 
 static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk,
 					int scale, int maxdiv)
-- 
1.9.3
