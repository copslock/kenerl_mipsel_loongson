Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 15:38:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39448 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993877AbdBNOhXKaP4I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 15:37:23 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2B6B833AC7608;
        Tue, 14 Feb 2017 14:37:14 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Feb 2017 14:37:17 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 4/4] MIPS: uasm: Constify insn_table_MM
Date:   Tue, 14 Feb 2017 14:37:08 +0000
Message-ID: <1487083028-19724-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1487083028-19724-1-git-send-email-matt.redfearn@imgtec.com>
References: <1487083028-19724-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56814
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

The insn_table_MM is an array of constant structures and as such should
be declared const.

This change saves 1024 bytes of kernel text on a micro32r2el_defconfig.
Before:
   text	   data	    bss	    dec	    hex	filename
4138863	1130964	 296432	5566259	 54ef33	vmlinux
After:
   text	   data	    bss	    dec	    hex	filename
4137839	1130964	 296432	5565235	 54eb33	vmlinux

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/mm/uasm-micromips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 277cf52d80e1..ddc5a9cfe2a5 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -40,7 +40,7 @@
 
 #include "uasm.c"
 
-static struct insn insn_table_MM[] = {
+static const struct insn insn_table_MM[] = {
 	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
 	{ insn_addiu, M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
 	{ insn_and, M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD },
@@ -156,7 +156,7 @@ static inline u32 build_jimm(u32 arg)
  */
 static void build_insn(u32 **buf, enum opcode opc, ...)
 {
-	struct insn *ip = NULL;
+	const struct insn *ip = NULL;
 	unsigned int i;
 	va_list ap;
 	u32 op;
-- 
2.7.4
