Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 12:16:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18144 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006648AbbJMKQncZLvs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 12:16:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2A7696FB04D89;
        Tue, 13 Oct 2015 11:16:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 11:16:37 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 13 Oct 2015 11:16:36 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [RFC v2 PATCH 00/14] Implement generic IPI support mechanism
Date:   Tue, 13 Oct 2015 11:16:08 +0100
Message-ID: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49496
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

This RFC series attempts to implement a generic IPI layer for reserving and sending IPIs.

It is based on the discussion in these links

	https://lkml.org/lkml/2015/8/26/713
	https://lkml.org/lkml/2015/9/29/875

In summary. We need a generic IPI layer to allow driver code to send IPIs to coprocessor
without caring about implementation details of the underlying controller.

Also it will help in making SMP IPI support more generic.

The goal is to have a mechanism to dynamically reserve an IPI to destination CPUs and
provide a single virq to send an IPI to any of these CPUs using generic irq_send_ipi()
API.

This v2 addresses the comments from v1 and implements a simpler mapping mechanism and moves
the irq_send_ipi() to be part of irqchip instead of irqdomain.

The implementation falls more natural and fits into place now (hopefully). So hopefully next
series would be non RFC. The only thing I haven't addressed is whether we want to make
request_percpu_irq() enable a coprocessor or defer that to the coprocessor itself.

This series is based on Linus tree. I couldn't compile test it because MIPS compilation was
broken due to other reasons. I expect some brokeness because of the introduction of
struct irq_common_data which is not present on the 4.1 tree I was testing my code on before
porting it to Linus tip. I will fix these issues and introduce proper accessors for accessing
struct ipi_mask given that the concept is approved.

I hope my commit messages aren't too terse.

Credit goes to Thomas for spec'ing and outlining the proper way to get this new API in.

Qais Yousef (14):
  irq: add new IRQ_DOMAIN_FLAGS_IPI
  irq: add GENERIC_IRQ_IPI Kconfig symbol
  irq: add new struct ipi_mask
  irq: add a new irq_send_ipi() to irq_chip
  irq: add struct ipi_mask to irq_data
  irq: add struct ipi_mapping and its helper functions
  irq: add a new generic IPI reservation code to irq core
  irq: implement irq_send_ipi
  MIPS: add support for generic SMP IPI support
  MIPS: make smp CMP, CPS and MT use the new generic IPI functions
  MIPS: delete smp-gic.c
  irqchip: mips-gic: add a IPI hierarchy domain
  irqchip: mips-gic: implement the new irq_send_ipi
  irqchip: mips-gic: remove IPI init code

 arch/mips/Kconfig                |   6 --
 arch/mips/include/asm/smp-ops.h  |   5 +-
 arch/mips/kernel/Makefile        |   1 -
 arch/mips/kernel/smp-cmp.c       |   4 +-
 arch/mips/kernel/smp-cps.c       |   4 +-
 arch/mips/kernel/smp-gic.c       |  64 -----------
 arch/mips/kernel/smp-mt.c        |   2 +-
 arch/mips/kernel/smp.c           | 117 ++++++++++++++++++++
 drivers/irqchip/Kconfig          |   2 +
 drivers/irqchip/irq-mips-gic.c   | 225 ++++++++++++++++++++++++---------------
 include/linux/irq.h              |  43 ++++++++
 include/linux/irqchip/mips-gic.h |   3 -
 include/linux/irqdomain.h        |  19 ++++
 kernel/irq/Kconfig               |   4 +
 kernel/irq/irqdomain.c           |  84 +++++++++++++++
 kernel/irq/manage.c              | 103 ++++++++++++++++++
 16 files changed, 517 insertions(+), 169 deletions(-)
 delete mode 100644 arch/mips/kernel/smp-gic.c

-- 
2.1.0
