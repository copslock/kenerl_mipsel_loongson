Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 17:18:43 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:54406 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012752AbbBFQSl7UbtM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Feb 2015 17:18:41 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id C986C2E495;
        Fri,  6 Feb 2015 17:18:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id X1Hqdxa9K9Oj; Fri,  6 Feb 2015 17:18:36 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 3C4F42E494;
        Fri,  6 Feb 2015 17:18:36 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 25305EF2;
        Fri,  6 Feb 2015 17:18:36 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 19FACC31;
        Fri,  6 Feb 2015 17:18:36 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 17A9F3E282;
        Fri,  6 Feb 2015 17:18:36 +0100 (CET)
Received: from lnxniklass.se.axis.com (10.94.49.1) by xmail2.se.axis.com
 (10.0.5.74) with Microsoft SMTP Server (TLS) id 8.3.342.0; Fri, 6 Feb 2015
 17:18:35 +0100
From:   Niklas Cassel <niklas.cassel@axis.com>
To:     <ralf@linux-mips.org>
CC:     <abrestic@chromium.org>, <linux-mips@linux-mips.org>,
        Niklas Cassel <niklass@axis.com>
Subject: [PATCH] MIPS: sead3: Corrected get_c0_perfcount_int
Date:   Fri, 6 Feb 2015 17:18:29 +0100
Message-ID: <1423239509-1432-1-git-send-email-niklass@axis.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <niklas.cassel@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklas.cassel@axis.com
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

Commit e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
updated several platforms. This is a copy paste error.

Signed-off-by: Niklas Cassel <niklass@axis.com>
---
 arch/mips/mti-sead3/sead3-time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index ec1dd24..e1d6989 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -72,7 +72,7 @@ void read_persistent_clock(struct timespec *ts)
 int get_c0_perfcount_int(void)
 {
 	if (gic_present)
-		return gic_get_c0_compare_int();
+		return gic_get_c0_perfcount_int();
 	if (cp0_perfcount_irq >= 0)
 		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	return -1;
-- 
2.1.4
