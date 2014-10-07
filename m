Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 17:22:59 +0200 (CEST)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:61886 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010716AbaJGPWsjf2vC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 17:22:48 +0200
Received: by mail-wg0-f45.google.com with SMTP id m15so9513003wgh.4
        for <multiple recipients>; Tue, 07 Oct 2014 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VmRKcyLxTXUqogXiHgxvJljVxtK79afrUpfuAzjrWac=;
        b=LzR/jyHl6C62l1X/3w0qBExnPZTYgP97rwR2vNPbcLPrw9pRWDhJXrpWumLbTg58y3
         7nUIDSlMzlIBi2dwOsOJg0/sssB7u3Las4QjVVCj5cJ2SoBiUGcHCSnU5/Ct3S2cW2o7
         t4NER8acNHYNVDZ01GvSnunyc/6xb7VhqrjtkPfF58ayW2o2NG46NXQormgrL1PeAPOY
         8WsCkNiIhm+bPXMoYOOVrcVVA4vfCRSWbRgWrVTdMD8zxzZToIzelyWoaXPZmDe+XizG
         +wn8mln794o4g1vWX3S1aSomMhCIfhAg/AJ2ud4Y4vnSTt+xd2pfU2O6q7w56alFvT7/
         sNRA==
X-Received: by 10.180.79.41 with SMTP id g9mr5314231wix.75.1412695363402;
        Tue, 07 Oct 2014 08:22:43 -0700 (PDT)
Received: from cizrna.lan (37-48-36-103.tmcz.cz. [37.48.36.103])
        by mx.google.com with ESMTPSA id ny6sm15093285wic.22.2014.10.07.08.22.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 08:22:42 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] MIPS: Alchemy: Remove direct access to prepare_count field of struct clk
Date:   Tue,  7 Oct 2014 17:21:46 +0200
Message-Id: <1412695334-2608-2-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43057
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
