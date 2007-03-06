Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 01:51:08 +0000 (GMT)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:40113 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20021315AbXCFBvG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Mar 2007 01:51:06 +0000
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 0D0BB3E267;
	Mon,  5 Mar 2007 20:50:27 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17900.51427.895657.607267@zeus.sw.starentnetworks.com>
Date:	Mon, 5 Mar 2007 20:50:27 -0500
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fix __raw_read_trylock() to allow multiple readers
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


Code is from linux-mips.org's git tree at 2.6.18 plus some patches
from 2.6.18.7.

I've run into a deadlock that occurs with the following config:

CONFIG_SMP
CONFIG_PREEMPT

An individual call to __raw_read_trylock() will just return failure if
there is already a reader.

Any code that tries to take a read lock by looping around
__raw_read_trylock() can deadlock if there is already a reader and the
lock in question has a mix of irq and non-irq readers.

This is the case in the _read_lock() from BUILD_LOCK_OPS() in
kernel/spinlock.c.

Perhaps someone can confirm this bug by a code inspection, but I
think the below patch will fix the issue.

Patch should apply ok to 2.6.18.7 (and a similar one to >= 2.6.19)

-- 
Dave Johnson
Starent Networks

========================  PATCH FOLLOWS  ========================

Fix __raw_read_trylock() to allow multiple readers.

A deadlock can occur for mixed irq and non-irq rwlock readers if
a 2nd reader attempts to take lock by looping around __raw_read_trylock().

Signed-off-by: Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>

--- old/include/asm-mips/spinlock.h	2007-03-05 20:34:51.000000000 -0500
+++ new/include/asm-mips/spinlock.h	2007-03-05 20:35:18.000000000 -0500
@@ -249,7 +249,7 @@
 		"	.set	noreorder	# __raw_read_trylock	\n"
 		"	li	%2, 0					\n"
 		"1:	ll	%1, %3					\n"
-		"	bnez	%1, 2f					\n"
+		"	bltz	%1, 2f					\n"
 		"	 addu	%1, 1					\n"
 		"	sc	%1, %0					\n"
 		"	beqzl	%1, 1b					\n"
@@ -267,7 +267,7 @@
 		"	.set	noreorder	# __raw_read_trylock	\n"
 		"	li	%2, 0					\n"
 		"1:	ll	%1, %3					\n"
-		"	bnez	%1, 2f					\n"
+		"	bltz	%1, 2f					\n"
 		"	 addu	%1, 1					\n"
 		"	sc	%1, %0					\n"
 		"	beqz	%1, 1b					\n"
