Received:  by oss.sgi.com id <S553849AbRBITcs>;
	Fri, 9 Feb 2001 11:32:48 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:42491 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553832AbRBITcj>;
	Fri, 9 Feb 2001 11:32:39 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f19JSr813936;
	Fri, 9 Feb 2001 11:28:53 -0800
Message-ID: <3A844571.7B5F8F61@mvista.com>
Date:   Fri, 09 Feb 2001 11:30:57 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Andreas Jaeger <aj@suse.de>
CC:     "Kevin D. Kissell" <kevink@mips.com>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [RESUME] fpu emulator
References: <20010208122030.A5408@paradigm.rfc822.org>
		<005d01c091c4$69940620$0deca8c0@Ulysses> <hor919tm4a.fsf@gee.suse.de>
		<3A8304C0.D3CFFEF7@mvista.com> <hoae7wjjvy.fsf@gee.suse.de>
Content-Type: multipart/mixed;
 boundary="------------38F51F38B68967D495D856BE"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------38F51F38B68967D495D856BE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andreas Jaeger wrote:
> 
> Jun Sun <jsun@mvista.com> writes:
> 
> > Andreas Jaeger wrote:
> > >
> >
> > > > saves/restores the FP registers in setjmp/longjmp, the
> > >
> > > Any ideas how this can be done?
> > >
> > > > model of "simply sending SIGILL/SIGFPE" will result
> > > > in *all* processes being terminated with extreme prejudice,
> > > > starting with init!
> > >
> >
> > There is a patch for glibc2.0.7, which I think was done by Jay Carlson.  It
> > basically works for glibc2.0.6 as well.  See the one for glibc2.0.6 attached
> > below.
> >
> > I think the patch is not "clean", in the sense that you only want to apply it
> > if you want to configure with "--without-fp".  Otherwise the patch will break
> > other configurations.
> >
> > Jun--- glibc-2.0.6/sysdeps/mips/__longjmp.c.orig-rpm  Sat Sep 11 00:01:44 1999
> > +++ glibc-2.0.6/sysdeps/mips/__longjmp.c      Sat Sep 11 00:02:36 1999
> > @@ -35,6 +35,7 @@
> >       along the way.  */
> >    register int val asm ("a1");
> >
> > +#ifdef __HAVE_FPU__
> 
> I looked through the whole of glibc and GCC and __HAVE_FPU__ is nowhere
> defined for MIPS.  __HAVE_FPU__ is defined for m68k in GCC but that's
> the only platform.
>

You are right - it is not defined in glibc.  Instead it is defined in egcs. 
For this particular build, I need to apply the mips patch for egcs 1.0.3a,
which supplies __HAVE_FPU__.  You can find it somewhere on oss.sgi site. 
There is an additional patch for softfloat which makes __HAVE_FPU__
conditional.  See the attachement.
 
> Therefore I don't think the patch makes any sense at all,

Therefore, it does make sense. :-)

Jun
--------------38F51F38B68967D495D856BE
Content-Type: text/plain; charset=us-ascii;
 name="egcs-1.0.3a-mips-softfloat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="egcs-1.0.3a-mips-softfloat.patch"

--- egcs-1.0.3a/gcc/config/mips/t-linux.orig	Mon Sep  6 21:38:16 1999
+++ egcs-1.0.3a/gcc/config/mips/t-linux	Wed Sep  8 08:43:58 1999
@@ -9,8 +9,28 @@
 LIBGCC1 =
 CROSS_LIBGCC1 =
 
-MULTILIB_OPTIONS= EL/EB
-MULTILIB_DIRNAMES= el eb
+# These are really part of libgcc1, but this will cause them to be
+# built correctly, so... [taken from t-sparclite]
+LIB2FUNCS_EXTRA = fp-bit.c dp-bit.c
+
+dp-bit.c: $(srcdir)/config/fp-bit.c
+	echo '#ifdef __MIPSEL__' > dp-bit.c
+	echo '#define FLOAT_BIT_ORDER_MISMATCH' >> dp-bit.c
+	echo '#endif' >> dp-bit.c
+	echo '#define US_SOFTWARE_GOFAST' >> dp-bit.c
+	cat $(srcdir)/config/fp-bit.c >> dp-bit.c
+
+fp-bit.c: $(srcdir)/config/fp-bit.c
+	echo '#define FLOAT' > fp-bit.c
+	echo '#ifdef __MIPSEL__' >> fp-bit.c
+	echo '#define FLOAT_BIT_ORDER_MISMATCH' >> fp-bit.c
+	echo '#endif' >> fp-bit.c
+	echo '#define US_SOFTWARE_GOFAST' >> fp-bit.c
+	cat $(srcdir)/config/fp-bit.c >> fp-bit.c
+
+
+MULTILIB_OPTIONS= EL/EB msoft-float
+MULTILIB_DIRNAMES= el eb soft-float
 MULTILIB_MATCHES=
 MULTILIB_EXCEPTIONS=
 
--- egcs-1.0.3a/gcc/config/mips/linux.h.orig	Mon Sep  6 21:38:16 1999
+++ egcs-1.0.3a/gcc/config/mips/linux.h	Wed Sep  8 08:43:40 1999
@@ -82,7 +82,7 @@
 %{!mabi*: -U__mips64} \
 %{fno-PIC:-U__PIC__ -U__pic__} %{fno-pic:-U__PIC__ -U__pic__} \
 %{fPIC:-D__PIC__ -D__pic__} %{fpic:-D__PIC__ -D__pic__} \
-%{-D__HAVE_FPU__ } \
+%{!msoft-float: -D__HAVE_FPU__ } \
 %{posix:-D_POSIX_SOURCE} \
 %{pthread:-D_REENTRANT}"
 
@@ -756,3 +756,7 @@
 
 #undef	MAX_WCHAR_TYPE_SIZE
 #define MAX_WCHAR_TYPE_SIZE	MAX_LONG_TYPE_SIZE
+
+/* US Software GOFAST library support.  */
+#include "gofast.h"
+#define INIT_TARGET_OPTABS INIT_GOFAST_OPTABS

--------------38F51F38B68967D495D856BE--
