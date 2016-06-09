Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:04:43 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34443 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041367AbcFIVCeSMYRE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:34 +0200
Received: by mail-pa0-f44.google.com with SMTP id bz2so16566139pad.1
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Agt+T1/d29QO4JpwlHHaurvkgf9FYvFYMHxfUADfL1w=;
        b=TOieIH50V8TaKK8ZuBMDxMLwv+S1AggGqzfHhs77Ud3yMxkQOplGu57NXixe6WFVtF
         1NJ0dW/cxaCm5d22bXHtNSkRfVYIZbUtiy5KfOhFEv4QTJWInThQS8GHivTxMzeZtVHK
         m6PqCwj385USDVV2JRydE6l0vN+rJKEZzaCAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Agt+T1/d29QO4JpwlHHaurvkgf9FYvFYMHxfUADfL1w=;
        b=Ej418W1NX8GtZIDddJvDbgah0/buKt4ZtpfENYn+LdGGEcd7ND/8HZ8Vhyw2z8n7Bs
         LmURRY5eLCZDoXb3YYJlkhTT9dGDJZN/hgau0igTxKj+MKgd6gZZccl7FJc5APf4CHIh
         tYtDo6Udyszcp7MioVHxPzHuj1Htpg+Vk7adSR9ixAFaOPsNzyFzdC73lvOOMtPma88K
         oC/06hSwSlfmgZVK6abcKEyj0Ta6q9811kIHC1i8GUyreqEbhMZ2oXa28Hm2D4ZZSkc1
         6y/9Y1YfkZNKthakcnOTy4eF5XuQeqS42UToyLnvwn7WftIB1QKxjyoLB/ORrF91+o9N
         VVXg==
X-Gm-Message-State: ALyK8tKNlDAb+tGrYAQxQso6GP/cibnWUa2OspzXseOoVQTm3EROhqFNZUK6f93RJ0CpfYei
X-Received: by 10.66.25.231 with SMTP id f7mr14574389pag.65.1465506148523;
        Thu, 09 Jun 2016 14:02:28 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l129sm12265904pfc.5.2016.06.09.14.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org
Subject: [PATCH 08/14] arm64/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:01:58 -0700
Message-Id: <1465506124-21866-9-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53971
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/ptrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6e2cf046615d..602316c97a47 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1246,13 +1246,13 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
 
+	/* Do the secure computing after ptrace; failures should be fast. */
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->syscallno);
 
-- 
2.7.4
