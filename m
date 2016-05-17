Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:08:01 +0200 (CEST)
Received: from exsmtp01.microchip.com ([198.175.253.37]:21924 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029438AbcEQFH7vYwV6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:07:59 +0200
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Mon, 16 May 2016
 22:07:50 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Tue, 17 May 2016
 10:36:03 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH 01/11] clk: microchip: use readl_poll_timeout() in pbclk_set_rate().
Date:   Tue, 17 May 2016 10:35:50 +0530
Message-ID: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

pbclk_set_rate() is using readl_poll_timeout_atomic() even
though spinlock is released. Fix it by replacing with
readl_poll_timeout().

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
---
Note: Please pull this complete series through the MIPS tree.

---

 drivers/clk/microchip/clk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/microchip/clk-core.c b/drivers/clk/microchip/clk-core.c
index ca85cea..c3b3014 100644
--- a/drivers/clk/microchip/clk-core.c
+++ b/drivers/clk/microchip/clk-core.c
@@ -199,9 +199,9 @@ static int pbclk_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	spin_unlock_irqrestore(&pb->core->reg_lock, flags);
 
-	/* wait again, for pbdivready */
-	err = readl_poll_timeout_atomic(pb->ctrl_reg, v, v & PB_DIV_READY,
-					1, LOCK_TIMEOUT_US);
+	/* wait again for DIV_READY */
+	err = readl_poll_timeout(pb->ctrl_reg, v, v & PB_DIV_READY,
+				 1, LOCK_TIMEOUT_US);
 	if (err)
 		return err;
 
-- 
1.8.3.1
