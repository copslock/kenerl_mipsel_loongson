Received:  by oss.sgi.com id <S553875AbRBIUl2>;
	Fri, 9 Feb 2001 12:41:28 -0800
Received: from mail.kdt.de ([195.8.224.4]:32517 "EHLO mail.kdt.de")
	by oss.sgi.com with ESMTP id <S553871AbRBIUlK>;
	Fri, 9 Feb 2001 12:41:10 -0800
Received: from arthur.inka.de (arthur.kdt.de [195.8.250.5])
	by mail.kdt.de (8.11.1/8.11.0) with ESMTP id f19KeZ411455;
	Fri, 9 Feb 2001 21:40:39 +0100
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.11 #1)
	id 14RKCO-00055g-00; Fri, 09 Feb 2001 21:31:20 +0100
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 853991EA2A; Fri,  9 Feb 2001 21:31:18 +0100 (CET)
To:     Jun Sun <jsun@mvista.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [RESUME] fpu emulator
References: <20010208122030.A5408@paradigm.rfc822.org>
	<005d01c091c4$69940620$0deca8c0@Ulysses> <hor919tm4a.fsf@gee.suse.de>
	<3A8304C0.D3CFFEF7@mvista.com> <hoae7wjjvy.fsf@gee.suse.de>
	<3A844571.7B5F8F61@mvista.com>
From:   Andreas Jaeger <aj@suse.de>
Date:   09 Feb 2001 21:31:18 +0100
In-Reply-To: <3A844571.7B5F8F61@mvista.com> (Jun Sun's message of "Fri, 09 Feb 2001 11:30:57 -0800")
Message-ID: <u8r917r42x.fsf@gromit.rhein-neckar.de>
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
> > Jun Sun <jsun@mvista.com> writes:
> > 
> > > Andreas Jaeger wrote:
> > > >
> > >
> > > > > saves/restores the FP registers in setjmp/longjmp, the
> > > >
> > > > Any ideas how this can be done?
> > > >
> > > > > model of "simply sending SIGILL/SIGFPE" will result
> > > > > in *all* processes being terminated with extreme prejudice,
> > > > > starting with init!
> > > >
> > >
> > > There is a patch for glibc2.0.7, which I think was done by Jay Carlson.  It
> > > basically works for glibc2.0.6 as well.  See the one for glibc2.0.6 attached
> > > below.
> > >
> > > I think the patch is not "clean", in the sense that you only want to apply it
> > > if you want to configure with "--without-fp".  Otherwise the patch will break
> > > other configurations.
> > >
> > > Jun--- glibc-2.0.6/sysdeps/mips/__longjmp.c.orig-rpm  Sat Sep 11 00:01:44 1999
> > > +++ glibc-2.0.6/sysdeps/mips/__longjmp.c      Sat Sep 11 00:02:36 1999
> > > @@ -35,6 +35,7 @@
> > >       along the way.  */
> > >    register int val asm ("a1");
> > >
> > > +#ifdef __HAVE_FPU__
> > 
> > I looked through the whole of glibc and GCC and __HAVE_FPU__ is nowhere
> > defined for MIPS.  __HAVE_FPU__ is defined for m68k in GCC but that's
> > the only platform.
> >
> 
> You are right - it is not defined in glibc.  Instead it is defined in egcs. 
> For this particular build, I need to apply the mips patch for egcs 1.0.3a,
> which supplies __HAVE_FPU__.  You can find it somewhere on oss.sgi site. 
> There is an additional patch for softfloat which makes __HAVE_FPU__
> conditional.  See the attachement.
>  
> > Therefore I don't think the patch makes any sense at all,
> 
> Therefore, it does make sense. :-)

As long as that old patch hasn't found it's way into the official
sources, the patch doesn't make sense ;-).  I'm willing to discuss
these issues again after those or similar patches have been added to
the CVS archive of GCC - but without this, there's no way to get the
patches into glibc.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
