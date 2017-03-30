Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 21:06:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65180 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992155AbdC3TGmDv5sr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 21:06:42 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2DB1C5826775E;
        Thu, 30 Mar 2017 20:06:32 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Mar 2017 20:06:35
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/5] MIPS/irqchip: Use IPI IRQ domains for CPU interrupt controller IPIs
Date:   Thu, 30 Mar 2017 12:06:08 -0700
Message-ID: <20170330190614.14844-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series introduces support for IPI IRQ domains to the CPU interrupt
controller driver, allowing IPIs to function in the same way as those
provided by the MIPS GIC as far as platform/board code is concerned.

Doing this allows us to avoid duplicating code across platforms, avoid
having to handle cases where IPI domains are or aren't in use depending
upon the interrupt controller, and strengthen a sanity check for cases
where IPI IRQ domains are supported.

Applies atop v4.11-rc4.


Paul Burton (5):
  irqchip: mips-cpu: Replace magic 0x100 with IE_SW0
  irqchip: mips-cpu: Prepare for non-legacy IRQ domains
  irqchip: mips-cpu: Introduce IPI IRQ domain support
  MIPS: smp-mt: Use CPU interrupt controller IPI IRQ domain support
  MIPS: Stengthen IPI IRQ domain sanity check

 arch/mips/kernel/smp-mt.c       |  49 ++------------
 arch/mips/kernel/smp.c          |  20 +++---
 arch/mips/lantiq/irq.c          |  52 --------------
 arch/mips/mti-malta/malta-int.c |  83 ++---------------------
 drivers/irqchip/Kconfig         |   2 +
 drivers/irqchip/irq-mips-cpu.c  | 146 +++++++++++++++++++++++++++++++++++-----
 6 files changed, 151 insertions(+), 201 deletions(-)

-- 
2.12.1
