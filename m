Received:  by oss.sgi.com id <S553884AbRBIVMS>;
	Fri, 9 Feb 2001 13:12:18 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:44272 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553878AbRBIVMG>;
	Fri, 9 Feb 2001 13:12:06 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f19L7k819484;
	Fri, 9 Feb 2001 13:07:46 -0800
Message-ID: <3A845C9E.C006CC39@mvista.com>
Date:   Fri, 09 Feb 2001 13:09:50 -0800
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
		<3A844571.7B5F8F61@mvista.com> <u8r917r42x.fsf@gromit.rhein-neckar.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Andreas Jaeger wrote:
> 
> Jun Sun <jsun@mvista.com> writes:
> 
> > Andreas Jaeger wrote:
> > >
> > > Jun Sun <jsun@mvista.com> writes:
> > >
> > > > Andreas Jaeger wrote:
> > > > >
> > > >
> > > > > > saves/restores the FP registers in setjmp/longjmp, the
> > > > >
> > > > > Any ideas how this can be done?
> > > > >
> > > > > > model of "simply sending SIGILL/SIGFPE" will result
> > > > > > in *all* processes being terminated with extreme prejudice,
> > > > > > starting with init!
> > > > >
> > > >
> > > > There is a patch for glibc2.0.7, which I think was done by Jay Carlson.  It
> > > > basically works for glibc2.0.6 as well.  See the one for glibc2.0.6 attached
> > > > below.
> > > >
> > > > I think the patch is not "clean", in the sense that you only want to apply it
> > > > if you want to configure with "--without-fp".  Otherwise the patch will break
> > > > other configurations.
> > > >
> > > > Jun--- glibc-2.0.6/sysdeps/mips/__longjmp.c.orig-rpm  Sat Sep 11 00:01:44 1999
> > > > +++ glibc-2.0.6/sysdeps/mips/__longjmp.c      Sat Sep 11 00:02:36 1999
> > > > @@ -35,6 +35,7 @@
> > > >       along the way.  */
> > > >    register int val asm ("a1");
> > > >
> > > > +#ifdef __HAVE_FPU__
> > >
> > > I looked through the whole of glibc and GCC and __HAVE_FPU__ is nowhere
> > > defined for MIPS.  __HAVE_FPU__ is defined for m68k in GCC but that's
> > > the only platform.
> > >
> >
> > You are right - it is not defined in glibc.  Instead it is defined in egcs.
> > For this particular build, I need to apply the mips patch for egcs 1.0.3a,
> > which supplies __HAVE_FPU__.  You can find it somewhere on oss.sgi site.
> > There is an additional patch for softfloat which makes __HAVE_FPU__
> > conditional.  See the attachement.
> >
> > > Therefore I don't think the patch makes any sense at all,
> >
> > Therefore, it does make sense. :-)
> 
> As long as that old patch hasn't found it's way into the official
> sources, the patch doesn't make sense ;-).  I'm willing to discuss
> these issues again after those or similar patches have been added to
> the CVS archive of GCC - but without this, there's no way to get the
> patches into glibc.
> 

Well, like I said earlier.  This is not a clean patch - it cannot be checked
in because it will break other configurations, AFAIK.  (OK, I probably should
have called it *hack* from the beginning :-0)

It would be nice to have some clean solutions...

Jun
