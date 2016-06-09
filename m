Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:06:04 +0200 (CEST)
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36068 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041424AbcFIVCftINQE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:35 +0200
Received: by mail-pf0-f182.google.com with SMTP id t190so16330066pfb.3
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MsvE6N6UqdLeFMmaS/9rZC4XR2ujr1fHSLfiP2y/Gn0=;
        b=bpwssgpewcKPO78yV+657MZdSY0DX34/P/3SKXqet/xN2BYH3+qOeNGtKDySd2ee5s
         qEu/ZAt8SE9mIvFdMM6RC8nX71yoEoI9AfUfe8T2ZPiAcGNqDewn0ADRsYwjUa4HS/y4
         k80kVO4ijjVpJ6N6uWlfgnGzuZVevhqGjgt9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MsvE6N6UqdLeFMmaS/9rZC4XR2ujr1fHSLfiP2y/Gn0=;
        b=iTVr3pWc+yO54hjAT7tzW1esU1xWOuuDHayhUy0MuqydzJuuIOMrfdslf2V9YVn0/r
         v671UzFUksMHZcntjUQjHagPIWWIkQ693755knYUvpY+su7XxtonQETI4czoF3y4zRhB
         5I2TaadeMgyCw8lKp+SIv2LfsCVTvUHfjHP8WDDUWgezkBqI8ux0uwVZD29PoX212p8d
         /Hz9rq+iJNT7gBt7SeWj87Qf0utj/OD/R1N7Zj4yBBwMhm/CgmBCAiXfMofuYYipZj5T
         CuebYIXxAu3aNBN71+y4yBkyGr2U2XdzrbycNwlL4+yDC9gyqNGvgOSFFG4Cwow5+trB
         MUjw==
X-Gm-Message-State: ALyK8tInbtz9HcW3IBLV1mlv0PDD/MNZDv23u0eoQoI7pY1VAjsbndMJr21fXvS+waewyoSk
X-Received: by 10.98.41.133 with SMTP id p127mr6463692pfp.18.1465506150029;
        Thu, 09 Jun 2016 14:02:30 -0700 (PDT)
Received: from www.outflux.net ([2002:ada4:7085:0:ae16:2dff:fe07:4fb6])
        by smtp.gmail.com with ESMTPSA id 12sm12152345pfx.68.2016.06.09.14.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        user-mode-linux-devel@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 11/14] s390/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:02:01 -0700
Message-Id: <1465506124-21866-12-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/ptrace.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index c238e9958c2a..cea17010448f 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -821,15 +821,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	long ret = 0;
-
-	/* Do the secure computing check first. */
-	if (secure_computing(NULL)) {
-		/* seccomp failures shouldn't expose any additional code. */
-		ret = -1;
-		goto out;
-	}
-
 	/*
 	 * The sysc_tracesys code in entry.S stored the system
 	 * call number to gprs[2].
@@ -843,7 +834,13 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		 * the system call and the system call restart handling.
 		 */
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
-		ret = -1;
+		return -1;
+	}
+
+	/* Do the secure computing check after ptrace. */
+	if (secure_computing(NULL)) {
+		/* seccomp failures shouldn't expose any additional code. */
+		return -1;
 	}
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
@@ -852,8 +849,8 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	audit_syscall_entry(regs->gprs[2], regs->orig_gpr2,
 			    regs->gprs[3], regs->gprs[4],
 			    regs->gprs[5]);
-out:
-	return ret ?: regs->gprs[2];
+
+	return regs->gprs[2];
 }
 
 asmlinkage void do_syscall_trace_exit(struct pt_regs *regs)
-- 
2.7.4
