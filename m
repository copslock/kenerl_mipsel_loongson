Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9GHG3j03336
	for linux-mips-outgoing; Tue, 16 Oct 2001 10:16:03 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9GHFmD03330
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 10:15:49 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA29556;
	Tue, 16 Oct 2001 19:06:41 +0200 (MET DST)
Date: Tue, 16 Oct 2001 19:06:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4.9: Bad code in xchg_u32()
Message-ID: <Pine.GSO.3.96.1011016161735.19676E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

 There is a problem with the xchg_u32() function when compiled for
CPU_HAS_LLSC.  The constraints are broken and do not prevent gcc from
expanding ll and sc into multiple instructions, clobbering $at
additionally.  See a dump below (from free_dma() in kernel/dma.o): 

 108:   00602021        move    a0,v1
 10c:   3c030000        lui     v1,0x0
                        10c: R_MIPS_HI16        .data
 110:   00621821        addu    v1,v1,v0
 114:   c0630004        ll      v1,4(v1)
                        114: R_MIPS_LO16        .data
 118:   00800821        move    at,a0
 11c:   3c010000        lui     at,0x0
                        11c: R_MIPS_HI16        .data
 120:   00220821        addu    at,at,v0
 124:   e0210004        sc      at,4(at)
                        124: R_MIPS_LO16        .data
 128:   5020fffb        beqzl   at,118 <free_dma+0x40>
 12c:   3c030000        lui     v1,0x0
                        12c: R_MIPS_HI16        .data
 130:   00621821        addu    v1,v1,v0
 134:   c0630004        ll      v1,4(v1)
                        134: R_MIPS_LO16        .data

 Following is a fix that works for me.  The code now looks:

 104:   3c010000        lui     at,0x0
                        104: R_MIPS_HI16        .data
 108:   24210004        addiu   at,at,4
                        108: R_MIPS_LO16        .data
 10c:   00221021        addu    v0,at,v0
 110:   00001821        move    v1,zero
 114:   c0460000        ll      a2,0(v0)
 118:   00602021        move    a0,v1
 11c:   e0440000        sc      a0,0(v0)
 120:   5080fffd        beqzl   a0,118 <free_dma+0x40>
 124:   c0460000        ll      a2,0(v0)

Excellent -- it got shortened as well. 

 Unfortunately, gcc 2.95.3 doesn't want to accept a "=R" output constraint
here so I had to use "=m".  It looks like a bug in gcc.  Until it is fixed
the "R" input constraint here is sufficient for gcc to know it has m
already available in one of registers.  I added ".set nomacro" to make
sure the second ll fits in the BDS as well.

 Ralf, I think this should get applied.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.9-20011009-xchg-1
diff -up --recursive --new-file linux-mips-2.4.9-20011009.macro/include/asm-mips/system.h linux-mips-2.4.9-20011009/include/asm-mips/system.h
--- linux-mips-2.4.9-20011009.macro/include/asm-mips/system.h	Sun Oct  7 04:26:15 2001
+++ linux-mips-2.4.9-20011009/include/asm-mips/system.h	Tue Oct 16 01:11:27 2001
@@ -234,18 +234,17 @@ extern __inline__ unsigned long xchg_u32
 	unsigned long dummy;
 
 	__asm__ __volatile__(
-		".set\tnoreorder\t\t\t# xchg_u32\n\t"
-		".set\tnoat\n\t"
+		".set\tpush\t\t\t\t# xchg_u32\n\t"
+		".set\tnoreorder\n\t"
+		".set\tnomacro\n\t"
 		"ll\t%0, %3\n"
-		"1:\tmove\t$1, %2\n\t"
-		"sc\t$1, %1\n\t"
-		"beqzl\t$1, 1b\n\t"
+		"1:\tmove\t%2, %z4\n\t"
+		"sc\t%2, %1\n\t"
+		"beqzl\t%2, 1b\n\t"
 		" ll\t%0, %3\n\t"
-		".set\tat\n\t"
-		".set\treorder"
-		: "=r" (val), "=o" (*m), "=r" (dummy)
-		: "o" (*m), "2" (val)
-		: "memory");
+		".set\tpop"
+		: "=&r" (val), "=m" (*m), "=&r" (dummy)
+		: "R" (*m), "Jr" (val));
 
 	return val;
 #else
