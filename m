Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:46:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24550 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860081AbaGKPpkLHyl- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:45:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E319CAFC50D19
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:45:30 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:45:33 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:45:33 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:45:32 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 04/13] MIPS: save/disable MSA in lose_fpu
Date:   Fri, 11 Jul 2014 16:44:30 +0100
Message-ID: <1405093479-5123-5-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 41139
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

The kernel depends upon MSA never being enabled when the FPU is not, a
condition which is currently violated in a few places (whilst saving
sigcontext, following mips_cpu_save). Catch all the problem cases by
disabling MSA in lose_fpu, after saving context if necessary.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/fpu.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index a939574..71d97eb 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -21,6 +21,7 @@
 #include <asm/hazards.h>
 #include <asm/processor.h>
 #include <asm/current.h>
+#include <asm/msa.h>
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 #include <asm/mips_mt.h>
@@ -141,13 +142,21 @@ static inline int own_fpu(int restore)
 static inline void lose_fpu(int save)
 {
 	preempt_disable();
-	if (is_fpu_owner()) {
+	if (is_msa_enabled()) {
+		if (save) {
+			save_msa(current);
+			asm volatile("cfc1 %0, $31"
+				: "=r"(current->thread.fpu.fcr31));
+		}
+		disable_msa();
+		clear_thread_flag(TIF_USEDMSA);
+	} else if (is_fpu_owner()) {
 		if (save)
 			_save_fp(current);
-		KSTK_STATUS(current) &= ~ST0_CU1;
-		clear_thread_flag(TIF_USEDFPU);
 		__disable_fpu();
 	}
+	KSTK_STATUS(current) &= ~ST0_CU1;
+	clear_thread_flag(TIF_USEDFPU);
 	preempt_enable();
 }
 
-- 
2.0.1
