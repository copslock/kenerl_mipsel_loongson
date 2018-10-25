Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2018 16:19:37 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994811AbeJYOSwrct9D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Oct 2018 16:18:52 +0200
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5312086D;
        Thu, 25 Oct 2018 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477126;
        bh=hIvPKx2oc/McEQE50nc1HYzqMBR+VVEEC3YMY/QE7vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDnftyW/A3FxGxfJyRxBd8yWI9xz+aRkETQnWMvKz1AD+9r3X2TK4rsYgxacqnjcp
         pbZEolyHUir/iHi7G/Mr88oIAo20un8A0rZWqjU1Pq2pGxxH9aXrrqQOuuClI5VBEY
         Cg4JCDc25e9qkovwreqQNxGRVEAyo96QMM6249QM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 65/65] MIPS: DEC: Fix an int-handler.S CPU_DADDI_WORKAROUNDS regression
Date:   Thu, 25 Oct 2018 10:17:05 -0400
Message-Id: <20181025141705.213937-65-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sashal@kernel.org
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

From: "Maciej W. Rozycki" <macro@linux-mips.org>

[ Upstream commit 68fe55680d0f3342969f49412fceabb90bdfadba ]

Fix a commit 3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in
delay slots") regression and remove assembly errors:

arch/mips/dec/int-handler.S: Assembler messages:
arch/mips/dec/int-handler.S:162: Error: Macro used $at after ".set noat"
arch/mips/dec/int-handler.S:163: Error: Macro used $at after ".set noat"
arch/mips/dec/int-handler.S:229: Error: Macro used $at after ".set noat"
arch/mips/dec/int-handler.S:230: Error: Macro used $at after ".set noat"

triggering with with the CPU_DADDI_WORKAROUNDS option set and the DADDIU
instruction.  This is because with that option in place the instruction
becomes a macro, which expands to an LI/DADDU (or actually ADDIU/DADDU)
sequence that uses $at as a temporary register.

With CPU_DADDI_WORKAROUNDS we only support `-msym32' compilation though,
and this is already enforced in arch/mips/Makefile, so choose the 32-bit
expansion variant for the supported configurations and then replace the
64-bit variant with #error just in case.

Fixes: 3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in delay slots")
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # 4.8+
Patchwork: https://patchwork.linux-mips.org/patch/16893/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/dec/int-handler.S | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/mips/dec/int-handler.S b/arch/mips/dec/int-handler.S
index 554d1da97743..21f4a9fe82fa 100644
--- a/arch/mips/dec/int-handler.S
+++ b/arch/mips/dec/int-handler.S
@@ -147,23 +147,12 @@
 		 * Find irq with highest priority
 		 */
 		# open coded PTR_LA t1, cpu_mask_nr_tbl
-#if (_MIPS_SZPTR == 32)
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		# open coded la t1, cpu_mask_nr_tbl
 		lui	t1, %hi(cpu_mask_nr_tbl)
 		addiu	t1, %lo(cpu_mask_nr_tbl)
-
-#endif
-#if (_MIPS_SZPTR == 64)
-		# open coded dla t1, cpu_mask_nr_tbl
-		.set	push
-		.set	noat
-		lui	t1, %highest(cpu_mask_nr_tbl)
-		lui	AT, %hi(cpu_mask_nr_tbl)
-		daddiu	t1, t1, %higher(cpu_mask_nr_tbl)
-		daddiu	AT, AT, %lo(cpu_mask_nr_tbl)
-		dsll	t1, 32
-		daddu	t1, t1, AT
-		.set	pop
+#else
+#error GCC `-msym32' option required for 64-bit DECstation builds
 #endif
 1:		lw	t2,(t1)
 		nop
@@ -214,23 +203,12 @@
 		 * Find irq with highest priority
 		 */
 		# open coded PTR_LA t1,asic_mask_nr_tbl
-#if (_MIPS_SZPTR == 32)
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		# open coded la t1, asic_mask_nr_tbl
 		lui	t1, %hi(asic_mask_nr_tbl)
 		addiu	t1, %lo(asic_mask_nr_tbl)
-
-#endif
-#if (_MIPS_SZPTR == 64)
-		# open coded dla t1, asic_mask_nr_tbl
-		.set	push
-		.set	noat
-		lui	t1, %highest(asic_mask_nr_tbl)
-		lui	AT, %hi(asic_mask_nr_tbl)
-		daddiu	t1, t1, %higher(asic_mask_nr_tbl)
-		daddiu	AT, AT, %lo(asic_mask_nr_tbl)
-		dsll	t1, 32
-		daddu	t1, t1, AT
-		.set	pop
+#else
+#error GCC `-msym32' option required for 64-bit DECstation builds
 #endif
 2:		lw	t2,(t1)
 		nop
-- 
2.17.1
