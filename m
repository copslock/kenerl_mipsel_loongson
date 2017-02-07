Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 23:01:07 +0100 (CET)
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:59284 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992267AbdBGV7zN15sC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 22:59:55 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id bDnlcoAU1sa1kbDnmclLmT; Tue, 07 Feb 2017 14:59:54 -0700
X-Authority-Analysis: v=2.2 cv=W+NIbVek c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=KKAkSRfTAAAA:8 a=8Aiz8qQ5bdL30ZDUwwMA:9
 a=Fp8MccfUoT0GBdDC_Lng:22 a=cvBusfyB2V15izCimMoJ:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 30DF633B35FD; Tue,  7 Feb 2017 13:59:53 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] MIPS: BMIPS: enable CPUfreq
Date:   Tue,  7 Feb 2017 13:58:56 -0800
Message-Id: <20170207215856.8999-5-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170207215856.8999-1-code@mmayer.net>
References: <20170207215856.8999-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfInaj7+Er8ra9j5cy1wIZEI4sCxW7tnvqH3giavSpsb8x/iZJ/FedDdkUlFZSsZGLMYeD/gUBT0T0o/qvSuIDgOttSvR0doDRNw6ICqRb++/KtCxFEL/
 Bm+em6O20aKjYcCsjf9Za7LqtccLy72XILwoNXvAfYQJMZPhGuwVH+qtkxgktcphbYiCMJwcCUfAjuK6xmwl8Q9iyn4qZAmTqNoEX0m5YuP0S4t5NYp8Flwg
 DrAumBY7oALFMa70YwQNoxe/tm2N4uX1IYBF5UtcDgz9o2s6DKXcgl5jtPJ+Gs52OCBmvw3gzO459UDRs1IYfU0uOI8LVsjRZpKLUU/pSaLtBQySSMgRWULo
 9Glq9GA7YB3IRVEBe811J5NGS6KCnw==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: code@mmayer.net
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

From: Markus Mayer <mmayer@broadcom.com>

Enable all applicable CPUfreq options.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/configs/bmips_stb_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 3be15cb..3cefa6b 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -15,6 +15,14 @@ CONFIG_EXPERT=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
+CONFIG_BMIPS_CPUFREQ=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
-- 
2.7.4
