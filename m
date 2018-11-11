Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2018 20:58:56 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44670 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993060AbeKKT6wtWTOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2018 20:58:52 +0100
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsf-0000l9-Em; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001sT-EU; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.811545133@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 348/366] MIPS: asmmacro: Ensure 64-bit FP registers
 are used with MSA
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 2bd7bc254ab1f45269db6dd7957d63b713817408 upstream.

This silences warnings like the following one when building with the
latest binutils:

arch/mips/kernel/genex.S: Assembler messages:
arch/mips/kernel/genex.S:438: Warning: the `msa' extension requires 64-bit FPRs

[ralf@linux-mips.org: Markos says binutils 2.25 and some 2.24 snapshots
are affected.]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9745/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/asmmacro.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -209,9 +209,13 @@
 	.endm
 
 #ifdef TOOLCHAIN_SUPPORTS_MSA
+/* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
+#undef fp
+
 	.macro	_cfcmsa	rd, cs
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	cfcmsa	\rd, $\cs
 	.set	pop
@@ -220,6 +224,7 @@
 	.macro	_ctcmsa	cd, rs
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	ctcmsa	$\cd, \rs
 	.set	pop
@@ -228,6 +233,7 @@
 	.macro	ld_d	wd, off, base
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	ld.d	$w\wd, \off(\base)
 	.set	pop
@@ -236,6 +242,7 @@
 	.macro	st_d	wd, off, base
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	st.d	$w\wd, \off(\base)
 	.set	pop
@@ -244,6 +251,7 @@
 	.macro	copy_u_w	ws, n
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	copy_u.w $1, $w\ws[\n]
 	.set	pop
@@ -252,6 +260,7 @@
 	.macro	copy_u_d	ws, n
 	.set	push
 	.set	mips64r2
+	.set	fp=64
 	.set	msa
 	copy_u.d $1, $w\ws[\n]
 	.set	pop
@@ -260,6 +269,7 @@
 	.macro	insert_w	wd, n
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	insert.w $w\wd[\n], $1
 	.set	pop
@@ -268,6 +278,7 @@
 	.macro	insert_d	wd, n
 	.set	push
 	.set	mips64r2
+	.set	fp=64
 	.set	msa
 	insert.d $w\wd[\n], $1
 	.set	pop
