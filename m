Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f919dkG12818
	for linux-mips-outgoing; Mon, 1 Oct 2001 02:39:46 -0700
Received: from coplin19.mips.com (host-3.mips.com [206.31.31.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f919dXD12811
	for <linux-mips@oss.sgi.com>; Mon, 1 Oct 2001 02:39:33 -0700
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id f919cGr16879;
	Mon, 1 Oct 2001 11:38:16 +0200
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Mon, 1 Oct 2001 11:38:16 +0200 (CEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: "H . J . Lu" <hjl@lucon.org>
cc: GNU C Library <libc-alpha@sourceware.cygnus.com>,
   linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Update sysdeps/mips/fpu/libm-test-ulps
In-Reply-To: <20010914111751.A17316@lucon.org>
Message-ID: <Pine.LNX.4.30.0110011106360.16270-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I discovered a problem in glibc-2.2.4-11.2.src.rpm concerning QNaN and
SNaN (quiet not-a-number and signalling not-a-number). It seems that
NaN's are always interpreted the Intel-way.

In glibc-2.2.4/soft-fp/quad.h it says:

#define _FP_QNANBIT_Q           \
        ((_FP_W_TYPE)1 << (_FP_FRACBITS_Q-2) % _FP_W_TYPE_SIZE)

But this is not correct on MIPS processors, where SNaNs has the bit set
and QNaNs has the bit cleared.  Changing the definition above to 0 doesn't
seem to solve the problem (I probably haven't found the root of the
problem).

The following piece of code gives the wrong result on a MIPS processor:

--------------------  cut here --------------
#include <math.h>

typedef union {
    long long ll;
    double d;
} t_number;

int main()
{
    t_number x, z;

    x.ll = 0x7ff7ffffffffffff; /* QNaN */
    z.d = sqrt(x.d);
    printf("%e %016llx\n", z.d, z.ll);
}
--------------------  cut here --------------


The result is a signalling NaN:

nan 7ff8000000000000

(I expected 0x7ff7ffffffffffff)


/Kjeld


On Fri, 14 Sep 2001, H . J . Lu wrote:

> Here is a patch for sysdeps/mips/fpu/libm-test-ulps. BTW, I got many
> math failures on Linux/mipsel. Has anyone else seen them?
>
>
> H.J.
> ----
> 2001-09-14  H.J. Lu  <hjl@gnu.org>
>
> 	* sysdeps/mips/fpu/libm-test-ulps: Updated.
>
> --- sysdeps/mips/fpu/libm-test-ulps.mips	Fri Apr 27 21:25:17 2001
> +++ sysdeps/mips/fpu/libm-test-ulps	Fri Sep 14 11:01:52 2001
> @@ -7,7 +7,7 @@ ifloat: 2
>  Test "asin (0.5) == pi/6":
>  float: 2
>  ifloat: 2
> -Test "asin (0.7) == 0.7753974966107530637":
> +Test "asin (0.7) == 0.77539749661075306374035335271498708":
>  double: 1
>  float: 2
>  idouble: 1
> @@ -175,12 +175,12 @@ idouble: 1
>  Test "Imaginary part of: cexp (-2.0 - 3.0 i) == -0.13398091492954261346140525546115575 - 0.019098516261135196432576240858800925 i":
>  float: 1
>  ifloat: 1
> -Test "Real part of: cexp (0.7 + 1.2 i) == 0.7296989091503236012 + 1.8768962328348102821 i":
> +Test "Real part of: cexp (0.7 + 1.2 i) == 0.72969890915032360123451688642930727 + 1.8768962328348102821139467908203072 i":
>  double: 1
>  float: 1
>  idouble: 1
>  ifloat: 1
> -Test "Imaginary part of: cexp (0.7 + 1.2 i) == 0.7296989091503236012 + 1.8768962328348102821 i":
> +Test "Imaginary part of: cexp (0.7 + 1.2 i) == 0.72969890915032360123451688642930727 + 1.8768962328348102821139467908203072 i":
>  float: 1
>  ifloat: 1
>
> @@ -249,7 +249,7 @@ float: 1
>  ifloat: 1
>
>  # cos
> -Test "cos (0.7) == 0.7648421872844884262":
> +Test "cos (0.7) == 0.76484218728448842625585999019186495":
>  double: 1
>  float: 1
>  idouble: 1
> @@ -374,7 +374,7 @@ double: 2
>  float: 1
>  idouble: 2
>  ifloat: 1
> -Test "exp10 (0.7) == 5.0118723362727228500":
> +Test "exp10 (0.7) == 5.0118723362727228500155418688494574":
>  float: 1
>  ifloat: 1
>  Test "exp10 (3) == 1000":
> @@ -451,6 +451,21 @@ ifloat: 2
>  Test "j0 (8.0) == 0.17165080713755390609":
>  float: 1
>  ifloat: 1
> +Test "j0 (4.0) == -3.9714980986384737228659076845169804197562E-1":
> +double: 1
> +float:  1
> +idouble: 1
> +ifloat:  1
> +ildouble: 1
> +ldouble: 1
> +Test "j0 (-4.0) == -3.9714980986384737228659076845169804197562E-1":
> +double: 1
> +float:  1
> +idouble: 1
> +ifloat:  1
> +ildouble: 1
> +ldouble: 1
> +
>
>  # j1
>  Test "j1 (10.0) == 0.043472746168861436670":
> @@ -563,7 +578,7 @@ idouble: 1
>  ifloat: 1
>
>  # sincos
> -Test "sincos (0.7, &sin_res, &cos_res) puts 0.76484218728448842626 in cos_res":
> +Test "sincos (0.7, &sin_res, &cos_res) puts 0.76484218728448842625585999019186495 in cos_res":
>  double: 1
>  float: 1
>  idouble: 1
> @@ -573,7 +588,7 @@ double: 1
>  float: 0.5
>  idouble: 1
>  ifloat: 0.5
> -Test "sincos (M_PI_6l*2.0, &sin_res, &cos_res) puts 0.866025403784438646764 in sin_res":
> +Test "sincos (M_PI_6l*2.0, &sin_res, &cos_res) puts 0.86602540378443864676372317075293616 in sin_res":
>  double: 1
>  float: 1
>  idouble: 1
> @@ -583,7 +598,7 @@ double: 0.2758
>  float: 0.3667
>  idouble: 0.2758
>  ifloat: 0.3667
> -Test "sincos (pi/6, &sin_res, &cos_res) puts 0.866025403784438646764 in cos_res":
> +Test "sincos (pi/6, &sin_res, &cos_res) puts 0.86602540378443864676372317075293616 in cos_res":
>  float: 1
>  ifloat: 1
>
> @@ -605,6 +620,13 @@ double: 1
>  float: 1
>  idouble: 1
>  ifloat: 1
> +Test "tanh (-0.7) == -0.60436777711716349631":
> +double: 1
> +float: 1
> +idouble: 1
> +ifloat: 1
> +ildouble:  1
> +ldouble:  1
>
>  # tgamma
>  Test "tgamma (-0.5) == -2 sqrt (pi)":
>

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
