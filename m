Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 18:13:37 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:42063 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492447Ab0DGQNQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 18:13:16 +0200
Received: by pzk16 with SMTP id 16so1089490pzk.22
        for <multiple recipients>; Wed, 07 Apr 2010 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=z4uyzgdlL9TTCF51xgAUkZwEaOz/3jZRn7rL994gcFo=;
        b=TSRqp/66VwlqaPiRyXN0xCG8DEgJYXtoO3EvPmoUwtUe54mplHBt4nSNDKzHKeDSoH
         Eh4GzmT8sS+xiihHItHkAK7T9CunQMJRTGEsXVPrL9czOIEpsRJ/sewp/ezIdzMPUFPR
         Cy7V2fE5H5G+m7jlpZz5rVaylkSv8Ep8LOsxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xnlOT6SWAfy0kH0yLGvDw4qh3UH5nC8HYFJWAeYmo2pkf76YYUQeTu0YsR+shFlNmd
         PaiUQzXqljGt69fVGART+NVzh3vrOWiNZY2Iwhry/vqUN4EOXa2O9eHEScTCsuTG80bm
         QCt/4NQNXkwmSkSU7b8DPCnLw3FbLN+1MvaYs=
Received: by 10.114.189.14 with SMTP id m14mr8772645waf.12.1270656787212;
        Wed, 07 Apr 2010 09:13:07 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 6sm4027054ywd.8.2010.04.07.09.13.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 09:13:06 -0700 (PDT)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>,
        =?UTF-8?q?Ralf=20R=C3=B6sch?= <roesch.ralf@web.de>
Subject: [PATCH v2 2/3] MIPS: cavium-octeon: rewrite the sched_clock() based on mips_cyc2ns()
Date:   Thu,  8 Apr 2010 00:05:39 +0800
Message-Id: <503ec883993ca4be3a5680bf52091bf0fcf37357.1270655886.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270653461.git.wuzhangjin@gmail.com>
References: <cover.1270653461.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270655886.git.wuzhangjin@gmail.com>
References: <cover.1270655886.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26363
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
