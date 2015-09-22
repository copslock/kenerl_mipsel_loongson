Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:55:40 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:53439 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008780AbbIVRx4tp6dU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:53:56 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZeRlM-00012Y-DR; Tue, 22 Sep 2015 17:53:56 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZeRlK-0000id-7F; Tue, 22 Sep 2015 10:53:54 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 068/102] MIPS: Fix seccomp syscall argument for MIPS64
Date:   Tue, 22 Sep 2015 10:52:04 -0700
Message-Id: <1442944358-1248-69-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1442944358-1248-1-git-send-email-kamal@canonical.com>
References: <1442944358-1248-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt7 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 9f161439e4104b641a7bfb9b89581d801159fec8 upstream.

Commit 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls (o32)")
fixed indirect system calls on O32 but it also introduced a bug for MIPS64
where it erroneously modified the v0 (syscall) register with the assumption
that the sycall offset hasn't been taken into consideration. This breaks
seccomp on MIPS64 n64 and n32 ABIs. We fix this by replacing the addition
with a move instruction.

Fixes: 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls (o32)")
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10951/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/scall64-64.S  | 2 +-
 arch/mips/kernel/scall64-n32.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index ad4d4463..a6f6b76 100644
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
index 446cc65..4b20106 100644
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
1.9.1
