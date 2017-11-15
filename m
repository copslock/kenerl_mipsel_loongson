Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2017 22:18:52 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:44231 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992211AbdKOVSps0KiJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2017 22:18:45 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 15 Nov 2017 21:18:35 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 15 Nov 2017 13:18:24 -0800
From:   James Hogan <james.hogan@mips.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] cpufreq: Add Loongson machine dependencies
Date:   Wed, 15 Nov 2017 21:17:55 +0000
Message-ID: <20171115211755.25102-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510780715-321457-21585-16487-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186969
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

The MIPS loongson cpufreq drivers don't build unless configured for the
correct machine type, due to dependency on machine specific architecture
headers and symbols in machine specific platform code.

More specifically loongson1-cpufreq.c uses RST_CPU_EN and RST_CPU,
neither of which is defined in asm/mach-loongson32/regs-clk.h unless
CONFIG_LOONGSON1_LS1B=y, and loongson2_cpufreq.c references
loongson2_clockmod_table[], which is only defined in
arch/mips/loongson64/lemote-2f/clock.c, i.e. when
CONFIG_LEMOTE_MACH2F=y.

Add these dependencies to Kconfig to avoid randconfig / allyesconfig
build failures (e.g. when based on BMIPS which also has a cpufreq
driver).

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/cpufreq/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 4ebae43118ef..d8addbce40bc 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -275,6 +275,7 @@ config BMIPS_CPUFREQ
 
 config LOONGSON2_CPUFREQ
 	tristate "Loongson2 CPUFreq Driver"
+	depends on LEMOTE_MACH2F
 	help
 	  This option adds a CPUFreq driver for loongson processors which
 	  support software configurable cpu frequency.
@@ -287,6 +288,7 @@ config LOONGSON2_CPUFREQ
 
 config LOONGSON1_CPUFREQ
 	tristate "Loongson1 CPUFreq Driver"
+	depends on LOONGSON1_LS1B
 	help
 	  This option adds a CPUFreq driver for loongson1 processors which
 	  support software configurable cpu frequency.
-- 
2.14.1
