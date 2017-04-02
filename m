Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 05:12:03 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49795 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991232AbdDBDKBjny8H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 05:10:01 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0003GS-V4; Sun, 02 Apr 2017 04:10:00 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0004RG-1T; Sun, 02 Apr 2017 04:09:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <paul.burton@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Sun, 02 Apr 2017 04:04:24 +0100
Message-ID: <lsq.1491102264.144601008@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 24/26] MIPS: assume at as source/dest of MSA
 copy/insert instructions
In-Reply-To: <lsq.1491102264.9835075@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57530
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

commit f23ce3883a30743a5b779dc6fb90ca8620688a23 upstream.

Assuming at ($1) as the source or destination register of copy or
insert instructions:

  - Simplifies the macros providing those instructions for toolchains
    without MSA support.

  - Avoids an unnecessary move instruction when at is used as the source
    or destination register anyway.

  - Is sufficient for the uses to be introduced in the kernel by a
    subsequent patch.

Note that due to a patch ordering snafu on my part this also fixes the
currently broken build with MSA support enabled. The build has been
broken since commit c9017757c532 "MIPS: init upper 64b of vector
registers when MSA is first used", which this patch should have
preceeded.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9161/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/asmmacro.h | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -225,35 +225,35 @@
 	.set	pop
 	.endm
 
-	.macro	copy_u_w	rd, ws, n
+	.macro	copy_u_w	ws, n
 	.set	push
 	.set	mips32r2
 	.set	msa
-	copy_u.w \rd, $w\ws[\n]
+	copy_u.w $1, $w\ws[\n]
 	.set	pop
 	.endm
 
-	.macro	copy_u_d	rd, ws, n
+	.macro	copy_u_d	ws, n
 	.set	push
 	.set	mips64r2
 	.set	msa
-	copy_u.d \rd, $w\ws[\n]
+	copy_u.d $1, $w\ws[\n]
 	.set	pop
 	.endm
 
-	.macro	insert_w	wd, n, rs
+	.macro	insert_w	wd, n
 	.set	push
 	.set	mips32r2
 	.set	msa
-	insert.w $w\wd[\n], \rs
+	insert.w $w\wd[\n], $1
 	.set	pop
 	.endm
 
-	.macro	insert_d	wd, n, rs
+	.macro	insert_d	wd, n
 	.set	push
 	.set	mips64r2
 	.set	msa
-	insert.d $w\wd[\n], \rs
+	insert.d $w\wd[\n], $1
 	.set	pop
 	.endm
 #else
@@ -318,40 +318,36 @@
 	.set	pop
 	.endm
 
-	.macro	copy_u_w	rd, ws, n
+	.macro	copy_u_w	ws, n
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
 	.insn
 	.word	COPY_UW_MSA_INSN | (\n << 16) | (\ws << 11)
-	move	\rd, $1
 	.set	pop
 	.endm
 
-	.macro	copy_u_d	rd, ws, n
+	.macro	copy_u_d	ws, n
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
 	.insn
 	.word	COPY_UD_MSA_INSN | (\n << 16) | (\ws << 11)
-	move	\rd, $1
 	.set	pop
 	.endm
 
-	.macro	insert_w	wd, n, rs
+	.macro	insert_w	wd, n
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	move	$1, \rs
 	.word	INSERT_W_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
 
-	.macro	insert_d	wd, n, rs
+	.macro	insert_d	wd, n
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	move	$1, \rs
 	.word	INSERT_D_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
