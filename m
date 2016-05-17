Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 01:09:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46202 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029381AbcEQXJBvFQCp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 01:09:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id D505F27D5ADDE;
        Wed, 18 May 2016 00:08:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 00:08:55 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 00:08:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Fix incomplete separation of XPA CPU feature
Date:   Wed, 18 May 2016 00:08:49 +0100
Message-ID: <1463526529-4087-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Commit 12822570a29b ("MIPS: Separate XPA CPU feature into LPA and MVH")
wasn't fully applied, possibly due to a conflict with commit
f270d881fa55 ("MIPS: Detect MIPSr6 Virtual Processor support"). This
left decode_config5() referring to the non-existent MIPS_CPU_XPA, which
breaks the build when XPA is enabled:

arch/mips/kernel/cpu-probe.c In function ‘decode_config5’:
arch/mips/kernel/cpu-probe.c:838:17: error: ‘MIPS_CPU_XPA’ undeclared (first use in this function)
   c->options |= MIPS_CPU_XPA;
                    ^

Apply the missing hunk, dropping the CONFIG_XPA ifdef and setting the
MIPS_CPU_MVH option when Config5.MVH is set.

Fixes: 12822570a29b ("MIPS: Separate XPA CPU feature into LPA and MVH")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13112/
---
 arch/mips/kernel/cpu-probe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5ac5c3e23460..a88d44247cc8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -833,10 +833,8 @@ static inline unsigned int decode_config5(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_MAAR;
 	if (config5 & MIPS_CONF5_LLB)
 		c->options |= MIPS_CPU_RW_LLB;
-#ifdef CONFIG_XPA
 	if (config5 & MIPS_CONF5_MVH)
-		c->options |= MIPS_CPU_XPA;
-#endif
+		c->options |= MIPS_CPU_MVH;
 	if (cpu_has_mips_r6 && (config5 & MIPS_CONF5_VP))
 		c->options |= MIPS_CPU_VP;
 
-- 
2.4.10
