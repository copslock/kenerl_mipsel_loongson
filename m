Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 13:57:18 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:43998 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225846AbUDMM5O>; Tue, 13 Apr 2004 13:57:14 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 1B6F14794B; Tue, 13 Apr 2004 14:57:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B589C47775; Tue, 13 Apr 2004 14:57:07 +0200 (CEST)
Date: Tue, 13 Apr 2004 14:57:07 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: linux-mips@linux-mips.org, Eric Christopher <echristo@redhat.com>,
	Daniel Jacobowitz <dan@debian.org>
Subject: Re: [PATCH] gcc 3.4 drops "accum" clobber, replace with "hi" intime.c
In-Reply-To: <053c01c420f5$ec230190$8d01010a@prefect>
Message-ID: <Pine.LNX.4.55.0404131451200.15949@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl>
 <20040412231309.GA702@linux-mips.org> <03f301c420e7$d8de2d70$8d01010a@prefect>
 <048e01c420f1$ad4ae3b0$8d01010a@prefect> <1081818125.19719.14.camel@dzur.sfbay.redhat.com>
 <04d501c420f3$6c836a30$8d01010a@prefect> <20040413010732.GA7560@nevyn.them.org>
 <04f501c420f4$5563f620$8d01010a@prefect> <053c01c420f5$ec230190$8d01010a@prefect>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 12 Apr 2004, Bradley D. LaRonde wrote:

> OK, so this patch actually builds, and it sounds like it will do the job,
> since "accum" means "hi and low", "lo" is already clobbered in all cases,
> and either "hi" is the output and doesn't need clobbering (hunks 1, 2, and
> 4), or "hi" is already clobbered (hunk 3).

 There are more places this should be dealt with and I have the following 
preliminary patch for this, but I'm unsure about removal of "accum" being 
completely safe for older compilers.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-mips-gcc3-2
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/time.c linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/time.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/time.c	2004-01-15 03:56:58.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/time.c	2004-02-02 04:38:34.000000000 +0000
@@ -242,7 +242,7 @@ static unsigned long fixed_rate_gettimeo
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (sll32_usecs_per_cycle)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -297,7 +297,7 @@ static unsigned long calibrate_div32_get
 	__asm__("multu  %1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -339,7 +339,7 @@ static unsigned long calibrate_div64_get
 				: "r" (timerhi), "m" (timerlo),
 				  "r" (tmp), "r" (USECS_PER_JIFFY),
 				  "r" (USECS_PER_JIFFY_FRAC)
-				: "hi", "lo", "accum");
+				: "hi", "lo");
 			cached_quotient = quotient;
 		}
 	}
@@ -353,7 +353,7 @@ static unsigned long calibrate_div64_get
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/cpu-probe.c linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/cpu-probe.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/cpu-probe.c	2003-12-11 03:56:36.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/cpu-probe.c	2004-02-02 04:44:30.000000000 +0000
@@ -177,7 +177,7 @@ static inline void mult_sh_align_mod(lon
 		".set	pop"
 		: "=&r" (lv1), "=r" (lw)
 		: "r" (m1), "r" (m2), "r" (s), "I" (0)
-		: "hi", "lo", "accum");
+		: "hi", "lo");
 	/* We have to use single integers for m1 and m2 and a double
 	 * one for p to be sure the mulsidi3 gcc's RTL multiplication
 	 * instruction has the workaround applied.  Older versions of
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/time.c linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/time.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/time.c	2004-01-15 03:57:03.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/time.c	2004-02-02 04:39:21.000000000 +0000
@@ -242,7 +242,7 @@ static unsigned long fixed_rate_gettimeo
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (sll32_usecs_per_cycle)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -297,7 +297,7 @@ static unsigned long calibrate_div32_get
 	__asm__("multu  %1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -339,7 +339,7 @@ static unsigned long calibrate_div64_get
 				: "r" (timerhi), "m" (timerlo),
 				  "r" (tmp), "r" (USECS_PER_JIFFY),
 				  "r" (USECS_PER_JIFFY_FRAC)
-				: "hi", "lo", "accum");
+				: "hi", "lo");
 			cached_quotient = quotient;
 		}
 	}
@@ -353,7 +353,7 @@ static unsigned long calibrate_div64_get
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
