Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2014 09:25:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39852 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012529AbaKEIZwetFv0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Nov 2014 09:25:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 40FE4CC5B8111;
        Wed,  5 Nov 2014 08:25:45 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 5 Nov
 2014 08:25:46 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Nov 2014 08:25:46 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.149) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Nov 2014 08:25:45 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: asm: r4kcache: Add EVA case for protected_writeback_dcache_line
Date:   Wed, 5 Nov 2014 08:25:37 +0000
Message-ID: <1415175937-23903-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43872
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

Commit de8974e3f76c0 ("MIPS: asm: r4kcache: Add EVA cache flushing
functions") added cache function for EVA using the cachee instruction.
However, it didn't add a case for the protected_writeback_dcache_line.
mips_dsemul() calls r4k_flush_cache_sigtramp() which in turn uses
the protected_writeback_dcache_line() to flush the trampoline code
back to memory. This used the wrong "cache" instruction leading to
random userland crashes on non-FPU cores.

Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/r4kcache.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 4520adc8699b..cd6e0afc6833 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -257,7 +257,11 @@ static inline void protected_flush_icache_line(unsigned long addr)
  */
 static inline void protected_writeback_dcache_line(unsigned long addr)
 {
+#ifdef CONFIG_EVA
+	protected_cachee_op(Hit_Writeback_Inv_D, addr);
+#else
 	protected_cache_op(Hit_Writeback_Inv_D, addr);
+#endif
 }
 
 static inline void protected_writeback_scache_line(unsigned long addr)
-- 
2.1.3
