Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2017 14:45:57 +0100 (CET)
Received: from smtpbgau1.qq.com ([54.206.16.166]:49980 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990513AbdADNpuZfJE7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jan 2017 14:45:50 +0100
X-QQ-mid: Xesmtp31t1483537534tqbcqynno
Received: from Red54.com (unknown [183.39.159.125])
        by esmtp4.qq.com (ESMTP) with SMTP id 0
        for <linux-mips@linux-mips.org>; Wed, 04 Jan 2017 21:45:33 +0800 (CST)
X-QQ-SSF: 00000000000000000M104F00000000U
X-QQ-FEAT: Gf8h89u9tNxU5IzFIRHwJh/Z2dAFcQjH4/184U4oH7ti5P9qtufuJen3/1BaL
        Jjqn9QVj7D7PmQ7MraB8XQ5iOIGt2LOKg3kOk85wZl14S3A40ik/J4uEjPjYf8coYjPHZ/y
        V/jkXmNMXYl6ySsg0vdqIINxRmMYYJz7pRO/fGGjGbnqRmc1S2e1ItxZZxfOHK7ncpNOb+l
        buPDyuyCbSz1rOlgFP6LbBKksy+BIktgdujPcQyqSt8hNGm35S/BqBfAkzswKPc1LBfEYpD
        g6XKuxvmSq9bMr9mTc5bwuqyM=
X-QQ-GoodBg: 0
Received: by Red54.com (sSMTP sendmail emulation); Wed, 04 Jan 2017 21:45:33 +0800
Date:   Wed, 4 Jan 2017 21:45:33 +0800
From:   =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Loongson: Fix osc_clk_name
Message-ID: <20170104134533.GA20945@red54.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:Red54.com:bgforeign:bgforeign3
X-QQ-Bgrelay: 1
Return-Path: <Yeking@Red54.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Yeking@Red54.com
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

"osc_33m_clk" is already renamed to "osc_clk".
https://patchwork.kernel.org/patch/9338505/

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 arch/mips/loongson32/common/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index beff0852..f9d877d4 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -82,7 +82,7 @@ void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
 /* CPUFreq */
 static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
 	.clk_name	= "cpu_clk",
-	.osc_clk_name	= "osc_33m_clk",
+	.osc_clk_name	= "osc_clk",
 	.max_freq	= 266 * 1000,
 	.min_freq	= 33 * 1000,
 };
-- 
2.11.0
