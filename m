Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 18:05:44 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:26538 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823020Ab3FNQFIHCe68 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 18:05:08 +0200
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2] MIPS: Reduce _NSIG from 128 to 127 to avoid BUG_ON
Date:   Fri, 14 Jun 2013 17:03:45 +0100
Message-ID: <1371225825-8225-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_14_17_04_55
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36890
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

MIPS has 128 signals, the highest of which has the number 128 (they
start from 1). The following command causes get_signal_to_deliver() to
pass this signal number straight through to do_group_exit() as the exit
code:

  strace sleep 10 & sleep 1 && kill -128 `pidof sleep`

However do_group_exit() checks for the core dump bit (0x80) in the exit
code which matches in this particular case and the kernel panics:

  BUG_ON(exit_code & 0x80); /* core dumps don't get here */

Lets avoid this by changing the ABI by reducing the number of signals to
127 (so that the maximum signal number is 127). Glibc incorrectly sets
[__]SIGRTMAX to 127 already. uClibc sets it to 128 so it's conceivable
that programs built against uClibc which intentionally uses RT signals
from the top (SIGRTMAX-n, n>=0) would need an updated uClibc (and a
rebuild if it's crazy enough to use __SIGRTMAX).

Note that the signals man page seems to make clear that signals should
be referred to from SIGRTMIN, and it seems unlikely that any portable
program would ever need to use 96 RT signals:

  "programs should never refer to real-time signals using hard-coded
  numbers, but instead should always refer to real-time signals using
  the notation SIGRTMIN+n, and include suitable (run-time) checks that
  SIGRTMIN+n does not exceed SIGRTMAX."

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dave Jones <davej@redhat.com>
Cc: linux-mips@linux-mips.org
---
As discussed on IRC, another possibility is to reduce the number of
signals down to 64 to match other arches and reduce the number of
sigset_t words, but I think that's riskier as it would affect glibc too.

 arch/mips/include/uapi/asm/signal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index addb9f5..40e944d 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -11,9 +11,9 @@
 
 #include <linux/types.h>
 
-#define _NSIG		128
+#define _NSIG		127
 #define _NSIG_BPW	(sizeof(unsigned long) * 8)
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+#define _NSIG_WORDS	((_NSIG + _NSIG_BPW - 1) / _NSIG_BPW)
 
 typedef struct {
 	unsigned long sig[_NSIG_WORDS];
-- 
1.8.1.2
