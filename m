Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 11:50:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48977 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008868AbaIXJuTDqaGi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 11:50:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4EB97DE4F4604
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:50:09 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:50:10 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Sep 2014 10:50:10 +0100
Received: from pburton-laptop.home (192.168.159.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:50:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/11] MIPS: disable FPU if the mode is unsupported
Date:   Wed, 24 Sep 2014 10:45:40 +0100
Message-ID: <1411551942-11153-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.158]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42764
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

The expected semantics of __enable_fpu are for the FPU to be enabled
in the given mode if possible, otherwise for the FPU to be left
disabled and SIGFPE returned. The FPU was incorrectly being left
enabled in cases where the desired value for FR was unavailable.
Without ensuring the FPU is disabled in this case, it would be
possible for userland to go on to execute further FP instructions
natively in the incorrect mode, rather than those instructions being
trapped & emulated as they need to be.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/fpu.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 6e60431..ba62fa5 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -48,6 +48,12 @@ enum fpu_mode {
 #define FPU_FR_MASK		0x1
 };
 
+#define __disable_fpu()							\
+do {									\
+	clear_c0_status(ST0_CU1);					\
+	disable_fpu_hazard();						\
+} while (0)
+
 static inline int __enable_fpu(enum fpu_mode mode)
 {
 	int fr;
@@ -83,7 +89,12 @@ fr_common:
 		enable_fpu_hazard();
 
 		/* check FR has the desired value */
-		return (!!(read_c0_status() & ST0_FR) == !!fr) ? 0 : SIGFPE;
+		if (!!(read_c0_status() & ST0_FR) == !!fr)
+			return 0;
+
+		/* unsupported FR value */
+		__disable_fpu();
+		return SIGFPE;
 
 	default:
 		BUG();
@@ -92,12 +103,6 @@ fr_common:
 	return SIGFPE;
 }
 
-#define __disable_fpu()							\
-do {									\
-	clear_c0_status(ST0_CU1);					\
-	disable_fpu_hazard();						\
-} while (0)
-
 #define clear_fpu_owner()	clear_thread_flag(TIF_USEDFPU)
 
 static inline int __is_fpu_owner(void)
-- 
2.0.4
