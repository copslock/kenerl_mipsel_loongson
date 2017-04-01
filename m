Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2017 15:24:37 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46000 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991061AbdDANWkCB2a- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Apr 2017 15:22:40 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzE-00042H-OC; Sat, 01 Apr 2017 14:22:36 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzD-0004e6-Rr; Sat, 01 Apr 2017 14:22:35 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Arnd Bergmann" <arnd@arndb.de>, linux-mips@linux-mips.org
Date:   Sat, 01 Apr 2017 14:17:50 +0100
Message-ID: <lsq.1491052670.78281440@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 03/19] MIPS: save/restore MSACSR register on context
 switch
In-Reply-To: <lsq.1491052670.319419763@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57523
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

3.16.43-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit f7a46fa7bb0047d3e226702a0c4b786862fe6843 upstream.

I added a field for the MSACSR register in struct mips_fpu_struct, but
never actually made use of it... This is a clear bug. Save and restore
the MSACSR register along with the vector registers.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7300/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/asmmacro.h | 11 +++++++++++
 arch/mips/kernel/asm-offsets.c   |  1 +
 2 files changed, 12 insertions(+)

--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -10,6 +10,7 @@
 
 #include <asm/hazards.h>
 #include <asm/asm-offsets.h>
+#include <asm/msa.h>
 
 #ifdef CONFIG_32BIT
 #include <asm/asmmacro-32.h>
@@ -378,9 +379,19 @@
 	st_d	29, THREAD_FPR29, \thread
 	st_d	30, THREAD_FPR30, \thread
 	st_d	31, THREAD_FPR31, \thread
+	.set	push
+	.set	noat
+	cfcmsa	$1, MSA_CSR
+	sw	$1, THREAD_MSA_CSR(\thread)
+	.set	pop
 	.endm
 
 	.macro	msa_restore_all	thread
+	.set	push
+	.set	noat
+	lw	$1, THREAD_MSA_CSR(\thread)
+	ctcmsa	MSA_CSR, $1
+	.set	pop
 	ld_d	0, THREAD_FPR0, \thread
 	ld_d	1, THREAD_FPR1, \thread
 	ld_d	2, THREAD_FPR2, \thread
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -234,6 +234,7 @@ void output_thread_fpu_defines(void)
 	       thread.fpu.fpr[31].val64[FPR_IDX(64, 0)]);
 
 	OFFSET(THREAD_FCR31, task_struct, thread.fpu.fcr31);
+	OFFSET(THREAD_MSA_CSR, task_struct, thread.fpu.msacsr);
 	BLANK();
 }
 
