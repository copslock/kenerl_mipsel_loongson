Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 23:00:13 +0100 (CET)
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:59284 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992209AbdBGV7boqjhC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 22:59:31 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id bDnNcoAK6sa1kbDnOclLfW; Tue, 07 Feb 2017 14:59:31 -0700
X-Authority-Analysis: v=2.2 cv=W+NIbVek c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=yG1wFZ-RLMJnsVyPFoEA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id AF9EF33B35F3; Tue,  7 Feb 2017 13:59:29 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
Date:   Tue,  7 Feb 2017 13:58:54 -0800
Message-Id: <20170207215856.8999-3-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170207215856.8999-1-code@mmayer.net>
References: <20170207215856.8999-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfDQqUPg4FsJIBTXKJSCXlNlQS7XE4rQvAG/enu6WHg1nz90A25Hw6E6qWCSVPoaTuHlV1zdKa7uTdmxc3pI/SDE+4DfyS9HKowMVd4Q7RiBpORVdmm9g
 +DD8XN1Qm3BHF6yQf8BXkDbZrWDi1TXk9iWRmqrM9aSmT4DMrblNazW53wMseHhT0HLbqi7nTlbLQ07DGlJ2tUVayDEGWYSdqrKx/8HkVW9Vz4qGEdH978/+
 ZWWGmDKx6FK7J14RB+4e9pX8h4RgpI9mGJs4kKwud9WYeXHsx9MW52hSs2dUDddGgqZ/KJeT1+dyychifKz9tTqGwJPLWLHiwonO5MG2ElFavUaWO4DCUF/A
 fgiRv7wK1SgVo6BvphTYDi5Ig/1+bw==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56702
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

Turn on CPU_SUPPORTS_CPUFREQ and MIPS_EXTERNAL_TIMER for BMIPS.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..e137eed 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1703,6 +1703,8 @@ config CPU_BMIPS
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_HAS_PREFETCH
+	select CPU_SUPPORTS_CPUFREQ
+	select MIPS_EXTERNAL_TIMER
 	help
 	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
 
-- 
2.7.4
