Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 21:18:04 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:53190 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823124Ab3IKTR6gchId (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 21:17:58 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VJpvE-0000y5-4h; Wed, 11 Sep 2013 14:17:52 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH] MIPS: Fix SMP core calculations when using MT support.
Date:   Wed, 11 Sep 2013 14:17:47 -0500
Message-Id: <1378927067-6081-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

The TCBIND register is only available if the core has MT support. It
should not be read otherwise. Secondly, the number of TCs (siblings)
are calculated differently depending on if the kernel is configured
as SMVP or SMTC.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/smp-cmp.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index c2e5d74..5969f1e 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -99,7 +99,9 @@ static void cmp_init_secondary(void)
 
 	c->core = (read_c0_ebase() >> 1) & 0x1ff;
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
-	c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE;
+	if (cpu_has_mipsmt)
+		c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) &
+			TCBIND_CURVPE;
 #endif
 #ifdef CONFIG_MIPS_MT_SMTC
 	c->tc_id  = (read_c0_tcbind() & TCBIND_CURTC) >> TCBIND_CURTC_SHIFT;
@@ -177,9 +179,16 @@ void __init cmp_smp_setup(void)
 	}
 
 	if (cpu_has_mipsmt) {
-		unsigned int nvpe, mvpconf0 = read_c0_mvpconf0();
+		unsigned int nvpe = 1;
+#ifdef CONFIG_MIPS_MT_SMP
+		unsigned int mvpconf0 = read_c0_mvpconf0();
+
+		nvpe = ((mvpconf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
+#elif defined(CONFIG_MIPS_MT_SMTC)
+		unsigned int mvpconf0 = read_c0_mvpconf0();
 
 		nvpe = ((mvpconf0 & MVPCONF0_PTC) >> MVPCONF0_PTC_SHIFT) + 1;
+#endif
 		smp_num_siblings = nvpe;
 	}
 	pr_info("Detected %i available secondary CPU(s)\n", ncpu);
-- 
1.7.9.5
