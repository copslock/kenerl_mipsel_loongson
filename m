Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAU2cWR21660
	for linux-mips-outgoing; Thu, 29 Nov 2001 18:38:32 -0800
Received: from deneb.localdomain (ga-cmng-u1-c3b-97.cmngga.adelphia.net [24.53.98.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAU2cQo21657
	for <linux-mips@oss.sgi.com>; Thu, 29 Nov 2001 18:38:26 -0800
Received: (from msalter@localhost)
	by deneb.localdomain (8.11.6/8.11.6) id fAU1cOA31059;
	Thu, 29 Nov 2001 20:38:24 -0500
Date: Thu, 29 Nov 2001 20:38:24 -0500
Message-Id: <200111300138.fAU1cOA31059@deneb.localdomain>
X-Authentication-Warning: deneb.localdomain: msalter set sender to msalter@redhat.com using -f
From: Mark Salter <msalter@redhat.com>
To: linux-mips@oss.sgi.com
Subject: math emulator patch
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


The following patch fixes the emulation of cvt.w.s and cvt.w.d for
values of -2147483648.

--Mark


Index: sp_tint.c
===================================================================
RCS file: /cvs/linux/arch/mips/math-emu/sp_tint.c,v
retrieving revision 1.4
diff -u -p -5 -c -r1.4 sp_tint.c
cvs server: conflicting specifications of output style
*** sp_tint.c	2001/10/09 23:56:19	1.4
--- sp_tint.c	2001/11/29 19:14:58
*************** int ieee754sp_tint(ieee754sp x)
*** 48,57 ****
--- 48,60 ----
  	case IEEE754_CLASS_DNORM:
  	case IEEE754_CLASS_NORM:
  		break;
  	}
  	if (xe >= 31) {
+ 		/* look for valid corner case */
+ 		if (xe == 31 && xs && xm == SP_HIDDEN_BIT)
+ 			return -2147483648;
  		/* Set invalid. We will only use overflow for floating
  		   point overflow */
  		SETCX(IEEE754_INVALID_OPERATION);
  		return ieee754si_xcpt(ieee754si_indef(), "sp_tint", x);
  	}
Index: dp_tint.c
===================================================================
RCS file: /cvs/linux/arch/mips/math-emu/dp_tint.c,v
retrieving revision 1.4
diff -u -p -5 -c -r1.4 dp_tint.c
cvs server: conflicting specifications of output style
*** dp_tint.c	2001/10/09 23:56:18	1.4
--- dp_tint.c	2001/11/29 19:18:02
*************** int ieee754dp_tint(ieee754dp x)
*** 48,57 ****
--- 48,60 ----
  	case IEEE754_CLASS_DNORM:
  	case IEEE754_CLASS_NORM:
  		break;
  	}
  	if (xe >= 31) {
+ 		/* look for valid corner case */
+ 		if (xe == 31 && xs && xm == DP_HIDDEN_BIT)
+ 			return -2147483648;
  		/* Set invalid. We will only use overflow for floating
  		   point overflow */
  		SETCX(IEEE754_INVALID_OPERATION);
  		return ieee754si_xcpt(ieee754si_indef(), "dp_tint", x);
  	}
