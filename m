Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2015 18:13:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18001 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008816AbbFQQNAvqF9X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2015 18:13:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4BDC712C5CE66;
        Wed, 17 Jun 2015 17:12:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 17 Jun 2015 17:12:54 +0100
Received: from raava.le.imgtec.org (192.168.154.64) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 17 Jun
 2015 17:12:54 +0100
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Cowgill <James.Cowgill@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: replace add and sub instructions in relocate_kernel.S with addiu
Date:   Wed, 17 Jun 2015 17:12:50 +0100
Message-ID: <1434557570-30452-1-git-send-email-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.64]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

Fixes the assembler errors generated when compiling a MIPS R6 kernel with
CONFIG_KEXEC on, by replacing the offending add and sub instructions with
addiu instructions.

Build errors:
arch/mips/kernel/relocate_kernel.S: Assembler messages:
arch/mips/kernel/relocate_kernel.S:27: Error: invalid operands `dadd $16,$16,8'
arch/mips/kernel/relocate_kernel.S:64: Error: invalid operands `dadd $20,$20,8'
arch/mips/kernel/relocate_kernel.S:65: Error: invalid operands `dadd $18,$18,8'
arch/mips/kernel/relocate_kernel.S:66: Error: invalid operands `dsub $22,$22,1'
scripts/Makefile.build:294: recipe for target 'arch/mips/kernel/relocate_kernel.o' failed

Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <stable@vger.kernel.org> # 4.0+
---
 arch/mips/kernel/relocate_kernel.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index 74bab9d..c6bbf21 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -24,7 +24,7 @@ LEAF(relocate_new_kernel)
 
 process_entry:
 	PTR_L		s2, (s0)
-	PTR_ADD		s0, s0, SZREG
+	PTR_ADDIU	s0, s0, SZREG
 
 	/*
 	 * In case of a kdump/crash kernel, the indirection page is not
@@ -61,9 +61,9 @@ copy_word:
 	/* copy page word by word */
 	REG_L		s5, (s2)
 	REG_S		s5, (s4)
-	PTR_ADD		s4, s4, SZREG
-	PTR_ADD		s2, s2, SZREG
-	LONG_SUB	s6, s6, 1
+	PTR_ADDIU	s4, s4, SZREG
+	PTR_ADDIU	s2, s2, SZREG
+	LONG_ADDIU	s6, s6, -1
 	beq		s6, zero, process_entry
 	b		copy_word
 	b		process_entry
-- 
2.1.4
