Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2014 17:50:44 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:45632 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010488AbaJCPumo8MDD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Oct 2014 17:50:42 +0200
Received: by mail-wg0-f52.google.com with SMTP id a1so1843077wgh.11
        for <multiple recipients>; Fri, 03 Oct 2014 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=VmRKcyLxTXUqogXiHgxvJljVxtK79afrUpfuAzjrWac=;
        b=gKZZlmPc7Cz0nAHyOKcIhQEbXpU65yvm/kgMqCK4sNWV09SCGtyc+H5Qr2cDBO1xo4
         kMnv7ww2Pf+VlDdSi5zXuWgPLrjPIIrzR2p84M0XUre6zND0eK6dszgeDYLrSen6frv9
         PM/s1fZYgEiPmWCLx3JDbY+Y49Y1z1eSMoZ71N0PHAnj1mq+kAEZ/h1uQjeicWhCdok4
         opZIOTK354oBYzNhfGrcfMdlMejKroRg6YSbJmubJlNq9MHbNW1e9at9nFyGB9EoUioZ
         Q1Dm8TI7K4f/YOTqFIZ8cQQa8TDNBl60tsEN5kxrIBxYatSLFLdfLrNE9HWZN6t/V5Vy
         jnDg==
X-Received: by 10.194.78.4 with SMTP id x4mr8543939wjw.44.1412351437433;
        Fri, 03 Oct 2014 08:50:37 -0700 (PDT)
Received: from cizrna.lan (37-48-55-252.tmcz.cz. [37.48.55.252])
        by mx.google.com with ESMTPSA id cz3sm8364946wjb.23.2014.10.03.08.50.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2014 08:50:36 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Alchemy: Remove direct access to prepare_count field of struct clk
Date:   Fri,  3 Oct 2014 17:50:00 +0200
Message-Id: <1412351404-28818-1-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42939
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
