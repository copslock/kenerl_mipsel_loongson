Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 14:30:50 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:55757 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011780AbbDSMagEI2h7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 14:30:36 +0200
Received: from localhost.localdomain (unknown [85.177.79.58])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 776069400D6;
        Sun, 19 Apr 2015 14:28:14 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] MIPS: ath79: Add a missing new line in log message
Date:   Sun, 19 Apr 2015 14:30:01 +0200
Message-Id: <1429446604-15403-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429446604-15403-1-git-send-email-albeu@free.fr>
References: <1429446604-15403-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

The memory setup log is missing a new line.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index a73c93c..7fc8397 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -225,7 +225,7 @@ void __init plat_time_init(void)
 	ddr_clk_rate = ath79_get_sys_clk_rate("ddr");
 	ref_clk_rate = ath79_get_sys_clk_rate("ref");
 
-	pr_info("Clocks: CPU:%lu.%03luMHz, DDR:%lu.%03luMHz, AHB:%lu.%03luMHz, Ref:%lu.%03luMHz",
+	pr_info("Clocks: CPU:%lu.%03luMHz, DDR:%lu.%03luMHz, AHB:%lu.%03luMHz, Ref:%lu.%03luMHz\n",
 		cpu_clk_rate / 1000000, (cpu_clk_rate / 1000) % 1000,
 		ddr_clk_rate / 1000000, (ddr_clk_rate / 1000) % 1000,
 		ahb_clk_rate / 1000000, (ahb_clk_rate / 1000) % 1000,
-- 
2.0.0
