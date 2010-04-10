Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 08:57:37 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:46800 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491958Ab0DJG5O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 08:57:14 +0200
Received: by pwj3 with SMTP id 3so3553431pwj.36
        for <multiple recipients>; Fri, 09 Apr 2010 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=sUGNdKEpG7sGQVVJ3fXkT300NAgm2L1rK7C72sHBRXk=;
        b=Zs9hRiRuTAVOVfhpEu9bA4RuGQu39n62xoQj4VovOmPNrgeLNQNz8H9/zc4QRVQpKX
         fDq4nk9NgniPGhFJd1m/apMKMz/a1676WVuVOY2tRjOa9flk/fB6CccPOezHqwPO2ilo
         dv5MS8dV19PXs3SYIMXZ+3PI3DN74Iy8Z+LJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tGm6XNJ887GQFjxpdbXxet78vNjQcdio1EpW7VNYwt7whPDnD/mG/TOyjXxme0fBTX
         c29ZQNbu2llR435x2TuVUb5mUDJ+qYT2J2QCgoPlfVJrBycrVLaC9sq/hy+LeArpwbAn
         ybgANJnc22kJEa10eE//ARWbaCwaADWq+UkCI=
Received: by 10.141.91.7 with SMTP id t7mr1329284rvl.83.1270882626592;
        Fri, 09 Apr 2010 23:57:06 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm1642896pzk.8.2010.04.09.23.57.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 23:57:05 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        =?UTF-8?q?Ralf=20R=C3=B6sch?= <roesch.ralf@web.de>,
        linux-mips@linux-mips.org
Subject: [PATCH v3 1/3] MIPS: add a common mips_cyc2ns()
Date:   Sat, 10 Apr 2010 14:49:57 +0800
Message-Id: <789d123bca6b687f82d43b94feb60066c2160228.1270881177.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270881177.git.wuzhangjin@gmail.com>
References: <cover.1270881177.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270881177.git.wuzhangjin@gmail.com>
References: <cover.1270881177.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes:

v2 -> v3:

  o use 32bit instead of 64bit for mult and shift as the 'struct
  clocksource' does, which saves several instructions for the 32bit
  version of mips_cyc2ns().
  o removes the 'easy way' of 128bit arithmatic for it not work with
  some compilers. (feedback from David)

v1 -> v2:

  o change the old mips_sched_clock() to mips_cyc2ns() and modify the
  arguments to support 32bit.
  o add 32bit support: use a smaller shift to avoid the quick overflow
  of 64bit arithmatic and balance the overhead of the 128bit arithmatic
  and the precision lost with the smaller shift.

----------------------

Because the high resolution sched_clock() for r4k has the same overflow
problem and solution mentioned in "MIPS: Octeon: Use non-overflowing
arithmetic in sched_clock".

    "With typical mult and shift values, the calculation for Octeon's
    sched_clock overflows when using 64-bit arithmetic.  Use 128-bit
    calculations instead."

To reduce the duplication, This patch abstracts the solution into an
inline funciton mips_cyc2ns() into arch/mips/include/asm/time.h from
arch/mips/cavium-octeon/csrc-octeon.c.

Two patches for Cavium and R4K will be sent out respectively to use this
common function.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/time.h |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index c7f1bfe..f0ee643 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -96,4 +96,38 @@ static inline void clockevent_set_clock(struct clock_event_device *cd,
 	clockevents_calc_mult_shift(cd, clock, 4);
 }
 
+static inline unsigned long long mips_cyc2ns(u64 cyc, u32 __mult, u32 __shift)
+{
+#ifdef CONFIG_32BIT
+	/*
+	 * To balance the overhead of 128bit-arithematic and the precision
+	 * lost, we choose a smaller shift to avoid the quick overflow as the
+	 * X86 & ARM does. please refer to arch/x86/kernel/tsc.c and
+	 * arch/arm/plat-orion/time.c
+	 */
+	return (cyc * __mult) >> __shift;
+#else /* CONFIG_64BIT */
+	/* 64-bit arithmatic can overflow, so use 128-bit */
+	u64 t1, t2, t3;
+	unsigned long long rv;
+	u64 mult, shift;
+	mult = __mult;
+	shift = __shift;
+
+	asm (
+		"dmultu\t%[cyc],%[mult]\n\t"
+		"nor\t%[t1],$0,%[shift]\n\t"
+		"mfhi\t%[t2]\n\t"
+		"mflo\t%[t3]\n\t"
+		"dsll\t%[t2],%[t2],1\n\t"
+		"dsrlv\t%[rv],%[t3],%[shift]\n\t"
+		"dsllv\t%[t1],%[t2],%[t1]\n\t"
+		"or\t%[rv],%[t1],%[rv]\n\t"
+		: [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3] "=&r" (t3)
+		: [cyc] "r" (cyc), [mult] "r" (mult), [shift] "r" (shift)
+		: "hi", "lo");
+	return rv;
+#endif
+}
+
 #endif /* _ASM_TIME_H */
-- 
1.7.0.1
