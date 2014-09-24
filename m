Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 11:48:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31606 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007197AbaIXJs52YPPK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 11:48:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EBDBB55B8587E
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:48:48 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:48:50 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Sep 2014 10:48:50 +0100
Received: from pburton-laptop.home (192.168.159.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:48:49 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/11] MIPS: clear MSACSR cause bits when handling MSA FP exception
Date:   Wed, 24 Sep 2014 10:45:36 +0100
Message-ID: <1411551942-11153-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.158]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42760
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

Much like for traditional scalar FP exceptions, the cause bits in the
MSACSR register need to be cleared following an MSA FP exception.
Without doing so the exception will simply be raised again whenever
the kernel restores MSACSR from a tasks saved context, leading to
undesirable spurious exceptions. Clear the cause bits from the
handle_msa_fpe function, mirroring the way handle_fpe clears the
cause bits in FCSR.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/genex.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index ac35e12..ae84496 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -367,6 +367,15 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	STI
 	.endm
 
+	.macro	__build_clear_msa_fpe
+	_cfcmsa	a1, MSA_CSR
+	li	a2, ~(0x3f << 12)
+	and	a2, a1
+	_ctcmsa	MSA_CSR, a1
+	TRACE_IRQS_ON
+	STI
+	.endm
+
 	.macro	__build_clear_ade
 	MFC0	t0, CP0_BADVADDR
 	PTR_S	t0, PT_BVADDR(sp)
@@ -425,7 +434,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER cpu cpu sti silent		/* #11 */
 	BUILD_HANDLER ov ov sti silent			/* #12 */
 	BUILD_HANDLER tr tr sti silent			/* #13 */
-	BUILD_HANDLER msa_fpe msa_fpe sti silent	/* #14 */
+	BUILD_HANDLER msa_fpe msa_fpe msa_fpe silent	/* #14 */
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
 	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
 	BUILD_HANDLER msa msa sti silent		/* #21 */
-- 
2.0.4
