Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 09:48:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46064 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010918AbbHMHsKRrw64 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 09:48:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DCDED79090C18;
        Thu, 13 Aug 2015 08:48:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 13 Aug 2015 08:48:04 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.168) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 13 Aug 2015 08:48:03 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: kernel: Fix seccomp syscall argument for MIPS64
Date:   Thu, 13 Aug 2015 08:47:59 +0100
Message-ID: <1439452079-3120-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48830
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

Commit 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls (o32)")
fixed indirect system calls on O32 but it also introduced a bug for MIPS64
where it erroneously modified the v0 (syscall) register with the assumption
that the sycall offset hasn't been taken into consideration. This breaks
seccomp on MIPS64 n64 and n32 ABIs. We fix this by replacing the addition
with a move instruction.

Fixes: 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls (o32)")
Cc: <stable@vger.kernel.org> # 3.15+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/scall64-64.S  | 2 +-
 arch/mips/kernel/scall64-n32.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index ad4d44635c76..a6f6b762c47a 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -80,7 +80,7 @@ syscall_trace_entry:
 	SAVE_STATIC
 	move	s0, t2
 	move	a0, sp
-	daddiu	a1, v0, __NR_64_Linux
+	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 2f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 446cc654da56..4b2010654c46 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -72,7 +72,7 @@ n32_syscall_trace_entry:
 	SAVE_STATIC
 	move	s0, t2
 	move	a0, sp
-	daddiu	a1, v0, __NR_N32_Linux
+	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 2f			# seccomp failed? Skip syscall
-- 
2.5.0
