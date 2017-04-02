Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 05:11:37 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49786 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991129AbdDBDKBeb0pH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 05:10:01 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0003GU-Vn; Sun, 02 Apr 2017 04:10:00 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0004RQ-33; Sun, 02 Apr 2017 04:09:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>
Date:   Sun, 02 Apr 2017 04:04:24 +0100
Message-ID: <lsq.1491102264.957862384@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 26/26] MIPS: wrap cfcmsa & ctcmsa accesses for
 toolchains with MSA support
In-Reply-To: <lsq.1491102264.9835075@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57529
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

3.16.43-rc2 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit e1bebbab1eaecac77d77033010b5e0f51b737e64 upstream.

Uses of the cfcmsa & ctcmsa instructions were not being wrapped by a
macro in the case where the toolchain supports MSA, since the arguments
exactly match a typical use of the instructions. However using current
toolchains this leads to errors such as:

  arch/mips/kernel/genex.S:437: Error: opcode not supported on this processor: mips32r2 (mips32r2) `cfcmsa $5,1'

Thus uses of the instructions must be in the context of a ".set msa"
directive, however doing that from the users of the instructions would
be messy due to the possibility that the toolchain does not support
MSA. Fix this by renaming the macros (prepending an underscore) in order
to avoid recursion when attempting to emit the instructions, and provide
implementations for the TOOLCHAIN_SUPPORTS_MSA case which ".set msa" as
appropriate.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9163/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/asmmacro.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -209,6 +209,22 @@
 	.endm
 
 #ifdef TOOLCHAIN_SUPPORTS_MSA
+	.macro	_cfcmsa	rd, cs
+	.set	push
+	.set	mips32r2
+	.set	msa
+	cfcmsa	\rd, $\cs
+	.set	pop
+	.endm
+
+	.macro	_ctcmsa	cd, rs
+	.set	push
+	.set	mips32r2
+	.set	msa
+	ctcmsa	$\cd, \rs
+	.set	pop
+	.endm
+
 	.macro	ld_d	wd, off, base
 	.set	push
 	.set	mips32r2
@@ -281,7 +297,7 @@
 	/*
 	 * Temporary until all toolchains in use include MSA support.
 	 */
-	.macro	cfcmsa	rd, cs
+	.macro	_cfcmsa	rd, cs
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
@@ -291,7 +307,7 @@
 	.set	pop
 	.endm
 
-	.macro	ctcmsa	cd, rs
+	.macro	_ctcmsa	cd, rs
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
@@ -389,7 +405,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	cfcmsa	$1, MSA_CSR
+	_cfcmsa	$1, MSA_CSR
 	sw	$1, THREAD_MSA_CSR(\thread)
 	.set	pop
 	.endm
@@ -399,7 +415,7 @@
 	.set	noat
 	SET_HARDFLOAT
 	lw	$1, THREAD_MSA_CSR(\thread)
-	ctcmsa	MSA_CSR, $1
+	_ctcmsa	MSA_CSR, $1
 	.set	pop
 	ld_d	0, THREAD_FPR0, \thread
 	ld_d	1, THREAD_FPR1, \thread
