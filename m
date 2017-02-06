Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 22:52:45 +0100 (CET)
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:39101 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991965AbdBFVwCddb5T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 22:52:02 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id arCacauj6sa1karCbcg7gO; Mon, 06 Feb 2017 14:52:01 -0700
X-Authority-Analysis: v=2.2 cv=W+NIbVek c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=yG1wFZ-RLMJnsVyPFoEA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 88AB333ABBB6; Mon,  6 Feb 2017 13:52:00 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
Date:   Mon,  6 Feb 2017 13:51:17 -0800
Message-Id: <20170206215119.87099-3-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170206215119.87099-1-code@mmayer.net>
References: <20170206215119.87099-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfDVGh4HcADVmIVCQslHIqXJGDVbIV7F8IY9XN6EG2EzUUk4LEc7ZPnCPq2kQTynXRMl6K5WhH5+UL3kaIwWQXGBenhFq0E2SepJLjLftH71526Rct5HD
 JUYgOXz4Cfd/RZEiXHrriBovtaAjLg2LhXkLt+kb5cVEAQO1HRlwZ9RxD5lPAl3A7/4EK3YmR1vhy63defIQtNuS6y3mvkQeA6D4vtqNU6W/+dLQLIHN+fFT
 QbsnJB/FaWA4ISoNsiY49KGKe/CzBbOFvvrv2LgBLh/V2S2AJSJUATtFQtfQP7fu1+7USglFBnSOS0H1TDvexqp/fgGZLKYfqBHSgNEz1sdYE0ExXfOfiM70
 CLBr+tuNbh0Xilmcos+DIfyMCvcEkA==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56664
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
