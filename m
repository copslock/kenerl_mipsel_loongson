Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:36:46 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:27837 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026232AbbEPOehErfIs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:37 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEYN1O004185
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYNKH016743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:23 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYMZE024951;
        Sat, 16 May 2015 14:34:23 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:22 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@axis.com>,
        Niklas Cassel <niklass@axis.com>, paul.burton@imgtec.com,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: smp-cps: cpu_set FPU mask if FPU present
Date:   Sat, 16 May 2015 10:33:21 -0400
Message-Id: <1431786833-25487-13-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Niklas Cassel <niklas.cassel@axis.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 90db024f140d0d6ad960cc5f090e3c8ed890ca55 ]

If we have an FPU, enroll ourselves in the FPU-full mask.
Matching the MT_SMP and CMP implementations of smp_setup.

Signed-off-by: Niklas Cassel <niklass@axis.com>
Cc: paul.burton@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8948/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kernel/smp-cps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index e6e16a1..0854f17 100644
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
2.1.0
