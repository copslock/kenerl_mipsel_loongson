Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 19:44:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40928 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012181AbcBHSoLcOUEb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 19:44:11 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 7D76CCF0E198D;
        Mon,  8 Feb 2016 18:44:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 8 Feb 2016 18:44:05 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 8 Feb 2016 18:44:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        Christopher Ferris <cferris@google.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] MIPS: Fix siginfo.h to use strict posix types
Date:   Mon, 8 Feb 2016 18:43:49 +0000
Message-ID: <1454957031-20138-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1454957031-20138-1-git-send-email-james.hogan@imgtec.com>
References: <1454957031-20138-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Commit 85efde6f4e0d ("make exported headers use strict posix types")
changed the asm-generic siginfo.h to use the __kernel_* types, and
commit 3a471cbc081b ("remove __KERNEL_STRICT_NAMES") make the internal
types accessible only to the kernel, but the MIPS implementation hasn't
been updated to match.

Switch to proper types now so that the exported asm/siginfo.h won't
produce quite so many compiler errors when included alone by a user
program.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 2.6.30-
---
 arch/mips/include/uapi/asm/siginfo.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
index 2cb7fdead570..03ec1090f781 100644
--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -42,13 +42,13 @@ typedef struct siginfo {
 
 		/* kill() */
 		struct {
-			pid_t _pid;		/* sender's pid */
+			__kernel_pid_t _pid;	/* sender's pid */
 			__ARCH_SI_UID_T _uid;	/* sender's uid */
 		} _kill;
 
 		/* POSIX.1b timers */
 		struct {
-			timer_t _tid;		/* timer id */
+			__kernel_timer_t _tid;	/* timer id */
 			int _overrun;		/* overrun count */
 			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
 			sigval_t _sigval;	/* same as below */
@@ -57,26 +57,26 @@ typedef struct siginfo {
 
 		/* POSIX.1b signals */
 		struct {
-			pid_t _pid;		/* sender's pid */
+			__kernel_pid_t _pid;	/* sender's pid */
 			__ARCH_SI_UID_T _uid;	/* sender's uid */
 			sigval_t _sigval;
 		} _rt;
 
 		/* SIGCHLD */
 		struct {
-			pid_t _pid;		/* which child */
+			__kernel_pid_t _pid;	/* which child */
 			__ARCH_SI_UID_T _uid;	/* sender's uid */
 			int _status;		/* exit code */
-			clock_t _utime;
-			clock_t _stime;
+			__kernel_clock_t _utime;
+			__kernel_clock_t _stime;
 		} _sigchld;
 
 		/* IRIX SIGCHLD */
 		struct {
-			pid_t _pid;		/* which child */
-			clock_t _utime;
+			__kernel_pid_t _pid;	/* which child */
+			__kernel_clock_t _utime;
 			int _status;		/* exit code */
-			clock_t _stime;
+			__kernel_clock_t _stime;
 		} _irix_sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-- 
2.4.10
