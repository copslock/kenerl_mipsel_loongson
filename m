Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2010 02:20:33 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19797 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492647Ab0DTAU3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Apr 2010 02:20:29 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bccf3580001>; Mon, 19 Apr 2010 17:20:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 19 Apr 2010 17:20:08 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 19 Apr 2010 17:20:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3K0K5Cx027938;
        Mon, 19 Apr 2010 17:20:05 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3K0K5wa027937;
        Mon, 19 Apr 2010 17:20:05 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ltt-dev@lists.casi.polymtl.ca
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] lttng: MIPS: Fix syscall entry tracing.
Date:   Mon, 19 Apr 2010 17:19:49 -0700
Message-Id: <1271722791-27885-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1271722791-27885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1271722791-27885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 20 Apr 2010 00:20:07.0969 (UTC) FILETIME=[3B763110:01CAE01F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For the 32-bit kernel and all three ABIs of the 64-bit kernel, we need
to test the _TIF_KERNEL_TRACE flag on syscall entry.  Otherwise, no
syscall entry tracing for you!

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/scall32-o32.S |    2 +-
 arch/mips/kernel/scall64-64.S  |    2 +-
 arch/mips/kernel/scall64-n32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index fd2a9bb..28f262d 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -52,7 +52,7 @@ NESTED(handle_sys, PT_SIZE, sp)
 
 stack_done:
 	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
-	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
+	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_KERNEL_TRACE
 	and	t0, t1
 	bnez	t0, syscall_trace_entry	# -> yes
 
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 18bf7f3..38c0c95 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -54,7 +54,7 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
-	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
+	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_KERNEL_TRACE
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
 	bnez	t0, syscall_trace_entry
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 3541fd3..fbecc01 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -53,7 +53,7 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
-	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
+	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_KERNEL_TRACE
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
 	bnez	t0, n32_syscall_trace_entry
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 14dde4c..0db5589 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -81,7 +81,7 @@ NESTED(handle_sys, PT_SIZE, sp)
 	PTR	4b, bad_stack
 	.previous
 
-	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
+	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_KERNEL_TRACE
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
 	bnez	t0, trace_a_syscall
-- 
1.6.6.1
