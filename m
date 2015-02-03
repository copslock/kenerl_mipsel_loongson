Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 14:37:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56536 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012662AbbBCNhw5lxn6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 14:37:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 08AC1F10CC906;
        Tue,  3 Feb 2015 13:37:45 +0000 (GMT)
Received: from metadesk01.kl.imgtec.org (192.168.14.104) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 3 Feb 2015 13:37:47 +0000
From:   Daniel Sanders <daniel.sanders@imgtec.com>
CC:     Toma Tabacu <toma.tabacu@imgtec.com>,
        Daniel Sanders <daniel.sanders@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] MIPS: LLVMLinux: Fix a 'cast to type not present in union' error.
Date:   Tue, 3 Feb 2015 13:37:16 +0000
Message-ID: <1422970639-7922-3-git-send-email-daniel.sanders@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1422970639-7922-1-git-send-email-daniel.sanders@imgtec.com>
References: <1422970639-7922-1-git-send-email-daniel.sanders@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.14.104]
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45628
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

From: Toma Tabacu <toma.tabacu@imgtec.com>

Remove a cast to the 'mips16e_instruction' union inside an if
condition and instead do an assignment to a local
'union mips16e_instruction' variable's 'full' member before the if
statement and use this variable in the if condition.

This is the error message reported by clang:
arch/mips/kernel/branch.c:38:8: error: cast to union type from type 'unsigned short' not present in union
                if (((union mips16e_instruction)inst).ri.opcode
                     ^                          ~~~~

The changed code can be compiled successfully by both gcc and clang.

Signed-off-by: Toma Tabacu <toma.tabacu@imgtec.com>
Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/branch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 4d7d99d..7110963 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -35,8 +35,10 @@ int __isa_exception_epc(struct pt_regs *regs)
 		return epc;
 	}
 	if (cpu_has_mips16) {
-		if (((union mips16e_instruction)inst).ri.opcode
-				== MIPS16e_jal_op)
+		union mips16e_instruction inst_mips16e;
+
+		inst_mips16e.full = inst;
+		if (inst_mips16e.ri.opcode == MIPS16e_jal_op)
 			epc += 4;
 		else
 			epc += 2;
-- 
2.1.4
