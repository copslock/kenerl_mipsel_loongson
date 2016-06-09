Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:06:44 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35487 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041387AbcFIVCglB0IE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:36 +0200
Received: by mail-pa0-f41.google.com with SMTP id hl6so16555403pac.2
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4r1QSdoOKATdKBhKmvfRrLqObzCzEVx+mLsTAXN2O9k=;
        b=jVBm+5hqIxE4rnonl8DARc5BaNXP8QsftcgPjCHLRTY6h7O5/hz6JwtFgY5IB7Huxi
         TKVbxk2mfT6zBctKhL3ItMt72kIRlQSTI602Nse7kli1RiBOfwrG9hee5Ji8XICHcjFM
         gshstdvZvBVGE/+7/InU2OZxJAEAoDWkiK2Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4r1QSdoOKATdKBhKmvfRrLqObzCzEVx+mLsTAXN2O9k=;
        b=RPPfFt8c3JRdUtLEuEeNuvAzloRF8Qzvxu5ld8fj/cUfnKkmP49WZ4ZMpSzjy3Tycv
         Bp7Ss2Yf2UDM2n8NMtEmkK7wwePf9y6KkBav0FKphyPeNkib95ZxTdb27l5p56QVFVUX
         u1K60twzHjMEYm59XW2zSjNxq1/Av5q981lfWiz9zsZRY4el1FQiDIrrUme9hCnJtDlk
         ftn7I0wdvQ/9g22KaeYk+IRsoguOY/nLqnTmbRbOfWydYjLap0KqnIk1Ph6Ya0/qKwMs
         cYNlq7MTuTKxSURTA+6YGSl2Zz/hlBZHSgU79b4CHERMrsD6VrtrTRk5o4ywhm0/qEXz
         ksaw==
X-Gm-Message-State: ALyK8tKLMb1GRjpW2bQZQXjicBR62E62pVICTSHX8TFnt39LCHTrqPmXqVLOutAHKIhU2wgj
X-Received: by 10.66.89.228 with SMTP id br4mr14658561pab.110.1465506150859;
        Thu, 09 Jun 2016 14:02:30 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id qc6sm12229225pac.6.2016.06.09.14.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        user-mode-linux-devel@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 13/14] tile/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:02:03 -0700
Message-Id: <1465506124-21866-14-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53977
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
Cc: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/tile/kernel/ptrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/tile/kernel/ptrace.c b/arch/tile/kernel/ptrace.c
index 8c6d2f2fefa3..d89b7011667c 100644
--- a/arch/tile/kernel/ptrace.c
+++ b/arch/tile/kernel/ptrace.c
@@ -255,14 +255,15 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 {
 	u32 work = ACCESS_ONCE(current_thread_info()->flags);
 
-	if (secure_computing(NULL) == -1)
+	if ((work & _TIF_SYSCALL_TRACE) &&
+	    tracehook_report_syscall_entry(regs)) {
+		regs->regs[TREG_SYSCALL_NR] = -1;
 		return -1;
-
-	if (work & _TIF_SYSCALL_TRACE) {
-		if (tracehook_report_syscall_entry(regs))
-			regs->regs[TREG_SYSCALL_NR] = -1;
 	}
 
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 	if (work & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_enter(regs, regs->regs[TREG_SYSCALL_NR]);
 
-- 
2.7.4
