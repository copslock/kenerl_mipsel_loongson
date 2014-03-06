Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2014 19:05:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:38863 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6853544AbaCFSE5xRVcq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2014 19:04:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5689116F94D1D
        for <linux-mips@linux-mips.org>; Thu,  6 Mar 2014 18:04:49 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 6 Mar
 2014 18:04:52 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 6 Mar 2014 18:04:51 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 6 Mar 2014 18:04:51 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: clear hazard barrier after changing MSAEn
Date:   Thu, 6 Mar 2014 18:04:27 +0000
Message-ID: <1394129067-20457-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39434
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

Changing MSAEn on the MIPS P5600 core creates an execution hazard which
must be cleared before any subsequent MSA instructions are executed.
This is similar to the FPU with which MSA is linked. Since all cores
with MSA support are >MIPSR2 the {en,dis}able_fpu_hazard macros will
always expand to the ehb instruction required, so they are simply
re-used.

Reported-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
This patch would ideally be applied as a fixup to "mips: add MSA
register definitions & access".
---
 arch/mips/include/asm/msa.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index d7fd8e1..a2aba6c 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -17,14 +17,18 @@ extern void _restore_msa(struct task_struct *);
 
 static inline void enable_msa(void)
 {
-	if (cpu_has_msa)
+	if (cpu_has_msa) {
 		set_c0_config5(MIPS_CONF5_MSAEN);
+		enable_fpu_hazard();
+	}
 }
 
 static inline void disable_msa(void)
 {
-	if (cpu_has_msa)
+	if (cpu_has_msa) {
 		clear_c0_config5(MIPS_CONF5_MSAEN);
+		disable_fpu_hazard();
+	}
 }
 
 static inline int is_msa_enabled(void)
-- 
1.8.5.3
