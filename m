Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 11:29:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40429 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012509AbcBWK3nF7gf- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 11:29:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 3445F63B32D5;
        Tue, 23 Feb 2016 10:29:35 +0000 (GMT)
Received: from metadesk01.kl.imgtec.org (192.168.169.39) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 23 Feb 2016 10:29:36 +0000
From:   Daniel Sanders <daniel.sanders@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Daniel Sanders <daniel.sanders@imgtec.com>,
        Scott Egerton <Scott.Egerton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH v2] mips: Avoid variant of .type unsupported by LLVM Assembler
Date:   Tue, 23 Feb 2016 10:29:20 +0000
Message-ID: <1456223360-31806-1-git-send-email-daniel.sanders@imgtec.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.169.39]
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52179
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

Although GAS accepts it, '.type symbol@function' is an undocumented form of
this directive. The documentation specifies a comma between the symbol and
'@function'.

Signed-off-by: Scott Egerton <Scott.Egerton@imgtec.com>
Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org

---

V2:
* Shortened the subject line.
* Rewrote second paragraph of the commit message.
* Made the same change to r2300_fpu.S.

 arch/mips/kernel/r2300_fpu.S | 2 +-
 arch/mips/kernel/r4k_fpu.S   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
index 5ce3b74..b4ac637 100644
--- a/arch/mips/kernel/r2300_fpu.S
+++ b/arch/mips/kernel/r2300_fpu.S
@@ -125,7 +125,7 @@ LEAF(_restore_fp_context)
 	END(_restore_fp_context)
 	.set	reorder
 
-	.type	fault@function
+	.type	fault, @function
 	.ent	fault
 fault:	li	v0, -EFAULT
 	jr	ra
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
