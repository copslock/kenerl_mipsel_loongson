Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BFRit10878
	for linux-mips-outgoing; Mon, 11 Feb 2002 07:27:44 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BFRc910873
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 07:27:38 -0800
Received: from js by hell with local (Exim 3.33 #1 (Debian))
	id 16aHQC-0000gD-00; Mon, 11 Feb 2002 15:27:08 +0100
Date: Mon, 11 Feb 2002 15:27:08 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Florian Lohoff <flo@rfc822.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020211142708.GA2577@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Florian Lohoff <flo@rfc822.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
References: <20020209150155.GA853@paradigm.rfc822.org> <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl> <20020211135302.GB30314@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211135302.GB30314@paradigm.rfc822.org>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 11, 2002 at 02:53:02PM +0100, Florian Lohoff wrote:
> On Mon, Feb 11, 2002 at 01:51:47PM +0100, Maciej W. Rozycki wrote:
> > On Sat, 9 Feb 2002, Florian Lohoff wrote:
> > 
> > > i just stumbled when i tried to compile a program (bootloader) with
> > > gcc which uses varargs. I got the error that "sgidefs.h" was missing.
> > > sgidefs.h is contained in the glibc which gets included by va-mips.h
> > > from stdarg.h - I dont think this is correct as i should be able
> > > to compile programs without glibc.

The glibc-2.2.5/FAQ says:
  1.20.   Which tools should I use for MIPS?

  {AJ} You should use the current development version of gcc 3.0 or newer from
  CVS.  gcc 2.95.x does not work correctly on mips-linux.

I'm not shure if this only applies to glibc, but the
gcc-2.95.x I tried to build could not even compile a kernel
because of:
  #ifndef __linux__
  #error Use a Linux compiler or give up.
  #endif
in linux/include/asm-mips/sgidefs.h. The gcc-3.0.3 I now use
has a totally different set of predefines than gcc-2.95.x, and
it seems to work.


> >  Hmm, in 2.95.3 in va-mips.h I see: 
> > 
> > /* Get definitions for _MIPS_SIM_ABI64 etc.  */
> > #ifdef _MIPS_SIM
> > #include <sgidefs.h>
> > #endif
> > 
> > so you shouldn't need sgidefs.h normally.  Or did something get broken for
> > 3.x?

sgidefs.h comes from the kernel includes.

gcc-3.x does not use va-mips.h or sgidefs,h, but simply
has the following in stdarg.h:
  #define va_start(v,l)   __builtin_stdarg_start((v),l)
  #define va_end          __builtin_va_end
  #define va_arg          __builtin_va_arg
etc.


Regards,
Johannes
