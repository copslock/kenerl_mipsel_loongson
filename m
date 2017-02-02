Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 02:06:22 +0100 (CET)
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:52364 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993883AbdBBBGPjYPsl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 02:06:15 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id Z5qfcu5GRsa1kZ5qhcJ3vM; Wed, 01 Feb 2017 18:06:08 -0700
X-Authority-Analysis: v=2.2 cv=W+NIbVek c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=rvSBo0zzLkEVHouOQ7EA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id CC3ED337850D; Wed,  1 Feb 2017 17:06:05 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
Date:   Wed,  1 Feb 2017 17:05:58 -0800
Message-Id: <20170202010601.75995-1-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
X-CMAE-Envelope: MS4wfH5yQ3LjYcc+LBVjCgtMrpW14T+cXpwEC5WnpMmcksL1yK/xSa6L6zJtx+a+DK8Yfwig002KOW70zvbBAMcjo3uvcAKaYdfPf7rnoJl2habbTpwmcEHe
 8Ab7/O2tNcZeznPBVsexOokyZSHttJDx6i3ln149WGmc0FubxpzxfJc/e1Mdb4E+/nPA/CDrGGdjyK2YbfQ8lS0MVI/xlmefqegWJI1vnjbZkuaxnxZhB7B2
 /K3BJGJroBXT12T9adEPTYH2Gj+kvLDbxPiERAU6oCDnxD1y/jX0AeFPA9lBRoLl0FjJxazpBCQdhtwiuxzIKypOXaPkL5QATuYdF+1YKegP644lPaCHyYQ+
 R9s04MuN/mzewLexGI8Pm24t0cL+Gw==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56581
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

This series adds a CPUfreq driver for the BMIPS SoCs. In the first
iteration only BMIPS5xxx SoCs are supported.

This series is based on 4.10-rc1.

Markus Mayer (3):
  BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
  cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
  MIPS: BMIPS: enable CPUfreq

 arch/mips/Kconfig                     |   2 +
 arch/mips/configs/bmips_stb_defconfig |  10 ++
 drivers/cpufreq/Kconfig               |  10 ++
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/bmips-cpufreq.c       | 205 ++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 drivers/cpufreq/bmips-cpufreq.c

-- 
2.7.4
