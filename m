Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KB7ux08979
	for linux-mips-outgoing; Wed, 20 Feb 2002 03:07:56 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KB7l908974
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 03:07:47 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g1KA7e414594;
	Wed, 20 Feb 2002 10:07:41 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15475.30060.604015.257576@gladsmuir.algor.co.uk>
Date: Wed, 20 Feb 2002 10:07:40 +0000
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: nigel@algor.co.uk, Hartvig Ekner <hartvige@mips.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: Re: math broken on mips
In-Reply-To: <200202200149.g1K1nT900770@oss.sgi.com>
References: <200202200149.g1K1nT900770@oss.sgi.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Zhang,

>    a quick example:
>  main()
> {
>    float t,zero=0.0;
>    t = 0.0/0.0;
>    printf("t=%08lx\n",*(unsigned long*)&t); (0x7fc00000)
>    t = zero/zero;
>    printf("t=%08lx\n",*(unsigned long*)&t); (0x7fbfffff)
> }
> 
> you should see different output,because the first one is optimized
> by gcc to a QNaN,but it's signalling for MIPS.

On my RedHat 7.1 x86 machine you get something of the same kind.  The
constant expression ("0.0/0.0") is always computed at compile time,
but the "zero/zero" is only resolved as a constant once you turn on
the optimiser.

So I see two different values printed without optimisation, but the
same value twice with -O2.

(Note that the 0.0/0.0 will be computed as a double, while zero/zero
will be computed as a float - but I don't think that makes any
difference in this case).

A floating point purist would say that the compiler should never try
to propagate floating point constants where the calculation might
produce any exception or exceptional result.

That's standards-correct, but unacceptable in practice.  If I write

  float pi = 3.1415926535897932384626433832795029;

the decimal->binary conversion will be inexact and might produce an
exception (if that flag is set: it almost never is, but the compiler
doesn't know that).  But I'll be annoyed if my compiler doesn't
generate a binary floating point value for 'pi' at compile time.

Once you open this door and allow the compiler to work on some
floating point constants, life gets tougher.  It might be a good rule
that if an expression produces an exceptional value (NaN, infinity),
you leave it to run-time... but it may mean some ugly back-tracking.

In this case gcc for x86 (and MIPS) has had no inhibitions: it's just
seen a constant expression and reduced it.  With no way to predict the
FP mode settings which will be in effect it has no way of knowing what
kind of exceptional result to produce in this case.  

The compiler is now kind of outside the specs: but it's still better
style to produce a signalling NaN (anyone who wanted their NaNs quiet
probably has exceptions turned off so won't know the difference;
anyone who didn't want their NaNs quiet should probably get an
exception).  But frankly, it's not important.

In expecting floating point maths to "just work" in corner cases,
you're expecting too much.  If you want to be appropriately
frightened, here's a paper I came across fairly recently - David
Goldberg's "What Every Computer Scientist should Know about Floating
Point":

  http://cch.loria.fr/documentation/IEEE754/ACM/goldberg.pdf

--
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
