Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 22:59:25 +0100 (CET)
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:59284 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992127AbdBGV7S1njXC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 22:59:18 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id bDn2coAAUsa1kbDn3clLZy; Tue, 07 Feb 2017 14:59:11 -0700
X-Authority-Analysis: v=2.2 cv=W+NIbVek c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=NEAV23lmAAAA:8 a=R7i0YIe9GHvLfq0SDbgA:9
 a=Fp8MccfUoT0GBdDC_Lng:22 a=Bn2pgwyD2vrAyMmN8A2t:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 510FA33B35ED; Tue,  7 Feb 2017 13:59:07 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] cpufreq: bmips-cpufreq: Add CPUfreq driver for Broadcom's BMIPS SoCs
Date:   Tue,  7 Feb 2017 13:58:52 -0800
Message-Id: <20170207215856.8999-1-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
X-CMAE-Envelope: MS4wfDTv+g/a9d+2qIbByAWCI5tfd6dxGwn8+R6LL/Cj1nI8pQI7gU0ZMlaWhVh5TacOzwkyx63onHWOm4SxObsLWr44PCRWiiyhdAwbFspX8v+GcOWpNLlf
 SJUW6HpGQxJzjdaDyx/Y1Kkzv+/s8dcFJzgwjBplUE+mKYvdxam0UftxkXaZ7GUtL/hSjZNLWylZaytiG4HGI5s4cE0P66WiMKRmhJEYcxE6xaYCNwkC/78X
 U7oTEVQPDAw6VMvvwDvbU0F8KNDedq+PYO2g5q9/wlbU3mzeUnZ0zf/WaJ4CfRa5hCkr4OgsDCy+EngBeic0xNo28k6FTDTXKF3LReaZ7JmUthoqEAVZpzhr
 IWn3ZP1IWPvogAKJjhsfX8S8aCjahQ==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56700
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

Sorry for the new iteration. I found two more simplifications, so here
goes. Only patch 3/4 has changed.

This series adds a CPUfreq driver for the BMIPS SoCs. In the first
iteration only BMIPS5xxx SoCs are supported.

This series is based on pm/linux-next.

The series is also available at
https://github.com/mmayer/linux/tree/bmips-cpufreq-v3

Changes since v2:
  - remove local variables freq and cpu_freq in bmips_cpufreq_get()
  - assign global variable "priv" directly in bmips_cpufreq_probe()
    rather than setting driver_data and then retrieving it from there
    to set priv in bmips_cpufreq_init()

Changes since v1:
  - based on pm/linux-next rather than 4.10-rc1
  - sanitized bmips_stb_defconfig by running "make savedefconfig"; this
    also lead to an additional patch (1/4), which contains non-CPUfreq
    related updates that "make savedefconfig" performed
  - use gobal variable to store driver data rather than policy->driver_data
  - got rid of some code as a result of using said global variable
  - kzalloc -> kmalloc
  - removed policy->freq_table = NULL;

Markus Mayer (4):
  MIPS: BMIPS: Update defconfig
  BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
  cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
  MIPS: BMIPS: enable CPUfreq

 arch/mips/Kconfig                     |   2 +
 arch/mips/configs/bmips_stb_defconfig |  16 +--
 drivers/cpufreq/Kconfig               |  10 ++
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/bmips-cpufreq.c       | 188 ++++++++++++++++++++++++++++++++++
 5 files changed, 211 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/bmips-cpufreq.c

-- 
2.7.4
