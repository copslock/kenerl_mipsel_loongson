Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB10b8l14301
	for linux-mips-outgoing; Fri, 30 Nov 2001 16:37:08 -0800
Received: from coplin19.mips.com ([62.243.233.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB10b0o14298
	for <linux-mips@oss.sgi.com>; Fri, 30 Nov 2001 16:37:00 -0800
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id fAUNai029302;
	Sat, 1 Dec 2001 00:36:44 +0100
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Sat, 1 Dec 2001 00:36:44 +0100 (CET)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: Mark Salter <msalter@redhat.com>
cc: <linux-mips@oss.sgi.com>
Subject: Re: math emulator patch
In-Reply-To: <200111300138.fAU1cOA31059@deneb.localdomain>
Message-ID: <Pine.LNX.4.33.0112010033480.29161-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Great. The same problem exists for sp_tlong.c and dp_tlong.c.

/Kjeld

On Thu, 29 Nov 2001, Mark Salter wrote:

> 
> The following patch fixes the emulation of cvt.w.s and cvt.w.d for
> values of -2147483648.
> 
> --Mark
> 
> 
> Index: sp_tint.c
> ===================================================================
> RCS file: /cvs/linux/arch/mips/math-emu/sp_tint.c,v
> retrieving revision 1.4
> diff -u -p -5 -c -r1.4 sp_tint.c
> cvs server: conflicting specifications of output style
> *** sp_tint.c	2001/10/09 23:56:19	1.4
> --- sp_tint.c	2001/11/29 19:14:58
> *************** int ieee754sp_tint(ieee754sp x)
> *** 48,57 ****
> --- 48,60 ----
>   	case IEEE754_CLASS_DNORM:
>   	case IEEE754_CLASS_NORM:
>   		break;
>   	}
>   	if (xe >= 31) {
> + 		/* look for valid corner case */
> + 		if (xe == 31 && xs && xm == SP_HIDDEN_BIT)
> + 			return -2147483648;
>   		/* Set invalid. We will only use overflow for floating
>   		   point overflow */
>   		SETCX(IEEE754_INVALID_OPERATION);
>   		return ieee754si_xcpt(ieee754si_indef(), "sp_tint", x);
>   	}
> Index: dp_tint.c
> ===================================================================
> RCS file: /cvs/linux/arch/mips/math-emu/dp_tint.c,v
> retrieving revision 1.4
> diff -u -p -5 -c -r1.4 dp_tint.c
> cvs server: conflicting specifications of output style
> *** dp_tint.c	2001/10/09 23:56:18	1.4
> --- dp_tint.c	2001/11/29 19:18:02
> *************** int ieee754dp_tint(ieee754dp x)
> *** 48,57 ****
> --- 48,60 ----
>   	case IEEE754_CLASS_DNORM:
>   	case IEEE754_CLASS_NORM:
>   		break;
>   	}
>   	if (xe >= 31) {
> + 		/* look for valid corner case */
> + 		if (xe == 31 && xs && xm == DP_HIDDEN_BIT)
> + 			return -2147483648;
>   		/* Set invalid. We will only use overflow for floating
>   		   point overflow */
>   		SETCX(IEEE754_INVALID_OPERATION);
>   		return ieee754si_xcpt(ieee754si_indef(), "dp_tint", x);
>   	}
> 

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
