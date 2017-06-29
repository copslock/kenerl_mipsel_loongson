Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 11:14:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5718 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993866AbdF2JNCqg87W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 11:13:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C3B019153E5F2;
        Thu, 29 Jun 2017 10:12:49 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 29 Jun 2017 10:12:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 1/4] MIPS: Drop duplicate HAVE_SYSCALL_TRACEPOINTS select
Date:   Thu, 29 Jun 2017 10:12:33 +0100
Message-ID: <013df3113da2ad1d4f95b528a54df971ee342f6d.1498727356.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <cover.7467c3bd7867c61afc334e409c93dac28541f5e6.1498727356.git-series.james.hogan@imgtec.com>
References: <cover.7467c3bd7867c61afc334e409c93dac28541f5e6.1498727356.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

MIPS selects HAVE_SYSCALL_TRACEPOINTS twice. The first was added back in
v3.13 by commit 2d7bf993e073 ("MIPS: ftrace: Add support for syscall
tracepoints."), but then a second redundant one was added in v4.2 by
commit fb59e394c30c ("MIPS: ftrace: Enable support for syscall
tracepoints.").

Drop the duplicate select.

Fixes: fb59e394c30c ("MIPS: ftrace: Enable support for syscall tracepoints.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig | 1 -
 1 file changed, 0 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 609986e8b21e..55e48a3e7f05 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -64,7 +64,6 @@ config MIPS
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
-- 
git-series 0.8.10
