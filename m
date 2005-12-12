Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2005 04:56:24 +0000 (GMT)
Received: from omx2-ext.sgi.com ([192.48.171.19]:55492 "EHLO omx2.sgi.com")
	by ftp.linux-mips.org with ESMTP id S8133354AbVLLE4F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Dec 2005 04:56:05 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id jBC71EEO015846;
	Sun, 11 Dec 2005 23:01:15 -0800
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA14165; Mon, 12 Dec 2005 15:55:38 +1100
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From:	Keith Owens <kaos@sgi.com>
To:	linux-kernel@vger.kernel.org
Cc:	linux-arm-kernel@lists.arm.linux.org.uk, rmk@arm.linux.org.uk,
	takata@linux-m32r.org, linux-mips@linux-mips.org,
	parisc-linux@lists.parisc-linux.org, linux-sh@m17n.org,
	lethal@linux-sh.org, davem@davemloft.net,
	sparclinux@vger.kernel.org
Subject: generic read_trylock() never tries, it always waits
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:	Mon, 12 Dec 2005 15:55:38 +1100
Message-ID: <9942.1134363338@kao2.melbourne.sgi.com>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

Copied to assorted architecture maintainers and mailing lists, please
trim cc: list back to lkml plus arch if you reply.

The generic version of read_trylock() never tests if the lock is in
use, it always spins waiting for the lock to be free.  IOW, it behaves
like read_lock().  Given the different implementations of rwlock_t, it
is hard for generic__raw_read_trylock() to do anything else.

I strongly recommend that the architectures below define their own
version of __raw_read_trylock() that really test the lock first, then
we can ditch generic__raw_read_trylock().  I have already sent an ia64
patch to that mailing list.

include/asm-arm/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-ia64/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-m32r/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-mips/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-parisc/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-sh/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-sparc64/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
