Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2017 14:05:01 +0100 (CET)
Received: from smtpbgau1.qq.com ([54.206.16.166]:60098 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991232AbdADNExjqt8r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jan 2017 14:04:53 +0100
X-QQ-mid: Xesmtp15t1483535078toisnur2y
Received: from Red54.com (unknown [183.39.159.125])
        by esmtp5.qq.com (ESMTP) with SMTP id 0
        for <linux-mips@linux-mips.org>; Wed, 04 Jan 2017 21:04:37 +0800 (CST)
X-QQ-SSF: 00000000000000000M104F00000000U
X-QQ-FEAT: yUqBE/5l+gf919770aqQb4h8OoTVhFNxFOxS1PJmvAKLrLJF9hvKIvSLpBmkA
        tRbS3SoQETMin3HKukpRTXdZlSvuqJrOSLCkZpWgDccoVhWZs+P38+nMOzZMAGGN6NwPEHO
        q8zsqIsFIUEfYYy6/SzemDcqIhrurYKFPSjsz8PfIxHPlIQQ6mCkE8C0Kt6VdT5tEmagGSz
        Uw8ZYPQf25ANaR7QPPG9+7x1ieSjMJ9eGixG4ECFf9rAXtt9uUlpAsWEEIwTny50aK/YH/V
        h9H9REkAu+xBlG
X-QQ-GoodBg: 0
Received: by Red54.com (sSMTP sendmail emulation); Wed, 04 Jan 2017 21:04:37 +0800
Date:   Wed, 4 Jan 2017 21:04:37 +0800
From:   =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Loongson: Probe Loongson 1C & Loongson 1
Message-ID: <20170104130437.GA20672@red54.local>
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
X-archive-position: 56153
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

Loongson 1 is a 32-bit MIPS CPU family with PRID 0x4220.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 arch/mips/kernel/cpu-probe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 06f690eb..62946f7b 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1503,7 +1503,13 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON1:
+#if defined(CONFIG_CPU_LOONGSON1B)
 			__cpu_name[cpu] = "Loongson 1B";
+#elif defined(CONFIG_CPU_LOONGSON1C)
+			__cpu_name[cpu] = "Loongson 1C";
+#else
+			__cpu_name[cpu] = "Loongson 1";
+#endif
 			break;
 		}
 
-- 
2.11.0
