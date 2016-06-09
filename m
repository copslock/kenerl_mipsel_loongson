Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:05:07 +0200 (CEST)
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34643 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041413AbcFIVCegugJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:34 +0200
Received: by mail-pf0-f177.google.com with SMTP id 62so16361574pfd.1
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hsne7rjptpK2v5g2LzbrLT5o1W9sSkv6Twx8ZgIqYAA=;
        b=Mdt5E4Imll7KXY0i/yXM6cWPT0062qz75ej8IxKH2fSyyd8oNS1EVlNh2pPjqnpnt2
         y6fxJa9pHFNnJfNxb6bOuSqXYzjyGDKDpdM111o3LINQvnfhR1npuC340cZdTd9qm9OC
         IBoKwuYf1bfTu4sQqM7kNLoXzPJakN4vrW1tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hsne7rjptpK2v5g2LzbrLT5o1W9sSkv6Twx8ZgIqYAA=;
        b=Uc5pdAFbJpQsXnB2Hmb+J2vhDcC0Be4pq3bpHn02cjaxz/2GZqodT/Rvk3VSl7HmUE
         Q/WTMdcLXxgNhGI99U1G9BNjgf6PdqYMfbVFir/zUQAwbtsi8rr3RFkE43bob6IIPNfz
         Oxe12Wy5cdrZ37t7bs3DsJTW1xDPLljLwLoI9XFMfGxQKf6e8HeNgghREQkecN4ynHez
         WFdESJQ4oXOBic6mHTxRLam7J7mFECZePVZabwm6bBN+NGnBPcIIMHZ1aDlFYBiR136k
         DJ7MHXM+SVPCzz+M/R/EcHBbUbDPugthH2/eVJcSmUjCKFCTOV+zhqBu9DXoc7UMt8zN
         oOzA==
X-Gm-Message-State: ALyK8tL9Xxm5EQPrU74270JdW+pDE41mhqgla57YBrhp7qdIaj1569Rc3dvWhaKKyD1YXzsm
X-Received: by 10.98.8.91 with SMTP id c88mr6448526pfd.57.1465506148864;
        Thu, 09 Jun 2016 14:02:28 -0700 (PDT)
Received: from www.outflux.net ([2002:ada4:7085:0:ae16:2dff:fe07:4fb6])
        by smtp.gmail.com with ESMTPSA id zn12sm12215972pab.14.2016.06.09.14.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 07/14] arm/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:01:57 -0700
Message-Id: <1465506124-21866-8-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53972
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
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/kernel/ptrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ad5e90ab165c..dc7b372872ff 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -932,18 +932,19 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 {
 	current_thread_info()->syscall = scno;
 
-	/* Do the secure computing check first; failures should be fast. */
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
+
+	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 	if (secure_computing(NULL) == -1)
 		return -1;
 #else
 	/* XXX: remove this once OABI gets fixed */
-	secure_computing_strict(scno);
+	secure_computing_strict(current_thread_info()->syscall);
 #endif
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
-
+	/* Tracer or seccomp may have changed syscall. */
 	scno = current_thread_info()->syscall;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-- 
2.7.4
