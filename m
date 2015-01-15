Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 16:41:58 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:45082 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014592AbbAOPl53MXES (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Jan 2015 16:41:57 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 2F24D2E349;
        Thu, 15 Jan 2015 16:41:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BubrqRg9N4K2; Thu, 15 Jan 2015 16:41:51 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 9041F2E126;
        Thu, 15 Jan 2015 16:41:51 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 78A8B1195;
        Thu, 15 Jan 2015 16:41:51 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 6CBA8FD9;
        Thu, 15 Jan 2015 16:41:51 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id 6AC613431E;
        Thu, 15 Jan 2015 16:41:51 +0100 (CET)
Received: from lnxniklass.se.axis.com (10.94.49.1) by xmail2.se.axis.com
 (10.0.5.74) with Microsoft SMTP Server (TLS) id 8.3.342.0; Thu, 15 Jan 2015
 16:41:51 +0100
From:   Niklas Cassel <niklas.cassel@axis.com>
To:     <ralf@linux-mips.org>
CC:     <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        Niklas Cassel <niklass@axis.com>
Subject: [PATCH] MIPS: smp-cps: cpu_set FPU mask if FPU present
Date:   Thu, 15 Jan 2015 16:41:13 +0100
Message-ID: <1421336473-5627-1-git-send-email-niklass@axis.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <niklas.cassel@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklas.cassel@axis.com
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

If we have an FPU, enroll ourselves in the FPU-full mask.
Matching the MT_SMP and CMP implementations of smp_setup.

Signed-off-by: Niklas Cassel <niklass@axis.com>
---
 arch/mips/kernel/smp-cps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bed7590..d5589be 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -88,6 +88,12 @@ static void __init cps_smp_setup(void)
 
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
+
+#ifdef CONFIG_MIPS_MT_FPAFF
+	/* If we have an FPU, enroll ourselves in the FPU-full mask */
+	if (cpu_has_fpu)
+		cpu_set(0, mt_fpu_cpumask);
+#endif /* CONFIG_MIPS_MT_FPAFF */
 }
 
 static void __init cps_prepare_cpus(unsigned int max_cpus)
-- 
2.1.4
