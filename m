Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:48:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52939 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859946AbaGKPrHtreXJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:47:07 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C8290520DF62C
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:46:57 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:47:01 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:47:00 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:47:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 10/13] MIPS: 16 byte align MSA vector context
Date:   Fri, 11 Jul 2014 16:46:54 +0100
Message-ID: <1405093614-5230-1-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 41145
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

The MSA specification upon first read appears to suggest that it is safe
to perform vector loads & stores with arbitrary alignment. However it
leaves provision for "address-dependent exceptions"... Align the vector
context to a 16 byte boundary to ensure that the kernel cannot cause any
such exceptions.

Note that the fpu field of struct thread_struct was already at a 16 byte
boundary within the struct, the introduction of FPU_ALIGN simply makes
the requirement explicit. The only part of this impacting the generated
kernel binary is ARCH_MIN_TASKALIGN.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/processor.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index ad70cba..5733fab 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -238,7 +238,13 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
-#define ARCH_MIN_TASKALIGN	8
+#ifdef CONFIG_CPU_HAS_MSA
+# define ARCH_MIN_TASKALIGN	16
+# define FPU_ALIGN		__aligned(16)
+#else
+# define ARCH_MIN_TASKALIGN	8
+# define FPU_ALIGN
+#endif
 
 struct mips_abi;
 
@@ -255,7 +261,7 @@ struct thread_struct {
 	unsigned long cp0_status;
 
 	/* Saved fpu/fpu emulator stuff. */
-	struct mips_fpu_struct fpu;
+	struct mips_fpu_struct fpu FPU_ALIGN;
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* Emulated instruction count */
 	unsigned long emulated_fp;
-- 
2.0.1
