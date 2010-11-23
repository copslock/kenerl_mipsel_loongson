Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 19:35:30 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:32908 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492058Ab0KWSf1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 19:35:27 +0100
Received: (qmail 26193 invoked from network); 23 Nov 2010 18:35:24 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Nov 2010 18:35:24 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Tue, 23 Nov 2010 10:35:24 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] MIPS: Fix CP0 COUNTER clockevent race
Date:   Tue, 23 Nov 2010 10:26:44 -0800
Message-Id: <444ef6c4bbb47d55c700452d8cd23229@localhost>
In-Reply-To: <8a8eee995454c8b271cceb440e31699a@localhost>
References: <8a8eee995454c8b271cceb440e31699a@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

Consider the following test case:

write_c0_compare(read_c0_count());

Even if the counter doesn't increment during execution, this might not
generate an interrupt until the counter wraps around.  The CPU may
perform the comparison each time CP0 COUNT increments, not when CP0
COMPARE is written.

If mips_next_event() is called with a very small delta, and CP0 COUNT
increments during the calculation of "cnt += delta", it is possible
that CP0 COMPARE will be written with the current value of CP0 COUNT.
If this is detected, the function should return -ETIME, to indicate
that the interrupt might not have actually gotten scheduled.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/cevt-r4k.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 2f4d7a9..98c5a97 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -32,7 +32,7 @@ static int mips_next_event(unsigned long delta,
 	cnt = read_c0_count();
 	cnt += delta;
 	write_c0_compare(cnt);
-	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
+	res = ((int)(read_c0_count() - cnt) >= 0) ? -ETIME : 0;
 	return res;
 }
 
-- 
1.7.0.4
