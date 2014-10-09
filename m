Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:02:24 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:61055 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010962AbaJIPCQKL8-G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:02:16 +0200
Received: by mail-wi0-f173.google.com with SMTP id fb4so13444608wid.6
        for <multiple recipients>; Thu, 09 Oct 2014 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VmRKcyLxTXUqogXiHgxvJljVxtK79afrUpfuAzjrWac=;
        b=Mv49YOX1iH1STGz8NX7KXjQRidvJHkPCJfxs2lStF6ZEueDXNFnTx6pVbYMkV5T6pc
         GwRS7+Ko2sD+L72RrEG4OafvwYP03DGwrrkzsqH2oHmY4IR2xU9Sbar/CEy8nZiHJ0DQ
         y35kSU3PzdJfFVBCqkOoTT/wwCRi+tk5tmc78JmH3PSznN6yVSa/Ha+hHrHzmDheiowI
         GAurPI9MBe7zWJ6kifxiwdj1vl4PWQcexwK8rvABSxbrsywi+BJMgcnb824ROuhVg8g3
         farwbTRE5MpzUU199RYYnZc54Ag8M+tWuLiuC/5+kNRti4IKFx4CtLS/yiJcVGgP3FhV
         jbQw==
X-Received: by 10.180.73.103 with SMTP id k7mr40453539wiv.1.1412866928371;
        Thu, 09 Oct 2014 08:02:08 -0700 (PDT)
Received: from cizrna.lan (37-48-37-161.tmcz.cz. [37.48.37.161])
        by mx.google.com with ESMTPSA id b6sm5847591wiy.22.2014.10.09.08.02.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 08:02:07 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] MIPS: Alchemy: Remove direct access to prepare_count field of struct clk
Date:   Thu,  9 Oct 2014 17:01:09 +0200
Message-Id: <1412866903-6970-2-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1412866903-6970-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1412866903-6970-1-git-send-email-tomeu.vizoso@collabora.com>
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43134
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
