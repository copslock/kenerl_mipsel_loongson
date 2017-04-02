Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 05:10:31 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49787 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991087AbdDBDKB3ImDH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 05:10:01 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0003GT-VU; Sun, 02 Apr 2017 04:10:00 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0004RM-2L; Sun, 02 Apr 2017 04:09:59 +0100
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
Message-ID: <lsq.1491102264.331724530@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 25/26] MIPS: remove MSA macro recursion
In-Reply-To: <lsq.1491102264.9835075@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57526
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

commit a3a49810c55e3489dfb5d72a9b2e41ab1db9ffb9 upstream.

Recursive macros made the code more concise & worked great for the
case where the toolchain doesn't support MSA. However, with toolchains
which do support MSA they lead to build failures such as:

  arch/mips/kernel/r4k_switch.S: Assembler messages:
  arch/mips/kernel/r4k_switch.S:148: Error: invalid operands `insert.w $w(0+1)[2],$1'
  arch/mips/kernel/r4k_switch.S:148: Error: invalid operands `insert.w $w(0+1)[3],$1'
  arch/mips/kernel/r4k_switch.S:148: Error: invalid operands `insert.w $w((0+1)+1)[2],$1'
  arch/mips/kernel/r4k_switch.S:148: Error: invalid operands `insert.w $w((0+1)+1)[3],$1'
  ...

Drop the recursion from msa_init_all_upper invoking the msa_init_upper
macro explicitly for each vector register.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9162/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/asmmacro.h | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -442,9 +442,6 @@
 	insert_w \wd, 2
 	insert_w \wd, 3
 #endif
-	.if	31-\wd
-	msa_init_upper	(\wd+1)
-	.endif
 	.endm
 
 	.macro	msa_init_all_upper
@@ -453,6 +450,37 @@
 	SET_HARDFLOAT
 	not	$1, zero
 	msa_init_upper	0
+	msa_init_upper	1
+	msa_init_upper	2
+	msa_init_upper	3
+	msa_init_upper	4
+	msa_init_upper	5
+	msa_init_upper	6
+	msa_init_upper	7
+	msa_init_upper	8
+	msa_init_upper	9
+	msa_init_upper	10
+	msa_init_upper	11
+	msa_init_upper	12
+	msa_init_upper	13
+	msa_init_upper	14
+	msa_init_upper	15
+	msa_init_upper	16
+	msa_init_upper	17
+	msa_init_upper	18
+	msa_init_upper	19
+	msa_init_upper	20
+	msa_init_upper	21
+	msa_init_upper	22
+	msa_init_upper	23
+	msa_init_upper	24
+	msa_init_upper	25
+	msa_init_upper	26
+	msa_init_upper	27
+	msa_init_upper	28
+	msa_init_upper	29
+	msa_init_upper	30
+	msa_init_upper	31
 	.set	pop
 	.endm
 
