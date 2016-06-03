Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 23:41:37 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:40096 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042095AbcFCVi7PKc84 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 23:38:59 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u53LcntY010981
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id u53Lcm5O007495
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:49 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u53LcmuO016755;
        Fri, 3 Jun 2016 21:38:48 GMT
Received: from lappy.us.oracle.com (/10.154.190.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jun 2016 14:38:47 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: ptrace: Fix FP context restoration FCSR regression
Date:   Fri,  3 Jun 2016 17:36:29 -0400
Message-Id: <1464989831-16666-94-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
References: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53792
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

From: "Maciej W. Rozycki" <macro@imgtec.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 4249548454f7ba4581aeee26bd83f42b48a14d15 ]

Fix a floating-point context restoration regression introduced with
commit 9b26616c8d9d ("MIPS: Respect the ISA level in FCSR handling")
that causes a Floating Point exception and consequently a kernel oops
with hard float configurations when one or more FCSR Enable and their
corresponding Cause bits are set both at a time via a ptrace(2) call.

To do so reinstate Cause bit masking originally introduced with commit
b1442d39fac2 ("MIPS: Prevent user from setting FCSR cause bits") to
address this exact problem and then inadvertently removed from the
PTRACE_SETFPREGS request with the commit referred above.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: stable@vger.kernel.org # v4.0+
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13238/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index e933a30..d56642a 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -175,6 +175,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 	}
 
 	__get_user(value, data + 64);
+	value &= ~FPU_CSR_ALL_X;
 	fcr31 = child->thread.fpu.fcr31;
 	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
-- 
2.5.0
