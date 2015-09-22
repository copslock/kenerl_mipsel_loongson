Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:24:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25653 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009093AbbIVSYwD8APQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:24:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3C6FAECF96AC4;
        Tue, 22 Sep 2015 19:24:40 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:24:43 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:24:41 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH] MIPS: always use r4k_wait_irqoff for MIPSr6
Date:   Tue, 22 Sep 2015 11:24:20 -0700
Message-ID: <1442946260-26691-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49312
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

Prior to release 6 of the MIPS architecture it has been implementation
dependent whether masked interrupts cause a wait instruction to return,
so the kernel has effectively had to maintain a whitelist of cores upon
which it is safe to use the r4k_wait_irqoff cpu_wait implementation.
With MIPSr6 this is no longer implementation dependent and
r4k_wait_irqoff can always be used.

Remove the existing I6400 case which will no longer ever be hit, and was
incorrect anyway since I6400 & r6 in general doesn't have the WII bit.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/idle.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index ab1478d..3e2b0b6 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -134,6 +134,16 @@ void __init check_wait(void)
 		return;
 	}
 
+	/*
+	 * MIPSr6 specifies that masked interrupts should unblock an executing
+	 * wait instruction, and thus that it is safe for us to use
+	 * r4k_wait_irqoff. Yippee!
+	 */
+	if (cpu_has_mips_r6) {
+		cpu_wait = r4k_wait_irqoff;
+		return;
+	}
+
 	switch (current_cpu_type()) {
 	case CPU_R3081:
 	case CPU_R3081E:
@@ -196,7 +206,6 @@ void __init check_wait(void)
 	case CPU_INTERAPTIV:
 	case CPU_M5150:
 	case CPU_QEMU_GENERIC:
-	case CPU_I6400:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
 			cpu_wait = r4k_wait_irqoff;
-- 
2.5.3
