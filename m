Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5NDdnP16436
	for linux-mips-outgoing; Sat, 23 Jun 2001 06:39:49 -0700
Received: from delta.ds2.pg.gda.pl (root@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5NDdlV16427
	for <linux-mips@oss.sgi.com>; Sat, 23 Jun 2001 06:39:47 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA25294;
	Fri, 22 Jun 2001 20:21:30 +0200 (MET DST)
Date: Fri, 22 Jun 2001 20:21:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Bug in memmove
In-Reply-To: <3B1E2BF7.5C0CADB8@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010622200059.18677C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Jun 2001, Gleb O. Raiko wrote:

> It seems there is a bug in our memmove routine. The condition is rare
> though, for example, memmove copies incorrectly, if src=5, dst=4, len=9.
[...]
> Two questions here. First, do we have a pattern that satisfies the
> condition, i.e. is the bug showstopper? My guess, it's not. Second, does
> somebody have ideas how to fix the bug? Well, I have, but want to hear
> somebody else.

 Here is a quick fix I developed after reading your report.  It fixes the
case you described.  Now memcpy() is invoked only if there is no overlap
at all -- the approach is taken from the Alpha port. 

 The copy loop begs for optimization (the original memmove() bits do as
well), but at least it works correctly.  The patch applies cleanly to
2.4.5 as of today. 

 Ralf, I think it should get applied unless someone cooks up a better
solution, i.e. optimizes it.  I'll optimize it myself, eventually, if no
one else does, but don't hold your breath.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.0-test12-20010110-memmove-1
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/lib/memcpy.S linux-mips-2.4.0-test12-20010110/arch/mips/lib/memcpy.S
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/lib/memcpy.S	Wed Dec  6 05:27:02 2000
+++ linux-mips-2.4.0-test12-20010110/arch/mips/lib/memcpy.S	Sun Jun 10 17:50:55 2001
@@ -402,16 +402,20 @@ u_end_bytes:
 
 	.align	5
 LEAF(memmove)
-	sltu	t0, a0, a1			# dst < src -> memcpy
-	bnez	t0, memcpy
-	 addu	v0, a0, a2
-	sltu	t0, v0, a1			# dst + len < src -> non-
-	bnez	t0, __memcpy			# overlapping, can use memcpy
+	addu	t0, a0, a2
+	sltu	t0, a1, t0			# dst + len <= src -> memcpy
+	addu	t1, a1, a2
+	sltu	t1, a0, t1			# dst >= src + len -> memcpy
+	and	t0, t1
+	beqz	t0, __memcpy
 	 move	v0, a0				/* return value */
 	beqz	a2, r_out
 	END(memmove)
 
 LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
+	sltu	t0, a1, a0
+	beqz	t0, r_end_bytes_up		# src >= dst
+	 nop
 	addu	a0, a2				# dst = dst + len
 	addu	a1, a2				# src = src + len
 
@@ -563,6 +567,17 @@ r_end_bytes:
 	 subu	a0, a0, 0x1
 
 r_out:
+	jr	ra
+	 move	a2, zero
+
+r_end_bytes_up:
+	lb	t0, (a1)
+	subu	a2, a2, 0x1
+	sb	t0, (a0)
+	addu	a1, a1, 0x1
+	bnez	a2, r_end_bytes_up
+	 addu	a0, a0, 0x1
+
 	jr	ra
 	 move	a2, zero
 
