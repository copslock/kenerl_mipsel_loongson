Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:45:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57660 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009131AbbIVSpQM506P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:45:16 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9F4456A4B3A76;
        Tue, 22 Sep 2015 19:45:06 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:45:10 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:45:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 6/6] MIPS: allow RIXI for 32-bit kernels on MIPS64
Date:   Tue, 22 Sep 2015 11:42:53 -0700
Message-ID: <1442947373-13345-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442947373-13345-1-git-send-email-paul.burton@imgtec.com>
References: <1442947373-13345-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49323
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

Commit a68d09a156b2 ("MIPS: Don't use RI/XI with 32-bit kernels on
64-bit CPUs") prevented use of RIXI on MIPS64 systems, stating that the
"TLB handlers cannot handle this case". What they actually couldn't
handle was cases where there were less fill bits in the Entry{Lo,Hi}
registers than bits used by software in PTEs. The handlers can now deal
with this case, so enable RIXI for MIPS32 kernels on MIPS64 systems.

Note that beyond the obvious benefits provided by having RIXI on such
systems, this is required for systems implementing MIPSr6 where RIXI
cannot be disabled.

This reverts commit a68d09a156b2 ("MIPS: Don't use RI/XI with 32-bit
kernels on 64-bit CPUs").

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/include/asm/cpu-features.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 9801ac9..7cb7c10 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -128,11 +128,7 @@
 #endif
 
 #ifndef cpu_has_rixi
-# ifdef CONFIG_64BIT
-# define cpu_has_rixi		(cpu_data[0].options & MIPS_CPU_RIXI)
-# else /* CONFIG_32BIT */
-# define cpu_has_rixi		((cpu_data[0].options & MIPS_CPU_RIXI) && !cpu_has_64bits)
-# endif
+#define cpu_has_rixi		(cpu_data[0].options & MIPS_CPU_RIXI)
 #endif
 
 #ifndef cpu_has_mmips
-- 
2.5.3
