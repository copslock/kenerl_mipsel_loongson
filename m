Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 12:09:49 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:40691 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013373AbaKKLJiXczyL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 12:09:38 +0100
Received: from bl15-104-53.dsl.telepac.pt ([188.80.104.53] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Xo9KI-0006wd-GU; Tue, 11 Nov 2014 11:09:34 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 038/170] MIPS: loongson2_cpufreq: Fix CPU clock rate setting mismerge
Date:   Tue, 11 Nov 2014 11:06:37 +0000
Message-Id: <1415704129-12709-39-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1415704129-12709-1-git-send-email-luis.henriques@canonical.com>
References: <1415704129-12709-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt1 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit aa08ed55442ac6f9810c055e1474be34e785e556 upstream.

During 3.16 merge window, parts of the commit 8e8acb32960f
(MIPS/loongson2_cpufreq: Fix CPU clock rate setting) seem to have
been deleted probably due to a mismerge, and as a result cpufreq
is broken again on Loongson2 boards in 3.16 and newer kernels.
Fix by repeating the fix.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/7835/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/loongson/lemote-2f/clock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/clock.c b/arch/mips/loongson/lemote-2f/clock.c
index 1eed38e28b1e..ebfb9cd71ca1 100644
--- a/arch/mips/loongson/lemote-2f/clock.c
+++ b/arch/mips/loongson/lemote-2f/clock.c
@@ -91,6 +91,7 @@ EXPORT_SYMBOL(clk_put);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
+	unsigned int rate_khz = rate / 1000;
 	struct cpufreq_frequency_table *pos;
 	int ret = 0;
 	int regval;
@@ -107,9 +108,9 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		propagate_rate(clk);
 
 	cpufreq_for_each_valid_entry(pos, loongson2_clockmod_table)
-		if (rate == pos->frequency)
+		if (rate_khz == pos->frequency)
 			break;
-	if (rate != pos->frequency)
+	if (rate_khz != pos->frequency)
 		return -ENOTSUPP;
 
 	clk->rate = rate;
-- 
2.1.0
