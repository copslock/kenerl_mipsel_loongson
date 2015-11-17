Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 19:01:02 +0100 (CET)
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:41450 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006617AbbKRSBAyNG9A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 19:01:00 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id B07D9DAC988;
        Tue, 17 Nov 2015 20:35:21 +0100 (CET)
Received: from localhost.localdomain (unknown [80.171.215.189])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 148EAA6254;
        Tue, 17 Nov 2015 20:35:03 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 0/6] MIPS: ath79: Move the IRQ drivers to drivers/irqchip
Date:   Tue, 17 Nov 2015 20:34:50 +0100
Message-Id: <1447788896-15553-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Hi all,

A first round of cleanup on the IRQ code to move most of it to
drivers/irqchip. After this the handlers for the cascaded interrupts on the
 ar934x and qca955x is the only IRQ code left in the platform directory.
For these two a new driver must be written first.

Alban

Alban Bedel (6):
  MIPS: ath79: Fix the size of the MISC INTC registers in ar9132.dtsi
  MIPS: ath79: irq: Remove useless #ifdef CONFIG_IRQCHIP
  MIPS: ath79: irq: Prepare moving the MISC driver to drivers/irqchip
  MIPS: ath79: irq: Move the MISC driver to drivers/irqchip
  MIPS: ath79: Allow using ath79_ddr_wb_flush() from drivers
  MIPS: ath79: irq: Move the CPU IRQ driver to drivers/irqchip

 arch/mips/ath79/common.h                 |   1 -
 arch/mips/ath79/irq.c                    | 249 +++----------------------------
 arch/mips/boot/dts/qca/ar9132.dtsi       |   2 +-
 arch/mips/include/asm/mach-ath79/ath79.h |   5 +
 drivers/irqchip/Makefile                 |   2 +
 drivers/irqchip/irq-ath79-cpu.c          |  97 ++++++++++++
 drivers/irqchip/irq-ath79-misc.c         | 182 ++++++++++++++++++++++
 7 files changed, 308 insertions(+), 230 deletions(-)
 create mode 100644 drivers/irqchip/irq-ath79-cpu.c
 create mode 100644 drivers/irqchip/irq-ath79-misc.c

-- 
2.0.0
