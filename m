Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 02:33:52 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:52572 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008555AbbC0BdvYQ8Te (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2015 02:33:51 +0100
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id F21BF2F4; Fri, 27 Mar 2015 02:33:48 +0100 (CET)
Received: from localhost (unknown [216.9.110.4])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 25C66209;
        Fri, 27 Mar 2015 02:33:47 +0100 (CET)
From:   Michael Opdenacker <michael.opdenacker@free-electrons.com>
To:     ralf@linux-mips.org
Cc:     chenhc@lemote.com, taohl@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: [PATCH] MIPS: Loongson-3: remove deprecated IRQF_DISABLED
Date:   Thu, 26 Mar 2015 18:33:41 -0700
Message-Id: <1427420021-27663-1-git-send-email-michael.opdenacker@free-electrons.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <michael.opdenacker@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46561
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

This removes the use of the IRQF_DISABLED flag
from arch/mips/loongson/loongson-3/hpet.c

It's a NOOP since 2.6.35.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/mips/loongson/loongson-3/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson/loongson-3/hpet.c b/arch/mips/loongson/loongson-3/hpet.c
index e898d68668a9..5c21cd3bd339 100644
--- a/arch/mips/loongson/loongson-3/hpet.c
+++ b/arch/mips/loongson/loongson-3/hpet.c
@@ -162,7 +162,7 @@ static irqreturn_t hpet_irq_handler(int irq, void *data)
 
 static struct irqaction hpet_irq = {
 	.handler = hpet_irq_handler,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
+	.flags = IRQF_NOBALANCING | IRQF_TIMER,
 	.name = "hpet",
 };
 
-- 
2.1.0
