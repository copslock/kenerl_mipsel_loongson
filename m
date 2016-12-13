Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 12:01:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6213 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993009AbcLMK7XAj2YS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2016 11:59:23 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 56E724E9002F;
        Tue, 13 Dec 2016 10:59:13 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 13 Dec 2016 10:59:15 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] MIPS: Select HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Tue, 13 Dec 2016 10:59:05 +0000
Message-ID: <1481626745-4290-6-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481626745-4290-1-git-send-email-matt.redfearn@imgtec.com>
References: <1481626745-4290-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56031
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

Since do_IRQ is now invoked on a separate IRQ stack, we select
HAVE_IRQ_EXIT_ON_IRQ_STACK so that softirq's may be invoked directly
from irq_exit(), rather than requiring do_softirq_own_stack.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2: None

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde43d34..80832aa8e4fb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -9,6 +9,7 @@ config MIPS
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
-- 
2.7.4
