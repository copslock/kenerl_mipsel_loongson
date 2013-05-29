Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 May 2013 19:02:36 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:29382 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834882Ab3E2RCSeLbpP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 May 2013 19:02:18 +0200
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Kees Cook" <keescook@chromium.org>
Subject: [RFC PATCH] kernel/signal.c: avoid BUG_ON with SIG128 (MIPS)
Date:   Wed, 29 May 2013 18:01:56 +0100
Message-ID: <1369846916-13202-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_05_29_18_02_11
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36632
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

MIPS has 128 signals, the highest of which has the number 128. The
following command causes get_signal_to_deliver() to pass this signal
number straight through to do_group_exit() as the exit code:

  strace sleep 10 & sleep 1 && kill -128 `pidof sleep`

However do_group_exit() checks for the core dump bit (0x80) in the exit
code which matches in this particular case and the kernel panics:

  BUG_ON(exit_code & 0x80); /* core dumps don't get here */

This is worked around by changing get_signal_to_deliver() to pass
min(info->si_signo, 127) instead of info->si_signo, so that this highest
of signal numbers get rounded down to 127. This makes the exit code
technically incorrect, but it's better than killing the whole kernel.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
---

This is based on v3.10-rc3.

It's a little hacky, but aside from reducing the number of signals to
127 to avoid this case (which isn't backwards compatible) I'm not sure
what else can be done. Any comments?

 kernel/signal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 113411b..69bc00f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2366,8 +2366,12 @@ relock:
 
 		/*
 		 * Death signals, no core dump.
+		 *
+		 * MIPS has a signal number 128 which clashes with the core dump
+		 * bit. If this was the signal we still want to report a valid
+		 * exit code, so round it down to 127.
 		 */
-		do_group_exit(info->si_signo);
+		do_group_exit(min(info->si_signo, 127));
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-- 
1.8.1.2
