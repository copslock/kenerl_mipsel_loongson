Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:20:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42642 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007016AbbLHNU6P2jvZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:20:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 04F2FB7E2336F;
        Tue,  8 Dec 2015 13:17:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:20:51 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:20:50 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 00/19] Implement generic IPI support mechanism
Date:   Tue, 8 Dec 2015 13:20:11 +0000
Message-ID: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50424
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

v4 is rebased on tip of irq/core and fixes a bug in ipi_send_single() where we
were passing the basevirq irq_data instead of the irq_data for the target cpu.

v3 removed the use of struct ipi_mask and moved to using cpumask only.
The assumption is that the user would need to set NR_CPUS to a suitable value to
cater for coprocessors outside linux SMP range.

We use irq_common_data affinity to store the ipi_mask too. Maybe we need to
separate them later, but I think it can be done safely later if the need arises.

This is boot tested on Malta platform.

Note that of_irq_find_parent() was moved to be static and could cause this patch
series not to compile. The issue was reported and a fix to undo that change
is in the pipeline (in the DT tree I guess).

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
 arch/mips/kernel/smp-mt.c                          |   2 +-
 arch/mips/kernel/smp.c                             | 136 +++++++
 drivers/irqchip/Kconfig                            |   2 +
 drivers/irqchip/irq-mips-gic.c                     | 354 ++++++++++++-----
 include/linux/irq.h                                |  61 ++-
 include/linux/irqchip/mips-gic.h                   |   3 -
 include/linux/irqdomain.h                          |  45 +++
 kernel/irq/Kconfig                                 |   4 +
 kernel/irq/Makefile                                |   1 +
 kernel/irq/ipi.c                                   | 441 +++++++++++++++++++++
 kernel/irq/irqdomain.c                             |   6 +-
 17 files changed, 969 insertions(+), 113 deletions(-)
 create mode 100644 kernel/irq/ipi.c

-- 
2.1.0
