Received:  by oss.sgi.com id <S553688AbRBIJRe>;
	Fri, 9 Feb 2001 01:17:34 -0800
Received: from ns.suse.de ([213.95.15.193]:23302 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S553645AbRBIJRL>;
	Fri, 9 Feb 2001 01:17:11 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 53C541E212; Fri,  9 Feb 2001 10:17:10 +0100 (MET)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
To:     Jun Sun <jsun@mvista.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [RESUME] fpu emulator
References: <20010208122030.A5408@paradigm.rfc822.org>
	<005d01c091c4$69940620$0deca8c0@Ulysses> <hor919tm4a.fsf@gee.suse.de>
	<3A8304C0.D3CFFEF7@mvista.com>
From:   Andreas Jaeger <aj@suse.de>
Date:   09 Feb 2001 10:17:05 +0100
In-Reply-To: <3A8304C0.D3CFFEF7@mvista.com> (Jun Sun's message of "Thu, 08 Feb 2001 12:42:40 -0800")
Message-ID: <hoae7wjjvy.fsf@gee.suse.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Jun Sun <jsun@mvista.com> writes:

> Andreas Jaeger wrote:
> > 
>  
> > > saves/restores the FP registers in setjmp/longjmp, the
> > 
> > Any ideas how this can be done?
> > 
> > > model of "simply sending SIGILL/SIGFPE" will result
> > > in *all* processes being terminated with extreme prejudice,
> > > starting with init!
> > 
> 
> There is a patch for glibc2.0.7, which I think was done by Jay Carlson.  It
> basically works for glibc2.0.6 as well.  See the one for glibc2.0.6 attached
> below.
> 
> I think the patch is not "clean", in the sense that you only want to apply it
> if you want to configure with "--without-fp".  Otherwise the patch will break
> other configurations.
> 
> Jun--- glibc-2.0.6/sysdeps/mips/__longjmp.c.orig-rpm	Sat Sep 11 00:01:44 1999
> +++ glibc-2.0.6/sysdeps/mips/__longjmp.c	Sat Sep 11 00:02:36 1999
> @@ -35,6 +35,7 @@
>       along the way.  */
>    register int val asm ("a1");
>  
> +#ifdef __HAVE_FPU__

I looked through the whole of glibc and GCC and __HAVE_FPU__ is nowhere
defined for MIPS.  __HAVE_FPU__ is defined for m68k in GCC but that's
the only platform.

Therefore I don't think the patch makes any sense at all,
Andreas

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
