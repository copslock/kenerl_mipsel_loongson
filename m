Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:08:46 +0200 (CEST)
Received: from smtpout.microchip.com ([198.175.253.82]:15523 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029444AbcEQFIQWiU06 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:08:16 +0200
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.181.6; Mon, 16 May 2016
 22:08:07 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Tue, 17 May 2016
 10:36:21 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Joshua Henderson <joshua.henderson@microchip.com>
Subject: [PATCH 03/11] MIPS: pic32mzda: fix getting timer clock rate.
Date:   Tue, 17 May 2016 10:35:52 +0530
Message-ID: <1463461560-9629-3-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53469
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

PIC32 clock driver is now implemented as platform driver instead of
as part of of_clk_init(). It meants all the clock modules are available
quite late in the boot sequence. So request for CPU clock by clk_get_sys()
and clk_get_rate() to find c0_timer rate fails.

To fix this use PIC32 specific early clock functions implemented for early
console support.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

---
Note: Please pull this complete series through the MIPS tree.

---

 arch/mips/pic32/pic32mzda/time.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
index ca6a62b..62a0a78 100644
--- a/arch/mips/pic32/pic32mzda/time.c
+++ b/arch/mips/pic32/pic32mzda/time.c
@@ -11,13 +11,12 @@
  *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
  *  for more details.
  */
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/irqdomain.h>
 
 #include <asm/time.h>
 
@@ -58,16 +57,12 @@ unsigned int get_c0_compare_int(void)
 
 void __init plat_time_init(void)
 {
-	struct clk *clk;
+	unsigned long rate = pic32_get_pbclk(7);
 
 	of_clk_init(NULL);
-	clk = clk_get_sys("cpu_clk", NULL);
-	if (IS_ERR(clk))
-		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
 
-	clk_prepare_enable(clk);
-	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
-	mips_hpt_frequency = clk_get_rate(clk) / 2;
+	pr_info("CPU Clock: %ldMHz\n", rate / 1000000);
+	mips_hpt_frequency = rate / 2;
 
 	clocksource_probe();
 }
-- 
1.8.3.1
