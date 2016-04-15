Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 11:08:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58481 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026631AbcDOJHpO5xGc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 11:07:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 4A415F4F4C97E;
        Fri, 15 Apr 2016 10:07:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 10:07:38 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 10:07:38 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/4] MIPS: Fix MSA ld_*/st_* asm macros to use PTR_ADDU
Date:   Fri, 15 Apr 2016 10:07:24 +0100
Message-ID: <1460711246-4394-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
References: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The MSA ld_*/st_* assembler macros for when the toolchain doesn't
support MSA use addu to offset the base address. However it is a virtual
memory pointer so fix it to use PTR_ADDU which expands to daddu for
64-bit kernels.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.3.y-
---
 arch/mips/include/asm/asmmacro.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index b99b38862fcb..e689b894353c 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -393,7 +393,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	addu	$1, \base, \off
+	PTR_ADDU $1, \base, \off
 	.word	LDB_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
@@ -402,7 +402,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	addu	$1, \base, \off
+	PTR_ADDU $1, \base, \off
 	.word	LDH_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
@@ -411,7 +411,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	addu	$1, \base, \off
+	PTR_ADDU $1, \base, \off
 	.word	LDW_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
@@ -420,7 +420,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	addu	$1, \base, \off
+	PTR_ADDU $1, \base, \off
 	.word	LDD_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
@@ -429,7 +429,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	addu	$1, \base, \off
+	PTR_ADDU $1, \base, \off
 	.word	STB_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
@@ -438,7 +438,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	addu	$1, \base, \off
+	PTR_ADDU $1, \base, \off
 	.word	STH_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
@@ -447,7 +447,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	addu	$1, \base, \off
+	PTR_ADDU $1, \base, \off
 	.word	STW_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
@@ -456,7 +456,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	addu	$1, \base, \off
+	PTR_ADDU $1, \base, \off
 	.word	STD_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
-- 
2.4.10
