Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PHHenC026146
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 10:17:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PHHeFg026145
	for linux-mips-outgoing; Tue, 25 Jun 2002 10:17:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.101])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PHHPnE026140
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 10:17:28 -0700
Received: from northrelay02.pok.ibm.com (northrelay02.pok.ibm.com [9.56.224.150])
	by e1.ny.us.ibm.com (8.12.2/8.12.2) with ESMTP id g5PHJJg5117856;
	Tue, 25 Jun 2002 13:19:19 -0400
Received: from d01ml076.pok.ibm.com (d01ml076.pok.ibm.com [9.117.250.6])
	by northrelay02.pok.ibm.com (8.11.1m3/NCO/VER6.1) with ESMTP id g5PHJFU124426;
	Tue, 25 Jun 2002 13:19:16 -0400
Subject: Re: [LTP] Re: LTP testing
To: Johannes Stezenbach <js@convergence.de>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com,
   ltp-list@lists.sourceforge.net, ltp-list-admin@lists.sourceforge.net,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Ralf Baechle <ralf@oss.sgi.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDCED143B.2CF490DC-ON85256BE3.005EDCBA@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Tue, 25 Jun 2002 12:19:10 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.10 |March 28, 2002) at
 06/25/2002 01:19:17 PM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g5PHHSnC026142
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


We actually try to stick to the Single Unix Specification whenever
possible.  I agree that the test should handle the SIGSEGV call.  We
actually have had other tests with the same scenario and have fixed them.
These tests were ported from OS's with strict guidelines on what to expect
that matched the manpages....this is obviously not the case with Linux.
We'll take a look at it and hopefully have a fixed version by the July
release...if not a patch will be supplied on the LTP mailing list
<ltp-list@lists.sf.net>

- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 638-9295
http://ltp.sourceforge.net


                                                                                                                             
                      Johannes Stezenbach                                                                                    
                      <js@convergence.de>              To:       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>                   
                      Sent by:                         cc:       Carsten Langgaard <carstenl@mips.com>, Ralf Baechle         
                      ltp-list-admin@lists.sour         <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,                          
                      ceforge.net                       ltp-list@lists.sourceforge.net                                       
                                                       Subject:  [LTP] Re: LTP testing                                       
                                                                                                                             
                      06/25/2002 09:28 AM                                                                                    
                                                                                                                             
                                                                                                                             



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


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
