Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 16:37:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37231 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012229AbcBQPhWoTd04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2016 16:37:22 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 01993D2E3E699;
        Wed, 17 Feb 2016 15:37:14 +0000 (GMT)
Received: from metadesk01.kl.imgtec.org (192.168.169.39) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 17 Feb 2016 15:37:16 +0000
From:   Daniel Sanders <daniel.sanders@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Daniel Sanders <daniel.sanders@imgtec.com>,
        Scott Egerton <Scott.Egerton@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] mips: Avoid a form of the .type directive that is not supported by LLVM's Integrated Assembler
Date:   Wed, 17 Feb 2016 15:37:09 +0000
Message-ID: <1455723429-26459-1-git-send-email-daniel.sanders@imgtec.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.169.39]
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.sanders@imgtec.com
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

The target independent parts of the LLVM Lexer considers 'fault@function'
to be a single token representing the 'fault' symbol with a 'function'
modifier. However, this is not the case in the .type directive where
'function' refers to STT_FUNC from the ELF standard.

This is the only example of this form of '.type' that we are aware of in
MIPS source so we'd prefer to make this small source change rather than
complicate the target independent parts of LLVM's assembly lexer with
directive and/or target specific exceptions to the lexing rules.

Signed-off-by: Scott Egerton <Scott.Egerton@imgtec.com>
Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org

---
 arch/mips/kernel/r4k_fpu.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index f09546e..17732f8 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -358,7 +358,7 @@ LEAF(_restore_msa_all_upper)
 
 	.set	reorder
 
-	.type	fault@function
+	.type	fault, @function
 	.ent	fault
 fault:	li	v0, -EFAULT				# failure
 	jr	ra
-- 
2.1.4
