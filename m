Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 09:40:45 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:55300
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8226045AbVDTIk3>; Wed, 20 Apr 2005 09:40:29 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 20 Apr 2005 08:40:26 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id A03781F300;
	Wed, 20 Apr 2005 17:40:24 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9475B1F22F;
	Wed, 20 Apr 2005 17:40:24 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j3K8eNoj004741;
	Wed, 20 Apr 2005 17:40:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 20 Apr 2005 17:40:23 +0900 (JST)
Message-Id: <20050420.174023.113589096.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: ieee754[sd]p_neg workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I have a long standing patch for FPU emulator to fix a segmentation
fault in pow() library function.

Here is a test program to reproduce it.

main()
{
	union {
		double d;
		struct {
#ifdef __MIPSEB
			unsigned int high, low;
#else
			unsigned int low, high;
#endif
		} i;
	} x, y, z;
        x.i.low = 0x00000000;
        x.i.high = 0xfff00001;
        y.i.low = 0x80000000;
        y.i.high = 0xcff00000;
        z.d = pow(x.d, y.d);
        printf("%x %x\n", z.i.high, z.i.low);
        return 0;
}


If you run this program, you will get segmentation fault (unless your
FPU does not raise Unimplemented exception for NaN operands).  The
segmentation fault is caused by endless recursion in __ieee754_pow().

It looks glibc's pow() assume unary '-' operation for any number
(including NaN) always invert its sign bit.

Here is a revised (just added a few comments) patch.  Please review.
Thank you.

diff -u linux-mips/arch/mips/math-emu/dp_simple.c linux/arch/mips/math-emu/dp_simple.c
--- linux-mips/arch/mips/math-emu/dp_simple.c	2005-01-31 11:05:18.000000000 +0900
+++ linux/arch/mips/math-emu/dp_simple.c	2005-04-20 17:02:02.613112541 +0900
@@ -48,16 +48,22 @@
 	CLEARCX;
 	FLUSHXDP;
 
+	/*
+	 * Invert the sign ALWAYS to prevent an endless recursion on
+	 * pow() in libc.
+	 */
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
 
diff -u linux-mips/arch/mips/math-emu/sp_simple.c linux/arch/mips/math-emu/sp_simple.c
--- linux-mips/arch/mips/math-emu/sp_simple.c	2005-01-31 11:05:18.000000000 +0900
+++ linux/arch/mips/math-emu/sp_simple.c	2005-04-20 17:02:13.678391113 +0900
@@ -48,16 +48,22 @@
 	CLEARCX;
 	FLUSHXSP;
 
+	/*
+	 * Invert the sign ALWAYS to prevent an endless recursion on
+	 * pow() in libc.
+	 */
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
 

---
Atsushi Nemoto
