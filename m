Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BGB7212086
	for linux-mips-outgoing; Mon, 11 Feb 2002 08:11:07 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BGAv912082
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 08:10:57 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA23750;
	Mon, 11 Feb 2002 16:10:37 +0100 (MET)
Date: Mon, 11 Feb 2002 16:10:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Johannes Stezenbach <js@convergence.de>
cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
In-Reply-To: <20020211142708.GA2577@convergence.de>
Message-ID: <Pine.GSO.3.96.1020211155920.18917F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Feb 2002, Johannes Stezenbach wrote:

> The glibc-2.2.5/FAQ says:
>   1.20.   Which tools should I use for MIPS?
> 
>   {AJ} You should use the current development version of gcc 3.0 or newer from
>   CVS.  gcc 2.95.x does not work correctly on mips-linux.

 Is gcc 3.x already stable enough to be used by people not directly
involved in gcc development?  More specifically for MIPS/Linux and
i386/Linux, for both the kernel and the userland?  I'm told it is not.

> I'm not shure if this only applies to glibc, but the
> gcc-2.95.x I tried to build could not even compile a kernel
> because of:
>   #ifndef __linux__
>   #error Use a Linux compiler or give up.
>   #endif
> in linux/include/asm-mips/sgidefs.h. The gcc-3.0.3 I now use
> has a totally different set of predefines than gcc-2.95.x, and
> it seems to work.

 Gcc 2.95.x as distributed certainly doesn't work.  With a set of patches
it appears rock solid.  For MIPS/Linux I'm using it for over two years for
both the kernel and the userland.  The last time I found bug and needed to
apply a fix to gcc 2.95.3 for MIPS/Linux was in April 2001. 

 With gcc 2.95.3 if I spot a weird behaviour, I'm pretty confident it's a
bug in the kernel or in user code, and not the compiler generating bad
code.

> gcc-3.x does not use va-mips.h or sgidefs,h, but simply
> has the following in stdarg.h:
>   #define va_start(v,l)   __builtin_stdarg_start((v),l)
>   #define va_end          __builtin_va_end
>   #define va_arg          __builtin_va_arg
> etc.

 Thanks for the info.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
