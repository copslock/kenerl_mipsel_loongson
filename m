Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 12:58:01 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:31255 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822972Ab3GAK6Ac6UCk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jul 2013 12:58:00 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: bcm63xx: clk: Add dummy clk_set_rate() function
Date:   Mon, 1 Jul 2013 11:57:24 +0100
Message-ID: <1372676244-1399-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_07_01_11_57_54
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Several drivers use the clk_set_rate() function that needs
to be defined in the platform's clock code. The Broadcom
BCM63xx platform hardcodes the clock rate so we create a new
dummy clk_set_rate() function which just returns -EINVAL.

Also fixes the following build problem on a randconfig:
drivers/built-in.o: In function `nop_usb_xceiv_probe':
phy-nop.c:(.text+0x3ec26c): undefined reference to `clk_set_rate'

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com> 
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/bcm63xx/clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index c726a97..70dcc52 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -318,6 +318,12 @@ unsigned long clk_get_rate(struct clk *clk)
 
 EXPORT_SYMBOL(clk_get_rate);
 
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
 struct clk *clk_get(struct device *dev, const char *id)
 {
 	if (!strcmp(id, "enet0"))
-- 
1.8.2.1
