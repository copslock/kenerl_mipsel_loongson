Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 18:47:23 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:62159 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225346AbSLRSrW>; Wed, 18 Dec 2002 18:47:22 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA12179;
	Wed, 18 Dec 2002 19:47:32 +0100 (MET)
Date: Wed, 18 Dec 2002 19:47:31 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
In-Reply-To: <m2vg1rnrkg.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021218194246.5977G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 18 Dec 2002, Juan Quintela wrote:

> maciej> Is it needed?  The part that returns .mx should be optimized away by the
> maciej> compiler automagically if unused. 
> 
> Idea was to make things compile without warnings, that way when you
> change anything, you search for warnings :(

 The idea is fine, sure.

> With the changes that I sent, I have put the warnings levels down to
> (for IP22) to:
>      - 7 C warnings
>      - 2 Asm warnings

 A few warnings are unavoidable -- e.g. there is no way to shut up gas
complaining about macros expanding into multiple instructions in branch
delay slots.  Too bad.

 How about this patch? -- it seems to work here (gcc 2.95.4).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021212-setcx-0
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/math-emu/ieee754int.h linux-mips-2.4.20-pre6-20021212/arch/mips/math-emu/ieee754int.h
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/math-emu/ieee754int.h	2002-12-16 17:17:55.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/math-emu/ieee754int.h	2002-12-18 18:31:51.000000000 +0000
@@ -58,10 +58,10 @@
 #define CLPAIR(x,y)	((x)*6+(y))
 
 #define CLEARCX	\
-  (ieee754_csr.cx = 0)
+	(ieee754_csr.cx = 0)
 
 #define SETCX(x) \
-  (ieee754_csr.cx |= (x),ieee754_csr.sx |= (x),ieee754_csr.mx & (x))
+	({ieee754_csr.cx |= (x); ieee754_csr.sx |= (x); ieee754_csr.mx & (x);})
 
 #define TSTX()	\
 	(ieee754_csr.cx & ieee754_csr.mx)
