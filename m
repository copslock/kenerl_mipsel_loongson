Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 17:40:31 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:20563 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013046AbbH0PjjP6-px (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2015 17:39:39 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t7RFdO6G019018
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2015 15:39:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t7RFdOBd014271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 27 Aug 2015 15:39:24 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t7RFdO31024735;
        Thu, 27 Aug 2015 15:39:24 GMT
Received: from lappy.us.oracle.com (/10.154.183.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2015 08:39:24 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: do_mcheck: Fix kernel code dump with EVA
Date:   Thu, 27 Aug 2015 11:37:21 -0400
Message-Id: <1440689954-10813-3-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1440689954-10813-1-git-send-email-sasha.levin@oracle.com>
References: <1440689954-10813-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49054
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 55c723e181ccec30fb5c672397fe69ec35967d97 ]

If a machine check exception is raised in kernel mode, user context,
with EVA enabled, then the do_mcheck handler will attempt to read the
code around the EPC using EVA load instructions, i.e. as if the reads
were from user mode. This will either read random user data if the
process has anything mapped at the same address, or it will cause an
exception which is handled by __get_user, resulting in this output:

 Code: (Bad address in epc)

Fix by setting the current user access mode to kernel if the saved
register context indicates the exception was taken in kernel mode. This
causes __get_user to use normal loads to read the kernel code.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15+
Patchwork: https://patchwork.linux-mips.org/patch/10777/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kernel/traps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d255a2a..0c02c05 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1376,6 +1376,7 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 	const int field = 2 * sizeof(unsigned long);
 	int multi_match = regs->cp0_status & ST0_TS;
 	enum ctx_state prev_state;
+	mm_segment_t old_fs = get_fs();
 
 	prev_state = exception_enter();
 	show_regs(regs);
@@ -1390,8 +1391,13 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 		dump_tlb_all();
 	}
 
+	if (!user_mode(regs))
+		set_fs(KERNEL_DS);
+
 	show_code((unsigned int __user *) regs->cp0_epc);
 
+	set_fs(old_fs);
+
 	/*
 	 * Some chips may have other causes of machine check (e.g. SB1
 	 * graduation timer)
-- 
2.1.4
