Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 12:13:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44100 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011280AbbKCLNcAJVB1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 12:13:32 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id D937641EF9184;
        Tue,  3 Nov 2015 11:13:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 3 Nov 2015 11:13:22 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Nov 2015 11:13:21 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH 00/14] Implement generic IPI support mechanism
Date:   Tue, 3 Nov 2015 11:12:47 +0000
Message-ID: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49803
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

The first 9 patches add the new functionality in the generic code.

Patches 10-13 make MIPS GIC irqchip driver support the new API and move MIPS
arch code to use the new generic IPI mechanism if the irqchip driver supports it.

Patch 14 adds IRQ-ipi.txt to Documentation explaining the new API and how to
make use of it.

This series is built on last RFC discussion[1]. I should have taken all
comments into account and hopefully haven't missed any.

This series is based on 4.3 irq/core.

Thanks,
Qais

[1] https://lkml.org/lkml/2015/10/13/227

Qais Yousef (14):
  genirq: Add new IRQ_DOMAIN_FLAGS_IPI
  genirq: Add DOMAIN_BUS_IPI
  genirq: Add GENERIC_IRQ_IPI Kconfig symbol
  genirq: Add new struct ipi_mask and helper functions
  genirq: Add struct ipi_mask to irq_data
  genirq: Add struct ipi_mapping and its helper functions
  genirq: Add a new generic IPI reservation code to irq core
  genirq: Add a new irq_send_ipi() to irq_chip
  genirq: Implement irq_send_ipi() to be used by drivers
  irqchip/mips-gic: Add a IPI hierarchy domain
  MIPS: Add generic SMP IPI support
  MIPS: Make smp CMP, CPS and MT use the new generic IPI functions
  MIPS: Delete smp-gic.c
  Docs: IRQ: Add new IRQ-ipi.txt

 Documentation/IRQ-ipi.txt        |  81 +++++++++++++
 arch/mips/Kconfig                |   6 -
 arch/mips/include/asm/smp-ops.h  |   5 +-
 arch/mips/kernel/Makefile        |   1 -
 arch/mips/kernel/smp-cmp.c       |   4 +-
 arch/mips/kernel/smp-cps.c       |   4 +-
 arch/mips/kernel/smp-gic.c       |  64 ----------
 arch/mips/kernel/smp-mt.c        |   2 +-
 arch/mips/kernel/smp.c           | 136 ++++++++++++++++++++++
 drivers/irqchip/Kconfig          |   2 +
 drivers/irqchip/irq-mips-gic.c   | 244 +++++++++++++++++++++++++--------------
 include/linux/irq.h              | 101 ++++++++++++++++
 include/linux/irqchip/mips-gic.h |   3 -
 include/linux/irqdomain.h        |  20 ++++
 kernel/irq/Kconfig               |   4 +
 kernel/irq/irqdomain.c           |  98 ++++++++++++++++
 kernel/irq/manage.c              | 151 ++++++++++++++++++++++++
 17 files changed, 757 insertions(+), 169 deletions(-)
 create mode 100644 Documentation/IRQ-ipi.txt
 delete mode 100644 arch/mips/kernel/smp-gic.c

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org

-- 
2.1.0
