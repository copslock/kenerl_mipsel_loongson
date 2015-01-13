Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 06:11:39 +0100 (CET)
Received: from mail-yh0-f48.google.com ([209.85.213.48]:46320 "EHLO
        mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbbAMFLinMBGF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 06:11:38 +0100
Received: by mail-yh0-f48.google.com with SMTP id i57so500398yha.7
        for <linux-mips@linux-mips.org>; Mon, 12 Jan 2015 21:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ILyR2oIEWazJ/qoVhRZlBamx0unP8BZloyXQo2OmT9s=;
        b=HKw1/O/nBC6lrmXEI2Oy0Rl0t8qLlvG0Coynr8yIqLlGgBnKgmujvE05NsYR6xIzHp
         pF3EBewTZK+YnJv8goGoHvv376KOeqxf6IPJplDE9JiGFJ0aG9wjfuf/A152eiYQkuOy
         ABXQ3pV7m0Evcw9oxDJAvoxxDD8ztSCJbHianKWQA1Ar1mxHSBJFdWxuTbUjpLbpowQq
         sO3+oJSkQhsIrtlQTibxcOpjdmtEJbz4CDzxpk/O2Njs2StHipNz+N638te/w1YPpnGn
         hUzcpaXqVOa6pzjTJLfa7t7EikMxW1TNu5QCbgMMNpJdqbrWZrEv8xWGBScGq09FDjo7
         2I3A==
X-Gm-Message-State: ALoCoQm3O93vRYJjrC3w5mCpeYJFUiGcs544XzYjHX38J4G+rVXHSXfE7JkGRuSMIHpHli2IIi0Q
X-Received: by 10.236.1.234 with SMTP id 70mr26007651yhd.64.1421125892759;
        Mon, 12 Jan 2015 21:11:32 -0800 (PST)
Received: from fido2.skyportsystems.com (gateway.skyportsystems.com. [74.93.0.69])
        by mx.google.com with ESMTPSA id 59sm9381681yhu.32.2015.01.12.21.11.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jan 2015 21:11:32 -0800 (PST)
From:   Ed Swierk <eswierk@skyportsystems.com>
To:     linux-mips@linux-mips.org
Cc:     Ed Swierk <eswierk@skyportsystems.com>
Subject: [PATCH] MIPS: Fix restart of indirect syscalls
Date:   Mon, 12 Jan 2015 21:10:30 -0800
Message-Id: <1421125830-60155-1-git-send-email-eswierk@skyportsystems.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <eswierk@skyportsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eswierk@skyportsystems.com
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
---
 arch/mips/kernel/scall32-o32.S | 1 +
 arch/mips/kernel/scall64-o32.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a5b14f4..8765289 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -171,6 +171,7 @@ illegal_syscall:
 	sll	t1, t0, 2
 	beqz	v0, einval
 	lw	t2, sys_call_table(t1)		# syscall routine
+	sw	a0, PT_R2(sp)			# call routine directly on restart
 
 	/* Some syscalls like execve get their arguments from struct pt_regs
 	   and claim zero arguments in the syscall table. Thus we have to
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 6788727d..299a8b6 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -169,6 +169,7 @@ LEAF(sys32_syscall)
 	dsll	t1, t0, 3
 	beqz	v0, einval
 	ld	t2, sys32_call_table(t1)		# syscall routine
+	sd	a0, PT_R2(sp)		# call routine directly on restart
 
 	move	a0, a1			# shift argument registers
 	move	a1, a2
-- 
1.9.1
