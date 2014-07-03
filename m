Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 15:26:31 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34928 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861113AbaGCNXPpDktm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 15:23:15 +0200
Received: by mail-wi0-f176.google.com with SMTP id n3so11409457wiv.9
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ep5NH5OOWASt+Z6F+2eQsPQdnp1pgo9gT+lBAG6vDSk=;
        b=c+de+Yc7MePTDZY14N4kptW6RCJSIlu1pKUJRWa/CCiw01OY8l4GmMMJZCZO17lZhc
         q9sF2WZZxKNayg2C3nTFtjT851lNhhVl9I9lVHxjp4it8ILqSYIKnOIzyWmTxF5e3x3y
         7Xj+vO/s4bUSUH3bnPEg/PWn1mgzfc1arvHZKBn2DULnUfz8L3AGz/fohL+/Ba8L8AkP
         bIf1iBPv481UspRFeiMIhqegkQ+3bthjkf6FsIxBOSbzw1xeg+6gFoVHh6epf18AKBrs
         6BvctZxSlOBvMMaU44VjxylGveZUOQ0iN0ouhKeg8rxqCnvV9Q9q6Urr7JwL8S5K4klL
         F9og==
X-Received: by 10.180.183.131 with SMTP id em3mr49946664wic.56.1404393790318;
        Thu, 03 Jul 2014 06:23:10 -0700 (PDT)
Received: from localhost.localdomain (p57A34891.dip0.t-ipconnect.de. [87.163.72.145])
        by mx.google.com with ESMTPSA id ev9sm67079017wic.24.2014.07.03.06.23.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jul 2014 06:23:09 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v2 09/11] MIPS: Alchemy: au1200fb: use clk framework
Date:   Thu,  3 Jul 2014 15:22:40 +0200
Message-Id: <1404393762-858019-10-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
References: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41004
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

minimal patch to replace direct clock register hackery with clock
framework calls.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: initial version, new

 drivers/video/fbdev/au1200fb.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 230cfa8..3c8cf71 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -30,6 +30,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
@@ -829,11 +830,19 @@ static void au1200_setpanel(struct panel_settings *newpanel,
 	 */
 	if (!(panel->mode_clkcontrol & LCD_CLKCONTROL_EXT))
 	{
-		uint32 sys_clksrc;
-		AU1X_WRSYS(panel->mode_auxpll, AU1000_SYS_AUXPLL);
-		sys_clksrc = AU1X_RDSYS(AU1000_SYS_CLKSRC) & ~0x0000001f;
-		sys_clksrc |= panel->mode_toyclksrc;
-		AU1X_WRSYS(sys_clksrc, AU1000_SYS_CLKSRC);
+		struct clk *a, *c = clk_get(NULL, "lcd_intclk");
+
+		if (!IS_ERR(c)) {
+			if ((panel->mode_toyclksrc & 7) == 4) {
+				a = clk_get(NULL, ALCHEMY_AUXPLL_CLK);
+				if (!IS_ERR(a)) {
+					clk_set_parent(c, a);
+					clk_put(a);
+				}
+			}
+			clk_prepare_enable(c);
+			clk_put(c);
+		}
 	}
 
 	/*
-- 
2.0.0
