Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fANFssg31766
	for linux-mips-outgoing; Fri, 23 Nov 2001 07:54:54 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fANFsgo31720
	for <linux-mips@oss.sgi.com>; Fri, 23 Nov 2001 07:54:42 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA19112;
	Fri, 23 Nov 2001 06:54:34 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA20534;
	Fri, 23 Nov 2001 06:54:33 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fANEsVA26971;
	Fri, 23 Nov 2001 15:54:33 +0100 (MET)
Message-ID: <3BFE6327.986D490C@mips.com>
Date: Fri, 23 Nov 2001 15:54:31 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: FPU test on RedHat7.1
References: <3BFD1BA7.C4490465@mips.com> <20011122103930.A2007@lucon.org>
Content-Type: multipart/mixed;
 boundary="------------B9EB53B4C32624550BB77E38"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------B9EB53B4C32624550BB77E38
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The file sysdeps/ieee754/dbl-64/e_remainder.c seems to have changed since
glibc-2.2.2.
I have attached the glibc-2.2.2 remainder file, which seems to work
better.

/Carsten

"H . J . Lu" wrote:

> On Thu, Nov 22, 2001 at 04:37:11PM +0100, Carsten Langgaard wrote:
> > The attached tests fails on my RedHat7.1 system, but works fine on my
> > old HardHat5.1.
> > Anyone got any idea.
> >
> > compile:
> > g++ -o fpu_test fpu_test.cc
> >
>
> Many FPU related tests in the current glibc from CVS failed on MIPS. I
> am planning to look into them. But I need to find time and docs on MIPS
> FPU.
>
> H.J.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------B9EB53B4C32624550BB77E38
Content-Type: text/plain; charset=iso-8859-15;
 name="e_remainder.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e_remainder.c"

/* @(#)e_remainder.c 5.1 93/09/24 */
/*
 * ====================================================
 * Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
 *
 * Developed at SunPro, a Sun Microsystems, Inc. business.
 * Permission to use, copy, modify, and distribute this
 * software is freely granted, provided that this notice 
 * is preserved.
 * ====================================================
 */

#if defined(LIBM_SCCS) && !defined(lint)
static char rcsid[] = "$NetBSD: e_remainder.c,v 1.8 1995/05/10 20:46:05 jtc Exp $";
#endif

/* __ieee754_remainder(x,p)
 * Return :                  
 * 	returns  x REM p  =  x - [x/p]*p as if in infinite 
 * 	precise arithmetic, where [x/p] is the (infinite bit) 
 *	integer nearest x/p (in half way case choose the even one).
 * Method : 
 *	Based on fmod() return x-[x/p]chopped*p exactlp.
 */

#include "math.h"
#include "math_private.h"

#ifdef __STDC__
static const double zero = 0.0;
#else
static double zero = 0.0;
#endif


#ifdef __STDC__
	double __ieee754_remainder(double x, double p)
#else
	double __ieee754_remainder(x,p)
	double x,p;
#endif
{
	int32_t hx,hp;
	u_int32_t sx,lx,lp;
	double p_half;

	EXTRACT_WORDS(hx,lx,x);
	EXTRACT_WORDS(hp,lp,p);
	sx = hx&0x80000000;
	hp &= 0x7fffffff;
	hx &= 0x7fffffff;

    /* purge off exception values */
	if((hp|lp)==0) return (x*p)/(x*p); 	/* p = 0 */
	if((hx>=0x7ff00000)||			/* x not finite */
	  ((hp>=0x7ff00000)&&			/* p is NaN */
	  (((hp-0x7ff00000)|lp)!=0)))
	    return (x*p)/(x*p);


	if (hp<=0x7fdfffff) x = __ieee754_fmod(x,p+p);	/* now x < 2p */
	if (((hx-hp)|(lx-lp))==0) return zero*x;
	x  = fabs(x);
	p  = fabs(p);
	if (hp<0x00200000) {
	    if(x+x>p) {
		x-=p;
		if(x+x>=p) x -= p;
	    }
	} else {
	    p_half = 0.5*p;
	    if(x>p_half) {
		x-=p;
		if(x>=p_half) x -= p;
	    }
	}
	GET_HIGH_WORD(hx,x);
	SET_HIGH_WORD(x,hx^sx);
	return x;
}

--------------B9EB53B4C32624550BB77E38--
