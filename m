Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 15:46:48 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:27518 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009087AbcAWOqr0kD15 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 15:46:47 +0100
Message-Id: <20160123141223.589159555@1wt.eu>
User-Agent: quilt/0.63-1
Date:   Sat, 23 Jan 2016 15:12:58 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ed Swierk <eswierk@skyportsystems.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2.6.32 37/42] MIPS: Fix restart of indirect syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
In-Reply-To: <aa387f55227cb730b41e3d621bf460ff@local>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

2.6.32-longterm review patch.  If anyone has any objections, please let me know.

------------------

From: Ed Swierk <eswierk@skyportsystems.com>

commit e967ef022e00bb7c2e5b1a42007abfdd52055050 upstream.

When 32-bit MIPS userspace invokes a syscall indirectly via syscall(number,
arg1, ..., arg7), the kernel looks up the actual syscall based on the given
number, shifts the other arguments to the left, and jumps to the syscall.

If the syscall is interrupted by a signal and indicates it needs to be
restarted by the kernel (by returning ERESTARTNOINTR for example), the
syscall must be called directly, since the number is no longer the first
argument, and the other arguments are now staged for a direct call.

Before shifting the arguments, store the syscall number in pt_regs->regs[2].
This gets copied temporarily into pt_regs->regs[0] after the syscall returns.
If the syscall needs to be restarted, handle_signal()/do_signal() copies the
number back to pt_regs->reg[2], which ends up in $v0 once control returns to
userspace.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8929/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
(cherry picked from commit 08f865bba9c705aef95268a33393698e5385587e)
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/scall32-o32.S | 1 +
 arch/mips/kernel/scall64-o32.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index b72c554..44194c1 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -194,6 +194,7 @@ illegal_syscall:
 	sll	t1, t0, 3
 	beqz	v0, einval
 	lw	t2, sys_call_table(t1)		# syscall routine
+	sw	a0, PT_R2(sp)			# call routine directly on restart
 
 	/* Some syscalls like execve get their arguments from struct pt_regs
 	   and claim zero arguments in the syscall table. Thus we have to
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 33ed571..1f7c01f 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -180,6 +180,7 @@ LEAF(sys32_syscall)
 	dsll	t1, t0, 3
 	beqz	v0, einval
 	ld	t2, sys_call_table(t1)		# syscall routine
+	sd	a0, PT_R2(sp)		# call routine directly on restart
 
 	move	a0, a1			# shift argument registers
 	move	a1, a2
-- 
1.7.12.2.21.g234cd45.dirty
