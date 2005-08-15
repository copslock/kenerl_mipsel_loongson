Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2005 19:10:21 +0100 (BST)
Received: from e5.ny.us.ibm.com ([IPv6:::ffff:32.97.182.145]:7637 "EHLO
	e5.ny.us.ibm.com") by linux-mips.org with ESMTP id <S8225256AbVHOSJ7>;
	Mon, 15 Aug 2005 19:09:59 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7FIEUME028482;
	Mon, 15 Aug 2005 14:14:30 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7FIEUos259450;
	Mon, 15 Aug 2005 14:14:30 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7FIEU3l010809;
	Mon, 15 Aug 2005 14:14:30 -0400
Received: from joust (dyn9047017070.beaverton.ibm.com [9.47.17.70] (may be forged))
	by d01av04.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7FIEUAa010777;
	Mon, 15 Aug 2005 14:14:30 -0400
Received: by joust (Postfix, from userid 1000)
	id 4D91D4F8AA; Mon, 15 Aug 2005 11:14:29 -0700 (PDT)
Date:	Mon, 15 Aug 2005 11:14:29 -0700
From:	Nishanth Aravamudan <nacc@us.ibm.com>
To:	ralf@linux-mips.org
Cc:	akpm@osdl.org, linux-mips@linux-mips.org
Subject: [-mm PATCH 11/32] mips: fix-up schedule_timeout() usage
Message-ID: <20050815181429.GN2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Return-Path: <nacc@us.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nacc@us.ibm.com
Precedence: bulk
X-list: linux-mips

Description: Use schedule_timeout_interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size. Also,
replace custom timespectojiffies() function with globally availabe
timespec_to_jiffies().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 arch/mips/kernel/irixsig.c |   17 ++---------------
 arch/mips/kernel/sysirix.c |    3 +--
 2 files changed, 3 insertions(+), 17 deletions(-)

diff -urpN 2.6.13-rc5-mm1/arch/mips/kernel/irixsig.c 2.6.13-rc5-mm1-dev/arch/mips/kernel/irixsig.c
--- 2.6.13-rc5-mm1/arch/mips/kernel/irixsig.c	2005-08-07 09:57:44.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/arch/mips/kernel/irixsig.c	2005-08-11 15:43:36.000000000 -0700
@@ -441,18 +441,6 @@ struct irix5_siginfo {
 	} stuff;
 };
 
-static inline unsigned long timespectojiffies(struct timespec *value)
-{
-	unsigned long sec = (unsigned) value->tv_sec;
-	long nsec = value->tv_nsec;
-
-	if (sec > (LONG_MAX / HZ))
-		return LONG_MAX;
-	nsec += 1000000000L / HZ - 1;
-	nsec /= 1000000000L / HZ;
-	return HZ * sec + nsec;
-}
-
 asmlinkage int irix_sigpoll_sys(unsigned long *set, struct irix5_siginfo *info,
 				struct timespec *tp)
 {
@@ -490,14 +478,13 @@ asmlinkage int irix_sigpoll_sys(unsigned
 			error = -EINVAL;
 			goto out;
 		}
-		expire = timespectojiffies(tp)+(tp->tv_sec||tp->tv_nsec);
+		expire = timespec_to_jiffies(tp) + (tp->tv_sec||tp->tv_nsec);
 	}
 
 	while(1) {
 		long tmp = 0;
 
-		current->state = TASK_INTERRUPTIBLE;
-		expire = schedule_timeout(expire);
+		expire = schedule_timeout_interruptible(expire);
 
 		for (i=0; i<=4; i++)
 			tmp |= (current->pending.signal.sig[i] & kset.sig[i]);
diff -urpN 2.6.13-rc5-mm1/arch/mips/kernel/sysirix.c 2.6.13-rc5-mm1-dev/arch/mips/kernel/sysirix.c
--- 2.6.13-rc5-mm1/arch/mips/kernel/sysirix.c	2005-08-07 09:57:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/arch/mips/kernel/sysirix.c	2005-08-11 15:46:57.000000000 -0700
@@ -1035,8 +1029,7 @@ bad:
 
 asmlinkage int irix_sginap(int ticks)
 {
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(ticks);
+	schedule_timeout_interruptible(ticks);
 	return 0;
 }
 
