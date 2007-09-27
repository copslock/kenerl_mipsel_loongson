Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 23:19:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:13792 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030390AbXI0WT5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 23:19:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8RMJu7q022137
	for <linux-mips@linux-mips.org>; Thu, 27 Sep 2007 23:19:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8RMJu0A022136
	for linux-mips@linux-mips.org; Thu, 27 Sep 2007 23:19:56 +0100
Date:	Thu, 27 Sep 2007 23:19:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [tglx@linutronix.de: [PATCH] clockevents: fix bogus next_event
	reset for oneshot broadcast devices]
Message-ID: <20070927221956.GA19990@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

----- Forwarded message from Thomas Gleixner <tglx@linutronix.de> -----

From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 28 Sep 2007 00:17:04 +0200
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] clockevents: fix bogus next_event reset for oneshot
	broadcast devices
Content-Type: text/plain

In periodic broadcast mode the next_event member of the broadcast device
structure is set to KTIME_MAX in the interrupt handler. This is wrong,
as we calculate the next periodic interrupt with this variable.

Remove it.

Noticed by Ralf. MIPS is the first user of this mode, it does not affect
existing users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-and-tested-by: Ralf Baechle <ralf@linux-mips.org>
---

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 0962e05..acf15b4 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -176,8 +176,6 @@ static void tick_do_periodic_broadcast(void)
  */
 static void tick_handle_periodic_broadcast(struct clock_event_device *dev)
 {
-	dev->next_event.tv64 = KTIME_MAX;
-
 	tick_do_periodic_broadcast();
 
 	/*


----- End forwarded message -----

  Ralf
