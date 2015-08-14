Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:43:38 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56163 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012177AbbHNRnEHaoD1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:43:04 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DB1E895;
        Fri, 14 Aug 2015 17:42:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Cowgill <James.Cowgill@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 02/84] MIPS: Replace add and sub instructions in relocate_kernel.S with addiu
Date:   Fri, 14 Aug 2015 10:41:30 -0700
Message-Id: <20150814174210.288958357@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174210.214822912@linuxfoundation.org>
References: <20150814174210.214822912@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48899
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Cowgill <James.Cowgill@imgtec.com>

commit a4504755e7dc8d43ed2a934397032691cd03adf7 upstream.

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
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10558/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/relocate_kernel.S |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
