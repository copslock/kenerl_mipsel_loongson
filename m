Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 08:58:02 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:64099 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491978Ab0DJG5Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 08:57:25 +0200
Received: by mail-pv0-f177.google.com with SMTP id 30so2193336pvc.36
        for <multiple recipients>; Fri, 09 Apr 2010 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=z4uyzgdlL9TTCF51xgAUkZwEaOz/3jZRn7rL994gcFo=;
        b=Np3sLDCdrVdvIPP9Q4eXGuGJJuz8PQenU0Kbmlagydvpb0rnk4e4d3zvzdBGtn0WN5
         RAmonOSokC/8TfIz/WjxpW8veNMDnQEPqPSug5JuOLG4unfRcT4ggoLhBFJRpLkbn2rq
         vdkf5KT1py9qMI5ktp5jB1DBD6h4pZcnOnbk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VANYhr8CP1qxRHGHKEaLurdVknleCmXw3kQS+xb8M+RrhaFZngUB5nshaLnHH6tG69
         t9Rj/UEp9rHYO2Y/j60/o+HuU2VevuJfD6Sq7SFmXJhyGqJ+MJZtBxmWSv3KkSSGIUon
         dUFN9Ej9lQKs2yJNRoMUD5M4gNW208weLlrow=
Received: by 10.140.179.8 with SMTP id b8mr1460572rvf.99.1270882644888;
        Fri, 09 Apr 2010 23:57:24 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm1642896pzk.8.2010.04.09.23.57.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 23:57:24 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        =?UTF-8?q?Ralf=20R=C3=B6sch?= <roesch.ralf@web.de>,
        linux-mips@linux-mips.org
Subject: [PATCH v3 2/3] MIPS: cavium-octeon: rewrite the sched_clock() based on mips_cyc2ns()
Date:   Sat, 10 Apr 2010 14:49:58 +0800
Message-Id: <4e8166375d6fb067115961f1dd28993c5a411d99.1270881177.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270881177.git.wuzhangjin@gmail.com>
References: <cover.1270881177.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270881177.git.wuzhangjin@gmail.com>
References: <cover.1270881177.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from v1:

  o use the new interface mips_cyc2ns() intead of the old
  mips_sched_clock().

The commit "MIPS: add a common mips_cyc2ns()" have abstracted the
solution of the 64bit calculation's overflow problem into a common
mips_cyc2ns() function in arch/mips/include/asm/time.h, This patch just
rewrites the sched_clock() for cavium-octeon on it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 0bf4bbe..bca0004 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -52,34 +52,9 @@ static struct clocksource clocksource_mips = {
 
 unsigned long long notrace sched_clock(void)
 {
-	/* 64-bit arithmatic can overflow, so use 128-bit.  */
-#if (__GNUC__ < 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ <= 3))
-	u64 t1, t2, t3;
-	unsigned long long rv;
-	u64 mult = clocksource_mips.mult;
-	u64 shift = clocksource_mips.shift;
-	u64 cnt = read_c0_cvmcount();
+	u64 cyc = read_c0_cvmcount();
 
-	asm (
-		"dmultu\t%[cnt],%[mult]\n\t"
-		"nor\t%[t1],$0,%[shift]\n\t"
-		"mfhi\t%[t2]\n\t"
-		"mflo\t%[t3]\n\t"
-		"dsll\t%[t2],%[t2],1\n\t"
-		"dsrlv\t%[rv],%[t3],%[shift]\n\t"
-		"dsllv\t%[t1],%[t2],%[t1]\n\t"
-		"or\t%[rv],%[t1],%[rv]\n\t"
-		: [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3] "=&r" (t3)
-		: [cnt] "r" (cnt), [mult] "r" (mult), [shift] "r" (shift)
-		: "hi", "lo");
-	return rv;
-#else
-	/* GCC > 4.3 do it the easy way.  */
-	unsigned int __attribute__((mode(TI))) t;
-	t = read_c0_cvmcount();
-	t = t * clocksource_mips.mult;
-	return (unsigned long long)(t >> clocksource_mips.shift);
-#endif
+	return mips_cyc2ns(cyc, clocksource_mips.mult, clocksource_mips.shift);
 }
 
 void __init plat_time_init(void)
-- 
1.7.0.1
