Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1JCM5Y14855
	for linux-mips-outgoing; Tue, 19 Feb 2002 04:22:05 -0800
Received: from dea.linux-mips.net (a1as02-p137.stg.tli.de [195.252.185.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1JCLi914852
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 04:21:47 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1JBLcc27213
	for linux-mips@oss.sgi.com; Tue, 19 Feb 2002 12:21:38 +0100
Received: from desire.geoffk.org (12-234-190-114.client.attbi.com [12.234.190.114])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1ILIp910604
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 13:18:51 -0800
Received: (from geoffk@localhost)
	by desire.geoffk.org (8.11.6/8.11.6) id g1IKIk802891;
	Mon, 18 Feb 2002 12:18:46 -0800
Date: Mon, 18 Feb 2002 12:18:46 -0800
From: Geoff Keating <geoffk@geoffk.org>
Message-Id: <200202182018.g1IKIk802891@desire.geoffk.org>
To: moshier@moshier.net
CC: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, libc-alpha@sources.redhat.com
In-reply-to: <Pine.LNX.4.44.0202181419220.25604-100000@moshier.net> (message
	from Stephen L Moshier on Mon, 18 Feb 2002 14:50:30 -0500 (EST))
Subject: Re: math broken on mips
Reply-to: Geoff Keating <geoffk@redhat.com>
References:  <Pine.LNX.4.44.0202181419220.25604-100000@moshier.net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Mailing-List: contact libc-alpha-help@sources.redhat.com; run by ezmlm
> List-Unsubscribe: <mailto:libc-alpha-unsubscribe-geoffk=redhat.com@sources.redhat.com>
> List-Subscribe: <mailto:libc-alpha-subscribe@sources.redhat.com>
> List-Archive: <http://sources.redhat.com/ml/libc-alpha/>
> List-Post: <mailto:libc-alpha@sources.redhat.com>
> List-Help: <mailto:libc-alpha-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
> Date: Mon, 18 Feb 2002 14:50:30 -0500 (EST)
> From: Stephen L Moshier <moshier@moshier.net>
> Reply-To: moshier@moshier.net
> cc: linux-mips@oss.sgi.com, <libc-alpha@sources.redhat.com>
> 
> 
> > pow(2,7) = 128.0 when rounding = TONEAREST or UPWARD
> >                = 64.1547.. when rounding = DOWNWARD or TOWARDZERO
> 
> The libm functions from IBM that were recently installed in glibc come
> with this remark in sysdeps/ieee754/dbl-64/MathLib.h:
> 
>   /* Assumption: Machine arithmetic operations are performed in       */
>   /* round nearest mode of IEEE 754 standard.                         */
> 
> These math functions use a doubled-precision Dekker arithmetic which is
> very sensitive to rounding rules and arithetic flaws.  Fixing the
> routines to give reasonable answers with other rounding modes would not
> be practical.
> 
> It is customary for a system math library to expect default environment
> conditions, and I do not think this design actually violates any
> standards. If you want to use non-default arithmetic settings and have
> them work portably on various systems, you will have to take defensive steps
> to protect your program from damage by the operating system and the system
> library.

... actually, C99 seems to imply that all supported rounding
precisions should work for the math library, although of course C99
doesn't promise very much about accuracy of the math library in the
first place.

Maybe we should add appropriate fesetround() calls to the math
library?  Usually most of each routine should be done with
round-to-nearest and then there's one or two operations at the end
that should be in the user's rounding mode, to get the
correctly-rounded value for the user's rounding mode.

-- 
- Geoffrey Keating <geoffk@geoffk.org> <geoffk@redhat.com>
