Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2005 21:26:20 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:5372 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225302AbVBAV0F>; Tue, 1 Feb 2005 21:26:05 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id j11LQ3dh024821;
	Tue, 1 Feb 2005 13:26:03 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id j11LQ3rQ024819;
	Tue, 1 Feb 2005 13:26:03 -0800
Date:	Tue, 1 Feb 2005 13:26:03 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] read_can_lock and write_can_lock for MIPS
Message-ID: <20050201212603.GA24787@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

With SMP+PREEMPT, read_can_lock() and write_can_lock() need to be defined. Attached
patch does this. Please review.

Thanks
Manish Lachwani

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_locks_preempt.patch"

Index: linux/include/asm-mips/spinlock.h
===================================================================
--- linux.orig/include/asm-mips/spinlock.h
+++ linux/include/asm-mips/spinlock.h
@@ -140,6 +140,9 @@
 
 #define rwlock_init(x)  do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
+#define read_can_lock(rw)	((rw)->lock >= 0)
+#define write_can_lock(rw)	(!(rw)->lock)
+
 static inline void _raw_read_lock(rwlock_t *rw)
 {
 	unsigned int tmp;

--6TrnltStXW4iwmi0--
