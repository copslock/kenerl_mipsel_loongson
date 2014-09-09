Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2014 14:04:10 +0200 (CEST)
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36511 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008439AbaIIMEFPhul6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Sep 2014 14:04:05 +0200
Received: from mfilter18-d.gandi.net (mfilter18-d.gandi.net [217.70.178.146])
        by relay5-d.mail.gandi.net (Postfix) with ESMTP id E434041C07B;
        Tue,  9 Sep 2014 14:04:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter18-d.gandi.net
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
        by mfilter18-d.gandi.net (mfilter18-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id 5-2uSLqqny5O; Tue,  9 Sep 2014 14:04:03 +0200 (CEST)
X-Originating-IP: 88.159.34.112
Received: from starbug-2.treewalker.org (unknown [88.159.34.112])
        (Authenticated sender: relay@treewalker.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 42C8641C088;
        Tue,  9 Sep 2014 14:04:03 +0200 (CEST)
Received: from hyperion.trinair2002 (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.treewalker.org (Postfix) with ESMTP id C0DED31876;
        Tue,  9 Sep 2014 14:04:02 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Apelete Seketeli <apelete@seketeli.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH] MIPS: Removed declaration of obsolete arch_init_clk_ops()
Date:   Tue,  9 Sep 2014 14:04:00 +0200
Message-Id: <1410264240-10869-1-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 1.8.4.5
Return-Path: <maarten@treewalker.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/include/asm/clock.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/include/asm/clock.h b/arch/mips/include/asm/clock.h
index 778e32d..4809c29 100644
--- a/arch/mips/include/asm/clock.h
+++ b/arch/mips/include/asm/clock.h
@@ -35,9 +35,6 @@ struct clk {
 #define CLK_ALWAYS_ENABLED	(1 << 0)
 #define CLK_RATE_PROPAGATES	(1 << 1)
 
-/* Should be defined by processor-specific code */
-void arch_init_clk_ops(struct clk_ops **, int type);
-
 int clk_init(void);
 
 int __clk_enable(struct clk *);
-- 
1.8.4.5
