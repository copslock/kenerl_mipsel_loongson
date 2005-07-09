Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2005 01:11:52 +0100 (BST)
Received: from e2.ny.us.ibm.com ([IPv6:::ffff:32.97.182.142]:38036 "EHLO
	e2.ny.us.ibm.com") by linux-mips.org with ESMTP id <S8226366AbVGIAL0>;
	Sat, 9 Jul 2005 01:11:26 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j690BnHp013337;
	Fri, 8 Jul 2005 20:11:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j690BnCf223990;
	Fri, 8 Jul 2005 20:11:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j690Bce1012258;
	Fri, 8 Jul 2005 20:11:38 -0400
Received: from joust (joust.beaverton.ibm.com [9.47.17.68])
	by d01av03.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j690BceE012080;
	Fri, 8 Jul 2005 20:11:38 -0400
Received: by joust (Postfix, from userid 1000)
	id 28D554F916; Fri,  8 Jul 2005 17:11:27 -0700 (PDT)
Date:	Fri, 8 Jul 2005 17:11:27 -0700
From:	Nishanth Aravamudan <nacc@us.ibm.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org,
	Kernel-Janitors <kernel-janitors@lists.osdl.org>
Subject: [PATCH 7/14] mips: replace timespectojiffies() with timespec_to_jiffies()
Message-ID: <20050709001127.GM2596@us.ibm.com>
References: <20050709000324.GD2596@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709000324.GD2596@us.ibm.com>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Return-Path: <nacc@us.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nacc@us.ibm.com
Precedence: bulk
X-list: linux-mips

From: Nishanth Aravamudan <nacc@us.ibm.com>

Description: Replace custom timespectojiffies() function with generic
standard one.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 irixsig.c |   14 +-------------
 1 files changed, 1 insertion(+), 13 deletions(-)

diff -urp 2.6.13-rc2-kj/arch/mips/kernel/irixsig.c 2.6.13-rc2-kj-dev/arch/mips/kernel/irixsig.c
--- 2.6.13-rc2-kj/arch/mips/kernel/irixsig.c	2005-07-06 07:57:02.000000000 -0700
+++ 2.6.13-rc2-kj-dev/arch/mips/kernel/irixsig.c	2005-07-06 13:30:34.000000000 -0700
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
@@ -490,7 +478,7 @@ asmlinkage int irix_sigpoll_sys(unsigned
 			error = -EINVAL;
 			goto out;
 		}
-		expire = timespectojiffies(tp)+(tp->tv_sec||tp->tv_nsec);
+		expire = timespec_to_jiffies(tp)+(tp->tv_sec||tp->tv_nsec);
 	}
 
 	while(1) {
