Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 12:19:52 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:58984 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492107Ab0BALT1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 12:19:27 +0100
Received: by pxi11 with SMTP id 11so4007578pxi.22
        for <multiple recipients>; Mon, 01 Feb 2010 03:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Taw54d6HxZCWf19QELob/RZAiSAVVMVmABgwKW8FVEE=;
        b=lE4WkeSwsMfbBF6GO64ZQIAoahNJgJYTODhsaV68Mn3KP54UrrJ6s9c2rgbnHMtr0p
         P3pQHzRYtF8UpYu4ownl9KlUctTN8zFc7Pxy7WyJgHxpK18DXZ92vTP0WqPtaSHOHnza
         OS00W6tACe2e1SwKv6p6q32ioFh61hORCDhxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e1h4ICdA4/fY9xeb08+ONW/v3woj3HBve0ITTPeSYWo7f9JbtZ8jGNJOx1+GZqR+vT
         0PK0GR7PD9AMK8mNMIv4kINVGy9EyIocXHwRkiDrfczM3SzihyyINuHBDv0ccEZhEemR
         7a5ColKLW+mhhQemKxtJgVAmGjzGZhUziZ5AQ=
Received: by 10.142.118.2 with SMTP id q2mr2997045wfc.292.1265023160498;
        Mon, 01 Feb 2010 03:19:20 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm561769pzk.10.2010.02.01.03.19.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 03:19:19 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/3] MIPS: cavium-octeon: rewrite the sched_clock() based on mips_sched_clock()
Date:   Mon,  1 Feb 2010 19:13:11 +0800
Message-Id: <d1cd5f2c5a8d0cc70ed943a204d83e08f95225f7.1265022593.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
References: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
In-Reply-To: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
References: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The commit "MIPS: add a common mips_sched_clock()" have abstracted the
solution of the 64bit calculation's overflow problem into a common
mips_sched_clock() function in arch/mips/include/asm/time.h, This patch
just rewrites the sched_clock() for cavium-octeon on it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c |   27 +--------------------------
 1 files changed, 1 insertions(+), 26 deletions(-)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 0bf4bbe..53b1c32 100644
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
 	u64 cnt = read_c0_cvmcount();
 
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
+	return mips_sched_clock(&clocksource_mips, cnt);
 }
 
 void __init plat_time_init(void)
-- 
1.6.6
