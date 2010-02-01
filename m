Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 12:19:29 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:40335 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492078Ab0BALTZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 12:19:25 +0100
Received: by pxi11 with SMTP id 11so4007532pxi.22
        for <multiple recipients>; Mon, 01 Feb 2010 03:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=t7okXqjZNkmvJrjNBkLmk7wO3rQO1Zp6jlZQvNd/cBQ=;
        b=cv5B5RQGxlMhNUOP0oa49ULuHAc4lKqVrkRkc2krTRK/UvDF6yiHwHOeIFVW1A4/Nj
         D+cy/SikJIML7QGX+yeSFy5zhftnyog4Qs2hLKI5HLLKXpP0nZPXB3njdS7jFgEoZETc
         OuDZIwHXp5kx1gdmJaAKJD0v6x1FL/qo2jm9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kaTbFBWIvwub4beQVwZQF+D7+/1aWpEaILs4NBWJ2c5OmVYgqavhxL5pSZlIMzHj3r
         BLrtwS7npklGrGMM8mK4QzdxgmBxHi4dQC3rUm8edwIsSgb8z/sIPMDRCXdWsj1De5j9
         0FsjGnn9Vrp3IYpZ/hUW5zDtkeWXRk8t9kG+A=
Received: by 10.142.2.9 with SMTP id 9mr2964481wfb.290.1265023157082;
        Mon, 01 Feb 2010 03:19:17 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm561769pzk.10.2010.02.01.03.19.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 03:19:16 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/3] MIPS: add a common mips_sched_clock()
Date:   Mon,  1 Feb 2010 19:13:10 +0800
Message-Id: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Because the high resolution sched_clock() for r4k has the same overflow
problem and solution mentioned in "MIPS: Octeon: Use non-overflowing
arithmetic in sched_clock".

    "With typical mult and shift values, the calculation for Octeon's
    sched_clock overflows when using 64-bit arithmetic.  Use 128-bit
    calculations instead."

To reduce the duplication, This patch abstracts the solution into an
inline funciton mips_sched_clock() into arch/mips/include/asm/time.h
from arch/mips/cavium-octeon/csrc-octeon.c.

Two patches for Cavium and R4K will be sent out respectively to use this
common function.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/time.h |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index c7f1bfe..f7bd5ce 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -96,4 +96,34 @@ static inline void clockevent_set_clock(struct clock_event_device *cd,
 	clockevents_calc_mult_shift(cd, clock, 4);
 }
 
+static inline unsigned long long mips_sched_clock(struct clocksource *cs, u64 cnt)
+{
+	/* 64-bit arithmatic can overflow, so use 128-bit.  */
+#if (__GNUC__ < 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ <= 3))
+	u64 t1, t2, t3;
+	unsigned long long rv;
+	u64 mult = cs->mult;
+	u64 shift = cs->shift;
+
+	asm (
+		"dmultu\t%[cnt],%[mult]\n\t"
+		"nor\t%[t1],$0,%[shift]\n\t"
+		"mfhi\t%[t2]\n\t"
+		"mflo\t%[t3]\n\t"
+		"dsll\t%[t2],%[t2],1\n\t"
+		"dsrlv\t%[rv],%[t3],%[shift]\n\t"
+		"dsllv\t%[t1],%[t2],%[t1]\n\t"
+		"or\t%[rv],%[t1],%[rv]\n\t"
+		: [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3] "=&r" (t3)
+		: [cnt] "r" (cnt), [mult] "r" (mult), [shift] "r" (shift)
+		: "hi", "lo");
+	return rv;
+#else	/* GCC > 4.3 do it the easy way.  */
+	unsigned int __attribute__((mode(TI))) t = cnt;
+
+	t = (t * cs->mult) >> cs->shift;
+	return (unsigned long long)t;
+#endif
+}
+
 #endif /* _ASM_TIME_H */
-- 
1.6.6
