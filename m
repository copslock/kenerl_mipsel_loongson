Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Oct 2016 09:26:31 +0100 (CET)
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:54955 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990686AbcJ3I0Y3Oo06 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Oct 2016 09:26:24 +0100
Received: from localhost.localdomain ([92.140.167.9])
        by mwinf5d70 with ME
        id 1kSJ1u0040CVt9o03kSJCa; Sun, 30 Oct 2016 09:26:19 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 30 Oct 2016 09:26:19 +0100
X-ME-IP: 92.140.167.9
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ralf@linux-mips.org, antonynpavlov@gmail.com, albeu@free.fr,
        hackpascal@gmail.com, amitoj1606@gmail.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] MIPS: ath79: Fix error handling
Date:   Sun, 30 Oct 2016 09:25:46 +0100
Message-Id: <20161030082546.15019-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.9.3
X-Antivirus: avast! (VPS 161029-0, 29/10/2016), Outbound message
X-Antivirus-Status: Clean
Return-Path: <christophe.jaillet@wanadoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christophe.jaillet@wanadoo.fr
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

'clk_register_fixed_rate()' returns an error pointer in case of error, not
NULL. So test it with IS_ERR.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/mips/ath79/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index cc3a1e33a600..c1102cffe37d 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -45,7 +45,7 @@ static struct clk *__init ath79_add_sys_clkdev(
 	int err;
 
 	clk = clk_register_fixed_rate(NULL, id, NULL, 0, rate);
-	if (!clk)
+	if (IS_ERR(clk))
 		panic("failed to allocate %s clock structure", id);
 
 	err = clk_register_clkdev(clk, id, NULL);
-- 
2.9.3
