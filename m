Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:31:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23902 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991964AbcKGLbIIQyns (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:31:08 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D4447ABF800D3;
        Mon,  7 Nov 2016 11:30:58 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:31:00 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH] MIPS: netlogic: Exclude netlogic,xlp-pic code from XLR builds
Date:   Mon, 7 Nov 2016 11:30:41 +0000
Message-ID: <20161107113042.15821-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55703
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

Code in arch/mips/netlogic/common/irq.c which handles the XLP PIC fails
to build in XLR configurations due to cpu_is_xlp9xx not being defined,
leading to the following build failure:

    arch/mips/netlogic/common/irq.c: In function ‘xlp_of_pic_init’:
    arch/mips/netlogic/common/irq.c:298:2: error: implicit declaration
    of function ‘cpu_is_xlp9xx’ [-Werror=implicit-function-declaration]
      if (cpu_is_xlp9xx()) {
      ^

Although the code was conditional upon CONFIG_OF which is indirectly
selected by CONFIG_NLM_XLP_BOARD but not CONFIG_NLM_XLR_BOARD, the
failing XLR with CONFIG_OF configuration can be configured manually or
by randconfig.

Fix the build failure by making the affected XLP PIC code conditional
upon CONFIG_CPU_XLP which is used to guard the inclusion of
asm/netlogic/xlp-hal/xlp.h that provides the required cpu_is_xlp9xx
function.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jayachandran C <jchandra@broadcom.com>
---

 arch/mips/netlogic/common/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 3660dc6..b04eca1 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -275,7 +275,7 @@ asmlinkage void plat_irq_dispatch(void)
 	do_IRQ(nlm_irq_to_xirq(node, i));
 }
 
-#ifdef CONFIG_OF
+#if defined(CONFIG_CPU_XLP) && defined(CONFIG_OF)
 static const struct irq_domain_ops xlp_pic_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
@@ -348,7 +348,7 @@ void __init arch_init_irq(void)
 #if defined(CONFIG_CPU_XLR)
 	nlm_setup_fmn_irq();
 #endif
-#if defined(CONFIG_OF)
+#if defined(CONFIG_CPU_XLP) && defined(CONFIG_OF)
 	of_irq_init(xlp_pic_irq_ids);
 #endif
 }
-- 
2.10.2
