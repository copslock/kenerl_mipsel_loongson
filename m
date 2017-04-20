Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 11:07:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4674 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991087AbdDTJHrhuoid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 11:07:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6C054408C5480;
        Thu, 20 Apr 2017 10:07:38 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 20 Apr 2017 10:07:40 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] irqchip: mips-gic: Remove dev domain & fixes
Date:   Thu, 20 Apr 2017 10:07:33 +0100
Message-ID: <1492679256-14513-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57736
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


This series fixes a couple of issues with the MIPS GIC driver and also
vastly simplifies it by removing the separate dev domain.

The first patch fixes a long standing issue with IPI reservation.
The second patch reqorks the driver to simplify it by removing the
overly complex device IRQ domain.
The third fixes an issue seen in v4.11 which broke the Malta platforms
legacy IRQ controller.

These patches have been tested on multiple MIPS platforms including
Malta, Boston, Ci40 and SEAD3.



Matt Redfearn (1):
  irqchip: mips-gic: Replace static map with dynamic

Paul Burton (2):
  irqchip: mips-gic: Separate IPI reservation & usage tracking
  irqchip: mips-gic: Remove device IRQ domain

 drivers/irqchip/irq-mips-gic.c | 338 +++++++++++++----------------------------
 1 file changed, 106 insertions(+), 232 deletions(-)

-- 
2.7.4
