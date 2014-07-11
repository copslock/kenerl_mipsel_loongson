Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:45:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13204 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860076AbaGKPpLljwT7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:45:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2442CE326D8DA
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:45:02 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:45:04 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:45:04 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:45:03 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 02/13] MIPS: save/restore MSACSR register on context switch
Date:   Fri, 11 Jul 2014 16:44:28 +0100
Message-ID: <1405093479-5123-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

I added a field for the MSACSR register in struct mips_fpu_struct, but
never actually made use of it... This is a clear bug. Save and restore
the MSACSR register along with the vector registers.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/asmmacro.h | 11 +++++++++++
 arch/mips/kernel/asm-offsets.c   |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 935543f..4986bf5 100644
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
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 4bb5107..b1d84bd 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -234,6 +234,7 @@ void output_thread_fpu_defines(void)
 	       thread.fpu.fpr[31].val64[FPR_IDX(64, 0)]);
 
 	OFFSET(THREAD_FCR31, task_struct, thread.fpu.fcr31);
+	OFFSET(THREAD_MSA_CSR, task_struct, thread.fpu.msacsr);
 	BLANK();
 }
 
-- 
2.0.1
