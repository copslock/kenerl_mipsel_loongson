Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:19:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43384 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009178AbaLRPMQlmj6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6E52FF13035B1
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:12:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:12:11 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:12:10 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 29/67] MIPS: kernel: proc: Add MIPS R6 support to /proc/cpuinfo
Date:   Thu, 18 Dec 2014 15:09:38 +0000
Message-ID: <1418915416-3196-30-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Print 'mips64r6' and/or 'mips32r6' if the kernel is running on
a MIPS R6 core.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/proc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 097fc8d14e42..b2194770878d 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -82,7 +82,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "]\n");
 	}
 
-	seq_printf(m, "isa\t\t\t: mips1");
+	if (!cpu_has_mips_r6)
+		seq_printf(m, "isa\t\t\t: mips1");
+	else
+		seq_printf(m, "isa\t\t\t:");
 	if (cpu_has_mips_2)
 		seq_printf(m, "%s", " mips2");
 	if (cpu_has_mips_3)
@@ -95,10 +98,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "%s", " mips32r1");
 	if (cpu_has_mips32r2)
 		seq_printf(m, "%s", " mips32r2");
+	if (cpu_has_mips32r6)
+		seq_printf(m, "%s", " mips32r6");
 	if (cpu_has_mips64r1)
 		seq_printf(m, "%s", " mips64r1");
 	if (cpu_has_mips64r2)
 		seq_printf(m, "%s", " mips64r2");
+	if (cpu_has_mips64r6)
+		seq_printf(m, "%s", " mips64r6");
 	seq_printf(m, "\n");
 
 	seq_printf(m, "ASEs implemented\t:");
-- 
2.2.0
