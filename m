Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2015 23:10:50 +0100 (CET)
Received: from mail.efficios.com ([78.47.125.74]:38688 "EHLO mail.efficios.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008934AbbLPWKsUAKdE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Dec 2015 23:10:48 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E2846340469;
        Wed, 16 Dec 2015 22:10:44 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UrLzG3PBXp3a; Wed, 16 Dec 2015 22:10:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 92E04340468;
        Wed, 16 Dec 2015 22:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X0eW1v4sZ39N; Wed, 16 Dec 2015 22:10:40 +0000 (UTC)
Received: from thinkos.internal.efficios.com (cable-192.222.213.99.electronicbox.net [192.222.213.99])
        by mail.efficios.com (Postfix) with ESMTPSA id 3A2AD340256;
        Wed, 16 Dec 2015 22:10:39 +0000 (UTC)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [RFC PATCH urcu on mips, parisc] Fix: compat_futex should work-around futex signal-restart kernel bug
Date:   Wed, 16 Dec 2015 17:09:52 -0500
Message-Id: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <mathieu.desnoyers@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@efficios.com
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

When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
signal handler. This spurious ENOSYS behavior causes hangs in liburcu
0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
same behavior. This might affect earlier kernels.

This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
nevertheless, we should try to handle this kernel bug more gracefully
than a user-space hang due to unexpected spurious ENOSYS return value.

Therefore, fallback on the "async-safe" version of compat_futex in those
situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
the nice property of being OK to use concurrently with other FUTEX_WAKE
and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.

We suspect that parisc might be affected by a similar issue (Debian
build bots reported a similar hang on both mips and parisc), but we do
not have access to the hardware required to test this hypothesis.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Michael Jeanson <mjeanson@efficios.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
CC: linux-kernel@vger.kernel.org
CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
CC: Helge Deller <deller@gmx.de>
CC: linux-parisc@vger.kernel.org
---
 compat_futex.c |  2 ++
 urcu/futex.h   | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/compat_futex.c b/compat_futex.c
index b7f78f0..9e918fe 100644
--- a/compat_futex.c
+++ b/compat_futex.c
@@ -111,6 +111,8 @@ end:
  * _ASYNC SIGNAL-SAFE_.
  * For now, timeout, uaddr2 and val3 are unused.
  * Waiter will busy-loop trying to read the condition.
+ * It is OK to use compat_futex_async() on a futex address on which
+ * futex() WAKE operations are also performed.
  */
 
 int compat_futex_async(int32_t *uaddr, int op, int32_t val,
diff --git a/urcu/futex.h b/urcu/futex.h
index 4d16cfa..a17eda8 100644
--- a/urcu/futex.h
+++ b/urcu/futex.h
@@ -73,7 +73,17 @@ static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
 
 	ret = futex(uaddr, op, val, timeout, uaddr2, val3);
 	if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
-		return compat_futex_noasync(uaddr, op, val, timeout,
+		/*
+		 * The fallback on ENOSYS is the async-safe version of
+		 * the compat futex implementation, because the
+		 * async-safe compat implementation allows being used
+		 * concurrently with calls to futex(). Indeed, sys_futex
+		 * FUTEX_WAIT, on some architectures (e.g. mips), within
+		 * a given process, spuriously return ENOSYS due to
+		 * signal restart bugs on some kernel versions (e.g.
+		 * Linux kernel 3.18 and possibly earlier).
+		 */
+		return compat_futex_async(uaddr, op, val, timeout,
 				uaddr2, val3);
 	}
 	return ret;
-- 
2.1.4
