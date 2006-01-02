Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jan 2006 12:58:30 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:51429 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133394AbWABM6K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Jan 2006 12:58:10 +0000
Received: from localhost (p6207-ipad27funabasi.chiba.ocn.ne.jp [220.107.197.207])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AD3303953; Mon,  2 Jan 2006 22:00:23 +0900 (JST)
Date:	Mon, 02 Jan 2006 21:59:49 +0900 (JST)
Message-Id: <20060102.215949.41198615.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	dom@mips.com, macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: ieee754[sd]p_neg workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050421.161945.79301612.nemoto@toshiba-tops.co.jp>
References: <16998.20933.14301.397793@arsenal.mips.com>
	<20050420131304.GF5212@linux-mips.org>
	<20050421.161945.79301612.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 21 Apr 2005 16:19:45 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

>>> So file a bug against glibc, but we should fix the emulator so it
>>> correctly imitates the MIPS instruction set...

ralf> As a matter of defensive design I think we should try to follow
ralf> the establish behaviour if nothing more specific is defined
ralf> anywhere.

anemo> OK, I sent a bug reoport to glibc bugzilla. (Bug# 864)

The bug was resolved ... marked as WONTFIX.

glibc developers said math-emu should be fixed.  Please look at:

http://sourceware.org/bugzilla/show_bug.cgi?id=864

for their comments.

So I send a patch for math-emu again.

Description:

It looks glibc's pow() assume an unary '-' operation for any number
(including NaNs) always invert its sign bit (though IEEE754 does not
specify the sign bit for NaNs).  This patch make the kernel math-emu
emulates real MIPS neg.[ds] instruction.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/math-emu/dp_simple.c b/arch/mips/math-emu/dp_simple.c
index 495c1ac..1c555e6 100644
--- a/arch/mips/math-emu/dp_simple.c
+++ b/arch/mips/math-emu/dp_simple.c
@@ -48,16 +48,22 @@ ieee754dp ieee754dp_neg(ieee754dp x)
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
 
diff --git a/arch/mips/math-emu/sp_simple.c b/arch/mips/math-emu/sp_simple.c
index c809830..770f0f4 100644
--- a/arch/mips/math-emu/sp_simple.c
+++ b/arch/mips/math-emu/sp_simple.c
@@ -48,16 +48,22 @@ ieee754sp ieee754sp_neg(ieee754sp x)
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
 
