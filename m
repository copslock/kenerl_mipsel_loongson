Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 13:05:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64931 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991786AbdCaLFoLtdBd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 13:05:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1413825ABC9E3;
        Fri, 31 Mar 2017 12:05:35 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 12:05:37 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/2] Fix v4.11 malta_defconfig regressions
Date:   Fri, 31 Mar 2017 12:05:30 +0100
Message-ID: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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


Since v4.11-rc1, 3 regressions have been observed on the Malta platform,
using malta_defconfig. which prevent it booting. These patches fix 2 of
them. The third one is that malta_defconfig, which uses SMP-MT, no
longer sets up its IPIs correctly resulting is a string of messages
like:

irq 23: nobody cared (try booting with the "irqpoll" option)
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.11.0-rc4 #421
Stack : 00000000 00000000 00000000 00000000 807cdff2 00000047 00000000 0000003d
        80741327 8f093194 806c191c 00000000 00000001 807c9acc 80756078 807d0000
        807cdbe4 80177c78 00000003 0000003c 00000006 80177a04 806c70a8 8f02be8c
        00000006 801b4c8c 00000000 00000000 ffffffff 00000000 8f02be8c 80740000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        ...
Call Trace:
[<8010c6c0>] show_stack+0x88/0xa4
[<80380fb8>] dump_stack+0x88/0xd0
[<8017cf64>] __report_bad_irq+0x48/0x108
[<8017d2d4>] note_interrupt+0x1c0/0x2fc
[<80179ed4>] handle_irq_event_percpu+0x4c/0x64
[<8017eafc>] handle_percpu_irq+0x88/0xb8
[<801791c0>] generic_handle_irq+0x40/0x58
[<80108664>] do_IRQ+0x18/0x24
[<803b83fc>] plat_irq_dispatch+0x54/0xa8
handlers:
Disabling IRQ #23

This regression is fixed by Paul Burtons series "MIPS/irqchip: Use IPI
IRQ domains for CPU interrupt controller IPIs", but it is a large change
for this stage in the cycle so I don't know how best to proceed with
that one.



Matt Redfearn (2):
  MIPS: Malta: Fix i8259 irqchip setup
  irqchip/mips-gic: Fix Local compare interrupt

 arch/mips/mti-malta/malta-int.c | 13 +++++++++++++
 drivers/irqchip/irq-mips-gic.c  |  4 ++++
 2 files changed, 17 insertions(+)

-- 
2.7.4
