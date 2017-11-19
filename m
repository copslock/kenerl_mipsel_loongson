Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 15:36:31 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:55196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992998AbdKSOfQSChRi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 15:35:16 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E977B722;
        Sun, 19 Nov 2017 14:35:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.4 50/59] MIPS: Netlogic: Exclude netlogic,xlp-pic code from XLR builds
Date:   Sun, 19 Nov 2017 15:32:58 +0100
Message-Id: <20171119143153.182271493@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171119143150.964013720@linuxfoundation.org>
References: <20171119143150.964013720@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>


[ Upstream commit 9799270affc53414da96e77e454a5616b39cdab0 ]

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

[ralf@linux-mips.org: Fixed up as per Jayachandran's suggestion.]

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jayachandran C <jchandra@broadcom.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14524/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/netlogic/common/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -275,7 +275,7 @@ asmlinkage void plat_irq_dispatch(void)
 	do_IRQ(nlm_irq_to_xirq(node, i));
 }
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_CPU_XLP
 static const struct irq_domain_ops xlp_pic_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
@@ -348,7 +348,7 @@ void __init arch_init_irq(void)
 #if defined(CONFIG_CPU_XLR)
 	nlm_setup_fmn_irq();
 #endif
-#if defined(CONFIG_OF)
+#ifdef CONFIG_CPU_XLP
 	of_irq_init(xlp_pic_irq_ids);
 #endif
 }
