Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g158cxH01515
	for linux-mips-outgoing; Tue, 5 Feb 2002 00:38:59 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g158ciA01489;
	Tue, 5 Feb 2002 00:38:45 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 5 Feb 2002 08:38:44 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 5F93EB46B; Tue,  5 Feb 2002 17:38:43 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id RAA22086; Tue, 5 Feb 2002 17:38:43 +0900 (JST)
Date: Tue, 05 Feb 2002 17:43:20 +0900 (JST)
Message-Id: <20020205.174320.78702446.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: endless recursive loop in pow()
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <200202040953.g149rrA17976@oss.sgi.com>
References: <200202040953.g149rrA17976@oss.sgi.com>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Tue_Feb__5_17:43:20_2002_271)--"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Tue_Feb__5_17:43:20_2002_271)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I found that pow() of glibc 2.2.4 causes stack overflow on some
testcase with NaN operand.  Try this simple (and dirty) test program
(for little endian).

main()
{
        double x, y, z;
        *(int*)(&x) = 0x00000000;
        *((int*)(&x) + 1) = 0xfff00001;
        *(int*)(&y) = 0x80000000;
        *((int*)(&y) + 1) = 0xcff00000;
        z = pow(x, y);
        printf("%x %x\n", *((int*)&z + 1), *(int*)&z);
        return 0;
}

This program fall into endless recursive call at line 128 in
sysdeps/ieee754/dbl-64/e_pow.c.

128:     return (k==1)?__ieee754_pow(-x,y):-__ieee754_pow(-x,y); /* if y even or odd */


The problem occur if sign-bit of a NaN and negation of the NaN is
same.  I saw this problem only if the neg.d instruction was
interpreted by kernel fp emulation.

The patch below is a fix for kernel fp emulation.  Is this a right
fix?  Or glibc should be fixed?

---
Atsushi Nemoto

----Next_Part(Tue_Feb__5_17:43:20_2002_271)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="neg.patch"

diff -u linux-sgi-cvs/arch/mips/math-emu/dp_simple.c linux.new/arch/mips/math-emu/dp_simple.c
--- linux-sgi-cvs/arch/mips/math-emu/dp_simple.c	Mon Oct 22 10:29:56 2001
+++ linux.new/arch/mips/math-emu/dp_simple.c	Tue Feb  5 17:36:29 2002
@@ -48,16 +48,18 @@
 	CLEARCX;
 	FLUSHXDP;
 
+	/* quick fix up */
+	DPSIGN(x) ^= 1;
+
 	if (xc == IEEE754_CLASS_SNAN) {
+		ieee754dp y = ieee754dp_indef();
 		SETCX(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef(), "neg");
+		DPSIGN(y) = DPSIGN(x);
+		return ieee754dp_nanxcpt(y, "neg");
 	}
 
 	if (ieee754dp_isnan(x))	/* but not infinity */
 		return ieee754dp_nanxcpt(x, "neg", x);
-
-	/* quick fix up */
-	DPSIGN(x) ^= 1;
 	return x;
 }
 
diff -u linux-sgi-cvs/arch/mips/math-emu/sp_simple.c linux.new/arch/mips/math-emu/sp_simple.c
--- linux-sgi-cvs/arch/mips/math-emu/sp_simple.c	Mon Oct 22 10:29:56 2001
+++ linux.new/arch/mips/math-emu/sp_simple.c	Tue Feb  5 17:36:29 2002
@@ -48,16 +48,18 @@
 	CLEARCX;
 	FLUSHXSP;
 
+	/* quick fix up */
+	SPSIGN(x) ^= 1;
+
 	if (xc == IEEE754_CLASS_SNAN) {
+		ieee754sp y = ieee754sp_indef();
 		SETCX(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(ieee754sp_indef(), "neg");
+		SPSIGN(y) = SPSIGN(x);
+		return ieee754sp_nanxcpt(y, "neg");
 	}
 
 	if (ieee754sp_isnan(x))	/* but not infinity */
 		return ieee754sp_nanxcpt(x, "neg", x);
-
-	/* quick fix up */
-	SPSIGN(x) ^= 1;
 	return x;
 }
 

----Next_Part(Tue_Feb__5_17:43:20_2002_271)----
