From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 26 Jun 2013 11:48:11 +0100
Subject: [PATCH 1/1] kernel/signal.c: fix BUG_ON with SIG128 (MIPS)
Message-ID: <20130626104811.4c8sia8ANfYqGWP-d3kl_0mlPkrKWQbRAFUAHHjqRp0@z>

MIPS has 128 signals, the highest of which has the number 128 (they
start from 1). The following command causes get_signal_to_deliver() to
pass this signal number straight through to do_group_exit() as the exit
code:

  strace sleep 10 & sleep 1 && kill -128 `pidof sleep`

However do_group_exit() checks for the core dump bit (0x80) in the exit
code which matches in this particular case and the kernel panics:

  BUG_ON(exit_code & 0x80); /* core dumps don't get here */

As a quick fix, mask out higher bits in the signal number. This
effectively matches the exit code from other code paths but avoids the
BUG_ON.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Daney <david.daney@cavium.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dave Jones <davej@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
---
 kernel/signal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 113411b..9ea8f4f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2366,8 +2366,14 @@ relock:
 
 		/*
 		 * Death signals, no core dump.
+		 *
+		 * Some architectures (MIPS) have 128 signals which doesn't play
+		 * nicely with the exit code since there are only 7 bits to
+		 * store the terminating signal number. Mask out higher bits to
+		 * avoid overflowing into the core dump bit and triggering
+		 * BUG_ON in do_group_exit.
 		 */
-		do_group_exit(info->si_signo);
+		do_group_exit(info->si_signo & 0x7f);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-- 
1.8.1.2
