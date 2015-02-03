Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 14:38:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61969 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014448AbbBCNiMvm56H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 14:38:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2F63D563DDF1A;
        Tue,  3 Feb 2015 13:38:03 +0000 (GMT)
Received: from metadesk01.kl.imgtec.org (192.168.14.104) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 3 Feb 2015 13:38:05 +0000
From:   Daniel Sanders <daniel.sanders@imgtec.com>
CC:     Toma Tabacu <toma.tabacu@imgtec.com>,
        Daniel Sanders <daniel.sanders@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] MIPS: LLVMLinux: Silence unicode warnings when preprocessing assembly.
Date:   Tue, 3 Feb 2015 13:37:19 +0000
Message-ID: <1422970639-7922-6-git-send-email-daniel.sanders@imgtec.com>
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
X-archive-position: 45631
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

Differentiate the 'u' GAS .macro argument from the '\u' C preprocessor unicode
escape sequence by renaming it to '_u'.

When the 'u' argument is evaluated, we end up writing '\u', which causes
clang to emit -Wunicode warnings.

This silences a couple of -Wunicode warnings reported by clang.
The changed code can be preprocessed without warnings by both gcc and clang.

Signed-off-by: Toma Tabacu <toma.tabacu@imgtec.com>
Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Jim Quinlan <jim2101024@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/include/asm/asmmacro.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 6caf876..c657932 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -200,12 +200,12 @@
 	.word	0x41600021 | (\reg << 16)
 	.endm
 
-	.macro	MFTR	rt=0, rd=0, u=0, sel=0
-	 .word	0x41000000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
+	.macro	MFTR	rt=0, rd=0, _u=0, sel=0
+	 .word	0x41000000 | (\rt << 16) | (\rd << 11) | (\_u << 5) | (\sel)
 	.endm
 
-	.macro	MTTR	rt=0, rd=0, u=0, sel=0
-	 .word	0x41800000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
+	.macro	MTTR	rt=0, rd=0, _u=0, sel=0
+	 .word	0x41800000 | (\rt << 16) | (\rd << 11) | (\_u << 5) | (\sel)
 	.endm
 
 #ifdef TOOLCHAIN_SUPPORTS_MSA
-- 
2.1.4
