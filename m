Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:18:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48640 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009177AbaLRPMPGBf08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:15 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5119244B0C62F
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:12:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:12:09 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:12:08 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 28/67] MIPS: kernel: entry.S: Add MIPS R6 related definitions
Date:   Thu, 18 Dec 2014 15:09:37 +0000
Message-ID: <1418915416-3196-29-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44763
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

The instruction hazard barrier in the form of:

jr.hb	ra
nop

is valid on MIPS R6 as well.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/entry.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 4353d323f017..d5ab21c3fd12 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -158,7 +158,8 @@ syscall_exit_work:
 	jal	syscall_trace_leave
 	b	resume_userspace
 
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MIPS_MT)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) || \
+    defined(CONFIG_MIPS_MT)
 
 /*
  * MIPS32R2 Instruction Hazard Barrier - must be called
@@ -171,4 +172,4 @@ LEAF(mips_ihb)
 	nop
 	END(mips_ihb)
 
-#endif /* CONFIG_CPU_MIPSR2 or CONFIG_MIPS_MT */
+#endif /* CONFIG_CPU_MIPSR2 or CONFIG_CPU_MIPSR6 or CONFIG_MIPS_MT */
-- 
2.2.0
