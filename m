Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:07:06 +0200 (CEST)
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36072 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041452AbcFIVCg5h5OE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:36 +0200
Received: by mail-pf0-f178.google.com with SMTP id t190so16330226pfb.3
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qSrZRKA/re/ckHRR3o3LlYcPsFI9+7jvkw4LPjMDH60=;
        b=AprkSqwfC8aOSOPvOcCJJkfMCkPYjWPtiXOUxlhMNBhK9ffwVeU4oXPTEcYA9moKWx
         jiymuOHx77ZLgQXazMXkX4ybjokoKiiNyWt/ebAKVEBytq55yevnmyoVC0moqFU/iwAH
         QeHq1hqIqrcpcABC7FaxALsnxy/qdT8QCwulM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qSrZRKA/re/ckHRR3o3LlYcPsFI9+7jvkw4LPjMDH60=;
        b=eTGCuz34vIOMUk+aUofy+n1bKOBxGJrs/V/8QYFtP6vKChLZDkUqLGqC5dBxPG3ody
         rFzLCq6QtvUB2a5ERTwAShrPDy2VIqjuLetDYdOtId0y4/uQHPE4xzcjULqiCx+Je2r2
         BwWbEzyhGvye6C3+xr2aS1gWY5AkiXeAJgcAKicBYHNYvHhOjOM/Cc85NoPE0Y9vwivd
         uPR8HJBufOuih+kWWnbGoX/kvFOw58tHguIn5cJ8mXgBNu9f6AK6P8cxMvFBrTIW1UtZ
         q7CN2LmGE6PsWiOhkCA/wUyB9/LRp05aIdBwC40ERtif+Npq0kBQ6gYsGlQH2fPmeSZz
         l/lQ==
X-Gm-Message-State: ALyK8tL3keUB1Ylqon1Gaz57LS8RTXxwgVq08pyoB+OECCeiX18HuFtgv9VcZ4IwLabrvurJ
X-Received: by 10.98.6.69 with SMTP id 66mr6439204pfg.115.1465506151198;
        Thu, 09 Jun 2016 14:02:31 -0700 (PDT)
Received: from www.outflux.net ([2002:ada4:7085:0:ae16:2dff:fe07:4fb6])
        by smtp.gmail.com with ESMTPSA id hw10sm12191436pac.15.2016.06.09.14.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 14/14] um/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:02:04 -0700
Message-Id: <1465506124-21866-15-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53978
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
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/skas/syscall.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 9c5570f0f397..ef4b8f949b51 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -20,12 +20,12 @@ void handle_syscall(struct uml_pt_regs *r)
 	UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
 
-	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing(NULL) == -1)
+	if (syscall_trace_enter(regs))
 		return;
 
-	if (syscall_trace_enter(regs))
-		goto out;
+	/* Do the seccomp check after ptrace; failures should be fast. */
+	if (secure_computing(NULL) == -1)
+		return;
 
 	/* Update the syscall number after orig_ax has potentially been updated
 	 * with ptrace.
@@ -37,6 +37,5 @@ void handle_syscall(struct uml_pt_regs *r)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
-out:
 	syscall_trace_leave(regs);
 }
-- 
2.7.4
