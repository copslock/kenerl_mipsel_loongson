Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 19:59:47 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38091 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993040AbcHMR7boqbqD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 19:59:31 +0200
Received: from 92.40.249.202.threembb.co.uk ([92.40.249.202] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYdDV-0003fH-KV; Sat, 13 Aug 2016 18:59:29 +0100
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYd3f-0002sQ-6g; Sat, 13 Aug 2016 18:49:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Christopher Ferris" <cferris@google.com>,
        linux-mips@linux-mips.org
Date:   Sat, 13 Aug 2016 18:42:51 +0100
Message-ID: <lsq.1471110171.723725154@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 051/305] MIPS: Fix siginfo.h to use strict posix types
In-Reply-To: <lsq.1471110169.907390585@decadent.org.uk>
X-SA-Exim-Connect-IP: 92.40.249.202
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.37-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 5daebc477da4dfeb31ae193d83084def58fd2697 upstream.

Commit 85efde6f4e0d ("make exported headers use strict posix types")
changed the asm-generic siginfo.h to use the __kernel_* types, and
commit 3a471cbc081b ("remove __KERNEL_STRICT_NAMES") make the internal
types accessible only to the kernel, but the MIPS implementation hasn't
been updated to match.

Switch to proper types now so that the exported asm/siginfo.h won't
produce quite so many compiler errors when included alone by a user
program.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Christopher Ferris <cferris@google.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12477/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/uapi/asm/siginfo.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -48,13 +48,13 @@ typedef struct siginfo {
 
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
@@ -63,26 +63,26 @@ typedef struct siginfo {
 
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
