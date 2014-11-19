Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 22:53:49 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:46401 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014056AbaKSVw6nAyZ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 22:52:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 51B0019C0E2;
        Wed, 19 Nov 2014 23:52:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id Ok5wq3QkCOkB; Wed, 19 Nov 2014 23:52:51 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id BE5FC5BC00A;
        Wed, 19 Nov 2014 23:52:51 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4/7] MIPS: loongson: lemote-2f: irq: make internal data static
Date:   Wed, 19 Nov 2014 23:52:48 +0200
Message-Id: <1416433971-18604-5-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
References: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Make internal static to eliminate the following sparse warnings:
warning: symbol 'ip6_irqaction' was not declared. Should it be static?
warning: symbol 'cascade_irqaction' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/loongson/lemote-2f/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
index 6f8682e..cab5f43 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -93,13 +93,13 @@ static irqreturn_t ip6_action(int cpl, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-struct irqaction ip6_irqaction = {
+static struct irqaction ip6_irqaction = {
 	.handler = ip6_action,
 	.name = "cascade",
 	.flags = IRQF_SHARED | IRQF_NO_THREAD,
 };
 
-struct irqaction cascade_irqaction = {
+static struct irqaction cascade_irqaction = {
 	.handler = no_action,
 	.name = "cascade",
 	.flags = IRQF_NO_THREAD,
-- 
2.1.2
