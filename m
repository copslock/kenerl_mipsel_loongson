Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 12:01:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11115 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6843084AbaFKKBYycMno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 12:01:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0B114C59B849
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 11:01:17 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 11 Jun 2014 11:01:17 +0100
Received: from pburton-laptop.home (192.168.159.44) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 11 Jun
 2014 11:01:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/2] MIPS: pm-cps: convert smp_mb__*()
Date:   Wed, 11 Jun 2014 11:00:57 +0100
Message-ID: <1402480857-5907-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402480857-5907-1-git-send-email-paul.burton@imgtec.com>
References: <1402480857-5907-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.44]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40487
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

Commit 91bbefe6b0fc "arch,mips: Convert smp_mb__*()" replaced the
smp_mb__* functions with a simpler API, whilst commit 3179d37ee1ed
"MIPS: pm-cps: add PM state entry code for CPS systems" introduced
new uses of smp_mb__before_atomic_inc & smp_mb__after_clear_bit.
Replace those calls with the corresponding before & after atomic
functions of the new, simpler API in order to avoid a build failure:

  arch/mips/kernel/pm-cps.c: In function 'coupled_barrier':
  arch/mips/kernel/pm-cps.c:104:2: error: 'smp_mb__before_atomic_inc' is
    deprecated (declared at include/linux/atomic.h:11)
    [-Werror=deprecated-declarations]

  arch/mips/kernel/pm-cps.c: In function 'cps_pm_enter_state':
  arch/mips/kernel/pm-cps.c:161:2: error: 'smp_mb__after_clear_bit' is
    deprecated (declared at include/linux/bitops.h:48)
    [-Werror=deprecated-declarations]

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/pm-cps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 5aa4c6f..c4c2069 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -101,7 +101,7 @@ static void coupled_barrier(atomic_t *a, unsigned online)
 	if (!coupled_coherence)
 		return;
 
-	smp_mb__before_atomic_inc();
+	smp_mb__before_atomic();
 	atomic_inc(a);
 
 	while (atomic_read(a) < online)
@@ -158,7 +158,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 
 	/* Indicate that this CPU might not be coherent */
 	cpumask_clear_cpu(cpu, &cpu_coherent_mask);
-	smp_mb__after_clear_bit();
+	smp_mb__after_atomic();
 
 	/* Create a non-coherent mapping of the core ready_count */
 	core_ready_count = per_cpu(ready_count, core);
-- 
2.0.0
