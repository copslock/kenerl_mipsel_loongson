Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 12:55:53 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:37109 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225453AbTISLzv>; Fri, 19 Sep 2003 12:55:51 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA10155;
	Fri, 19 Sep 2003 13:55:46 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 19 Sep 2003 13:55:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: linux-mips@linux-mips.org
Subject: Re: mips64 cpu-probe.c compile failure
In-Reply-To: <20030918.232202.07646481.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.GSO.3.96.1030919132308.9134B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Sep 2003, Atsushi Nemoto wrote:

> macro>  I wanted to avoid that as the resulting code would be ugly.  I
> macro> guess there is no other choice, although I think that's a bug
> macro> in gcc.
> 
> I have no idea that is a gcc bug, but I think align_mod() inline
> function is not so beautiful because it can not be compiled anyway if
> non-constant value was passed.

 Well, the asm statement requires immediates, so if macros are used
variables won't work anyway, but the the code will look more obscurely.

> macro>  Can you quote the exact command line used for building the
> macro> file?
> 
> mips64el-linux-gcc -D__KERNEL__ -I/home/anemo/work/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I /home/anemo/work/linux/include/asm/gcc -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe  -march=r4600   -nostdinc -iwithprefix include -DKBUILD_BASENAME=cpu_probe  -c -o cpu-probe.o cpu-probe.c
> 
> I also tried with -finline-limit=100000 but no luck.

 It looks like gcc insists on forcing the constants into registers.  The
following patch should work for gcc 3.x.  A few warnings will still be
emitted, but the code will get build properly.

 I'm applying the change to the CVS as it's good anyway.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.22-20030916-mips-bugs-gcc3-0
diff -up --recursive --new-file linux-mips-2.4.22-20030916.macro/arch/mips64/kernel/cpu-probe.c linux-mips-2.4.22-20030916/arch/mips64/kernel/cpu-probe.c
--- linux-mips-2.4.22-20030916.macro/arch/mips64/kernel/cpu-probe.c	2003-09-12 01:18:01.000000000 +0000
+++ linux-mips-2.4.22-20030916/arch/mips64/kernel/cpu-probe.c	2003-09-18 22:14:19.000000000 +0000
@@ -113,7 +113,7 @@ static inline void check_wait(void)
 	}
 }
 
-static inline void align_mod(int align, int mod)
+static inline void align_mod(const int align, const int mod)
 {
 	asm volatile(
 		".set	push\n\t"
@@ -124,11 +124,11 @@ static inline void align_mod(int align, 
 		".endr\n\t"
 		".set	pop"
 		:
-		: "i" (align), "i" (mod));
+		: "n" (align), "n" (mod));
 }
 
 static inline void mult_sh_align_mod(long *v1, long *v2, long *w,
-				     int align, int mod)
+				     const int align, const int mod)
 {
 	unsigned long flags;
 	int m1, m2;
