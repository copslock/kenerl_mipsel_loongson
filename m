Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 12:39:02 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55998 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492497AbZLBLi7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 12:38:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB2BcvSM001880
        for <linux-mips@linux-mips.org>; Wed, 2 Dec 2009 11:38:57 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB2BcuCQ001821
        for linux-mips@linux-mips.org; Wed, 2 Dec 2009 11:38:56 GMT
Date:   Wed, 2 Dec 2009 11:38:55 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Fix MIPS I build.
Message-ID: <20091202113855.GA32256@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Broken by d63c63e889bbeeaa461a8addf1245f89f3ce4ece (lmo) rsp.
f1e39a4a616cd9981a9decfd5332fd07a01abb8b (kernel.org).

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 3fe1fcf..fe0d798 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -306,6 +306,7 @@ static inline int mips_atomic_set(struct pt_regs *regs,
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__ (
+		"	.set	mips3					\n"
 		"	li	%[err], 0				\n"
 		"1:	ll	%[old], (%[addr])			\n"
 		"	move	%[tmp], %[new]				\n"
@@ -320,6 +321,7 @@ static inline int mips_atomic_set(struct pt_regs *regs,
 		"	"STR(PTR)"	1b, 4b				\n"
 		"	"STR(PTR)"	2b, 4b				\n"
 		"	.previous					\n"
+		"	.set	mips0					\n"
 		: [old] "=&r" (old),
 		  [err] "=&r" (err),
 		  [tmp] "=&r" (tmp)
@@ -329,6 +331,7 @@ static inline int mips_atomic_set(struct pt_regs *regs,
 		: "memory");
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__ (
+		"	.set	mips3					\n"
 		"	li	%[err], 0				\n"
 		"1:	ll	%[old], (%[addr])			\n"
 		"	move	%[tmp], %[new]				\n"
@@ -347,6 +350,7 @@ static inline int mips_atomic_set(struct pt_regs *regs,
 		"	"STR(PTR)"	1b, 5b				\n"
 		"	"STR(PTR)"	2b, 5b				\n"
 		"	.previous					\n"
+		"	.set	mips0					\n"
 		: [old] "=&r" (old),
 		  [err] "=&r" (err),
 		  [tmp] "=&r" (tmp)
