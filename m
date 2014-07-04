Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 13:00:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48986 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817535AbaGDLAJ4jDRN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 13:00:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8BF809BFD6587;
        Fri,  4 Jul 2014 12:00:00 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 4 Jul
 2014 12:00:02 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 12:00:02 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 12:00:02 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <stable@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: smp-mt: Fix link error when PROC_FS=n
Date:   Fri, 4 Jul 2014 11:59:46 +0100
Message-ID: <1404471586-13510-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41025
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

Commit d6d3c9afaab4 (MIPS: MT: proc: Add support for printing VPE and TC
ids) causes a link error when CONFIG_PROC_FS=n:

arch/mips/built-in.o: In function `proc_cpuinfo_notifier_init':
smp-mt.c: undefined reference to `register_proc_cpuinfo_notifier'

This is fixed by adding an ifdef around the procfs handling code
in smp-mt.c.

Reported-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # >= 3.15
---
 arch/mips/kernel/smp-mt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 3babf6e4f894..21f23add04f4 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -288,6 +288,7 @@ struct plat_smp_ops vsmp_smp_ops = {
 	.prepare_cpus		= vsmp_prepare_cpus,
 };
 
+#ifdef CONFIG_PROC_FS
 static int proc_cpuinfo_chain_call(struct notifier_block *nfb,
 	unsigned long action_unused, void *data)
 {
@@ -309,3 +310,4 @@ static int __init proc_cpuinfo_notifier_init(void)
 }
 
 subsys_initcall(proc_cpuinfo_notifier_init);
+#endif
-- 
1.9.3
