Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1EB3oU08240
	for linux-mips-outgoing; Thu, 14 Feb 2002 03:03:50 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1EB3f908237;
	Thu, 14 Feb 2002 03:03:42 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 14 Feb 2002 10:03:41 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id D1E92B479; Thu, 14 Feb 2002 19:03:38 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id TAA49061; Thu, 14 Feb 2002 19:03:38 +0900 (JST)
Date: Thu, 14 Feb 2002 19:08:07 +0900 (JST)
Message-Id: <20020214.190807.28780825.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: cvt.s.d emulation fix
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I found two small problem on cvt.s.d emulation.

1. Converting a denormalized number does not raise Inexact exception.

2. Any denormalized double precision numbers are converted to zero
   regardless rounding mode.  If rounding mode was "up", a positive
   denormalized double precision number should be converted to minimal
   (denormalized) single precision number.

Here is a patch.

--- linux-sgi-cvs/arch/mips/math-emu/sp_fdp.c	Mon Oct 22 10:29:56 2001
+++ linux.new/arch/mips/math-emu/sp_fdp.c	Thu Feb 14 18:56:06 2002
@@ -55,6 +55,10 @@
 	case IEEE754_CLASS_DNORM:
 		/* cant possibly be sp representable */
 		SETCX(IEEE754_UNDERFLOW);
+		SETCX(IEEE754_INEXACT);
+		if ((ieee754_csr.rm == IEEE754_RU && !xs) ||
+		    (ieee754_csr.rm == IEEE754_RD && xs))
+			return ieee754sp_xcpt(ieee754sp_mind(xs), "fdp", x);
 		return ieee754sp_xcpt(ieee754sp_zero(xs), "fdp", x);
 	case IEEE754_CLASS_NORM:
 		break;
---
Atsushi Nemoto
