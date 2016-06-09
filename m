Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:05:47 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36704 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041422AbcFIVCfbbDkE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:35 +0200
Received: by mail-pa0-f43.google.com with SMTP id b5so16518528pas.3
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Sw2W3K42wZ2ymBLqhVP49O2I+Kh9DVzTU+Zk8PVUaM=;
        b=b8NMWorhTBAxMp9++W+c+usgSzj0AFGeKv6U6jSrgZFlpiTOAmtkLRd9bWQemqSp0t
         4InMg3C4C5U5G0kk5K9Ym8uoX9o9pyyDzRQjn0oF0LduCFhq1HmZ3grsad2bgnpBdz10
         uUFtrMSi0ij56CZO+HF01MrSKunPVvZh237yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Sw2W3K42wZ2ymBLqhVP49O2I+Kh9DVzTU+Zk8PVUaM=;
        b=mxSBkq0A9cdY4LoN5B0jKg7bmXWhmVUxFHIGOMu1Uac0C/A9zQuAlVhBno2IIxhQ+n
         F7DAqFNyCBQmgrCPRwrM94CBFg0aoHUg65dPmR204DN2yVLFN2g2AhlLxSUereTNaLW/
         Hsc5fdD2uaJ1sPA0ljo4hgQMmLRN5P2PkfGNYpTRrMdrciOdTtRMkahNOG4hMe5Sc26a
         lTtpl5hr9UN2AA21M53fTJJzad7zVIKJKC8mQSK3fb2J0vFZM2JnPdyQqME3U2KU/ss5
         A6dIP5knZbsIbnCLBHYAzuYH1EHZNRQNJ1X5YgR3PI0tHgM8YaODIrybniMIWSYlsm6V
         /h/A==
X-Gm-Message-State: ALyK8tKwmGqy9TwvTK6fqHZknbXaS+jklva7neK3WmX8ySjAdujwW0gAfswsYSFOk7C2EaaV
X-Received: by 10.66.49.134 with SMTP id u6mr14467962pan.118.1465506149704;
        Thu, 09 Jun 2016 14:02:29 -0700 (PDT)
Received: from www.outflux.net ([2002:ada4:7085:0:ae16:2dff:fe07:4fb6])
        by smtp.gmail.com with ESMTPSA id 14sm12132101pfu.83.2016.06.09.14.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        user-mode-linux-devel@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 09/14] MIPS/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:01:59 -0700
Message-Id: <1465506124-21866-10-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53974
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
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/ptrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index c50af846ecf9..6103b24d1bfc 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -888,17 +888,16 @@ long arch_ptrace(struct task_struct *child, long request,
  */
 asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 {
-	long ret = 0;
 	user_exit();
 
 	current_thread_info()->syscall = syscall;
 
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
-		ret = -1;
+		return -1;
+
+	if (secure_computing(NULL) == -1)
+		return -1;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
-- 
2.7.4
