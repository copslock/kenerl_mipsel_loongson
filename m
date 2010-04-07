Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 18:13:13 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:37664 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492436Ab0DGQNK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 18:13:10 +0200
Received: by pwj3 with SMTP id 3so1126871pwj.36
        for <multiple recipients>; Wed, 07 Apr 2010 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=krXE+U+Txk6R9agv/z1OzEWdSMlxtD/P40DwijTNFuQ=;
        b=ObIkbu/p0aEo8BGhX/Ovn2Gv+cvjHFcuEgyI7rFe/6OXEglRhocB9lhURUDihmyHBM
         dOCyjIhxfw2lqHzw5KmR64pRxI0Rmfdf+NAiMu31W7cGw74c5N5sq01BSrgB8e6IB0Rf
         A2wx6nSxtAcO8xYCn58DUowCiOywvl/k2O2hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JvXvteaJR/tkI0/LqsFLnDtqiaMDEjsyQB3BinAnjAqUNSK1cd7v2ByskX8KSVRirU
         6il4havhjEff4ekhYY7zi4fBUFDv1fTpQsIkgAYFga0dqd+gkY4kLo/RxXd3xW/v+tNV
         uXyGllBtHsFbmleuZWxalERRSqkSK2wj4I8g4=
Received: by 10.141.188.37 with SMTP id q37mr7596827rvp.212.1270656781576;
        Wed, 07 Apr 2010 09:13:01 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 6sm4027054ywd.8.2010.04.07.09.12.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 09:13:00 -0700 (PDT)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>,
        =?UTF-8?q?Ralf=20R=C3=B6sch?= <roesch.ralf@web.de>
Subject: [PATCH v2 1/3] MIPS: add a common mips_cyc2ns()
Date:   Thu,  8 Apr 2010 00:05:38 +0800
Message-Id: <9e1889ed5fa23dfaa1ad432ebb4b8f837f6668b4.1270655886.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270653461.git.wuzhangjin@gmail.com>
References: <cover.1270653461.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270655886.git.wuzhangjin@gmail.com>
References: <cover.1270655886.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes:

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
 arch/mips/include/asm/time.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index c7f1bfe..898f0e0 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -96,4 +96,42 @@ static inline void clockevent_set_clock(struct clock_event_device *cd,
 	clockevents_calc_mult_shift(cd, clock, 4);
 }
 
+static inline unsigned long long mips_cyc2ns(u64 cyc, u64 mult, u64 shift)
+{
+#ifdef CONFIG_32BIT
+	/*
+	 * To balance the overhead of 128bit-arithematic and the precision
+	 * lost, we choose a smaller shift to avoid the quick overflow as the
+	 * X86 & ARM does. please refer to arch/x86/kernel/tsc.c and
+	 * arch/arm/plat-orion/time.c
+	 */
+	return (cyc * mult) >> shift;
+#else /* CONFIG_64BIT */
+	/* 64-bit arithmatic can overflow, so use 128-bit.  */
+#if (__GNUC__ < 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ <= 3))
+	u64 t1, t2, t3;
+	unsigned long long rv;
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
+#else	/* GCC > 4.3 do it the easy way.  */
+	unsigned int __attribute__((mode(TI))) t = cyc;
+
+	t = (t * mult) >> shift;
+	return (unsigned long long)t;
+#endif
+#endif /* CONFIG_64BIT */
+}
+
 #endif /* _ASM_TIME_H */
-- 
1.7.0.1
