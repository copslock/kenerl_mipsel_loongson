Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PEPBnC022289
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 07:25:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PEPBLn022288
	for linux-mips-outgoing; Tue, 25 Jun 2002 07:25:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PEP1nC022283;
	Tue, 25 Jun 2002 07:25:02 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17MrIc-0000Lp-00; Tue, 25 Jun 2002 16:28:06 +0200
Date: Tue, 25 Jun 2002 16:28:06 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com, ltp-list@lists.sourceforge.net
Subject: Re: LTP testing
Message-ID: <20020625142806.GA1338@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
	ltp-list@lists.sourceforge.net
References: <3D186E76.63B33B0E@mips.com> <Pine.GSO.3.96.1020625154306.29623G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.3.96.1020625154306.29623G-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 25, 2002 at 03:53:25PM +0200, Maciej W. Rozycki wrote:
> On Tue, 25 Jun 2002, Carsten Langgaard wrote:
> 
> > The next LTP failure line is:
> > pipe05      1  BROK  :  Unexpected signal 11 received.
> > 
> > For this one I haven't got a fix, because the failure is due to the way
> > the pipe syscall is implemented for MIPS (so we need a fix in both the
> > kernel and glibc).
> > 
> > The glibc code look like this
> > SYSCALL__ (pipe, 1)
> >         /* Plop in the two descriptors.  */
> >         sw v0, 0(a0)
> >         sw v1, 4(a0)
> > 
> >         /* Go out with a clean status.  */
> >         move v0, zero
> >         j ra
> >         .end __pipe
> > 
> > The problem is that the code is called with $a0 = 0. So the 'sw v0,
> > 0(a0)' after the syscall generates a segmentation fault.
> 
>  The test is broken and it's what should be fixed, instead -- several
> Linux platforms do it this way, e.g. Alpha and IA-64.  A SIGSEGV is a
> valid response for an invalid address.  Remember you test pipe(3) and not
> pipe(2). 

The question is what API spec is relevant for Linux. My pipe(2) man page
says (there is no pipe(3) man page):

  int pipe(int filedes[2]);
  ...
  ERRORS
    ...
    EFAULT filedes is not valid.

whereas The Single UNIX ® Specification, Version 2
(http://www.opengroup.org/onlinepubs/007908799/xsh/pipe.html)
implies the SIGSEGV is OK.

Maybe the LTP folks can shed a light on this.


Regards,
Johannes
