Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 04:22:06 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55024 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006506AbcARDWEHkq3J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 04:22:04 +0100
Received: from deadeye.wl.decadent.org.uk ([192.168.4.247] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1aL0OI-0005Ap-21; Mon, 18 Jan 2016 03:22:02 +0000
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1aL0OB-0004DY-MO; Mon, 18 Jan 2016 03:21:55 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Ed Swierk" <eswierk@skyportsystems.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Mon, 18 Jan 2016 03:18:35 +0000
Message-ID: <lsq.1453087115.124626824@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 37/70] MIPS: Fix restart of indirect syscalls
In-Reply-To: <lsq.1453087114.713093519@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.247
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.76-rc1 review patch.  If anyone has any objections, please let me know.

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
---
 arch/mips/kernel/scall32-o32.S | 1 +
 arch/mips/kernel/scall64-o32.S | 1 +
 2 files changed, 2 insertions(+)

--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -192,6 +192,7 @@ illegal_syscall:
 	sll	t1, t0, 3
 	beqz	v0, einval
 	lw	t2, sys_call_table(t1)		# syscall routine
+	sw	a0, PT_R2(sp)			# call routine directly on restart
 
 	/* Some syscalls like execve get their arguments from struct pt_regs
 	   and claim zero arguments in the syscall table. Thus we have to
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -180,6 +180,7 @@ LEAF(sys32_syscall)
 	dsll	t1, t0, 3
 	beqz	v0, einval
 	ld	t2, sys_call_table(t1)		# syscall routine
+	sd	a0, PT_R2(sp)		# call routine directly on restart
 
 	move	a0, a1			# shift argument registers
 	move	a1, a2
