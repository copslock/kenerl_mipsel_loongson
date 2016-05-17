Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 16:31:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65080 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006514AbcEQObadGkgo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 16:31:30 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 4BF3CB93A7227;
        Tue, 17 May 2016 15:31:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 17 May 2016 15:31:24 +0100
Received: from localhost (10.100.200.141) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 17 May
 2016 15:31:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Joe Perches" <joe@perches.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 0/3] External Interrupt Controller (EIC) fixes
Date:   Tue, 17 May 2016 15:31:03 +0100
Message-ID: <1463495466-29689-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53486
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

This series fixes a few small issues with support for External Interrupt
Controllers (cpu_has_veic), ensuring that it is configured to service
all interrupts by default & that when a GIC is present it's enabled when
expected.

Applies atop v4.6.

Paul Burton (3):
  MIPS: Clear Status IPL field when using EIC
  MIPS: smp-cps: Clear Status IPL field when using EIC
  irqchip: mips-gic: Setup EIC mode on each CPU if it's in use

 arch/mips/kernel/irq.c         |  3 +++
 arch/mips/kernel/smp-cps.c     |  8 ++++++--
 drivers/irqchip/irq-mips-gic.c | 10 +++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.8.2
