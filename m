From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 21 Sep 2014 15:38:43 +0300
Subject: MIPS: loongson2_cpufreq: Fix CPU clock rate setting mismerge
Message-ID: <20140921123843.qP0VqDoXhIrZJr8IBrL2zlvezeYpnM99Soj422eyz04@z>

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
