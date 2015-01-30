Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 13:10:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7020 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012269AbbA3MKzLpaEl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 13:10:55 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6CDA0E5F20154
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 12:10:47 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 12:10:49 +0000
Received: from localhost (192.168.159.167) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 12:10:42 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 03/10] MIPS: remove MSA macro recursion
Date:   Fri, 30 Jan 2015 12:09:32 +0000
Message-ID: <1422619779-9940-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
References: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.167]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45565
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

Recursive macros made the code more concise & worked great for the
case where the toolchain doesn't support MSA. However, with toolchains
which do support MSA they lead to build failures such as:

  arch/mips/kernel/r4k_switch.S: Assembler messages:
  arch/mips/kernel/r4k_switch.S:148: Error: invalid operands `insert.w $w(0+1)[2],$1'
  arch/mips/kernel/r4k_switch.S:148: Error: invalid operands `insert.w $w(0+1)[3],$1'
  arch/mips/kernel/r4k_switch.S:148: Error: invalid operands `insert.w $w((0+1)+1)[2],$1'
  arch/mips/kernel/r4k_switch.S:148: Error: invalid operands `insert.w $w((0+1)+1)[3],$1'
  ...

Drop the recursion from msa_init_all_upper invoking the msa_init_upper
macro explicitly for each vector register.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Rebase atop v3.19-rc6.
---
 arch/mips/include/asm/asmmacro.h | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 34f9757..d2231d6 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -442,9 +442,6 @@
 	insert_w \wd, 2
 	insert_w \wd, 3
 #endif
-	.if	31-\wd
-	msa_init_upper	(\wd+1)
-	.endif
 	.endm
 
 	.macro	msa_init_all_upper
@@ -453,6 +450,37 @@
 	SET_HARDFLOAT
 	not	$1, zero
 	msa_init_upper	0
+	msa_init_upper	1
+	msa_init_upper	2
+	msa_init_upper	3
+	msa_init_upper	4
+	msa_init_upper	5
+	msa_init_upper	6
+	msa_init_upper	7
+	msa_init_upper	8
+	msa_init_upper	9
+	msa_init_upper	10
+	msa_init_upper	11
+	msa_init_upper	12
+	msa_init_upper	13
+	msa_init_upper	14
+	msa_init_upper	15
+	msa_init_upper	16
+	msa_init_upper	17
+	msa_init_upper	18
+	msa_init_upper	19
+	msa_init_upper	20
+	msa_init_upper	21
+	msa_init_upper	22
+	msa_init_upper	23
+	msa_init_upper	24
+	msa_init_upper	25
+	msa_init_upper	26
+	msa_init_upper	27
+	msa_init_upper	28
+	msa_init_upper	29
+	msa_init_upper	30
+	msa_init_upper	31
 	.set	pop
 	.endm
 
-- 
2.2.2
