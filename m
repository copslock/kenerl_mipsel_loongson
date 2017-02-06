Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 22:52:00 +0100 (CET)
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:35550 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992121AbdBFVvxxEqBT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 22:51:53 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id arCKcb37bcWiHarCLclgeZ; Mon, 06 Feb 2017 14:51:47 -0700
X-Authority-Analysis: v=2.2 cv=JLBLi4Cb c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=JasKRrlFe7e3P3rDF2sA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 406B833ABBB0; Mon,  6 Feb 2017 13:51:36 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] cpufreq: bmips-cpufreq: Add CPUfreq driver for Broadcom's BMIPS SoCs
Date:   Mon,  6 Feb 2017 13:51:15 -0800
Message-Id: <20170206215119.87099-1-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
X-CMAE-Envelope: MS4wfA3KF5kqwANgXFwOZZyqmUigdntmGCGrHJtNwPFEz4mXN21KpuuWDUXr+StYpGkl0MaIDE9TMI6XKYCAIh0DtXGZSr5ApFYic2uVQX8XzRtkwCeDDHO/
 bhCNko7Y81D2M16WT14LaBs+mdWgYB+kl0nAkqdqlZUmnIYvV9UdurVlhu4u60umGxpi/SP3JO1oaJp+4GSorQb+7ZAD8kV3hE9xouvzRzoVUtXsXcuJ8FWe
 0FUxtrxnJDZ0xRWAZGiRN9DjSrUOUN70s0FLdclRjL9PokMzoZxOrmkR+YPacks+U7cHUXB8rA0MruZ48QwaiOSeZwPs+uF1UHD57wv3NaIhFkv9OtwU9L3C
 zMA3bi9minOPXXkspeUP9HgZqhxEiw==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56662
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

The very first patch contains updates to bmips_stb_defconfig that are
unrelated to this series. Looks like bmips_stb_defconfig hasn't been
updated in a while. I didn't want to mix those changes with the CPUfreq
related ones, so that patch now comes first in the series and is
independent of the CPUfreq related changes to bmips_stb_defconfig
(patch 4/4).

This series is based on pm/linux-next.

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
 drivers/cpufreq/bmips-cpufreq.c       | 195 ++++++++++++++++++++++++++++++++++
 5 files changed, 218 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/bmips-cpufreq.c

-- 
2.7.4
