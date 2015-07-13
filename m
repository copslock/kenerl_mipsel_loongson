Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:30:57 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:50784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009967AbbGMUazNQcXV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:30:55 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3C112140365;
        Mon, 13 Jul 2015 20:30:53 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 1FD0B140371; Mon, 13 Jul 2015 20:30:53 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51818140365;
        Mon, 13 Jul 2015 20:30:51 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Alchemy: Include clk.h
Date:   Mon, 13 Jul 2015 13:30:50 -0700
Message-Id: <1436819450-16440-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.3.0.rc1.33.g42e4583
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

This clock provider uses the consumer API, so include clk.h
explicitly.

Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Please ack so this can go through the clk tree. We're removing
the include of clk.h in clk-provider.h so that the consumer
and provider APIs are clearly split.

 arch/mips/alchemy/common/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 6e46abe0dac6..5168c4dca1ca 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -35,6 +35,7 @@
 
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/slab.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
