Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Sep 2014 08:31:39 +0200 (CEST)
Received: from top.free-electrons.com ([176.31.233.9]:54045 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006158AbaI0GbhV5n9Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Sep 2014 08:31:37 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id F060D7B5; Sat, 27 Sep 2014 08:31:31 +0200 (CEST)
Received: from localhost (jon84-1-78-229-41-66.fbx.proxad.net [78.229.41.66])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8EA316FD;
        Sat, 27 Sep 2014 08:31:31 +0200 (CEST)
From:   Michael Opdenacker <michael.opdenacker@free-electrons.com>
To:     ralf@linux-mips.org, akpm@linux-foundation.org
Cc:     jkosina@suse.cz, standby24x7@gmail.com, rdunlap@infradead.org,
        yongjun_wei@trendmicro.com.cn, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: [PATCH] MIPS: ralink: remove deprecated IRQF_DISABLED
Date:   Sat, 27 Sep 2014 08:31:05 +0200
Message-Id: <1411799465-18508-1-git-send-email-michael.opdenacker@free-electrons.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <michael.opdenacker@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.opdenacker@free-electrons.com
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

Remove the use of the IRQF_DISABLED flag
from arch/mips/ralink/timer.c

It's a NOOP since 2.6.35 and it will be removed soon.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/mips/ralink/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index e38692a44e69..5bb29b3790ff 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -58,7 +58,7 @@ static irqreturn_t rt_timer_irq(int irq, void *_rt)
 
 static int rt_timer_request(struct rt_timer *rt)
 {
-	int err = request_irq(rt->irq, rt_timer_irq, IRQF_DISABLED,
+	int err = request_irq(rt->irq, rt_timer_irq, 0,
 						dev_name(rt->dev), rt);
 	if (err) {
 		dev_err(rt->dev, "failed to request irq\n");
-- 
1.9.1
