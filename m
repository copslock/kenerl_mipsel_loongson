Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 12:01:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13756 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817054AbaFKKBTQpafn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 12:01:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A196CD3D11F59
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 11:01:10 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 11 Jun
 2014 11:01:12 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 11 Jun 2014 11:01:12 +0100
Received: from pburton-laptop.home (192.168.159.44) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 11 Jun
 2014 11:01:11 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/2] MIPS: smp-cps: Convert smp_mb__after_atomic_dec()
Date:   Wed, 11 Jun 2014 11:00:56 +0100
Message-ID: <1402480857-5907-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.44]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40486
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
smp_mb__after_atomic_dec function with smp_mb__after_atomic, whilst
commit 1d8f1f5a780a "MIPS: smp-cps: hotplug support" introduced a new
use of it. Replace that use with smp_mb__after_atomic in order to avoid
a build failure:

  arch/mips/kernel/smp-cps.c: In function 'cps_cpu_disable':
  arch/mips/kernel/smp-cps.c:304:2: error: 'smp_mb__after_atomic_dec' is
    deprecated (declared at include/linux/atomic.h:35)
    [-Werror=deprecated-declarations]

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/smp-cps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index df0598d..949f2c6 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -301,7 +301,7 @@ static int cps_cpu_disable(void)
 
 	core_cfg = &mips_cps_core_bootcfg[current_cpu_data.core];
 	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
-	smp_mb__after_atomic_dec();
+	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
 	cpu_clear(cpu, cpu_callin_map);
 
-- 
2.0.0
