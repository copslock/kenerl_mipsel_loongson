Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 13:22:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54622 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011789AbbLBMWPM8eAA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 13:22:15 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id AEFEE419A8F87;
        Wed,  2 Dec 2015 12:22:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 2 Dec 2015 12:22:08 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 2 Dec 2015 12:22:08 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v3 00/19] Implement generic IPI support mechanism
Date:   Wed, 2 Dec 2015 12:21:41 +0000
Message-ID: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

This series adds support for a generic IPI mechanism that can be used by both
arch and drivers to send IPIs to other CPUs.

v3 removes the use of struct ipi_mask and moves to using cpumask only.
The assumption is that the user would need to set NR_CPUS to a suitable value to
cater for coprocessors outside linux SMP range.

We use irq_common_data affinity to store the ipi_mask too.

This series is still based on irq/core 4.3 since 4.4-rcs has mips build issues.
I'll rebase once they're fixed.

Thanks,
Qais

Qais Yousef (19):
  genirq: Add new IRQ_DOMAIN_FLAGS_IPI
  genirq: Add DOMAIN_BUS_IPI
  genirq: Add GENERIC_IRQ_IPI Kconfig symbol
  genirq: Add struct ipi_mapping and its helper functions
  genirq: Add ipi_offset to irq_common_data
  genirq: Add an extra comment about the use of affinity in
    irq_common_data
  genirq: Make irq_domain_alloc_descs() non static
  genirq: Add a new generic IPI reservation code to irq core
  genirq: Add a new function to get IPI reverse mapping
  genirq: Add a new irq_send_ipi() to irq_chip
  genirq: Implement ipi_send_{mask, single}()
  irqchip/mips-gic: Add a IPI hierarchy domain
  irqchip/mips-gic: Add device hierarchy domain
  irqchip/mips-gic: Use gic_vpes instead of NR_CPUS
  irqchip/mips-gic: Clear percpu_masks correctly when mapping
  MIPS: Add generic SMP IPI support
  MIPS: Make smp CMP, CPS and MT use the new generic IPI functions
  MIPS: Delete smp-gic.c
  irqchip/mips-gic: Add new DT property to reserve IPIs

 .../bindings/interrupt-controller/mips-gic.txt     |   7 +
 arch/mips/Kconfig                                  |   6 -
 arch/mips/include/asm/smp-ops.h                    |   5 +-
 arch/mips/kernel/Makefile                          |   1 -
 arch/mips/kernel/smp-cmp.c                         |   4 +-
 arch/mips/kernel/smp-cps.c                         |   4 +-
 arch/mips/kernel/smp-gic.c                         |  64 ---
 arch/mips/kernel/smp-mt.c                          |   2 +-
 arch/mips/kernel/smp.c                             | 136 +++++++
 drivers/irqchip/Kconfig                            |   2 +
 drivers/irqchip/irq-mips-gic.c                     | 353 ++++++++++++-----
 include/linux/irq.h                                |  61 ++-
 include/linux/irqchip/mips-gic.h                   |   3 -
 include/linux/irqdomain.h                          |  46 +++
 kernel/irq/Kconfig                                 |   4 +
 kernel/irq/Makefile                                |   1 +
 kernel/irq/ipi.c                                   | 437 +++++++++++++++++++++
 kernel/irq/irqdomain.c                             |   6 +-
 18 files changed, 965 insertions(+), 177 deletions(-)
 delete mode 100644 arch/mips/kernel/smp-gic.c
 create mode 100644 kernel/irq/ipi.c

-- 
2.1.0
