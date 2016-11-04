Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 10:30:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48139 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992227AbcKDJ3MdgJS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 10:29:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 62AFDCFE494B3;
        Fri,  4 Nov 2016 09:29:04 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 4 Nov 2016 09:29:06 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qsyousef@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] MIPS: smp-cps: Don't BUG if a CPU fails to start
Date:   Fri, 4 Nov 2016 09:28:58 +0000
Message-ID: <1478251738-13593-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1478251738-13593-1-git-send-email-matt.redfearn@imgtec.com>
References: <1478251738-13593-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

If there is no online CPU within a core which could receive the IPI to
start another VP in that core, a BUG() is triggered. Instead print a
warning and gracefully handle the failure such that the system remains
usable, albeit without the requested secondary CPU.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/kernel/smp-cps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 44339b470ef4..a2544c2394e4 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -326,7 +326,11 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 			if (cpu_online(remote))
 				break;
 		}
-		BUG_ON(remote >= NR_CPUS);
+		if (remote >= NR_CPUS) {
+			pr_crit("No online CPU in core %u to start CPU%d\n",
+				core, cpu);
+			goto out;
+		}
 
 		err = smp_call_function_single(remote, remote_vpe_boot,
 					       NULL, 1);
-- 
2.7.4
