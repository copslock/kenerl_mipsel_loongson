Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 13:10:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23964 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842557AbaGXLKVCyKwE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2014 13:10:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F0D434B4BC0B3
        for <linux-mips@linux-mips.org>; Thu, 24 Jul 2014 12:10:11 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 24 Jul
 2014 12:10:14 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Jul 2014 12:10:13 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.158) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Jul 2014 12:10:13 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/2] MIPS: syscall: Fix AUDIT value for O32 processes on MIPS64
Date:   Thu, 24 Jul 2014 12:10:01 +0100
Message-ID: <1406200202-10104-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.2
In-Reply-To: <1406200202-10104-1-git-send-email-markos.chandras@imgtec.com>
References: <1406200202-10104-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

On MIPS64, O32 processes set both TIF_32BIT_ADDR and
TIF_32BIT_REGS so the previous condition treated O32 applications
as N32 when evaluating seccomp filters. Fix the condition to check
both TIF_32BIT_{REGS, ADDR} for the N32 AUDIT flag.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/syscall.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 17960fe7a8ce..cdf68b33bd65 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -131,10 +131,12 @@ static inline int syscall_get_arch(void)
 {
 	int arch = EM_MIPS;
 #ifdef CONFIG_64BIT
-	if (!test_thread_flag(TIF_32BIT_REGS))
+	if (!test_thread_flag(TIF_32BIT_REGS)) {
 		arch |= __AUDIT_ARCH_64BIT;
-	if (test_thread_flag(TIF_32BIT_ADDR))
-		arch |= __AUDIT_ARCH_CONVENTION_MIPS64_N32;
+		/* N32 sets only TIF_32BIT_ADDR */
+		if (test_thread_flag(TIF_32BIT_ADDR))
+			arch |= __AUDIT_ARCH_CONVENTION_MIPS64_N32;
+	}
 #endif
 #if defined(__LITTLE_ENDIAN)
 	arch |=  __AUDIT_ARCH_LE;
-- 
2.0.2
