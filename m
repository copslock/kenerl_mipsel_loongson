Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 02:06:43 +0100 (CET)
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:36897 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993900AbdBBBG10npvl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 02:06:27 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id Z5qscVsuNVQuxZ5qtc0uy0; Wed, 01 Feb 2017 18:06:21 -0700
X-Authority-Analysis: v=2.2 cv=BNTDlBYG c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=yG1wFZ-RLMJnsVyPFoEA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 2950F337850F; Wed,  1 Feb 2017 17:06:18 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
Date:   Wed,  1 Feb 2017 17:05:59 -0800
Message-Id: <20170202010601.75995-2-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170202010601.75995-1-code@mmayer.net>
References: <20170202010601.75995-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfBm3V/xllhwPYFeCbbdnQoyTHaMgZmpL47ZhRGCNqJeNZZKb3L+Ta2Ek/2zFrPrXGKQq55pxDBS+cVeVWvzYOjuQtTDU64L3uaK/xnJ2KGO3ZQHzECob
 57v1zqozKmOguaMYS4Yg0do0nWKlKgzbPExLFdohr/nO9CdTmOX5b9ikHLjCIJs5503bPKLdgXZWhwpcI0G2n43slgiQO1TUK1iP5KUypAtnDcPLoiOX1+Yt
 NdZIftUH5YKDW9VAYop4qkYxH5pKtXkB+tZC3i7syj2Kjc78Fh2qSSYLH9D91nnOo8Zta1C6UsPAFwHRb0n7p5gYRMkek7fW5h2aiTa3GkVp7hfWR7BEbD/7
 CA/cZsWK6Drxg/2XbpTbIw9S6zN8Hg==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56582
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
