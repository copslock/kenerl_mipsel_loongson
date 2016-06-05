Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:54:45 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60495 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042474AbcFEVxDzyCup (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:53:03 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E03A5941;
        Sun,  5 Jun 2016 21:52:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.6 017/121] MIPS: Fix MSA ld_*/st_* asm macros to use PTR_ADDU
Date:   Sun,  5 Jun 2016 14:42:49 -0700
Message-Id: <20160605214418.232896025@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605214417.708509043@linuxfoundation.org>
References: <20160605214417.708509043@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53843
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit ea1688573426adc2587ed52d086b51c7c62eaca3 upstream.

The MSA ld_*/st_* assembler macros for when the toolchain doesn't
support MSA use addu to offset the base address. However it is a virtual
memory pointer so fix it to use PTR_ADDU which expands to daddu for
64-bit kernels.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13062/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/asmmacro.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

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
