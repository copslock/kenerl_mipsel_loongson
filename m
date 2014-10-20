Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 15:41:33 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:52706 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011923AbaJTNlYeHKkx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 15:41:24 +0200
Received: by mail-wi0-f176.google.com with SMTP id hi2so7153512wib.9
        for <multiple recipients>; Mon, 20 Oct 2014 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dOqooTy4Ptxz5Z5el8o0yLyJYwiRF0SSP4s6W3+/hFY=;
        b=idSQ6O8g4Dc1JBN9g7W8WVak+J3jHwpTAgWphKuVvIGS2JH60h7zwbnBg39j4WxmNT
         4AnyB+Mx+GaLNnf4iGvYCvU6WjuNwkQvyQ+AUA6Ed+h09GwEU9MjMDRVZsu7s6rWapD3
         UobYVPdOfad96xfEarEQLVv0yTx4WlSKV4XWbkCHRujaagfZvKVtchBN84VpYBpbO2xF
         hWQlU1ratZIGJsxXurF4zkWW0Yb2CfOcdPI7h7gxCa01Ke1ETt00GYhO63Q5JPZRDeuc
         It3LIOFCykLe8cCazeZrYWMQZKBCWgcT7cVyTxz5ft852z25vTPLXoZohQjL/L13CSjS
         J/3w==
X-Received: by 10.194.24.197 with SMTP id w5mr33890143wjf.71.1413812478180;
        Mon, 20 Oct 2014 06:41:18 -0700 (PDT)
Received: from cizrna.lan (37-48-34-187.tmcz.cz. [37.48.34.187])
        by mx.google.com with ESMTPSA id pc8sm11927091wjb.36.2014.10.20.06.41.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 06:41:17 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] MIPS: Alchemy: Remove direct access to prepare_count field of struct clk
Date:   Mon, 20 Oct 2014 15:40:01 +0200
Message-Id: <1413812442-24956-2-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1413812442-24956-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1413812442-24956-1-git-send-email-tomeu.vizoso@collabora.com>
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43354
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

Replacing it with a call to __clk_is_prepared(), which isn't entirely
equivalent but in practice shouldn't matter.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/mips/alchemy/common/clock.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index d7557cd..203e440 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -37,7 +37,6 @@
 #include <linux/io.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
-#include <linux/clk-private.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -397,10 +396,10 @@ static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
 			break;
 
 		/* if this parent is currently unused, remember it.
-		 * XXX: I know it's a layering violation, but it works
-		 * so well.. (if (!clk_has_active_children(pc)) )
+		 * XXX: we would actually want clk_has_active_children()
+		 * but this is a good-enough approximation for now.
 		 */
-		if (pc->prepare_count == 0) {
+		if (!__clk_is_prepared(pc)) {
 			if (!free)
 				free = pc;
 		}
-- 
1.9.3
