Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:03:06 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34438 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041378AbcFIVCcYZG5E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:32 +0200
Received: by mail-pa0-f49.google.com with SMTP id bz2so16565924pad.1
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zGj3Dc5fUo4wG9tXYIAGSwK5+QIWrKBBNZnIHpErj8M=;
        b=fWmt5ZWb+QsU98L+B3q4kO3IFGwhojT+bjD5bjT6Ubc0c4f1WOaqD9dYPsqGxvDdf6
         Q7uJFwWPpyaovCye1qkz4gyUhQTn2JSsGHfP0x68INnRhu/ebC2sk4HP20r3eiM343l0
         rl7jwDnm05Z7vej229qNU/yLo8rBfePXzjO3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zGj3Dc5fUo4wG9tXYIAGSwK5+QIWrKBBNZnIHpErj8M=;
        b=EBMCHI8+zYKfHDrbijSlt6BnLWkLJHt76aTYkbWgi94JZ9OE5d5DRDEyIYKuqXzqNm
         wn1QYb1SkySarBvTLAWv97R+ZXlzo2QIymSnVVMFIdC5QChPviSe6abtDz6w5A1TM1Wk
         TQDpKSt16n45QnVJfEbk1xHMoKbwAHdWLPpcTPDvvIr8lX7Y/fGoaRRvJkTOQeAaaa87
         Mkhc1Lojdfs8sJmxgDyKt/JMpeOQnXhEzdyp9jmtd1GiRZP0oVw7lstKPu9BDQ0A5SAG
         LTH+fuJVz+egvpk6eJEK4XvzaDHp1er0rZX4W6wzU720Y1o8RzXRNX4Owcek+urOYGaN
         MgVg==
X-Gm-Message-State: ALyK8tJw6bqCJ6L01z0zSvrdwlMXYvh72MqW2Q60Qxz2eaLNbOgn0PHII3Oyv0/Rxo3K4N6V
X-Received: by 10.66.55.69 with SMTP id q5mr14393835pap.145.1465506146620;
        Thu, 09 Jun 2016 14:02:26 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id ce8sm12105174pad.44.2016.06.09.14.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
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
Subject: [PATCH 05/14] seccomp: recheck the syscall after RET_TRACE
Date:   Thu,  9 Jun 2016 14:01:55 -0700
Message-Id: <1465506124-21866-6-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53966
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

When RET_TRACE triggers, a tracer may change a syscall into something that
should be filtered by seccomp. This re-runs seccomp after a trace event
to make sure things continue to pass.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
 kernel/seccomp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 14a37d71b612..54d15eb2b701 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -556,7 +556,8 @@ void secure_computing_strict(int this_syscall)
 #else
 
 #ifdef CONFIG_SECCOMP_FILTER
-static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
+static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
+			    const bool recheck_after_trace)
 {
 	u32 filter_ret, action;
 	int data;
@@ -588,6 +589,10 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
 		goto skip;
 
 	case SECCOMP_RET_TRACE:
+		/* We've been put in this state by the ptracer already. */
+		if (recheck_after_trace)
+			return 0;
+
 		/* ENOSYS these calls if there is no tracer attached. */
 		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
 			syscall_set_return_value(current,
@@ -611,6 +616,15 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
 		if (this_syscall < 0)
 			goto skip;
 
+		/*
+		 * Recheck the syscall, since it may have changed. This
+		 * intentionally uses a NULL struct seccomp_data to force
+		 * a reload of all registers. This does not goto skip since
+		 * a skip would have already been reported.
+		 */
+		if (__seccomp_filter(this_syscall, NULL, true))
+			return -1;
+
 		return 0;
 
 	case SECCOMP_RET_ALLOW:
@@ -629,7 +643,8 @@ skip:
 	return -1;
 }
 #else
-static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
+static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
+			    const bool recheck_after_trace)
 {
 	BUG();
 }
@@ -652,7 +667,7 @@ int __secure_computing(const struct seccomp_data *sd)
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
 		return 0;
 	case SECCOMP_MODE_FILTER:
-		return __seccomp_filter(this_syscall, sd);
+		return __seccomp_filter(this_syscall, sd, false);
 	default:
 		BUG();
 	}
-- 
2.7.4
